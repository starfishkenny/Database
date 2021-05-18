-- union
create table SALES2007_1
	(NAME_ varchar(50),
	AMOUNT numeric(15,2));
-----------------------------------------------------
insert into SALES2007_1
values
	('Mike',150000.25),
	('Jon',132000.75),
	('Mary',100000);
-----------------------------------------------------
create table SALES2007_2
	(NAME_ varchar(50),
	AMOUNT numeric(15,2));
-----------------------------------------------------
insert into SALES2007_2
values
	('Mike',120000.75),
	('Jon',142000.75),
	('Mary',100000);
-----------------------------------------------------
select * from SALES2007_1;
-----------------------------------------------------
select * from SALES2007_2;
-----------------------------------------------------
select * from SALES2007_1
union
select * from SALES2007_2;
-----------------------------------------------------
select NAME_ from SALES2007_1
union
select NAME_ from SALES2007_2;
-----------------------------------------------------
select AMOUNT from SALES2007_1
union
select AMOUNT from SALES2007_2;
-----------------------------------------------------
select * from SALES2007_1
union
select * from SALES2007_2
order by AMOUNT desc;
-----------------------------------------------------
-- union all (�ߺ��� �����͵� ��� ���)
select NAME_ from SALES2007_1
union all
select NAME_ from SALES2007_2;
-----------------------------------------------------
select NAME_ from SALES2007_1
union all
select NAME_ from SALES2007_2;
-----------------------------------------------------
-- intersect
create table EMPLOYEES_
(EMPLOYEE_ID SERIAL PRIMARY KEY
, EMPLOYEE_NAME VARCHAR (255) NOT NULL);
-----------------------------------------------------
insert into employees_ (employee_id, EMPLOYEE_NAME)
values
	(1,'Joyce Edwards'),
	(2,'Diane Collins'),
	(3,'Alice Stewart'),
	(4,'Julie Sanchez'),
	(5,'Heather Morris'),
	(6,'Teresa Rogers'),
	(7,'Doris Reed'),
	(8,'Gloria Cook'),
	(9,'Evelyn Morgan'),
	(10,'Jean Bell');
-----------------------------------------------------
select * from employees_;
-----------------------------------------------------
create table KEYS
(EMPLOYEE_ID INT PRIMARY KEY,
EFFECTIVE_DATE DATE NOT NULL,
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES EMPLOYEES_ (EMPLOYEE_ID));
-----------------------------------------------------
insert into keys
values
	(1,'2000-02-01'),
	(2,'2001-06-01'),
	(5,'2002-01-01'),
	(7,'2005-06-01');
-----------------------------------------------------
select * from keys;
-----------------------------------------------------
CREATE TABLE HIPOS
(EMPLOYEE_ID INT PRIMARY KEY,
EFFECTIVE_DATE DATE NOT NULL,
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES EMPLOYEES_ (EMPLOYEE_ID));
-----------------------------------------------------
insert into hipos
values
	(9,'2000-01-01'),
	(2,'2002-06-01'),
	(5,'2006-06-01'),
	(10,'2005-06-01');
-----------------------------------------------------
select EMPLOYEE_ID from KEYS
intersect
select EMPLOYEE_ID from HIPOS;
-----------------------------------------------------
select A.EMPLOYEE_ID from KEYS A, HIPOS B where A.EMPLOYEE_ID = B.EMPLOYEE_ID;
-----------------------------------------------------
select EMPLOYEE_ID from KEYS
intersect
select EMPLOYEE_ID from HIPOS
order by EMPLOYEE_ID desc;
-----------------------------------------------------
-- except
-- ��� �ִ� ��ȭ ����
select distinct INVENTORY.FILM_ID, TITLE from INVENTORY
inner join FILM
	on FILM.FILM_ID = INVENTORY.FILM_ID
order by TITLE;
-----------------------------------------------------
-- ��� ���� ��ȭ ���� (except)
select FILM_ID,TITLE from FILM
except
select distinct INVENTORY.FILM_ID,TITLE from INVENTORY
inner join FILM
	on FILM.FILM_ID = INVENTORY.FILM_ID
order by TITLE;
-----------------------------------------------------
-- ��������
select avg(RENTAL_RATE) from FILM;
select FILM_ID,TITLE,RENTAL_RATE from FILM where RENTAL_RATE > 2.98; -- �ѹ��� ó���ϴ� ��� => ��������
-----------------------------------------------------
-- ��ø �������� Ȱ��
select FILM_ID,TITLE,RENTAL_RATE from FILM
	where RENTAL_RATE >
		(select avg(RENTAL_RATE) from FILM);
-----------------------------------------------------
-- �ζ��� �� Ȱ��
select A.FILM_ID,A.TITLE,A.RENTAL_RATE from FILM A,
	(select avg(RENTAL_RATE) as AVG_RENTAL_RATE from FILM) B
	where A.RENTAL_RATE > B.AVG_RENTAL_RATE;
-----------------------------------------------------
-- ��Į�� �������� Ȱ��
select A.FILM_ID,A.TITLE,A.RENTAL_RATE from
	(select A.FILM_ID,A.TITLE,A.RENTAL_RATE,
		(select avg(L.RENTAL_RATE) from FILM L)
	as AVG_RENTAL_RATE from FILM A) A
	where A.RENTAL_RATE > A.AVG_RENTAL_RATE;
-----------------------------------------------------
-- any (���� ���������� ���� ��ȯ�� �� ���հ� ��)
select TITLE,LENGTH from FILM
	where LENGTH >= any -- ��ȭ�з��� �󿵽ð��� ���� �� ��ȭ�� ���� �� �󿵽ð��� ����
	(select max(LENGTH) from FILM A, FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID); -- ��ȭ �з��� �󿵽ð��� ���� �� �󿵽ð��� ����
-----------------------------------------------------
select TITLE,LENGTH from FILM
	where LENGTH = any -- ��ȭ�з��� �󿵽ð��� ���� �� �󿵽ð��� ������ �󿵽ð��� ���� ��ȭ ���� ���
	(select max(LENGTH) from FILM A,FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID); -- ��ȭ �з��� �󿵽ð��� ���� �� �󿵽ð��� ����
-----------------------------------------------------
-- = any �� in�� ����
select TITLE,LENGTH from FILM
	where LENGTH in
	(select max(LENGTH) from FILM A,FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID);