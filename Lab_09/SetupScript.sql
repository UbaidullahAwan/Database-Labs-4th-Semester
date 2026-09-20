-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 20, 2026 at 04:33 PM
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
-- Database: `joins_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `Assignment`
--

CREATE TABLE `Assignment` (
  `EmpID` int(11) NOT NULL,
  `ProjectID` int(11) NOT NULL,
  `HoursPerWeek` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Assignment`
--

INSERT INTO `Assignment` (`EmpID`, `ProjectID`, `HoursPerWeek`) VALUES
(101, 1001, 10),
(102, 1001, 20),
(102, 1002, 15),
(103, 1002, 30),
(104, 1003, 25),
(105, 1003, 40),
(106, 1004, 35),
(108, 1005, 20),
(109, 1005, 30);

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `DeptID` int(11) NOT NULL,
  `DeptName` varchar(40) NOT NULL,
  `Location` varchar(30) DEFAULT NULL,
  `Budget` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`DeptID`, `DeptName`, `Location`, `Budget`) VALUES
(10, 'Engineering', 'Lahore', 5000000.00),
(20, 'Marketing', 'Karachi', 2000000.00),
(30, 'Finance', 'Islamabad', 3000000.00),
(40, 'Research', 'Lahore', 4000000.00),
(50, 'Sales', 'Karachi', NULL);

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
  `ManagerID` int(11) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Employee`
--

INSERT INTO `Employee` (`EmpID`, `EmpName`, `Gender`, `Salary`, `HireDate`, `City`, `ManagerID`, `DeptID`) VALUES
(101, 'Ali Khan', 'M', 120000.00, '2018-03-15', 'Lahore', NULL, 10),
(102, 'Sara Iqbal', 'F', 95000.00, '2019-06-01', 'Lahore', 101, 10),
(103, 'Hamza Raza', 'M', 85000.00, '2020-01-20', 'Karachi', 101, 10),
(104, 'Ayesha Noor', 'F', 110000.00, '2017-11-10', 'Karachi', NULL, 20),
(105, 'Bilal Ahmed', 'M', 70000.00, '2021-04-05', 'Karachi', 104, 20),
(106, 'Fatima Sheikh', 'F', 90000.00, '2019-09-12', 'Islamabad', NULL, 30),
(107, 'Usman Tariq', 'M', 78000.00, '2022-02-18', 'Islamabad', 106, 30),
(108, 'Maira Javed', 'F', 115000.00, '2016-07-22', 'Lahore', NULL, 40),
(109, 'Zain Abbas', 'M', 60000.00, '2023-01-09', 'Lahore', 108, 40),
(110, 'Nida Yousaf', 'F', 72000.00, '2022-08-30', NULL, 108, 40);

-- --------------------------------------------------------

--
-- Table structure for table `Project`
--

CREATE TABLE `Project` (
  `ProjectID` int(11) NOT NULL,
  `ProjectName` varchar(50) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Project`
--

INSERT INTO `Project` (`ProjectID`, `ProjectName`, `StartDate`, `EndDate`, `DeptID`) VALUES
(1001, 'Website Revamp', '2024-01-10', '2024-06-30', 10),
(1002, 'Mobile App', '2024-03-01', '2024-12-31', 10),
(1003, 'Brand Campaign', '2024-02-15', '2024-05-15', 20),
(1004, 'Audit System', '2024-04-01', NULL, 30),
(1005, 'AI Research', '2024-05-01', '2025-04-30', 40),
(1006, 'Internal Tool', '2024-06-01', '2024-09-30', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Assignment`
--
ALTER TABLE `Assignment`
  ADD PRIMARY KEY (`EmpID`,`ProjectID`),
  ADD KEY `ProjectID` (`ProjectID`);

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`DeptID`);

--
-- Indexes for table `Employee`
--
ALTER TABLE `Employee`
  ADD PRIMARY KEY (`EmpID`),
  ADD KEY `DeptID` (`DeptID`),
  ADD KEY `ManagerID` (`ManagerID`);

--
-- Indexes for table `Project`
--
ALTER TABLE `Project`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `DeptID` (`DeptID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Assignment`
--
ALTER TABLE `Assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`EmpID`) REFERENCES `Employee` (`EmpID`),
  ADD CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`);

--
-- Constraints for table `Employee`
--
ALTER TABLE `Employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `Department` (`DeptID`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`ManagerID`) REFERENCES `Employee` (`EmpID`);

--
-- Constraints for table `Project`
--
ALTER TABLE `Project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `Department` (`DeptID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
