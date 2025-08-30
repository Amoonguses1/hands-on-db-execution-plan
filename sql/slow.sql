-- Set the optimizer to only use Nested Loop Join
SET enable_mergejoin = off;
SET enable_hashjoin = off;
SET enable_nestloop = on;
SET enable_indexscan = off;
SET enable_bitmapscan = off;

-- Analyze the query plan for a slow query
SELECT
    c.customer_name,
    o.order_date
FROM
    Orders AS o
JOIN
    Customers AS c ON o.customer_id = c.customer_id
ORDER BY
    o.order_date;

-- Reset the optimizer settings to default for subsequent queries
RESET enable_mergejoin;
RESET enable_hashjoin;
RESET enable_nestloop;
RESET enable_indexscan;
RESET enable_bitmapscan;
