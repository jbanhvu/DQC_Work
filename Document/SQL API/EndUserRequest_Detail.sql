SELECT o.id,o.created_at,o.status,
SUM(CASE WHEN oi.product_id=0 THEN oi.price*oi.quantity ELSE 0 END)   AS amount_servive  ,
SUM(CASE WHEN oi.product_id>0 THEN oi.price*oi.quantity ELSE 0 END)   AS amount_product  ,
SUM(CASE WHEN oi.product_id>0 AND p.is_managed=1 THEN oi.price*oi.quantity ELSE 0 END)   AS amount_product_DQ  ,
SUM(CASE WHEN oi.product_id>0 AND p.is_managed=0 THEN oi.price*oi.quantity ELSE 0 END)   AS amount_servive_other  ,
0 AS shipping
  FROM issue i 
INNER JOIN `order` o ON i.id=o.issue_id
INNER JOIN order_item oi ON o.id=oi.order_id
LEFT JOIN product p ON oi.product_id=p.id
WHERE i.id=1 AND o.is_primary=1
GROUP BY o.id,o.created_at,o.status;


# Chi tiet don hang
SELECT  p.id, p.code,p.name,p.unit, oi.quantity, oi.price, oi.quantity*oi.price
  FROM issue i 
INNER JOIN `order` o ON i.id=o.issue_id
INNER JOIN order_item oi ON o.id=oi.order_id
LEFT JOIN product p ON oi.product_id=p.id
WHERE i.id=1 AND o.is_primary=1;