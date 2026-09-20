-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 20, 2026 at 04:16 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agg_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE `Customer` (
  `CustID` int(11) NOT NULL,
  `CustName` varchar(60) NOT NULL,
  `City` varchar(30) DEFAULT NULL,
  `JoinDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`CustID`, `CustName`, `City`, `JoinDate`) VALUES
(1, 'Ali Khan', 'Lahore', '2022-01-15'),
(2, 'Sara Iqbal', 'Karachi', '2022-04-22'),
(3, 'Hamza Raza', 'Lahore', '2023-02-10'),
(4, 'Ayesha Noor', 'Islamabad', '2023-05-18'),
(5, 'Bilal Ahmed', 'Karachi', '2023-09-01'),
(6, 'Fatima Sheikh', NULL, '2024-01-12'),
(7, 'Usman Tariq', 'Lahore', '2024-06-30'),
(8, 'Maira Javed', 'Islamabad', '2024-08-25');

-- --------------------------------------------------------

--
-- Table structure for table `OrderItem`
--

CREATE TABLE `OrderItem` (
  `OrderID` int(11) NOT NULL,
  `CustID` int(11) DEFAULT NULL,
  `ProdID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OrderItem`
--

INSERT INTO `OrderItem` (`OrderID`, `CustID`, `ProdID`, `Quantity`, `OrderDate`) VALUES
(1001, 1, 101, 1, '2023-03-10'),
(1002, 1, 102, 2, '2023-03-10'),
(1003, 2, 104, 1, '2023-05-22'),
(1004, 2, 106, 5, '2023-05-22'),
(1005, 3, 101, 1, '2023-08-15'),
(1006, 3, 110, 1, '2023-08-15'),
(1007, 4, 108, 3, '2023-11-02'),
(1008, 5, 103, 4, '2024-01-20'),
(1009, 5, 102, 1, '2024-01-20'),
(1010, 6, 105, 1, '2024-02-14'),
(1011, 7, 107, 2, '2024-04-08'),
(1012, 7, 106, 10, '2024-04-08'),
(1013, 7, 109, 3, '2024-07-15'),
(1014, 2, 110, 1, '2024-09-05'),
(1015, 3, 108, 2, '2024-10-11');

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `ProdID` int(11) NOT NULL,
  `ProdName` varchar(60) NOT NULL,
  `Category` varchar(30) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `StockQty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`ProdID`, `ProdName`, `Category`, `Price`, `StockQty`) VALUES
(101, 'Laptop Pro 15', 'Electronics', 185000.00, 12),
(102, 'Wireless Mouse', 'Electronics', 2500.00, 50),
(103, 'USB-C Cable', 'Electronics', 800.00, 100),
(104, 'Office Chair', 'Furniture', 18500.00, 8),
(105, 'Standing Desk', 'Furniture', 45000.50, 5),
(106, 'Notebook A4', 'Stationery', 350.00, 200),
(107, 'Ballpoint Pen 10pk', 'Stationery', 450.00, 150),
(108, 'Coffee Beans 1kg', 'Grocery', 1899.99, 30),
(109, 'Green Tea Box', 'Grocery', 650.00, 45),
(110, 'Bluetooth Speaker', 'Electronics', 7500.00, 18);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`CustID`);

--
-- Indexes for table `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `CustID` (`CustID`),
  ADD KEY `ProdID` (`ProdID`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`ProdID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`CustID`) REFERENCES `Customer` (`CustID`),
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`ProdID`) REFERENCES `Product` (`ProdID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
