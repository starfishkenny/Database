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
-- union all (중복된 데이터도 모두 출력)
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
-- 재고가 있는 영화 추출
select distinct INVENTORY.FILM_ID, TITLE from INVENTORY
inner join FILM
	on FILM.FILM_ID = INVENTORY.FILM_ID
order by TITLE;
-----------------------------------------------------
-- 재고가 없는 영화 추출 (except)
select FILM_ID,TITLE from FILM
except
select distinct INVENTORY.FILM_ID,TITLE from INVENTORY
inner join FILM
	on FILM.FILM_ID = INVENTORY.FILM_ID
order by TITLE;
-----------------------------------------------------
-- 서브쿼리
select avg(RENTAL_RATE) from FILM;
select FILM_ID,TITLE,RENTAL_RATE from FILM where RENTAL_RATE > 2.98; -- 한번에 처리하는 방법 => 서브쿼리
-----------------------------------------------------
-- 중첩 서브쿼리 활용
select FILM_ID,TITLE,RENTAL_RATE from FILM
	where RENTAL_RATE >
		(select avg(RENTAL_RATE) from FILM);
-----------------------------------------------------
-- 인라인 뷰 활용
select A.FILM_ID,A.TITLE,A.RENTAL_RATE from FILM A,
	(select avg(RENTAL_RATE) as AVG_RENTAL_RATE from FILM) B
	where A.RENTAL_RATE > B.AVG_RENTAL_RATE;
-----------------------------------------------------
-- 스칼라 서브쿼리 활용
select A.FILM_ID,A.TITLE,A.RENTAL_RATE from
	(select A.FILM_ID,A.TITLE,A.RENTAL_RATE,
		(select avg(L.RENTAL_RATE) from FILM L)
	as AVG_RENTAL_RATE from FILM A) A
	where A.RENTAL_RATE > A.AVG_RENTAL_RATE;
-----------------------------------------------------
-- any (값을 서브쿼리에 의해 반환된 값 집합과 비교)
select TITLE,LENGTH from FILM
	where LENGTH >= any -- 영화분류별 상영시간이 가장 긴 영화의 제목 및 상영시간을 구함
	(select max(LENGTH) from FILM A, FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID); -- 영화 분류별 상영시간이 가장 긴 상영시간을 구함
-----------------------------------------------------
select TITLE,LENGTH from FILM
	where LENGTH = any -- 영화분류별 상영시간이 가장 긴 상영시간과 동일한 상영시간을 갖는 영화 제목 출력
	(select max(LENGTH) from FILM A,FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID); -- 영화 분류별 상영시간이 가장 긴 상영시간을 구함
-----------------------------------------------------
-- = any 는 in과 동일
select TITLE,LENGTH from FILM
	where LENGTH in
	(select max(LENGTH) from FILM A,FILM_CATEGORY B
		where A.FILM_ID = B.FILM_ID
		group by B.CATEGORY_ID);