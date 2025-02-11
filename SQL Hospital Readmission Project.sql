#Hopsital Readmission Data Cleaning
USE hospital_readmission;
SELECT * 
FROM hospital_readmission.hospital_readmissions;

#Checking missing Values
SELECT COUNT(*) AS total_rows,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
SUM(CASE WHEN time_in_hospital IS NULL THEN 1 ELSE 0 END) AS missing_time,
SUM(CASE WHEN readmitted IS NULL THEN 1 ELSE 0 END) AS missing_readmitted
FROM hospital_readmission.hospital_readmissions;
#no missing values

#Total Count of Patients
SELECT COUNT(*) AS total_pts
FROM hospital_readmissions
;

#Age distribution of pts
SELECT age,
COUNT(*) AS num_pts
FROM hospital_readmissions
GROUP BY age
ORDER BY CAST(SUBSTRING_INDEX(age, '-',1) AS UNSIGNED)
;

#Hospital Readmission Exploratory Data Analysis
#Number of readmitted patients
SELECT COUNT(*) AS total_patients,
SUM(CASE WHEN readmitted = 'yes' THEN 1 ELSE 0 END) AS readmitted_patients
FROM hospital_readmissions
;


#Average length of stay 
SELECT AVG(time_in_hospital) AS avg_length_of_stay
FROM hospital_readmissions
;

#Get readmission vs length of stay
SELECT time_in_hospital, COUNT(*) AS num_readmissions
FROM hospital_readmissions
WHERE readmitted = 'yes'
GROUP BY time_in_hospital
ORDER BY num_readmissions DESC
LIMIT 10
;

#Readmission Rate by age group
SELECT age,
COUNT(*) AS total_patients,
ROUND((SUM(readmitted ='yes')*100.0/COUNT(*)),2) AS readmission_rate
FROM hospital_readmissions
GROUP BY age
ORDER BY CAST(SUBSTRING_INDEX(age, '-',1) AS UNSIGNED)
;

#Most common diagnosis for readmission
SELECT diag_1, COUNT(*) AS readmissions
FROM hospital_readmissions
WHERE readmitted = 'yes'
GROUP BY diag_1
HAVING COUNT(*) > 10
ORDER BY readmissions DESC
LIMIT 5
;

#Readmission rate by diagnosis
SELECT diag_1 AS diagnosis,
COUNT(*) AS total_cases,
SUM(readmitted = 'yes') AS readmitted_cases,
ROUND((SUM(readmitted = 'yes') * 100.0/COUNT(*)),2) AS readmission_rate
FROM hospital_readmissions
GROUP BY diag_1
HAVING COUNT(*)>10
ORDER BY readmission_rate DESC
LIMIT 10
;


#Readmission rate by time in hospital
SELECT time_in_hospital,
COUNT(*) AS total_pts,
SUM(readmitted = 'yes') AS readmitted_pts,
ROUND((SUM(readmitted ='yes')*100.0/COUNT(*)),2) AS readmission_rate
FROM hospital_readmissions
GROUP BY time_in_hospital
ORDER BY time_in_hospital
;



#Medication influence on readmissions
SELECT n_medications, 
COUNT(*) AS total_patients,
SUM(readmitted = 'yes') AS readmitted_cases,
ROUND((SUM(readmitted ='yes')*100.0/COUNT(*)),2) AS readmission_rate
FROM hospital_readmissions
GROUP BY n_medications
HAVING COUNT(*)>50
ORDER BY readmission_rate DESC
LIMIT 10
;

