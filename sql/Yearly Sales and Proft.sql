SELECT 
  STRFTIME('%Y', [Order Date]) AS Year,
  ROUND(SUM(Sales), 2) AS TotalSales,
  ROUND(SUM(Profit), 2) AS TotalProfit
FROM superstore
GROUP BY Year
ORDER BY Year;