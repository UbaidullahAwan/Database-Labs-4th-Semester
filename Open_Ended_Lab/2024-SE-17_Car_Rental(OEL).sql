/*
=====================================================================
DBMS OPEN-ENDED LAB ASSIGNMENT

MySQL 8.x

This file contains:
1. Database design and implementation
2. Constraints and realistic sample data
3. Required JOIN queries
4. Consolidated VIEW
5. Business-rule TRIGGERS
6. STORED PROCEDURE for registering a rental
7. Test statements
8. Optimization indexes / analysis query
=====================================================================
*/

DROP DATABASE IF EXISTS cargo_rentals;
CREATE DATABASE cargo_rentals;
USE cargo_rentals;

-- ===================================================================
-- TASK 1 — DATABASE DESIGN AND IMPLEMENTATION
-- ===================================================================

-- Customer stores each customer's details once.
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    CNIC VARCHAR(20) NOT NULL UNIQUE,
    Address VARCHAR(200),
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Vehicle stores vehicle-specific information once.
CREATE TABLE Vehicle (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleNumber VARCHAR(20) NOT NULL UNIQUE,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    ModelYear INT NOT NULL,
    DailyRate DECIMAL(10,2) NOT NULL,
    VehicleStatus ENUM('Available','Rented','Maintenance') NOT NULL DEFAULT 'Available',
    CONSTRAINT chk_vehicle_year CHECK (ModelYear BETWEEN 1990 AND 2100),
    CONSTRAINT chk_daily_rate CHECK (DailyRate > 0)
);

-- Rental links one customer to one vehicle for a rental period.
-- DailyRateAtRental preserves the historical price even if Vehicle.DailyRate changes later.
CREATE TABLE Rental (
    RentalID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    RentalDate DATE NOT NULL,
    ExpectedReturnDate DATE NOT NULL,
    ActualReturnDate DATE NULL,
    DailyRateAtRental DECIMAL(10,2) NOT NULL,
    TotalCharge DECIMAL(12,2) NOT NULL DEFAULT 0,
    RentalStatus ENUM('Active','Returned','Cancelled') NOT NULL DEFAULT 'Active',
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rental_customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT fk_rental_vehicle
        FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_expected_return
        CHECK (ExpectedReturnDate >= RentalDate),

    CONSTRAINT chk_actual_return
        CHECK (ActualReturnDate IS NULL OR ActualReturnDate >= RentalDate),

    CONSTRAINT chk_rental_rate CHECK (DailyRateAtRental > 0),
    CONSTRAINT chk_total_charge CHECK (TotalCharge >= 0)
);

-- ReturnRecord keeps return-condition information separate from Rental.
-- One rental can have at most one return record.
CREATE TABLE ReturnRecord (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL UNIQUE,
    ReturnDate DATE NOT NULL,
    OdometerReading INT,
    FuelLevelPercent TINYINT,
    DamageNotes VARCHAR(255),
    LateFee DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_return_rental
        FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_odometer CHECK (OdometerReading IS NULL OR OdometerReading >= 0),
    CONSTRAINT chk_fuel CHECK (FuelLevelPercent IS NULL OR FuelLevelPercent BETWEEN 0 AND 100),
    CONSTRAINT chk_late_fee CHECK (LateFee >= 0)
);

-- Payment is separated because a rental can have zero, one, or multiple payments.
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    PaymentMethod ENUM('Cash','Card','Bank Transfer','Online') NOT NULL,
    PaymentStatus ENUM('Pending','Paid','Refunded') NOT NULL DEFAULT 'Paid',
    ReferenceNo VARCHAR(50) UNIQUE,

    CONSTRAINT fk_payment_rental
        FOREIGN KEY (RentalID) REFERENCES Rental(RentalID)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT chk_payment_amount CHECK (Amount > 0)
);


-- ===================================================================
-- SAMPLE DATA
-- ===================================================================

INSERT INTO Customer (CustomerName, Phone, Email, CNIC, Address) VALUES
('Ali Khan',     '0300-1234567', 'ali.khan@example.com',     '35202-1111111-1', 'Lahore'),
('Sara Ahmed',   '0301-2345678', 'sara.ahmed@example.com',   '35202-2222222-2', 'Islamabad'),
('Hamza Raza',   '0302-3456789', 'hamza.raza@example.com',   '42101-3333333-3', 'Karachi'),
('Ayesha Noor',  '0303-4567890', 'ayesha.noor@example.com',  '61101-4444444-4', 'Rawalpindi'),
('Bilal Hussain','0304-5678901', 'bilal.h@example.com',      '35202-5555555-5', 'Lahore'),
('Nida Yousaf',  '0305-6789012', 'nida.yousaf@example.com',  '37405-6666666-6', 'Islamabad');

INSERT INTO Vehicle (VehicleNumber, Make, Model, ModelYear, DailyRate, VehicleStatus) VALUES
('ABC-123', 'Toyota',  'Corolla', 2022, 5000, 'Available'),
('LEA-456', 'Honda',   'Civic',   2021, 6500, 'Available'),
('ICT-789', 'Suzuki',  'Swift',   2023, 4500, 'Available'),
('KHI-321', 'Toyota',  'Yaris',   2022, 5200, 'Available'),
('RWP-654', 'KIA',     'Sportage',2023, 9000, 'Available'),
('ISB-777', 'Hyundai', 'Tucson',  2024, 9500, 'Maintenance');

-- Historical returned rentals
INSERT INTO Rental
(CustomerID, VehicleID, RentalDate, ExpectedReturnDate, ActualReturnDate,
 DailyRateAtRental, TotalCharge, RentalStatus)
VALUES
(1, 1, '2026-09-01', '2026-09-04', '2026-09-04', 5000, 15000, 'Returned'),
(2, 2, '2026-09-03', '2026-09-06', '2026-09-06', 6500, 19500, 'Returned'),
(1, 3, '2026-09-08', '2026-09-10', '2026-09-10', 4500,  9000, 'Returned'),
(3, 4, '2026-09-05', '2026-09-09', '2026-09-10', 5200, 20800, 'Returned');

-- Current active rentals
INSERT INTO Rental
(CustomerID, VehicleID, RentalDate, ExpectedReturnDate, ActualReturnDate,
 DailyRateAtRental, TotalCharge, RentalStatus)
VALUES
(4, 2, '2026-09-18', '2026-09-22', NULL, 6500, 26000, 'Active'),
(5, 5, '2026-09-19', '2026-09-23', NULL, 9000, 36000, 'Active');

UPDATE Vehicle SET VehicleStatus = 'Rented' WHERE VehicleID IN (2,5);

INSERT INTO ReturnRecord
(RentalID, ReturnDate, OdometerReading, FuelLevelPercent, DamageNotes, LateFee)
VALUES
(1, '2026-09-04', 45210, 80, 'No damage', 0),
(2, '2026-09-06', 38100, 75, 'No damage', 0),
(3, '2026-09-10', 21400, 90, 'Minor scratch on rear bumper', 0),
(4, '2026-09-10', 57350, 60, 'No damage; returned one day late', 5200);

INSERT INTO Payment
(RentalID, PaymentDate, Amount, PaymentMethod, PaymentStatus, ReferenceNo)
VALUES
(1, '2026-09-04', 15000, 'Cash',          'Paid', 'PAY-1001'),
(2, '2026-09-06', 19500, 'Card',          'Paid', 'PAY-1002'),
(3, '2026-09-10',  9000, 'Online',        'Paid', 'PAY-1003'),
(4, '2026-09-10', 26000, 'Bank Transfer', 'Paid', 'PAY-1004'),
(5, '2026-09-18', 13000, 'Card',          'Paid', 'PAY-1005'),
(6, '2026-09-19', 18000, 'Cash',          'Paid', 'PAY-1006');


-- ===================================================================
-- TASK 3 — REQUIRED JOIN QUERIES
-- ===================================================================

-- Q1. Display customer name, vehicle number, vehicle model,
-- rental date, and return date for every rental.
SELECT
    c.CustomerName,
    v.VehicleNumber,
    CONCAT(v.Make, ' ', v.Model) AS VehicleModel,
    r.RentalDate,
    r.ActualReturnDate AS ReturnDate
FROM Rental r
INNER JOIN Customer c ON r.CustomerID = c.CustomerID
INNER JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY r.RentalID;


-- Q2. Display all customers and the vehicles they have rented.
-- Customers who have never rented a vehicle must also appear.
SELECT
    c.CustomerID,
    c.CustomerName,
    v.VehicleNumber,
    CONCAT(v.Make, ' ', v.Model) AS VehicleModel,
    r.RentalDate,
    r.RentalStatus
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
LEFT JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY c.CustomerID, r.RentalDate;


-- Q3. Display all vehicles and their current rental information.
-- Vehicles not currently rented must also appear.
SELECT
    v.VehicleID,
    v.VehicleNumber,
    CONCAT(v.Make, ' ', v.Model) AS VehicleModel,
    v.VehicleStatus,
    r.RentalID,
    c.CustomerName,
    r.RentalDate,
    r.ExpectedReturnDate
FROM Vehicle v
LEFT JOIN Rental r
    ON v.VehicleID = r.VehicleID
   AND r.RentalStatus = 'Active'
LEFT JOIN Customer c
    ON r.CustomerID = c.CustomerID
ORDER BY v.VehicleID;


-- Q4. Display total number of rentals made by each customer,
-- including customers who have made no rentals.
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(r.RentalID) AS TotalRentals
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY c.CustomerID;


-- ===================================================================
-- TASK 4 — VIEW
-- ===================================================================

DROP VIEW IF EXISTS vw_ConsolidatedRentalReport;

CREATE VIEW vw_ConsolidatedRentalReport AS
SELECT
    r.RentalID,
    c.CustomerID,
    c.CustomerName,
    c.Phone AS CustomerPhone,
    v.VehicleID,
    v.VehicleNumber,
    CONCAT(v.Make, ' ', v.Model) AS VehicleModel,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.ActualReturnDate,
    r.DailyRateAtRental,
    r.TotalCharge,
    r.RentalStatus,
    COALESCE(SUM(CASE WHEN p.PaymentStatus = 'Paid' THEN p.Amount ELSE 0 END), 0) AS AmountPaid,
    r.TotalCharge -
      COALESCE(SUM(CASE WHEN p.PaymentStatus = 'Paid' THEN p.Amount ELSE 0 END), 0) AS Balance
FROM Rental r
JOIN Customer c ON r.CustomerID = c.CustomerID
JOIN Vehicle v ON r.VehicleID = v.VehicleID
LEFT JOIN Payment p ON r.RentalID = p.RentalID
GROUP BY
    r.RentalID, c.CustomerID, c.CustomerName, c.Phone,
    v.VehicleID, v.VehicleNumber, v.Make, v.Model,
    r.RentalDate, r.ExpectedReturnDate, r.ActualReturnDate,
    r.DailyRateAtRental, r.TotalCharge, r.RentalStatus;

-- Test the view
SELECT * FROM vw_ConsolidatedRentalReport ORDER BY RentalID;


-- ===================================================================
-- TASK 5 — TRIGGERS
-- The brief's submission/rubric requires a trigger although the task
-- numbering in the handout skips directly from Task 4 to Task 6.
-- These triggers enforce the "one active rental per vehicle" rule.
-- ===================================================================

DROP TRIGGER IF EXISTS trg_before_rental_insert;
DROP TRIGGER IF EXISTS trg_after_rental_insert;
DROP TRIGGER IF EXISTS trg_after_rental_update;

DELIMITER $$

CREATE TRIGGER trg_before_rental_insert
BEFORE INSERT ON Rental
FOR EACH ROW
BEGIN
    DECLARE current_status VARCHAR(20);

    SELECT VehicleStatus
      INTO current_status
      FROM Vehicle
     WHERE VehicleID = NEW.VehicleID;

    IF current_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle does not exist.';
    END IF;

    IF NEW.RentalStatus = 'Active' AND current_status <> 'Available' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is not available for rental.';
    END IF;

    IF NEW.ExpectedReturnDate < NEW.RentalDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Expected return date cannot be before rental date.';
    END IF;
END$$

CREATE TRIGGER trg_after_rental_insert
AFTER INSERT ON Rental
FOR EACH ROW
BEGIN
    IF NEW.RentalStatus = 'Active' THEN
        UPDATE Vehicle
           SET VehicleStatus = 'Rented'
         WHERE VehicleID = NEW.VehicleID;
    END IF;
END$$

CREATE TRIGGER trg_after_rental_update
AFTER UPDATE ON Rental
FOR EACH ROW
BEGIN
    -- When an active rental is returned/cancelled, release the vehicle.
    IF OLD.RentalStatus = 'Active'
       AND NEW.RentalStatus IN ('Returned','Cancelled') THEN
        UPDATE Vehicle
           SET VehicleStatus = 'Available'
         WHERE VehicleID = NEW.VehicleID;
    END IF;
END$$

DELIMITER ;


-- ===================================================================
-- TASK 6 — STORED PROCEDURE
-- Register a new rental and calculate charge from rental period.
-- Charge convention: DATEDIFF(end,start) rental days, minimum 1 day.
-- ===================================================================

DROP PROCEDURE IF EXISTS sp_RegisterRental;

DELIMITER $$

CREATE PROCEDURE sp_RegisterRental(
    IN p_CustomerID INT,
    IN p_VehicleID INT,
    IN p_RentalDate DATE,
    IN p_ExpectedReturnDate DATE
)
BEGIN
    DECLARE v_DailyRate DECIMAL(10,2);
    DECLARE v_Status VARCHAR(20);
    DECLARE v_Days INT;
    DECLARE v_TotalCharge DECIMAL(12,2);

    -- Roll back the operation automatically if any SQL error occurs.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF p_ExpectedReturnDate < p_RentalDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Expected return date cannot be before rental date.';
    END IF;

    -- Lock the vehicle row while checking availability.
    SELECT DailyRate, VehicleStatus
      INTO v_DailyRate, v_Status
      FROM Vehicle
     WHERE VehicleID = p_VehicleID
     FOR UPDATE;

    IF v_DailyRate IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle does not exist.';
    END IF;

    IF v_Status <> 'Available' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is currently unavailable.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Customer WHERE CustomerID = p_CustomerID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist.';
    END IF;

    SET v_Days = GREATEST(DATEDIFF(p_ExpectedReturnDate, p_RentalDate), 1);
    SET v_TotalCharge = v_Days * v_DailyRate;

    INSERT INTO Rental
    (CustomerID, VehicleID, RentalDate, ExpectedReturnDate,
     DailyRateAtRental, TotalCharge, RentalStatus)
    VALUES
    (p_CustomerID, p_VehicleID, p_RentalDate, p_ExpectedReturnDate,
     v_DailyRate, v_TotalCharge, 'Active');

    -- trg_after_rental_insert changes VehicleStatus to Rented.

    COMMIT;

    SELECT
        LAST_INSERT_ID() AS NewRentalID,
        p_CustomerID AS CustomerID,
        p_VehicleID AS VehicleID,
        v_Days AS RentalDays,
        v_DailyRate AS DailyRate,
        v_TotalCharge AS TotalCharge,
        'Rental registered successfully' AS Message;
END$$

DELIMITER ;

-- Procedure demonstration.
-- Vehicle 3 is available in the supplied sample data.
CALL sp_RegisterRental(6, 3, '2026-09-21', '2026-09-24');

-- Verify procedure + trigger effect.
SELECT * FROM Rental ORDER BY RentalID;
SELECT VehicleID, VehicleNumber, VehicleStatus
FROM Vehicle
WHERE VehicleID = 3;


-- ===================================================================
-- OPTIONAL RETURN DEMONSTRATION FOR THE UPDATE TRIGGER
-- Run these statements after the procedure test above.
-- ===================================================================

UPDATE Rental
SET ActualReturnDate = '2026-09-24',
    RentalStatus = 'Returned'
WHERE RentalID = 7;

INSERT INTO ReturnRecord
(RentalID, ReturnDate, OdometerReading, FuelLevelPercent, DamageNotes, LateFee)
VALUES
(7, '2026-09-24', 25000, 85, 'No damage', 0);

SELECT VehicleID, VehicleNumber, VehicleStatus
FROM Vehicle
WHERE VehicleID = 3;


-- ===================================================================
-- TASK 7 — OPTIMIZATION
-- ===================================================================

-- Potential inefficiency:
-- Reporting/search queries frequently join Rental by CustomerID/VehicleID
-- and filter active rentals. Indexes reduce full scans as data grows.

CREATE INDEX idx_rental_customer
    ON Rental(CustomerID);

CREATE INDEX idx_rental_vehicle_status
    ON Rental(VehicleID, RentalStatus);

CREATE INDEX idx_rental_status_dates
    ON Rental(RentalStatus, RentalDate, ExpectedReturnDate);

CREATE INDEX idx_payment_rental_status
    ON Payment(RentalID, PaymentStatus);

-- Demonstrate how MySQL plans the current-rental lookup.
EXPLAIN
SELECT
    v.VehicleNumber,
    r.RentalID,
    r.RentalDate,
    r.ExpectedReturnDate
FROM Vehicle v
LEFT JOIN Rental r
    ON v.VehicleID = r.VehicleID
   AND r.RentalStatus = 'Active'
ORDER BY v.VehicleID;


/*
=====================================================================
END OF COMPLETE LAB SOLUTION
=====================================================================
*/
