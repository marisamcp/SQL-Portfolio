# Project 1 (Hospital Readmission Dataset)

## 📊 Dataset Overview  
This dataset contains information on hospital patient admissions and readmissions. The goal is to analyze factors contributing to readmission rates and identify patterns that could help improve patient care.  

## 📌 Key Data Fields  
- `Age Range` – Unique identifier for each patient  
- ` Time_in_hospital`- Number of days spent in the hospital
- `Readmission_Flag` – Indicates if a patient was readmitted within 30 days (Yes,No)  
- `Diagnosis_identifier` – Diagnosis for the primary condition  
- `Length_of_Stay` – Number of days admitted  
- `diabetes_med`- Is the pt taking diabetes medication (Yes,No)

## 📈 Data Source  
- **Possible sources:** Public health datasets (Kaggle)  
- **Assumptions:** This dataset represents a sample of hospital readmissions over a specific period.  

# Key Insights: Hospital Readmission Analysis  

## 🔎 Objective  
- Identify factors influencing patient readmissions within 30 days.
- Use SQL techniques such as aggregation, window functions, and data transformation to extract insights from large datasets.

## 📊 Key Findings  
✔ **High readmission rates** were observed among patients with chronic circulatory conditions.  
✔ **Lower readmission rates** were observed among patients with chronic conditions like diabetes and digestive conditions. 
✔ **Length of Stay (LOS) and readmission rates** showed a strong correlation, with longer initial stays leading to higher readmissions.  
✔  **Number of Medications** patients witha higher medcation intake showed higher readmission rates

## 📌 SQL Techniques Used  
- **Joins** to combine patient demographics, diagnoses, and cost data.  
- **Window Functions** to calculate rolling readmission rates.  
- **CTEs** for segmenting high-risk patients.


# Project 2 World Life Expectancy Dataset  

## 📊 Dataset Overview  
This dataset contains global life expectancy data along with factors such as GDP, healthcare spending, and population demographics. The goal is to identify key determinants of longevity across countries.  

## 📌 Key Data Fields  
- `Country` – Name of the country
- `Status` -Developing or Developed
- `Year` – Year of recorded data  
- `Life_Expectancy` – Average life expectancy in years  
- `GDP_Per_Capita` – Economic output per person  
- `Healthcare_Expenditure` – % of GDP spent on healthcare  
- `Infant_Mortality_Rate` – Infant deaths per 1,000 live births  
- `Schooling` – Measure of education levels

  # Key Insights: World Life Expectancy Analysis  

## 🔎 Objective  
- Analyze factors influencing life expectancy across different nations.  
- Identify correlations between economic indicators and longevity.  

## 📊 Key Findings  
✔ **Higher GDP per capita** correlated with increased life expectancy, particularly in developed nations.  
✔ **Healthcare expenditure** played a crucial role in extending lifespan, especially in countries with universal healthcare.  
✔ **Infant mortality rates** had a strong inverse relationship with life expectancy.  
✔ **Education levels** showed a positive impact on longevity, reinforcing the importance of public education policies.  

## 📌 SQL Techniques Used  
- **Joins** to combine life expectancy, economic, and healthcare data.  
- **Window Functions** to calculate year-over-year changes in life expectancy.  
- **Aggregations & Correlation Analysis** to identify statistical relationships.  


## 📈 Data Source  
- **Possible sources:** Kaggle datasets  
- **Assumptions:** The dataset includes annual records for multiple countries.  





# Project 3 (Household Income Dataset)
**Household Spending Dataset Overview**

📊 **Dataset Overview**  
This project focuses on cleaning and analyzing **US Household Income** data. The goal is to:
- **Perform data cleaning** (remove duplicates, rename columns, handle missing values).
- **Explore household income distribution** across different states and income brackets.
- **Extract key insights** using SQL queries.

## 📌 Key Data Fields 
## 📊 Tables Used:
1. **us_household_income** – Contains household-level income data.
2. **us_household_income_statistics** – Aggregated statistics on household income.
- **Key Identifier**: Unique identifier for each entry.
-**Mean/Median Income**: Average and median income for each community.  
- **Type**: Classification of the community (e.g., county, town, borough).  
- **Area of Land**: Total land area.  
- **Area of Water**: Total water area.

 ## 🔎 Objective  
- Analyze income distribution across different states and income brackets to identify economic trends. 
- Use SQL techniques such as aggregation, window functions, and data transformation to extract insights from large datasets.

## 📊 Key Findings 
✔ High-income states have a significantly higher median income, indicating economic disparities.
✔ Data inconsistencies were found and fixed, improving dataset quality.
✔ Most households fall within middle-income brackets, while extreme low/high-income groups are less common.

📈 **Data Source**  

Potential source: Kaggle Datasets.


