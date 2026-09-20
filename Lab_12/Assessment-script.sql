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
-- Database: `uni_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `CourseID` varchar(10) NOT NULL,
  `CourseName` varchar(60) NOT NULL,
  `Department` varchar(30) DEFAULT NULL,
  `Credits` int(11) DEFAULT NULL,
  `Fee` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`CourseID`, `CourseName`, `Department`, `Credits`, `Fee`) VALUES
('BB301', 'Marketing Basics', 'Business', 3, 24000.00),
('CS101', 'Intro to Programming', 'Computer Science', 3, 25000.00),
('CS201', 'Database Systems', 'Computer Science', 3, 28000.00),
('CS301', 'Operating Systems', 'Computer Science', 4, 30000.00),
('EE201', 'Digital Logic', 'Electrical Engg', 3, 26000.00),
('MT101', 'Calculus I', 'Mathematics', 3, 22000.00);

-- --------------------------------------------------------

--
-- Table structure for table `Enrollment`
--

CREATE TABLE `Enrollment` (
  `Enrollment` int(11) NOT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `CourseID` varchar(10) DEFAULT NULL,
  `Marks` int(11) DEFAULT NULL,
  `EnrollmentDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Enrollment`
--

INSERT INTO `Enrollment` (`Enrollment`, `StudentID`, `CourseID`, `Marks`, `EnrollmentDate`) VALUES
(1, 1001, 'CS101', 78, '2022-09-15'),
(2, 1001, 'CS201', 85, '2023-09-15'),
(3, 1001, 'MT101', 90, '2022-09-15'),
(4, 1002, 'CS101', 65, '2022-09-15'),
(5, 1002, 'CS201', 72, '2023-09-15'),
(6, 1003, 'CS101', 88, '2023-09-15'),
(7, 1003, 'EE201', 80, '2023-09-15'),
(8, 1004, 'MT101', 95, '2022-09-15'),
(9, 1004, 'CS201', 70, '2023-09-15'),
(10, 1005, 'CS101', 55, '2024-09-15'),
(11, 1006, 'CS101', 82, '2023-09-15'),
(12, 1006, 'CS301', 76, '2024-09-15'),
(13, 1007, 'CS201', 91, '2023-09-15'),
(14, 1007, 'CS301', 86, '2024-09-15'),
(15, 1008, 'CS101', 60, '2024-09-15'),
(16, 1008, 'MT101', 68, '2024-09-15');

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `StudentID` int(11) NOT NULL,
  `FullName` varchar(60) NOT NULL,
  `City` varchar(30) DEFAULT NULL,
  `EnrollmentDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`StudentID`, `FullName`, `City`, `EnrollmentDate`) VALUES
(1001, 'Ahmad Raza', 'Lahore', '2022-09-01'),
(1002, 'Sara Imran', 'Karachi', '2022-09-01'),
(1003, 'Bilal Khan', 'Lahore', '2023-09-01'),
(1004, 'Fatima Ali', 'Islamabad', '2022-09-01'),
(1005, 'Hira Yousaf', NULL, '2024-09-01'),
(1006, 'Zain Abbas', 'Karachi', '2023-09-01'),
(1007, 'Mehwish Anwar', 'Lahore', '2022-09-01'),
(1008, 'Talha Hussain', 'Islamabad', '2024-09-01'),
(1009, 'Areeba Yasin', 'Lahore', '2023-09-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`CourseID`);

--
-- Indexes for table `Enrollment`
--
ALTER TABLE `Enrollment`
  ADD PRIMARY KEY (`Enrollment`),
  ADD KEY `StudentID` (`StudentID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`StudentID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Enrollment`
--
ALTER TABLE `Enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`),
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `Course` (`CourseID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
