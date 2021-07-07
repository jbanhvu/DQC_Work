SELECT 
  count(DISTINCT i.id),
  SUM(pqi.gross_price/1.1)revenue,
  SUM(CASE WHEN pqi.product_id=0 then pqi.gross_price/1.1 ELSE 0 END) service,
  SUM(CASE WHEN pqi.product_id>0 then pqi.gross_price/1.1 ELSE 0 END) product_total,
  SUM(CASE WHEN pqi.product_id>0 AND p.is_managed=1 then pqi.gross_price/1.1 ELSE 0 END) product_total_dq,
  SUM(CASE WHEN pqi.product_id>0 AND p.is_managed=0 then pqi.gross_price/1.1 ELSE 0 END) product_total_not_dq,
  IFNULL(em.percent_discount_service,0)percent_discount_service ,
  IFNULL(em.percent_discount_product,0)percent_discount_product,
  IFNULL(em.percent_discount_product_other,0)percent_discount_product_other
  FROM issue i 
  LEFT JOIN price_quotation pq ON i.id=pq.issue_id
  LEFT JOIN price_quotation_item pqi ON pq.id=pqi.price_quotation_id
  LEFT JOIN product p ON pqi.product_id=p.id
  LEFT JOIN user u ON u.id=i.user_id
  LEFT JOIN enterprise_membership em ON em.id=u.membership_id
  WHERE i.user_id=2;