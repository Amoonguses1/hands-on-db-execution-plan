SET geqo_threshold = 2;

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
    Orders AS o,
    Customers AS c,
    Order_Items AS oi,
    Products AS p,
    Shippers AS s,
    Reviews AS r
WHERE
    o.customer_id = c.customer_id AND
    oi.order_id = o.order_id AND
    p.product_id = oi.product_id AND
    s.shipping_id = o.shipping_id AND
    (p.product_id = r.product_id AND c.customer_id = r.customer_id OR r.review_id IS NULL);
