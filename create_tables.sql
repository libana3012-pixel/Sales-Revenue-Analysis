CREATE TABLE customers (id INTEGER,
    name TEXT,
    country TEXT);

CREATE TABLE products (id INTEGER,
    product_name TEXT,
    category TEXT,
    price INTEGER);

CREATE TABLE orders (id INTEGER,
    customer_id INTEGER,
    order_date TEXT);

CREATE TABLE order_items (id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER);
