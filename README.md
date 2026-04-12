# 📊 Customer Churn & Retention Analysis

🚀 **End-to-End Data Analytics Project | SQL • Python • Excel • Power BI**

---

## 📌 Project Overview

This project analyzes customer churn behavior to uncover **why customers leave, who is at risk, and how businesses can improve retention**.

The goal was to simulate a real-world business scenario:
> Turning raw, messy data into **actionable insights** that drive strategic decisions.

---

## 🎯 Key Business Questions

- Which customers are most likely to churn?
- How does contract type affect churn?
- Do pricing and billing methods influence churn?
- Which services reduce customer churn?
- What is the revenue impact of churn?

---

## 📊 Key Insights

- 📉 **Month-to-month contracts** have the highest churn rate  
- ⏳ **New customers (0–12 months)** churn the most  
- 💳 Certain **payment methods** are linked to higher churn  
- 💰 High-value customers (CLTV) churn → **major revenue risk**  
- 🛠 Customers with **tech support & security services** churn less  

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|------|--------|
| **Python (Pandas, NumPy)** | Data cleaning & EDA |
| **PostgreSQL** | Business analysis & querying |
| **Excel** | KPI dashboards & quick insights |
| **Power BI** | Interactive dashboards & storytelling |

---

## 🧹 Data Cleaning & Preparation

- Handled missing and inconsistent values  
- Fixed CSV formatting issues  
- Converted data types (numeric, categorical)  
- Standardized column names  
- Removed irrelevant columns  
- Exported clean dataset for analysis  

---

## 🐍 Exploratory Data Analysis (EDA)

Key analysis performed:

- Churn distribution
- Tenure vs churn behavior
- Monthly charges vs churn
- Contract type analysis
- Service usage impact

---

## 🗄 SQL Analysis

Key queries answered:

- Churn rate by contract, tenure, and payment method  
- Revenue lost due to churn  
- High-value churned customers  
- Customer segmentation (High / Medium / Low value)  
- Churn risk profiling  

### Example Query

```sql
SELECT
    contract,
    COUNT(*) AS customers,
    ROUND(AVG(churn_value) * 100, 2) AS churn_rate
FROM churn_data
GROUP BY contract
ORDER BY churn_rate DESC;
📊 Power BI Dashboard
🔹 Features
KPI Cards:
Total Customers
Churn Rate
Revenue Lost
Average CLTV
Visuals:
Churn by Contract (Bar Chart)
Churn by Tenure Group (Column Chart)
Revenue vs Churn (Line Chart)
Top Churn Reasons (Bar Chart)
Customer Segments (Donut Chart)
Interactive Filters:
Contract
Payment Method
Internet Service
🎨 Dashboard Design Focus
Clean, recruiter-level layout
Consistent color theme (dark blue)
Clear business storytelling
Insight-driven visuals (not cluttered)
📸 Dashboard Preview

👉 Add your Power BI dashboard screenshot here

📂 Project Structure
customer-churn-retention-analysis/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   └── churn_analysis.ipynb
│
├── sql/
│   └── churn_analysis.sql
│
├── powerbi/
│   └── churn_dashboard.pbix
│
└── README.md

💡 What I Learned
Data cleaning is 80% of the work
SQL is critical for business insight extraction
Good dashboards focus on clarity, not complexity
Small data issues can break entire pipelines
Churn analysis is essential for business growth strategy
💼 About Me

I’m a Junior Data Analyst with a background in Applied Statistics & IT, passionate about transforming data into insights that drive decisions.

🔗 Let’s Connect
💼 LinkedIn: https://linkedin.com/in/vera-data-analyst
📧 Email: veranhemakinya@gmail.com
⭐ Support This Project

If you found this useful:

⭐ Star the repo
🍴 Fork it
💬 Share feedback
📌 Tags

python sql powerbi data-analysis dashboard business-intelligence churn-analysis analytics


---