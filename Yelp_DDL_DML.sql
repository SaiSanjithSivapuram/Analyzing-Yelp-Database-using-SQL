drop table if exists review;
drop table if exists users;
drop table if exists business;

CREATE TABLE business(
	business_id varchar(50) NOT NULL PRIMARY KEY,
	name varchar(300) NOT NULL,
  	address varchar(500),
  	city varchar(70) NOT NULL,
  	state varchar(4) NOT NULL,
  	postal_code varchar(20),
  	latitude double precision NOT NULL,
  	longitude double precision NOT NULL,
  	stars double precision NOT NULL,
  	review_count integer NOT NULL,
  	is_open integer NOT NULL,
  	categories varchar(1000)
);



CREATE TABLE users (
    user_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(100),
    review_count INTEGER,
    yelping_since TIMESTAMP,
    average_stars DECIMAL(2, 1)
);


CREATE TABLE review (
    review_id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    business_id VARCHAR(255),
    stars DECIMAL(2, 1),
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    date TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES business(business_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

COPY business FROM '/Users/sanjithsivapuram/Public/yelp_business.csv' WITH CSV HEADER DELIMITER ',' NULL '';
COPY users FROM '/Users/sanjithsivapuram/Public/yelp_user.csv' WITH CSV HEADER DELIMITER ',' NULL '';
COPY review FROM '/Users/sanjithsivapuram/Public/yelp_review.csv' WITH CSV HEADER DELIMITER ',' NULL '';