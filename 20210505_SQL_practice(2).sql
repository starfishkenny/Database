-- �ǽ��غ�
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
-- �ǽ��غ�
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
-- �ǽ�
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
-- ������ ����
select 
 f1.title,
 f2.title,
 f1.length
 from film f1
inner join film f2
on f1.film_id <> f2.film_id
and f1.length = f2.length;