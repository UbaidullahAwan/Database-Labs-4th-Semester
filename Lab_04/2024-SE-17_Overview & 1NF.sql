/* ===============================================Lab 04 =======================================================*/

-- Functional Dependencies

-- OrderId -> OrderDate

-- CustId -> CustName, CustEmail

-- BookId -> BookTitle, Publisher, Unit Price, Qty

-- Insertion Anomaly

/* To insert a new book, we need orderID. For orderId we will have to insert customer data in customer table
   resulting in insertion anomaly.


   To upate the BookId of Python(101) to Python(103) , we will have to alter multiple rows, resulting in 
   update anomaly.

   If we are to delete SQL book from the database, we will have to delete multiple group columns, resulting in
   deletion anomaly

   */

/* ===============================================Task 2 =======================================================*/

    
    /* 
    
First Normal Form (1NF)

    OrderId  |   OrderDate       BookId      BookTitle    Publisher      UnitPrice       Qty     CustId      CustName        CustEmail

    O-501    |   2026-04-02      B-1         SQL basics      Pearson     1200            1       C-10        Bilal           bilal@x.com 
    O-502    |   2026-04-03      B-2         Python 103      OReilly     1500            2       C-11        Areeba          areeba@x.com
    O-503    |   2026-04-05      B-3         Networks        Pearson     1800            1       C-10        Bilal           bilal@x.com
    
    
    
    
    -- Sql Code
    
    create table OrderBook_1NF(

        OrderId INT PRIMARY KEY ,
        OrderDate date,

        BookId INT PRIMARY KEY ,
        BookTitle varchar(255),
        Publisher varchar(255),
        UnitPrice varchar(200),
        Qty INT,

        CustId INT PRIMARY KEY ,
        CustName varchar(255),
        CustEmail varchar(255)


        insert into OrderBook_1NF values (OrderID, OrderDate, BookId, BookTitle, Publisher, UnitPrice, Qty, CustId, CustName, CustEmail)
        values('O-501', '2026-04-02', 'B-1' , 'SQL basics' , 'Pearson', 1200 , 1, 'C-11', 'Bilal', 'bilal@X.com'),
        ('O-502', '2026-04-03', 'B-2' ,' Python 101' , 'OReilly', 1500 , 2, 'C-12', 'Areeba', 'areeba@x.com'),
        ('O-503', '2026-04-05', 'B-3' , 'Networks' , 'Pearson', 1800 , 1, 'C-11', 'Bilal', 'bilal@x.com');

    ); */
