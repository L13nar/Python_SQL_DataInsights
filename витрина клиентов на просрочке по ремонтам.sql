--витрина клиентов совершающих больше всего просрочек по ремонтам
--если использовать просто подзапрос то он выдаст список просроченных ремонтов,
-- вероятно нужно напомнить о ремонте либо внести исправление в базу
select
    ID_CONT,
    count(ID_CONT)
from (
SELECT
    id_remont_order,
    ID_CONT,
    expected_date_repair,
    actual_date_repair
FROM TRANSIT2_REMONT_ORDERS AS RO
WHERE expected_date_repair < datetime('now')
    AND actual_date_repair IS NULL) a2
group by ID_CONT
order by 2 desc

