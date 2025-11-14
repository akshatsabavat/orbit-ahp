-- ============================================
-- ORBIT MACRO LAYER - AGGREGATED INTELLIGENCE
-- Synthesized data for vendor strategy decisions
-- ============================================

-- USER CRITERIA PREFERENCES
-- Learned from each user's purchase behavior
CREATE TABLE user_criteria_preferences (
    preference_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    category_id VARCHAR(50) NOT NULL,
    
    -- Their typical criteria weights (JSONB for flexibility)
    criteria_weights JSONB NOT NULL,
    
    -- How confident are we? (based on purchase count)
    confidence_score DECIMAL(3,2),
    
    -- User segment classification
    user_segment VARCHAR(50),
    
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    UNIQUE(user_id, category_id)
);

-- PRODUCT AGGREGATE INSIGHTS
-- Computed from all users who interacted with this product
CREATE TABLE product_aggregate_insights (
    insight_id VARCHAR(50) PRIMARY KEY,
    product_id VARCHAR(50) NOT NULL,
    vendor_id VARCHAR(50) NOT NULL,
    category_id VARCHAR(50) NOT NULL,
    
    -- Average criteria weights from users who bought this
    avg_criteria_weights JSONB NOT NULL,
    
    -- Behavioral metrics
    total_views INT DEFAULT 0,
    total_purchases INT DEFAULT 0,
    conversion_rate DECIMAL(5,4),
    
    -- User segment breakdown (percentages)
    segment_breakdown JSONB,
    
    -- Dominant user segment
    primary_segment VARCHAR(50),
    
    last_computed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- VENDOR STRATEGIC INSIGHTS
-- High-level aggregates per vendor
CREATE TABLE vendor_strategic_insights (
    insight_id VARCHAR(50) PRIMARY KEY,
    vendor_id VARCHAR(50) NOT NULL,
    category_id VARCHAR(50) NOT NULL,
    
    -- Market position
    market_share DECIMAL(5,4),
    total_products INT,
    total_sales INT,
    avg_conversion_rate DECIMAL(5,4),
    
    -- Customer segments (percentages)
    customer_segments JSONB,
    
    -- Competitive position
    price_competitiveness_rank INT,
    selection_rank INT,
    
    -- Average criteria weights across ALL their customers
    avg_customer_criteria JSONB,
    
    last_computed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    UNIQUE(vendor_id, category_id)
);

-- ============================================
-- SYNTHETIC DATA: USER CRITERIA PREFERENCES
-- Based on 10 user personas
-- ============================================

-- LAPTOPS PREFERENCES
INSERT INTO user_criteria_preferences VALUES
-- budget_bob: Price-focused
('pref_lap_001', 'usr_001', 'cat_laptops', 
 '{"price": 0.40, "performance": 0.20, "battery_life": 0.15, "portability": 0.10, "display_quality": 0.08, "brand_reputation": 0.07}',
 0.90, 'budget_conscious', NOW()),

-- performance_paula: Specs-focused
('pref_lap_002', 'usr_002', 'cat_laptops',
 '{"price": 0.08, "performance": 0.45, "battery_life": 0.18, "portability": 0.10, "display_quality": 0.12, "brand_reputation": 0.07}',
 0.85, 'performance_focused', NOW()),

-- apple_andy: Brand-loyal
('pref_lap_003', 'usr_003', 'cat_laptops',
 '{"price": 0.10, "performance": 0.20, "battery_life": 0.20, "portability": 0.15, "display_quality": 0.15, "brand_reputation": 0.20}',
 0.95, 'brand_loyal', NOW()),

-- balanced_beth: Balanced
('pref_lap_004', 'usr_004', 'cat_laptops',
 '{"price": 0.20, "performance": 0.20, "battery_life": 0.20, "portability": 0.15, "display_quality": 0.15, "brand_reputation": 0.10}',
 0.80, 'balanced', NOW()),

-- vendor_loyal_larry: Price + convenience
('pref_lap_005', 'usr_005', 'cat_laptops',
 '{"price": 0.30, "performance": 0.25, "battery_life": 0.15, "portability": 0.12, "display_quality": 0.10, "brand_reputation": 0.08}',
 0.75, 'convenience_focused', NOW()),

-- gamer_grace: Performance + display
('pref_lap_006', 'usr_006', 'cat_laptops',
 '{"price": 0.05, "performance": 0.50, "battery_life": 0.10, "portability": 0.05, "display_quality": 0.25, "brand_reputation": 0.05}',
 0.88, 'performance_focused', NOW()),

-- coffee_connoisseur_carlos: Balanced tech user
('pref_lap_007', 'usr_007', 'cat_laptops',
 '{"price": 0.15, "performance": 0.25, "battery_life": 0.20, "portability": 0.15, "display_quality": 0.15, "brand_reputation": 0.10}',
 0.70, 'balanced', NOW()),

-- runner_rachel: Battery + portability
('pref_lap_008', 'usr_008', 'cat_laptops',
 '{"price": 0.25, "performance": 0.15, "battery_life": 0.30, "portability": 0.20, "display_quality": 0.05, "brand_reputation": 0.05}',
 0.72, 'mobile_focused', NOW()),

-- brand_hopper_henry: Price + performance balance
('pref_lap_009', 'usr_009', 'cat_laptops',
 '{"price": 0.28, "performance": 0.28, "battery_life": 0.16, "portability": 0.12, "display_quality": 0.10, "brand_reputation": 0.06}',
 0.78, 'value_seeker', NOW()),

-- premium_pete: Quality over price
('pref_lap_010', 'usr_010', 'cat_laptops',
 '{"price": 0.05, "performance": 0.30, "battery_life": 0.20, "portability": 0.15, "display_quality": 0.20, "brand_reputation": 0.10}',
 0.92, 'premium_buyer', NOW());

-- SMARTPHONES PREFERENCES
INSERT INTO user_criteria_preferences VALUES
('pref_phn_001', 'usr_001', 'cat_phones',
 '{"price": 0.45, "camera_quality": 0.15, "battery_life": 0.18, "performance": 0.12, "storage_capacity": 0.08, "brand_ecosystem": 0.02}',
 0.85, 'budget_conscious', NOW()),

('pref_phn_002', 'usr_002', 'cat_phones',
 '{"price": 0.08, "camera_quality": 0.30, "battery_life": 0.15, "performance": 0.30, "storage_capacity": 0.12, "brand_ecosystem": 0.05}',
 0.80, 'performance_focused', NOW()),

('pref_phn_003', 'usr_003', 'cat_phones',
 '{"price": 0.08, "camera_quality": 0.25, "battery_life": 0.20, "performance": 0.20, "storage_capacity": 0.12, "brand_ecosystem": 0.15}',
 0.95, 'brand_loyal', NOW());

-- COFFEE PREFERENCES
INSERT INTO user_criteria_preferences VALUES
('pref_cof_001', 'usr_001', 'cat_coffee',
 '{"price": 0.50, "roast_quality": 0.20, "origin_prestige": 0.10, "organic_certification": 0.10, "flavor_complexity": 0.10}',
 0.90, 'budget_conscious', NOW()),

('pref_cof_007', 'usr_007', 'cat_coffee',
 '{"price": 0.08, "roast_quality": 0.30, "origin_prestige": 0.30, "organic_certification": 0.20, "flavor_complexity": 0.12}',
 0.95, 'premium_buyer', NOW());

-- SNEAKERS PREFERENCES
INSERT INTO user_criteria_preferences VALUES
('pref_snk_001', 'usr_001', 'cat_sneakers',
 '{"price": 0.45, "comfort": 0.25, "style": 0.15, "durability": 0.10, "brand_prestige": 0.05}',
 0.88, 'budget_conscious', NOW()),

('pref_snk_008', 'usr_008', 'cat_sneakers',
 '{"price": 0.15, "comfort": 0.45, "style": 0.10, "durability": 0.20, "brand_prestige": 0.10}',
 0.92, 'performance_focused', NOW());

-- ============================================
-- SYNTHETIC DATA: PRODUCT AGGREGATE INSIGHTS
-- Computed for popular products
-- ============================================

-- Budget laptop (Dell Inspiron 15) - attracts budget users
INSERT INTO product_aggregate_insights VALUES
('agg_lap_006', 'prod_lap_006', 'vnd_budget_tech', 'cat_laptops',
 '{"price": 0.38, "performance": 0.22, "battery_life": 0.16, "portability": 0.10, "display_quality": 0.08, "brand_reputation": 0.06}',
 245, 28, 0.1143,
 '{"budget_conscious": 0.65, "value_seeker": 0.25, "balanced": 0.10}',
 'budget_conscious',
 NOW());

-- Mid-tier laptop (Acer Aspire 5) - mixed audience
INSERT INTO product_aggregate_insights VALUES
('agg_lap_007', 'prod_lap_007', 'vnd_techbuy', 'cat_laptops',
 '{"price": 0.32, "performance": 0.25, "battery_life": 0.18, "portability": 0.11, "display_quality": 0.09, "brand_reputation": 0.05}',
 312, 45, 0.1442,
 '{"budget_conscious": 0.45, "value_seeker": 0.35, "balanced": 0.20}',
 'budget_conscious',
 NOW());

-- Premium laptop (MacBook Air M2) - brand-loyal users
INSERT INTO product_aggregate_insights VALUES
('agg_lap_017', 'prod_lap_017', 'vnd_premium_tech', 'cat_laptops',
 '{"price": 0.09, "performance": 0.23, "battery_life": 0.22, "portability": 0.16, "display_quality": 0.18, "brand_reputation": 0.12}',
 428, 67, 0.1565,
 '{"brand_loyal": 0.55, "premium_buyer": 0.30, "balanced": 0.15}',
 'brand_loyal',
 NOW());

-- Gaming laptop (ASUS ROG) - performance users
INSERT INTO product_aggregate_insights VALUES
('agg_lap_027', 'prod_lap_027', 'vnd_premium_tech', 'cat_laptops',
 '{"price": 0.07, "performance": 0.48, "battery_life": 0.12, "portability": 0.08, "display_quality": 0.20, "brand_reputation": 0.05}',
 189, 23, 0.1217,
 '{"performance_focused": 0.75, "premium_buyer": 0.15, "balanced": 0.10}',
 'performance_focused',
 NOW());

-- Budget phone (Motorola Moto G)
INSERT INTO product_aggregate_insights VALUES
('agg_phn_002', 'prod_phn_002', 'vnd_techbuy', 'cat_phones',
 '{"price": 0.42, "camera_quality": 0.18, "battery_life": 0.20, "performance": 0.12, "storage_capacity": 0.06, "brand_ecosystem": 0.02}',
 298, 41, 0.1376,
 '{"budget_conscious": 0.70, "value_seeker": 0.20, "balanced": 0.10}',
 'budget_conscious',
 NOW());

-- Flagship phone (iPhone 15 Pro)
INSERT INTO product_aggregate_insights VALUES
('agg_phn_031', 'prod_phn_031', 'vnd_premium_tech', 'cat_phones',
 '{"price": 0.08, "camera_quality": 0.28, "battery_life": 0.18, "performance": 0.22, "storage_capacity": 0.12, "brand_ecosystem": 0.12}',
 512, 89, 0.1738,
 '{"brand_loyal": 0.60, "premium_buyer": 0.25, "performance_focused": 0.15}',
 'brand_loyal',
 NOW());

-- Premium coffee (Ethiopian Yirgacheffe)
INSERT INTO product_aggregate_insights VALUES
('agg_cof_013', 'prod_cof_013', 'vnd_brewmaster', 'cat_coffee',
 '{"price": 0.12, "roast_quality": 0.28, "origin_prestige": 0.28, "organic_certification": 0.18, "flavor_complexity": 0.14}',
 156, 34, 0.2179,
 '{"premium_buyer": 0.65, "balanced": 0.25, "value_seeker": 0.10}',
 'premium_buyer',
 NOW());

-- Running shoe (Adidas Ultraboost)
INSERT INTO product_aggregate_insights VALUES
('agg_snk_014', 'prod_snk_014', 'vnd_kickstyle', 'cat_sneakers',
 '{"price": 0.15, "comfort": 0.42, "style": 0.15, "durability": 0.20, "brand_prestige": 0.08}',
 267, 38, 0.1424,
 '{"performance_focused": 0.55, "premium_buyer": 0.25, "balanced": 0.20}',
 'performance_focused',
 NOW());

-- ============================================
-- SYNTHETIC DATA: VENDOR STRATEGIC INSIGHTS
-- High-level vendor intelligence
-- ============================================

-- TechBuy Electronics - Balanced retailer
INSERT INTO vendor_strategic_insights VALUES
('vsi_tech_lap', 'vnd_techbuy', 'cat_laptops',
 0.28, 35, 156,
 0.1385,
 '{"budget_conscious": 0.35, "value_seeker": 0.30, "balanced": 0.20, "performance_focused": 0.10, "premium_buyer": 0.05}',
 2, 1,
 '{"price": 0.28, "performance": 0.24, "battery_life": 0.18, "portability": 0.12, "display_quality": 0.11, "brand_reputation": 0.07}',
 NOW());

-- Budget Tech Deals - Budget specialist
INSERT INTO vendor_strategic_insights VALUES
('vsi_budget_lap', 'vnd_budget_tech', 'cat_laptops',
 0.18, 25, 98,
 0.1122,
 '{"budget_conscious": 0.70, "value_seeker": 0.20, "balanced": 0.08, "performance_focused": 0.02, "premium_buyer": 0.00}',
 1, 3,
 '{"price": 0.42, "performance": 0.20, "battery_life": 0.16, "portability": 0.10, "display_quality": 0.07, "brand_reputation": 0.05}',
 NOW());

-- Premium Tech Hub - Premium specialist
INSERT INTO vendor_strategic_insights VALUES
('vsi_premium_lap', 'vnd_premium_tech', 'cat_laptops',
 0.24, 28, 134,
 0.1567,
 '{"brand_loyal": 0.40, "premium_buyer": 0.35, "performance_focused": 0.15, "balanced": 0.08, "budget_conscious": 0.02}',
 4, 2,
 '{"price": 0.08, "performance": 0.28, "battery_life": 0.19, "portability": 0.15, "display_quality": 0.19, "brand_reputation": 0.11}',
 NOW());

-- BrewMaster Coffee Co
INSERT INTO vendor_strategic_insights VALUES
('vsi_brew_cof', 'vnd_brewmaster', 'cat_coffee',
 0.42, 18, 289,
 0.2012,
 '{"premium_buyer": 0.45, "balanced": 0.30, "value_seeker": 0.15, "budget_conscious": 0.10}',
 3, 1,
 '{"price": 0.18, "roast_quality": 0.28, "origin_prestige": 0.24, "organic_certification": 0.18, "flavor_complexity": 0.12}',
 NOW());

-- KickStyle Sneakers
INSERT INTO vendor_strategic_insights VALUES
('vsi_kick_snk', 'vnd_kickstyle', 'cat_sneakers',
 0.38, 22, 167,
 0.1456,
 '{"performance_focused": 0.35, "balanced": 0.25, "value_seeker": 0.20, "budget_conscious": 0.15, "premium_buyer": 0.05}',
 2, 1,
 '{"price": 0.22, "comfort": 0.35, "style": 0.18, "durability": 0.17, "brand_prestige": 0.08}',
 NOW());

-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX idx_user_prefs_user ON user_criteria_preferences(user_id);
CREATE INDEX idx_user_prefs_category ON user_criteria_preferences(category_id);
CREATE INDEX idx_user_prefs_segment ON user_criteria_preferences(user_segment);

CREATE INDEX idx_product_insights_product ON product_aggregate_insights(product_id);
CREATE INDEX idx_product_insights_vendor ON product_aggregate_insights(vendor_id);
CREATE INDEX idx_product_insights_segment ON product_aggregate_insights(primary_segment);
CREATE INDEX idx_product_insights_conversion ON product_aggregate_insights(conversion_rate);

CREATE INDEX idx_vendor_insights_vendor ON vendor_strategic_insights(vendor_id);
CREATE INDEX idx_vendor_insights_category ON vendor_strategic_insights(category_id);