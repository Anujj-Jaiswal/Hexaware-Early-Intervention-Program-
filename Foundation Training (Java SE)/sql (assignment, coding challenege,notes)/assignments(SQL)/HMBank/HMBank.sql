-- Bank System Assignment

-- Task 1 Database Design 

CREATE DATABASE HMBank;
USE HMBank;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE
);

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number) VALUES
('Aarav', 'Sharma', '1990-05-21', 'aarav.sharma@example.com', '9876543210'),
('Vihaan', 'Mehta', '1985-11-15', 'vihaan.mehta@example.com', '9123456780'),
('Diya', 'Patel', '1992-08-30', 'diya.patel@example.com', '9988776655'),
('Isha', 'Reddy', '1988-02-10', 'isha.reddy@example.com', '9765432109'),
('Raj', 'Kumar', '1975-07-19', 'raj.kumar@example.com', '9654321098'),
('Mira', 'Singh', '1995-12-05', 'mira.singh@example.com', '9543210987'),
('Karan', 'Gupta', '1983-03-25', 'karan.gupta@example.com', '9432109876'),
('Nisha', 'Joshi', '1991-09-14', 'nisha.joshi@example.com', '9321098765'),
('Siddharth', 'Desai', '1987-04-18', 'siddharth.desai@example.com', '9210987654'),
('Ananya', 'Bhattacharya', '1993-06-22', 'ananya.bhattacharya@example.com', '9109876543');


CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type ENUM('savings', 'current', 'zero_balance') NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1, 'savings', 50000.00),
(2, 'current', 150000.00),
(3, 'savings', 75000.00),
(4, 'zero_balance', 0.00),
(5, 'current', 200000.00),
(6, 'savings', 60000.00),
(7, 'savings', 85000.00),
(8, 'current', 120000.00),
(9, 'savings', 95000.00),
(10, 'zero_balance', 0.00);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type ENUM('deposit', 'withdrawal', 'transfer') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1, 'deposit', 50000.00, '2024-01-10 10:00:00'),
(2, 'deposit', 150000.00, '2024-01-12 11:30:00'),
(3, 'deposit', 75000.00, '2024-01-15 09:45:00'),
(4, 'deposit', 0.00, '2024-01-18 14:20:00'),
(5, 'deposit', 200000.00, '2024-01-20 16:10:00'),
(6, 'deposit', 60000.00, '2024-01-22 13:50:00'),
(7, 'deposit', 85000.00, '2024-01-25 08:30:00'),
(8, 'deposit', 120000.00, '2024-01-28 17:15:00'),
(9, 'deposit', 95000.00, '2024-01-30 12:00:00'),
(10, 'deposit', 0.00, '2024-02-01 10:05:00'),

(1, 'withdrawal', 5000.00, '2024-02-05 10:00:00'),
(2, 'withdrawal', 20000.00, '2024-02-06 11:30:00'),
(3, 'deposit', 25000.00, '2024-02-07 09:45:00'),
(4, 'deposit', 10000.00, '2024-02-08 14:20:00'),
(5, 'withdrawal', 50000.00, '2024-02-09 16:10:00'),
(6, 'withdrawal', 10000.00, '2024-02-10 13:50:00'),
(7, 'deposit', 15000.00, '2024-02-11 08:30:00'),
(8, 'withdrawal', 30000.00, '2024-02-12 17:15:00'),
(9, 'deposit', 20000.00, '2024-02-13 12:00:00'),
(10, 'deposit', 5000.00, '2024-02-14 10:05:00');



-- Task 2

-- 1. Retrieve the name, account type and email of all customers.
SELECT c.first_name, c.last_name, c.email, a.account_type 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id;

-- 2. List all transactions corresponding to each customer.
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id 
JOIN Transactions t ON a.account_id = t.account_id;

-- 3. Increase the balance of a specific account by a certain amount (e.g., account_id = 1, amount = 5000).
UPDATE Accounts 
SET balance = balance + 5000 
WHERE account_id = 1;

-- 4. Combine first and last names of customers as a full_name.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name 
FROM Customers c;

-- 5. Remove accounts with a balance of zero where the account type is savings.
DELETE FROM Accounts 
WHERE balance = 0 AND account_type = 'savings';

-- 6. Find customers living in a specific city 

ALTER TABLE Customers
ADD COLUMN city VARCHAR(50);

UPDATE Customers SET city = 'New York' WHERE email = 'aarav.sharma@example.com';
UPDATE Customers SET city = 'Los Angeles' WHERE email = 'vihaan.mehta@example.com';
UPDATE Customers SET city = 'Chicago' WHERE email = 'diya.patel@example.com';
UPDATE Customers SET city = 'Houston' WHERE email = 'isha.reddy@example.com';
UPDATE Customers SET city = 'Phoenix' WHERE email = 'raj.kumar@example.com';
UPDATE Customers SET city = 'Philadelphia' WHERE email = 'mira.singh@example.com';
UPDATE Customers SET city = 'San Antonio' WHERE email = 'karan.gupta@example.com';
UPDATE Customers SET city = 'San Diego' WHERE email = 'nisha.joshi@example.com';
UPDATE Customers SET city = 'Dallas' WHERE email = 'siddharth.desai@example.com';
UPDATE Customers SET city = 'San Jose' WHERE email = 'ananya.bhattacharya@example.com';

SELECT * 
FROM Customers 
WHERE city = 'Specific City';

-- 7. Get the account balance for a specific account (e.g., account_id = 1).
SELECT balance 
FROM Accounts 
WHERE account_id = 1;

-- 8. List all current accounts with a balance greater than $1,000.
SELECT * 
FROM Accounts 
WHERE account_type = 'current' AND balance > 1000;

-- 9. Retrieve all transactions for a specific account (e.g., account_id = 1).
SELECT * 
FROM Transactions 
WHERE account_id = 1;

-- 10. Calculate the interest accrued on savings accounts based on a given interest rate (e.g., 5%).
-- Assuming interest rate is an annual rate, and balance is used for a year.
SELECT account_id, balance * 0.05 AS interest_accrued 
FROM Accounts 
WHERE account_type = 'savings';

-- 11. Identify accounts where the balance is less than a specified overdraft limit (e.g., 500).
SELECT * 
FROM Accounts 
WHERE balance < 500;

-- 12. Find customers not living in a specific city.
SELECT * 
FROM Customers 
WHERE city != 'Specific City';

-- Task 3

-- 1. Find the average account balance for all customers.
SELECT AVG(balance) AS average_balance 
FROM Accounts;

-- 2. Retrieve the top 10 highest account balances.
SELECT * 
FROM Accounts 
ORDER BY balance DESC 
LIMIT 10;

-- 3. Calculate total deposits for all customers in a specific date (e.g., '2024-01-01').
SELECT SUM(amount) AS total_deposits 
FROM Transactions 
WHERE transaction_type = 'deposit' AND DATE(transaction_date) = '2024-01-01';

-- 4. Find the oldest and newest customers.
SELECT MIN(DOB) AS oldest_customer, MAX(DOB) AS newest_customer 
FROM Customers;

-- 5. Retrieve transaction details along with the account type.
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, a.account_type 
FROM Transactions t 
JOIN Accounts a ON t.account_id = a.account_id;

-- 6. Get a list of customers along with their account details.
SELECT c.first_name, c.last_name, a.account_id, a.account_type, a.balance 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id;

-- 7. Retrieve transaction details along with customer information for a specific account (e.g., account_id = 1).
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date 
FROM Transactions t 
JOIN Accounts a ON t.account_id = a.account_id 
JOIN Customers c ON a.customer_id = c.customer_id 
WHERE a.account_id = 1;

-- 8. Identify customers who have more than one account.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(a.account_id) AS account_count 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id 
GROUP BY c.customer_id 
HAVING COUNT(a.account_id) > 1;

-- 9. Calculate the difference in transaction amounts between deposits and withdrawals.
SELECT account_id, 
       SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
       (SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) - 
        SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END)) AS balance_difference 
FROM Transactions 
GROUP BY account_id;

-- 10. Calculate the average daily balance for each account over a specified period.
SELECT account_id, 
       AVG(balance) AS average_daily_balance 
FROM Accounts 
WHERE account_id IN (SELECT account_id FROM Transactions WHERE transaction_date BETWEEN '2024-01-01' AND '2024-01-31')
GROUP BY account_id;

-- 11. Calculate the total balance for each account type.
SELECT account_type, 
       SUM(balance) AS total_balance 
FROM Accounts 
GROUP BY account_type;

-- 12. Identify accounts with the highest number of transactions, ordered by descending order.
SELECT a.account_id, 
       COUNT(t.transaction_id) AS transaction_count 
FROM Accounts a 
JOIN Transactions t ON a.account_id = t.account_id 
GROUP BY a.account_id 
ORDER BY transaction_count DESC;

-- 13. List customers with high aggregate account balances, along with their account types.
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, SUM(a.balance) AS total_balance 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id 
GROUP BY c.customer_id, a.account_type 
HAVING total_balance > 100000;  

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account.
SELECT transaction_type, amount, transaction_date, account_id, COUNT(*) AS transaction_count 
FROM Transactions 
GROUP BY transaction_type, amount, transaction_date, account_id 
HAVING COUNT(*) > 1;

-- Task 4

-- 1. Retrieve the customer(s) with the highest account balance.
SELECT c.first_name, c.last_name, a.balance 
FROM Customers c 
JOIN Accounts a ON c.customer_id = a.customer_id 
WHERE a.balance = (SELECT MAX(balance) FROM Accounts);

-- 2. Calculate the average account balance for customers who have more than one account.
SELECT AVG(a.balance) AS avg_balance 
FROM Accounts a 
WHERE a.customer_id IN (SELECT customer_id 
                        FROM Accounts 
                        GROUP BY customer_id 
                        HAVING COUNT(account_id) > 1);

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
SELECT t.* 
FROM Transactions t 
WHERE t.amount > (SELECT AVG(amount) FROM Transactions);

-- 4. Identify customers who have no recorded transactions.
SELECT c.first_name, c.last_name 
FROM Customers c 
WHERE c.customer_id NOT IN (SELECT DISTINCT a.customer_id 
                            FROM Accounts a 
                            JOIN Transactions t ON a.account_id = t.account_id);

-- 5. Calculate the total balance of accounts with no recorded transactions.
SELECT SUM(a.balance) AS total_balance 
FROM Accounts a 
WHERE a.account_id NOT IN (SELECT DISTINCT t.account_id 
                           FROM Transactions t);

-- 6. Retrieve transactions for accounts with the lowest balance.
SELECT t.* 
FROM Transactions t 
WHERE t.account_id = (SELECT a.account_id 
                      FROM Accounts a 
                      WHERE a.balance = (SELECT MIN(balance) FROM Accounts));

-- 7. Identify customers who have accounts of multiple types.
SELECT c.customer_id, c.first_name, c.last_name 
FROM Customers c 
WHERE c.customer_id IN (SELECT a.customer_id 
                        FROM Accounts a 
                        GROUP BY a.customer_id 
                        HAVING COUNT(DISTINCT a.account_type) > 1);

-- 8. Calculate the percentage of each account type out of the total number of accounts.
SELECT a.account_type, 
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts)) AS percentage 
FROM Accounts a 
GROUP BY a.account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id (e.g., customer_id = 1).
SELECT t.* 
FROM Transactions t 
WHERE t.account_id IN (SELECT a.account_id 
                       FROM Accounts a 
                       WHERE a.customer_id = 1);

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
SELECT a.account_type, 
       (SELECT SUM(balance) 
        FROM Accounts 
        WHERE account_type = a.account_type) AS total_balance 
FROM Accounts a 
GROUP BY a.account_type;
