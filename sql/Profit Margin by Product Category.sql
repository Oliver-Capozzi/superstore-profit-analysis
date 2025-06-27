SELECT
  [Product Category],
  ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS ProfitMarginPercent
FROM superstore
GROUP BY [Product Category]
ORDER BY ProfitMarginPercent DESC;