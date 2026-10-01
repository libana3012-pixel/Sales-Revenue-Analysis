-- Revenue case study | synthetic retail transactions, March-June 2026
-- Run on a fresh SQLite database: sqlite3 revenue.db < case-study/schema-and-data.sql
PRAGMA foreign_keys = ON;
CREATE TABLE customers (customer_id TEXT PRIMARY KEY, customer_name TEXT NOT NULL, market TEXT NOT NULL);
CREATE TABLE products (product_id TEXT PRIMARY KEY, product_name TEXT NOT NULL, category TEXT NOT NULL);
CREATE TABLE orders (order_id TEXT PRIMARY KEY, customer_id TEXT NOT NULL REFERENCES customers(customer_id), order_date TEXT NOT NULL, acquisition_channel TEXT NOT NULL);
CREATE TABLE order_items (order_id TEXT NOT NULL REFERENCES orders(order_id), product_id TEXT NOT NULL REFERENCES products(product_id), quantity INTEGER NOT NULL CHECK(quantity > 0), unit_price NUMERIC NOT NULL CHECK(unit_price >= 0), PRIMARY KEY(order_id, product_id));
INSERT INTO customers VALUES
('C001','Customer 01','NO'),('C002','Customer 02','NO'),('C003','Customer 03','SE'),('C004','Customer 04','NO'),
('C005','Customer 05','DK'),('C006','Customer 06','SE'),('C007','Customer 07','NO'),('C008','Customer 08','DK');
INSERT INTO products VALUES
('P01','Desk lamp','Home'),('P02','Notebook set','Office'),('P03','Reusable bottle','Lifestyle'),
('P04','Table light','Home'),('P05','Pen bundle','Office'),('P06','Canvas tote','Lifestyle');
INSERT INTO orders VALUES
('O001','C001','2026-03-03','online'),('O002','C002','2026-03-08','organic'),('O003','C003','2026-03-13','online'),
('O004','C001','2026-04-04','email'),('O005','C004','2026-04-12','online'),('O006','C005','2026-04-19','organic'),
('O007','C002','2026-05-03','email'),('O008','C006','2026-05-11','online'),('O009','C003','2026-05-20','organic'),
('O010','C001','2026-06-06','email'),('O011','C004','2026-06-15','online'),('O012','C007','2026-06-22','organic');
INSERT INTO order_items VALUES
('O001','P01',1,120),('O001','P03',2,35),('O002','P02',1,85),('O003','P04',1,160),('O003','P06',1,25),
('O004','P01',2,120),('O005','P05',1,60),('O005','P03',1,35),('O006','P02',2,85),('O007','P04',1,160),
('O008','P01',1,120),('O008','P06',2,25),('O009','P05',2,60),('O010','P03',3,35),('O010','P02',1,85),
('O011','P04',1,160),('O011','P05',1,60),('O012','P06',3,25),('O012','P01',1,120);
