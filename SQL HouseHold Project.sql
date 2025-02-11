#US Household Income Data Cleaning 

#Renaming id column in statistics
 
ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT * 
FROM us_project.us_household_income
;

SELECT * 
FROM us_project.us_household_income_statistics
;

#Finding Duplicates from us_project.us_household_income
SELECT id, 
COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

#Removing Duplicates from us_project.us_household_income
SELECT *
FROM (
	SELECT row_id,
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
        ) duplicates
	WHERE row_num > 1
;

DELETE FROM us_household_income
WHERE row_id IN (
		SELECT row_id
		FROM (
			SELECT row_id,
			id, 
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
			FROM us_project.us_household_income
			) duplicates
	WHERE row_num > 1)
;

#Finding duplicates from us_project.us_household_income_statistics
SELECT id, 
COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

#Fixing State Name column ('georia' to 'Georgia')
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

#Fixing State Name column ('alabama' to'Alabama')
UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

#Fixing Place column (missing values)
SELECT *
FROM us_project.us_household_income
WHERE Place = ''
;

SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

#Updating Tpye column
SELECT Type,
COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
ORDER BY 1
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

#Updating missing, null, 0 on Aland, AWater Column
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;

#US Household Income Exploratory Data Analysis

SELECT * 
FROM us_project.us_household_income
;

SELECT * 
FROM us_project.us_household_income_statistics
;

#Sum of area of land and water by State
SELECT State_Name, 
SUM(ALand), SUM(AWater),
SUM(ALand) + SUM(AWater) AS Total_of_land_and_water
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY Total_of_land_and_water DESC
;

#Top 10 States with Largest Land
SELECT State_Name, 
SUM(AWater),
SUM(Aland) AS Total_Land
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY Total_Land DESC
LIMIT 10
;

#Top 10 States with Largest Water
SELECT State_Name, 
SUM(AWater) AS Total_Water,
SUM(Aland) AS Total_Land
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY Total_Water DESC
LIMIT 10;

#Filter out 0 values for mean
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

#Average and Median Household income by State
SELECT u.State_Name,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
;

# Top 10 States with the Lowest Average Income
SELECT u.State_Name,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10
;

#Top 10 States with the Highest Average Income
SELECT u.State_Name,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name 
ORDER BY 2 DESC
LIMIT 10
;

#Filtering Average/Median Income by community Type
SELECT Type,
COUNT(Type),
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY ROUND(AVG(Mean),1) DESC
;

