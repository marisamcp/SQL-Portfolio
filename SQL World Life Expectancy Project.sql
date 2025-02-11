#World Life Expectancy Project (Data Cleaning)

SELECT * 
FROM world_life_expectancy
;

#Remove Duplicate Rows
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country,Year)) > 1
;

SELECT *
FROM (
	SELECT Row_id, 
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
	Row_Id IN (
    SELECT Row_Id
FROM (
	SELECT Row_id, 
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
)
;

SELECT * 
FROM world_life_expectancy
;

#Updating Status Column

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2. Status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2. Status = 'Developed'
;

SELECT * 
FROM world_life_expectancy
;

#Updating Life Expectancy Columns to fix missing values

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

#Find Outliers in Life Expectancy
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` < 40 OR `Life expectancy` > 90
;

#World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
From world_life_expectancy
;

#Trends in Life Expectancy

#Top 10 Countries with the highest Average Life Expectancy
SELECT Country,
ROUND(AVG(`Life expectancy`),1) AS AVG_life_expectancy
FROM world_life_expectancy
WHERE `Life expectancy` IS NOT NULL
GROUP BY Country
ORDER BY AVG_life_expectancy DESC
LIMIT 10
;

#Average Life Expectancy By Country
SELECT Country,
ROUND(AVG(`Life expectancy`),1) AS AVG_life_expectancy
FROM world_life_expectancy
WHERE `Life expectancy` IS NOT NULL
GROUP BY Country
;

#Life Expectancy Over 15 year span by Country
SELECT Country, 
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`), 1) AS LIFE_INCREASE_OVER_15_YEARS
From world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY LIFE_INCREASE_OVER_15_YEARS DESC
;

#Average Life Expectancy based by year
SELECT YEAR, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

#Maximum Life Expectancy by Status
SELECT Status,
MAX(`Life expectancy`) AS Max_life_exp
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Status
;

SELECT Status,
MIN(`Life expectancy`) AS Min_life_exp
FROM world_life_expectancy
WHERE `Life expectancy`  != '0'
GROUP BY Status
;

#Correlation Between Life Expectancy and GDP
SELECT Country, 
ROUND(AVG( `Life expectancy`),1) AS average_life,
ROUND(AVG(GDP),1) AS average_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING average_life > 0
AND average_GDP > 0
ORDER BY average_GDP DESC
;

#Case Statement to filter high or low life expectancy/high or low GDP 
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END),1) AS High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END),1) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

#Correlation between life expectancy and Country Status
SELECT Status,
ROUND(AVG(`Life expectancy`),1),
COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;

#Total GDP filtered between Developed and Developing Countries
SELECT Status,  
    SUM(GDP) AS Total_GDP  
FROM world_life_expectancy  
WHERE GDP IS NOT NULL  
GROUP BY Status
;  


#Correlation of BMI and Life Expectancy based on Country
SELECT Country,
ROUND(AVG(`Life expectancy`),1) AS AVG_Life_Exp,
Round(AVG(BMI),1) AS AVG_BMI
FROM world_life_expectancy
GROUP BY Country
Having AVG_Life_Exp > 0
AND AVG_BMI > 0
ORDER BY AVG_BMI DESC
;

#Correlation of BMI and GDP based on Country
SELECT Country,
ROUND(AVG(GDP),1) AS AVG_GDP,
ROUND(AVG(BMI),1) AS AVG_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_GDP > 0
AND AVG_BMI > 0
ORDER BY AVG_BMI DESC
;

#Number of Deaths each year compared to Life Expectancy
SELECT COUNTRY,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE 'United States of America'
;

