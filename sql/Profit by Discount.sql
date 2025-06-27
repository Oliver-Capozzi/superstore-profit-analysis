SELECT
  ROUND(Discount * 100) || '%' AS DiscountPercent,
  COUNT(*) AS OrderCount,
  ROUND(AVG(Profit), 2) AS AvgProfitPerOrder,
  ROUND(SUM(Profit), 2) AS TotalProfit
FROM superstore
WHERE Discount BETWEEN 0 AND 0.10
GROUP BY Discount
ORDER BY Discount;