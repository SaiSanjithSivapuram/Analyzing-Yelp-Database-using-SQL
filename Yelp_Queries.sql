-- EDA For Businesses
-- Retrieve all the businesses data
select * from business;

-- Businesses per state
select state, count(business_id) as business_per_state 
from business
group by state
order by business_per_state desc;

-- Businesses per state and city
select state, city, count(business_id) as business_per_state_city 
from business
group by state, city
order by state, city, business_per_state_city desc;

-- Total Business for each business
select name, count(business_id) as total_business
from business
group by name
order by total_business desc;

-- Relation between Businesses and Stars
select stars, count(business_id) as total_business
from business
group by stars
order by stars desc;

-- All different rating for each businesses
select name, stars, count(business_id) as total_business
from business
group by name, stars
order by name, stars desc;

-- Business Categories and Ratings
SELECT categories, AVG(stars) AS average_rating, COUNT(business_id) AS number_of_businesses
FROM business
GROUP BY categories
ORDER BY average_rating DESC, number_of_businesses DESC;

-- EDA for Reviews
-- Retrieve all the reviews data
select * from review;

-- Trend in Average Review Over Time
SELECT DATE_TRUNC('year', r.date) AS year, AVG(r.stars) AS average_rating
FROM review r
GROUP BY year
ORDER BY year;

-- Reviews over time
SELECT b.business_id, b.name, DATE_TRUNC('year', r.date) AS year, COUNT(r.review_id) AS total_reviews
FROM business b
JOIN review r ON b.business_id = r.business_id
GROUP BY b.business_id, b.name, year
ORDER BY b.business_id, year;

-- Correlation between business and reviews
SELECT b.business_id, b.name, AVG(r.stars) AS average_rating, COUNT(r.review_id) AS review_count
FROM business b
JOIN review r ON b.business_id = r.business_id
GROUP BY b.business_id, b.name
ORDER BY review_count DESC, average_rating DESC;

-- Top Businesses in terms of reviews and rating
SELECT b.business_id, b.name, AVG(r.stars) AS average_rating, COUNT(r.review_id) AS review_count
FROM business b
JOIN review r ON b.business_id = r.business_id
WHERE b.stars >= 4
GROUP BY b.business_id, b.name
ORDER BY review_count DESC, average_rating DESC
LIMIT 10;

-- EDA for Users
-- Retrieve all the users data
select * from users;

-- Retreiving number of users over time
SELECT DATE_TRUNC('year', u.yelping_since) AS year, COUNT(u.user_id) AS number_of_users
FROM users u
GROUP BY year
ORDER BY year;