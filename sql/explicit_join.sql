SELECT
    c.customer_name,
    c.email,
    o.order_date,
    p.product_name,
    p.price,
    oi.quantity,
    s.shipper_name,
    r.rating,
    r.review_text
FROM
    Orders AS o
JOIN
    Customers AS c ON o.customer_id = c.customer_id
JOIN
    Order_Items AS oi ON o.order_id = oi.order_id
JOIN
    Products AS p ON oi.product_id = p.product_id
JOIN
    Shippers AS s ON o.shipping_id = s.shipping_id
LEFT JOIN
    Reviews AS r ON p.product_id = r.product_id AND c.customer_id = r.customer_id;
