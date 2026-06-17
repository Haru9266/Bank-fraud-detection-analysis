-- PART 1 — Basic Exploration 


USE fraud_db;

SELECT * FROM fraud_transactions LIMIT 10;

SELECT COUNT(*) AS total_transactions
FROM fraud_transactions;

SELECT COUNT(*) AS total_frauds
FROM fraud_transactions
WHERE isFraud = 1;

SELECT 
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_frauds,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS fraud_percentage
FROM fraud_transactions;

SELECT DISTINCT type
FROM fraud_transactions;

-- PART 2 — Fraud Filtering

-- Q6: Only fraud transactions
SELECT step, type, amount, oldbalanceOrg, newbalanceOrig, isFraud
FROM fraud_transactions
WHERE isFraud = 1
LIMIT 20;

-- Q7: Fraud transactions of TRANSFER type
SELECT step, type, amount, oldbalanceOrg, newbalanceOrig
FROM fraud_transactions
WHERE isFraud = 1 
  AND type = 'TRANSFER'
LIMIT 20;

-- Q8: Frauds above 5 lakh
SELECT step, type, amount, oldbalanceOrg, newbalanceOrig
FROM fraud_transactions
WHERE isFraud = 1 
  AND amount > 500000
ORDER BY amount DESC
LIMIT 20;

-- Q9: The biggest fraud transaction
SELECT step, type, amount, oldbalanceOrg, newbalanceOrig, isFlaggedFraud
FROM fraud_transactions
WHERE isFraud = 1
ORDER BY amount DESC
LIMIT 1;

-- Q10: Flagged by system but was not actually fraud
SELECT step, type, amount, isFraud, isFlaggedFraud
FROM fraud_transactions
WHERE isFlaggedFraud = 1 
  AND isFraud = 0;

-- Bonus: Missed frauds
SELECT COUNT(*) AS missed_frauds
FROM fraud_transactions
WHERE isFraud = 1 
  AND isFlaggedFraud = 0;
  
-- PART 3 — Fraud Pattern Analysis
-- GROUP BY, SUM, AVG, MAX, MIN

-- Q11: Count of fraud transactions by type
SELECT type, 
       COUNT(*) AS fraud_count
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY fraud_count DESC;

-- Q12: Total fraud amount by type
SELECT type,
       COUNT(*) AS fraud_count,
       ROUND(SUM(amount), 2) AS total_fraud_amount
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY total_fraud_amount DESC;

-- Q13: Average, maximum and minimum fraud amount by type
SELECT type,
       COUNT(*) AS fraud_count,
       ROUND(AVG(amount), 2) AS avg_fraud_amount,
       ROUND(MAX(amount), 2) AS max_fraud_amount,
       ROUND(MIN(amount), 2) AS min_fraud_amount
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY avg_fraud_amount DESC;

-- Q14: Top 10 time steps with highest fraud count
SELECT step,
       COUNT(*) AS fraud_count
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY step
ORDER BY fraud_count DESC
LIMIT 10;

-- Q15: Suspicious transactions where sender's balance became zero
SELECT step, type, amount,
       oldbalanceOrg, newbalanceOrig
FROM fraud_transactions
WHERE isFraud = 1
  AND newbalanceOrig = 0
  AND oldbalanceOrg > 0
ORDER BY amount DESC
LIMIT 20;

-- PART 4 — Advanced Analysis
-- Subqueries, CASE WHEN


-- Q16: Fraud transactions with amount above the average fraud amount (Subquery)
SELECT step, type, amount, oldbalanceOrg, newbalanceOrig
FROM fraud_transactions
WHERE isFraud = 1
  AND amount > (
      SELECT AVG(amount)
      FROM fraud_transactions
      WHERE isFraud = 1
  )
ORDER BY amount DESC
LIMIT 20;

-- Q17: Assign risk level to fraud transactions (CASE WHEN)
SELECT step, type, amount, isFraud,
       CASE 
           WHEN amount > 1000000 THEN 'HIGH RISK'
           WHEN amount > 200000  THEN 'MEDIUM RISK'
           ELSE 'LOW RISK'
       END AS risk_level
FROM fraud_transactions
WHERE isFraud = 1
ORDER BY amount DESC
LIMIT 20;

-- Q18: Fraud count and total amount grouped by balance pattern
SELECT 
    CASE 
        WHEN newbalanceDest = 0 AND oldbalanceDest = 0 THEN 'Empty Destination Account'
        WHEN newbalanceDest > oldbalanceDest THEN 'Balance Increased'
        ELSE 'Other Pattern'
    END AS destination_pattern,
    COUNT(*) AS fraud_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY destination_pattern
ORDER BY fraud_count DESC;

-- Q19: System fraud detection rate
SELECT 
    COUNT(*) AS total_frauds,
    SUM(isFlaggedFraud) AS flagged_by_system,
    COUNT(*) - SUM(isFlaggedFraud) AS missed_by_system,
    ROUND(SUM(isFlaggedFraud) * 100.0 / COUNT(*), 2) AS detection_rate_pct
FROM fraud_transactions
WHERE isFraud = 1;

-- Q20: Complete fraud summary report
SELECT 
    'Overall Summary' AS report_section,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_frauds,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 4) AS fraud_rate_pct,
    ROUND(SUM(CASE WHEN isFraud = 1 THEN amount ELSE 0 END), 2) AS total_fraud_amount,
    ROUND(AVG(CASE WHEN isFraud = 1 THEN amount END), 2) AS avg_fraud_amount,
    ROUND(MAX(CASE WHEN isFraud = 1 THEN amount END), 2) AS max_fraud_amount
FROM fraud_transactions;

-- PART 5 — Views
-- CREATE VIEW for portfolio reuse

-- V1: View containing only fraud transactions
DROP VIEW IF EXISTS vw_fraud_only;

CREATE VIEW vw_fraud_only AS
SELECT 
    step,
    type,
    amount,
    oldbalanceOrg,
    newbalanceOrig,
    oldbalanceDest,
    newbalanceDest,
    isFlaggedFraud
FROM fraud_transactions
WHERE isFraud = 1;

-- V2: View with type-wise fraud summary
DROP VIEW IF EXISTS vw_fraud_summary;

CREATE VIEW vw_fraud_summary AS
SELECT 
    type,
    COUNT(*) AS fraud_count,
    ROUND(SUM(amount), 2) AS total_fraud_amount,
    ROUND(AVG(amount), 2) AS avg_fraud_amount,
    ROUND(MAX(amount), 2) AS max_fraud_amount,
    ROUND(MIN(amount), 2) AS min_fraud_amount
FROM fraud_transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY fraud_count DESC;

-- V3: View with high value fraud transactions (above 2 lakh) with risk level
DROP VIEW IF EXISTS vw_high_value_fraud;

CREATE VIEW vw_high_value_fraud AS
SELECT 
    step,
    type,
    amount,
    oldbalanceOrg,
    newbalanceOrig,
    isFlaggedFraud,
    CASE 
        WHEN amount > 1000000 THEN 'HIGH RISK'
        WHEN amount > 200000  THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_level
FROM fraud_transactions
WHERE isFraud = 1 
  AND amount > 200000
ORDER BY amount DESC;

-- Check all views created in this database
SHOW FULL TABLES IN fraud_db WHERE TABLE_TYPE = 'VIEW';