-- =========================================
-- CUSTOMER CHURN & RETENTION ANALYSIS
-- =========================================

-- CREATE TABLE

CREATE TABLE churn_data (
    customer_id INTEGER,
    country TEXT,
    state TEXT,
    city TEXT,
    zip_code TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    gender TEXT,
    senior_citizen TEXT,
    partner TEXT,
    dependents TEXT,
    tenure_months INTEGER,
    phone_service TEXT,
    multiple_lines TEXT,
    internet_service TEXT,
    online_security TEXT,
    online_backup TEXT,
    device_protection TEXT,
    tech_support TEXT,
    streaming_tv TEXT,
    streaming_movies TEXT,
    contract TEXT,
    paperless_billing TEXT,
    payment_method TEXT,
    monthly_charges NUMERIC,
    total_charges NUMERIC,
    churn_label TEXT,
    churn_value INTEGER,
    churn_score INTEGER,
    cltv NUMERIC,
    churn_reason TEXT
);

-- =========================================
-- 1. OVERALL CHURN KPI
-- =========================================
SELECT 
    COUNT(*) AS total_customers,
    SUM(churn_value) AS churned_customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate_percentage
FROM churn_data;

-- =========================================
-- 2. CHURN BY CONTRACT
-- =========================================
SELECT
    contract,
    COUNT(*) AS total_customers,
    SUM(churn_value) AS churned_customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY contract
ORDER BY churn_rate DESC;

-- =========================================
-- 3. CHURN BY TENURE (CUSTOMER LIFECYCLE)
-- =========================================
SELECT
    CASE 
        WHEN tenure_months < 12 THEN '0-12 Months'
        WHEN tenure_months < 24 THEN '12-24 Months'
        ELSE '24+ Months'
    END AS tenure_group,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- =========================================
-- 4. CHURN BY PAYMENT METHOD
-- =========================================
SELECT
    payment_method,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY payment_method
ORDER BY churn_rate DESC;

-- =========================================
-- 5. REVENUE LOSS DUE TO CHURN
-- =========================================
SELECT
    SUM(total_charges) AS total_revenue,
    SUM(CASE WHEN churn_value = 1 THEN total_charges ELSE 0 END) AS revenue_lost_to_churn
FROM churn_data;

-- =========================================
-- 6. HIGH-VALUE CUSTOMERS WHO CHURNED
-- =========================================
SELECT
    customer_id,
    cltv,
    total_charges
FROM churn_data
WHERE churn_value = 1
ORDER BY cltv DESC
LIMIT 10;

-- =========================================
-- 7. CHURN BY INTERNET SERVICE
-- =========================================
SELECT
    internet_service,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY internet_service
ORDER BY churn_rate DESC;

-- =========================================
-- 8. TOP CHURN REASONS
-- =========================================
SELECT
    churn_reason,
    COUNT(*) AS total_churned
FROM churn_data
WHERE churn_value = 1
GROUP BY churn_reason
ORDER BY total_churned DESC
LIMIT 10;

-- =========================================
-- 9. CUSTOMER SEGMENTATION
-- =========================================
SELECT
    CASE 
        WHEN cltv > 5000 THEN 'High Value'
        WHEN cltv > 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY customer_segment
ORDER BY churn_rate DESC;

-- =========================================
-- 10. EXPORT DATA FOR POWER BI
-- =========================================
SELECT
    contract,
    payment_method,
    tenure_months,
    monthly_charges,
    total_charges,
    churn_value,
    churn_score,
    cltv
FROM churn_data;

-- =========================================
-- 11. CHURN RATE + REVENUE IMPACT
-- =========================================
SELECT
    CASE 
        WHEN cltv > 5000 THEN 'High Value'
        WHEN cltv > 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    SUM(churn_value) AS churned_customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate,
    SUM(total_charges) AS total_revenue,
    SUM(CASE WHEN churn_value = 1 THEN total_charges ELSE 0 END) AS lost_revenue
FROM churn_data
GROUP BY customer_segment
ORDER BY lost_revenue DESC;

-- =========================================
-- 12. CHURN RISK PROFILE
-- =========================================
SELECT
    contract,
    internet_service,
    payment_method,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY contract, internet_service, payment_method
HAVING COUNT(*) > 50
ORDER BY churn_rate DESC;

-- =========================================
-- 13. ARPU (AVERAGE REVENUE PER USER)
-- =========================================
SELECT
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_revenue,
    ROUND(AVG(total_charges), 2) AS avg_total_revenue
FROM churn_data;

-- =========================================
-- 14. HIGH REVENUE CUSTOMERS WHO CHURNED
-- =========================================
SELECT
    customer_id,
    monthly_charges,
    total_charges,
    cltv
FROM churn_data
WHERE churn_value = 1
AND total_charges > (SELECT AVG(total_charges) FROM churn_data)
ORDER BY total_charges DESC
LIMIT 20;

-- =========================================
-- 15. TENURE VS REVENUE
-- =========================================
SELECT
    tenure_months,
    COUNT(*) AS customers,
    ROUND(AVG(total_charges), 2) AS avg_revenue,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY tenure_months
ORDER BY tenure_months;

-- =========================================
-- 16. SERVICE USAGE IMPACT
-- =========================================
SELECT
    online_security,
    tech_support,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY online_security, tech_support
ORDER BY churn_rate DESC;

-- =========================================
-- 17. BILLING BEHAVIOR ANALYSIS
-- =========================================
SELECT
    paperless_billing,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY paperless_billing;

-- =========================================
-- 18. EXECUTIVE SUMMARY (FOR DASHBOARD)
-- =========================================
SELECT
    contract,
    internet_service,
    payment_method,
    COUNT(*) AS total_customers,
    SUM(churn_value) AS churned_customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges,
    ROUND(AVG(cltv), 2) AS avg_cltv
FROM churn_data
GROUP BY contract, internet_service, payment_method;