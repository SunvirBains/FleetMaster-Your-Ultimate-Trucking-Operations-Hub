-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 30, 2024 at 01:16 AM
-- Server version: 8.0.40
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bain0059`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`bain0059`@`%` PROCEDURE `GetTruckSchedules` (IN `truckId` INT)   BEGIN
    SELECT 
        Schedule.ScheduleId, 
        Drivers.FullName AS DriverName, 
        Schedule.StartLocation, 
        Schedule.EndLocation, 
        Schedule.Date 
    FROM 
        Schedule
    JOIN Drivers ON Schedule.DriverId = Drivers.DriverId
    JOIN Trucks ON Drivers.TruckId = Trucks.TruckId
    WHERE Trucks.TruckId = truckId;
END$$

--
-- Functions
--
CREATE DEFINER=`bain0059`@`%` FUNCTION `TotalDistanceTraveled` (`truckId` INT) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE totalDistance DECIMAL(10,2);
    SELECT SUM(DistanceTraveled) INTO totalDistance
    FROM FuelConsumption
    WHERE TruckId = truckId;
    RETURN totalDistance;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `CustomerId` int NOT NULL,
  `CompanyName` varchar(100) NOT NULL,
  `ContactName` varchar(100) NOT NULL,
  `ContactEmail` varchar(100) NOT NULL,
  `ContactNumber` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`CustomerId`, `CompanyName`, `ContactName`, `ContactEmail`, `ContactNumber`) VALUES
(1, 'ACME Corp', 'John Manager', 'john@acme.com', '5551010101'),
(2, 'Global Logistics', 'Alice Manager', 'alice@globallog.com', '5552020202'),
(3, 'Blue Line Ltd.', 'Bob Manager', 'bob@blueline.com', '5553030303'),
(4, 'Speedy Freight', 'Charlie Smith', 'charlie@speedy.com', '5554040404'),
(5, 'Heavy Haulers', 'Dave Strong', 'dave@haulers.com', '5555050505');

-- --------------------------------------------------------

--
-- Table structure for table `Drivers`
--

CREATE TABLE `Drivers` (
  `DriverId` int NOT NULL,
  `TruckId` int DEFAULT NULL,
  `FullName` varchar(100) NOT NULL,
  `LicenseNumber` varchar(50) NOT NULL,
  `PhoneNumber` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0000000000',
  `HireDate` date NOT NULL,
  `LicenseExpiryDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Drivers`
--

INSERT INTO `Drivers` (`DriverId`, `TruckId`, `FullName`, `LicenseNumber`, `PhoneNumber`, `HireDate`, `LicenseExpiryDate`) VALUES
(1, 1, 'John Smith', 'L12345', '5551234567', '2020-01-15', '2025-01-15'),
(2, 2, 'Alice Johnson', 'L67890', '5559876543', '2019-03-20', '2024-03-20'),
(3, NULL, 'Mark Davis', 'L11223', '5551122334', '2021-05-10', '2026-05-10'),
(4, 3, 'Sarah Brown', 'L33445', '5553344556', '2020-08-22', '2025-08-22'),
(5, 1, 'Paul Green', 'L55667', '5555566778', '2022-02-15', '2027-02-15'),
(6, 2, 'Emily White', 'L77889', '5557788990', '2023-01-01', '2028-01-01'),
(7, NULL, 'Chris Black', 'L99001', '5559900112', '2021-09-30', '2026-09-30'),
(8, 3, 'Lisa Grey', 'L22334', '5552233445', '2018-12-12', '2023-12-12'),
(9, 1, 'Mike Johnson', 'L55678', '5555567890', '2017-07-10', '2022-07-10'),
(10, 2, 'Angela Carter', 'L66789', '5556678901', '2019-04-18', '2024-04-18');

-- --------------------------------------------------------

--
-- Table structure for table `FuelConsumption`
--

CREATE TABLE `FuelConsumption` (
  `FuelId` int NOT NULL,
  `TruckId` int NOT NULL,
  `Date` date NOT NULL DEFAULT (curdate()),
  `LitersConsumed` decimal(10,2) NOT NULL,
  `CostPerLiter` decimal(10,2) NOT NULL,
  `TotalCost` decimal(15,2) NOT NULL,
  `DistanceTraveled` decimal(10,2) DEFAULT NULL,
  `IdleTime` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `FuelConsumption`
--

INSERT INTO `FuelConsumption` (`FuelId`, `TruckId`, `Date`, `LitersConsumed`, `CostPerLiter`, `TotalCost`, `DistanceTraveled`, `IdleTime`) VALUES
(6, 1, '2023-11-20', 100.00, 1.50, 150.00, 500.00, NULL),
(7, 2, '2023-11-21', 200.00, 1.45, 290.00, 1000.00, NULL),
(8, 3, '2023-11-22', 150.00, 1.55, 232.50, 750.00, NULL),
(9, 4, '2023-11-23', 180.00, 1.60, 288.00, 800.00, NULL),
(10, 5, '2023-11-24', 220.00, 1.52, 334.40, 1100.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Maintenance`
--

CREATE TABLE `Maintenance` (
  `MaintenanceId` int NOT NULL,
  `TruckId` int NOT NULL,
  `MaintenanceDate` date NOT NULL DEFAULT (curdate()),
  `Description` longtext,
  `Cost` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Maintenance`
--

INSERT INTO `Maintenance` (`MaintenanceId`, `TruckId`, `MaintenanceDate`, `Description`, `Cost`) VALUES
(1, 1, '2023-11-15', 'Oil Change', 100.00),
(2, 2, '2023-11-18', 'Tire Replacement', 500.00),
(3, 3, '2023-11-20', 'Brake Inspection', 200.00),
(4, 4, '2023-11-25', 'Engine Tuning', 800.00),
(5, 5, '2023-11-28', 'Air Filter Replacement', 150.00),
(6, 1, '2023-12-01', 'Battery Replacement', 300.00),
(7, 2, '2023-12-05', 'Transmission Repair', 1000.00),
(8, 3, '2023-12-07', 'Coolant Flush', 120.00),
(9, 4, '2023-12-10', 'Suspension Repair', 700.00),
(10, 5, '2023-12-12', 'Exhaust System Repair', 600.00),
(11, 1, '2023-12-15', 'Steering Alignment', 180.00),
(12, 2, '2023-12-18', 'Fuel System Service', 450.00);

-- --------------------------------------------------------

--
-- Table structure for table `Schedule`
--

CREATE TABLE `Schedule` (
  `ScheduleId` int NOT NULL,
  `DriverId` int NOT NULL,
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `StartLocation` varchar(100) NOT NULL,
  `EndLocation` varchar(100) NOT NULL,
  `LoadWeight` decimal(10,2) NOT NULL,
  `Status` enum('Scheduled','In Progress','Completed','Cancelled') DEFAULT 'Scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Schedule`
--

INSERT INTO `Schedule` (`ScheduleId`, `DriverId`, `Date`, `StartLocation`, `EndLocation`, `LoadWeight`, `Status`) VALUES
(11, 1, '2023-12-01 08:00:00', 'Toronto', 'Montreal', 1500.00, 'Scheduled'),
(12, 2, '2023-12-02 09:00:00', 'Vancouver', 'Seattle', 2000.00, 'In Progress'),
(13, 3, '2023-12-03 10:00:00', 'Calgary', 'Edmonton', 2500.00, 'Completed'),
(14, 4, '2023-12-04 12:00:00', 'Winnipeg', 'Regina', 3000.00, 'Cancelled'),
(15, 5, '2023-12-05 14:00:00', 'Halifax', 'Moncton', 3500.00, 'Scheduled');

-- --------------------------------------------------------

--
-- Table structure for table `Trucks`
--

CREATE TABLE `Trucks` (
  `TruckId` int NOT NULL,
  `LicensePlate` varchar(20) NOT NULL,
  `Make` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Year` year NOT NULL,
  `Capacity` decimal(10,2) NOT NULL,
  `StatusId` int NOT NULL,
  `TotalDistance` decimal(15,2) DEFAULT NULL,
  `InsuranceExpiryDate` date DEFAULT NULL,
  `CurrentLocation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Trucks`
--

INSERT INTO `Trucks` (`TruckId`, `LicensePlate`, `Make`, `Model`, `Year`, `Capacity`, `StatusId`, `TotalDistance`, `InsuranceExpiryDate`, `CurrentLocation`) VALUES
(1, 'AB1234', 'Ford', 'F-150', '2020', 5000.00, 1, 120000.00, '2024-01-15', NULL),
(2, 'CD5678', 'Volvo', 'VNL 760', '2018', 20000.00, 2, 250000.00, '2023-12-30', NULL),
(3, 'EF9012', 'Freightliner', 'Cascadia', '2019', 18000.00, 1, 180000.00, '2024-02-10', NULL),
(4, 'GH3456', 'Peterbilt', '579', '2021', 25000.00, 3, 50000.00, '2024-05-20', NULL),
(5, 'IJ7890', 'Kenworth', 'T680', '2022', 30000.00, 1, 30000.00, '2024-11-10', NULL);

--
-- Triggers `Trucks`
--
DELIMITER $$
CREATE TRIGGER `EnforceTruckCapacity` AFTER INSERT ON `Trucks` FOR EACH ROW BEGIN
    IF NEW.Capacity < 1000 THEN
        DELETE FROM Trucks WHERE TruckId = NEW.TruckId;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `TruckStatus`
--

CREATE TABLE `TruckStatus` (
  `StatusID` int NOT NULL,
  `STATUSDesc` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `TruckStatus`
--

INSERT INTO `TruckStatus` (`StatusID`, `STATUSDesc`) VALUES
(1, 'Available'),
(3, 'Decommissioned'),
(2, 'In Maintenance'),
(5, 'In Transit'),
(4, 'Out of Service');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vDriversAndTrucks`
-- (See below for the actual view)
--
CREATE TABLE `vDriversAndTrucks` (
`DriverId` int
,`DriverName` varchar(100)
,`TruckId` int
,`TruckLicensePlate` varchar(20)
,`TruckMake` varchar(50)
,`TruckModel` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vTruckDriverSchedules`
-- (See below for the actual view)
--
CREATE TABLE `vTruckDriverSchedules` (
`DriverName` varchar(100)
,`EndLocation` varchar(100)
,`LicensePlate` varchar(20)
,`ScheduleId` int
,`StartLocation` varchar(100)
,`TruckId` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vTruckSchedules`
-- (See below for the actual view)
--
CREATE TABLE `vTruckSchedules` (
`EndLocation` varchar(100)
,`LicensePlate` varchar(20)
,`ScheduleId` int
,`StartLocation` varchar(100)
,`TruckId` int
);

-- --------------------------------------------------------

--
-- Structure for view `vDriversAndTrucks`
--
DROP TABLE IF EXISTS `vDriversAndTrucks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`bain0059`@`%` SQL SECURITY DEFINER VIEW `vDriversAndTrucks`  AS SELECT `Drivers`.`DriverId` AS `DriverId`, `Drivers`.`FullName` AS `DriverName`, `Trucks`.`TruckId` AS `TruckId`, `Trucks`.`LicensePlate` AS `TruckLicensePlate`, `Trucks`.`Make` AS `TruckMake`, `Trucks`.`Model` AS `TruckModel` FROM (`Drivers` join `Trucks` on((`Drivers`.`TruckId` = `Trucks`.`TruckId`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vTruckDriverSchedules`
--
DROP TABLE IF EXISTS `vTruckDriverSchedules`;

CREATE ALGORITHM=UNDEFINED DEFINER=`bain0059`@`%` SQL SECURITY DEFINER VIEW `vTruckDriverSchedules`  AS SELECT `Trucks`.`TruckId` AS `TruckId`, `Trucks`.`LicensePlate` AS `LicensePlate`, `Drivers`.`FullName` AS `DriverName`, `Schedule`.`ScheduleId` AS `ScheduleId`, `Schedule`.`StartLocation` AS `StartLocation`, `Schedule`.`EndLocation` AS `EndLocation` FROM ((`Trucks` join `Drivers` on((`Trucks`.`TruckId` = `Drivers`.`TruckId`))) join `Schedule` on((`Drivers`.`DriverId` = `Schedule`.`DriverId`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vTruckSchedules`
--
DROP TABLE IF EXISTS `vTruckSchedules`;

CREATE ALGORITHM=UNDEFINED DEFINER=`bain0059`@`%` SQL SECURITY DEFINER VIEW `vTruckSchedules`  AS SELECT `Trucks`.`TruckId` AS `TruckId`, `Trucks`.`LicensePlate` AS `LicensePlate`, `Schedule`.`ScheduleId` AS `ScheduleId`, `Schedule`.`StartLocation` AS `StartLocation`, `Schedule`.`EndLocation` AS `EndLocation` FROM ((`Trucks` join `Drivers` on((`Trucks`.`TruckId` = `Drivers`.`TruckId`))) join `Schedule` on((`Drivers`.`DriverId` = `Schedule`.`DriverId`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`CustomerId`);

--
-- Indexes for table `Drivers`
--
ALTER TABLE `Drivers`
  ADD PRIMARY KEY (`DriverId`),
  ADD UNIQUE KEY `LicenseNumber` (`LicenseNumber`),
  ADD UNIQUE KEY `idx_LicenseNumber` (`LicenseNumber`),
  ADD KEY `TruckId` (`TruckId`),
  ADD KEY `idx_FullName` (`FullName`);

--
-- Indexes for table `FuelConsumption`
--
ALTER TABLE `FuelConsumption`
  ADD PRIMARY KEY (`FuelId`,`TruckId`),
  ADD KEY `TruckId` (`TruckId`);

--
-- Indexes for table `Maintenance`
--
ALTER TABLE `Maintenance`
  ADD PRIMARY KEY (`MaintenanceId`),
  ADD KEY `TruckId` (`TruckId`);

--
-- Indexes for table `Schedule`
--
ALTER TABLE `Schedule`
  ADD PRIMARY KEY (`ScheduleId`),
  ADD KEY `Schedule_ibfk_1` (`DriverId`);

--
-- Indexes for table `Trucks`
--
ALTER TABLE `Trucks`
  ADD PRIMARY KEY (`TruckId`),
  ADD UNIQUE KEY `LicensePlate` (`LicensePlate`),
  ADD KEY `StatusId` (`StatusId`);

--
-- Indexes for table `TruckStatus`
--
ALTER TABLE `TruckStatus`
  ADD PRIMARY KEY (`StatusID`),
  ADD UNIQUE KEY `STATUSDesc` (`STATUSDesc`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `CustomerId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Drivers`
--
ALTER TABLE `Drivers`
  MODIFY `DriverId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `FuelConsumption`
--
ALTER TABLE `FuelConsumption`
  MODIFY `FuelId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Maintenance`
--
ALTER TABLE `Maintenance`
  MODIFY `MaintenanceId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Schedule`
--
ALTER TABLE `Schedule`
  MODIFY `ScheduleId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `Trucks`
--
ALTER TABLE `Trucks`
  MODIFY `TruckId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `TruckStatus`
--
ALTER TABLE `TruckStatus`
  MODIFY `StatusID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Drivers`
--
ALTER TABLE `Drivers`
  ADD CONSTRAINT `Drivers_ibfk_1` FOREIGN KEY (`TruckId`) REFERENCES `Trucks` (`TruckId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `FuelConsumption`
--
ALTER TABLE `FuelConsumption`
  ADD CONSTRAINT `FuelConsumption_ibfk_1` FOREIGN KEY (`TruckId`) REFERENCES `Trucks` (`TruckId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Maintenance`
--
ALTER TABLE `Maintenance`
  ADD CONSTRAINT `Maintenance_ibfk_1` FOREIGN KEY (`TruckId`) REFERENCES `Trucks` (`TruckId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Schedule`
--
ALTER TABLE `Schedule`
  ADD CONSTRAINT `Schedule_ibfk_1` FOREIGN KEY (`DriverId`) REFERENCES `Drivers` (`DriverId`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Trucks`
--
ALTER TABLE `Trucks`
  ADD CONSTRAINT `Trucks_ibfk_1` FOREIGN KEY (`StatusId`) REFERENCES `TruckStatus` (`StatusID`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`bain0059`@`%` EVENT `RemoveInactiveDrivers` ON SCHEDULE EVERY 1 MONTH STARTS '2024-11-30 00:49:48' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DELETE FROM Drivers
    WHERE DriverId NOT IN (
        SELECT DISTINCT DriverId 
        FROM Schedule 
        WHERE Date >= NOW() - INTERVAL 1 YEAR
    );
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
