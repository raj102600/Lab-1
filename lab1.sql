#Create a view to return the difference between return date and rental date for each movie rental
#Write a CREATE VIEW statement that returns the number of days between return_date and rental_date from the rental table. This view should also include the rental_id and customer_id columns so that you can join it with the rental table and with the customer table. Consider that rentals that have not been returned have a null value in return_date, so in these cases you should calculate the difference between the rental_date and the current_date.


CREATE VIEW rental_days_view AS 
SELECT rental_id, customer_id, 
datediff(rental_date, COALESCE(return_date, current_date)) AS 
rental_days FROM rental;

##Create a view to obtain the average movie return time of each customer
##Write a CREATE VIEW statement that returns an average of the rental return times of each customer for the last four years. This view should select records from the rental_return_times and return customer_id and the average of rental_days, taking only the data since 2005.##

CREATE VIEW average_movie_return_time AS
SELECT customer_id, AVG(rental_date) AS average_movie_return_time
FROM rental
WHERE rental_date >= '2005-01-01'
group by customer_id;


***Create the query that feeds customer dashboard
Write a SELECT statement that joins the customer table with the customer_avg_return_times view, and adds a column with a CASE statement to return the customer category according to their average return times.

The category is distinguishing between those that return the movies on average:

within a week after rental (assign the value "GOOD"),

within 30 days (assign the value "FAIR"),

and those that take more than 30 days (assign the value "BAD").

This is the query that is used to feed the dashboard ***


SELECT
  *,
  CASE
    WHEN average_movie_return_time < 7 THEN "GOOD"
    WHEN average_movie_return_time < 30 THEN "FAIR"
    ELSE "BAD"
  END AS customer_category
FROM customer
JOIN average_movie_return_time ON customer.customer_id = average_movie_return_time_.customer_id;


***Create a view from the query that feeds the customer dashboard
Write a CREATE VIEW statement that saves the query that feeds the customer dashboard. Use the alias customer_dashboard for this view and check if the view works by querying it.



CREATE VIEW customer_dashboard AS
SELECT
 c.*,
  CASE
    WHEN average_movie_return_time < 7 THEN "GOOD"
    WHEN average_movie_return_time < 30 THEN "FAIR"
    ELSE "BAD"
  END AS customer_category
FROM customer as c
JOIN average_movie_return_time on c.customer_id = average_movie_return_time.customer_id;