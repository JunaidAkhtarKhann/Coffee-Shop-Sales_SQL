### Overview of the SQL Project: Coffee Shop Sales Analysis

This SQL project focuses on a **sales analysis** of a coffee shop, covering multiple key aspects such as total sales, order counts, and trends over time. Here's a breakdown of the project:

---

### 1. **Database Setup:**
   - A database `Coffee_shop_Sales` is created to store sales data.
   - The project uses a `Coffee_Sales` table for querying and analysis.

### 2. **Data Exploration & Alteration:**
   - **Data Type Checks:** Inspects the columns of `Coffee_Sales` using:
     - `sp_help 'Coffee_Sales'`
     - `INFORMATION_SCHEMA.COLUMNS`
   - **Alterations:**
     - `transaction_date` is altered to `DATE`.
     - `transaction_time` is altered to `TIME`.

---

### 3. **Monthly Sales Calculation:**
   - For each month (January to December), total sales are calculated using `SUM(transaction_qty * unit_price)`.
   - Extracts the **month** from `transaction_date` using `MONTH()` to filter sales by specific months.

---

### 4. **Month-on-Month Sales & Order Trends:**
   - **Sales Trend Analysis:**
     - Calculates **month-on-month sales** differences using the `LAG()` function to compare current sales with the previous month.
   - **Order Count Trends:**
     - Calculates the number of transactions (orders) for each month using `COUNT(transaction_id)`.

---

### 5. **Sales Quantity & Comparison:**
   - **Total Quantity Sold:** Computes the total quantity sold in each month using `COUNT(transaction_qty)`.
   - **Month-on-Month Quantity Trends:** Uses `LAG()` to track increases or decreases in sold quantities.

---

### 6. **Comprehensive Sales Metrics:**
   - Combines multiple metrics (quantity, transactions, sales) in a single query:
     - Uses `CONCAT()` and `ROUND()` to present totals in thousands (e.g., `1k` for 1000).

---

### 7. **Sales by Weekdays & Weekends:**
   - Uses `DATEPART(WEEKDAY, transaction_date)` to analyze sales performance on weekends versus weekdays.
   - Compares sales totals on weekends (Saturday, Sunday) with weekdays.

---

### 8. **Store Location Sales Analysis:**
   - Analyzes total sales for each **store location** on a monthly basis.
   - Ranks sales by location using `GROUP BY store_location`.

---

### 9. **Day-wise and Hour-wise Sales:**
   - **Daily Sales:** Calculates total sales for each day of the month using `DAY(transaction_date)`.
   - **Hourly Sales:** Summarizes sales by the hour using `DATEPART(HOUR, transaction_time)`.

---

### 10. **Average Sales Calculation:**
   - **Monthly Averages:** Calculates the average sales for each month using `AVG()`.

---

### 11. **Sales by Product Categories and Types:**
   - **Product Category:** Summarizes total sales by product categories (e.g., coffee, snacks) for each month.
   - **Product Type:** Calculates sales for different product types using `GROUP BY product_type`.

---

### 12. **Total Sales by Day of the Week:**
   - **Weekday Sales Breakdown:** Assigns meaningful labels (e.g., "Monday," "Tuesday") to sales based on the day of the week using `CASE` statements.
   - Sales trends by weekday for the month of May.

---

### Key Functions and Techniques:
   - **Aggregations:** `SUM()`, `COUNT()`, `AVG()`
   - **Date/Time Handling:** `MONTH()`, `DAY()`, `DATEPART(WEEKDAY)`
   - **Window Functions:** `LAG()` for month-on-month comparisons.
   - **Grouping:** `GROUP BY` for summarizing sales by month, product, store, and time.
   - **Conditional Statements:** `CASE` for categorizing weekday vs. weekend sales.

---

### Conclusion:
This project provides an in-depth analysis of coffee shop sales data, tracking monthly sales trends, order counts, and performance based on time (day, week, hour). It also covers product-based and location-based sales insights, making it a comprehensive exploration of sales metrics.
