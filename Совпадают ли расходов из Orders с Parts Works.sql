
--запрос для вывода колонки выводящей условие совпадают ли суммы расходов между Orders и Parts Works
SELECT
    *,
    CASE
        WHEN "разница общая" > 0 THEN 'есть разница'
        ELSE 'разницы нет'
    END AS 'условие'
FROM (
    SELECT
        RO.id_remont_order AS RO_ID,
        CAST(RO.works_price AS INTEGER) AS RO_w_price,
        CAST(RO.spare_parts AS INTEGER) AS RO_parts,
        CAST(RP.summa AS INTEGER) AS RP_summa,
        CAST(RW.summa AS INTEGER) AS RW_summa,
        CAST(RO.works_price AS INTEGER) - CAST(RW.summa AS INTEGER) AS 'разница по работам',
        CAST(RO.spare_parts AS INTEGER) - CAST(RP.summa AS INTEGER) AS 'разница по ремонтам',
        CAST(RO.works_price AS INTEGER) - CAST(RW.summa AS INTEGER) + CAST(RO.spare_parts AS INTEGER) - CAST(RP.summa AS INTEGER) AS 'разница общая'
    FROM TRANSIT2_REMONT_ORDERS AS RO
    RIGHT JOIN TRANSIT2_REMONT_WORKS AS RW ON RO.id_remont_order = RW.id_remont_order
    RIGHT JOIN TRANSIT2_REMONT_PARTS AS RP ON RO.id_remont_order = RP.id_remont_order
    WHERE RO.is_closed = '1'
    AND CAST(RO.works_price AS INTEGER) > 1
    AND CAST(RO.spare_parts AS INTEGER) > 1
    UNION ALL
    SELECT
        RO.id_remont_order AS RO_ID,
        CAST(RO.works_price AS INTEGER) AS RO_w_price,
        CAST(RO.spare_parts AS INTEGER) AS RO_parts,
        CAST(RP.summa AS INTEGER) AS RP_summa,
        CAST(RW.summa AS INTEGER) AS RW_summa,
        CAST(RO.works_price AS INTEGER) - CAST(RW.summa AS INTEGER) AS 'разница по работам',
        CAST(RO.spare_parts AS INTEGER) - CAST(RP.summa AS INTEGER) AS 'разница по ремонтам',
        CAST(RO.works_price AS INTEGER) - CAST(RW.summa AS INTEGER) + CAST(RO.spare_parts AS INTEGER) - CAST(RP.summa AS INTEGER) AS 'разница общая'
    FROM TRANSIT2_REMONT_ORDERS AS RO
    LEFT JOIN TRANSIT2_REMONT_WORKS AS RW ON RO.id_remont_order = RW.id_remont_order
    LEFT JOIN TRANSIT2_REMONT_PARTS AS RP ON RO.id_remont_order = RP.id_remont_order
    WHERE RO.is_closed = '1'
) a1
-- если нужно вывести только те заказы по которым есть разница то можно добавить условие : "where условие='есть разница'"

