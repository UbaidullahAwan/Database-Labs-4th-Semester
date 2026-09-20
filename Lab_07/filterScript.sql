-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 20, 2026 at 06:25 PM
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
-- Database: `filters_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `EmpID` int(11) NOT NULL,
  `EmpName` varchar(50) NOT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `JobTitle` varchar(40) DEFAULT NULL,
  `DeptName` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Employee`
--

INSERT INTO `Employee` (`EmpID`, `EmpName`, `Gender`, `Salary`, `HireDate`, `City`, `JobTitle`, `DeptName`) VALUES
(101, 'Ali Khan', 'M', 120000.00, '2018-03-15', 'Lahore', 'Senior\r\nEngineer', 'Engineering'),
(102, 'Sara Iqbal', 'F', 95000.00, '2019-06-01', 'Lahore', 'Software\r\nEngineer', 'Engineering'),
(103, 'Hamza Raza', 'M', 85000.00, '2020-01-20', 'Karachi', 'Software\r\nEngineer', 'Engineering'),
(104, 'Ayesha Noor', 'F', 110000.00, '2017-11-10', 'Karachi', 'Marketing Lead', 'Marketing'),
(105, 'Bilal Ahmed', 'M', 70000.00, '2021-04-05', 'Karachi', 'Marketing Exec', 'Marketing'),
(106, 'Fatima Sheikh', 'F', 90000.00, '2019-09-12', 'Islamabad', 'Accountant', 'Finance'),
(107, 'Usman Tariq', 'M', 78000.00, '2022-02-18', 'Islamabad', 'Accountant', 'Finance'),
(108, 'Maira Javed', 'F', 115000.00, '2016-07-22', 'Lahore', 'Research Lead', 'Research'),
(109, 'Zain Abbas', 'M', 60000.00, '2023-01-09', 'Lahore', 'Research Analyst', 'Research'),
(110, 'Nida Yousaf', 'F', 72000.00, '2022-08-30', NULL, 'Research\r\nAnalyst', 'Research'),
(111, 'Adeel Akhtar', 'M', 88000.00, '2020-05-14', 'Lahore', 'QA Engineer', 'Engineering'),
(112, 'Sana Malik', 'F', 102000.00, '2018-12-01', 'Karachi', 'Sales Manager', 'Sales'),
(113, 'Talha Hussain', 'M', 65000.00, '2023-07-18', 'Islamabad', 'Sales Exec', 'Sales'),
(114, 'Mehwish Anwar', 'F', 80000.00, '2021-10-25', 'Lahore', 'HR Officer', 'HR'),
(115, 'Imran Shafi', 'M', 125000.00, '2015-04-30', NULL, 'Director', 'Engineering');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Employee`
--
ALTER TABLE `Employee`
  ADD PRIMARY KEY (`EmpID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
