-- Baseline categories
INSERT INTO inventory.category (name, description, created_by) VALUES
  ('Electronics',   'Smartphones, laptops, accessories',    'system'),
  ('Clothing',      'Apparel for all ages',                 'system'),
  ('Home & Garden', 'Furniture, decor, outdoor',            'system'),
  ('Books',         'Fiction, non-fiction, textbooks',      'system'),
  ('Sports',        'Equipment, footwear, nutrition',       'system');

-- Baseline products (10 per category via a single block)
INSERT INTO inventory.product (name, description, price, category_id, created_by)
SELECT p.name, p.description, p.price, c.id, 'system'
FROM (VALUES
  ('Smartphone XS',       'High-end mobile phone',          1299999, 'Electronics'),
  ('Wireless Earbuds',    'Noise-cancelling earbuds',        299999,  'Electronics'),
  ('Laptop Pro 15',       '15" ultrabook, 16 GB RAM',       3499999, 'Electronics'),
  ('USB-C Hub 7-in-1',    'Multi-port hub for laptops',      89999,  'Electronics'),
  ('Smart Watch',         'Fitness & notifications',         499999,  'Electronics'),
  ('Classic Tee',         '100% cotton t-shirt',             35000,  'Clothing'),
  ('Running Shorts',      'Breathable sports shorts',        55000,  'Clothing'),
  ('Denim Jacket',        'Casual denim jacket',            150000,  'Clothing'),
  ('Yoga Pants',          'Stretch fabric, 4-way flex',      80000,  'Clothing'),
  ('Winter Coat',         'Waterproof insulated coat',      320000,  'Clothing'),
  ('Desk Lamp LED',       'Adjustable brightness lamp',      75000,  'Home & Garden'),
  ('Ceramic Pot Set',     '3-piece pot set',                 45000,  'Home & Garden'),
  ('Garden Hose 20m',     'Expandable garden hose',          60000,  'Home & Garden'),
  ('Throw Pillow',        'Decorative 50x50 cm pillow',      28000,  'Home & Garden'),
  ('Bookshelf 5-tier',    'Wood & metal bookshelf',         250000,  'Home & Garden'),
  ('Clean Code',          'By Robert C. Martin',             65000,  'Books'),
  ('The Pragmatic Prog.', 'By Hunt & Thomas',                70000,  'Books'),
  ('Design Patterns',     'GoF classic',                     80000,  'Books'),
  ('SQL in 10 Minutes',   'Ben Forta guide',                 45000,  'Books'),
  ('DDIA',                'Designing Data-Intensive Apps',   95000,  'Books'),
  ('Yoga Mat 6mm',        'Anti-slip exercise mat',          55000,  'Sports'),
  ('Resistance Bands',    'Set of 5 bands',                  35000,  'Sports'),
  ('Running Shoes',       'Lightweight trail shoes',        280000,  'Sports'),
  ('Protein Powder 1kg',  'Whey isolate vanilla',           120000,  'Sports'),
  ('Water Bottle 1L',     'BPA-free stainless steel',        42000,  'Sports')
) AS p(name, description, price, cat_name)
JOIN inventory.category c ON c.name = p.cat_name;

-- Inventory stock for each product
INSERT INTO inventory.inventory (product_id, quantity, created_by)
SELECT id, (RANDOM() * 500 + 50)::INT, 'system'
FROM inventory.product;
