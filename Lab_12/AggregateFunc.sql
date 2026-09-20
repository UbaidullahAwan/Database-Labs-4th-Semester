-- ======================================Part A ========================================

/*
  Statement 1:  Count the total number of customers, products, and orders in the database (three separate queries or one with three columns).

  Query 1:      SELECT (SELECT COUNT(*) FROM Customer) AS TotalCustomers,(SELECT COUNT(*) FROM Product) AS TotalProducts,
                (SELECT COUNT(*) FROM OrderItem) AS TotalOrders;

  Statement 2:  Find the cheapest and most expensive products. Show MinPrice and MaxPrice.

  Query 2:      SELECT MIN(Price) AS MinPrice,MAX(Price) AS MaxPrice FROM Product;

  Statement 3:  What is the average price of all products? Round to 2 decimal places.

  Query 3:      SELECT ROUND(AVG(Price), 2) AS AvgPrice FROM Product;

  Statement 4:  What is the total stock quantity across all products?

  Query 4:      SELECT SUM(StockQty) AS TotalStock FROM Product;

  Statement 5:  How many distinct cities do customers live in (ignoring NULL)?

  Query 5:      SELECT COUNT(DISTINCT City) AS DistinctCities FROM Customer;

  Statement 6:  How many distinct categories of products are there?

  Query 6:      SELECT COUNT(DISTINCT Category) AS DistinctCategories FROM Product;

  Statement 7:  How many customers have a recorded city? How many do not? (Two queries.)

  Query 7:      SELECT COUNT(City) AS CustomersWithCity FROM Customer;

  Statement 8:  Find the earliest and latest order date in the system.

  Query 8:      SELECT MIN(OrderDate) AS EarliestOrder,MAX(OrderDate) AS LatestOrder FROM OrderItem;

  Statement 9:  Compute the total revenue from all orders. Revenue per row = Quantity * Price; total = SUM of all rows. (Hint: JOIN OrderItem with Product.)

  Query 9:      SELECT SUM(o.Quantity * p.Price) AS TotalRevenue FROM OrderItem o JOIN Product p ON o.ProdID = p.ProdID;

  Statement 10:  Compute the average quantity per order (average of Quantity column in OrderItem). Round to 2 decimals.

  Query 10:      SELECT ROUND(AVG(Quantity), 2) AS AvgQuantity FROM OrderItem;

*/






-- ======================================Part B ========================================

/*
  Statement 1:  Number of customers in each city. Sort by count descending. (GROUP BY.)

  Query 1:      SELECT City, COUNT(*) AS NumCustomers FROM Customer GROUP BY City ORDER BY NumCustomers DESC;

  Statement 2:  Number of products in each category. Sort by count descending.

  Query 2:      SELECT Category, COUNT(*) AS NumProducts FROM Product GROUP BY Category ORDER BY NumProducts DESC;
  
  Statement 3:  For each product category, find the average, minimum, and maximum price. Sort by average price descending.

  Query 3:      SELECT Category, ROUND(AVG(Price), 2) AS AvgPrice, MIN(Price) AS MinPrice,MAX(Price) AS MaxPrice
                FROM Product GROUP BY Category ORDER BY AvgPrice DESC;

  Statement 4:  Total stock quantity per category. Sort by total descending.

  Query 4:      SELECT Category, SUM(StockQty) AS TotalStock FROM Product GROUP BY Category
                ORDER BY TotalStock DESC;

  Statement 5:  Number of orders placed in each year. Show Year and NumOrders, sorted by year. (Hint: use YEAR() from Lab #3.)

  Query 5:      SELECT YEAR(OrderDate) AS Year, COUNT(*) AS NumOrders FROM OrderItem GROUP BY YEAR(OrderDate)
                ORDER BY Year;

  Statement 6:  Number of orders placed each month of 2024. Show Month (1–12) and NumOrders, sorted by month.

  Query 6:      SELECT MONTH(OrderDate) AS Month, COUNT(*) AS NumOrders FROM OrderItem WHERE YEAR(OrderDate) = 2024
                GROUP BY MONTH(OrderDate) ORDER BY Month;

  Statement 7:  Find product categories where the average price is greater than 5,000. (GROUP BY + HAVING.)

  Query 7:      SELECT Category, ROUND(AVG(Price), 2) AS AvgPrice FROM Product GROUP BY Category HAVING AVG(Price) > 5000;

  Statement 8:  Find cities with more than 1 customer (exclude NULL city). (WHERE + GROUP BY + HAVING.)

  Query 8:      SELECT City, COUNT(*) AS NumCustomers FROM Customer WHERE City IS NOT NULL GROUP BY City
                HAVING COUNT(*) > 1;

  Statement 9:  For each customer, count how many orders they have placed. Include customers with zero orders. (LEFT JOIN + COUNT.)

  Query 9:      SELECT c.CustID, c.CustName, COUNT(o.OrderID) AS NumOrders FROM Customer c LEFT JOIN OrderItem o ON c.CustID = o.CustID
                GROUP BY c.CustID, c.CustName ORDER BY NumOrders DESC;

  Statement 10:  Total quantity sold for each product. Show ProdName and TotalQty, sorted by TotalQty descending. Include products that have never been sold (TotalQty should be 0 or NULL). (LEFT JOIN.)

  Query 10:      SELECT p.ProdName, COALESCE(SUM(o.Quantity), 0) AS TotalQty FROM Product p LEFT JOIN OrderItem o ON p.ProdID = o.ProdID
                 GROUP BY p.ProdID, p.ProdName ORDER BY TotalQty DESC;

  Statement 11:  Total revenue (Quantity * Price) per product category. Sort by revenue descending.

  Query 11:      SELECT p.Category, SUM(o.Quantity * p.Price) AS Revenue FROM OrderItem o JOIN Product p ON o.ProdID = p.ProdID
                GROUP BY p.Category ORDER BY Revenue DESC;

  Statement 12:  For each customer, compute their total spend. Show CustName and TotalSpend, sorted descending. Include customers with no orders. (LEFT JOIN.)

  Query 12:      SELECT c.CustName, COALESCE(SUM(o.Quantity * p.Price), 0) AS TotalSpend FROM Customer c LEFT JOIN OrderItem o ON c.CustID = o.CustID LEFT JOIN Product p ON o.ProdID = p.ProdID
                 GROUP BY c.CustID, c.CustName ORDER BY TotalSpend DESC;

 Statement 13:  List customers whose total spend exceeds 50,000. Show CustName and TotalSpend. (HAVING.)

  Query 13:      SELECT c.CustName, SUM(o.Quantity * p.Price) AS TotalSpend FROM Customer c JOIN OrderItem o ON c.CustID = o.CustID JOIN Product p ON o.ProdID = p.ProdID GROUP BY c.CustID, c.CustName
                  HAVING SUM(o.Quantity * p.Price) > 50000 ORDER BY TotalSpend DESC;

 Statement 14:  For each city, count the number of customers and total revenue generated by them. Include only cities with more than 1 customer. (GROUP BY + HAVING.)

  Query 14:      SELECT c.City, COUNT(DISTINCT c.CustID) AS NumCustomers COALESCE(SUM(o.Quantity * p.Price), 0) AS TotalRevenue FROM Customer c LEFT JOIN OrderItem o ON c.CustID = o.CustID LEFT JOIN Product p ON o.ProdID = p.ProdID
                 WHERE c.City IS NOT NULL GROUP BY c.City HAVING COUNT(DISTINCT c.CustID) > 1 ORDER BY TotalRevenue DESC;

Statement 15: Find the top 3 best-selling products by total quantity sold. (GROUP BY + ORDER BY + LIMIT.)

  Query 15:      SELECT p.ProdName, SUM(o.Quantity) AS TotalQty FROM OrderItem o JOIN Product p ON o.ProdID = p.ProdID GROUP BY p.ProdID, p.ProdName
                  ORDER BY TotalQty DESC LIMIT 3;

Statement 16:  For each year, compute the total revenue. Show Year and Revenue, sorted by year.

  Query 16:      SELECT YEAR(o.OrderDate) AS Year, SUM(o.Quantity * p.Price) AS Revenue FROM OrderItem o JOIN Product p ON o.ProdID = p.ProdID
                 GROUP BY YEAR(o.OrderDate) ORDER BY Year;

Statement 17:  Find the average order value (revenue per order). Group by OrderID first to get each order's value, then average those values. (Two-step thinking — you may use the AVG of SUM trick or a subquery.)

  Query 17:      SELECT ROUND(AVG(OrderRevenue), 2) AS AvgOrderValue FROM ( SELECT o.OrderID, SUM(o.Quantity * p.Price) AS OrderRevenue FROM OrderItem o JOIN Product p ON o.ProdID = p.ProdID
                 GROUP BY o.OrderID) AS OrderTotals;


*/



/* ======================================== Assessment Questions============================================== */

/*  Q1. How many students and how many courses are there? (Two values in one query.)?

    Ans1: SELECT (SELECT COUNT(*) FROM Student) AS TotalStudents, (SELECT COUNT(*) FROM Course) AS TotalCourses;

    Q2. How many distinct cities do students come from (ignore NULL)?

    Ans2: SELECT COUNT(DISTINCT City) AS DistinctCities FROM Student;

    Q3. Compute the average, minimum, and maximum Marks across all enrollments.

    Ans3: SELECT ROUND(AVG(Marks), 2) AS AvgMarks, MIN(Marks) AS MinMarks, MAX(Marks) AS MaxMarks
          FROM Enrollment;

    Q4. Number of students in each city. Sort by count descending. Include the NULL-city group at the end.

    Ans4: SELECT City, COUNT(*) AS NumStudents FROM Student GROUP BY City ORDER BY NumStudents DESC, City IS NULL;

    Q5. Number of courses offered by each department, sorted by count descending.

    Ans5: SELECT Department, COUNT(*) AS NumCourses FROM Course GROUP BY Department ORDER BY NumCourses DESC;

    Q6. For each course, show CourseName, the number of students enrolled, and the average marks. Sort by average marks descending. (JOIN + GROUP BY.)
    
    Ans6: SELECT c.CourseName, COUNT(e.Enrollment) AS NumEnrolled, ROUND(AVG(e.Marks), 2) AS AvgMarks FROM Course c LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
          GROUP BY c.CourseID, c.CourseName ORDER BY AvgMarks DESC;

    Q7. List courses with an average marks above 80. Show CourseName and AvgMarks. (HAVING.)

    Ans7: SELECT c.CourseName, ROUND(AVG(e.Marks), 2) AS AvgMarks FROM Course c JOIN Enrollment e ON c.CourseID = e.CourseID GROUP BY c.CourseID, c.CourseName
          HAVING AVG(e.Marks) > 80 ORDER BY AvgMarks DESC;

    Q8. Total fee revenue per department, assuming each enrolled student paid the course fee. Show Department and TotalRevenue, sorted descending. (3-table join + GROUP BY.)

    Ans8: SELECT c.Department, SUM(c.Fee) AS TotalRevenue FROM Enrollment e JOIN Course c ON e.CourseID = c.CourseID GROUP BY c.Department
          ORDER BY TotalRevenue DESC;

    Q9. For each student, show how many courses they are enrolled in and their average marks. Include students with no enrollments (count = 0, avg = NULL). (LEFT JOIN + GROUP BY.)

    Ans9: SELECT s.FullName, COUNT(e.Enrollment) AS NumCourses,ROUND(AVG(e.Marks), 2) AS AvgMarks FROM Student s LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
          GROUP BY s.StudentID, s.FullName ORDER BY NumCourses DESC;

    Q10. Find students who scored above 85 in at least one course. Show their FullName and the highest mark they have achieved. (GROUP BY + HAVING + MAX.)

    Ans10: SELECT s.FullName, MAX(e.Marks) AS HighestMark FROM Students JOIN Enrollment e ON s.StudentID = e.StudentID GROUP BY s.StudentID, s.FullName HAVING MAX(e.Marks) > 85
           ORDER BY HighestMark DESC;

    Q11. List departments where the average marks across all their courses is below 75. Show Department and OverallAvgMarks. (Multi-step JOIN + GROUP BY + HAVING.)

    Ans11: SELECT c.Department, ROUND(AVG(e.Marks), 2) AS OverallAvgMarks FROM Course c JOIN Enrollment e ON c.CourseID = e.CourseID GROUP BY c.Department
            HAVING AVG(e.Marks) < 75 ORDER BY OverallAvgMarks;

    Q12. Find the top 3 students by total fee they have paid (sum of fees of their enrolled courses). Show FullName and TotalFee. (JOIN + GROUP BY + ORDER BY + LIMIT.)

    Ans12: SELECT s.FullName, SUM(c.Fee) AS TotalFee FROM Students JOIN Enrollment e ON s.StudentID = e.StudentID JOIN Course c ON e.CourseID = c.CourseID GROUP BY s.StudentID, s.FullName
           ORDER BY TotalFee DESC LIMIT 3;
*/