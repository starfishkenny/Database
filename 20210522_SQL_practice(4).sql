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
csv; -- 컬럼명 없이 출력
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
-- 데이터타입1
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
-- 데이터타입2
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
-- 테이블생성_제약조건
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

-- ROLE_ID 컬럼은 ROLE테이블의 ROLE_ID 컬럼을 참조한다.
-- ROLE_ID 컬럼은 ROLE테이블의 ROLE_ID 컬럼에 대한 삭제 혹은 변경시 아무것도 하지 않는다.
-- USER_ID 컬럼은 ACCOUNT테이블의 USER_ID 컬럼을 참조한다.
-- USER_ID 컬럼은 ACCOUNT테이블의 USER_ID 컬럼에 대한 삭제 혹은 변경시 아무것도 하지 않는다.
-------------------------------------------------------
insert into ACCOUNT
values
(1,'이경오','1234','dbms@naver.com',current_timestamp,null);

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
-- 액션영화의 정보만으로 신규 테이블 생성(1)
create table ACTION_FILM as select
A.FILM_ID,A.TITLE,A.RELEASE_YEAR,A.LENGTH,A.RATING
from FILM A, FILM_CATEGORY B
	where A.FILM_ID = B.FILM_ID and B.CATEGORY_ID =1;

select * from ACTION_FILM;
-------------------------------------------------------
-- 액션영화의 정보만으로 신규 테이블 생성(2)
create table if not exists ACTION_FILM as select
A.FILM_ID,A.TITLE,A.RELEASE_YEAR,A.LENGTH,A.RATING
from FILM A, FILM_CATEGORY B
	where A.FILM_ID = B.FILM_ID and B.CATEGORY_ID =1;

-- 기존에 테이블이 있어도 if not exists로 인해 error 발생 X / 아무런 작업 없이 SQL문 종료
-------------------------------------------------------
-- 테이블 구조 변경
create table LINKS
(LINK_ID serial primary key,
TITLE varchar(512) not null,
URL varchar(1024) not null unique);
-------------------------------------------------------
alter table LINKS add column ACTIVE boolean; -- ACTIVE 칼럼 추가
select * from LINKS;
-------------------------------------------------------
alter table LINKS drop column ACTIVE; -- ACTIVE 칼럼 제거
select * from LINKS;
-------------------------------------------------------
alter table LINKS rename column TITLE to LINK_TITLE; -- TITLE 칼럼 LINK_TITLE 칼럼으로 이름 변경
select * from LINKS;
-------------------------------------------------------
alter table links add column TARGET varchar(10);
select * from LINKS;
-------------------------------------------------------
alter table LINKS alter column TARGET set default '_BLANK'; -- TARGET 칼럼의 default값을 '_BLANK'로 설정
select * from LINKS;
-------------------------------------------------------
insert into LINKS
(LINK_TITLE,URL)
values
('PostgreSQL Tutorial','http://www.postgresqltutorial.com');

commit;
-------------------------------------------------------
select * from LINKS;
-------------------------------------------------------
alter table LINKS add check (TARGET in ('_self','_blank','_parent','_top')); -- TARGET 칼럼에 대한 체크 제약 조건 추가
-------------------------------------------------------
insert into LINKS
(LINK_TITLE,URL,TARGET)
values
('PostgreSQL Tutorial','http://www.postgresqltutorial.com','whatever'); -- TARGET 칼럼의 체크 제약조건에 없는 'whatever' 값 insert 시도 (X)
-------------------------------------------------------
-- 테이블 이름 변경
create table VENDORS
(ID serial primary key,
NAME varchar not null);
-------------------------------------------------------
alter table VENDORS rename to SUPPLIERS;
-------------------------------------------------------
create table SUPPLIER_GROUPS
(ID serial primary key,
NAME varchar not null);
-------------------------------------------------------
alter table SUPPLIERS add column GROUP_ID int not null;
alter table SUPPLIERS add foreign key (GROUP_ID) references SUPPLIER_GROUPS (ID); -- FK 생성
-------------------------------------------------------
-- 뷰 생성
create view SUPPLIER_DATA as select
S.ID,S.NAME,G.name "GROUP"
from SUPPLIERS S, SUPPLIER_GROUPS G
	where G.ID = S.GROUP_ID;	
-------------------------------------------------------
select * from SUPPLIER_DATA;
-------------------------------------------------------
-- SUPPLIERS 테이블의 GROUP_ID 칼럼은 SUPPLIER_GROUPS 테이블의 ID 칼럼을 참조함
-- 그럼 만약 부모 테이블인 SUPPLIER_GROUPS 테이블의 테이블명을 바꾸면 자식테이블인 SUPPLIERS 테이블은 어떻게 될까
alter table SUPPLIER_GROUPS rename to GROUPS;
-------------------------------------------------------
-- 테이블명이 바뀌었어도 자동으로 GROUPS 테이블을 참조함 (자동으로 반영)
-------------------------------------------------------
-- 컬럼추가
create table TB_CUST
(CUST_ID serial primary key,
CUST_NAME varchar(50) not null);

alter table TB_CUST add column PHONE_NUMBER varchar(13);

alter table TB_CUST
	add column FAX_NUMBER varchar(13),
	add column EMAIL_ADDR varchar(50);

select * from TB_CUST;
-------------------------------------------------------
-- not unll 제약 컬럼 추가 -> 우선 null 조건으로 컬럼 추가 후 해당 컬럼을 update
insert into TB_CUST
values
(1,'이경오','010-1234-5678','02-123-1234','dbmsexpert@naver.com');

commit;
-------------------------------------------------------
alter table TB_CUST add column CONTACT_NM varchar null;

update TB_CUST set CONTACT_NM = '홍길동' where CUST_ID = 1;

commit;

alter table TB_CUST alter column CONTACT_NM set not null;
-------------------------------------------------------
-- 칼럼 제거
create table PUBLISHERS
(PUBLISHER_ID serial primary key,
NAME varchar not null);

create table CATEGORIES_
(CATEGORY_ID serial primary key,
NAME varchar not null);

create table BOOKS
(BOOK_ID serial primary key,
TITLE varchar not null,
ISBN varchar not null,
PUBLISHED_DATE date not null,
DESCRIPTION varchar,
CATEGORY_ID int not null,
PUBLISHER_ID int not null,
foreign key (PUBLISHER_ID) references PUBLISHERS
(PUBLISHER_ID),
foreign key (CATEGORY_ID) references CATEGORIES
(CATEGORY_ID));
-------------------------------------------------------
create view BOOK_INFO as select
	B.BOOK_ID,
	B.TITLE,
	B.ISBN,
	B.PUBLISHED_DATE,
	P.NAME
from BOOKS B, PUBLISHERS P 
	where P.PUBLISHER_ID = B.PUBLISHER_ID
	order by B.TITLE;
-------------------------------------------------------
alter table BOOKS drop column CATEGORY_ID; -- BOOKS 테이블은 자식 테이블이므로 CATEGORY_ID 칼럼은 제거 가능. 칼럼이 제거되면서 CATEGORY_ID의 FK도 함꼐 삭제됨
-------------------------------------------------------
alter table BOOKS drop column PUBLISHER_ID; -- PUBLISHER_ID 칼럼 제거할 수 없음 -> 해당 칼럼은 BOOK_INFO 뷰에서 참조하고 있기 때문
-------------------------------------------------------
alter table BOOKS drop column PUBLISHER_ID cascade;
-------------------------------------------------------
select * from BOOK_INFO; -- 칼럼 삭제 성공, 그러나 BOOK_INFO 뷰도 같이 drop됨
-------------------------------------------------------
alter table BOOKS
	drop column ISBN,
	drop column DESCRIPTION;
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------