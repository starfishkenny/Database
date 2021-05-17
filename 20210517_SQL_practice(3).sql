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