-- ������ Ÿ��
-- boolean
create table STOCK_AVAILABILITY
(PRODUCT_ID int not null primary key,
AVAILABLE boolean not null);

insert into STOCK_AVAILABILITY (PRODUCT_ID, AVAILABLE)
values
(100, TRUE),
(200, FALSE),
(300, 't'),
(400, '1'),
(500, 'y'),
(600, 'yes'),
(700, 'no'),
(800, '0');

select * from STOCK_AVAILABILITY;
-----------------------------------------------------------
-- ���� ����
select * from STOCK_AVAILABILITY
	where AVAILABLE = 'YES';
	
select * from STOCK_AVAILABILITY
	where AVAILABLE;
-----------------------------------------------------------
select * from STOCK_AVAILABILITY 
	where AVAILABLE = 'NO';
	
select * from STOCK_AVAILABILITY
	where not AVAILABLE;
-----------------------------------------------------------
-- CHAR(����): ������ ����, ������ ������ �������� �е�
-- VARCHAR(����): ������ ����, ������ ������ �������� �е����� ����
-- TEXT: ���Ѵ� ������ ���ڿ��� ���� (= VARCHAR)
create table CHARACTER_TESTS
(ID serial primary key,
X CHAR(3),
Y VARCHAR(10),
Z TEXT);

insert into CHARACTER_TESTS
values
(1,'Y','YES','YESYESYES');

commit;

select * from CHARACTER_TESTS;
-----------------------------------------------------------
insert into CHARACTER_TESTS
values
(2,'Y','Y','YESYESYES');

commit;

select * from CHARACTER_TESTS where X=Y;
-----------------------------------------------------------
-- numeric: �������� �Ǽ��������� ���ڸ� ǥ���ϸ� ������ �ڸ����� ������ �� ����
create table PRODUCTS_
(ID serial primary key,
NAME varchar not null,
PRICE numeric (5,2));

insert into PRODUCTS_ (NAME, PRICE)
values
('Phone',500.215),
('Tablet',500.214);

commit;

select * from PRODUCTS;
-----------------------------------------------------------
-- integer
-- smallint: -32,768 ~ 32,767 (2byte)
-- integer: -2,147,483,648 ~ 2,147,483,647 (4byte)
-- bigint: -9,223,372,036,854,775,80 ~ 9,223,372,036,854,775,807 (8byte)
create table BOOKS_
(BOOK_ID serial primary key,
TITLE varchar(255) not null,
PAGES smallint not null check(PAGES > 0));

create table CITIES
(CITY_ID serial primary key,
CITY_NAME varchar(255) not null,
POPULATION int not null check(POPULATION >= 0));
-----------------------------------------------------------
-- serial: integer �������� ������ sequential�� ������ (���ϼ��� �����ϴ� PK�� ���� ���)
create table TABLE_NAME
(ID serial);

insert into TABLE_NAME
values(default);

commit;

select * from TABLE_NAME;

-- �������� �̿��� �÷� ����
create sequence TABLE_NAME_ID_SEQ_;

create table TABLE_NAME_
(ID int not null default
	nextval('TABLE_NAME_ID_SEQ'));
	
alter sequence TABLE_NAME_ID_SEQ owned by TABLE_NAME.ID;

insert into TABLE_NAME values(default);

commit;

select * from TABLE_NAME;
-----------------------------------------------------------
create table FRUITS
(ID serial primary key,
NAME varchar not null);

insert into FRUITS(NAME) values ('orange'); -- IDĮ�� �ڵ����� 1�� ��

insert into FRUITS(ID,NAME) values(default,'apple'); -- IDĮ�� �ڵ����� 2�� ��

select * from FRUITS;
-----------------------------------------------------------
select currval(PG_GET_SERIAL_SEQUENCE('fruits','id')); -- ������ �� ���ϱ�
-----------------------------------------------------------
-- DATE(����)
select NOW()::date; -- �����ͺ��̽� ���� ���� ���� ��������
select current_date; -- �����ͺ��̽� ���� ���� ���� ��������
select to_char(now()::date,'dd/mm/yyyy'); -- to_char�� �̿��Ͽ� �ٸ� ������ �������� ��������
select to_char(now()::date,'Mon dd,yyyy');
-----------------------------------------------------------
-- �پ��� ���� ���
select
	FIRST_NAME,LAST_NAME,now()-create_date as diff from CUSTOMER;

select
	FIRST_NAME,LAST_NAME,age(create_date) as diff from CUSTOMER;

-- �پ��� ���� ����
select
	FIRST_NAME,LAST_NAME,
	extract(year from create_date) as YEAR,
	extract(month from create_date) as MONTH,
	extract(day from create_date) as DAY 
from CUSTOMER;
-----------------------------------------------------------
-- TIME(�ð�)
select current_time; -- �����ͺ��̽� ���� ���� �ð��� ��������
select localtime;

select 
	localtime,
	extract(hour from localtime) as HOUR,
	extract(minute from localtime) as MINUTE,
	extract(second from localtime) as SECOND;

-- �ð����
select time '10:00' - time '02:00' as diff;
select time '10:59' - time '02:01' as diff;
select time '10:59:59' - time '02:01:01' as diff;

select 
	localtime,
	localtime + interval '2 HOURS' as PLUS_2HOURS,
	localtime - interval '2 HOURS' as MINUS_2HOURS;
-----------------------------------------------------------
-- TIMESTAMP(���� �� �ð�)
select now(); -- �����ͺ��̽� ���� ���� ���� �� �ð��� ��������
select current_timestamp;
select timeofday(); -- �����ͺ��̽� ���� ���� ���� �� �ð��� ���ϱ��� ��������

-- �پ��� ������ �ð� ������ ���ڿ��� ���
select
	to_char(current_timestamp, 'YYYY'),
	to_char(current_timestamp, 'YYYY-MM'),
	to_char(current_timestamp, 'YYYY-MM-DD'),
	to_char(current_timestamp, 'YYYY-MM-DD HH24'),
	to_char(current_timestamp, 'YYYY-MM-DD HH24:MI'),
	to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
	to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS.MS'),
	to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS.MS.US');