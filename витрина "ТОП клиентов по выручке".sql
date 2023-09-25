--витрина топовых клиентов 2023 года с точки зрения продаж
SELECT
    ID_CONT,
    COUNT(id_remont_order) as total_orders,
    printf('%,.2f', SUM(total_amount)/COUNT(id_remont_order)) AS avg_total_amount,
    replace(printf('%,.2f', SUM(total_amount)), ',', ' ') AS formatted_total_amount,
    DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank
FROM TRANSIT2_REMONT_ORDERS AS RO
WHERE
    RO.is_closed = '1'
and actual_date_repair < '2023-01-01'
GROUP BY ID_CONT
HAVING SUM(total_amount) > 0
ORDER BY 5

