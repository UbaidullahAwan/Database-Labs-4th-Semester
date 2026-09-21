/* ===============================================Lab 5 =======================================================*/

    -- Partial Dependencies

-- OrderId -> OrderDate

-- CustId -> CustName, CustEmail

-- BookId -> BookTitle, Publisher, Unit Price, Qty

/* Second Normal Form (2NF) 

create table orders(
    OrderId INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate date
);

create table books(
    BookId INT PRIMARY KEY AUTO_INCREMENT,
    BookTitle varchar(300),
    Publisher varchar(300),
    UnitPrice varchar(300),
    Qty INT(10),
    foreign key (BookId) references OrderId(orders),
    foreign key (BookId) references CustId(customers)
);
create table customers(
    CustId INT PRIMARY KEY AUTO_INCREMENT,
    CustName varchar(255),
    CustEmail varchar(255)
);

Here Partial Dependencies have been removed. So, it is in 2NF
*/

/* ===============================================3NF =======================================================*/

/* Third     Normal Form (3NF) 

The tables are already in third normal form. No transitive dependency exits.

create table orders(
    OrderId INT PRIMARY KEY,
    OrderDate date
);

create table books(
    BookId INT PRIMARY KEY ,
    BookTitle varchar(300),
    Publisher varchar(300),
    UnitPrice varchar(300),
    Qty INT(10),
    foreign key (BookId) references OrderId(orders),
    foreign key (BookId) references CustId(customers)
);
create table customers(
    CustId INT PRIMARY KEY,
    CustName varchar(255),
    CustEmail varchar(255)
);


insert into order (OrderID, OrderDate) values ('O-501', '2026-04-02'), ('O-502', '2026-04-03'),('O-503', '2026-04-05');
insert into books (BookId, BookTitle, Publisher, UnitPrice, Qty) values ('B-1', 'SQL basics', 'Pearson', '1200', 1),('B-2', 'Python 103', 'OReilly', '1500', 2),('B-3', 'Networks', 'Pearson', '1800', 1);
insert into customers (CustId, CustName, CustEmail) values ('C-11' , 'Bilal', 'bilal@x.com'),('C-12' , 'Areeba', 'areeba@x.com');

*/

/* ===============================================Task 5 =======================================================*/

/* -- Verification Query 1: Recreate original report

SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustID,
    c.CustName,
    c.CustEmail,
    b.BookID,
    b.BookTitle,
    p.PublisherName AS Publisher,
    b.UnitPrice,
    od.Qty
FROM OrderDetails od
JOIN Orders   o ON od.OrderID = o.OrderID
JOIN Customer c ON o.CustID = c.CustID
JOIN Books    b ON od.BookID = b.BookID
JOIN Publisher p ON b.PublisherID = p.PublisherID
ORDER BY o.OrderID, b.BookID; */





/* ===============================================Task 6 =======================================================*/
/*
Our final 3NF schema eliminates each anomaly identified in Task 1 as follows.
The insertion anomaly is resolved because we can now add a new book to the Books 
table and a new publisher to the Publisher table independently, without requiring a
customer order. The update anomaly is resolved because customer information 
(name, email) is stored only once in the Customer table; changing Bilal's email
requires updating exactly one row. The deletion anomaly is resolved because deleting
an order only removes rows from Orders and OrderDetails, leaving the customer record
and book records intact. Additionally, the transitive dependency BookID →
PublisherName was removed by extracting Publisher into its own table, ensuring
publisher information is stored once and referenced by ID. The schema now 
satisfies the rule: every non-prime attribute depends on the key, the whole key,
and nothing but the key. This design is also efficient to query via joins (as 
demonstrated in Task 5) without any data redundancy.

 */

 /*===================================== Assessment Problem ===================================================*/

 /*  First of all, we are to figure-out the entities involved:

    1. Patient
    2. Doctor
    3. Visit (Weak Entity)
    4. Department
    5. Diagnosis

    Functional dependencies for the given relational data are:

    PatientId -> PatientName, PatientPhone
    DoctorID -> DoctorName,  Speciality, DeptName, DeptHead
    VisitId -> VisitDate, Diagnosis, Fee

    Candidate keys are the keys which are  qualified to be the primary key but are in queue to be so.

    In our case, we have:

    1. PatientId
    2. DoctorID
    3. VisitId      
    
    as candidate keys


    --------------------------------------------------------------------------------------------------------------

   First normal form (1NF) says that all the cells in the relational database must be atomic - they should contain
   one value in a single cell.

   In our case, we already have first normal form achieved since all the values are atomic.


   Sql:

   create database Hospital_Patient_Visits;
   use Hospital_Patient_Visits;

   create table Patient(
       visitId INT auto_increment PRIMARY KEY,
       visitDate data,
       PatientId INT auto_increment PRIMARY KEY,

   )

 -----------------------------------------------------------------------------------------------------------------

 Sql:

   create database Hospital_Patient_Visits;
   use Hospital_Patient_Visits;


   create table Visits(
       visitId INT auto_increment PRIMARY KEY,
       visitDate date
   )
   create table Patient(
       VisitId  INT,
       VisitDate date,
       PatientId INT auto_increment PRIMARY KEY,
       PatientName varchar(255),
       PatientPhone varchar(255),
       FOREIGN KEY visitId referrences visitId(Visits)
       FOREIGN KEY VisitDate referrences visitDate(Visits)
   )
   create table Doctor(
       VisitId INT,
       DoctorID INT auto_increment PRIMARY KEY,
       DoctorName varchar(255),
       Speciality varchar(100),
       Deptname varchar(100),
       Depthead varchar(100),
       FOREIGN KEY Deptname referrences DeptId(Department),
       FOREIGN KEY DeptHead referrences DeptHead(Department)
   )
   create table Department(
       DeptId INT auto_increment PRIMARY KEY,
       DeptName varchar(100),
       DeptHead varchar(100)
   )
   create table Diagnostics(
       DiagnosticId INT auto_increment PRIMARY KEY,
       Diagnose varchar(255),
       Fee varchar(100)
   )


   insert into Patient (patientName, PatientPhone) values ('Hassan', 0300-1112233), ('Mehreen', 0301-4445566), 
   ('Hassan', 0300-1112233), ('Junaid', 0302-7778899);

   insert into Visits (visitDate) values ('2026-04-10'), ('2026-04-10'), ('2026-04-11'), ('2026-04-12');

   insert into Doctor (DoctorName, Speciality) values ('Dr. Imran', 'Cardiology'), ('Dr.Asma', 'Dermatology'),      ('Dr.Asma', 'Dermatology'), ('Dr. Imran', 'Cardiology');

    Insert into Department (DeptName, DeptHead) values ('Health Care', 'Dr. Tariq'),('Skin Clinic', 'Dr. Asma'),     ('Skin Clinic', 'Dr. Asma'),('Health Care', 'Dr. Tariq');

    insert into Diagnostics (Diagnose, Fee) values ('Hypertension' , 2500), ('Eczema' , 2000), ('Allergy' ,         2000), ('Arrhythmia' , 3000);
 */