SELECT 
  Year,
  [Product Category],
  ROUND(SUM(Sales), 2)  AS TotalSales,
  ROUND(SUM(Profit), 2) AS TotalProfit
FROM superstore
WHERE Year IS NOT NULL
GROUP BY Year, [Product Category]
ORDER BY Year, [Product Category];