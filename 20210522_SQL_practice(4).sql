-- insert
create table LINK
(ID serial primary key,
URL VARCHAR(255) not null,
NAME VARCHAR(255) not null,
DESCRIPTION VARCHAR(255),
REL VARCHAR(50));
-------------------------------------------------------
insert into LINK
(URL,NAME)
values
('http://naver.com','Naver');
commit;
-------------------------------------------------------
insert into LINK
(URL,NAME)
values
('http://www.google.com','Google'),
('http://www.yahoo.com','Yahoo'),
('http://www.bing.com','Bing');
commit;
-------------------------------------------------------
-- update join
create table product_segment
(ID serial primary key,
SEGMENT varchar(255) not null,
DISCOUNT numeric(4,2));

insert into PRODUCT_SEGMENT
(SEGMENT,DISCOUNT)
values
('Grand Luxury',0.05),
('Luxury',0.06),
('Mass',0.1);

commit;
-------------------------------------------------------
create table product_
(ID serial primary key,
NAME varchar not null,
PRICE numeric(10,2),
NET_PRICE numeric(10,2),
SEGMENT_ID int not null,
foreign key(SEGMENT_ID) references PRODUCT_SEGMENT(ID));

insert into product_ (NAME,PRICE,SEGMENT_ID)
values
('K5', 804.89, 1)
, ('K7', 228.55, 3)
, ('K9', 366.45, 2)
, ('SONATA', 145.33, 3)
, ('SPARK', 551.77, 2)
, ('AVANTE', 261.58, 3)
, ('LOZTE', 519.62, 2)
, ('SANTAFE', 843.31, 1)
, ('TUSON', 254.18, 3)
, ('TRAX', 427.78, 2)
, ('ORANDO', 936.29, 1)
, ('RAY', 910.34, 1)
, ('MORNING', 208.33, 3)
, ('VERNA', 985.45, 1)
, ('K8', 841.26, 1)
, ('TICO', 896.38, 1)
, ('MATIZ', 575.74, 2)
, ('SPORTAGE', 530.64, 2)
, ('ACCENT', 892.43, 1)
, ('TOSCA', 161.71, 3);

commit;
-------------------------------------------------------
select * from product_;
-------------------------------------------------------
update product_ A
	set NET_PRICE = A.PRICE - (A.PRICE * B.DISCOUNT)
	from PRODUCT_SEGMENT B
	where A.segment_ID = B.ID;

-------------------------------------------------------
-- upsert
 create table CUSTOMERS (CUSTOMER_ID serial primary key,
NAME varchar unique,
EMAIL varchar not null,
ACTIVE bool not null default true);

insert into CUSTOMERS(NAME,EMAIL)
values
('IBM', 'contact@ibm.com'),
('Microsoft', 'contact@microsoft.com'),
('Intel', 'contact@intel.com');

commit;
-------------------------------------------------------
insert into CUSTOMERS(NAME,EMAIL)
values
('Microsoft','hotline@microsoft.com')
on conflict(NAME) do nothing;
-------------------------------------------------------
insert into CUSTOMERS(NAME,EMAIL)
values
('Microsoft','hotline@microsoft.com') 
on conflict(NAME)
do update
set EMAIL = excluded.EMAIL ||';'|| CUSTOMERS.EMAIL;

commit;
-------------------------------------------------------
-- export
copy CATEGORY(CATEGORY_ID,NAME,LAST_UPDATE)
to '...\DB_CATEGORY.csv'
delimiter ','
csv header;
-------------------------------------------------------
copy CATEGORY(CATEGORY_ID,NAME,LAST_UPDATE)
to '...\DB_CATEGORY.txt'
delimiter '|'
csv header;
-------------------------------------------------------
copy CATEGORY(CATEGORY_ID,NAME,LAST_UPDATE)
to '...\DB_CATEGORY_2.csv'
delimiter ','
csv; -- �÷��� ���� ���
-------------------------------------------------------
-- import
create table CATEGORY_IMPORT
(CATEGORY_ID serial not null,
"NAME" varchar(25) not null,
LAST_UPDATE timestamp not null default now(),
constraint CATEGORY_IMPORT_PKEY primary key (CATEGORY_ID));
-------------------------------------------------------
copy CATEGORY_IMPORT(CATEGORY_ID,"NAME",LAST_UPDATE)
from '...\DB_CATEGORY.csv'
delimiter ','
csv header;
-------------------------------------------------------
select * from CATEGORY_IMPORT;
-------------------------------------------------------
delete from CATEGORY_IMPORT;
commit;
-------------------------------------------------------
copy CATEGORY_IMPORT(CATEGORY_ID,"NAME",LAST_UPDATE)
from '...\DB_CATEGORY.txt'
delimiter '|'
csv header;
-------------------------------------------------------
copy CATEGORY_IMPORT(CATEGORY_ID,"NAME",LAST_UPDATE)
from '...\DB_CATEGORY_2.csv'
delimiter ','
csv;
-------------------------------------------------------
-- ������Ÿ��1
create table data_type_test_1
(A_BOOLEAN boolean,
B_CHAR char(10),
C_VARCHAR varchar(10),
D_TEXT text,
E_INT int,
F_SAMLLINT smallint,
G_FLOAT float,
H_NUMERIC numeric(15,2));

insert into DATA_TYPE_TEST_1
values
(true,
'ABCDE',
'ABCDE',
'TEXT',
1000,
10,
10.12345,
10.25);

select * from DATA_TYPE_TEST_1;
-------------------------------------------------------
-- ������Ÿ��2
create table DATA_TYPE_TEST_2
(A_DATE date,
B_TIME time,
C_TIMESTAMP timestamp,
D_ARRAY text[],
E_JSON json);

insert into data_type_test_2 
values
(current_date,
localtime,
current_timestamp,
array['010-1234-1234','010-4321-4321'],
'{"customer":"John Doe","items":{"product":"Beer","qty":6}}');

select * from DATA_TYPE_TEST_2;
-------------------------------------------------------
-- ���̺����_��������
create table ACCOUNT
(USER_ID serial primary key,
USERNAME varchar(50) unique not null,
PASSWORD varchar(50) not null,
EMAIL varchar(355) unique not null,
CREATED_ON timestamp not null,
LAST_LOGIN timestamp);
-------------------------------------------------------
create table role
(ROLE_ID serial primary key,
ROLE_NAME varchar(255) unique not null);
-------------------------------------------------------
create table ACCOUNT_ROLE
(USER_ID integer not null,
ROLE_ID integer not null,
GRANT_DATE timestamp without time zone,
primary key (USER_ID,ROLE_ID),
constraint ACCOUNT_ROLE_ROLE_ID_FKEY foreign key(ROLE_ID)
references ROLE(ROLE_ID) match simple
on update no action on delete no action,
constraint ACCOUNT_ROLE_USER_ID_FKEY foreign key(USER_ID)
references ACCOUNT(USER_ID) match simple
on update no action on delete no action);

-- ROLE_ID �÷��� ROLE���̺��� ROLE_ID �÷��� �����Ѵ�.
-- ROLE_ID �÷��� ROLE���̺��� ROLE_ID �÷��� ���� ���� Ȥ�� ����� �ƹ��͵� ���� �ʴ´�.
-- USER_ID �÷��� ACCOUNT���̺��� USER_ID �÷��� �����Ѵ�.
-- USER_ID �÷��� ACCOUNT���̺��� USER_ID �÷��� ���� ���� Ȥ�� ����� �ƹ��͵� ���� �ʴ´�.
-------------------------------------------------------
insert into ACCOUNT
values
(1,'�̰��','1234','dbms@naver.com',current_timestamp,null);

commit;

select * from ACCOUNT;
-------------------------------------------------------
insert into ROLE
values
(1,'DBA');

commit;

select * from role;
-------------------------------------------------------
insert into ACCOUNT_ROLE
values
(1,1,current_timestamp);

select * from ACCOUNT_ROLE;
-------------------------------------------------------
-- CTAS(CREATE TABLE AS SELECT)
-- �׼ǿ�ȭ�� ���������� �ű� ���̺� ����(1)
create table ACTION_FILM as select
A.FILM_ID,A.TITLE,A.RELEASE_YEAR,A.LENGTH,A.RATING
from FILM A, FILM_CATEGORY B
	where A.FILM_ID = B.FILM_ID and B.CATEGORY_ID =1;

select * from ACTION_FILM;
-------------------------------------------------------
-- �׼ǿ�ȭ�� ���������� �ű� ���̺� ����(2)
create table if not exists ACTION_FILM as select
A.FILM_ID,A.TITLE,A.RELEASE_YEAR,A.LENGTH,A.RATING
from FILM A, FILM_CATEGORY B
	where A.FILM_ID = B.FILM_ID and B.CATEGORY_ID =1;

-- ������ ���̺��� �־ if not exists�� ���� error �߻� X / �ƹ��� �۾� ���� SQL�� ����