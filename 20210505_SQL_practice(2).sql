create table basket_a
(id int primary key,
fruit varchar (100) not null);
---------------------------------------------
create table basket_b
(id int primary key,
fruit varchar(100) not null);
---------------------------------------------
insert into basket_a
(id, fruit)
values
(1, 'apple'),
(2, 'orange'),
(3, 'banana'),
(4, 'cucumber');
commit;
---------------------------------------------
insert into basket_b
(id, fruit)
values
(1, 'orange'),
(2, 'apple'),
(3, 'watermelon'),
(4, 'pear');
commit;
---------------------------------------------
select * from basket_a;
---------------------------------------------
select * from basket_b;
---------------------------------------------
select
	a.id id_a,
	a.fruit fruit_a,
	b.id id_b,
	b.fruit fruit_b
 from basket_a a
inner join basket_b b 
 on a.fruit = b.fruit;
---------------------------------------------
-- ½Ç½À
select 
	a.customer_id,a.first_name,a.last_name,a.email,
	b.amount,b.payment_date
 from customer a 
inner join payment b 
 on a.customer_id = b.customer_id;
---------------------------------------------
select 
	a.customer_id,a.first_name,a.last_name,a.email,
	b.amount,b.payment_date
 from customer a 
inner join payment b 
on a.customer_id = b.customer_id 
where a.customer_id = 2;
---------------------------------------------
select 
	a.customer_id,a.first_name,a.last_name,a.email,
	b.amount,b.payment_date,
	c.first_name as s_first_name,
	c.last_name as s_last_name
 from customer a 
inner join payment b 
on a.customer_id = b.customer_id 
inner join staff c 
on b.staff_id = c.staff_id; 