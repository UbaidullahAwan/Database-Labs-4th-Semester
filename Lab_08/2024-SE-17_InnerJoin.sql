-- ------------------------------------------ Part A  -------------------------------------------------
--Statement1: List every employee with their department name and location. (INNER JOIN)

--Query1: Select e.EmpName,  d.DeptName, d.Location from Employee e inner join Department d on e.DeptID = d.DeptID;

--Statement2: Same as A1, but include employees whose DeptID is NULL — if any. (LEFT JOIN)

--Query2:  Select e.EmpName,  d.DeptName, d.Location from Employee e left join Department d on e.DeptID = d.DeptID where e.DeptID is NULL;

--Statement3: List every department with the names of its employees. Departments with no employees should still appear once with NULL EmpName.

--Query3: select d.DeptName , e.EmpName from department d left join Employee e on d.DeptID = e.DeptID;

--Statement4: List every project with its department name and location. Include projects that have no department.

--Query4: select p.ProjectName, d.DeptName, d.Location from Project p left join Department d on p.DeptID = d.DeptID;

--Statement5: Find employees who are not assigned to any project. (LEFT JOIN + IS NULL pattern)

--Query5:  select e.EmpName from Employee e left join Assignment a on e.EmpID = a.EmpID where a.EmpID is NULL;

--Statement6: List every project that currently has no assignments.

--Query6: select p.ProjectName from Project p left join Assignment a on p.ProjectID = a.ProjectID where a.ProjectID is NULL;

--Statement7: Show every employee in the Engineering department along with their salary, sorted by salary descending. (INNER JOIN + WHERE)

--Query7: select e.EmpName, e.Salary, d.DeptName from Employee e Inner JOIN Department d on e.DeptID= d.DeptID where d.DeptName = 'Engineering' ORDER BY e.Salary DESC;

--Statement8: List employees in Lahore-based departments. Show EmpName and DeptName.

--Query8: select e.EmpName, d.DeptName from Employee e Inner JOIN Department d on e.DeptID= d.DeptID where d.Location ='Lahore'; 

--Statement9: List every department and the count of how many employees work there (use LEFT JOIN with COUNT and GROUP BY). Include departments with zero employees.

--Query9: SELECT d.DeptID, d.DeptName, COUNT(e.EmpID) AS NumEmployees FROM Department d LEFT JOIN Employee e ON d.DeptID = e.DeptID GROUP BY d.DeptID, d.DeptName ORDER BY NumEmployees DESC;

--Statement10: Produce a FULL OUTER JOIN result of Employee and Department using UNION.

--Query10: select e.EmpID,e.EmpName,e.Gender,e.Salary,e.HireDate,e.City, e.ManagerID, d.DeptName, d.Location,d.Budget from Employee e left JOIN Department d on e.DeptID= d.DeptID  

-- UNION

-- select e.EmpID,e.EmpName,e.Gender,e.Salary,e.HireDate,e.City, e.ManagerID, d.DeptName, d.Location,d.Budget from Employee e right JOIN Department d on e.DeptID= d.DeptID ; 
