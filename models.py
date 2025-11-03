from pydantic import BaseModel
from typing import Dict, List, Optional
from datetime import datetime

# basic user info
class User(BaseModel):
    user_id: str
    username: str
    email: str
    created_at: Optional[datetime] = None

# vendor details
class Vendor(BaseModel):
    vendor_id: str
    vendor_name: str
    vendor_rating: float
    avg_shipping_days: int
    return_policy_days: int

# product with specs as dict
class Product(BaseModel):
    product_id: str
    product_name: str
    category_id: str
    brand: str
    model: Optional[str] = None
    base_price: float
    specs: Dict  # json field from db
    description: Optional[str] = None
    
# vendor inventory - specific vendor selling specific product
class VendorInventory(BaseModel):
    inventory_id: str
    vendor_id: str
    product_id: str
    vendor_price: float
    stock_quantity: int
    shipping_days: int
    shipping_cost: float
    is_available: bool

# purchase history entry
class Purchase(BaseModel):
    purchase_id: str
    user_id: str
    inventory_id: str
    purchase_date: datetime
    quantity: int
    total_paid: float

# enriched purchase with product details (for analysis)
class EnrichedPurchase(BaseModel):
    purchase: Purchase
    product: Product
    vendor: Vendor
    inventory: VendorInventory

# criteria weight derived from user behavior
class CriteriaWeight(BaseModel):
    criteria_name: str
    weight: float  # 0-1, normalized
    confidence: float  # how confident we are in this weight

# user preference profile (output of analysis)
class UserProfile(BaseModel):
    user_id: str
    category_id: str
    criteria_weights: List[CriteriaWeight]
    avg_purchase_price: float
    brand_preferences: Dict[str, float]  # brand -> frequency
    total_purchases: int

# product score on a single criteria
class ProductScore(BaseModel):
    product_id: str
    criteria_name: str
    score: float  # 0-1, normalized
    
# final ranked product result
class RankedProduct(BaseModel):
    product: Product
    inventory: VendorInventory
    vendor: Vendor
    ahp_score: float  # final weighted score
    criteria_scores: Dict[str, float]  # breakdown by criteria

class StrategicAlternative(BaseModel):
    """Strategic option vendor can pursue"""
    alternative_id: str
    name: str
    description: str
    category: str

class StrategicCriteria(BaseModel):
    """Criteria for evaluating strategies"""
    criteria_name: str
    weight: float
    confidence: float
    description: str

class VendorProfile(BaseModel):
    """Aggregated vendor intelligence"""
    vendor_id: str
    vendor_name: str
    category_id: str
    market_share: float
    avg_conversion_rate: float
    total_products: int
    total_sales: int
    avg_customer_criteria: Dict[str, float]
    customer_segments: Dict[str, float]
    price_competitiveness_rank: Optional[int] = None
    selection_rank: Optional[int] = None

class RankedAlternative(BaseModel):
    """Strategic alternative with AHP score"""
    rank: int
    alternative: StrategicAlternative
    ahp_score: float
    criteria_scores: Dict[str, float]
    score_breakdown: Dict[str, float]

class BOCRAnalysis(BaseModel):
    """Benefits-Opportunities-Costs-Risks"""
    alternative_name: str
    benefits: Dict[str, float]
    opportunities: Dict[str, float]
    costs: Dict[str, float]
    risks: Dict[str, float]
    total_benefits: float
    total_opportunities: float
    total_costs: float
    total_risks: float
    net_score: float

class ProductAggregateInsight(BaseModel):
    """Aggregated product insights"""
    product_id: str
    product_name: str
    vendor_id: str
    category_id: str
    total_views: int
    total_purchases: int
    conversion_rate: float
    avg_criteria_weights: Dict[str, float]
    segment_breakdown: Dict[str, float]
    primary_segment: str
