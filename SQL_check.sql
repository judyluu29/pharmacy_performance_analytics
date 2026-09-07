CREATE DATABASE pharmacy_analytics;
USE pharmacy_analytics;
SELECT DATABASE();

CREATE TABLE dim_branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    district VARCHAR(100),
    province VARCHAR(100)
);
SHOW TABLES;
DESCRIBE dim_branch;

CREATE TABLE dim_medicine (
    medicine_id VARCHAR(20) PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL,
    generic_name VARCHAR(150),
    medicine_category VARCHAR(100),
    dosage_form VARCHAR(50),
    strength_mg DECIMAL(10,2),
    pack_size VARCHAR(50),
    supplier_name VARCHAR(150),
    prescription_required VARCHAR(20)
);

DESCRIBE dim_medicine;

SELECT COUNT(*) 
FROM dim_medicine;

TRUNCATE TABLE dim_medicine;

DROP TABLE dim_medicine;

CREATE TABLE dim_medicine (
    medicine_id VARCHAR(20) PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL,
    generic_name VARCHAR(150),
    medicine_category VARCHAR(100),
    dosage_form VARCHAR(50),
    strength_mg VARCHAR(20),
    pack_size VARCHAR(50),
    supplier_name VARCHAR(150),
    prescription_required VARCHAR(20)
);

SELECT COUNT(*) AS total_medicines
FROM dim_medicine;

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day_of_week VARCHAR(20)
);

SELECT COUNT(*) AS total_dates
FROM dim_date;

CREATE TABLE fact_sales (
    transaction_id VARCHAR(30) PRIMARY KEY,
    transaction_date DATE NOT NULL,
    branch_id INT NOT NULL,
    medicine_id VARCHAR(20) NOT NULL,
    payment_method VARCHAR(50),
    customer_gender VARCHAR(20),
    customer_age INT,
    customer_city VARCHAR(100),
    batch_no VARCHAR(50),
    expiry_date DATE,
    quantity INT,
    unit_price_lkr DECIMAL(12,2),
    discount_rate DECIMAL(6,4),
    gross_sales_lkr DECIMAL(14,2),
    discount_amount_lkr DECIMAL(14,2),
    revenue_lkr DECIMAL(14,2),
    days_to_expiry INT,
    age_group VARCHAR(20),
    discount_group VARCHAR(30),

    FOREIGN KEY (branch_id)
        REFERENCES dim_branch(branch_id),

    FOREIGN KEY (medicine_id)
        REFERENCES dim_medicine(medicine_id),

    FOREIGN KEY (transaction_date)
        REFERENCES dim_date(date)
);

DESCRIBE fact_sales;

SELECT
    f.transaction_id,
    d.year,
    d.month_name,
    b.branch_name,
    m.medicine_name,
    f.quantity,
    f.revenue_lkr
FROM fact_sales f
JOIN dim_date d
    ON f.transaction_date = d.date
JOIN dim_branch b
    ON f.branch_id = b.branch_id
JOIN dim_medicine m
    ON f.medicine_id = m.medicine_id
LIMIT 10;

##Overall pharmacy KPIs in SQL
SELECT
    ROUND(SUM(revenue_lkr), 2) AS total_revenue_lkr,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    ROUND(
        SUM(revenue_lkr) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_transaction_value_lkr
FROM fact_sales;


##Monthly sales trend
SELECT
    d.year,
    d.month,
    d.month_name,
    ROUND(SUM(f.revenue_lkr), 2) AS revenue_lkr,
    SUM(f.quantity) AS units_sold,
    COUNT(DISTINCT f.transaction_id) AS transactions
FROM fact_sales f
JOIN dim_date d
    ON f.transaction_date = d.date
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


##Monthly revenue growth
WITH monthly_sales AS (
    SELECT
        d.year,
        d.month,
        d.month_name,
        SUM(f.revenue_lkr) AS revenue_lkr
    FROM fact_sales f
    JOIN dim_date d
        ON f.transaction_date = d.date
    GROUP BY
        d.year,
        d.month,
        d.month_name
),

sales_with_previous AS (
    SELECT
        *,
        LAG(revenue_lkr) OVER (
            ORDER BY year, month
        ) AS previous_month_revenue
    FROM monthly_sales
)

SELECT
    year,
    month,
    month_name,
    ROUND(revenue_lkr, 2) AS revenue_lkr,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (revenue_lkr - previous_month_revenue)
        / previous_month_revenue * 100,
        2
    ) AS mom_growth_pct
FROM sales_with_previous
ORDER BY year, month;

##Year-over-Year revenue comparison
WITH yoy_sales AS (
    SELECT
        d.year,
        SUM(f.revenue_lkr) AS revenue_lkr,
        SUM(f.quantity) AS units_sold,
        COUNT(DISTINCT f.transaction_id) AS transactions
    FROM fact_sales f
    JOIN dim_date d
        ON f.transaction_date = d.date
    WHERE d.month <= 6
    GROUP BY d.year
)

SELECT
    year,
    ROUND(revenue_lkr, 2) AS revenue_lkr,
    units_sold,
    transactions,
    ROUND(
        (revenue_lkr - LAG(revenue_lkr) OVER (ORDER BY year))
        / LAG(revenue_lkr) OVER (ORDER BY year) * 100,
        2
    ) AS revenue_growth_pct,
    
    ROUND(
        (units_sold - LAG(units_sold) OVER (ORDER BY year))
        / LAG(units_sold) OVER (ORDER BY year) * 100,
        2
    ) AS units_growth_pct,
    
    ROUND(
        (transactions - LAG(transactions) OVER (ORDER BY year))
        / LAG(transactions) OVER (ORDER BY year) * 100,
        2
    ) AS transaction_growth_pct

FROM yoy_sales
ORDER BY year;


##Confirm whether revenue growth was price-driven
WITH medicine_prices AS (
    SELECT
        f.medicine_id,
        m.medicine_name,

        AVG(
            CASE WHEN d.year = 2022
            THEN f.unit_price_lkr END
        ) AS avg_price_2022,

        AVG(
            CASE WHEN d.year = 2023
            THEN f.unit_price_lkr END
        ) AS avg_price_2023

    FROM fact_sales f

    JOIN dim_date d
        ON f.transaction_date = d.date

    JOIN dim_medicine m
        ON f.medicine_id = m.medicine_id

    WHERE d.month <= 6

    GROUP BY
        f.medicine_id,
        m.medicine_name
)

SELECT
    medicine_id,
    medicine_name,
    ROUND(avg_price_2022, 2) AS avg_price_2022,
    ROUND(avg_price_2023, 2) AS avg_price_2023,

    ROUND(
        (avg_price_2023 - avg_price_2022)
        / avg_price_2022 * 100,
        2
    ) AS price_growth_pct

FROM medicine_prices

ORDER BY price_growth_pct DESC;

#summarise the finding
WITH medicine_prices AS (
    SELECT
        f.medicine_id,

        AVG(CASE WHEN d.year = 2022
            THEN f.unit_price_lkr END) AS price_2022,

        AVG(CASE WHEN d.year = 2023
            THEN f.unit_price_lkr END) AS price_2023

    FROM fact_sales f
    JOIN dim_date d
        ON f.transaction_date = d.date

    WHERE d.month <= 6

    GROUP BY f.medicine_id
)

SELECT
    COUNT(*) AS medicines_compared,

    SUM(
        CASE WHEN price_2023 > price_2022
        THEN 1 ELSE 0 END
    ) AS medicines_price_increased,

    ROUND(
        AVG(
            (price_2023 - price_2022)
            / price_2022 * 100
        ),
        2
    ) AS avg_price_growth_pct

FROM medicine_prices;


##Rank medicines within each category

WITH medicine_sales AS (
    SELECT
        m.medicine_category,
        m.medicine_name,
        SUM(f.revenue_lkr) AS revenue_lkr,
        SUM(f.quantity) AS units_sold
    FROM fact_sales f
    JOIN dim_medicine m
        ON f.medicine_id = m.medicine_id
    GROUP BY
        m.medicine_category,
        m.medicine_name
),

ranked_medicines AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY medicine_category
            ORDER BY revenue_lkr DESC
        ) AS revenue_rank
    FROM medicine_sales
)

SELECT
    medicine_category,
    medicine_name,
    ROUND(revenue_lkr, 2) AS revenue_lkr,
    units_sold,
    revenue_rank
FROM ranked_medicines
WHERE revenue_rank <= 3
ORDER BY
    medicine_category,
    revenue_rank;
  
  
#Medicine contribution classification
WITH medicine_sales AS (
    SELECT
        m.medicine_id,
        m.medicine_name,
        m.medicine_category,
        SUM(f.revenue_lkr) AS revenue
    FROM fact_sales f
    JOIN dim_medicine m
        ON f.medicine_id = m.medicine_id
    GROUP BY
        m.medicine_id,
        m.medicine_name,
        m.medicine_category
),

contribution AS (
    SELECT
        *,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        )
        / SUM(revenue) OVER () * 100
        AS cumulative_revenue_pct
    FROM medicine_sales
)

SELECT
    medicine_id,
    medicine_name,
    medicine_category,
    ROUND(revenue, 2) AS revenue,
    ROUND(cumulative_revenue_pct, 2) AS cumulative_revenue_pct,

    CASE
        WHEN cumulative_revenue_pct <= 80 THEN 'Top'
        WHEN cumulative_revenue_pct <= 95 THEN 'Middle'
        ELSE 'Bottom'
    END AS contribution_class

FROM contribution
ORDER BY revenue DESC;


##Branch YoY growth

WITH branch_yoy AS (
    SELECT
        b.branch_id,
        b.branch_name,
        d.year,
        SUM(f.revenue_lkr) AS revenue
    FROM fact_sales f

    JOIN dim_branch b
        ON f.branch_id = b.branch_id

    JOIN dim_date d
        ON f.transaction_date = d.date

    WHERE d.month <= 6

    GROUP BY
        b.branch_id,
        b.branch_name,
        d.year
),

branch_comparison AS (
    SELECT
        branch_id,
        branch_name,

        SUM(
            CASE WHEN year = 2022
            THEN revenue ELSE 0 END
        ) AS revenue_2022,

        SUM(
            CASE WHEN year = 2023
            THEN revenue ELSE 0 END
        ) AS revenue_2023

    FROM branch_yoy

    GROUP BY
        branch_id,
        branch_name
)

SELECT
    branch_id,
    branch_name,

    ROUND(revenue_2022, 2) AS revenue_2022,
    ROUND(revenue_2023, 2) AS revenue_2023,

    ROUND(
        (revenue_2023 - revenue_2022)
        / revenue_2022 * 100,
        2
    ) AS revenue_growth_pct

FROM branch_comparison

ORDER BY revenue_growth_pct DESC;