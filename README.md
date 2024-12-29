<h2>Overview</h2>
<p>FleetMaster is a comprehensive trucking management system designed to optimize and manage trucking operations. The system includes features for managing trucks, drivers, maintenance, schedules, and customers, with integrated views and reports for better decision-making.</p>

<h2>Database Details</h2>

<h3>Tables</h3>
<ul>
    <li><strong>TruckStatus</strong>: Tracks truck statuses.</li>
    <li><strong>Trucks</strong>: Stores truck details and maintenance data.</li>
    <li><strong>Drivers</strong>: Manages driver assignments and licenses.</li>
    <li><strong>Schedule</strong>: Logs delivery schedules and statuses.</li>
    <li><strong>FuelConsumption</strong>: Records fuel usage and costs.</li>
    <li><strong>Maintenance</strong>: Tracks maintenance logs and costs.</li>
    <li><strong>Customers</strong>: Stores customer contact information.</li>
</ul>

<h3>Relationships</h3>
<ul>
    <li><code>Trucks.StatusId → TruckStatus.StatusId</code></li>
    <li><code>Drivers.TruckId → Trucks.TruckId</code></li>
    <li><code>Schedule.DriverId → Drivers.DriverId</code></li>
    <li><code>FuelConsumption.TruckId → Trucks.TruckId</code></li>
    <li><code>Maintenance.TruckId → Trucks.TruckId</code></li>
</ul>

<h3>Features</h3>
<ul>
    <li><strong>Stored Procedures</strong>:
        <ul>
            <li><code>GetTruckSchedules</code>: Retrieves schedules for a specific truck.</li>
        </ul>
    </li>
    <li><strong>Functions</strong>:
        <ul>
            <li><code>TotalDistanceTraveled</code>: Calculates total distance for a truck.</li>
        </ul>
    </li>
    <li><strong>Triggers</strong>:
        <ul>
            <li><code>EnforceTruckCapacity</code>: Ensures truck capacity is valid.</li>
        </ul>
    </li>
    <li><strong>Events</strong>:
        <ul>
            <li><code>RemoveInactiveDrivers</code>: Deletes drivers with no schedules in the past year.</li>
        </ul>
    </li>
</ul>

<h2>Getting Started</h2>
<ol>
    <li>Import the SQL script into your MySQL database.</li>
    <li>Use phpMyAdmin or any MySQL client to manage and query the database.</li>
    <li>Customize views and reports as needed.</li>
</ol>
