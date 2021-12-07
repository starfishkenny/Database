-- 실습준비
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
---------------------------------------------
select 
	a.id as id_a,
	a.fruit as fruit_a,
	b.id as id_b,
	b.fruit as fruit_b
 from basket_a a 
left join basket_b b 
 on a.fruit = b.fruit;
---------------------------------------------
-- left only
select
	a.id as id_a,
	a.fruit as fruit_a,
	b.id as id_b,
	b.fruit as fruit_b
 from basket_a a 
left join basket_b b 
 on a.fruit = b.fruit 
where b.id is null;
---------------------------------------------
select 
	a.id as id_a,
	a.fruit as friut_a,
	b.id as id_b,
	b.fruit as fruit_b
 from basket_a a
right join basket_b b
 on a.fruit = b.fruit;
 ---------------------------------------------
-- right only
select
	a.id as id_a,
	a.fruit as fruit_a,
	b.id as id_b,
	b.fruit as fruit_b
 from basket_a a 
right join basket_b b
 on a.fruit = b.fruit 
where a.id is null;
---------------------------------------------
-- 실습준비
create table employee
(employee_id int primary key,
first_name varchar(255)not null,
last_name varchar(255) not null,
manager_id int,
foreign key(manager_id) references employee(employee_id) on delete cascade)
;
---------------------------------------------
insert into employee(
employee_id,
first_name,
last_name,
manager_id)
values
(1, 'Windy', 'Hays', null),
(2, 'Ava', 'Christensen', 1),
(3, 'Hassan', 'Conner', 1),
(4, 'Anna', 'Reeves', 2),
(5, 'Sau', 'Norman', 2),
(6, 'Kelsie', 'Hays', 3),
(7, 'Tory', 'Goff', 3),
(8, 'Salley', 'Lester', 3);
---------------------------------------------
select * from employee;
---------------------------------------------
-- 실습
select 
 e.first_name ||' '|| e.last_name employee,
 m.first_name ||' '|| m.last_name manager
from employee e
inner join employee m 
on m.employee_id = e.manager_id
order by manager;
---------------------------------------------
select 
 e.first_name ||' '|| e.last_name employee,
 m.first_name ||' '|| e.last_name manager
from employee e 
left outer join employee m 
on m.employee_id = e.manager_id
order by manager;
---------------------------------------------
-- 부정형 조건
select 
 f1.title,
 f2.title,
 f1.length
 from film f1
inner join film f2
on f1.film_id <> f2.film_id
and f1.length = f2.length;
---------------------------------------------
select 
	a.id id_a,
	a.fruit fruit_a,
	b.id id_b,
	b.fruit fruit_b
from basket_a a 
full outer join basket_b b
 on a.fruit = b.fruit;
 ---------------------------------------------
select 
	a.id id_a,
	a.fruit fruit_a,
	b.id id_b,
	b.fruit fruit_b
from basket_a a 
full outer join basket_b b 
on a.fruit = b.fruit
where a.id is null or b.id is null;
---------------------------------------------
-- 추가실습준비
create table
if not exists departments
(department_id serial primary key,
department_name varchar(255) not null);
---------------------------------------------
create table
if not exists employees
(employee_id serial primary key,
employee_name varchar(255),
department_id integer);
---------------------------------------------
insert into departments
(department_name)
values
('Sales'),('Marketing'),('HR'),('IT'),('Production');
---------------------------------------------
insert into employees 
(employee_name,department_id)
values
('Bette Nicholson',1),
('Christian Gable',1),
('Joe Swank',2),
('Fred Costner',3),
('Sandra Kilmer',4),
('Juia Mcqueen',null);
---------------------------------------------
select * from departments;
---------------------------------------------
select * from employees;
---------------------------------------------
-- full outer join
select
	e.employee_name,
	d.department_name
from employees e 
full outer join departments d 
 on d.department_id = e.department_id;
---------------------------------------------
select 
	e.employee_name,
	d.department_name
from employees e 
full outer join departments d 
 on d.department_id = e.department_id
where e.employee_name is null;
---------------------------------------------
select 
	e.employee_name,
	d.department_name
from employees e 
full outer join departments d 
 on d.department_id = e.department_id
where d.department_id is null;
---------------------------------------------
-- cross join
create table cross_T1
(label_ char(1) primary key);
---------------------------------------------
create table cross_T2
(score int primary key);
---------------------------------------------
insert into cross_T1(label_)
values
('A'),
('B');
---------------------------------------------
insert into cross_T2(score)
values
(1),
(2),
(3);
---------------------------------------------
select * from cross_T1;
---------------------------------------------
select * from cross_T2;
---------------------------------------------
select * from cross_T1 cross join cross_T2;
---------------------------------------------
-- natural join 
create table categories
(category_id serial primary key,
category_name varchar(255) not null);
---------------------------------------------
create table products
(product_id serial primary key,
product_name varchar(255) not null,
category_id int not null,
foreign key(category_id) references categories(category_id));
---------------------------------------------
insert into categories 
(category_name)
values
('Smart Phone'),
('Laptop'),
('Tablet');
---------------------------------------------
insert into products
(product_name, category_id)
values
('iPhone',1),
('Samsung Galaxy',1),
('HP Elite',2),
('Lenovo Thinkpad',2),
('iPad',3),
('Kindle Fire',3);
---------------------------------------------
select * from categories;
---------------------------------------------
select * from products;
---------------------------------------------
select * from products a natural join categories b;
---------------------------------------------
select
	a.category_id, a.product_id,
	a.product_name, b.category_name
 from products a
inner join categories b 
on (a.category_id = b.category_id);
---------------------------------------------
-- group by
select customer_id from payment group by customer_id;
---------------------------------------------
select customer_id,sum(amount) as amount_sum from payment
	group by customer_id
	order by sum(amount) desc;
---------------------------------------------
select customer_id,sum(amount) as amount_sum from payment
	group by customer_id
	order by amount_sum desc;
---------------------------------------------
select customer_id,sum(amount) as amount_sum from payment
	group by customer_id
	order by 2 desc;
---------------------------------------------
select staff_id,count(payment_id) as count from payment
	group by staff_id;
---------------------------------------------
-- having
select customer_id,sum(amount) as amount_sum from payment
	group by customer_id
	having sum(amount) > 200;
---------------------------------------------
select store_id,count(customer_id) as count from customer
	group by store_id
	having count(customer_id) > 300;
---------------------------------------------
-- grouping set
create table sales
(brand varchar not null,
segment varchar not null,
quantity int not null,
primary key (brand,segment));

insert into sales (brand,segment,quantity)
values
('ABC','Premium',100),
('ABC','Basic',200),
('XYZ','Premium',100),
('XYZ','Basic',300);
---------------------------------------------
select * from sales;
---------------------------------------------
select brand,segment,sum(quantity) from sales
group by brand,segment;
---------------------------------------------
select brand,sum(quantity) from sales group by brand;
---------------------------------------------
select segment,sum(quantity) from sales group by segment;
---------------------------------------------
select sum(quantity) from sales;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by brand,segment
	union all
	select brand,null,sum(quantity)
	from sales
	group by brand
	union all
	select null,segment,sum(quantity)
	from sales
	group by segment
	union all
	select null,null,sum(quantity)
	from sales;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by
	grouping sets((brand,segment),(brand),());
---------------------------------------------
select grouping(brand) grouping_brand,grouping(segment) grouping_segment,
	brand,segment,sum(quantity)
	from sales
	group by
	grouping sets
	((brand,segment),
	(brand),
	(segment),
	())
	order by brand,segment;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by
		rollup (brand,segment)
	order by brand,segment;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by segment,
		rollup (brand)
	order by segment,brand;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by
		cube (brand,segment)
	order by brand,segment;
---------------------------------------------
select brand,segment,sum(quantity) from sales
	group by brand,
		cube (segment)
	order by brand,segment;
---------------------------------------------
-- 분석함수
create table product_group
	(group_id serial primary key,
	group_name varchar(255) not null);
---------------------------------------------
insert into product_group(group_name)
values
('Smartphone'),
('Laptop'),
('Tablet');
---------------------------------------------
create table product
	(product_id serial primary key,
	product_name varchar(255) not null,
	price decimal(11,2),
	group_id int not null,
	foreign key (group_id) references product_group(group_id));
---------------------------------------------
insert into product(product_name,group_id,price)
values
('Microsoft Lumia',1,200),
('HTC One',1,400),
('Nexus',1,500),
('iPhone',1,900),
('HP Elite',2,1200),
('Lenovo Thinkpad',2,700),
('Sony VAIO',2,700),
('Dell Vostro',2,800),
('iPad',3,700),
('Kindle Fire',3,150),
('Samsung Galaxy Tab',3,200);
---------------------------------------------
select * from product_group;
---------------------------------------------
select * from product;
---------------------------------------------
-- count
select count(*) from product;
---------------------------------------------
select count(*) over(), A.* from product A;
---------------------------------------------
-- avg
select avg(price) from product;
---------------------------------------------
select B.group_name,avg(price) from product A
inner join product_group B
	on (A.group_id = B.group_id)
group by B.group_name;
---------------------------------------------
select A.product_name,A.price,B.group_name,avg(A.price)
	over (partition by B.group_name)
from product A
inner join product_group B on (A.group_id = B.group_id);
---------------------------------------------
-- row_number (무조건 1,2,3,4,5,..)
select A.product_name,B.group_name,A.price,
	row_number () over (partition by B.group_name order by A.price)
from product A
inner join product_group B
	on (A.group_id = B.group_id);
---------------------------------------------
-- rank (같은 순위면 같은 순위면서 다음 순위 건너뜀 1,1,3,4,...)
select A.product_name,B.group_name,A.price,
	rank () over (partition by B.group_name order by A.price)
from product A
inner join product_group B
	on (A.group_id = B.group_id);
---------------------------------------------
-- dense_rank (같은 순위며 같은 순위면서 다음 순위 건너뛰지 않음 1,1,2,3,...)
select A.product_name,B.group_name,A.price,
	dense_rank () over (partition by B.group_name order by A.price)
from product A
inner join product_group B
	on (A.group_id = B.group_id);
---------------------------------------------
-- first_value, last_value
select A.product_name,B.group_name,A.price,
	first_value(A.price) over (partition by b.group_name order by a.price)
	as lowest_price_per_group
from product A
inner join product_group B on (A.group_id = B.group_id);
---------------------------------------------
select A.product_name,B.group_name,A.price,
	last_value(A.price) over (partition by B.group_name order by A.price
	range between unbounded preceding and unbounded following) -- 파티션 첫번째 로우부터 파티션 마지막 로우까지
	as highest_price_per_group
from product A
inner join product_group B on (A.group_id = B.group_id);
---------------------------------------------
-- lag, lead
select A.product_name,B.group_name,A.price,
	lag(A.price,1) over (partition by B.group_name order by A.price) as prev_price,
	A.price - lag(price,1) over (partition by group_name order by A.price) as cur_prev_diff
from product A
inner join product_group B on (A.group_id = B.group_id);
---------------------------------------------
select A.product_name,B.group_name,A.price,
	lead(A.price,1) over (partition by B.group_name order by A.price) as next_price,
	A.price - lead(price,1) over (partition by group_name order by A.price) as cur_next_diff
from product A
inner join product_group B on (A.group_id = B.group_id);
---------------------------------------------
-- 실습문제1
select to_char(rental_date,'YYYY') Y,
	to_char(rental_date,'MM') M,
	to_char(rental_date,'DD') D,
	count(rental_id)
from rental
group by rollup 
	(to_char(rental_date,'YYYY'),
	to_char(rental_date,'MM'),
	to_char(rental_date,'DD'));
---------------------------------------------
-- 실습문제2
select A.customer_id,
	row_number() over (order by count(A.rental_id) desc) as rental_rank,
	count(A.rental_id) rental_count
from rental A
group by A.customer_id;
---------------------------------------------
select A.customer_id,
	row_number() over(order by count(A.rental_id) desc) as rental_rank,
	count(A.rental_id) rental_count
from rental A
group by A.customer_id order by rental_rank limit 1;
---------------------------------------------
select A.customer_id,
	row_number() over(order by count(A.rental_id) desc) as rental_rank,
	count(A.rental_id) rental_count,
	max(B.first_name) as first_name,
	max(B.last_name) as last_name
from rental A, customer B
	where A.customer_id = B.customer_id
group by A.customer_id order by rental_rank limit 1;