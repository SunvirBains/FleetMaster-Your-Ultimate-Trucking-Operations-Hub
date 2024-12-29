# FleetMaster-Your-Ultimate-Trucking-Operations-Hub
FleetMaster is a smart trucking management system that streamlines operations, tracks truck statuses, schedules drivers, manages maintenance, and analyzes fuel usage. With integrated customer records and automated alerts, it ensures efficient fleet operations, reduced downtime, and improved logistics for trucking businesses.
Overview
FleetMaster is a comprehensive trucking management system designed to optimize and manage trucking operations. The system includes features for managing trucks, drivers, maintenance, schedules, and customers, with integrated views and reports for better decision-making.

Database Details
Tables
TruckStatus: Tracks truck statuses.
Trucks: Stores truck details and maintenance data.
Drivers: Manages driver assignments and licenses.
Schedule: Logs delivery schedules and statuses.
FuelConsumption: Records fuel usage and costs.
Maintenance: Tracks maintenance logs and costs.
Customers: Stores customer contact information.
Relationships
Trucks.StatusId → TruckStatus.StatusId
Drivers.TruckId → Trucks.TruckId
Schedule.DriverId → Drivers.DriverId
FuelConsumption.TruckId → Trucks.TruckId
Maintenance.TruckId → Trucks.TruckId
Features
Stored Procedures:
GetTruckSchedules: Retrieves schedules for a specific truck.
Functions:
TotalDistanceTraveled: Calculates total distance for a truck.
Triggers:
EnforceTruckCapacity: Ensures truck capacity is valid.
Events:
RemoveInactiveDrivers: Deletes drivers with no schedules in the past year.
Getting Started
Import the SQL script into your MySQL database.
Use phpMyAdmin or any MySQL client to manage and query the database.
Customize views and reports as needed.
