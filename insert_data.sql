INSERT INTO customers VALUES (1, 'Ola', 'Norway');
INSERT INTO customers VALUES (2, 'Kari', 'Norway');
INSERT INTO customers VALUES (3, 'Emma', 'Sweden');
INSERT INTO customers VALUES (4, 'Ali', 'Denmark');
INSERT INTO customers VALUES (5, 'Per', 'Norway');

INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 900);
INSERT INTO products VALUES (2, 'Headphones', 'Electronics', 120);
INSERT INTO products VALUES (3, 'Coffee Machine', 'Home', 250);
INSERT INTO products VALUES (4, 'Office Chair', 'Furniture', 300);
INSERT INTO products VALUES (5, 'Notebook', 'Office', 20);
INSERT INTO products VALUES (6, 'Desk Lamp', 'Furniture', 80);

INSERT INTO orders VALUES (1, 1, '2024-01-05');
INSERT INTO orders VALUES (2, 1, '2024-01-12');
INSERT INTO orders VALUES (3, 2, '2024-01-15');
INSERT INTO orders VALUES (4, 3, '2024-01-20');
INSERT INTO orders VALUES (5, 4, '2024-02-01');
INSERT INTO orders VALUES (6, 4, '2024-02-10');
INSERT INTO orders VALUES (7, 5, '2024-02-15');

INSERT INTO order_items VALUES (1, 1, 1, 1);
INSERT INTO order_items VALUES (2, 1, 2, 1);
INSERT INTO order_items VALUES (3, 2, 5, 3);
INSERT INTO order_items VALUES (4, 3, 3, 1);
INSERT INTO order_items VALUES (5, 4, 4, 1);
INSERT INTO order_items VALUES (6, 5, 2, 2);
INSERT INTO order_items VALUES (7, 6, 6, 1);
INSERT INTO order_items VALUES (8, 7, 5, 5);
