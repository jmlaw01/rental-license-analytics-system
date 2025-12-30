# Rental License Analytics System

This project is an end‑to‑end data engineering and analytics solution built to clean, normalize, and analyze Baltimore rental license data. It demonstrates a complete workflow from raw CSV files → Python ETL → a normalized SQL database → reusable reporting views → an interactive Power BI dashboard.

The goal is to transform messy, inconsistent source data into a scalable, validated, and analytics‑ready model suitable for compliance reporting and operational insights.

---

## 🚀 Features

### **Python ETL Pipeline**
- Cleans and normalizes raw CSV files
- Standardizes and deduplicates property addresses
- Validates selectors and business rules
- Loads data into a structured SQL schema
- Modular design for maintainability and reuse

### **Normalized SQL Database**
- Staging → cleaned dimension and fact tables
- Foreign key validation and unique constraints
- Surrogate keys for consistent relationships
- Reusable SQL views for reporting

### **Power BI Dashboard**
- Star schema with a shared Date dimension
- Time‑intelligence measures (active licenses, expirations, trends)
- Interactive visuals for compliance and property insights
- Optimized model for performance and scalability

---

## 🏗️ Architecture

*[architecture_diagram.pdf](https://github.com/user-attachments/files/24387002/architecture_diagram.pdf)*
Raw CSVs -> Python ETL (cleaning, normalization, validation) -> MySQL Database (normalized schema) -> SQL Views (reporting layer) -> Power BI Dashboard

---

## ⚠️ Data Challenges & Constraints

Real‑world data is messy — these constraints shaped the system’s design:

- Source data split across multiple CSVs with inconsistent formats  
- Non‑standardized property addresses requiring normalization  
- No shared Date dimension for time‑based reporting  
- Business rules requiring one license per property  
- Need for validated, compliance‑ready reporting  
- Power BI performance considerations as data volume grows  

These constraints justify the normalization, validation logic, and view‑based modeling used throughout the project.

---

## 🔄 How It Works

### **1. Extract**
Raw CSV files are loaded and profiled for structure, duplicates, and inconsistencies.

### **2. Transform**
Python scripts perform:
- Address standardization  
- Deduplication  
- Foreign key validation  
- Surrogate key creation  
- Data type enforcement  

### **3. Load**
Cleaned data is inserted into a normalized MySQL schema using `load_data.sql`.

### **4. Model**
SQL views abstract complexity and provide a stable interface for reporting tools:
- `current_license_summary`  
- `license_time_series`  


### **5. Visualize**
Power BI connects to the views and provides:
- Time‑intelligence analysis  
- Active license snapshots  
- Property‑level insights  
- Interactive filtering  

---

## 📊 Dashboard Preview

![Baltimore_City_Visuals_December](https://github.com/user-attachments/assets/9e9366e6-b634-4130-8667-14b9c505d86c)
![Baltimore_City_Visuals_April](https://github.com/user-attachments/assets/fed4825e-9b37-40ff-b470-425c49a35213)

---

## 📁 Repository Structure

/etl/               # Python scripts for cleaning, normalization, and loading 
/sql/
  schema.sql      # Full normalized schema (tables, keys, constraints) 
  load_data.sql   # Inserts cleaned data into the schema 
  views.sql       # Reporting views for Power BI 
/powerbi/         # PBIX file and/or dashboard screenshots 
/docs/            # Architecture diagram, notes, supporting documentation 
  README.md           # Project overview and documentation

---

## 🧠 What I Learned

- Designing normalized schemas for messy real‑world data  
- Building reusable SQL views for analytics and BI tools  
- Creating a shared Date table and time‑intelligence measures  
- Reconciling discrepancies between Excel and SQL  
- Structuring ETL pipelines for clarity, validation, and scalability  
- Modeling data in Power BI using star schema principles  
- Communicating technical decisions clearly for interviews and stakeholders  

---

## 📌 Future Enhancements

- Automate ETL with scheduled runs  
- Add incremental refresh logic  
- Expand dashboard KPIs  
- Integrate additional data sources  
- Deploy database to a cloud host for live demos  

---

## 📬 Contact

If you'd like to discuss the project, architecture, or implementation details, feel free to reach out.

