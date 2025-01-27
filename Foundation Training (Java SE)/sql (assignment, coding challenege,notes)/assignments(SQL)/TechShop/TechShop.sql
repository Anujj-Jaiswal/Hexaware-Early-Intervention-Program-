-- TechShop Assignment 

-- Task 1 Database Design 
CREATE DATABASE TechShop;
Use TechShop;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Amit', 'Sharma', 'amit.sharma@example.com', '9876543210', '123, MG Road, Mumbai'),
('Priya', 'Verma', 'priya.verma@example.com', '9123456780', '456, Park Street, Kolkata'),
('Rahul', 'Khan', 'rahul.khan@example.com', '9988776655', '789, Brigade Road, Bangalore'),
('Sneha', 'Iyer', 'sneha.iyer@example.com', '8877665544', '321, Residency Road, Chennai'),
('Vikram', 'Singh', 'vikram.singh@example.com', '7766554433', '654, Linking Road, Mumbai'),
('Neha', 'Patel', 'neha.patel@example.com', '6655443322', '987, Banjara Hills, Hyderabad'),
('Karan', 'Joshi', 'karan.joshi@example.com', '5544332211', '159, Marine Drive, Mumbai'),
('Anita', 'Desai', 'anita.desai@example.com', '4433221100', '753, Connaught Place, Delhi'),
('Rohit', 'Mehta', 'rohit.mehta@example.com', '3322110099', '852, Indira Nagar, Delhi'),
('Meena', 'Reddy', 'meena.reddy@example.com', '2211009988', '951, Whitefield, Bangalore');


CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL
);

INSERT INTO Products (ProductName, Description, Price) VALUES
('Smartphone X', 'Latest model with advanced features', 25000.00),
('Laptop Pro', 'High-performance laptop for professionals', 75000.00),
('Wireless Earbuds', 'Noise-cancelling wireless earbuds', 3000.00),
('Smartwatch', 'Feature-rich smartwatch with health tracking', 5000.00),
('Gaming Console', 'Next-gen gaming console with immersive graphics', 35000.00),
('4K LED TV', '55-inch 4K Ultra HD Smart LED TV', 45000.00),
('Bluetooth Speaker', 'Portable Bluetooth speaker with deep bass', 2000.00),
('Digital Camera', 'Mirrorless digital camera with 24MP sensor', 30000.00),
('Tablet S', '10-inch tablet with high-resolution display', 15000.00),
('Home Assistant', 'AI-powered smart home assistant device', 4000.00);


CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-04-10', 28000.00),
(2, '2024-04-12', 75000.00),
(3, '2024-04-15', 5000.00),
(4, '2024-04-18', 45000.00),
(5, '2024-04-20', 25000.00),
(6, '2024-04-22', 2000.00),
(7, '2024-04-25', 35000.00),
(8, '2024-04-27', 15000.00),
(9, '2024-04-29', 4000.00),
(10, '2024-04-30', 30000.00);


CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1),
(4, 6, 1),
(5, 1, 1),
(5, 7, 1),
(6, 3, 1),
(7, 5, 1),
(8, 9, 1),
(9, 10, 1),
(10, 8, 1),
(10, 2, 1);

CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT NOT NULL,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 50, '2024-03-01 10:00:00'),
(2, 30, '2024-03-02 11:30:00'),
(3, 100, '2024-03-03 09:15:00'),
(4, 75, '2024-03-04 14:45:00'),
(5, 20, '2024-03-05 16:20:00'),
(6, 25, '2024-03-06 13:50:00'),
(7, 60, '2024-03-07 08:40:00'),
(8, 40, '2024-03-08 12:10:00'),
(9, 80, '2024-03-09 17:30:00'),
(10, 55, '2024-03-10 19:05:00');


-- Tasks 2: 

-- 1: Select First Name, Last Name, and Email of all customers
SELECT FirstName, LastName, Email
FROM Customers;

-- 2: Select all orders with OrderDate and the corresponding customer names
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 3: Insert a new customer record
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Rajesh', 'Gupta', 'rajesh.gupta@example.com', '9988776622', '789, MG Road, Pune');

-- 4: Update prices by increasing them by 10%
UPDATE Products
SET Price = Price * 1.10;

-- 5: Delete an order and its associated order details based on OrderID
DELETE FROM OrderDetails WHERE OrderID = 101;  
DELETE FROM Orders WHERE OrderID = 101;      

-- 6: Insert a new order into the Orders table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (3, '2024-10-01', 45000.00);

-- 7: Update a specific customer's email and address
UPDATE Customers
SET Email = 'new.email@example.com', Address = 'New Address, New City'
WHERE CustomerID = 2;  

-- 8: Recalculate and update the total amount for each order
UPDATE Orders O
JOIN (
    SELECT OrderID, SUM(OD.Quantity * P.Price) AS TotalAmount
    FROM OrderDetails OD
    JOIN Products P ON OD.ProductID = P.ProductID
    GROUP BY OrderID
) AS CalculatedOrders ON O.OrderID = CalculatedOrders.OrderID
SET O.TotalAmount = CalculatedOrders.TotalAmount;

-- 9: Delete all orders and order details for a specific customer
DELETE FROM OrderDetails WHERE OrderID IN (
    SELECT OrderID FROM Orders WHERE CustomerID = 5  
);
DELETE FROM Orders WHERE CustomerID = 5; 

-- 10: Insert a new product into the Products table
INSERT INTO Products (ProductName, Description, Price)
VALUES ('Smartphone Z', 'Next-gen smartphone with advanced features', 30000.00);

-- 11: Update the status of a specific order
ALTER TABLE Orders ADD COLUMN Status VARCHAR(20);  
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 7;  

-- 12: Calculate and update the number of orders per customer
ALTER TABLE Customers ADD COLUMN NumberOfOrders INT;  
UPDATE Customers C
SET C.NumberOfOrders = (
    SELECT COUNT(*) FROM Orders O WHERE O.CustomerID = C.CustomerID
);

-- Tasks 3:

-- 1. Retrieve orders along with customer information 
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName, Customers.Email
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 2. Calculate total revenue generated by each product
SELECT Products.ProductName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName;

-- 3. List customers who have made at least one purchase
SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone, Customers.Address
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 4. Find the most popular product (highest total quantity ordered)
SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName
ORDER BY TotalQuantityOrdered DESC
LIMIT 1;

-- 5. List gadgets along with their corresponding categories
ALTER TABLE Products
ADD COLUMN Category VARCHAR(50);

UPDATE Products SET Category = 'Smartphone' WHERE ProductName = 'Smartphone X';
UPDATE Products SET Category = 'Laptop' WHERE ProductName = 'Laptop Pro';
UPDATE Products SET Category = 'Audio' WHERE ProductName = 'Wireless Earbuds';
UPDATE Products SET Category = 'Wearable' WHERE ProductName = 'Smartwatch';
UPDATE Products SET Category = 'Gaming' WHERE ProductName = 'Gaming Console';
UPDATE Products SET Category = 'Television' WHERE ProductName = '4K LED TV';
UPDATE Products SET Category = 'Audio' WHERE ProductName = 'Bluetooth Speaker';
UPDATE Products SET Category = 'Camera' WHERE ProductName = 'Digital Camera';
UPDATE Products SET Category = 'Tablet' WHERE ProductName = 'Tablet S';
UPDATE Products SET Category = 'Home Assistant' WHERE ProductName = 'Home Assistant';

SELECT ProductName, Category
FROM Products;

-- 6. Calculate average order value per customer
SELECT Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

-- 7. Find the order with the highest total revenue
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY Orders.TotalAmount DESC
LIMIT 1;

-- 8. List products and the number of times each product has been ordered
SELECT Products.ProductName, COUNT(OrderDetails.ProductID) AS TimesOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName;

-- 9. Find customers who have purchased a specific product 
SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = 'Smartphone X';  

-- 10. Calculate total revenue for orders within a specific time period 
SELECT SUM(Orders.TotalAmount) AS TotalRevenue
FROM Orders
WHERE Orders.OrderDate BETWEEN '2024-01-01' AND '2024-12-31';  

-- Tasks 4:

-- 1. Find customers who have not placed any orders
SELECT FirstName, LastName, Email
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID FROM Orders
);

-- 2. Find the total number of products available for sale
SELECT COUNT(*) AS TotalProducts
FROM Products;

-- 3. Calculate the total revenue generated by TechShop
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

-- 4. Calculate the average quantity ordered for products in a specific category
SELECT AVG(OrderDetails.Quantity) AS AverageQuantity
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Smartphones';  -- Example category

-- 5. Calculate the total revenue generated by a specific customer 
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE CustomerID = 4;  -- Example customer ID

-- 6. Find the customers who have placed the most orders 
SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY OrderCount DESC
LIMIT 1;

-- 7. Find the most popular product category based on total quantity ordered
SELECT Products.Category, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.Category
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 8. Find the customer who has spent the most money on electronic gadgets 
SELECT Customers.FirstName, Customers.LastName, SUM(Orders.TotalAmount) AS TotalSpending
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY TotalSpending DESC
LIMIT 1;

-- 9. Calculate the average order value for all customers
SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

-- 10. Find total number of orders placed by each customer and list their names along with the order count
SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;





















