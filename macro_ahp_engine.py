"""
MACRO AHP ENGINE
Vendor strategic analysis using AHP
Uses Gemini (not Claude!) for narrative generation
"""

import google.generativeai as genai
import numpy as np
import os
from typing import Dict, List, Tuple, Optional
from models import (
    VendorProfile, StrategicAlternative, StrategicCriteria,
    RankedAlternative, BOCRAnalysis
)

# Configure Gemini
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

class ORBITMacroAgent:
    """
    Strategic AHP agent for vendors
    Analyzes aggregated user behavior → recommends vendor strategies
    """
    
    def __init__(self):
        self.model = genai.GenerativeModel('gemini-2.5-flash')
    
    def run_strategic_analysis(
        self,
        vendor_profile: VendorProfile,
        strategic_query: Optional[str] = None
    ) -> Tuple[List[RankedAlternative], List[StrategicCriteria], Dict]:
        """
        Main analysis - same pattern as micro run_query
        """
        # Define alternatives
        alternatives = self._define_alternatives(vendor_profile.category_id)
        
        # Derive criteria from aggregated user behavior
        criteria = self._derive_criteria(vendor_profile)
        
        # Build AHP matrices
        comparison_matrices = {}
        priority_vectors = {}
        consistency_ratios = {}
        
        for criterion in criteria:
            matrix = self._build_comparison_matrix(alternatives, criterion, vendor_profile)
            priorities, cr = self._calculate_priorities(matrix)
            
            comparison_matrices[criterion.criteria_name] = matrix.tolist()
            priority_vectors[criterion.criteria_name] = priorities.tolist()
            consistency_ratios[criterion.criteria_name] = cr
        
        # Calculate final scores
        final_scores = np.zeros(len(alternatives))
        for criterion in criteria:
            priorities = np.array(priority_vectors[criterion.criteria_name])
            final_scores += criterion.weight * priorities
        
        # Rank
        ranked_indices = np.argsort(final_scores)[::-1]
        
        ranked_alternatives = []
        for i, idx in enumerate(ranked_indices):
            alt = alternatives[idx]
            breakdown = {
                c.criteria_name: priority_vectors[c.criteria_name][idx] * c.weight
                for c in criteria
            }
            
            ranked_alternatives.append(RankedAlternative(
                rank=i + 1,
                alternative=alt,
                ahp_score=final_scores[idx],
                criteria_scores={
                    c.criteria_name: priority_vectors[c.criteria_name][idx]
                    for c in criteria
                },
                score_breakdown=breakdown
            ))
        
        # AHP matrices dict
        ahp_matrices = {
            'alternatives': [alt.name for alt in alternatives],
            'criteria': [c.criteria_name for c in criteria],
            'criteria_weights': {c.criteria_name: c.weight for c in criteria},
            'comparison_matrices': comparison_matrices,
            'priority_vectors': priority_vectors,
            'consistency_ratios': consistency_ratios,
            'final_scores': final_scores.tolist(),
            'vendor_context': {
                'vendor_id': vendor_profile.vendor_id,
                'category_id': vendor_profile.category_id,
                'avg_criteria_weights': vendor_profile.avg_customer_criteria,
                'customer_segments': vendor_profile.customer_segments
            }
        }
        
        return ranked_alternatives, criteria, ahp_matrices
    
    def _define_alternatives(self, category_id: str) -> List[StrategicAlternative]:
        """Strategic options vendors can pursue"""
        alternatives = [
            StrategicAlternative(
                alternative_id="alt_expand_budget",
                name="expand_budget",
                description="Expand budget/low-price product line",
                category=category_id
            ),
            StrategicAlternative(
                alternative_id="alt_expand_premium",
                name="expand_premium",
                description="Invest in premium/high-end products",
                category=category_id
            ),
            StrategicAlternative(
                alternative_id="alt_optimize_midrange",
                name="optimize_midrange",
                description="Focus on mid-range value products",
                category=category_id
            ),
            StrategicAlternative(
                alternative_id="alt_improve_logistics",
                name="improve_logistics",
                description="Improve shipping speed and service",
                category=category_id
            ),
            StrategicAlternative(
                alternative_id="alt_increase_selection",
                name="increase_selection",
                description="Expand product variety/selection",
                category=category_id
            )
        ]
        return alternatives
    
    def _derive_criteria(self, vendor_profile: VendorProfile) -> List[StrategicCriteria]:
        """
        KEY FUNCTION: Convert aggregated user behavior → strategic criteria
        This is how micro layer influences macro layer!
        """
        criteria = []
        
        # Market demand - based on customer preferences
        demand_weight = sum([
            v for k, v in vendor_profile.avg_customer_criteria.items()
            if k in ['price', 'performance', 'quality']
        ]) / max(len(vendor_profile.avg_customer_criteria), 1)
        
        criteria.append(StrategicCriteria(
            criteria_name="market_demand",
            weight=demand_weight,
            confidence=0.8,
            description="Alignment with customer preferences"
        ))
        
        # Segment opportunity
        segment_diversity = len([v for v in vendor_profile.customer_segments.values() if v > 0.1])
        segment_weight = min(0.3, segment_diversity * 0.1)
        
        criteria.append(StrategicCriteria(
            criteria_name="segment_opportunity",
            weight=segment_weight,
            confidence=0.85,
            description="Size of target customer segment"
        ))
        
        # Competitive position
        competitive_weight = (vendor_profile.market_share * 0.5 + vendor_profile.avg_conversion_rate * 0.5)
        criteria.append(StrategicCriteria(
            criteria_name="competitive_position",
            weight=competitive_weight,
            confidence=0.9,
            description="Current market strength"
        ))
        
        # Operational feasibility
        criteria.append(StrategicCriteria(
            criteria_name="operational_feasibility",
            weight=0.2,
            confidence=0.7,
            description="Ease of implementation"
        ))
        
        # Financial impact
        criteria.append(StrategicCriteria(
            criteria_name="financial_impact",
            weight=0.25,
            confidence=0.75,
            description="Expected profitability"
        ))
        
        # Normalize
        total = sum(c.weight for c in criteria)
        for c in criteria:
            c.weight = c.weight / total
        
        return criteria
    
    def _build_comparison_matrix(
        self,
        alternatives: List[StrategicAlternative],
        criterion: StrategicCriteria,
        vendor_profile: VendorProfile
    ) -> np.ndarray:
        """Build pairwise comparison matrix"""
        n = len(alternatives)
        matrix = np.ones((n, n))
        
        avg_weights = vendor_profile.avg_customer_criteria
        segments = vendor_profile.customer_segments
        
        if criterion.criteria_name == "market_demand":
            price_sensitivity = avg_weights.get('price', 0)
            
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue
                    
                    alt_i = alternatives[i].name
                    alt_j = alternatives[j].name
                    
                    if alt_i == "expand_budget" and price_sensitivity > 0.3:
                        if alt_j == "expand_premium":
                            matrix[i][j] = 5
                        elif alt_j == "optimize_midrange":
                            matrix[i][j] = 3
                        else:
                            matrix[i][j] = 2
                    elif alt_i == "expand_premium" and price_sensitivity < 0.15:
                        if alt_j == "expand_budget":
                            matrix[i][j] = 5
                        elif alt_j == "optimize_midrange":
                            matrix[i][j] = 3
                        else:
                            matrix[i][j] = 2
                    elif matrix[j][i] != 1:
                        matrix[i][j] = 1 / matrix[j][i]
        
        elif criterion.criteria_name == "segment_opportunity":
            budget_segment = segments.get('budget_conscious', 0)
            premium_segment = segments.get('premium_buyer', 0) + segments.get('brand_loyal', 0)
            
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue
                    alt_i = alternatives[i].name
                    if alt_i == "expand_budget" and budget_segment > 0.5:
                        matrix[i][j] = 4
                    elif alt_i == "expand_premium" and premium_segment > 0.4:
                        matrix[i][j] = 4
                    elif matrix[j][i] != 1:
                        matrix[i][j] = 1 / matrix[j][i]
        
        elif criterion.criteria_name == "financial_impact":
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue
                    alt_i = alternatives[i].name
                    alt_j = alternatives[j].name
                    if alt_i == "expand_premium" and alt_j == "expand_budget":
                        matrix[i][j] = 5
                    elif alt_i == "optimize_midrange":
                        matrix[i][j] = 3
                    elif matrix[j][i] != 1:
                        matrix[i][j] = 1 / matrix[j][i]
        
        elif criterion.criteria_name == "operational_feasibility":
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue
                    alt_i = alternatives[i].name
                    if alt_i in ["improve_logistics", "increase_selection"]:
                        matrix[i][j] = 3
                    elif matrix[j][i] != 1:
                        matrix[i][j] = 1 / matrix[j][i]
        
        return matrix
    
    def _calculate_priorities(self, matrix: np.ndarray) -> Tuple[np.ndarray, float]:
        """Calculate priority vector using eigenvalue method"""
        eigenvalues, eigenvectors = np.linalg.eig(matrix)
        max_eigenvalue_idx = np.argmax(eigenvalues.real)
        principal_eigenvector = eigenvectors[:, max_eigenvalue_idx].real
        priorities = principal_eigenvector / principal_eigenvector.sum()
        
        # Consistency ratio
        n = len(matrix)
        lambda_max = eigenvalues[max_eigenvalue_idx].real
        ci = (lambda_max - n) / (n - 1)
        ri_values = [0, 0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49]
        ri = ri_values[n-1] if n <= 10 else 1.49
        cr = ci / ri if ri > 0 else 0
        
        return priorities, cr
    
    def generate_bocr(
        self,
        top_alternative: RankedAlternative,
        vendor_profile: VendorProfile
    ) -> BOCRAnalysis:
        """Generate BOCR analysis"""
        alt_name = top_alternative.alternative.name
        segments = vendor_profile.customer_segments
        
        if alt_name == "expand_budget":
            benefits = {
                "large_market": segments.get('budget_conscious', 0) * 100,
                "high_volume": 0.8,
                "brand_awareness": 0.6
            }
            opportunities = {
                "market_penetration": 0.85,
                "customer_acquisition": 0.9,
                "economies_of_scale": 0.7
            }
            costs = {
                "thin_margins": 0.9,
                "inventory_risk": 0.6,
                "brand_dilution": 0.4
            }
            risks = {
                "price_war": 0.8,
                "quality_perception": 0.5,
                "margin_pressure": 0.85
            }
        elif alt_name == "expand_premium":
            benefits = {
                "high_margins": 0.95,
                "brand_prestige": 0.8,
                "customer_loyalty": 0.75
            }
            opportunities = {
                "market_differentiation": 0.85,
                "premium_segment_growth": segments.get('premium_buyer', 0) * 100,
                "upsell_potential": 0.7
            }
            costs = {
                "product_development": 0.85,
                "marketing_investment": 0.8,
                "quality_assurance": 0.75
            }
            risks = {
                "limited_market": 1 - segments.get('premium_buyer', 0.2),
                "competition_intensity": 0.7,
                "economic_sensitivity": 0.6
            }
        else:
            benefits = {"benefit_1": 0.7}
            opportunities = {"opportunity_1": 0.7}
            costs = {"cost_1": 0.6}
            risks = {"risk_1": 0.6}
        
        return BOCRAnalysis(
            alternative_name=alt_name,
            benefits=benefits,
            opportunities=opportunities,
            costs=costs,
            risks=risks,
            total_benefits=sum(benefits.values()),
            total_opportunities=sum(opportunities.values()),
            total_costs=sum(costs.values()),
            total_risks=sum(risks.values()),
            net_score=sum(benefits.values()) + sum(opportunities.values()) - sum(costs.values()) - sum(risks.values())
        )
    
    def generate_strategic_narrative(
        self,
        vendor_profile: VendorProfile,
        ranked_alternatives: List[RankedAlternative],
        criteria: List[StrategicCriteria],
        bocr: BOCRAnalysis
    ) -> str:
        """Use Gemini to generate strategic narrative"""
        
        prompt = f"""You are a strategic business analyst for {vendor_profile.vendor_name}.

## VENDOR DATA
Market Share: {vendor_profile.market_share*100:.1f}%
Conversion Rate: {vendor_profile.avg_conversion_rate*100:.1f}%
Products: {vendor_profile.total_products}

## CUSTOMER BASE
"""
        for seg, pct in vendor_profile.customer_segments.items():
            prompt += f"- {seg}: {pct*100:.0f}%\n"
        
        prompt += "\n## TOP STRATEGY (AHP Analysis)\n"
        top = ranked_alternatives[0]
        prompt += f"{top.alternative.name} (Score: {top.ahp_score:.3f})\n\n"
        
        prompt += "## BOCR\n"
        prompt += f"Benefits: {bocr.total_benefits:.2f}\n"
        prompt += f"Opportunities: {bocr.total_opportunities:.2f}\n"
        prompt += f"Costs: {bocr.total_costs:.2f}\n"
        prompt += f"Risks: {bocr.total_risks:.2f}\n\n"
        
        prompt += """Provide:
1. Executive Summary (2-3 sentences)
2. Why This Strategy (reference the data)
3. Implementation Steps (3-5 actions)
4. Key Risks & Mitigation
5. Success Metrics

Be specific and actionable."""
        
        response = self.model.generate_content(prompt)
        return response.text