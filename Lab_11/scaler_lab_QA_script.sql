-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 20, 2026 at 05:18 PM
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
-- Database: `scaler_lab_QA`
--

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `EmpID` int(11) NOT NULL,
  `FullName` varchar(60) NOT NULL,
  `Email` varchar(80) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `JobTitle` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Employee`
--

INSERT INTO `Employee` (`EmpID`, `FullName`, `Email`, `Phone`, `DOB`, `HireDate`, `Salary`, `City`, `JobTitle`) VALUES
(2001, ' ahmad raza', 'ahmad@firm.com', '0300-1112233', '1990-04-12', '2018-09-01', 120000.50, 'Lahore', 'Senior Engineer'),
(2002, 'Sara Imran', 'SARA@FIRM.COM', '0301-4445566', '1992-11-20', '2019-03-15', 95000.00, 'Karachi', 'Software Engineer'),
(2003, 'BILAL KHAN', 'bilal@firm.com', '0302-7778899', '1993-08-05', '2020-01-20', 85000.75, 'Lahore', 'QA Engineer'),
(2004, 'Fatima Ali', NULL, '0303-1234567', '1991-02-14', '2017-11-10', 110000.00, 'Islamabad', 'Manager'),
(2005, 'Hira Yousaf', 'hira@firm.com', NULL, '1995-06-30', '2021-04-05', 70000.00, NULL, 'Accountant'),
(2006, 'Zain Abbas ', 'zain@firm.com', '0305-3456780', '1994-10-25', '2022-08-30', 78000.40, 'Karachi', 'Designer'),
(2007, 'Mehwish Anwar', 'mehwish@FIRM.com', '0306-4567890', '1989-12-09', '2016-07-22', 125000.00, 'Lahore', 'Director'),
(2008, 'Talha Hussain', 'talha@firm.com', '0307-5678901', '1996-03-18', '2023-01-09', 60000.00, 'Islamabad', 'HR Officer'),
(2009, 'Areeba Yasin', 'areeba@firm.com', '0308-6789012', '1990-07-22', '2019-09-12', 90000.99, 'Lahore', 'Analyst'),
(2010, 'Hassan Ahmed', 'hassan@firm.com', '0309-7890123', '1997-01-30', '2024-02-18', 65000.00, 'Karachi', 'Junior Developer');

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
