/* ====================================Part B ======================================*/

-- select ProdName , round(Price , 2) As Price, round(Price - Price * 0.15,2) As Discounted_Price from Product;

-- SELECT ProdName , round(Price * 0.17 , 2) As Tax, round(Price + Price * 0.17,2) As Price_with_Tax from Product;

-- select ProdName, Price, floor(Price/1000) As FloorVal, Ceil(Price/1000) As CeilVal from Product;

-- SELECT ProdName, Price, ROUND(Price, -2) AS RoundedToHundred FROM Product;

-- SELECT ProdID, ProdName from Product where MOD(ProdId,2) != 0;

-- Select CustName, JoinDate ,Year(JoinDate) As Year, Monthname(JoinDate) as Month, Dayofweek(JoinDate)AS Day from Customer;

-- select CustName, DOB, Date_format(DOB, '%d %M %Y') as FormattedDate from Customer;

-- select CustName, DOB, timestampdiff(year, DOB, CURRENT_DATE()) As Age from Customer;

-- select CustName, JoinDate, timestampdiff(day, JoinDate, CURRENT_DATE()) As DaysSinceJoin from Customer;

-- select CustName, JoinDate from Customer where year(JoinDate) = '2023';

-- select ProdName, LaunchDate from Product where Month(LaunchDate) In (10,11,12) order by LaunchDate;

-- select CustName, JoinDate from Customer where JoinDate >= Date_sub(curdate(), interval 6 month);

-- select ProdName, LaunchDate, timestampdiff(day,LaunchDate , curdate()) As AgeInDays from Product;

-- SELECT ProdName, LaunchDate, DATE_ADD(LaunchDate, INTERVAL 90 DAY) AS NinetyDaysLater FROM Product;

-- select concat('Hello ', trim(upper(CustName)), ' ,age ',timestampdiff(year, DOB, curdate())  , ' joined: ', date_format(JoinDate, '%M %Y')) as Summary from Customer;

/* =============================================== Questions ================================================*/

-- SELECT EmpID, FullName As Original_Full_Name, trim(upper(FullName)) Cleaned_Name from Employee;

-- SELECT FullName, substring(Email, locate('@', Email) - 6) As Username from Employee;

-- SELECT EmpID, FullName, concat(left(phone, 4), 'XXXXXXX') As phone from Employee where phone is not null;

-- SELECT FullName, concat(trim(lower(replace(FullName, ' ', '.'))),'@company.com') As GeneratedEmail from Employee;

-- SELECT FullName, Salary, round(Salary+ Salary*0.125,2) As NewSalary from Employee;
   
--SELECT FullName, Salary,  FLOOR(Salary / 1000) * 1000 AS RoundedSalary FROM Employee;
-- SELECT FullName, timestampdiff(year, DOB, curdate()) As AgeInYears , timestampdiff(year, HireDate, Curdate()) As yearsOfService from Employee;

-- SELECT FullName, Date_format(HireDate, '%d-%M-%Y') As FormattedHireDate from Employee;

-- SELECT FullName, HireDate from Employee where year(HireDate) >= '2019';

-- SELECT concat(trim(upper(FullName)), ' | ' , City, ' | ' , JobTitle, ' | ', ' Joined: ' , Date_format(HireDate, '%d-%M-%Y'), ' | ', 'Age: ', timestampdiff(year, DOB, curdate())) as Profile from Employee;