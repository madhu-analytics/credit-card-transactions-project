# 💳 Credit Card Transactions – SQL Analysis Project

## 📌 Project Overview
This project presents a collection of **SQL queries** designed to solve real-world business problems using a **credit card transactions dataset**. The focus is on deriving meaningful insights such as spending patterns, city-level trends, card performance, and customer behavior using SQL.

Each query simulates a scenario that a **data analyst or data engineer** might encounter while working in finance, banking, or retail analytics.

---

## 🧰 Tools & Skills Used

- **SQL (PostgreSQL / MySQL)**
- Joins, CTEs, Window Functions
- Aggregations, Grouping
- Subqueries and Ranking
- Analytical Thinking & Business Understanding

---

## 📊 Problem Statements & SQL Solutions

Below are the problem statements solved in this project:

---

### 🔎 1. Top 5 Cities by Credit Card Spend Contribution
**Problem:** Find the top 5 cities with the highest total credit card spends and show their percentage contribution to the overall credit card spend.

📌 **Insight:** Helps identify high-revenue markets and key focus areas.

---

### 📅 2. Monthly Spend by Card Type
**Problem:** For each card type, print the month with the highest total spend and the amount spent.

📌 **Insight:** Understand peak usage months and campaign timing.

---

### 💰 3. Cumulative Spend Milestone (1 Million)
**Problem:** Print the transaction details (all columns) where each card type first crosses ₹1,000,000 in total cumulative spend. (Should return 4 rows – one per card type)

📌 **Insight:** Detect velocity of card usage and customer behavior.

---

### 🪙 4. Lowest Percentage Spend for Gold Card
**Problem:** Identify the city with the lowest percentage of total spends made using **Gold** cards.

📌 **Insight:** Pinpoints underperforming regions for Gold cards.

---

### 🧾 5. Expense Type Patterns by City
**Problem:** For each city, print 3 columns – `city`, `highest_expense_type`, `lowest_expense_type`

📌 **Insight:** Reveals spending behavior differences by geography.

---

### 👩 6. Female Spend Percentage per Expense Type
**Problem:** For each expense type, calculate the percentage contribution of spends made by **female** cardholders.

📌 **Insight:** Highlights gender-based preferences across spending categories.

---

### 📈 7. Highest MoM Growth Combo – Jan 2014
**Problem:** Determine the combination of `card_type` and `expense_type` that had the highest **month-over-month (MoM)** growth in spend from Dec 2013 to Jan 2014.

📌 **Insight:** Detects successful product or promotional campaigns.

---

### 🧮 8. Weekend Spend Efficiency by City
**Problem:** During **weekends**, which city has the highest **spend-to-transaction** ratio?

📌 **Insight:** Evaluates transaction efficiency or high-value consumers.

---

### ⏱ 9. Fastest City to 500 Transactions
**Problem:** Which city reached its **500th transaction** the fastest (in terms of days) after its **first transaction**?

📌 **Insight:** Measures transaction acceleration and early adopter behavior.

---

## 📈 Key Outcomes

- 💡 Gained hands-on experience solving complex SQL business scenarios.
- 📉 Uncovered valuable insights such as top cities, MoM growth, and gender spend behavior.
- ⚙️ Applied **advanced SQL functions** such as `RANK()`, `WINDOW`, `PARTITION BY`, `DATE_DIFF`, and **aggregates**.

---

## 🚀 Future Enhancements

- Add **Power BI / Tableau dashboards** to visualize findings
- Build an **ETL pipeline** using Python and Airflow
- Use **dbt** to modularize SQL queries for production workflows

---

## 🤝 Let’s Connect

- 💼 [LinkedIn – Madhu Uday]https://www.linkedin.com/in/madhu-uday-4904b2117/
- 📧 Email: madhuudyadg@gmail.com

---

