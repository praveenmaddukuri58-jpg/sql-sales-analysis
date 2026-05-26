-- ============================================
-- SALES TREND ANALYSIS
-- Sample Database Setup
-- Author: venkata praveen maddukuri
-- ============================================

-- Create tables
CREATE TABLE IF NOT EXISTS products (
    product_id   INTEGER PRIMARY KEY,
    product_name TEXT,
    category     TEXT,
    unit_price   REAL
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id   INTEGER PRIMARY KEY,
    customer_name TEXT,
    segment       TEXT,
    region        TEXT
);

CREATE TABLE IF NOT EXISTS orders (
    order_id    INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date  TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    item_id    INTEGER PRIMARY KEY,
    order_id   INTEGER,
    product_id INTEGER,
    quantity   INTEGER,
    unit_price REAL,
    FOREIGN KEY (order_id)    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

-- ============================================
-- SEED DATA
-- ============================================

INSERT INTO products VALUES
(1,  'Laptop Pro 15',     'Electronics',  1200.00),
(2,  'Wireless Mouse',    'Electronics',    45.00),
(3,  'Standing Desk',     'Furniture',     650.00),
(4,  'Office Chair',      'Furniture',     420.00),
(5,  'Monitor 27"',       'Electronics',   380.00),
(6,  'Notebook Pack',     'Stationery',     18.00),
(7,  'Printer Ink Set',   'Stationery',     35.00),
(8,  'USB Hub',           'Electronics',    55.00),
(9,  'Desk Lamp',         'Furniture',      75.00),
(10, 'Keyboard Wireless', 'Electronics',    95.00);

INSERT INTO customers VALUES
(1,  'Acme Corp',         'B2B',    'Southeast'),
(2,  'Jane Smith',        'Retail', 'Northeast'),
(3,  'TechStart LLC',     'B2B',    'West'),
(4,  'Bob Johnson',       'Retail', 'Southeast'),
(5,  'MegaRetail Inc',    'B2B',    'Midwest'),
(6,  'Sara Lee',          'Retail', 'West'),
(7,  'Gulf Solutions',    'B2B',    'Southeast'),
(8,  'Mike Torres',       'Retail', 'Northeast'),
(9,  'Bright Ideas Co',   'B2B',    'Midwest'),
(10, 'Linda Park',        'Retail', 'West');

INSERT INTO orders VALUES
(1,  1,  '2024-01-15', 2400.00),
(2,  2,  '2024-01-22',   90.00),
(3,  3,  '2024-02-03', 1200.00),
(4,  4,  '2024-02-18',  420.00),
(5,  5,  '2024-03-05', 3250.00),
(6,  6,  '2024-03-19',  380.00),
(7,  1,  '2024-04-02', 1650.00),
(8,  7,  '2024-04-25',  820.00),
(9,  8,  '2024-05-10',   45.00),
(10, 9,  '2024-05-28', 2100.00),
(11, 2,  '2024-06-06',  475.00),
(12, 10, '2024-06-20',  150.00),
(13, 3,  '2024-07-08', 4800.00),
(14, 5,  '2024-07-22', 1300.00),
(15, 1,  '2024-08-01', 2950.00),
(16, 6,  '2024-08-15',   95.00),
(17, 4,  '2024-09-03',  650.00),
(18, 9,  '2024-09-17', 1800.00),
(19, 7,  '2024-10-04', 3400.00),
(20, 2,  '2024-10-29',  380.00),
(21, 8,  '2024-11-11',  120.00),
(22, 10, '2024-11-25', 2600.00),
(23, 1,  '2024-12-02', 5100.00),
(24, 3,  '2024-12-15', 4200.00),
(25, 5,  '2024-12-28', 3800.00);

INSERT INTO order_items VALUES
(1,  1,  1, 2, 1200.00),
(2,  2,  2, 2,   45.00),
(3,  3,  1, 1, 1200.00),
(4,  4,  4, 1,  420.00),
(5,  5,  3, 5,  650.00),
(6,  6,  5, 1,  380.00),
(7,  7,  3, 2,  650.00),
(8,  7,  9, 1,   75.00),
(9,  8,  4, 1,  420.00),
(10, 8,  9, 2,   75.00),
(11, 9,  2, 1,   45.00),
(12, 10, 1, 1, 1200.00),
(13, 10, 5, 1,  380.00),
(14, 11, 8, 3,   55.00),
(15, 11, 2, 2,   45.00),
(16, 12, 6, 5,   18.00),
(17, 12, 7, 2,   35.00),
(18, 13, 1, 4, 1200.00),
(19, 14, 3, 2,  650.00),
(20, 15, 1, 2, 1200.00),
(21, 15, 10,1,   95.00),
(22, 16, 10,1,   95.00),
(23, 17, 3, 1,  650.00),
(24, 18, 5, 2,  380.00),
(25, 18, 8, 2,   55.00),
(26, 19, 1, 2, 1200.00),
(27, 19, 5, 1,  380.00),
(28, 20, 5, 1,  380.00),
(29, 21, 6, 4,   18.00),
(30, 21, 7, 2,   35.00),
(31, 22, 1, 2, 1200.00),
(32, 23, 1, 4, 1200.00),
(33, 23, 3, 1,  650.00),
(34, 24, 1, 3, 1200.00),
(35, 24, 4, 1,  420.00),
(36, 25, 3, 4,  650.00),
(37, 25, 5, 2,  380.00);
