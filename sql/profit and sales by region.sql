SELECT 
  Region,
  ROUND(SUM(Sales), 2)  AS TotalSales,
  ROUND(SUM(Profit), 2) AS TotalProfit
FROM superstore
GROUP BY Region
ORDER BY TotalProfit ASC;