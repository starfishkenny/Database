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
------------------------------------------------------------
select customer_id,payment_id,amount from payment where amount between 8 and 9;
------------------------------------------------------------
select customer_id,payment_id,amount from payment where amount not between 8 and 9;
------------------------------------------------------------
select customer_id,payment_id,amount,payment_date from payment where cast(payment_date as date) between '2007-02-07'and '2007-02-15';
------------------------------------------------------------
select first_name,last_name from customer where first_name like 'Jen%';
------------------------------------------------------------
select first_name,last_name from customer where first_name like '%er%';
------------------------------------------------------------
select first_name,last_name from customer where first_name like '_her%';
------------------------------------------------------------
select first_name,last_name from customer where first_name not like 'jen%';
------------------------------------------------------------
create table contacts
(id int generated by default as identity,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(255) not null,
phone varchar(15),
primary key(id)
);
------------------------------------------------------------
insert into contacts(first_name,last_name,email,phone) 
values('Jonh','Doe','john.doe@example.com',null),
('Lily','Bush','lily.bush@example.com','(408-234-2764)');
------------------------------------------------------------
select * from contacts;
------------------------------------------------------------
select id,first_name,last_name,email,phone from contacts where phone=null;
------------------------------------------------------------
select id,first_name,last_name,email,phone from contacts where phone is null;
------------------------------------------------------------
select id,first_name,last_name,email,phone from contacts where phone is not null;
------------------------------------------------------------
select amount from payment order by amount desc limit 1;
------------------------------------------------------------
select distinct a.customer_id from payment a where a.amount = 
			(select a.amount from payment a order by a.amount
			desc limit 1);
------------------------------------------------------------
select email from customer where email not like '@%'
and email not like '%@'
and email like '%@%';