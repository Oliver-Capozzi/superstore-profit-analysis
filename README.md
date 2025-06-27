# 📊 Superstore Profit Analysis (2009 – 2012)

An end‑to‑end data‑science case study that dissects four years of Superstore sales data to uncover *why* profits fell, *where* money was lost, and *how* the business can turn things around.  The project walks through **data cleaning, SQL trend mining, Tableau storytelling, and strategic recommendations**—all packaged as a portfolio‑ready GitHub repository.

---

## 🔎 Quick Links

| Section                                                 | Purpose                            |
| ------------------------------------------------------- | ---------------------------------- |
| [Dataset](#dataset)                                     | Raw & cleaned data overview        |
| [Project Roadmap](#project-roadmap)                     | Everything done—at a glance        |
| [SQL Deep‑Dive](#sql-deep-dive)                         | Every query + insight              |
| [Tableau Gallery](#tableau-gallery)                     | 7 interactive visuals explained    |
| [Key Findings](#key-findings)                           | What the numbers revealed          |
| [Strategic Recommendations](#strategic-recommendations) | Concrete business actions          |
| [Re‑run the Analysis](#re-run-the-analysis)             | How to replicate this repo locally |
| [Future Work](#future-work)                             | Next analytical steps              |

---

## 📂 Dataset

| File | Description                                            |
| ---- | ------------------------------------------------------ |
| ``   | Original Kaggle/GitHub Superstore extract (≈10 k rows) |
| ``   | Clean version—bad dates removed, numeric types fixed   |

> **Columns of interest**
>
> - `Order Date` → transaction timestamp
> - `Product Category` → Furniture · Technology · Office Supplies
> - `Region` → East · West · Central · South
> - `Sales` → revenue per line item
> - `Profit` → sales minus cost of goods
> - `Discount` → decimal (0 – 0.9)

---

## 🚣️ Project Roadmap

1. **Data Cleaning**  → removed 21 bad rows, standardized `YYYY‑MM‑DD` dates.
2. **SQLite Modeling**  → imported CSV → added computed `Year`, `Month`, and `Profit Margin` fields.
3. **SQL Trend Mining**  → seven focused queries (see below).
4. **Tableau Storytelling**  → built 7 worksheets + 1 dashboard:
   - yearly, category, region, discount, margin, product TOP10, seasonality
5. **Insight Synthesis**  → translated numbers into bulletproof findings.
6. **Strategy Blueprint**  → five actionable moves to reverse the profit slide.

---

## 🗓️ SQL Deep‑Dive

> **Database:** `superstore.sqlite` (one table: `superstore`)

### One‑Time Prep

```sql
ALTER TABLE superstore ADD COLUMN Year INTEGER;
UPDATE superstore
SET Year = CAST(strftime('%Y',[Order Date]) AS INTEGER)
WHERE Year IS NULL;
```

### 1️⃣ Yearly Profit + Sales

```sql
SELECT Year,
       ROUND(SUM(Sales),2)  AS TotalSales,
       ROUND(SUM(Profit),2) AS TotalProfit
FROM   superstore
GROUP  BY Year;
```

*Insight → profit fell 35 % from 2009 → 2012 despite flat sales.*

### 2️⃣ Category Performance Over Time

```sql
SELECT Year,
       [Product Category],
       SUM(Profit) AS Profit
FROM   superstore
GROUP  BY Year,[Product Category];
```

*Insight → Furniture flipped to loss territory in 2011 – 2012.*

### 3️⃣ Regional Winners & Losers

```sql
SELECT Region,
       SUM(Profit) AS Profit
FROM   superstore
GROUP  BY Region;
```

*Insight → Central region lost \$15 k while West earned \$12 k.*

### 4️⃣ Profit vs Exact Discount %

```sql
SELECT ROUND(Discount*100)||'%' AS DiscPct,
       AVG(Profit)              AS AvgProfit
FROM   superstore
WHERE  Discount<=0.10
GROUP  BY Discount;
```

*Insight → Avg profit flips negative beyond a 6 % discount.*

### 5️⃣ Profit Margin by Category

```sql
SELECT [Product Category],
       ROUND(SUM(Profit)/SUM(Sales)*100,2) AS MarginPct
FROM   superstore
GROUP  BY [Product Category];
```

*Insight → Technology ≈ 15 % margin, Furniture ≈ –133 %.*

### 6️⃣ Top‑10 Profit‑Heavy Products

```sql
SELECT [Product Name],
       SUM(Profit) AS Profit
FROM   superstore
GROUP  BY [Product Name]
ORDER  BY Profit DESC
LIMIT 10;
```

### 7️⃣ Seasonality — Average Monthly Profit

```sql
WITH monthly_totals AS (
  SELECT strftime('%m',[Order Date]) AS M,
         Year,
         SUM(Profit)                AS mo_profit
  FROM   superstore
  GROUP  BY Year,M
)
SELECT M AS Month,
       AVG(mo_profit) AS AvgProfit
FROM   monthly_totals
GROUP  BY M;
```

*Insight → Nov peaks; Jul troughs.*

---

## 🖼️ Tableau Gallery

| # | Worksheet                     | What it Shows                       |
| - | ----------------------------- | ----------------------------------- |
| 1 | **Yearly Profit Trend**       | Visual decline 2009 → 2012          |
| 2 | **Profit by Category × Year** | Furniture losses vs Tech gains      |
| 3 | **Profit by Region**          | West up, Central down               |
| 4 | **Profit by Discount %**      | Break‑even threshold at 6 %         |
| 5 | **Margin by Category**        | Efficiency snapshot; red marks loss |
| 6 | **Top‑10 Products**           | 60 % of profit from 10 SKUs         |
| 7 | **Avg Monthly Profit**        | Seasonality pattern                 |

> **Interactive workbook:** [`tableau/superstore_dashboard.twbx`](tableau/superstore_dashboard.twbx)

Screenshots live in `` and are embedded below:

&#x20;    &#x20;

---

## 🔑 Key Findings

1. **Company‑wide slump**: Profit fell from \$45 k → \$29 k (–35 %) in four years.
2. **Furniture drain**: –\$38 k total profit (–133 % margin) → prime turnaround target.
3. **Discount leak**: Orders with >6 % discount consistently unprofitable.
4. **Regional imbalance**: Central region wiped out 80 % of Tech gains.
5. **Product winners**: 10 SKUs generate 60 % of total profit—amplify them.
6. **Seasonality**: November surge, July slump—inventory + marketing levers.

---

## 🎯 Strategic Recommendations

| Priority | Action                                            | Rationale                                |
| -------- | ------------------------------------------------- | ---------------------------------------- |
| 🔴 High  | Cap discounts at 5 %                              | Prevent margin flip to negative (>6 %).  |
| 🔴 High  | Re‑price or phase out loss‑making Furniture lines | Furniture losses >\$38 k.                |
| 🟧 Med   | Double‑down on Technology                         | 15 % margin and positive YoY growth.     |
| 🟧 Med   | Central region operational review                 | Plug \$15 k loss; learn West’s playbook. |
| 🟩 Low   | Stock up for November, slim July                  | Align inventory with seasonality.        |

> *Recommendations are embedded ****inside**** this README to keep the full narrative in one place. If you prefer, copy them into a separate **`recommendations.md`**.*

---

## 🔄 Re‑run the Analysis

1. **Clone** this repo.
2. Open **DB Browser for SQLite → “Open Database” → select **``.
3. Run each SQL script from `/sql/analysis_queries.sql`.
4. Open **Tableau Public → “Open Workbook” → **``**.**
5. Refresh the data source if prompted; all charts update automatically.

---

## 🔮 Future Work

- **Forecasting:** ARIMA or Prophet forecast for profits 2013 –2015.
- **Customer segmentation:** cluster customers and map to profit.
- **Price‑sensitivity analysis:** regression of discount vs demand.

---

## 📝 License

MIT — free to use, share, and adapt. Please credit **@Oliver-Capozzi**.

