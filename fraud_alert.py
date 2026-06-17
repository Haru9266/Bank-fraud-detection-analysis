# ============================================
# SCRIPT 2 — Automated Alert System
# ============================================


# ---- PART 1 — Import Libraries ----
import pandas as pd
import os
from datetime import datetime


# ---- PART 2 — Set File Paths ----
file_path = r"C:\Users\pooja kumari\OneDrive\Desktop\Data-Analysis-Projects\Pro-9-Bank_Fraud_Project\Fraud_cleaned.csv"

log_path = r"C:\Users\pooja kumari\OneDrive\Desktop\Data-Analysis-Projects\Pro-9-Bank_Fraud_Project\fraud_alert_log.txt"

# Alert threshold — alert will trigger above this percentage
FRAUD_THRESHOLD = 0.5


# ---- PART 3 — Load CSV File ----
print("=" * 50)
print("  FRAUD ALERT SYSTEM")
print("=" * 50)
print()
print("Step 1: Loading CSV file...")

df = pd.read_csv(file_path)

print(f"✅ File loaded successfully!")
print(f"   Total Rows : {len(df):,}")
print()


# ---- PART 4 — Calculate Fraud Percentage ----
print("Step 2: Calculating fraud percentage...")

total     = len(df)
fraud     = df['isFraud'].sum()
fraud_pct = (fraud / total) * 100

print(f"   Total Transactions : {total:,}")
print(f"   Fraud Cases        : {fraud:,}")
print(f"   Fraud Percentage   : {fraud_pct:.4f}%")
print(f"   Threshold Set      : {FRAUD_THRESHOLD}%")
print()


# ---- PART 5 — Check Alert Status ----
print("Step 3: Checking alert status...")
print()

now = datetime.now().strftime("%d-%m-%Y %H:%M:%S")

if fraud_pct > FRAUD_THRESHOLD:
    alert_status  = "HIGH FRAUD ALERT"
    alert_message = f"ALERT: Fraud {fraud_pct:.4f}% is ABOVE threshold {FRAUD_THRESHOLD}%"
    print("🚨 " * 10)
    print("  🚨 HIGH FRAUD ALERT DETECTED! 🚨")
    print("🚨 " * 10)
    print()
    print(alert_message)
else:
    alert_status  = "NORMAL — No Alert"
    alert_message = f"OK: Fraud {fraud_pct:.4f}% is BELOW threshold {FRAUD_THRESHOLD}%"
    print("✅ " * 1)
    print("   STATUS: NORMAL — No Alert!")
    print("✅ " * 1)
    print()
    print(alert_message)

print()


# ---- PART 6 — Save Results to Log File ----
print("Step 4: Saving results to log file...")

log_entry = f"""
==================================================
  FRAUD ALERT SYSTEM LOG
==================================================
Date and Time        : {now}
Total Transactions   : {total:,}
Fraud Cases          : {fraud:,}
Fraud Percentage     : {fraud_pct:.4f}%
Threshold            : {FRAUD_THRESHOLD}%
Status               : {alert_status}
Message              : {alert_message}
==================================================

"""

with open(log_path, 'a', encoding='utf-8') as log_file:
    log_file.write(log_entry)

print(f" Log file saved successfully!")
print(f"   Location: {log_path}")
print()


# ---- PART 7 — Final Summary ----
print("=" * 50)
print("   ALERT SYSTEM COMPLETE!")
print("=" * 50)
print()
print(f"  Status   : {alert_status}")
print(f"  Log File : fraud_alert_log.txt")
print()
