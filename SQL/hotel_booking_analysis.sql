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


-- Q2. MONTHLY BOOKINGS TREND

SELECT 
	DATE_FORMAT(check_in_date,'%y-%m') AS month,
    COUNT(booking_id) AS total_bookings
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'
GROUP BY month
ORDER BY month;

-- Q3. MONTHLY REVENUE TREND

SELECT
	DATE_FORMAT(check_in_date,'%y-%m') AS month,
	SUM(total_amount) AS monthly_revenue
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'    
GROUP BY month
ORDER BY month;

-- Q4. AVERAGE LENGTH OF STAY
SELECT 
	ROUND(AVG(nights),2) AS avg_length_of_stay
FROM hotel_bookings
WHERE booking_status = 'Checked-Out';  

-- Q5 .OCCUPANCY ANALYSIS

SELECT 
	CASE 
		WHEN DAYOFWEEK(check_in_date) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
	END AS day_type,
    COUNT(booking_id) AS total_bookings
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'
GROUP BY day_type;

-- Q6.ADR – Average Daily Rate
SELECT 
	ROUND(SUM(total_amount) / SUM(nights), 2) AS ADR
FROM hotel_bookings
WHERE booking_status = 'Checked-Out';

-- Q7. RevPAR (Portfolio Version) (Revenue Per Available Room)

SELECT 
	ROUND(
		(SUM(total_amount) / SUM(nights)) * 
        (COUNT(booking_id) / COUNT(DISTINCT DATE (check_in_date))), 2
    ) AS RevPAR
FROM hotel_bookings
WHERE booking_status = 'Checked-Out';

-- Q8 REVENUE BY HOTEL TYPE

SELECT	
	hotel_type,
    SUM(total_amount) AS Revenue
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'
GROUP BY hotel_type
ORDER BY Revenue desc;

-- Q9 REVENUE BY ROOM TYPE

SELECT 
	room_type,
    SUM(total_amount) AS Revenue
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'
GROUP BY room_type
ORDER BY Revenue desc;

-- Q10. CANCELLATION RATE

SELECT
    ROUND(
        SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) 
        / COUNT(booking_id) * 100,
    2) AS cancellation_rate_percent
FROM hotel_bookings;

-- Q11.HIGH DEMAND SEASONS (MONTHLY)
SELECT 
	DATE_FORMAT(check_in_date,'%m') AS month,
    COUNT(booking_id) AS bookings
FROM hotel_bookings
WHERE booking_status = 'Checked-Out'
GROUP BY month
ORDER BY bookings DESC;
    