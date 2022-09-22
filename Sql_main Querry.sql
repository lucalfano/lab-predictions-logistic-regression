use sakila;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select title, rental_duration, rental_rate, length, replacement_cost, rating, category, rented_may
from(
select film_id,
case
when month(rental_date) = 5 then True
else False
end as rented_may
from rental
join inventory using(inventory_id)
join film using(film_id)
join film_category using(film_id)
join category using (category_id)
where year(rental_date) = 2005 and month(rental_date) = 5
group by film_id) t1
right join(
select rental_date, title, film_id, rental_duration, rental_rate, length, replacement_cost, rating, category.name as category
from rental
join inventory using(inventory_id)
join film using(film_id)
join film_category using(film_id)
join category using (category_id)
where year(rental_date) = 2005
group by film_id
) t2
using (film_id);