--витрина автомобилей которые ремонтировались всего один раз
--если автомобиль не продан , то по какой причине не продолжаются ремонты
with a1 as (
SELECT
    CAR_NUMBER,
    ID_CONT,
    total_amount,
    works_price,
    spare_parts,
    actual_date_repair,
    lag(actual_date_repair) OVER (PARTITION BY CAR_NUMBER ORDER BY actual_date_repair) as previous_date_repair
FROM TRANSIT2_REMONT_ORDERS
WHERE
    (CAR_NUMBER NOT LIKE '%0000%' AND CAR_NUMBER NOT LIKE '%-%') AND
    NOT (CAR_NUMBER REGEXP '^[А-Яа-я0-9]+$') AND
    cast(total_amount as integer) > 0)

select
    CAR_NUMBER,
    ID_CONT,
    actual_date_repair,
    count(CAR_NUMBER) over (partition by ID_CONT) as count_cars
from a1 where previous_date_repair is null
order by  4 desc