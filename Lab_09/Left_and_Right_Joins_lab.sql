--------------------------------------------- Part B -------------------------------------------------

--Statement1: For each employee, show their name and their manager's name. Top-level managers should still appear with NULL Manager. (SELF JOIN)

--Query1: select e.EmpName As Employee, m.EmpName As Manager from Employee e left join Employee m  on e.ManagerID = m.EmpID;

--Statement2: List employees who earn more than their direct manager. Show employee name, employee salary, manager name, manager salary.

--Query2: select e.EmpName As Employee, e.Salary As EmployeeSalary, m.EmpName As Manager, m.Salary As ManagerSalary from Employee e left join Employee m  on e.ManagerID = m.EmpID where m.Salary>e.Salary;

--Statement3: List employees whose manager works in a different department. Show EmpName, ManagerName, and both department names. (Hint: self-join Employee, then join Department twice with different aliases.)

--Query3: SELECT e.EmpName AS Employee,ed.DeptName AS EmpDept,m.EmpName AS Manager,md.DeptName AS ManagerDept FROM Employee e INNER JOIN Employee m ON e.ManagerID = m.EmpID
-- INNER JOIN Department ed ON e.DeptID = ed.DeptID INNER JOIN Department md ON m.DeptID = md.DeptID WHERE e.DeptID <> m.DeptID;

--Statement4: Show every employee with the project name they work on and weekly hours. (3-table join: Employee → Assignment → Project)

--Query4: select e.EmpName, p.ProjectName , a.HoursPerWeek from Employee e join Project p on e.DeptID= p.DeptID join Assignment a on e.EmpID=a.EmpID;

--Statment5: List every assignment with employee name, project name, and the project's department name. (4-table join)

--Query5:  SELECT e.EmpName, p.ProjectName, d.DeptName FROM Employee e JOIN Assignment a ON e.EmpID = a.EmpID JOIN Project    p ON a.ProjectID = p.ProjectID JOIN Department d ON p.DeptID    = d.DeptID;

--Statement6: List the names and weekly hours of employees working on the Mobile App project.

--Query6: select e.EmpName, a.HoursPerWeek  from Employee e left join Assignment a on e.EmpID = a.EmpID where a.ProjectID =1002;

--Statement7: List every employee in Lahore together with the projects they are assigned to (project name and hours). Include Lahore employees with no assignments.

--Query7: select e.EmpName, p.ProjectName , a.HoursPerWeek from Employee e Join Project p on e.DeptID=p.DeptID Join Assignment a on e.EmpID= a.EmpID where e.City='Lahore';

--Statement8: List the names of employees who work on a project run by a department different from their own. (Compare e.DeptID and p.DeptID.)

--Query8: select e.EmpName, p.ProjectName , d.DeptName from Employee e join Project p on e.DeptID=p.DeptID join Department d on p.DeptID=e.DeptID where e.DeptID = p.DeptID;

--Statement9: For each department, list the names of projects that started in 2024. Include departments that have no such projects. (LEFT JOIN + WHERE on date)

--Query9: select d.DeptName,p.ProjectName, p.StartDate from Project p left join Department d on p.DeptID=d.DeptID where p.StartDate > '2024' & p.StartDate< '2025';

--Statement10: List every employee with the total hours they work per week across all their projects. Include employees with zero hours. (LEFT JOIN + SUM + GROUP BY)

--Query10: SELECT e.EmpID,e.EmpName, COALESCE(SUM(a.HoursPerWeek), 0) AS TotalHours FROM Employee e LEFT JOIN Assignment a ON e.EmpID = a.EmpID GROUP BY e.EmpID, e.EmpName ORDER BY TotalHours DESC;

-----------------------------------------Questions-----------------------------------------------------

--Question1: Show every book with its author's name and country. (INNER JOIN)

--Ans1: select b.Title, a.AuthorName,a.Country from Book b inner join Author a on b.AuthorID=a.AuthorID;

--Question2: Show every author with their books. Authors with no books must still appear once with NULL Title. (LEFT JOIN)

--Ans2: select b.Title, a.AuthorName from Book b left join Author a on b.AuthorID=a.AuthorID;

--Question3: List members who have never borrowed any book. (LEFT JOIN + IS NULL)

--Ans3: select m.MemberName from Member m left join Loan l on m.MemberID=l.MemberID where l.LoanID is null;

--Question4: List every loan with the member's name, book title, and author's name. (3-table join)

--Ans4: select  l.loanID,m.MemberName, b.Title As BookTitle, a.AuthorName from Author join Book b on a.AuthorID=b.AuthorI join loan l on b.BookID=l.BookID join Member m on l.MemberID=m.MemberID;

--Question5: List currently borrowed books (ReturnDate IS NULL) along with the borrower's name and city.

--Ans5: select b.Title,m.MemberName, m.City from Member m join Loan l on m.MemberID=l.MemberID join Book b on l.BookID=b.BookID where l.ReturnDate is Null;

--Question6: List Pakistani authors and the titles of their books. Include Pakistani authors with no books. (LEFT JOIN + WHERE on author country)

--Ans6: select a.AuthorName, b.Title from Author a left join Book b on a.AuthorID=b.AuthorID where a.Country = 'Pakistan';

--Question7: List every book together with the names of all members who have borrowed it. Include books that have never been borrowed. (LEFT JOIN chain)

--Ans7: SELECT b.BookID, b.Title, m.MemberName FROM Book b LEFT JOIN Loan l ON b.BookID = l.BookID LEFT JOIN Member m ON l.MemberID = m.MemberID ORDER BY b.BookID, m.MemberName;

--Question8: Find authors whose books have never been borrowed. (Multi-step: Author → Book → Loan)

--Ans8: SELECT DISTINCT a.AuthorID, a.AuthorName FROM Author a INNER JOIN Book b ON a.AuthorID = b.AuthorID LEFT JOIN Loan l ON b.BookID = l.BookID WHERE l.LoanID IS NULL;

--Question9: Produce a FULL OUTER JOIN of Author and Book using UNION — every author and every book, matched where possible.

--Ans9: select b.BookID, b.Title,b.Genre,b.Price,b.AuthorID,b.PublishedYear from Book b left join Author a on b.BookID=a.AuthorID UNION select b.BookID, b.Title,b.Genre,b.Price,b.AuthorID,b.PublishedYear from Book b right join Author a on b.BookID=a.AuthorID;

--Question10: List members who have borrowed books written by Pakistani authors. Show member name, book title, and author name. (4-way join with filter)

--Ans10: select m.MemberName, b.Title, a.AuthorName from Author a join Book b on a.AuthorID=b.AuthorID join Member m on a.AuthorID=b.AuthorID join loan l on m.MemberID=l.MemberID  where a.Country = 'Pakistan';

