# 📊 Customer Churn Prediction & Retention Dashboard
This project uses R and Tableau to analyze, predict, and visualize customer churn for a telecom company. It demonstrates the full data analysis lifecycle—from cleaning and modeling to business visualization—ideal for showcasing Data Analyst skills.

## 🧰 Tools & Technologies Used

- **R** – tidyverse, ggplot2, logistic regression  
- **Tableau** – Dashboard development and visualization  
- **CSV** – Exported model predictions  
- **Dataset** – Telco Customer Churn dataset

## 📈 Project Workflow

### 🔹 Step 1: Data Cleaning & Exploration (in R)
- Loaded Telco dataset and converted variables to appropriate formats
- Cleaned missing values and summarized churn distribution
- Used `ggplot2` to visualize churn trends by contract type, tenure, and charges

### 🔹 Step 2: Predictive Modeling (in R)
- Built a **logistic regression model** to predict churn using key features:  
  `tenure`, `MonthlyCharges`, `TotalCharges`, `Contract`
- Predicted churn probabilities for customers
- Segmented customers into:
  - **High Risk** (> 0.7)
  - **Medium Risk** (> 0.4 and ≤ 0.7)
  - **Low Risk** (≤ 0.4)
- Exported prediction results as `churn_predictions.csv`

### 🔹 Step 3: Visualization & Dashboard (in Tableau)
- Imported the churn predictions into Tableau
- Created an **interactive dashboard** showing:
  - Overall churn rate
  - Churn by contract type
  - Breakdown of churn risk categories
  - List of high-risk customers for business targeting

## 🔍 Key Insights

- Majority of **high-risk churners** were on **month-to-month contracts** with high charges  
- Customers with **longer tenure** and **2-year contracts** had **lower churn probability**


