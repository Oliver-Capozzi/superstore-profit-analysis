WITH monthly_totals AS (
    SELECT
        STRFTIME('%m', [Order Date]) AS Month,   -- 01 … 12
        Year,
        SUM(Profit) AS MonthProfit               -- total profit that month-year
    FROM superstore
    WHERE Year IS NOT NULL
    GROUP BY Year, Month
)

/* Step-2: average those totals across the 4 years */
SELECT
    Month,
    ROUND(AVG(MonthProfit), 2) AS AvgMonthlyProfit
FROM   monthly_totals
GROUP  BY Month
ORDER  BY CAST(Month AS INTEGER);