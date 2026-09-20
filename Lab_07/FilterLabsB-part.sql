

/* --------------------------------------------------B------------------------------------------------ */

-- B1. List employees with salary between 75,000 and 100,000 inclusive.
-- Sort by salary ascending.

-- SELECT EmpID, EmpName, Salary FROM Employee WHERE Salary BETWEEN 75000 AND 100000 ORDER BY Salary ASC;

-- B2. List employees hired between January 2020 and December 2022.

-- SELECT EmpID, EmpName, HireDate FROM Employee WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';

-- B3. Show employees whose salary is not between 80,000 and 100,000.

-- SELECT EmpID, EmpName, Salary FROM Employee WHERE Salary NOT BETWEEN 80000 AND 100000;

-- B4. List employees whose city is Lahore or Islamabad.
-- Sort by city, then by salary descending.

-- SELECT EmpID, EmpName, City, Salary FROM Employee WHERE City IN ('Lahore', 'Islamabad') ORDER BY City ASC, Salary DESC;

-- B5. Find employees in any department except Engineering, Sales, and HR.

-- SELECT EmpID, EmpName, DeptName FROM Employee WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');

-- B6. Show all employees whose name starts with the letter M.

-- SELECT EmpName FROM Employee WHERE EmpName LIKE 'M%';

-- B7. Find employees whose name contains the letter a anywhere.

-- SELECT EmpID, EmpName FROM Employee WHERE EmpName LIKE '%a%';

-- B8. Find employees whose name ends with 'an'.

-- SELECT EmpID, EmpName FROM Employee WHERE EmpName LIKE '%an';

-- B9. Show employees whose job title contains the word Engineer
-- but who do not work in the Engineering department.

-- SELECT EmpID, EmpName, JobTitle, DeptName FROM Employee WHERE JobTitle LIKE '%Engineer%' AND DeptName <> 'Engineering';

-- B10. List the names of employees who do not have a recorded city.

--SELECT EmpName FROM Employee WHERE City IS NULL;

-- B11. List employees who have a recorded city, sorted alphabetically by city.

-- SELECT EmpID, EmpName, City FROM Employee WHERE City IS NOT NULL ORDER BY City ASC;

-- B12. Display the 3 highest paid employees. Show EmpName and Salary.

-- SELECT EmpName, Salary FROM Employee ORDER BY Salary DESC LIMIT 3;

-- B13. Display the 5 most recently hired employees.

-- SELECT EmpID, EmpName, HireDate FROM Employee ORDER BY HireDate DESC LIMIT 5;

-- B14. List the bottom 3 salaries in the company, lowest first.

-- SELECT EmpID, EmpName, Salary FROM Employee ORDER BY Salary ASC LIMIT 3;

-- B15. Show all employees, sorted by department ascending,
-- then by hire date ascending within each department.

-- SELECT EmpID, EmpName, DeptName, HireDate FROM Employee ORDER BY DeptName ASC, HireDate ASC;

/* --------------------------------------------------Questions------------------------------------------------ */

-- Q1. List all books with a price greater than 1500. Show Title and Price.

-- SELECT Title, Price FROM Book WHERE Price > 1500;

-- Q2. Find all books published between 1900 and 2000.

-- Show Title and PublishedYear, sorted by year.

-- SELECT Title, PublishedYear FROM Book WHERE PublishedYear BETWEEN 1900 AND 2000 ORDER BY PublishedYear ASC;

-- Q3. List books in Fiction or Mystery genre with stock greater than 5.

--SELECT BookID, Title, Genre, StockQty FROM Book WHERE Genre IN ('Fiction', 'Mystery') AND StockQty > 5;

-- Q4. Find books whose title contains the word 'the' anywhere.
-- Show Title and Author.

--SELECT Title, Author FROM Book WHERE Title LIKE '%the%';

-- Q5. List books whose title starts with the letter A or ends with t.

-- SELECT BookID, Title FROM Book WHERE Title LIKE 'A%' OR Title LIKE '%t';

-- Q6. Find books with no recorded author. Show Title.

-- SELECT Title FROM Book WHERE Author IS NULL;

-- Q7. List books that are out of stock or have an unknown publisher.

-- SELECT BookID, Title, StockQty, Publisher FROM Book WHERE StockQty =  OR Publisher IS NULL;

-- Q8. Show the 3 most expensive books in stock.

-- SELECT Title, Price, StockQty FROM Book WHERE StockQty > 0 ORDER BY Price DESC sLIMIT 3;

-- Q9. Display all books written in Urdu, sorted by published year ascending.

-- SELECT BookID, Title, Author, PublishedYear, Language FROM Book WHERE Language = 'Urdu' ORDER BY PublishedYear ASC;

-- Q10. List books published before the year 2000 with a price under 1200,
-- sorted by genre and then by title.

-- SELECT BookID, Title, Genre, Price, PublishedYear FROM Book WHERE PublishedYear < 2000 AND Price < 1200 ORDER BY Genre ASC, Title ASC;




