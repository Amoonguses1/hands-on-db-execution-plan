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
