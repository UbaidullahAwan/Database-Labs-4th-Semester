-- ------------------------------------------ Part A to be commenced Here -------------------------------------------------

/*

-- A1. List EmpID, EmpName, and Salary of all employees who earn more than 90,000.
SELECT EmpID, EmpName, Salary FROM Employee WHERE Salary > 90000;

-- A2. Show all employees with salary less than or equal to 75,000. Display EmpName and Salary.
SELECT EmpName, Salary FROM Employee WHERE Salary <= 75000;

-- A3. Find every employee who works in Lahore and earns more than 90,000.
SELECT EmpID, EmpName, Salary, City FROM Employee WHERE City = 'Lahore' AND Salary > 90000;

-- A4. List employees in Karachi or Islamabad. Show EmpName and City.
SELECT EmpName, City FROM Employee WHERE City = 'Karachi' OR City = 'Islamabad';

-- A5. Find female employees who are not in the Engineering department.
SELECT EmpID, EmpName, Gender, DeptName FROM Employee WHERE Gender = 'F' AND DeptName <> 'Engineering';

-- A6. Show employees who are male and earn between 70,000 and 90,000
-- using AND and comparison operators only.
SELECT EmpID, EmpName, Gender, Salary FROM Employee WHERE Gender = 'M' AND Salary >= 70000 AND Salary <= 90000;

-- A7. List employees who are either Software Engineers or earn more than 100,000.
SELECT EmpID, EmpName, JobTitle, Salary FROM Employee WHERE JobTitle = 'Software Engineer' OR Salary > 100000;

-- A8. Find employees who are not in Marketing and not in Sales.
SELECT EmpID, EmpName, DeptName FROM Employee WHERE DeptName <> 'Marketing' AND DeptName <> 'Sales';

*/

