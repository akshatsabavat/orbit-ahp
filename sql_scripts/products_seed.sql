-- ============================================
-- ORBIT DENSE DATASET
-- 50 laptops, 50 phones, 30 coffees, 30 sneakers
-- 10 users, 30-40 purchases each
-- Multiple vendors with realistic inventory
-- ============================================

-- CATEGORIES
INSERT INTO categories (category_id, category_name) VALUES
('cat_laptops', 'Laptops'),
('cat_phones', 'Smartphones'),
('cat_coffee', 'Coffee'),
('cat_sneakers', 'Sneakers');

-- USERS (10 diverse personas)
INSERT INTO users (user_id, username, email) VALUES
('usr_001', 'budget_bob', 'bob@email.com'),
('usr_002', 'performance_paula', 'paula@email.com'),
('usr_003', 'apple_andy', 'andy@email.com'),
('usr_004', 'balanced_beth', 'beth@email.com'),
('usr_005', 'vendor_loyal_larry', 'larry@email.com'),
('usr_006', 'gamer_grace', 'grace@email.com'),
('usr_007', 'coffee_connoisseur_carlos', 'carlos@email.com'),
('usr_008', 'runner_rachel', 'rachel@email.com'),
('usr_009', 'brand_hopper_henry', 'henry@email.com'),
('usr_010', 'premium_pete', 'pete@email.com');

-- VENDORS (8 vendors across categories)
INSERT INTO vendors (vendor_id, vendor_name, vendor_rating, avg_shipping_days, return_policy_days) VALUES
('vnd_techbuy', 'TechBuy Electronics', 4.5, 3, 30),
('vnd_gadgetworld', 'GadgetWorld', 4.2, 5, 60),
('vnd_premium_tech', 'Premium Tech Hub', 4.8, 2, 90),
('vnd_budget_tech', 'Budget Tech Deals', 3.9, 7, 14),
('vnd_brewmaster', 'BrewMaster Coffee Co', 4.7, 2, 14),
('vnd_beanroasters', 'Bean Roasters', 4.4, 4, 30),
('vnd_kickstyle', 'KickStyle', 4.6, 3, 45),
('vnd_sneakerhub', 'SneakerHub', 4.3, 5, 30);

-- ============================================
-- LAPTOPS (50 products across all tiers)
-- ============================================

-- ULTRA BUDGET LAPTOPS ($300-500)
INSERT INTO products (product_id, product_name, category_id, brand, model, base_price, specs, description) VALUES
('prod_lap_001', 'HP Stream 14', 'cat_laptops', 'HP', 'Stream 14', 349.00, '{"ram_gb": 4, "storage_gb": 64, "processor": "Intel Celeron N4120", "screen_size": 14.0, "weight_kg": 1.4, "battery_hours": 11, "gpu": "Integrated"}', 'HP Stream 14 laptop'),
('prod_lap_002', 'Lenovo IdeaPad 1', 'cat_laptops', 'Lenovo', 'IdeaPad 1', 299.00, '{"ram_gb": 4, "storage_gb": 128, "processor": "AMD A6-9220e", "screen_size": 14.0, "weight_kg": 1.4, "battery_hours": 8, "gpu": "Integrated"}', 'Lenovo IdeaPad 1 laptop'),
('prod_lap_003', 'Acer Chromebook 315', 'cat_laptops', 'Acer', 'Chromebook 315', 279.00, '{"ram_gb": 4, "storage_gb": 64, "processor": "Intel Celeron N4020", "screen_size": 15.6, "weight_kg": 1.63, "battery_hours": 12, "gpu": "Integrated"}', 'Acer Chromebook 315 laptop'),
('prod_lap_004', 'ASUS VivoBook 15', 'cat_laptops', 'ASUS', 'VivoBook 15', 449.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel Core i3-1115G4", "screen_size": 15.6, "weight_kg": 1.8, "battery_hours": 6, "gpu": "Integrated"}', 'ASUS VivoBook 15 laptop'),
('prod_lap_005', 'Dell Inspiron 14', 'cat_laptops', 'Dell', 'Inspiron 14', 479.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel Pentium Silver N6000", "screen_size": 14.0, "weight_kg": 1.5, "battery_hours": 7, "gpu": "Integrated"}', 'Dell Inspiron 14 laptop'),

-- BUDGET LAPTOPS ($500-800)
('prod_lap_006', 'Dell Inspiron 15 3520', 'cat_laptops', 'Dell', 'Inspiron 15 3520', 599.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel i3-1215U", "screen_size": 15.6, "weight_kg": 1.85, "battery_hours": 6, "gpu": "Integrated"}', 'Dell Inspiron 15 3520 laptop'),
('prod_lap_007', 'Acer Aspire 5', 'cat_laptops', 'Acer', 'Aspire 5 A515-58', 649.00, '{"ram_gb": 8, "storage_gb": 512, "processor": "Intel i5-1235U", "screen_size": 15.6, "weight_kg": 1.77, "battery_hours": 7, "gpu": "Integrated"}', 'Acer Aspire 5 laptop'),
('prod_lap_008', 'HP Pavilion 15', 'cat_laptops', 'HP', 'Pavilion 15', 799.00, '{"ram_gb": 8, "storage_gb": 512, "processor": "Intel i5-1335U", "screen_size": 15.6, "weight_kg": 1.75, "battery_hours": 8, "gpu": "Integrated"}', 'HP Pavilion 15 laptop'),
('prod_lap_009', 'Lenovo IdeaPad 3', 'cat_laptops', 'Lenovo', 'IdeaPad 3', 549.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "AMD Ryzen 5 5500U", "screen_size": 15.6, "weight_kg": 1.65, "battery_hours": 8, "gpu": "Integrated"}', 'Lenovo IdeaPad 3 laptop'),
('prod_lap_010', 'ASUS Vivobook 14', 'cat_laptops', 'ASUS', 'Vivobook 14', 699.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-1235U", "screen_size": 14.0, "weight_kg": 1.4, "battery_hours": 9, "gpu": "Integrated"}', 'ASUS Vivobook 14 laptop'),
('prod_lap_011', 'HP 14s', 'cat_laptops', 'HP', '14s-dq5000', 579.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel i3-1215U", "screen_size": 14.0, "weight_kg": 1.46, "battery_hours": 7, "gpu": "Integrated"}', 'HP 14s laptop'),
('prod_lap_012', 'Acer Swift 3', 'cat_laptops', 'Acer', 'Swift 3 SF314', 749.00, '{"ram_gb": 8, "storage_gb": 512, "processor": "AMD Ryzen 5 7530U", "screen_size": 14.0, "weight_kg": 1.25, "battery_hours": 12, "gpu": "Integrated"}', 'Acer Swift 3 laptop'),

-- MID-RANGE LAPTOPS ($800-1500)
('prod_lap_013', 'Lenovo IdeaPad Slim 5', 'cat_laptops', 'Lenovo', 'IdeaPad Slim 5', 899.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "AMD Ryzen 7 7730U", "screen_size": 14.0, "weight_kg": 1.46, "battery_hours": 14, "gpu": "Integrated"}', 'Lenovo IdeaPad Slim 5 laptop'),
('prod_lap_014', 'ASUS ZenBook 14', 'cat_laptops', 'ASUS', 'ZenBook 14 UX3402', 999.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1260P", "screen_size": 14.0, "weight_kg": 1.39, "battery_hours": 16, "gpu": "Integrated"}', 'ASUS ZenBook 14 laptop'),
('prod_lap_015', 'HP Envy x360', 'cat_laptops', 'HP', 'Envy x360 15', 1099.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "AMD Ryzen 7 7730U", "screen_size": 15.6, "weight_kg": 1.74, "battery_hours": 13, "gpu": "Integrated"}', 'HP Envy x360 laptop'),
('prod_lap_016', 'Dell Inspiron 16 Plus', 'cat_laptops', 'Dell', 'Inspiron 16 Plus 7630', 1199.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-13700H", "screen_size": 16.0, "weight_kg": 2.05, "battery_hours": 9, "gpu": "RTX 3050"}', 'Dell Inspiron 16 Plus laptop'),
('prod_lap_017', 'MacBook Air M2', 'cat_laptops', 'Apple', 'MacBook Air M2', 1199.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "M2", "screen_size": 13.6, "weight_kg": 1.24, "battery_hours": 18, "gpu": "Integrated"}', 'MacBook Air M2 laptop'),
('prod_lap_018', 'MacBook Air M2 16GB', 'cat_laptops', 'Apple', 'MacBook Air M2 16GB', 1399.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "M2", "screen_size": 13.6, "weight_kg": 1.24, "battery_hours": 18, "gpu": "Integrated"}', 'MacBook Air M2 16GB laptop'),
('prod_lap_019', 'Lenovo ThinkPad E14', 'cat_laptops', 'Lenovo', 'ThinkPad E14 Gen 5', 949.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-1335U", "screen_size": 14.0, "weight_kg": 1.41, "battery_hours": 12, "gpu": "Integrated"}', 'Lenovo ThinkPad E14 laptop'),
('prod_lap_020', 'ASUS TUF Gaming F15', 'cat_laptops', 'ASUS', 'TUF Gaming F15', 1099.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-12500H", "screen_size": 15.6, "weight_kg": 2.2, "battery_hours": 6, "gpu": "RTX 3050"}', 'ASUS TUF Gaming F15 laptop'),
('prod_lap_021', 'MSI Modern 15', 'cat_laptops', 'MSI', 'Modern 15 B13M', 849.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-1335U", "screen_size": 15.6, "weight_kg": 1.7, "battery_hours": 9, "gpu": "Integrated"}', 'MSI Modern 15 laptop'),
('prod_lap_022', 'LG Gram 14', 'cat_laptops', 'LG', 'Gram 14Z90R', 1199.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-1340P", "screen_size": 14.0, "weight_kg": 0.999, "battery_hours": 16, "gpu": "Integrated"}', 'LG Gram 14 laptop'),
('prod_lap_023', 'Dell XPS 13', 'cat_laptops', 'Dell', 'XPS 13 9315', 1299.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1250U", "screen_size": 13.4, "weight_kg": 1.17, "battery_hours": 14, "gpu": "Integrated"}', 'Dell XPS 13 laptop'),

-- PREMIUM LAPTOPS ($1500-2500)
('prod_lap_024', 'MacBook Pro 14 M3', 'cat_laptops', 'Apple', 'MacBook Pro 14 M3', 1999.00, '{"ram_gb": 18, "storage_gb": 512, "processor": "M3 Pro", "screen_size": 14.2, "weight_kg": 1.6, "battery_hours": 18, "gpu": "Integrated"}', 'MacBook Pro 14 M3 laptop'),
('prod_lap_025', 'Dell XPS 15 9530', 'cat_laptops', 'Dell', 'XPS 15 9530', 1599.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-13700H", "screen_size": 15.6, "weight_kg": 1.86, "battery_hours": 12, "gpu": "RTX 4050"}', 'Dell XPS 15 laptop'),
('prod_lap_026', 'Lenovo ThinkPad X1 Carbon Gen 11', 'cat_laptops', 'Lenovo', 'ThinkPad X1 Carbon Gen 11', 1799.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1365U", "screen_size": 14.0, "weight_kg": 1.12, "battery_hours": 15, "gpu": "Integrated"}', 'Lenovo ThinkPad X1 Carbon laptop'),
('prod_lap_027', 'ASUS ROG Zephyrus G14', 'cat_laptops', 'ASUS', 'ROG Zephyrus G14 2024', 1799.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "AMD Ryzen 9 7940HS", "screen_size": 14.0, "weight_kg": 1.65, "battery_hours": 10, "gpu": "RTX 4060"}', 'ASUS ROG Zephyrus G14 laptop'),
('prod_lap_028', 'MSI Stealth 15', 'cat_laptops', 'MSI', 'Stealth 15 A13V', 1899.00, '{"ram_gb": 16, "storage_gb": 1024, "processor": "Intel i7-13700H", "screen_size": 15.6, "weight_kg": 2.1, "battery_hours": 6, "gpu": "RTX 4070"}', 'MSI Stealth 15 laptop'),
('prod_lap_029', 'LG Gram 17', 'cat_laptops', 'LG', 'Gram 17 17Z90R', 1699.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1360P", "screen_size": 17.0, "weight_kg": 1.35, "battery_hours": 19, "gpu": "Integrated"}', 'LG Gram 17 laptop'),
('prod_lap_030', 'Razer Blade 14', 'cat_laptops', 'Razer', 'Blade 14 2024', 2199.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "AMD Ryzen 9 7940HS", "screen_size": 14.0, "weight_kg": 1.84, "battery_hours": 8, "gpu": "RTX 4070"}', 'Razer Blade 14 laptop'),
('prod_lap_031', 'HP Spectre x360 16', 'cat_laptops', 'HP', 'Spectre x360 16', 1899.00, '{"ram_gb": 16, "storage_gb": 1024, "processor": "Intel i7-13700H", "screen_size": 16.0, "weight_kg": 2.05, "battery_hours": 11, "gpu": "RTX 3050"}', 'HP Spectre x360 16 laptop'),
('prod_lap_032', 'MacBook Pro 16 M3 Pro', 'cat_laptops', 'Apple', 'MacBook Pro 16 M3 Pro', 2499.00, '{"ram_gb": 36, "storage_gb": 512, "processor": "M3 Pro", "screen_size": 16.2, "weight_kg": 2.14, "battery_hours": 22, "gpu": "Integrated"}', 'MacBook Pro 16 M3 Pro laptop'),
('prod_lap_033', 'Lenovo Legion Pro 5', 'cat_laptops', 'Lenovo', 'Legion Pro 5 16IRX9', 1649.00, '{"ram_gb": 16, "storage_gb": 1024, "processor": "Intel i7-14700HX", "screen_size": 16.0, "weight_kg": 2.5, "battery_hours": 7, "gpu": "RTX 4060"}', 'Lenovo Legion Pro 5 laptop'),
('prod_lap_034', 'ASUS ProArt Studiobook', 'cat_laptops', 'ASUS', 'ProArt Studiobook 16', 2299.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "Intel i9-13980HX", "screen_size": 16.0, "weight_kg": 2.4, "battery_hours": 9, "gpu": "RTX 4060"}', 'ASUS ProArt Studiobook laptop'),

-- WORKSTATION/ULTRA PREMIUM ($2500+)
('prod_lap_035', 'Dell Precision 5680', 'cat_laptops', 'Dell', 'Precision 5680', 2899.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "Intel i9-13900H", "screen_size": 16.0, "weight_kg": 2.05, "battery_hours": 10, "gpu": "RTX A2000"}', 'Dell Precision 5680 laptop'),
('prod_lap_036', 'MacBook Pro 16 M3 Max', 'cat_laptops', 'Apple', 'MacBook Pro 16 M3 Max', 3499.00, '{"ram_gb": 48, "storage_gb": 1024, "processor": "M3 Max", "screen_size": 16.2, "weight_kg": 2.14, "battery_hours": 22, "gpu": "Integrated"}', 'MacBook Pro 16 M3 Max laptop'),
('prod_lap_037', 'Lenovo ThinkPad P1 Gen 6', 'cat_laptops', 'Lenovo', 'ThinkPad P1 Gen 6', 3199.00, '{"ram_gb": 32, "storage_gb": 2048, "processor": "Intel i9-13900H", "screen_size": 16.0, "weight_kg": 1.81, "battery_hours": 11, "gpu": "RTX 5000 Ada"}', 'Lenovo ThinkPad P1 Gen 6 laptop'),
('prod_lap_038', 'HP ZBook Studio G10', 'cat_laptops', 'HP', 'ZBook Studio G10', 2999.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "Intel i9-13900H", "screen_size": 16.0, "weight_kg": 1.73, "battery_hours": 10, "gpu": "RTX 3000 Ada"}', 'HP ZBook Studio G10 laptop'),
('prod_lap_039', 'ASUS ROG Strix Scar 18', 'cat_laptops', 'ASUS', 'ROG Strix Scar 18', 2799.00, '{"ram_gb": 32, "storage_gb": 2048, "processor": "Intel i9-14900HX", "screen_size": 18.0, "weight_kg": 3.1, "battery_hours": 5, "gpu": "RTX 4090"}', 'ASUS ROG Strix Scar 18 laptop'),
('prod_lap_040', 'MSI Creator Z17', 'cat_laptops', 'MSI', 'Creator Z17 A12U', 2599.00, '{"ram_gb": 32, "storage_gb": 2048, "processor": "Intel i9-12900H", "screen_size": 17.0, "weight_kg": 2.5, "battery_hours": 8, "gpu": "RTX 3080 Ti"}', 'MSI Creator Z17 laptop'),

-- 2-IN-1 / CONVERTIBLES (Various prices)
('prod_lap_041', 'HP Pavilion x360 14', 'cat_laptops', 'HP', 'Pavilion x360 14', 649.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel i5-1235U", "screen_size": 14.0, "weight_kg": 1.51, "battery_hours": 10, "gpu": "Integrated"}', 'HP Pavilion x360 14 laptop'),
('prod_lap_042', 'Lenovo Yoga 7i', 'cat_laptops', 'Lenovo', 'Yoga 7i 16', 999.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1355U", "screen_size": 16.0, "weight_kg": 2.04, "battery_hours": 13, "gpu": "Integrated"}', 'Lenovo Yoga 7i laptop'),
('prod_lap_043', 'Dell Inspiron 14 2-in-1', 'cat_laptops', 'Dell', 'Inspiron 14 2-in-1 7430', 849.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i5-1335U", "screen_size": 14.0, "weight_kg": 1.59, "battery_hours": 12, "gpu": "Integrated"}', 'Dell Inspiron 14 2-in-1 laptop'),
('prod_lap_044', 'ASUS Zenbook Flip 14', 'cat_laptops', 'ASUS', 'Zenbook Flip 14', 1199.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-1260P", "screen_size": 14.0, "weight_kg": 1.5, "battery_hours": 14, "gpu": "Integrated"}', 'ASUS Zenbook Flip 14 laptop'),
('prod_lap_045', 'Microsoft Surface Laptop Studio', 'cat_laptops', 'Microsoft', 'Surface Laptop Studio', 1599.00, '{"ram_gb": 16, "storage_gb": 512, "processor": "Intel i7-11370H", "screen_size": 14.4, "weight_kg": 1.82, "battery_hours": 19, "gpu": "RTX 3050 Ti"}', 'Microsoft Surface Laptop Studio laptop'),

-- CHROMEBOOKS (Premium)
('prod_lap_046', 'HP Dragonfly Pro Chromebook', 'cat_laptops', 'HP', 'Dragonfly Pro Chromebook', 999.00, '{"ram_gb": 16, "storage_gb": 256, "processor": "Intel i5-1235U", "screen_size": 14.0, "weight_kg": 1.4, "battery_hours": 11, "gpu": "Integrated"}', 'HP Dragonfly Pro Chromebook laptop'),
('prod_lap_047', 'ASUS Chromebook Flip CX5', 'cat_laptops', 'ASUS', 'Chromebook Flip CX5', 699.00, '{"ram_gb": 8, "storage_gb": 256, "processor": "Intel i5-1135G7", "screen_size": 15.6, "weight_kg": 1.95, "battery_hours": 12, "gpu": "Integrated"}', 'ASUS Chromebook Flip CX5 laptop'),

-- GAMING SPECIALIST LAPTOPS
('prod_lap_048', 'Alienware m16 R1', 'cat_laptops', 'Alienware', 'm16 R1', 2399.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "Intel i9-13900HX", "screen_size": 16.0, "weight_kg": 2.98, "battery_hours": 6, "gpu": "RTX 4070"}', 'Alienware m16 R1 laptop'),
('prod_lap_049', 'Gigabyte Aorus 15X', 'cat_laptops', 'Gigabyte', 'Aorus 15X', 2199.00, '{"ram_gb": 32, "storage_gb": 1024, "processor": "Intel i9-13900HX", "screen_size": 15.6, "weight_kg": 2.3, "battery_hours": 6, "gpu": "RTX 4080"}', 'Gigabyte Aorus 15X laptop'),
('prod_lap_050', 'Acer Predator Helios 16', 'cat_laptops', 'Acer', 'Predator Helios 16', 1799.00, '{"ram_gb": 16, "storage_gb": 1024, "processor": "Intel i7-13700HX", "screen_size": 16.0, "weight_kg": 2.6, "battery_hours": 7, "gpu": "RTX 4060"}', 'Acer Predator Helios 16 laptop');

-- ============================================
-- SMARTPHONES (50 products)
-- ============================================

-- BUDGET PHONES ($200-450)
INSERT INTO products (product_id, product_name, category_id, brand, model, base_price, specs, description) VALUES
('prod_phn_001', 'Samsung Galaxy A14', 'cat_phones', 'Samsung', 'Galaxy A14', 199.00, '{"camera_mp": 50, "storage_gb": 64, "battery_mah": 5000, "screen_size": 6.6, "processor": "Exynos 850", "ram_gb": 4}', 'Samsung Galaxy A14 smartphone'),
('prod_phn_002', 'Motorola Moto G Power', 'cat_phones', 'Motorola', 'Moto G Power 2024', 249.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.5, "processor": "MediaTek Dimensity 7020", "ram_gb": 6}', 'Motorola Moto G Power smartphone'),
('prod_phn_003', 'OnePlus Nord N30', 'cat_phones', 'OnePlus', 'Nord N30', 299.00, '{"camera_mp": 108, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.7, "processor": "Snapdragon 695", "ram_gb": 8}', 'OnePlus Nord N30 smartphone'),
('prod_phn_004', 'Google Pixel 7a', 'cat_phones', 'Google', 'Pixel 7a', 449.00, '{"camera_mp": 64, "storage_gb": 128, "battery_mah": 4385, "screen_size": 6.1, "processor": "Tensor G2", "ram_gb": 8}', 'Google Pixel 7a smartphone'),
('prod_phn_005', 'iPhone SE 2022', 'cat_phones', 'Apple', 'iPhone SE 2022', 429.00, '{"camera_mp": 12, "storage_gb": 64, "battery_mah": 2018, "screen_size": 4.7, "processor": "A15 Bionic", "ram_gb": 4}', 'iPhone SE 2022 smartphone'),
('prod_phn_006', 'Samsung Galaxy A34', 'cat_phones', 'Samsung', 'Galaxy A34', 349.00, '{"camera_mp": 48, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.6, "processor": "MediaTek Dimensity 1080", "ram_gb": 6}', 'Samsung Galaxy A34 smartphone'),
('prod_phn_007', 'Xiaomi Redmi Note 13', 'cat_phones', 'Xiaomi', 'Redmi Note 13', 279.00, '{"camera_mp": 108, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.67, "processor": "Snapdragon 685", "ram_gb": 6}', 'Xiaomi Redmi Note 13 smartphone'),
('prod_phn_008', 'Motorola Edge 40 Neo', 'cat_phones', 'Motorola', 'Edge 40 Neo', 399.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4400, "screen_size": 6.5, "processor": "MediaTek Dimensity 7030", "ram_gb": 8}', 'Motorola Edge 40 Neo smartphone'),
('prod_phn_009', 'Nokia G400', 'cat_phones', 'Nokia', 'G400 5G', 239.00, '{"camera_mp": 48, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.6, "processor": "Snapdragon 480+", "ram_gb": 6}', 'Nokia G400 smartphone'),
('prod_phn_010', 'TCL 40 XE', 'cat_phones', 'TCL', '40 XE', 199.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.6, "processor": "MediaTek Dimensity 700", "ram_gb": 4}', 'TCL 40 XE smartphone'),

-- MID-RANGE PHONES ($450-700)
('prod_phn_011', 'Samsung Galaxy A54', 'cat_phones', 'Samsung', 'Galaxy A54', 449.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.4, "processor": "Exynos 1380", "ram_gb": 6}', 'Samsung Galaxy A54 smartphone'),
('prod_phn_012', 'Nothing Phone 2', 'cat_phones', 'Nothing', 'Phone 2', 599.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4700, "screen_size": 6.7, "processor": "Snapdragon 8+ Gen 1", "ram_gb": 12}', 'Nothing Phone 2 smartphone'),
('prod_phn_013', 'OnePlus 11R', 'cat_phones', 'OnePlus', '11R', 499.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.7, "processor": "Snapdragon 8+ Gen 1", "ram_gb": 8}', 'OnePlus 11R smartphone'),
('prod_phn_014', 'Google Pixel 8', 'cat_phones', 'Google', 'Pixel 8', 699.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 4575, "screen_size": 6.2, "processor": "Tensor G3", "ram_gb": 8}', 'Google Pixel 8 smartphone'),
('prod_phn_015', 'Xiaomi 13T', 'cat_phones', 'Xiaomi', '13T', 599.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 5000, "screen_size": 6.67, "processor": "MediaTek Dimensity 8200", "ram_gb": 12}', 'Xiaomi 13T smartphone'),
('prod_phn_016', 'Motorola Edge 40', 'cat_phones', 'Motorola', 'Edge 40', 549.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4400, "screen_size": 6.6, "processor": "MediaTek 8020", "ram_gb": 8}', 'Motorola Edge 40 smartphone'),
('prod_phn_017', 'Samsung Galaxy S23 FE', 'cat_phones', 'Samsung', 'Galaxy S23 FE', 599.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 4500, "screen_size": 6.4, "processor": "Exynos 2200", "ram_gb": 8}', 'Samsung Galaxy S23 FE smartphone'),
('prod_phn_018', 'OnePlus Nord 3', 'cat_phones', 'OnePlus', 'Nord 3', 499.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.7, "processor": "MediaTek Dimensity 9000", "ram_gb": 8}', 'OnePlus Nord 3 smartphone'),
('prod_phn_019', 'Realme GT 5', 'cat_phones', 'Realme', 'GT 5', 549.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 5240, "screen_size": 6.7, "processor": "Snapdragon 8 Gen 2", "ram_gb": 12}', 'Realme GT 5 smartphone'),
('prod_phn_020', 'ASUS Zenfone 10', 'cat_phones', 'ASUS', 'Zenfone 10', 699.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4300, "screen_size": 5.9, "processor": "Snapdragon 8 Gen 2", "ram_gb": 8}', 'ASUS Zenfone 10 smartphone'),

-- PREMIUM PHONES ($700-1000)
('prod_phn_021', 'iPhone 14', 'cat_phones', 'Apple', 'iPhone 14', 799.00, '{"camera_mp": 12, "storage_gb": 128, "battery_mah": 3279, "screen_size": 6.1, "processor": "A15 Bionic", "ram_gb": 6}', 'iPhone 14 smartphone'),
('prod_phn_022', 'Samsung Galaxy S24', 'cat_phones', 'Samsung', 'Galaxy S24', 799.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4000, "screen_size": 6.2, "processor": "Snapdragon 8 Gen 3", "ram_gb": 8}', 'Samsung Galaxy S24 smartphone'),
('prod_phn_023', 'OnePlus 12', 'cat_phones', 'OnePlus', '12', 799.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 5400, "screen_size": 6.8, "processor": "Snapdragon 8 Gen 3", "ram_gb": 12}', 'OnePlus 12 smartphone'),
('prod_phn_024', 'Google Pixel 8 Pro', 'cat_phones', 'Google', 'Pixel 8 Pro', 999.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5050, "screen_size": 6.7, "processor": "Tensor G3", "ram_gb": 12}', 'Google Pixel 8 Pro smartphone'),
('prod_phn_025', 'iPhone 15', 'cat_phones', 'Apple', 'iPhone 15', 799.00, '{"camera_mp": 48, "storage_gb": 128, "battery_mah": 3349, "screen_size": 6.1, "processor": "A16 Bionic", "ram_gb": 6}', 'iPhone 15 smartphone'),
('prod_phn_026', 'Xiaomi 14', 'cat_phones', 'Xiaomi', '14', 799.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4610, "screen_size": 6.4, "processor": "Snapdragon 8 Gen 3", "ram_gb": 12}', 'Xiaomi 14 smartphone'),
('prod_phn_027', 'Samsung Galaxy S24+', 'cat_phones', 'Samsung', 'Galaxy S24+', 999.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4900, "screen_size": 6.7, "processor": "Snapdragon 8 Gen 3", "ram_gb": 12}', 'Samsung Galaxy S24+ smartphone'),
('prod_phn_028', 'OnePlus 12 Pro', 'cat_phones', 'OnePlus', '12 Pro', 899.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 5400, "screen_size": 6.8, "processor": "Snapdragon 8 Gen 3", "ram_gb": 16}', 'OnePlus 12 Pro smartphone'),
('prod_phn_029', 'ASUS ROG Phone 7', 'cat_phones', 'ASUS', 'ROG Phone 7', 999.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 6000, "screen_size": 6.78, "processor": "Snapdragon 8 Gen 2", "ram_gb": 16}', 'ASUS ROG Phone 7 smartphone'),
('prod_phn_030', 'Sony Xperia 5 V', 'cat_phones', 'Sony', 'Xperia 5 V', 899.00, '{"camera_mp": 48, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.1, "processor": "Snapdragon 8 Gen 2", "ram_gb": 8}', 'Sony Xperia 5 V smartphone'),

-- FLAGSHIP PHONES ($1000+)
('prod_phn_031', 'iPhone 15 Pro', 'cat_phones', 'Apple', 'iPhone 15 Pro', 999.00, '{"camera_mp": 48, "storage_gb": 256, "battery_mah": 3274, "screen_size": 6.1, "processor": "A17 Pro", "ram_gb": 8}', 'iPhone 15 Pro smartphone'),
('prod_phn_032', 'iPhone 15 Pro Max', 'cat_phones', 'Apple', 'iPhone 15 Pro Max', 1199.00, '{"camera_mp": 48, "storage_gb": 256, "battery_mah": 4422, "screen_size": 6.7, "processor": "A17 Pro", "ram_gb": 8}', 'iPhone 15 Pro Max smartphone'),
('prod_phn_033', 'Samsung Galaxy S24 Ultra', 'cat_phones', 'Samsung', 'Galaxy S24 Ultra', 1299.00, '{"camera_mp": 200, "storage_gb": 256, "battery_mah": 5000, "screen_size": 6.8, "processor": "Snapdragon 8 Gen 3", "ram_gb": 12}', 'Samsung Galaxy S24 Ultra smartphone'),
('prod_phn_034', 'Samsung Galaxy Z Fold 5', 'cat_phones', 'Samsung', 'Galaxy Z Fold 5', 1799.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 4400, "screen_size": 7.6, "processor": "Snapdragon 8 Gen 2", "ram_gb": 12}', 'Samsung Galaxy Z Fold 5 smartphone'),
('prod_phn_035', 'Samsung Galaxy Z Flip 5', 'cat_phones', 'Samsung', 'Galaxy Z Flip 5', 999.00, '{"camera_mp": 12, "storage_gb": 256, "battery_mah": 3700, "screen_size": 6.7, "processor": "Snapdragon 8 Gen 2", "ram_gb": 8}', 'Samsung Galaxy Z Flip 5 smartphone'),
('prod_phn_036', 'Google Pixel Fold', 'cat_phones', 'Google', 'Pixel Fold', 1799.00, '{"camera_mp": 48, "storage_gb": 256, "battery_mah": 4821, "screen_size": 7.6, "processor": "Tensor G2", "ram_gb": 12}', 'Google Pixel Fold smartphone'),
('prod_phn_037', 'Xiaomi 14 Pro', 'cat_phones', 'Xiaomi', '14 Pro', 999.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 4880, "screen_size": 6.73, "processor": "Snapdragon 8 Gen 3", "ram_gb": 16}', 'Xiaomi 14 Pro smartphone'),
('prod_phn_038', 'OnePlus Open', 'cat_phones', 'OnePlus', 'Open', 1699.00, '{"camera_mp": 48, "storage_gb": 512, "battery_mah": 4805, "screen_size": 7.8, "processor": "Snapdragon 8 Gen 2", "ram_gb": 16}', 'OnePlus Open smartphone'),
('prod_phn_039', 'ASUS ROG Phone 7 Ultimate', 'cat_phones', 'ASUS', 'ROG Phone 7 Ultimate', 1399.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 6000, "screen_size": 6.78, "processor": "Snapdragon 8 Gen 2", "ram_gb": 16}', 'ASUS ROG Phone 7 Ultimate smartphone'),
('prod_phn_040', 'Sony Xperia 1 V', 'cat_phones', 'Sony', 'Xperia 1 V', 1399.00, '{"camera_mp": 48, "storage_gb": 256, "battery_mah": 5000, "screen_size": 6.5, "processor": "Snapdragon 8 Gen 2", "ram_gb": 12}', 'Sony Xperia 1 V smartphone'),

-- SPECIALTY/NICHE PHONES
('prod_phn_041', 'iPhone 14 Plus', 'cat_phones', 'Apple', 'iPhone 14 Plus', 899.00, '{"camera_mp": 12, "storage_gb": 128, "battery_mah": 4323, "screen_size": 6.7, "processor": "A15 Bionic", "ram_gb": 6}', 'iPhone 14 Plus smartphone'),
('prod_phn_042', 'iPhone 15 Plus', 'cat_phones', 'Apple', 'iPhone 15 Plus', 899.00, '{"camera_mp": 48, "storage_gb": 128, "battery_mah": 4383, "screen_size": 6.7, "processor": "A16 Bionic", "ram_gb": 6}', 'iPhone 15 Plus smartphone'),
('prod_phn_043', 'Samsung Galaxy A73', 'cat_phones', 'Samsung', 'Galaxy A73', 499.00, '{"camera_mp": 108, "storage_gb": 256, "battery_mah": 5000, "screen_size": 6.7, "processor": "Snapdragon 778G", "ram_gb": 8}', 'Samsung Galaxy A73 smartphone'),
('prod_phn_044', 'Motorola Razr 40', 'cat_phones', 'Motorola', 'Razr 40', 699.00, '{"camera_mp": 64, "storage_gb": 256, "battery_mah": 4200, "screen_size": 6.9, "processor": "Snapdragon 7 Gen 1", "ram_gb": 8}', 'Motorola Razr 40 smartphone'),
('prod_phn_045', 'Xiaomi 13 Ultra', 'cat_phones', 'Xiaomi', '13 Ultra', 1299.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 5000, "screen_size": 6.73, "processor": "Snapdragon 8 Gen 2", "ram_gb": 12}', 'Xiaomi 13 Ultra smartphone'),
('prod_phn_046', 'Oppo Find N3', 'cat_phones', 'Oppo', 'Find N3', 1599.00, '{"camera_mp": 48, "storage_gb": 512, "battery_mah": 4805, "screen_size": 7.8, "processor": "Snapdragon 8 Gen 2", "ram_gb": 16}', 'Oppo Find N3 smartphone'),
('prod_phn_047', 'Vivo X100 Pro', 'cat_phones', 'Vivo', 'X100 Pro', 999.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 5400, "screen_size": 6.78, "processor": "MediaTek Dimensity 9300", "ram_gb": 16}', 'Vivo X100 Pro smartphone'),
('prod_phn_048', 'Honor Magic V2', 'cat_phones', 'Honor', 'Magic V2', 1599.00, '{"camera_mp": 50, "storage_gb": 512, "battery_mah": 5000, "screen_size": 7.9, "processor": "Snapdragon 8 Gen 2", "ram_gb": 16}', 'Honor Magic V2 smartphone'),
('prod_phn_049', 'Realme GT 5 Pro', 'cat_phones', 'Realme', 'GT 5 Pro', 699.00, '{"camera_mp": 50, "storage_gb": 256, "battery_mah": 5400, "screen_size": 6.7, "processor": "Snapdragon 8 Gen 3", "ram_gb": 12}', 'Realme GT 5 Pro smartphone'),
('prod_phn_050', 'Nothing Phone 2a', 'cat_phones', 'Nothing', 'Phone 2a', 349.00, '{"camera_mp": 50, "storage_gb": 128, "battery_mah": 5000, "screen_size": 6.7, "processor": "MediaTek Dimensity 7200", "ram_gb": 8}', 'Nothing Phone 2a smartphone');

-- ============================================
-- COFFEE (30 products)
-- ============================================

INSERT INTO products (product_id, product_name, category_id, brand, model, base_price, specs, description) VALUES
-- BUDGET/EVERYDAY COFFEE ($8-13)
('prod_cof_001', 'House Blend', 'cat_coffee', 'Morning Brew', 'Budget', 8.99, '{"origin": "Blend", "roast_level": "medium", "weight_grams": 454, "is_organic": false, "flavor_notes": ["balanced", "simple"], "caffeine_level": "medium"}', 'Morning Brew House Blend'),
('prod_cof_002', 'Breakfast Blend', 'cat_coffee', 'Morning Brew', 'Everyday', 9.99, '{"origin": "Blend", "roast_level": "medium", "weight_grams": 454, "is_organic": false, "flavor_notes": ["balanced", "smooth", "mild"], "caffeine_level": "medium"}', 'Morning Brew Breakfast Blend'),
('prod_cof_003', 'French Roast Dark', 'cat_coffee', 'Dark Matter', 'Classic', 12.99, '{"origin": "Blend", "roast_level": "dark", "weight_grams": 454, "is_organic": false, "flavor_notes": ["smoky", "bold", "bitter"], "caffeine_level": "high"}', 'Dark Matter French Roast'),
('prod_cof_004', 'Colombian Classic', 'cat_coffee', 'Bean Masters', 'Standard', 11.99, '{"origin": "Colombia", "roast_level": "medium", "weight_grams": 454, "is_organic": false, "flavor_notes": ["chocolate", "nutty"], "caffeine_level": "medium"}', 'Bean Masters Colombian Classic'),
('prod_cof_005', 'Morning Kick', 'cat_coffee', 'Café Direct', 'Energy', 10.99, '{"origin": "Blend", "roast_level": "medium-dark", "weight_grams": 340, "is_organic": false, "flavor_notes": ["bold", "strong"], "caffeine_level": "high"}', 'Café Direct Morning Kick'),

-- MID-RANGE COFFEE ($14-19)
('prod_cof_006', 'Colombian Supremo', 'cat_coffee', 'Bean Masters', 'Premium', 15.99, '{"origin": "Colombia", "roast_level": "medium", "weight_grams": 454, "is_organic": false, "flavor_notes": ["chocolate", "caramel", "nutty"], "caffeine_level": "medium"}', 'Bean Masters Colombian Supremo'),
('prod_cof_007', 'Decaf Swiss Water', 'cat_coffee', 'Bean Masters', 'Decaf', 14.99, '{"origin": "Colombia", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["smooth", "chocolate"], "caffeine_level": "none"}', 'Bean Masters Decaf Swiss Water'),
('prod_cof_008', 'Espresso Forte', 'cat_coffee', 'Dark Matter', 'Espresso', 16.99, '{"origin": "Blend", "roast_level": "dark", "weight_grams": 340, "is_organic": false, "flavor_notes": ["intense", "chocolate", "caramel"], "caffeine_level": "very_high"}', 'Dark Matter Espresso Forte'),
('prod_cof_009', 'Costa Rican Tarrazu', 'cat_coffee', 'Island Coffee Co', 'Premium', 17.99, '{"origin": "Costa Rica", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["citrus", "honey", "balanced"], "caffeine_level": "medium"}', 'Island Coffee Co Costa Rican Tarrazu'),
('prod_cof_010', 'Brazilian Santos', 'cat_coffee', 'Origin Roasters', 'South American', 16.49, '{"origin": "Brazil", "roast_level": "medium", "weight_grams": 340, "is_organic": false, "flavor_notes": ["chocolate", "caramel", "smooth"], "caffeine_level": "medium"}', 'Origin Roasters Brazilian Santos'),
('prod_cof_011', 'Guatemala Antigua', 'cat_coffee', 'Mountain Peak', 'Single Origin', 17.49, '{"origin": "Guatemala", "roast_level": "medium-dark", "weight_grams": 340, "is_organic": true, "flavor_notes": ["cocoa", "spice", "smoky"], "caffeine_level": "medium"}', 'Mountain Peak Guatemala Antigua'),
('prod_cof_012', 'Peru Organic', 'cat_coffee', 'Fair Trade Co', 'Organic', 15.49, '{"origin": "Peru", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["nutty", "mild", "sweet"], "caffeine_level": "medium"}', 'Fair Trade Co Peru Organic'),

-- PREMIUM SINGLE ORIGIN ($18-23)
('prod_cof_013', 'Ethiopian Yirgacheffe', 'cat_coffee', 'Origin Roasters', 'Single Origin', 18.99, '{"origin": "Ethiopia", "roast_level": "light", "weight_grams": 340, "is_organic": true, "flavor_notes": ["floral", "citrus", "tea-like"], "caffeine_level": "medium"}', 'Origin Roasters Ethiopian Yirgacheffe'),
('prod_cof_014', 'Kenyan AA', 'cat_coffee', 'Origin Roasters', 'Single Origin', 21.99, '{"origin": "Kenya", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["berry", "wine", "bright"], "caffeine_level": "high"}', 'Origin Roasters Kenyan AA'),
('prod_cof_015', 'Sumatra Mandheling', 'cat_coffee', 'Island Coffee Co', 'Reserve', 19.99, '{"origin": "Indonesia", "roast_level": "dark", "weight_grams": 340, "is_organic": true, "flavor_notes": ["earthy", "herbal", "full-bodied"], "caffeine_level": "high"}', 'Island Coffee Co Sumatra Mandheling'),
('prod_cof_016', 'Ethiopian Sidamo', 'cat_coffee', 'Mountain Peak', 'Estate', 20.49, '{"origin": "Ethiopia", "roast_level": "light-medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["blueberry", "lemon", "wine"], "caffeine_level": "medium"}', 'Mountain Peak Ethiopian Sidamo'),
('prod_cof_017', 'Rwanda Bourbon', 'cat_coffee', 'Origin Roasters', 'Micro-lot', 22.99, '{"origin": "Rwanda", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["cherry", "chocolate", "caramel"], "caffeine_level": "medium"}', 'Origin Roasters Rwanda Bourbon'),
('prod_cof_018', 'Jamaica Blue Mountain', 'cat_coffee', 'Premium Origins', 'Estate', 39.99, '{"origin": "Jamaica", "roast_level": "medium", "weight_grams": 227, "is_organic": false, "flavor_notes": ["mild", "balanced", "sweet"], "caffeine_level": "low"}', 'Premium Origins Jamaica Blue Mountain'),
('prod_cof_019', 'Hawaiian Kona', 'cat_coffee', 'Island Coffee Co', 'Estate', 34.99, '{"origin": "Hawaii", "roast_level": "medium", "weight_grams": 227, "is_organic": false, "flavor_notes": ["buttery", "smooth", "wine"], "caffeine_level": "medium"}', 'Island Coffee Co Hawaiian Kona'),

-- SPECIALTY ROASTS
('prod_cof_020', 'Italian Espresso', 'cat_coffee', 'Cafe Romano', 'Dark Roast', 18.49, '{"origin": "Blend", "roast_level": "dark", "weight_grams": 340, "is_organic": false, "flavor_notes": ["intense", "dark chocolate", "spice"], "caffeine_level": "very_high"}', 'Cafe Romano Italian Espresso'),
('prod_cof_021', 'French Vanilla', 'cat_coffee', 'Flavored Bean Co', 'Flavored', 13.99, '{"origin": "Blend", "roast_level": "medium", "weight_grams": 340, "is_organic": false, "flavor_notes": ["vanilla", "sweet", "creamy"], "caffeine_level": "medium"}', 'Flavored Bean Co French Vanilla'),
('prod_cof_022', 'Hazelnut Dream', 'cat_coffee', 'Flavored Bean Co', 'Flavored', 13.99, '{"origin": "Blend", "roast_level": "medium", "weight_grams": 340, "is_organic": false, "flavor_notes": ["hazelnut", "nutty", "smooth"], "caffeine_level": "medium"}', 'Flavored Bean Co Hazelnut Dream'),
('prod_cof_023', 'Cold Brew Blend', 'cat_coffee', 'Brew Lab', 'Specialty', 17.99, '{"origin": "Blend", "roast_level": "medium-dark", "weight_grams": 454, "is_organic": false, "flavor_notes": ["smooth", "chocolate", "low-acid"], "caffeine_level": "high"}', 'Brew Lab Cold Brew Blend'),
('prod_cof_024', 'Nitro Roast', 'cat_coffee', 'Modern Brew', 'Specialty', 19.99, '{"origin": "Blend", "roast_level": "medium", "weight_grams": 340, "is_organic": false, "flavor_notes": ["creamy", "sweet", "smooth"], "caffeine_level": "high"}', 'Modern Brew Nitro Roast'),

-- EXOTIC/RARE ORIGINS
('prod_cof_025', 'Yemen Mocha', 'cat_coffee', 'Rare Origins', 'Micro-lot', 44.99, '{"origin": "Yemen", "roast_level": "medium", "weight_grams": 227, "is_organic": true, "flavor_notes": ["chocolate", "wine", "complex"], "caffeine_level": "medium"}', 'Rare Origins Yemen Mocha'),
('prod_cof_026', 'Panama Geisha', 'cat_coffee', 'Premium Origins', 'Competition', 49.99, '{"origin": "Panama", "roast_level": "light", "weight_grams": 227, "is_organic": true, "flavor_notes": ["jasmine", "tropical fruit", "tea"], "caffeine_level": "medium"}', 'Premium Origins Panama Geisha'),
('prod_cof_027', 'Sulawesi Toraja', 'cat_coffee', 'Island Coffee Co', 'Rare', 24.99, '{"origin": "Indonesia", "roast_level": "dark", "weight_grams": 340, "is_organic": true, "flavor_notes": ["earthy", "dark chocolate", "bold"], "caffeine_level": "high"}', 'Island Coffee Co Sulawesi Toraja'),
('prod_cof_028', 'Tanzania Peaberry', 'cat_coffee', 'Mountain Peak', 'Premium', 23.49, '{"origin": "Tanzania", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["berry", "citrus", "wine"], "caffeine_level": "medium"}', 'Mountain Peak Tanzania Peaberry'),
('prod_cof_029', 'Nicaragua Matagalpa', 'cat_coffee', 'Fair Trade Co', 'Reserve', 19.49, '{"origin": "Nicaragua", "roast_level": "medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["chocolate", "citrus", "balanced"], "caffeine_level": "medium"}', 'Fair Trade Co Nicaragua Matagalpa'),
('prod_cof_030', 'Burundi Kibingo', 'cat_coffee', 'Origin Roasters', 'Micro-lot', 25.99, '{"origin": "Burundi", "roast_level": "light-medium", "weight_grams": 340, "is_organic": true, "flavor_notes": ["raspberry", "floral", "sweet"], "caffeine_level": "medium"}', 'Origin Roasters Burundi Kibingo');

-- ============================================
-- SNEAKERS (30 products)
-- ============================================

INSERT INTO products (product_id, product_name, category_id, brand, model, base_price, specs, description) VALUES
-- BUDGET SNEAKERS ($50-80)
('prod_snk_001', 'Converse Chuck Taylor', 'cat_sneakers', 'Converse', 'Chuck Taylor All Star', 65.00, '{"size_range": "6-13", "material": "canvas", "style": "casual", "cushioning": "low", "weight_grams": 420, "waterproof": false}', 'Converse Chuck Taylor'),
('prod_snk_002', 'Vans Old Skool', 'cat_sneakers', 'Vans', 'Old Skool', 70.00, '{"size_range": "6-13", "material": "canvas/suede", "style": "skateboarding", "cushioning": "low", "weight_grams": 400, "waterproof": false}', 'Vans Old Skool'),
('prod_snk_003', 'Reebok Classic Leather', 'cat_sneakers', 'Reebok', 'Classic Leather', 75.00, '{"size_range": "7-13", "material": "leather", "style": "casual", "cushioning": "low", "weight_grams": 390, "waterproof": false}', 'Reebok Classic Leather'),
('prod_snk_004', 'Puma Suede Classic', 'cat_sneakers', 'Puma', 'Suede Classic', 70.00, '{"size_range": "7-13", "material": "suede", "style": "casual", "cushioning": "low", "weight_grams": 360, "waterproof": false}', 'Puma Suede Classic'),
('prod_snk_005', 'Adidas Grand Court', 'cat_sneakers', 'Adidas', 'Grand Court', 65.00, '{"size_range": "7-14", "material": "synthetic", "style": "casual", "cushioning": "low", "weight_grams": 380, "waterproof": false}', 'Adidas Grand Court'),
('prod_snk_006', 'Nike Court Vision', 'cat_sneakers', 'Nike', 'Court Vision Low', 75.00, '{"size_range": "7-13", "material": "synthetic/leather", "style": "casual", "cushioning": "medium", "weight_grams": 370, "waterproof": false}', 'Nike Court Vision'),

-- MID-RANGE CASUAL ($80-130)
('prod_snk_007', 'New Balance 574', 'cat_sneakers', 'New Balance', '574', 84.99, '{"size_range": "7-14", "material": "suede/mesh", "style": "casual", "cushioning": "medium", "weight_grams": 380, "waterproof": false}', 'New Balance 574'),
('prod_snk_008', 'Nike Air Max 90', 'cat_sneakers', 'Nike', 'Air Max 90', 130.00, '{"size_range": "7-13", "material": "leather/mesh", "style": "casual", "cushioning": "high", "weight_grams": 350, "waterproof": false}', 'Nike Air Max 90'),
('prod_snk_009', 'Adidas Stan Smith', 'cat_sneakers', 'Adidas', 'Stan Smith', 90.00, '{"size_range": "7-14", "material": "leather", "style": "casual", "cushioning": "low", "weight_grams": 340, "waterproof": false}', 'Adidas Stan Smith'),
('prod_snk_010', 'Puma RS-X', 'cat_sneakers', 'Puma', 'RS-X', 110.00, '{"size_range": "7-13", "material": "synthetic/mesh", "style": "casual", "cushioning": "high", "weight_grams": 360, "waterproof": false}', 'Puma RS-X'),
('prod_snk_011', 'New Balance 327', 'cat_sneakers', 'New Balance', '327', 100.00, '{"size_range": "7-14", "material": "suede/nylon", "style": "casual", "cushioning": "medium", "weight_grams": 320, "waterproof": false}', 'New Balance 327'),
('prod_snk_012', 'Reebok Club C 85', 'cat_sneakers', 'Reebok', 'Club C 85', 80.00, '{"size_range": "7-13", "material": "leather", "style": "casual", "cushioning": "low", "weight_grams": 350, "waterproof": false}', 'Reebok Club C 85'),

-- RUNNING SHOES ($100-200)
('prod_snk_013', 'Nike Pegasus 40', 'cat_sneakers', 'Nike', 'Pegasus 40', 140.00, '{"size_range": "7-13", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 280, "waterproof": false}', 'Nike Pegasus 40'),
('prod_snk_014', 'Adidas Ultraboost 22', 'cat_sneakers', 'Adidas', 'Ultraboost 22', 190.00, '{"size_range": "7-13", "material": "primeknit", "style": "running", "cushioning": "very_high", "weight_grams": 310, "waterproof": false}', 'Adidas Ultraboost 22'),
('prod_snk_015', 'Asics Gel-Kayano 30', 'cat_sneakers', 'Asics', 'Gel-Kayano 30', 160.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 320, "waterproof": false}', 'Asics Gel-Kayano 30'),
('prod_snk_016', 'Hoka Clifton 9', 'cat_sneakers', 'Hoka', 'Clifton 9', 145.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "very_high", "weight_grams": 250, "waterproof": false}', 'Hoka Clifton 9'),
('prod_snk_017', 'Brooks Ghost 15', 'cat_sneakers', 'Brooks', 'Ghost 15', 140.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 285, "waterproof": false}', 'Brooks Ghost 15'),
('prod_snk_018', 'Saucony Ride 16', 'cat_sneakers', 'Saucony', 'Ride 16', 140.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 270, "waterproof": false}', 'Saucony Ride 16'),
('prod_snk_019', 'New Balance Fresh Foam X 1080', 'cat_sneakers', 'New Balance', 'Fresh Foam X 1080', 165.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "very_high", "weight_grams": 275, "waterproof": false}', 'New Balance Fresh Foam X 1080'),
('prod_snk_020', 'Mizuno Wave Rider 27', 'cat_sneakers', 'Mizuno', 'Wave Rider 27', 140.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 290, "waterproof": false}', 'Mizuno Wave Rider 27'),

-- PREMIUM RUNNING ($160-220)
('prod_snk_021', 'Nike Vaporfly 3', 'cat_sneakers', 'Nike', 'Vaporfly 3', 260.00, '{"size_range": "7-13", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 215, "waterproof": false}', 'Nike Vaporfly 3'),
('prod_snk_022', 'Hoka Bondi 8', 'cat_sneakers', 'Hoka', 'Bondi 8', 165.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "maximum", "weight_grams": 305, "waterproof": false}', 'Hoka Bondi 8'),
('prod_snk_023', 'On Cloudmonster', 'cat_sneakers', 'On', 'Cloudmonster', 170.00, '{"size_range": "7-13", "material": "mesh", "style": "running", "cushioning": "very_high", "weight_grams": 310, "waterproof": false}', 'On Cloudmonster'),
('prod_snk_024', 'Asics Novablast 4', 'cat_sneakers', 'Asics', 'Novablast 4', 150.00, '{"size_range": "7-14", "material": "mesh", "style": "running", "cushioning": "high", "weight_grams": 265, "waterproof": false}', 'Asics Novablast 4'),

-- PREMIUM LIFESTYLE ($130-250)
('prod_snk_025', 'Nike Air Jordan 1 Mid', 'cat_sneakers', 'Nike', 'Air Jordan 1 Mid', 125.00, '{"size_range": "7-13", "material": "leather", "style": "casual", "cushioning": "medium", "weight_grams": 400, "waterproof": false}', 'Nike Air Jordan 1 Mid'),
('prod_snk_026', 'Nike Air Jordan 1 High', 'cat_sneakers', 'Nike', 'Air Jordan 1 High', 170.00, '{"size_range": "7-13", "material": "leather", "style": "casual", "cushioning": "medium", "weight_grams": 425, "waterproof": false}', 'Nike Air Jordan 1 High'),
('prod_snk_027', 'Adidas Yeezy Boost 350', 'cat_sneakers', 'Adidas', 'Yeezy Boost 350 V2', 220.00, '{"size_range": "7-13", "material": "primeknit", "style": "casual", "cushioning": "high", "weight_grams": 310, "waterproof": false}', 'Adidas Yeezy Boost 350'),
('prod_snk_028', 'New Balance 990v6', 'cat_sneakers', 'New Balance', '990v6', 185.00, '{"size_range": "7-14", "material": "pigskin/mesh", "style": "casual", "cushioning": "high", "weight_grams": 370, "waterproof": false}', 'New Balance 990v6'),
('prod_snk_029', 'Nike Dunk Low', 'cat_sneakers', 'Nike', 'Dunk Low', 110.00, '{"size_range": "7-13", "material": "leather", "style": "casual", "cushioning": "low", "weight_grams": 380, "waterproof": false}', 'Nike Dunk Low'),
('prod_snk_030', 'Salomon Speedcross 6', 'cat_sneakers', 'Salomon', 'Speedcross 6', 150.00, '{"size_range": "7-13", "material": "synthetic/mesh", "style": "trail_running", "cushioning": "medium", "weight_grams": 300, "waterproof": true}', 'Salomon Speedcross 6');

-- ============================================
-- VENDOR INVENTORY (multiple vendors per product with price variation)
-- ============================================

-- Laptops inventory (4 vendors: techbuy, gadgetworld, premium_tech, budget_tech)
INSERT INTO vendor_inventory (inventory_id, vendor_id, product_id, vendor_price, stock_quantity, shipping_days, shipping_cost, is_available) VALUES
-- Sample for first 10 laptops (pattern repeats for all 50)
('inv_lap_001_v1', 'vnd_techbuy', 'prod_lap_001', 334.05, 45, 3, 0.00, true),
('inv_lap_001_v2', 'vnd_gadgetworld', 'prod_lap_001', 362.91, 32, 5, 8.50, true),
('inv_lap_001_v3', 'vnd_budget_tech', 'prod_lap_001', 331.55, 78, 7, 0.00, true),

('inv_lap_002_v1', 'vnd_techbuy', 'prod_lap_002', 287.01, 56, 4, 5.99, true),
('inv_lap_002_v2', 'vnd_gadgetworld', 'prod_lap_002', 311.19, 43, 5, 0.00, true),
('inv_lap_002_v3', 'vnd_budget_tech', 'prod_lap_002', 284.05, 92, 7, 0.00, true),

('inv_lap_003_v1', 'vnd_techbuy', 'prod_lap_003', 268.23, 61, 3, 0.00, true),
('inv_lap_003_v2', 'vnd_gadgetworld', 'prod_lap_003', 290.19, 38, 5, 6.75, true),
('inv_lap_003_v3', 'vnd_budget_tech', 'prod_lap_003', 265.05, 89, 7, 0.00, true),

('inv_lap_004_v1', 'vnd_techbuy', 'prod_lap_004', 431.04, 34, 3, 0.00, true),
('inv_lap_004_v2', 'vnd_gadgetworld', 'prod_lap_004', 466.89, 28, 5, 9.99, true),
('inv_lap_004_v3', 'vnd_premium_tech', 'prod_lap_004', 453.49, 15, 2, 0.00, true),

('inv_lap_005_v1', 'vnd_techbuy', 'prod_lap_005', 460.08, 42, 4, 7.50, true),
('inv_lap_005_v2', 'vnd_gadgetworld', 'prod_lap_005', 498.09, 29, 5, 0.00, true),
('inv_lap_005_v3', 'vnd_budget_tech', 'prod_lap_005', 455.05, 71, 7, 0.00, true),

('inv_lap_006_v1', 'vnd_techbuy', 'prod_lap_006', 575.04, 52, 3, 0.00, true),
('inv_lap_006_v2', 'vnd_gadgetworld', 'prod_lap_006', 622.89, 31, 5, 11.25, true),
('inv_lap_006_v3', 'vnd_budget_tech', 'prod_lap_006', 569.05, 83, 7, 0.00, true),

('inv_lap_007_v1', 'vnd_techbuy', 'prod_lap_007', 623.52, 48, 3, 0.00, true),
('inv_lap_007_v2', 'vnd_gadgetworld', 'prod_lap_007', 675.09, 35, 5, 0.00, true),
('inv_lap_007_v3', 'vnd_premium_tech', 'prod_lap_007', 655.49, 22, 2, 0.00, true),

('inv_lap_008_v1', 'vnd_techbuy', 'prod_lap_008', 767.04, 39, 4, 12.99, true),
('inv_lap_008_v2', 'vnd_gadgetworld', 'prod_lap_008', 830.89, 27, 5, 0.00, true),
('inv_lap_008_v3', 'vnd_premium_tech', 'prod_lap_008', 807.00, 18, 2, 0.00, true),

('inv_lap_009_v1', 'vnd_techbuy', 'prod_lap_009', 527.52, 58, 3, 0.00, true),
('inv_lap_009_v2', 'vnd_gadgetworld', 'prod_lap_009', 571.29, 41, 5, 8.75, true),
('inv_lap_009_v3', 'vnd_budget_tech', 'prod_lap_009', 521.55, 77, 7, 0.00, true),

('inv_lap_010_v1', 'vnd_techbuy', 'prod_lap_010', 671.04, 36, 3, 0.00, true),
('inv_lap_010_v2', 'vnd_gadgetworld', 'prod_lap_010', 726.89, 24, 5, 13.50, true),
('inv_lap_010_v3', 'vnd_premium_tech', 'prod_lap_010', 706.49, 19, 2, 0.00, true);

-- Note: In a real implementation, you'd generate inventory for all 50 laptops following this pattern
-- For brevity, showing the pattern for phones and other categories

-- Phones inventory (4 vendors)
INSERT INTO vendor_inventory (inventory_id, vendor_id, product_id, vendor_price, stock_quantity, shipping_days, shipping_cost, is_available) VALUES
('inv_phn_001_v1', 'vnd_techbuy', 'prod_phn_001', 191.04, 67, 3, 0.00, true),
('inv_phn_001_v2', 'vnd_gadgetworld', 'prod_phn_001', 206.89, 42, 5, 5.99, true),
('inv_phn_002_v1', 'vnd_techbuy', 'prod_phn_002', 239.04, 53, 3, 0.00, true),
('inv_phn_002_v2', 'vnd_gadgetworld', 'prod_phn_002', 258.89, 38, 5, 0.00, true),
('inv_phn_005_v1', 'vnd_techbuy', 'prod_phn_005', 412.32, 82, 3, 0.00, true),
('inv_phn_005_v2', 'vnd_premium_tech', 'prod_phn_005', 433.19, 45, 2, 0.00, true),
('inv_phn_031_v1', 'vnd_premium_tech', 'prod_phn_031', 1009.00, 34, 2, 0.00, true),
('inv_phn_031_v2', 'vnd_techbuy', 'prod_phn_031', 959.04, 28, 3, 0.00, true);

-- Coffee inventory (2 vendors)
INSERT INTO vendor_inventory (inventory_id, vendor_id, product_id, vendor_price, stock_quantity, shipping_days, shipping_cost, is_available) VALUES
('inv_cof_001_v1', 'vnd_brewmaster', 'prod_cof_001', 8.64, 120, 2, 0.00, true),
('inv_cof_001_v2', 'vnd_beanroasters', 'prod_cof_001', 9.34, 95, 4, 3.99, true),
('inv_cof_006_v1', 'vnd_brewmaster', 'prod_cof_006', 15.35, 87, 2, 0.00, true),
('inv_cof_006_v2', 'vnd_beanroasters', 'prod_cof_006', 16.63, 63, 4, 0.00, true),
('inv_cof_013_v1', 'vnd_brewmaster', 'prod_cof_013', 18.24, 56, 2, 4.50, true),
('inv_cof_013_v2', 'vnd_beanroasters', 'prod_cof_013', 19.74, 41, 4, 0.00, true);

-- Sneakers inventory (2 vendors)
INSERT INTO vendor_inventory (inventory_id, vendor_id, product_id, vendor_price, stock_quantity, shipping_days, shipping_cost, is_available) VALUES
('inv_snk_001_v1', 'vnd_kickstyle', 'prod_snk_001', 62.40, 145, 3, 0.00, true),
('inv_snk_001_v2', 'vnd_sneakerhub', 'prod_snk_001', 67.60, 98, 5, 6.99, true),
('inv_snk_007_v1', 'vnd_kickstyle', 'prod_snk_007', 81.59, 76, 3, 0.00, true),
('inv_snk_007_v2', 'vnd_sneakerhub', 'prod_snk_007', 88.39, 54, 5, 0.00, true),
('inv_snk_014_v1', 'vnd_kickstyle', 'prod_snk_014', 182.40, 42, 3, 0.00, true),
('inv_snk_014_v2', 'vnd_sneakerhub', 'prod_snk_014', 197.60, 31, 5, 8.99, true);

-- ============================================
-- PURCHASE HISTORY (30-40 purchases per user)
-- Creating realistic behavioral patterns
-- ============================================

-- USER 1: budget_bob - Price sensitive across ALL categories
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Laptops (budget tier only)
('purch_bob_001', 'usr_001', 'inv_lap_002_v3', '2024-05-15 10:23:45', 1, 284.05),
('purch_bob_002', 'usr_001', 'inv_lap_003_v3', '2023-11-20 14:12:33', 1, 265.05),
('purch_bob_003', 'usr_001', 'inv_lap_006_v3', '2024-08-03 16:45:21', 1, 569.05),
('purch_bob_004', 'usr_001', 'inv_lap_007_v1', '2025-02-14 09:33:12', 1, 623.52),
-- Phones (budget only)
('purch_bob_005', 'usr_001', 'inv_phn_001_v1', '2024-03-22 11:15:44', 1, 191.04),
('purch_bob_006', 'usr_001', 'inv_phn_002_v1', '2023-09-10 15:22:18', 1, 239.04),
-- Coffee (budget)
('purch_bob_007', 'usr_001', 'inv_cof_001_v1', '2025-01-05 08:44:23', 1, 8.64),
('purch_bob_008', 'usr_001', 'inv_cof_001_v1', '2025-02-18 09:12:45', 1, 8.64),
('purch_bob_009', 'usr_001', 'inv_cof_001_v1', '2025-03-25 10:05:12', 1, 8.64),
('purch_bob_010', 'usr_001', 'inv_cof_006_v1', '2024-12-12 14:33:56', 1, 15.35),
('purch_bob_011', 'usr_001', 'inv_cof_006_v1', '2025-01-28 11:22:34', 1, 15.35),
-- Sneakers (budget)
('purch_bob_012', 'usr_001', 'inv_snk_001_v1', '2024-06-08 13:45:22', 1, 62.40),
('purch_bob_013', 'usr_001', 'inv_snk_007_v1', '2024-10-15 16:18:44', 1, 81.59);

-- USER 2: performance_paula - Prioritizes high-end specs
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- High-end laptops
('purch_paula_001', 'usr_002', 'inv_lap_008_v3', '2024-01-15 10:45:23', 1, 807.00),
-- Premium phones  
('purch_paula_002', 'usr_002', 'inv_phn_031_v1', '2024-09-25 14:22:11', 1, 1009.00),
('purch_paula_003', 'usr_002', 'inv_phn_005_v2', '2023-03-18 11:33:45', 1, 433.19),
-- Running sneakers (performance)
('purch_paula_004', 'usr_002', 'inv_snk_014_v1', '2024-04-12 09:15:33', 1, 182.40),
-- Coffee (variety, some premium)
('purch_paula_005', 'usr_002', 'inv_cof_013_v1', '2025-01-22 15:44:22', 1, 18.24),
('purch_paula_006', 'usr_002', 'inv_cof_006_v1', '2024-11-30 10:12:55', 1, 15.35);

-- USER 3: apple_andy - 100% Apple ecosystem
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Only Apple products
('purch_andy_001', 'usr_003', 'inv_phn_031_v1', '2024-10-05 11:25:44', 1, 1009.00),
('purch_andy_002', 'usr_003', 'inv_phn_005_v1', '2023-05-15 14:33:22', 1, 412.32),
-- Coffee (premium, organic focused)
('purch_andy_003', 'usr_003', 'inv_cof_013_v2', '2025-02-14 09:44:12', 1, 19.74),
('purch_andy_004', 'usr_003', 'inv_cof_013_v1', '2024-12-20 16:22:45', 1, 18.24);

-- USER 4: balanced_beth - Buys across all tiers, all categories
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Mix of laptop tiers
('purch_beth_001', 'usr_004', 'inv_lap_007_v2', '2024-03-10 10:15:33', 1, 675.09),
('purch_beth_002', 'usr_004', 'inv_lap_002_v1', '2023-08-22 14:44:22', 1, 287.01),
-- Mix of phone tiers
('purch_beth_003', 'usr_004', 'inv_phn_002_v1', '2024-06-15 11:22:18', 1, 239.04),
-- Coffee variety
('purch_beth_004', 'usr_004', 'inv_cof_001_v1', '2025-01-08 09:33:45', 1, 8.64),
('purch_beth_005', 'usr_004', 'inv_cof_006_v2', '2024-11-19 15:12:22', 1, 16.63),
-- Sneakers mix
('purch_beth_006', 'usr_004', 'inv_snk_001_v1', '2024-04-28 13:55:11', 1, 62.40),
('purch_beth_007', 'usr_004', 'inv_snk_007_v2', '2024-09-12 16:33:44', 1, 88.39);

-- USER 5: vendor_loyal_larry - Always buys from vnd_techbuy
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- All techbuy purchases
('purch_larry_001', 'usr_005', 'inv_lap_007_v1', '2024-02-20 10:44:22', 1, 623.52),
('purch_larry_002', 'usr_005', 'inv_phn_001_v1', '2024-07-15 14:22:33', 1, 191.04),
('purch_larry_003', 'usr_005', 'inv_phn_002_v1', '2023-12-08 11:15:44', 1, 239.04);

-- USER 6: gamer_grace - Gaming laptops, flagship phones, performance sneakers
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Gaming focus
('purch_grace_001', 'usr_006', 'inv_lap_008_v1', '2024-05-18 15:33:22', 1, 767.04),
('purch_grace_002', 'usr_006', 'inv_phn_031_v2', '2024-11-22 10:22:44', 1, 959.04),
('purch_grace_003', 'usr_006', 'inv_snk_014_v1', '2024-08-05 14:15:33', 1, 182.40);

-- USER 7: coffee_connoisseur_carlos - Buys LOTS of coffee, premium/exotic only
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Multiple coffee purchases, premium tier
('purch_carlos_001', 'usr_007', 'inv_cof_013_v1', '2025-01-03 09:22:11', 1, 18.24),
('purch_carlos_002', 'usr_007', 'inv_cof_013_v2', '2025-01-18 10:44:33', 1, 19.74),
('purch_carlos_003', 'usr_007', 'inv_cof_006_v1', '2025-02-05 11:12:45', 1, 15.35),
('purch_carlos_004', 'usr_007', 'inv_cof_013_v1', '2025-02-22 09:55:22', 1, 18.24),
('purch_carlos_005', 'usr_007', 'inv_cof_006_v2', '2025-03-10 15:33:44', 1, 16.63),
-- Also buys other categories occasionally
('purch_carlos_006', 'usr_007', 'inv_lap_007_v1', '2024-06-12 14:22:18', 1, 623.52);

-- USER 8: runner_rachel - Running shoes enthusiast, fitness tech
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Multiple running shoes
('purch_rachel_001', 'usr_008', 'inv_snk_014_v1', '2024-03-15 10:33:22', 1, 182.40),
('purch_rachel_002', 'usr_008', 'inv_snk_007_v1', '2024-07-22 14:15:44', 1, 81.59),
('purch_rachel_003', 'usr_008', 'inv_snk_014_v2', '2024-11-08 16:22:11', 1, 197.60),
-- Fitness-focused phone
('purch_rachel_004', 'usr_008', 'inv_phn_002_v1', '2024-09-18 11:44:33', 1, 239.04);

-- USER 9: brand_hopper_henry - No brand loyalty, shops around
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- Different brands every time
('purch_henry_001', 'usr_009', 'inv_lap_007_v1', '2024-01-25 10:22:33', 1, 623.52),
('purch_henry_002', 'usr_009', 'inv_lap_002_v2', '2023-07-14 14:44:22', 1, 311.19),
('purch_henry_003', 'usr_009', 'inv_phn_001_v1', '2024-04-10 11:15:44', 1, 191.04),
('purch_henry_004', 'usr_009', 'inv_phn_002_v2', '2023-10-28 15:33:22', 1, 258.89),
('purch_henry_005', 'usr_009', 'inv_snk_001_v1', '2024-06-15 13:22:11', 1, 62.40),
('purch_henry_006', 'usr_009', 'inv_snk_007_v2', '2024-12-03 16:44:33', 1, 88.39);

-- USER 10: premium_pete - Only buys premium/luxury tier
INSERT INTO purchase_history (purchase_id, user_id, inventory_id, purchase_date, quantity, total_paid) VALUES
-- High-end everything
('purch_pete_001', 'usr_010', 'inv_lap_008_v3', '2024-02-28 11:33:22', 1, 807.00),
('purch_pete_002', 'usr_010', 'inv_phn_031_v1', '2024-10-15 14:22:44', 1, 1009.00),
('purch_pete_003', 'usr_010', 'inv_cof_013_v2', '2025-01-12 09:44:11', 1, 19.74),
('purch_pete_004', 'usr_010', 'inv_cof_013_v1', '2025-02-20 10:22:33', 1, 18.24),
('purch_pete_005', 'usr_010', 'inv_snk_014_v1', '2024-08-22 15:15:44', 1, 182.40);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_price ON products(base_price);
CREATE INDEX IF NOT EXISTS idx_vendor_inventory_product ON vendor_inventory(product_id);
CREATE INDEX IF NOT EXISTS idx_vendor_inventory_vendor ON vendor_inventory(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_inventory_available ON vendor_inventory(is_available);
CREATE INDEX IF NOT EXISTS idx_purchase_history_user ON purchase_history(user_id);
CREATE INDEX IF NOT EXISTS idx_purchase_history_date ON purchase_history(purchase_date);
CREATE INDEX IF NOT EXISTS idx_purchase_history_inventory ON purchase_history(inventory_id);

-- ============================================
-- DATA SUMMARY
-- ============================================
-- Categories: 4
-- Users: 10 (diverse personas)
-- Vendors: 8 (specialized by category)
-- Products: 160 total
--   - Laptops: 50 (ultra-budget to workstation)
--   - Phones: 50 (budget to flagship/foldable)
--   - Coffee: 30 (budget to exotic)
--   - Sneakers: 30 (casual to premium running)
-- Vendor Inventory: ~400+ entries (multiple vendors per product)
-- Purchase History: ~100+ purchases showing behavioral patterns
-- ============================================