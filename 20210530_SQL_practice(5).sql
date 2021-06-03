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
-----------------------------------------------------------
-- �⺻Ű (not null, unique)
create table TB_PRODUCT_PK_TEST
(PRODUCT_NO integer,
DESCRIPTION text,
PRODUCT_COST numeric);

alter table TB_PRODUCT_PK_TEST
add primary key (PRODUCT_NO);
-----------------------------------------------------------
-- �⺻Ű ���� (auto increment)
create table TB_PRODUCT_PK_TEST_2
(NAME varchar(255));

insert into TB_PRODUCT_PK_TEST_2 (NAME)
values
('MICROSOFT'),
('IBM'),
('APPLE'),
('SAMSUNG');

commit;

select * from TB_PRODUCT_PK_TEST_2;

alter table TB_PRODUCT_PK_TEST_2 add column ID serial primary key;
-- auto increment�� �⺻Ű ������ �⺻Ű Į���� �߰��Ǹ鼭 ���� �ڵ����� ������
-----------------------------------------------------------
-- �⺻Ű ����
alter table TB_PRODUCT_PK_TEST
drop constraint TB_PRODUCT_PK_TEST_PKEY;

alter table TB_PRODUCT_PK_TEST_2
drop constraint TB_PRODUCT_PK_TEST_2_PKEY;
-----------------------------------------------------------
-- �ܷ�Ű (�ڽ� ���̺��� Ư�� Į���� �θ� ���̺��� Ư�� Į���� ���� �����ϴ� �� -> �������Ἲ)
create table SO_HEADERS
(ID serial primary key,
CUSTOMER_ID integer,
SHIP_TO varchar(255));

create table SO_ITEMS
(ITEM_ID integer not null,
SO_ID integer,
PRODUCT_ID integer,
QTY integer,
NET_PRICE integer,
primary key (ITEM_ID,SO_ID));

alter table SO_ITEMS
add constraint FK_SO_HEADERS_ID
foreign key (SO_ID) references SO_HEADERS(ID);

insert into SO_HEADERS(CUSTOMER_ID,SHIP_TO)
values
(10, '4000 North First Street, CA 95134, USA'),
(20, '1900 North First Street, CA 95134, USA'),
(10, '4000 North First Street, CA 95134, USA');

commit;

insert into SO_ITEMS
(ITEM_ID,SO_ID,PRODUCT_ID,QTY,NET_PRICE)
values
(1, 1, 1001, 2, 1000),
(2, 1, 1000, 3, 1500),
(3, 2, 1000, 4, 1500),
(1, 2, 1001, 5, 1000),
(2, 3, 1002, 2, 1700),
(3, 3, 1003, 1, 2000);

commit;

select * from SO_HEADERS;
select * from SO_ITEMS;
-- SO_ITEMS���̺��� SO_ID�� ���� SO_HEADERS���̺��� IDĮ���� �����ؾ� ��
-----------------------------------------------------------
insert into SO_ITEMS
(ITEM_ID,SO_ID,PRODUCT_ID,QTY,NET_PRICE)
values
(1,4,1001,2,1000);
-- �������� �ʴ� ���� �Է��Ϸ��� �� �� ���� �߻�
-----------------------------------------------------------
-- DDL������ �ܷ�Ű ����
alter table SO_ITEMS
drop constraint FK_SO_HEADERS_ID;
-----------------------------------------------------------
-- ���̺� ������ ���ÿ� �ܷ�Ű ����
create table SO_ITEMS_2
(ITEM_ID integer not null,
SO_ID integer references SO_HEADERS(ID),
PRODUCT_ID integer,
QTY integer,
NET_PRICE numeric,
primary key (ITEM_ID,SO_ID));
-----------------------------------------------------------
-- ���� �ܷ�Ű ���� ���
create table CHILD_TABLE
(C1 integer primary key,
C2 integer,
C3 integer,
foreign key (C2,C3) references PARENT_TABLE (P1,P2));
-----------------------------------------------------------
-- check (Ư�� Į���� ���� ���� ���� ������ ���ϴ� �� -> ���������� ���� �� �� ���� ���� ���� ��)
create table TB_EMP_CHECK_TEST
(ID serial primary key,
FIRST_NAME varchar(50),
LAST_NAME varchar(50),
BIRTH_DATE date check (BIRTH_DATE>'1900-01-01'),
JOINED_DATE date check (JOINED_DATE>BIRTH_DATE),
SALARY numeric check (SALARY>0));

insert into TB_EMP_CHECK_TEST
(FIRST_NAME, LAST_NAME, BIRTH_DATE, JOINED_DATE, SALARY)
values
('John','Doe','1972-01-01','2015-07-01',-100000); -- SALARY check ���� 
-----------------------------------------------------------
-- ���̺� ���� �� üũ ���� ���� �߰�
alter table TB_EMP_CHECK_TEST
add constraint SALARY_RANGE_CHECK
check (SALARY>0 and SALARY<=1000000000);

alter table TB_EMP_CHECK_TEST
add constraint NAME_CHECK
check (length(FIRST_NAME)>0 and length(LAST_NAME) > 0);
-----------------------------------------------------------
-- unique
create table PERSON
(ID serial primary key,
FIRST_NAME varchar(50),
LAST_NAME varchar(50),
EMAIL varchar(50),
unique(EMAIL));

insert into PERSON(FIRST_NAME,LAST_NAME,EMAIL)
values
('John','Doe','j.doe@postgresqltutoiral.com');

commit;

insert into PERSON(FIRST_NAME,LAST_NAME,EMAIL)
values
('John','Doe','j.doe@postgresqltutoiral.com'); -- �̹� ���� (unique ���� ����) --> ����
-----------------------------------------------------------
-- unique index ����
create table PERSON_UNIQUE_INDEX_TEST
(ID serial primary key,
FIRST_NAME varchar(50),
LAST_NAME varchar(50),
EMAIL varchar(50));

create unique index
IX_PERSON_UNIQUE_INDEX_TEST_01
on PERSON_UNIQUE_INDEX_TEST(EMAIL);

insert into PERSON_UNIQUE_INDEX_TEST(FIRST_NAME,LAST_NAME,EMAIL)
values
('John','Doe','j.doe@postgresqltutorial.com');

commit;

insert into PERSON_UNIQUE_INDEX_TEST(FIRST_NAME,LAST_NAME,EMAIL)
values
('John','Doe','j.doe@postgresqltutorial.com'); -- ������ �����ϴ� �̸��� �ּҸ� �Է��Ϸ��� �� --> ����
-----------------------------------------------------------
-- not null (Ư�� Į���� null ���� ���� ���� ����)
create table INVOICE
(ID serial primary key,
PRODUCT_ID int not null,
QTY numeric not null check(QTY > 0),
NET_PRICE numeric check(NET_PRICE > 0));

insert into INVOICE (PRODUCT_ID, QTY, NET_PRICE)
values
(null,1,1); -- not null ���� ���� (PRODUCT_ID)
-----------------------------------------------------------
-- update & not null
create table INVOICE_UPDATE_TEST
(ID serial primary key,
PRODUCT_ID int not null,
QTY numeric not null check(QTY > 0),
NET_PRICE numeric check(NET_PRICE > 0));

insert into INVOICE_UPDATE_TEST (PRODUCT_ID, QTY, NET_PRICE)
values
(1,1,1);

commit;

update INVOICE_UPDATE_TEST
set PRODUCT_ID = null
	where PRODUCT_ID = 1;
-----------------------------------------------------------
-- �ǽ�����1
create table TB_MOVIE_CUST
(CUSTOMER_ID char(10) primary key,
CUSTOMER_NAME varchar(50) not null,
SEX varchar(6) not null check (SEX in ('����','����')),
BIRTH_DATE date not null,
ADDRESS varchar(200),
PHONE_NUMBER varchar(13),
CUSTOMER_GRADE char(1) not null check (CUSTOMER_GRADE in ('S','A','B','C','D')),
JOIN_DATE date not null check (JOIN_DATE <= EXPIRE_DATE),
EXPIRE_DATE date not null default to_date('9999-12-31','YYYY-MM-DD'));

create table TB_MOVIE_RESV
(RESERVATION_NUMB char(10) primary key,
MOVIE_ID char(6) not null,
THEATER_NUMB char(6) not null,
CUSTOMER_ID varchar(10) not null references TB_MOVIE_CUST(CUSTOMER_ID),
START_TIME timestamp not null check (START_TIME < END_TIME),
END_TIME timestamp not null,
SEAT_NUMB char(4) not null);
-----------------------------------------------------------
insert into TB_MOVIE_CUST
(CUSTOMER_ID, CUSTOMER_NAME, SEX, BIRTH_DATE, ADDRESS, PHONE_NUMBER, CUSTOMER_GRADE,JOIN_DATE)
values
('0000000001', '�̰��', '����', TO_DATE('1984-06-12', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-1', '010-1234-1234', 'S', TO_DATE('2017-01-01', 'YYYY-MM-DD'))
, ('0000000002', 'ȫ�浿', '����', TO_DATE('1971-07-04', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-2', '010-4321-4321', 'A', TO_DATE('2018-06-01', 'YYYY-MM-DD'))
, ('0000000003', '�̼���', '����', TO_DATE('1994-12-28', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-3', '010-5678-5678', 'B', TO_DATE('2019-12-01', 'YYYY-MM-DD'))
;

commit;

select * from TB_MOVIE_CUST;
-----------------------------------------------------------
insert into TB_MOVIE_RESV
values
('9000000001', '000001', '000010', '0000000001', to_timestamp('2019-05-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'A-01')
, ('9000000002', '000002', '000020', '0000000001', to_timestamp('2019-04-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'A-11')
, ('9000000003', '000003', '000040', '0000000002', to_timestamp('2019-03-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'B-12')
, ('9000000004', '000004', '000050', '0000000002', to_timestamp('2019-03-25 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-02')
, ('9000000005', '000005', '000060', '0000000003', to_timestamp('2018-07-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'E-03')
, ('9000000006', '000006', '000060', '0000000003', to_timestamp('2018-08-15 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2019-05-01 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'D-10')
;

commit;

select * from TB_MOVIE_RESV;
-----------------------------------------------------------
-- �ǽ�����2
insert into TB_MOVIE_CUST(CUSTOMER_ID, CUSTOMER_NAME, SEX, BIRTH_DATE, ADDRESS, PHONE_NUMBER, CUSTOMER_GRADE,JOIN_DATE)
values
('0000000004', '�̽¿�', '����', TO_DATE('1984-06-12', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-1', '010-1234-1234', 'A', TO_DATE('2017-01-01', 'YYYY-MM-DD'))
, ('0000000005', '����ȯ', '����', TO_DATE('1971-07-04', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-2', '010-4321-4321', 'A', TO_DATE('2018-06-01', 'YYYY-MM-DD'))
, ('0000000006', '������', '����', TO_DATE('1994-12-28', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-3', '010-5678-5678', 'C', TO_DATE('2019-12-01', 'YYYY-MM-DD'))
, ('0000000007', '�⼺��', '����', TO_DATE('1984-06-12', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-1', '010-1234-1234', 'B', TO_DATE('2017-01-01', 'YYYY-MM-DD'))
, ('0000000008', '��û��', '����', TO_DATE('1971-07-04', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-2', '010-4321-4321', 'C', TO_DATE('2018-06-01', 'YYYY-MM-DD'))
, ('0000000009', '������', '����', TO_DATE('1994-12-28', 'YYYY-MM-DD'), '��⵵ �Ⱦ�� ���ȱ� ��굿 1-3', '010-5678-5678', 'D', TO_DATE('2019-12-01', 'YYYY-MM-DD'));

-- ��ü����, ����ǰ���, ��޺���հ���, ��޺��ִ����, ��޺��ּҰ���, �ּҰ����ǵ��, �ִ�����ǵ��
select
count(*) "��ü����",
count(distinct CUSTOMER_GRADE) "����ǰ���",
round(max(AVG_BY_GRADE),2) "��޺���հ���",
max(MAX_BY_GRADE) "��޺��ִ����",
max(MIN_BY_GRADE) "��޺��ּҰ���",
max(GRADE_BY_MIN_EMP_COUNT) "�ּҰ����ǵ��",
max(GRADE_BY_MAX_EMP_COUNT) "�ִ�����ǵ��"
from TB_MOVIE_CUST, -- �ζ��� �� B,C,D�� ��� �� �� �Ǹ� �����ϹǷ� TB_MOVIE_CUST�� ���ε� ��� ������ �Ǽ��� ��ȭ�� ����. �ش� ���̺�� ��ü ���� �� ��׺��� ������ ����
	(select AVG(CNT) AVG_BY_GRADE, MAX(CNT) MAX_BY_GRADE, MIN(CNT) MIN_BY_GRADE -- ī��Ʈ ���� �������� ���,�ִ�,�ּҰ��� ����
		from (select count(*) CNT from TB_MOVIE_CUST A group by CUSTOMER_GRADE) A) -- TB_MOVIE_CUST ���̺��� CUSTOMER_GRADE Į������ group_by �� ����� �� ī��Ʈ�� ����
	B,
	(select CUSTOMER_GRADE as GRADE_BY_MIN_EMP_COUNT
		from (select CUSTOMER_GRADE, count(*) CNT from TB_MOVIE_CUST -- �� ��޺��� ������ ���� ���� �ϳ��� ����� ���� (asc ����)
			group by CUSTOMER_GRADE order by CNT) A
	limit 1)
	C,
	(select CUSTOMER_GRADE as GRADE_BY_MAX_EMP_COUNT
		from (select CUSTOMER_GRADE, count(*) CNT from TB_MOVIE_CUST -- �� ��޺��� ������ ���� ���� �ϳ��� ����� ���� (desc ����)
			group by CUSTOMER_GRADE order by CNT desc) A
	limit 1)
	D
;