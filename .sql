# employee-analytics-dashborad
An interactive Power BI Employee Analytics Dashboard that provides insights, and department-wise trends. Designed to help HR and managers make data-drive decisions with clear visualization and actionable metrics.
# import raw data
SELECT *
FROM EmployeeMaster_Raw;
## DATA CLEANING
# removing duplicates employee
DELECT FROM EmployeeMaster_Raw

WHERE EmployeeID IN (

    SELECT EmployeeID
    
    FROM (
    
        SELECT EmployeeID,
        
               ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY EmployeeID) AS rn
               
        FROM EmployeeMaster_raw
        
    ) t
    
    WHERE rn > 1
    
);

# handling missing values

UPDATE EmployeeMaster_raw

SET Salary = 0

WHERE Salary IS NULL OR Salary = '';

# handling missing performances

UPDATE EmployeeMaster_raw

SET PerformanceRating = 0

WHERE PerformanceRating IS NULL;

# fix joining month format

UPDATE EmployeeMaster_raw

SET JoiningDate = CONVERT(month, JoiningDate, 103);

# DATA AGGREGATION FOR POWER BI DASHBOARD

# Salary Analysis

# Salary by Department

SELECT Department, SUM(Salary) AS TotalSalary

FROM EmployeeMaster_clean

GROUP BY Department;

# Salary by Job Title

SELECT JobTitle, SUM(Salary) AS TotalSalary

FROM EmployeeMaster_clean

GROUP BY JobTitle

ORDER BY TotalSalary DESC;


# Employee Distribution

# Count by Gender

SELECT Gender, COUNT(*) AS EmployeeCount

FROM EmployeeMaster_clean

GROUP BY Gender;


# Count by Department

SELECT Department, COUNT(*) AS HeadCount

FROM EmployeeMaster_clean

GROUP BY Department;


# Performance Analysis

# Average Performance Rating by Department

SELECT Department, AVG(PerformanceRating) AS AvgRating

FROM EmployeeMaster_clean

GROUP BY Department;

# Performance Rating Distribution

SELECT PerformanceRating, COUNT(*) AS TotalEmployees

FROM EmployeeMaster_clean

GROUP BY PerformanceRating;



# Experience Analysis

# Average Experience by Department

SELECT Department, AVG(Experience) AS AvgExperience

FROM EmployeeMaster_clean

GROUP BY Department;


# Experience by Employee

SELECT EmployeeID, Name, Experience

FROM EmployeeMaster_clean;


# Joining Trend

# Employees Joined Per Year

SELECT JoiningYear, COUNT(*) AS EmployeesJoined

FROM EmployeeMaster_clean

GROUP BY JoiningYear

ORDER BY JoiningYear;
