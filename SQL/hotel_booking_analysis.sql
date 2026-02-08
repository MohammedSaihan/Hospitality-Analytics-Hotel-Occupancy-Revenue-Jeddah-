-- Q.1 TOTAL BOOKINGS & REVENUE


-- total booking
SELECT 
	COUNT(booking_id) AS total_bookings
FROM hotel_bookings
WHERE booking_status = 'Checked-out';

-- total revenue
SELECT 
	SUM(total_amount) AS total_revenue
FROM hotel_bookings
WHERE booking_status = 'Checked-out';