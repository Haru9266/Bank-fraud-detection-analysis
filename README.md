# Bank-fraud-detection-analysis
End-to-end fraud detection on 6.3M+ bank transactions using Python, SQL, and Power BI — with automated fraud alert system and report generation.

# 🏦 Bank Fraud Detection Analysis

End-to-end fraud detection project on 6.3M+ bank transactions — combining **Python (EDA + Automation)**, **SQL (Pattern Analysis)**, and **Power BI (Dashboard)** to uncover fraud trends and detection gaps.

![Python](https://img.shields.io/badge/Python-3.x-blue?style=flat-square&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Pattern%20Analysis-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Cleaning-150458?style=flat-square&logo=pandas&logoColor=white)
![Automation](https://img.shields.io/badge/Automation-Fraud%20Alerts-orange?style=flat-square)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)

---

## 📌 Project Overview

Banks lose huge amounts of money every year due to fraudulent transactions. In this project, I analyzed a large-scale transaction dataset to:
- Identify **where** fraud happens (which transaction types)
- Measure **how much** fraud costs the bank
- Check whether the bank's **own fraud-flagging system** is actually working
- Build **automation scripts** that can generate fraud reports and trigger alerts automatically
- Visualize everything in an interactive **Power BI dashboard**

---

## 🛠️ Tools & Tech Stack

| Tool | Purpose |
|------|---------|
| **Python (Pandas)** | Data cleaning, EDA, automation scripts |
| **MySQL (SQL)** | Fraud pattern analysis, views, advanced queries |
| **Power BI** | Interactive dashboard & visual storytelling |
| **Power Automate (Theory)** | Workflow automation concept |

---

## 📊 Dataset

- **Rows:** 6.3 Million+ transactions
- **Columns:** step, type, amount, oldbalanceOrg, newbalanceOrig, oldbalanceDest, newbalanceDest, isFraud, isFlaggedFraud
- **Transaction Types:** CASH_OUT, PAYMENT, CASH_IN, TRANSFER, DEBIT

---

## 🔑 Key Findings

- 🚨 **Fraud occurs exclusively in `CASH_OUT` and `TRANSFER` transaction types** — no fraud found in PAYMENT, CASH_IN, or DEBIT.
- 📉 Total fraud cases: **8,213** out of 6.3M+ transactions (**0.13%** of all transactions).
- ⚠️ **Detection Gap:** The bank's own automated flagging system (`isFlaggedFraud`) caught only **16 out of 8,213** fraud cases — meaning **99.8% of frauds went undetected** by the existing system.
- 💰 Total Fraud Amount: **₹12.06 Billion**, almost evenly split between TRANSFER (50.3%) and CASH_OUT (49.7%).
- 🔍 Many frauds show a clear pattern: the **sender's account balance drops to ₹0** right after the transaction — a strong red flag for fraud detection rules.

---

## 🐍 Python Workflow

1. **Data Cleaning & EDA** — Handled missing values, checked data types, explored fraud distribution.
2. **`fraud_automation.py`** — Automatically generates a fraud summary report (`Fraud_Report.xlsx`) from the cleaned dataset.
3. **`fraud_alert.py`** — An automated alert system that:
   - Loads the cleaned dataset
   - Calculates the current fraud percentage
   - Compares it against a set threshold (0.5%)
   - Triggers a 🚨 HIGH ALERT if fraud % crosses the threshold
   - Logs every result (date, time, fraud %, status) into `fraud_alert_log.txt`

This automation shows how fraud monitoring can run **without manual checking** — a real-world style early-warning system.

---

## 🗄️ SQL Analysis (MySQL)

Performed deep fraud analysis using **20 SQL queries** across 5 phases:

1. **Basic Exploration** — Row counts, fraud %, transaction types
2. **Fraud Filtering** — Isolating fraud transactions, high-value frauds, biggest fraud case
3. **Pattern Analysis** — GROUP BY, AVG/MAX/MIN fraud amount by type, riskiest time steps
4. **Advanced Analysis** — Subqueries, `CASE WHEN` risk levels (HIGH/MEDIUM/LOW), system detection rate
5. **Views (for reuse)**
   - `vw_fraud_only` → All fraud transactions
   - `vw_fraud_summary` → Type-wise fraud summary
   - `vw_high_value_fraud` → High-value frauds (>₹2 lakh) with risk level tagging

---

## 📈 Power BI Dashboard
![Power BI Dashboard](Screenshot%202026-06-18%20010548.png)
Interactive dashboard built with:
- KPI Cards: Total Transactions (6M), Total Fraud Amount (12.06bn), Fraud % (0.13), Flagged Fraud Count (8K)
- Donut Chart: Fraud Amount by Type (TRANSFER vs CASH_OUT)
- Bar Charts: Total Count by Type, Fraud Count by Type
- Pie Chart: Total Transactions by Type
- Filters: isFraud, type, step

---

## 💡 Business Impact

This analysis proves that a bank's existing fraud-detection rules can have **huge blind spots**. By combining SQL pattern analysis with automated Python alerts, this project shows a practical approach to **catching more fraud, faster** — and demonstrates skills directly relevant to **Data Analyst / Fraud Analytics** roles.

---

## 👩‍💻 About Me

**Pooja Kumari** — Fresher Data Analyst | New Delhi
Certified in Data Analytics & AI — Ducat Institute

📧 poojak110059@gmail.com
🔗 Portfolio: [haru9266.github.io/data-analyst-portfolio](https://haru9266.github.io/data-analyst-portfolio)
🐙 GitHub: [@haru9266](https://github.com/haru9266)
