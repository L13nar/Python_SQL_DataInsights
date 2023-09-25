--Гипотеза
--Так как есть информация по количеству активных карт (можно предположить , о привязке активной карты к автомобилю)
--мы можем сравнить количество автомобилей пользующихся услугами сервиса с общим количеством автомобилей находящимся в распоряжении Клиента (с его парком).
-- Данная информация будет полезна Менеджерам для формирования их стратегии продаж и верного расходования времени (приоритет на Клиентов с наибольшим парком авто не использующих наш сервис)

with a1 as (SELECT
     ID_CONT,
    sum(total_amount)  as total_revenue,
    count(CAR_NUMBER) as Cars_count,
    sum(total_amount) / count(CAR_NUMBER)  as revenue_per_car
FROM TRANSIT2_REMONT_ORDERS
WHERE
    (CAR_NUMBER NOT LIKE '%0000%' AND CAR_NUMBER NOT LIKE '%-%') AND
    NOT (CAR_NUMBER REGEXP '^[А-Яа-я0-9]+$') AND
    cast(total_amount as integer) > 0
group by
    ID_CONT)

SELECT
  Trans.ID_CONT,
  Trans.Active_cards,
  coalesce(Cars_count,0) as Current_Client_Cars,
  Trans.Active_cards - coalesce(Cars_count,0) as Possible_Client_Cars
FROM TR3_DSBD_MARGIN_TRANS Trans
left join a1 on Trans.ID_CONT = a1.ID_CONT
order by 4 desc