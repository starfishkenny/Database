select * from customer;
------------------------------------------------------------
select first_name,last_name from customer;
------------------------------------------------------------
select first_name,last_name from customer order by first_name asc;
------------------------------------------------------------
select first_name,last_name from customer order by last_name desc;
------------------------------------------------------------
select first_name,last_name from customer order by first_name asc,last_name desc;
------------------------------------------------------------
select first_name,last_name from customer order by 1 asc,2 desc;
------------------------------------------------------------
create table T1 (ID Serial not null primary key,Bcolor VARCHAR,FCOLOR VARCHAR);

insert into T1 (BCOLOR,FCOLOR) values 
	('red','red'),
	('red','red'),
	('red',),
	(,'red'),
	('red','green'),
	('red','blue'),
	('green','red'),
	('green','blue'),
	('green','green'),
	('blue','red'),
	('blue','green'),
	('blue','blue')
;
------------------------------------------------------------
select * from T1;
------------------------------------------------------------
select distinct BCOLOR from T1 order by BCOLOR;
------------------------------------------------------------
select distinct BCOLOR,FCOLOR from T1 order by BCOLOR,FCOLOR;
------------------------------------------------------------
select distinct on (BCOLOR) BCOLOR,FCOLOR from T1 order by BCOLOR,FCOLOR;
------------------------------------------------------------
select distinct on (BCOLOR) BCOLOR,FCOLOR from T1 order by BCOLOR,FCOLOR desc;
------------------------------------------------------------
select first_name,last_name from customer where first_name = 'Jamie';
------------------------------------------------------------
select first_name,last_name from customer where first_name = 'Jamie' and last_name = 'Rice';
------------------------------------------------------------
select customer_id,amount,payment_id from payment where amount <= 1 or amount >= 8;
------------------------------------------------------------
select film_id,title,release_year from film order by film_id limit 5;
------------------------------------------------------------
select film_id,title,release_year from film order by film_id limit 4 offset 3;
------------------------------------------------------------
select film_id,title,rental_rate from film order by rental_rate desc limit 10;
------------------------------------------------------------
select film_id,title from film order by title fetch first row only;
------------------------------------------------------------
select film_id,title from film order by title fetch first 1 row only;
------------------------------------------------------------
select film_id,title from film order by title offset 5 rows fetch first 5 row only;
------------------------------------------------------------
select customer_id,rental_id,return_date from rental where customer_id in (1,2) order by return_date desc;
------------------------------------------------------------
select customer_id,rental_id,return_date from rental where customer_id = 1 or customer_id = 2 order by return_date desc;
------------------------------------------------------------
select customer_id,rental_id,return_date from rental where customer_id not in (1,2) order by return_date desc;
------------------------------------------------------------
select customer_id,rental_id,return_date from rental where customer_id<>1 and customer_id<>2 order by return_date desc;
------------------------------------------------------------
select customer_id from rental where cast (return_date as date) = '2005-05-27';
------------------------------------------------------------
select first_name,last_name from customer where customer_id in (select customer_id from rental where cast (return_date as date) = '2005-05-27');