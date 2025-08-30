-- Insert data into the Customers table (10,000 rows)
INSERT INTO Customers (customer_id, customer_name, email)
SELECT
id,
'user' || id,
'user' || id || '@gmail.com'
FROM
generate_series(1, 10000) AS id;

-- Insert data into the Products table (20,000 rows)
INSERT INTO Products (product_id, product_name, price)
SELECT
id,
'item_' || id,
(id % 10) + 100
FROM
generate_series(1, 20000) AS id;

-- Insert data into the Shippers table (10 row)
INSERT INTO Shippers (shipping_id, shipper_name)
SELECT
id,
'shipper_' || id
FROM
generate_series(1, 10) AS id;

-- Inserting data into the Orders table
-- Creating 100,000 order records
INSERT INTO Orders (order_id, customer_id, order_date, shipping_id)
SELECT
id,
FLOOR(RANDOM() * 10000) + 1 AS customer_id, -- Randomly select customer_id from 1-1000
CURRENT_DATE - (FLOOR(RANDOM() * 365) || ' days')::INTERVAL, -- A random date from the last year
FLOOR(RANDOM() * 10) + 1 AS shipping_id -- Randomly select shipping_id from 1-10
FROM
generate_series(1, 100000) AS id;

-- Inserting data into the Order_Items table
-- Creating 300,000 product records
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity)
SELECT
id,
FLOOR(RANDOM() * 100000) + 1 AS order_id, -- Randomly select order_id from 1-10000
FLOOR(RANDOM() * 20000) + 1 AS product_id, -- Randomly select product_id from 1-2000
FLOOR(RANDOM() * 5) + 1 AS quantity -- Random quantity between 1 and 5
FROM
generate_series(1, 300000) AS id;

-- Inserting data into the Reviews table
-- Creating 300 review records for products that were actually purchased by customers
WITH purchased_items AS (
-- Join Orders and Order_Items to get valid customer-product pairs
SELECT
o.customer_id,
oi.product_id
FROM
Orders AS o
JOIN
Order_Items AS oi ON o.order_id = oi.order_id
),
random_reviews AS (
-- Select 1000 random purchased customer-product pairs
SELECT
customer_id,
product_id,
ROW_NUMBER() OVER (ORDER BY RANDOM()) as row_num
FROM
purchased_items
LIMIT 1000
)
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_text)
SELECT
rr.row_num,
rr.product_id,
rr.customer_id,
FLOOR(RANDOM() * 5) + 1 AS rating, -- Random rating between 1 and 5
'This is a randomly generated review text ' || rr.row_num AS review_text
FROM
random_reviews AS rr;
