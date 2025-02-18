CREATE TABLE restaurants (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    price_range INT check(price_range >=1 and price_range <= 5)
);

INSERT INTO restaurants (name, location, price_range) values ('mcdonalds', 'new york' , 1);
INSERT INTO restaurants (name, location, price_range) values ('taco bell', 'Lincoln' , 2);
INSERT INTO restaurants (name, location, price_range) values ('taco bell', 'dallas' , 2);
INSERT INTO restaurants (name, location, price_range) values ('taco bell', 'houston' , 2);
INSERT INTO restaurants (name, location, price_range) values ('cheesecake factory', 'Cali' , 3);
INSERT INTO restaurants (name, location, price_range) values ('cheesecake factory', 'new york' ,4);
INSERT INTO restaurants (name, location, price_range) values ('cheesecake factory', 'Lincoln' , 3);
INSERT INTO restaurants (name, location, price_range) values ('wendys', 'new york' , 2);
INSERT INTO restaurants (name, location, price_range) values ('pizza kitchen', 'new york' , 3);

CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);
select *
from restaurants
    left join(
        select restaurant_id,
            count(*),
            TRUNC(AVG(rating, 1)) as average_rating
        from reviews
        group by restaurant_id
    ) reviews on restaurants.id = reviews.restaurant_id;
