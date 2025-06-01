-- write a query to print highest spend month and amount spent in that month for each card type
WITH monthly_spending AS (
  SELECT 
    card_type,
    DATE_FORMAT(STR_TO_DATE(transaction_date, '%d-%b-%y'), '%Y-%m') AS month,
    SUM(amount) AS total_spent
  FROM credit_card_transcations
  GROUP BY card_type, month
),
ranked_spending AS (
  SELECT *,
         RANK() OVER (PARTITION BY card_type ORDER BY total_spent DESC) AS rk
  FROM monthly_spending
)
SELECT 
  card_type,
  month AS highest_spend_month,
  total_spent AS amount_spent
FROM ranked_spending
WHERE rk = 1;

-- write a query to print the transaction details(all columns from the table) for each card type when
-- it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

WITH ordered_txns AS (
    SELECT 
        *,
        STR_TO_DATE(transaction_date, '%d-%b-%y') AS txn_date,
        SUM(amount) OVER (
            PARTITION BY card_type 
            ORDER BY STR_TO_DATE(transaction_date, '%d-%b-%y'), transaction_id
        ) AS cumulative_spend
    FROM credit_card_transcations
),
ranked_txns AS (
    SELECT *
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY card_type 
                ORDER BY txn_date, transaction_id
            ) AS rn
        FROM ordered_txns
        WHERE cumulative_spend >= 1000000
    ) AS filtered
    WHERE rn = 1
)
SELECT 
    *
FROM ranked_txns;

-- write a query to find city which had lowest percentage spend for gold card type
WITH gold_city_spend AS (
    SELECT 
        city,
        SUM(amount) AS city_gold_spend
    FROM credit_card_transcations
    WHERE card_type = 'Gold'
    GROUP BY city
),
total_gold_spend AS (
    SELECT 
        SUM(amount) AS total_spend
    FROM credit_card_transcations
    WHERE card_type = 'Gold'
),
city_percentage AS (
    SELECT 
        g.city,
        g.city_gold_spend,
        (g.city_gold_spend / t.total_spend) * 100 AS percentage_spend
    FROM gold_city_spend g
    JOIN total_gold_spend t
)
SELECT 
    city,
    ROUND(percentage_spend, 2) AS percentage_spend
FROM city_percentage
ORDER BY percentage_spend ASC
LIMIT 1;

-- write a query to print 3 columns:  
-- city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

WITH city_category_spend AS (
    SELECT 
        city,
        exp_type,
        SUM(amount) AS total_spend
    FROM credit_card_transcations
    GROUP BY city, exp_type
),
ranked_spends AS (
    SELECT 
        city,
        exp_type,
        total_spend,
        RANK() OVER (PARTITION BY city ORDER BY total_spend DESC) AS spend_rank_desc,
        RANK() OVER (PARTITION BY city ORDER BY total_spend ASC) AS spend_rank_asc
    FROM city_category_spend
),
highest AS (
    SELECT city, exp_type AS highest_expense_type
    FROM ranked_spends
    WHERE spend_rank_desc = 1
),
lowest AS (
    SELECT city, exp_type AS lowest_expense_type
    FROM ranked_spends
    WHERE spend_rank_asc = 1
)
SELECT 
    h.city,
    h.highest_expense_type,
    l.lowest_expense_type
FROM highest h
JOIN lowest l ON h.city = l.city
ORDER BY h.city;

-- write a query to find percentage contribution of spends by females for each expense type

WITH category_spend AS (
    SELECT 
        exp_type,
        SUM(amount) AS total_spend
    FROM credit_card_transcations
    GROUP BY exp_type
),
female_spend AS (
    SELECT 
        exp_type,
        SUM(amount) AS female_spend
    FROM credit_card_transcations
    WHERE gender = 'F'
    GROUP BY exp_type
)
SELECT 
    c.exp_type,
    ROUND(IFNULL(f.female_spend, 0) / c.total_spend * 100, 2) AS female_spend_percentage
FROM category_spend c
LEFT JOIN female_spend f ON c.exp_type = f.exp_type
ORDER BY female_spend_percentage DESC;

-- which card and expense type combination saw highest month over month growth in Jan-2014

WITH monthly_spend AS (
    SELECT
        card_type,
        exp_type,
        DATE_FORMAT(STR_TO_DATE(transaction_date, '%d-%b-%y'), '%Y-%m') AS yearmonth,
        SUM(amount) AS total_spend
    FROM credit_card_transcations
    GROUP BY card_type, exp_type, DATE_FORMAT(STR_TO_DATE(transaction_date, '%d-%b-%y'), '%Y-%m')
),
growth_calc AS (
    SELECT
        card_type,
        exp_type,
        yearmonth,
        total_spend,
        LAG(total_spend) OVER (
            PARTITION BY card_type, exp_type 
            ORDER BY yearmonth
        ) AS prev_month_spend
    FROM monthly_spend
),
growth_rate AS (
    SELECT
        card_type,
        exp_type,
        yearmonth,
        total_spend,
        prev_month_spend,
        ROUND(
            IFNULL((total_spend - prev_month_spend) / NULLIF(prev_month_spend, 0) * 100, 0), 
            2
        ) AS growth_percentage
    FROM growth_calc
)
SELECT 
    card_type,
    exp_type AS expense_type,
    growth_percentage
FROM growth_rate
WHERE yearmonth = '2014-01'
ORDER BY growth_percentage DESC
LIMIT 1;

-- during weekends which city has highest total spend to total no of transcations ratio

SELECT 
    city,
    ROUND(SUM(amount) / COUNT(*), 2) AS spend_to_transaction_ratio
FROM credit_card_transcations
WHERE DAYOFWEEK(STR_TO_DATE(transaction_date, '%d-%b-%y')) IN (1, 7)  -- Sunday = 1, Saturday = 7
GROUP BY city
ORDER BY spend_to_transaction_ratio DESC
LIMIT 1;


-- which city took least number of days to reach its 500th transaction after the first transaction in that city
WITH txn_ranked AS (
    SELECT 
        city,
        STR_TO_DATE(transaction_date, '%d-%b-%y') AS txn_date,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY STR_TO_DATE(transaction_date, '%d-%b-%y')) AS txn_num
    FROM credit_card_transcations
),
city_500_dates AS (
    SELECT 
        city,
        MIN(CASE WHEN txn_num = 1 THEN txn_date END) AS first_txn_date,
        MIN(CASE WHEN txn_num = 500 THEN txn_date END) AS txn_500_date
    FROM txn_ranked
    GROUP BY city
    HAVING txn_500_date IS NOT NULL
)
SELECT 
    city,
    DATEDIFF(txn_500_date, first_txn_date) AS days_to_500_txns
FROM city_500_dates
ORDER BY days_to_500_txns ASC
LIMIT 1;


