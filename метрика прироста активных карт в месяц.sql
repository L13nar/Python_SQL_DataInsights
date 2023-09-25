--метрика учета прироста количества активных карт в месяц
SELECT
    DT_month,
    SUM(Active_cards) AS Total_Active_cards,
    SUM(Active_cards) - LAG(SUM(Active_cards)) OVER (ORDER BY CAST(SUBSTR(DT_month, 7, 4) || '-' || SUBSTR(DT_month, 4, 2) || '-' || SUBSTR(DT_month, 1, 2) AS DATE)) AS Monthly_Increase
FROM TR3_DSBD_MARGIN_TRANS
GROUP BY DT_month
ORDER BY CAST(SUBSTR(DT_month, 7, 4) || '-' || SUBSTR(DT_month, 4, 2) || '-' || SUBSTR(DT_month, 1, 2) AS DATE);
