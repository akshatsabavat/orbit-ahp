import google.generativeai as genai
import json
import os
from typing import List, Dict, Optional
from pydantic import BaseModel, Field
from models import EnrichedPurchase, UserProfile, CriteriaWeight, Product, RankedProduct, VendorInventory, Vendor
from collections import Counter
import numpy as np

# fixed criteria sets per category - never change, only weights change
CATEGORY_CRITERIA = {
    "laptops": {
        "criteria": [
            "price",
            "performance",
            "battery_life",
            "portability",
            "display_quality",
            "brand_reputation"
        ],
        "cost_criteria": ["price"]  # these get inverted after scoring (lower is better)
    },
    "smartphones": {
        "criteria": [
            "price",
            "camera_quality",
            "battery_life",
            "performance",
            "storage_capacity",
            "brand_ecosystem"
        ],
        "cost_criteria": ["price"]
    },
    "coffee": {
        "criteria": [
            "price",
            "roast_quality",
            "origin_prestige",
            "organic_certification",
            "flavor_complexity"
        ],
        "cost_criteria": ["price"]
    },
    "sneakers": {
        "criteria": [
            "price",
            "comfort",
            "style",
            "durability",
            "brand_prestige"
        ],
        "cost_criteria": ["price"]
    }
}

DEFAULT_CRITERIA = {
    "criteria": ["price", "quality", "brand"],
    "cost_criteria": ["price"]
}

class ORBITAgent:
    """
    ORBIT Agent: Query-driven AHP product ranking
    
    Basic Agent Flow:
    1. Parse user query → extract requirements
    2. Fetch candidate products
    3. Analyze user history → derive base preferences
    4. Get fixed criteria set for category
    5. Weight criteria: blend user preferences + query requirements
    6. Score products on criteria (relative to each other)
    7. Calculate AHP scores and rank
    """
    
    def __init__(self, model_name="gemini-2.5-flash", temperature=0.7):
        self.model_name = model_name
        self.temperature = temperature
        genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
        self.model = genai.GenerativeModel(self.model_name)
    
    def parse_query(self, query: str) -> Dict:
        """
        Step 1: Parse natural language query
        Extract: category, constraints, use case, preferences
        """
        
        prompt = f"""
Parse this product search query and extract structured information.

Query: "{query}"

Extract:
1. category: laptops, smartphones, coffee, sneakers, or general
2. budget_max: maximum price mentioned (null if not specified)
3. budget_min: minimum price mentioned (null if not specified)
4. use_case: primary use case (gaming, work, casual, etc.)
5. must_have_features: list of required features
6. preferences: list of nice-to-have preferences
7. brand_preference: specific brand mentioned (null if not specified)

Return ONLY valid JSON:
{{
    "category": "laptops",
    "budget_max": 1500,
    "budget_min": null,
    "use_case": "gaming",
    "must_have_features": ["high performance", "good GPU"],
    "preferences": ["long battery life"],
    "brand_preference": null
}}
"""
        
        try:
            response = self.model.generate_content(prompt)
            parsed = json.loads(response.text.strip().replace('```json', '').replace('```', ''))
            return parsed
        except Exception as e:
            print(f"Query parsing failed: {e}")
            return {
                "category": "general",
                "budget_max": None,
                "use_case": "general",
                "must_have_features": [],
                "preferences": [],
                "brand_preference": None
            }
    
    def analyze_user_history(self, purchases: List[EnrichedPurchase], category: str) -> Dict:
        """
        Step 2: Analyze purchase history to understand user preferences
        Returns base preference profile
        """
        
        if not purchases:
            return {
                "price_sensitivity": 0.5,
                "brand_loyalty": {},
                "avg_price": 0,
                "spec_preferences": {}
            }
        
        prices = [p.purchase.total_paid for p in purchases]
        brands = [p.product.brand for p in purchases]
        specs = [p.product.specs for p in purchases]
        
        avg_price = sum(prices) / len(prices)
        price_variance = np.std(prices) if len(prices) > 1 else 0
        
        # price sensitivity, inversing this because --> low variance = consistent budget = high sensitivity, so more cheaper the better
        price_sensitivity = 1 - min(price_variance / avg_price, 1.0) if avg_price > 0 else 0.5
        
        brand_counts = Counter(brands)
        total = len(brands)
        brand_loyalty = {brand: count/total for brand, count in brand_counts.items()}
        
        # extract common spec patterns
        spec_preferences = {}
        if category == "laptops":
            rams = [s.get('ram_gb', 0) for s in specs if 'ram_gb' in s]
            if rams:
                spec_preferences['avg_ram'] = sum(rams) / len(rams)
        elif category == "smartphones":
            cameras = [s.get('camera_mp', 0) for s in specs if 'camera_mp' in s]
            if cameras:
                spec_preferences['avg_camera'] = sum(cameras) / len(cameras)
        
        return {
            "price_sensitivity": price_sensitivity,
            "brand_loyalty": brand_loyalty,
            "avg_price": avg_price,
            "spec_preferences": spec_preferences,
            "total_purchases": len(purchases)
        }
    
    def get_criteria_set(self, category: str) -> tuple[List[str], List[str]]:
        """
        Step 3: Get fixed criteria set for category
        No dynamic generation - returns standardized criteria
        Returns: (criteria_list, cost_criteria_list)
        """
        config = CATEGORY_CRITERIA.get(category, DEFAULT_CRITERIA)
        return config["criteria"], config["cost_criteria"]
    
    def calculate_criteria_weights(self, criteria: List[str], query_parsed: Dict, 
                                   user_profile: Dict) -> Dict[str, float]:
        """
        Step 4: Calculate criteria weights
        Blend: user history preferences + query requirements
        """
        
        prompt = f"""
Calculate AHP criteria weights that balance USER PREFERENCES and QUERY REQUIREMENTS.

CRITERIA: {criteria}

USER PROFILE:
- Price Sensitivity: {user_profile.get('price_sensitivity', 0.5):.2f} (higher = more price conscious)
- Avg Past Spend: ${user_profile.get('avg_price', 0):.2f}
- Brand Loyalty: {user_profile.get('brand_loyalty', {})}
- Purchase Count: {user_profile.get('total_purchases', 0)}

QUERY CONTEXT:
- Use Case: {query_parsed.get('use_case')}
- Budget Max: ${query_parsed.get('budget_max', 'not specified')}
- Must-Haves: {query_parsed.get('must_have_features', [])}
- Preferences: {query_parsed.get('preferences', [])}

WEIGHTING LOGIC:
1. If user is price sensitive (>0.7) → increase "price" weight
2. If query specifies use case (gaming/work) → increase relevant spec weights
3. If user has brand loyalty (>50% one brand) → increase "brand" weight
4. If query has must-haves → prioritize those criteria
5. Weights MUST sum to 1.0

Return ONLY valid JSON:
{{
    "weights": {{
        "price": 0.35,
        "performance": 0.30,
        "battery_life": 0.20,
        "brand_reputation": 0.15
    }},
    "reasoning": "User is price sensitive but query requires high performance..."
}}
"""
        
        try:
            response = self.model.generate_content(prompt)
            result = json.loads(response.text.strip().replace('```json', '').replace('```', ''))
            weights = result['weights']
            
            # normalize to ensure sum = 1
            total = sum(weights.values())
            normalized = {k: v/total for k, v in weights.items()}
            
            print(f"   💡 Reasoning: {result.get('reasoning', 'Weights calculated')}")
            return normalized
            
        except Exception as e:
            print(f"Weight calculation failed: {e}")
            # equal weights fallback
            return {c: 1.0/len(criteria) for c in criteria}
    
    def score_products_relative(self, products: List[Product], criteria: List[str],
                                query_parsed: Dict, user_profile: Dict, cost_criteria: List[str]) -> Dict[str, Dict[str, float]]:
        """
        Step 5: Score products on each criteria
        IMPORTANT: Scores are RELATIVE to other products in the set
        Cost criteria (like price) will be inverted after scoring
        """
        
        products_data = [
            {
                "product_id": p.product_id,
                "name": p.product_name,
                "brand": p.brand,
                "price": p.base_price,
                "specs": p.specs
            }
            for p in products
        ]
        
        prompt = f"""
Score products RELATIVE to each other on each criteria (0-1 scale).

CRITERIA: {criteria}

PRODUCTS:
{json.dumps(products_data, indent=2)}

USER CONTEXT:
- Avg Past Price: ${user_profile.get('avg_price', 0):.2f}
- Brand Preferences: {user_profile.get('brand_loyalty', {})}

QUERY CONTEXT:
- Budget Max: ${query_parsed.get('budget_max', 'none')}
- Use Case: {query_parsed.get('use_case')}

CRITICAL SCORING RULES:

FOR PRICE CRITERION ONLY:
- DO NOT consider user budget or preferences when scoring price
- Simply normalize based on the price range in this product set
- Formula: price_score = (product_price - min_price) / (max_price - min_price)
- HIGHER PRICE = HIGHER SCORE (most expensive product = 1.0, cheapest = 0.0)
- Example: If prices are [$500, $1000, $1500], scores are [0.0, 0.5, 1.0]
- The code will automatically invert this afterwards so cheaper products rank better
- Do NOT try to favor cheaper products - just do straight mathematical normalization

FOR ALL OTHER CRITERIA:
- Higher score = better performance on that criterion
- performance: Compare RAM, processor, GPU specs - better specs = higher score
- battery_life: More hours = higher score
- portability: Lighter weight = higher score
- display_quality: Better screen tech/resolution = higher score
- brand_reputation: Stronger brand or matches user preferences = higher score
- Normalize all scores 0-1 relative to the products in this set

Return ONLY valid JSON:
{{
    "scores": {{
        "prod_lap_001": {{"price": 0.93, "performance": 0.6, "battery_life": 0.7, "brand_reputation": 0.9}},
        "prod_lap_002": {{"price": 0.21, "performance": 0.9, "battery_life": 0.5, "brand_reputation": 0.3}}
    }},
    "reasoning": "Price scores are pure mathematical normalization. Product A at $1800 scored 0.93, Product B at $700 scored 0.21..."
}}
"""
        
        try:
            response = self.model.generate_content(prompt)
            result = json.loads(response.text.strip().replace('```json', '').replace('```', ''))
            scores = result['scores']
            
            # invert cost criteria (lower is better, so flip the score)
            for product_id, product_scores in scores.items():
                for cost_criterion in cost_criteria:
                    if cost_criterion in product_scores:
                        product_scores[cost_criterion] = 1.0 - product_scores[cost_criterion]
            
            print(f"   🎯 {result.get('reasoning', 'Products scored')}")
            print(f"   🔄 Inverted cost criteria: {cost_criteria}")
            return scores
        except Exception as e:
            print(f"Product scoring failed: {e}")
            # fallback: random scores
            return {p.product_id: {c: 0.5 for c in criteria} for p in products}
    
    def calculate_ahp_scores(self, product_scores: Dict[str, Dict[str, float]],
                            criteria_weights: Dict[str, float]) -> Dict[str, float]:
        """
        Step 6: Calculate final AHP scores
        Weighted sum: score = Σ(weight[criteria] × product_score[criteria])
        """
        
        final_scores = {}
        
        for product_id, scores in product_scores.items():
            ahp_score = sum(
                criteria_weights.get(criteria, 0) * score
                for criteria, score in scores.items()
            )
            final_scores[product_id] = ahp_score
        
        return final_scores
    
    def run_query(self, user_id: str, query: str, purchase_history: List[EnrichedPurchase],
                  candidate_products: List[Product]) -> tuple[List[RankedProduct], UserProfile, Dict]:
        """
        MAIN WORKFLOW: Query-driven AHP ranking
        
        Returns: (ranked_products, user_profile_used, ahp_matrices)
        """
        
        print(f"\n🤖 ORBIT Agent Processing Query")
        print(f"   User: {user_id}")
        print(f"   Query: '{query}'")
        print("="*60)
        
        # step 1: parse query
        print("\n📝 Step 1: Parsing query...")
        query_parsed = self.parse_query(query)
        print(f"   Category: {query_parsed.get('category')}")
        print(f"   Use Case: {query_parsed.get('use_case')}")
        print(f"   Budget: ${query_parsed.get('budget_max', 'no limit')}")
        
        # step 2: analyze user history
        print("\n👤 Step 2: Analyzing user purchase history...")
        user_profile = self.analyze_user_history(purchase_history, query_parsed.get('category', 'general'))
        print(f"   Total Purchases: {user_profile['total_purchases']}")
        print(f"   Price Sensitivity: {user_profile['price_sensitivity']:.2f}")
        print(f"   Avg Past Price: ${user_profile['avg_price']:.2f}")
        
        # PRE-FILTER: Remove products that violate hard constraints
        print("\n🔍 Step 2.5: Applying hard constraint filters...")
        original_count = len(candidate_products)
        
        # budget constraint
        if query_parsed.get('budget_max'):
            budget_max = query_parsed['budget_max']
            candidate_products = [p for p in candidate_products if p.base_price <= budget_max]
            print(f"   Budget filter (≤${budget_max}): {original_count} → {len(candidate_products)} products")
        
        if query_parsed.get('budget_min'):
            budget_min = query_parsed['budget_min']
            candidate_products = [p for p in candidate_products if p.base_price >= budget_min]
            print(f"   Budget min filter (≥${budget_min}): kept {len(candidate_products)} products")
        
        # brand constraint
        if query_parsed.get('brand_preference'):
            brand = query_parsed['brand_preference']
            candidate_products = [p for p in candidate_products if p.brand.lower() == brand.lower()]
            print(f"   Brand filter ({brand}): kept {len(candidate_products)} products")
        
        if len(candidate_products) == 0:
            print("   ⚠️  No products match constraints! Returning empty results.")
            return [], UserProfile(
                user_id=user_id,
                category_id=query_parsed.get('category', 'general'),
                criteria_weights=[],
                avg_purchase_price=user_profile['avg_price'],
                brand_preferences=user_profile['brand_loyalty'],
                total_purchases=user_profile['total_purchases']
            ), {}
        
        # step 3: get fixed criteria set
        print("\n🎯 Step 3: Getting fixed criteria set...")
        criteria, cost_criteria = self.get_criteria_set(query_parsed.get('category', 'general'))
        print(f"   Criteria: {criteria}")
        print(f"   Cost Criteria (will be inverted): {cost_criteria}")
        
        # step 4: calculate weights
        print("\n⚖️  Step 4: Calculating criteria weights...")
        criteria_weights = self.calculate_criteria_weights(criteria, query_parsed, user_profile)
        for c, w in criteria_weights.items():
            print(f"   {c}: {w:.3f}")
        
        # step 5: score products
        print("\n📊 Step 5: Scoring products...")
        product_scores = self.score_products_relative(candidate_products, criteria, 
                                                      query_parsed, user_profile, cost_criteria)
        
        # step 6: calculate AHP scores
        print("\n🏆 Step 6: Calculating final AHP scores...")
        ahp_scores = self.calculate_ahp_scores(product_scores, criteria_weights)
        
        # step 7: build ranked results
        ranked_products = []
        for product in candidate_products:
            if product.product_id in ahp_scores:
                ranked_products.append(RankedProduct(
                    product=product,
                    inventory=VendorInventory(
                        inventory_id="demo",
                        vendor_id="demo",
                        product_id=product.product_id,
                        vendor_price=product.base_price,
                        stock_quantity=10,
                        shipping_days=3,
                        shipping_cost=0,
                        is_available=True
                    ),
                    vendor=Vendor(
                        vendor_id="demo",
                        vendor_name="Demo Vendor",
                        vendor_rating=4.5,
                        avg_shipping_days=3,
                        return_policy_days=30
                    ),
                    ahp_score=ahp_scores[product.product_id],
                    criteria_scores=product_scores[product.product_id]
                ))
        
        # sort by score
        ranked_products.sort(key=lambda x: x.ahp_score, reverse=True)
        
        print(f"\n✅ Ranking complete! Top pick: {ranked_products[0].product.product_name}")
        print(f"   AHP Score: {ranked_products[0].ahp_score:.3f}")
        
        # build user profile for visualization
        user_profile_obj = UserProfile(
            user_id=user_id,
            category_id=query_parsed.get('category', 'general'),
            criteria_weights=[
                CriteriaWeight(criteria_name=c, weight=w, confidence=0.8)
                for c, w in criteria_weights.items()
            ],
            avg_purchase_price=user_profile['avg_price'],
            brand_preferences=user_profile['brand_loyalty'],
            total_purchases=user_profile['total_purchases']
        )
        
        # build AHP matrices for visualization
        ahp_matrices = {
            'criteria': criteria,
            'criteria_weights': criteria_weights,
            'product_scores': product_scores,
            'final_scores': ahp_scores,
            'query_context': query_parsed,
            'user_profile': user_profile
        }
        
        return ranked_products, user_profile_obj, ahp_matrices