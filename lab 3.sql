##Write the query for the view rental_duration
You need to prepare the underlying query for the view called rental_duration. In order to do this, you will need to create a query that uses the rental table and displays the following columns:

customer_id and

avg_rental_duration

In avg_rental_duration you will need to calculate the average date difference (the length of time between two dates in days) between the return_date and rental_date.

Make sure to group the results by customer_id.


SELECT customer_id,
        AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental
GROUP BY customer_id;

**Create the view rental_duration from the prepared query
Create a view called rental_duration from the prepared query. This view displays the average rental duration for each customer.

This view will contain the following two columns:

customer_id and

avg_rental_duration.

create view rental_duration as
SELECT customer_id,
AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental
GROUP BY customer_id;


**Write the query for the view total_dvds
Prepare the query for the view called total_dvds. This view will show us how many DVDs each customer has rented.

In order to do this, you will need to count or sum the inventory_id field in the rental table.
You will also need to join three different tables: customer, address, and rental.

The column names for this view should be customer_id, district, and total_dvds_rented. Group the information by customer and district so that it can be tracked for how many DVDs each customer has rented. 

This means that in the end, you will have a query with the following three output columns:

customer_id,

district, and

total_dvds_rented.

SELECT 
c.customer_id, 
a.district, 
COUNT(r.inventory_id) total_dvds_rented
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id
INNER JOIN address a ON c.address_id = a.address_id
GROUP BY c.customer_id, a.district;

**Create the view total_dvds from the prepared query
Create a view called total_dvds from the prepared query. This view displays the average rental duration for each customer.

This means that in the end, you will have a view with the following three output columns:

customer_id,

district, and

total_dvds_rented.

CREATE view total_dvds as 
SELECT c.customer_id,
       a.district,
       SUM(inventory_id) AS total_dvds_rented
FROM rental r 
INNER JOIN customer c ON r.customer_id = c.customer_id
INNER JOIN address a ON c.address_id = a.address_id
GROUP BY c.customer_id, a.district;


***Prepare the query for the view called valuation_report
Prepare the query for the view called valuation_report. In order to do this, you will need to use the two views rental_duration and valuation_report, as well as the two tables customer and address. Make sure to properly join these tables and views and reference their names in the joins.

This view will show the district, total count of unique customer IDs that rented DVDs in each district, total DVDs rented, and average rental duration in each district.

The column names for this view should be district, total_customers, total_dvds_rented, and avg_rental_duration. Group the results by district.

This means that in the end, you will have a query with the following three output columns:

district,

total_customers,

total_dvds_rented, and

avg_rental_duration.


SELECT 
a.district, 
COUNT(DISTINCT c.customer_id) AS total_customers, 
SUM(t.total_dvds_rented) AS total_dvds_rented, 
AVG(r.avg_rental_duration) AS avg_rental_duration
FROM rental_duration r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN total_dvds t ON c.customer_id = t.customer_id
GROUP BY a.district;

**Create the view valuation_report from the prepared query
Create a view called valuation_report from the prepared query. 

This view will show the district, total count of unique customer IDs that rented DVDs in each district, total DVDs rented, and average rental duration in each district.

The column names for this view should be district, total_customers, total_dvds_rented, and avg_rental_duration. Group the results by district.

This means that in the end, you will have a view with the following three output columns:

district,

total_customers,

total_dvds_rented, and

avg_rental_duration.



create view valuation_report as
SELECT a.district, 
COUNT(DISTINCT c.customer_id) AS total_customers, 
SUM(t.total_dvds_rented) AS total_dvds_rented, 
AVG(r.avg_rental_duration) AS avg_rental_duration
FROM rental_duration r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN total_dvds t ON c.customer_id = t.customer_id
GROUP BY a.district;


select * from valuation_report;

