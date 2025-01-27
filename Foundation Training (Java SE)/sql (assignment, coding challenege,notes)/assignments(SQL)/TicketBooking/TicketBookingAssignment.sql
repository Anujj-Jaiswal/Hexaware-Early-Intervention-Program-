-- TicketBooking System Assignment

-- Task 1 Database Design 

CREATE DATABASE TicketBookingSystem;
USE TicketBookingSystem;

CREATE TABLE Venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

INSERT INTO Venue (venue_name, address) VALUES
('INOX Cinemas', 'MG Road, Bangalore'),
('Sardar Vallabhbhai Patel Stadium', 'Ahmedabad, Gujarat'),
('Nehru Indoor Stadium', 'Mumbai, Maharashtra'),
('PVR Cinemas', 'Connaught Place, Delhi'),
('Rajiv Gandhi Indoor Stadium', 'Hyderabad, Telangana'),
('Cinepolis', 'Marine Drive, Chennai'),
('FIFA Arena', 'Kolkata, West Bengal'),
('The Grand Concert Hall', 'Pune, Maharashtra'),
('Eros Theater', 'Bandra, Mumbai'),
('Regal Cinema', 'Chennai, Tamil Nadu');

CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    event_type ENUM('Movie', 'Sports', 'Concert') NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('Avengers: Endgame', '2024-11-15', '18:30:00', 1, 200, 150, 250.00, 'Movie'),
('Rock Night', '2024-12-05', '20:00:00', 7, 500, 300, 500.00, 'Concert'),
('Cricket Finals', '2024-11-20', '16:00:00', 2, 1000, 800, 750.00, 'Sports'),
('Shakespeare Play', '2024-10-25', '19:00:00', 9, 300, 200, 300.00, 'Concert'), -- Changed to Concert
('Bollywood Musical', '2024-12-10', '20:30:00', 10, 400, 350, 400.00, 'Concert'),
('Interstellar', '2024-11-18', '17:00:00', 4, 250, 200, 220.00, 'Movie'),
('Live Football Match', '2024-12-22', '15:00:00', 3, 1500, 1200, 600.00, 'Sports'),
('Jazz Evening', '2024-10-30', '19:30:00', 8, 350, 250, 450.00, 'Concert'),
('Spider-Man: No Way Home', '2024-11-25', '18:00:00', 5, 300, 250, 230.00, 'Movie'),
('Classical Dance Show', '2024-12-15', '18:45:00', 6, 200, 150, 350.00, 'Concert'); 

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15)
);

INSERT INTO Customer (customer_name, email, phone_number) VALUES
('Amit Sharma', 'amit.sharma@example.com', '9876543210'),
('Priya Singh', 'priya.singh@example.com', '9123456780'),
('Rohan Mehta', 'rohan.mehta@example.com', '9988776655'),
('Sakshi Verma', 'sakshi.verma@example.com', '8877665544'),
('Vikram Patel', 'vikram.patel@example.com', '7766554433'),
('Neha Gupta', 'neha.gupta@example.com', '6655443322'),
('Anil Kumar', 'anil.kumar@example.com', '5544332211'),
('Divya Joshi', 'divya.joshi@example.com', '4433221100'),
('Karan Malhotra', 'karan.malhotra@example.com', '3322110099'),
('Sneha Rao', 'sneha.rao@example.com', '2211009988');

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost) VALUES
(1, 1, 2, 500.00),
(2, 2, 4, 2000.00),
(3, 3, 3, 2250.00),
(4, 4, 1, 300.00),
(5, 5, 2, 800.00),
(6, 6, 3, 660.00),
(7, 7, 5, 3000.00),
(8, 8, 2, 900.00),
(9, 9, 4, 920.00),
(10, 10, 3, 1050.00);


-- Task 1 Database Design 

-- 1. Write a SQL query to list all Events.
SELECT * FROM Event;

-- 2. Write a SQL query to select events with available tickets.
SELECT * FROM Event WHERE available_seats > 0;

-- 3. Write a SQL query to select events name partial match with ‘cup’.
SELECT * FROM Event WHERE event_name LIKE '%cup%';

-- 4. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;

-- 5. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM Event WHERE event_date BETWEEN '2024-11-01' AND '2024-12-31';

-- 6. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * FROM Event WHERE available_seats > 0 AND event_type = 'Concert';

-- 7. Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT * FROM Customer LIMIT 5 OFFSET 5;

-- 8. Write a SQL query to retrieve bookings details contains booked no of tickets more than 4.
SELECT * FROM Booking WHERE num_tickets > 4;

-- 9. Write a SQL query to retrieve customer information whose phone number ends with ‘000’.
SELECT * FROM Customer WHERE phone_number LIKE '%000';

-- 10. Write a SQL query to retrieve the events in order whose seat capacity is more than 15000.
SELECT * FROM Event WHERE total_seats > 15000 ORDER BY event_name;

-- 11. Write a SQL query to select events name not starting with ‘x’, ‘y’, ‘z’.
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';

-- Task 3

-- 1. Write a SQL query to list Events and their Average Ticket Prices.
SELECT event_name, AVG(ticket_price) AS average_ticket_price
FROM Event
GROUP BY event_name;

-- 2. Write a SQL query to calculate the Total Revenue Generated by Events.
SELECT event_name, SUM(num_tickets * ticket_price) AS total_revenue
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name;

-- 3. Write a SQL query to find the event with the highest ticket sales.
SELECT event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name
ORDER BY total_tickets_sold DESC
LIMIT 1;

-- 4. Write a SQL query to calculate the Total Number of Tickets Sold for Each Event.
SELECT event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name;

-- 5. Write a SQL query to find Events with No Ticket Sales.
SELECT event_name
FROM Event
LEFT JOIN Booking ON Event.event_id = Booking.event_id
WHERE Booking.booking_id IS NULL;

-- 6. Write a SQL query to find the user who has booked the most tickets.
SELECT customer_name, SUM(num_tickets) AS total_tickets_booked
FROM Booking 
JOIN Customer ON Booking.customer_id = Customer.customer_id
GROUP BY customer_name
ORDER BY total_tickets_booked DESC
LIMIT 1;

-- 7. Write a SQL query to list Events and the total number of tickets sold for each month.
SELECT event_name, MONTHNAME(event_date) AS month, SUM(num_tickets) AS total_tickets_sold
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name, MONTHNAME(event_date);

-- 8. Write a SQL query to calculate the Average Ticket Price for Events in Each Venue.
SELECT venue_name, AVG(ticket_price) AS average_ticket_price
FROM Event
JOIN Venue ON Event.venue_id = Venue.venue_id
GROUP BY venue_name;

-- 9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_type;

-- 10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
SELECT YEAR(event_date) AS year, SUM(num_tickets * ticket_price) AS total_revenue
FROM Booking 
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY YEAR(event_date);

-- 11. Write a SQL query to list users who have booked tickets for multiple events.
SELECT customer_name, COUNT(DISTINCT event_id) AS total_events_booked
FROM Booking 
JOIN Customer ON Booking.customer_id = Customer.customer_id
GROUP BY customer_name
HAVING total_events_booked > 1;

-- 12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT customer_name, SUM(num_tickets * ticket_price) AS total_revenue
FROM Booking 
JOIN Customer ON Booking.customer_id = Customer.customer_id
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY customer_name;

-- 13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.
SELECT event_type, venue_name, AVG(ticket_price) AS average_ticket_price
FROM Event
JOIN Venue ON Event.venue_id = Venue.venue_id
GROUP BY event_type, venue_name;

-- 14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
SELECT customer_name, SUM(num_tickets) AS total_tickets_purchased
FROM Booking 
JOIN Customer ON Booking.customer_id = Customer.customer_id
WHERE booking_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY customer_name;


-- Task 4

-- 1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT venue_name, (SELECT AVG(ticket_price) FROM Event WHERE Event.venue_id = Venue.venue_id) AS average_ticket_price
FROM Venue;

-- 2. Find Events with More Than 50% of Tickets Sold using subquery.
SELECT event_name
FROM Event
WHERE (total_seats - available_seats) > (0.5 * total_seats);

-- 3. Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_name, (SELECT SUM(num_tickets) FROM Booking WHERE Event.event_id = Booking.event_id) AS total_tickets_sold
FROM Event;

-- 4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT customer_name
FROM Customer
WHERE NOT EXISTS (SELECT 1 FROM Booking WHERE Booking.customer_id = Customer.customer_id);

-- 5. List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT event_name
FROM Event
WHERE event_id NOT IN (SELECT event_id FROM Booking);

-- 6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
SELECT event_type, total_tickets_sold
FROM (SELECT event_type, SUM(num_tickets) AS total_tickets_sold
      FROM Booking 
      JOIN Event ON Booking.event_id = Event.event_id
      GROUP BY event_type) AS subquery;

-- 7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT event_name, ticket_price
FROM Event
WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);

-- 8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT customer_name, (SELECT SUM(num_tickets * ticket_price) FROM Booking 
                       JOIN Event ON Booking.event_id = Event.event_id 
                       WHERE Booking.customer_id = Customer.customer_id) AS total_revenue
FROM Customer;

-- 9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
SELECT customer_name
FROM Customer
WHERE customer_id IN (SELECT Booking.customer_id 
                      FROM Booking 
                      JOIN Event ON Booking.event_id = Event.event_id
                      WHERE Event.venue_id = 1);  

-- 10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY.
SELECT event_type, (SELECT SUM(num_tickets) FROM Booking WHERE Event.event_id = Booking.event_id) AS total_tickets_sold
FROM Event
GROUP BY event_type;

-- 11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT.
SELECT customer_name
FROM Customer
WHERE customer_id IN (SELECT Booking.customer_id 
                      FROM Booking
                      JOIN Event ON Booking.event_id = Event.event_id
                      WHERE DATE_FORMAT(event_date, '%Y-%m') = '2024-10');  

-- 12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT venue_name, (SELECT AVG(ticket_price) FROM Event WHERE Event.venue_id = Venue.venue_id) AS average_ticket_price
FROM Venue;







