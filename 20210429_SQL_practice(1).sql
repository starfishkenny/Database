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
select customer_id,amount,payment_id from customer where amount <= 1 or amount >= 8;
