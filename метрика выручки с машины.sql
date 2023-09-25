-- метрика и гипотеза выручки с машины
-- более объективный показатель важности того или иного клиента
-- Почему это важно:
-- показатель выручка на машину важен для анализа того, насколько успешно сервис удерживает клиентов и продает дополнительные услуги.
-- Если средняя выручка по машине клиента высока, это может указывать на то, что клиенты регулярно пользуются сервисом и покупают дополнительные услуги.
SELECT
    CAR_NUMBER,
    ID_CONT,
    total_amount,
    sum(total_amount) over (partition by ID_CONT) as total_revenue,
    count(CAR_NUMBER) over (partition by ID_CONT) as Cars_count,
    sum(total_amount) over (partition by ID_CONT)/ count(CAR_NUMBER) over (partition by ID_CONT) as revenue_per_car
FROM TRANSIT2_REMONT_ORDERS
WHERE
    (CAR_NUMBER NOT LIKE '%0000%' AND CAR_NUMBER NOT LIKE '%-%') AND
    NOT (CAR_NUMBER REGEXP '^[А-Яа-я0-9]+$') AND
    cast(total_amount as integer) > 0
order by 5 desc