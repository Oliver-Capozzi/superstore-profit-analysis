SELECT
  [Product Name],
  ROUND(SUM(Profit), 2) AS TotalProfit
FROM superstore
GROUP BY [Product Name]
ORDER BY TotalProfit DESC
LIMIT 10;