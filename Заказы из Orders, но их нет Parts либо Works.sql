
-- Проверка заказов которые есть в Orders, но нет в табличке Parts либо Works
with a1 as (
SELECTa
    RO.id_remont_order as RO_ID,
    RO.works_price as RO_w_price,
    RO.spare_parts as  RO_parts,
    RO.total_amount,
    RW.id_remont_order AS rw_id_remont_order,
    RP.id_remont_order AS rp_id_remont_order,
    RP.summa AS RP_summa,
    RW.summa AS RW_summa
FROM TRANSIT2_REMONT_ORDERS AS RO
RIGHT JOIN TRANSIT2_REMONT_WORKS AS RW ON RO.id_remont_order = RW.id_remont_order
RIGHT JOIN TRANSIT2_REMONT_PARTS AS RP ON RO.id_remont_order = RP.id_remont_order
WHERE RO.is_closed = '1'
AND cast(RO.works_price as integer) > 1
AND cast(RO.spare_parts as integer) > 1
UNION ALL
SELECT
    RO.id_remont_order as RO_ID,
    RO.works_price as RO_w_price,
    RO.spare_parts as RO_parts,
    RO.total_amount,
    RW.id_remont_order AS rw_id_remont_order,
    RP.id_remont_order AS rp_id_remont_order,
    RP.summa AS RP_summa,
    RW.summa AS RW_summa
FROM TRANSIT2_REMONT_ORDERS AS RO
LEFT JOIN TRANSIT2_REMONT_WORKS AS RW ON RO.id_remont_order = RW.id_remont_order
LEFT JOIN TRANSIT2_REMONT_PARTS AS RP ON RO.id_remont_order = RP.id_remont_order
WHERE RO.is_closed = '1'
AND cast(RO.works_price as integer) > 1
AND cast(RO.spare_parts as integer) > 1 )

SELECT
   RO_ID,
   RO_w_price,
   RW_summa,
   RO_parts,
   RP_summa,
    CASE WHEN RO_w_price IS NOT NULL AND RW_summa IS NULL THEN 1 ELSE 0 END AS work_case,
    CASE WHEN RO_parts IS NOT NULL AND RP_summa IS  NULL THEN 1 ELSE 0 END AS parts_case
FROM a1
where work_case in (1) OR parts_case in (1)

-- в итоге получаем два закрытых заказа которых нет в табличках Works и Parts
--F29D8025C2C820FDE053024A14AC77D2
--FOE165171A30D948E053024A14AC6930