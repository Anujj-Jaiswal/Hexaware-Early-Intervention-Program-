-- Courier_Management_System

-- Task 1 Database Design 

CREATE DATABASE Courier_Management_System;
USE Courier_Management_System;

CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20),
    Address TEXT
);

INSERT INTO User (Name, Email, Password, ContactNumber, Address) VALUES
('Amit Sharma', 'amit.sharma@example.com', 'password123', '9876543210', '123, MG Road, Mumbai'),
('Neha Gupta', 'neha.gupta@example.com', 'securePass!@#', '9123456780', '456, Brigade Road, Bangalore'),
('Ravi Kumar', 'ravi.kumar@example.com', 'raviPass456', '9988776655', '789, Park Street, Kolkata');

CREATE TABLE Courier (
    CourierID INT AUTO_INCREMENT PRIMARY KEY,
    SenderName VARCHAR(255) NOT NULL,
    SenderAddress TEXT NOT NULL,
    ReceiverName VARCHAR(255) NOT NULL,
    ReceiverAddress TEXT NOT NULL,
    Weight DECIMAL(5,2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE NOT NULL,
    DeliveryDate DATE
);

INSERT INTO Courier (SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
('Amit Sharma', '123, MG Road, Mumbai', 'Neha Gupta', '456, Brigade Road, Bangalore', 2.50, 'In Transit', 'TRK123456789', '2024-10-05'),
('Neha Gupta', '456, Brigade Road, Bangalore', 'Ravi Kumar', '789, Park Street, Kolkata', 1.75, 'Delivered', 'TRK987654321', '2024-10-03'),
('Ravi Kumar', '789, Park Street, Kolkata', 'Amit Sharma', '123, MG Road, Mumbai', 3.20, 'Pending', 'TRK192837465', '2024-10-07');

CREATE TABLE CourierServices (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    Cost DECIMAL(8,2) NOT NULL
);

INSERT INTO CourierServices (ServiceName, Cost) VALUES
('Standard Delivery', 250.00),
('Express Delivery', 500.00),
('Same-Day Delivery', 800.00);

CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee (Name, Email, ContactNumber, Role, Salary) VALUES
('Suresh Mehta', 'suresh.mehta@courier.com', '9876501234', 'Dispatcher', 35000.00),
('Priya Singh', 'priya.singh@courier.com', '9123405678', 'Delivery Executive', 28000.00),
('Vikram Patel', 'vikram.patel@courier.com', '9987612345', 'Manager', 60000.00);

CREATE TABLE Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    LocationName VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL
);

INSERT INTO Location (LocationName, Address) VALUES
('Mumbai Hub', '12, Gateway of India, Mumbai'),
('Bangalore Hub', '34, MG Road, Bangalore'),
('Kolkata Hub', '56, Park Street, Kolkata');

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

INSERT INTO Payment (CourierID, LocationID, Amount, PaymentDate) VALUES
(1, 1, 250.00, '2024-10-04'),
(2, 2, 500.00, '2024-10-03'),
(3, 3, 800.00, '2024-10-06');

-- Task 2

-- 1. List all customers:
SELECT Name, Email, ContactNumber, Address 
FROM User;

-- 2. List all orders for a specific customer:
SELECT CourierID, SenderName, ReceiverName, TrackingNumber, Status, DeliveryDate
FROM Courier
WHERE SenderName = 'Amit Sharma';

-- 3. List all couriers:
SELECT * 
FROM Courier;

-- 4. List all packages for a specific order:
SELECT CourierID, SenderName, ReceiverName, Weight, Status, TrackingNumber, DeliveryDate
FROM Courier
WHERE CourierID = 1; 

-- 5. List all deliveries for a specific courier:
SELECT * 
FROM Courier
WHERE TrackingNumber = 'TRK123456789'; 

-- 6. List all undelivered packages:
SELECT * 
FROM Courier
WHERE Status != 'Delivered';

-- 7. List all packages that are scheduled for delivery today:
SELECT * 
FROM Courier
WHERE DeliveryDate = CURDATE();

-- 8. List all packages with a specific status:
SELECT * 
FROM Courier
WHERE Status = 'In Transit'; 

-- 9. Calculate the total number of packages for each courier:
SELECT SenderName, COUNT(*) AS TotalPackages 
FROM Courier
GROUP BY SenderName;

-- 10. Find the average delivery time for each courier:
SELECT SenderName, AVG(DATEDIFF(DeliveryDate, CURDATE())) AS AvgDeliveryTime
FROM Courier
GROUP BY SenderName;

-- 11. List all packages with a specific weight range:
SELECT * 
FROM Courier
WHERE Weight BETWEEN 1.00 AND 5.00; 

-- 12. Retrieve employees whose names contain 'John':
SELECT * 
FROM Employee
WHERE Name LIKE '%John%';

-- 13. Retrieve all courier records with payments greater than $50:
SELECT c.*
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > 50.00;

-- Task 3

-- 1. Find the total number of couriers handled by each employee:
SELECT e.Name, COUNT(c.CourierID) AS TotalCouriers
FROM Employee e
JOIN Courier c ON e.Name = c.SenderName 
GROUP BY e.Name;

-- 2. Calculate the total revenue generated by each location:
SELECT l.LocationName, SUM(p.Amount) AS TotalRevenue
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationName;

-- 3. Find the total number of couriers delivered to each location:
SELECT l.LocationName, COUNT(c.CourierID) AS TotalCouriersDelivered
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
JOIN Courier c ON p.CourierID = c.CourierID
WHERE c.Status = 'Delivered'
GROUP BY l.LocationName;

-- 4. Find the courier with the highest average delivery time:
SELECT SenderName, AVG(DATEDIFF(DeliveryDate, CURDATE())) AS AvgDeliveryTime
FROM Courier
GROUP BY SenderName
ORDER BY AvgDeliveryTime DESC
LIMIT 1;

-- 5. Find Locations with Total Payments Less Than a Certain Amount:
SELECT l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationName
HAVING TotalPayments < 5000; 

-- 6. Calculate Total Payments per Location:
SELECT l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationName;

-- 7. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X):
SELECT c.TrackingNumber, SUM(p.Amount) AS TotalPayments
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.LocationID = X 
GROUP BY c.TrackingNumber
HAVING TotalPayments > 1000;

-- 8. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'):
SELECT c.TrackingNumber, SUM(p.Amount) AS TotalPayments
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.PaymentDate > 'YYYY-MM-DD' 
GROUP BY c.TrackingNumber
HAVING TotalPayments > 1000;

-- 9. Retrieve locations where the total amount received is more than $5000 before a certain date 
SELECT l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
WHERE p.PaymentDate < 'YYYY-MM-DD' 
GROUP BY l.LocationName
HAVING TotalPayments > 5000;

-- Task 4

-- 1. Retrieve Payments with Courier Information
SELECT p.*, c.*
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID;

-- 2. Retrieve Payments with Location Information
SELECT p.*, l.*
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID;

-- 3. Retrieve Payments with Courier and Location Information
SELECT p.*, c.*, l.*
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID
INNER JOIN Location l ON p.LocationID = l.LocationID;

-- 4. List all payments with courier details
SELECT p.PaymentID, p.Amount, c.TrackingNumber, c.Status
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID;

-- 5. Total payments received for each courier
SELECT c.TrackingNumber, SUM(p.Amount) AS TotalPayments
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.TrackingNumber;

-- 6. List payments made on a specific date
SELECT *
FROM Payment
WHERE PaymentDate = '2024-10-03'; 

-- 7. Get Courier Information for Each Payment
SELECT p.PaymentID, c.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID;

-- 8. Get Payment Details with Location
SELECT p.PaymentID, l.LocationName, l.Address, p.Amount
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID;

-- 9. Calculating Total Payments for Each Courier
SELECT c.TrackingNumber, SUM(p.Amount) AS TotalPayments
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.TrackingNumber;

-- 10. List Payments Within a Date Range
SELECT *
FROM Payment
WHERE PaymentDate BETWEEN '2024-10-01' AND '2024-10-07'; 

-- 11. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side
SELECT u.Name, c.*
FROM User u
LEFT OUTER JOIN Courier c ON u.Name = c.SenderName;

-- 12. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side
SELECT c.*, s.*
FROM Courier c
LEFT OUTER JOIN CourierServices s ON c.CourierID = s.ServiceID;

-- 13. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side
SELECT e.Name, p.*
FROM Employee e
LEFT OUTER JOIN Payment p ON e.Name = p.CourierID; 

-- 14. List all users and all courier services, showing all possible combinations
SELECT u.Name, s.ServiceName
FROM User u
CROSS JOIN CourierServices s;

-- 15. List all employees and all locations, showing all possible combinations
SELECT e.Name, l.LocationName
FROM Employee e
CROSS JOIN Location l;

-- 16. Retrieve a list of couriers and their corresponding sender information 
SELECT c.*, u.*
FROM Courier c
LEFT OUTER JOIN User u ON c.SenderName = u.Name;

-- 17. Retrieve a list of couriers and their corresponding receiver information 
SELECT c.*, u.*
FROM Courier c
LEFT OUTER JOIN User u ON c.ReceiverName = u.Name;

-- 18. Retrieve a list of couriers along with the courier service details 
SELECT c.*, s.*
FROM Courier c
LEFT OUTER JOIN CourierServices s ON c.CourierID = s.ServiceID;

-- 19. Retrieve a list of employees and the number of couriers assigned to each employee
SELECT e.Name, COUNT(c.CourierID) AS NumberOfCouriers
FROM Employee e
LEFT OUTER JOIN Courier c ON e.Name = c.SenderName
GROUP BY e.Name;

-- 20. Retrieve a list of locations and the total payment amount received at each location
SELECT l.LocationName, SUM(p.Amount) AS TotalPaymentAmount
FROM Location l
LEFT OUTER JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationName;

-- 21. Retrieve all couriers sent by the same sender 
SELECT *
FROM Courier
WHERE SenderName = 'Amit Sharma'; 

-- 22. List all employees who share the same role
SELECT Name, Role
FROM Employee
GROUP BY Role
HAVING COUNT(*) > 1;

-- 23. Retrieve all payments made for couriers sent from the same location
SELECT p.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID
WHERE c.SenderAddress = '123, MG Road, Mumbai'; 

-- 24. Retrieve all couriers sent from the same location (based on SenderAddress)
SELECT *
FROM Courier
WHERE SenderAddress = '123, MG Road, Mumbai';

-- 25. List employees and the number of couriers they have delivered
SELECT e.Name, COUNT(c.CourierID) AS NumberOfDeliveries
FROM Employee e
LEFT OUTER JOIN Courier c ON e.Name = c.SenderName
GROUP BY e.Name;

-- 26. Find couriers that were paid an amount greater than the cost of their respective courier services
SELECT c.*, p.Amount, s.Cost
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
JOIN CourierServices s ON c.CourierID = s.ServiceID
WHERE p.Amount > s.Cost;

-- 27. Find couriers that have a weight greater than the average weight of all couriers
SELECT *
FROM Courier
WHERE Weight > (SELECT AVG(Weight) FROM Courier);

-- 28. Find the names of all employees who have a salary greater than the average salary
SELECT Name, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- 29. Find the total cost of all courier services where the cost is less than the maximum cost
SELECT SUM(Cost)
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);

-- 30. Find all couriers that have been paid for
SELECT *
FROM Courier
WHERE CourierID IN (SELECT CourierID FROM Payment);

-- 31. Find the locations where the maximum payment amount was made
SELECT LocationName, MAX(Amount) AS MaxPayment
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY LocationName;

-- 32. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName')
SELECT *
FROM Courier
WHERE Weight > (SELECT MAX(Weight) FROM Courier WHERE SenderName = 'Amit Sharma'); 


