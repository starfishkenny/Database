-- 데이터 타입
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
-- 참값 추출
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
-- CHAR(길이): 고정형 길이, 공간이 남을시 공백으로 패딩
-- VARCHAR(길이): 가변형 길이, 공간이 남을시 공백으로 패딩하지 않음
-- TEXT: 무한대 길이의 문자열을 저장 (= VARCHAR)
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
-- numeric: 정수부터 실수형까지의 숫자를 표현하며 각각의 자릿수를 지정할 수 있음
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
-- serial: integer 형식으로 구현된 sequential한 데이터 (유일성을 보장하는 PK에 자주 사용)
create table TABLE_NAME
(ID serial);

insert into TABLE_NAME
values(default);

commit;

select * from TABLE_NAME;

-- 시퀀스를 이용한 컬럼 생성
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

insert into FRUITS(NAME) values ('orange'); -- ID칼럼 자동으로 1로 들어감

insert into FRUITS(ID,NAME) values(default,'apple'); -- ID칼럼 자동으로 2로 들어감

select * from FRUITS;
-----------------------------------------------------------
select currval(PG_GET_SERIAL_SEQUENCE('fruits','id')); -- 시퀀스 값 구하기
-----------------------------------------------------------
-- DATE(일자)
select NOW()::date; -- 데이터베이스 기준 현재 일자 가져오기
select current_date; -- 데이터베이스 기준 현재 일자 가져오기
select to_char(now()::date,'dd/mm/yyyy'); -- to_char를 이용하여 다른 형태의 포맷으로 가져오기
select to_char(now()::date,'Mon dd,yyyy');
-----------------------------------------------------------
-- 다양한 일자 계산
select
	FIRST_NAME,LAST_NAME,now()-create_date as diff from CUSTOMER;

select
	FIRST_NAME,LAST_NAME,age(create_date) as diff from CUSTOMER;

-- 다양한 일자 추출
select
	FIRST_NAME,LAST_NAME,
	extract(year from create_date) as YEAR,
	extract(month from create_date) as MONTH,
	extract(day from create_date) as DAY 
from CUSTOMER;
-----------------------------------------------------------
-- TIME(시간)
select current_time; -- 데이터베이스 기준 현재 시간을 가져오기
select localtime;

select 
	localtime,
	extract(hour from localtime) as HOUR,
	extract(minute from localtime) as MINUTE,
	extract(second from localtime) as SECOND;

-- 시간계산
select time '10:00' - time '02:00' as diff;
select time '10:59' - time '02:01' as diff;
select time '10:59:59' - time '02:01:01' as diff;

select 
	localtime,
	localtime + interval '2 HOURS' as PLUS_2HOURS,
	localtime - interval '2 HOURS' as MINUS_2HOURS;
-----------------------------------------------------------
-- TIMESTAMP(일자 및 시간)
select now(); -- 데이터베이스 기준 현재 일자 및 시간을 가져오기
select current_timestamp;
select timeofday(); -- 데이터베이스 기준 현재 일자 및 시간에 요일까지 가져오기

-- 다양한 형태의 시간 포맷을 문자열로 출력
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
-- 기본키 (not null, unique)
create table TB_PRODUCT_PK_TEST
(PRODUCT_NO integer,
DESCRIPTION text,
PRODUCT_COST numeric);

alter table TB_PRODUCT_PK_TEST
add primary key (PRODUCT_NO);
-----------------------------------------------------------
-- 기본키 생성 (auto increment)
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
-- auto increment로 기본키 생성시 기본키 칼럼이 추가되면서 값도 자동으로 생성됨
-----------------------------------------------------------
-- 기본키 제거
alter table TB_PRODUCT_PK_TEST
drop constraint TB_PRODUCT_PK_TEST_PKEY;

alter table TB_PRODUCT_PK_TEST_2
drop constraint TB_PRODUCT_PK_TEST_2_PKEY;
-----------------------------------------------------------
-- 외래키 (자식 테이블의 특정 칼럼이 부모 테이블의 특정 칼럼의 값을 참조하는 것 -> 참조무결성)
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
-- SO_ITEMS테이블의 SO_ID의 값은 SO_HEADERS테이블의 ID칼럼에 존재해야 함
-----------------------------------------------------------
insert into SO_ITEMS
(ITEM_ID,SO_ID,PRODUCT_ID,QTY,NET_PRICE)
values
(1,4,1001,2,1000);
-- 존재하지 않는 값을 입력하려고 할 때 오류 발생
-----------------------------------------------------------
-- DDL문으로 외래키 삭제
alter table SO_ITEMS
drop constraint FK_SO_HEADERS_ID;
-----------------------------------------------------------
-- 테이블 생성과 동시에 외래키 생성
create table SO_ITEMS_2
(ITEM_ID integer not null,
SO_ID integer references SO_HEADERS(ID),
PRODUCT_ID integer,
QTY integer,
NET_PRICE numeric,
primary key (ITEM_ID,SO_ID));
-----------------------------------------------------------
-- 복합 외래키 생성 방법
create table CHILD_TABLE
(C1 integer primary key,
C2 integer,
C3 integer,
foreign key (C2,C3) references PARENT_TABLE (P1,P2));
-----------------------------------------------------------
-- check (특저 칼럼에 들어가는 값에 대한 제약을 가하는 것 -> 업무적으로 절대 들어갈 수 없는 값을 막는 것)
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
('John','Doe','1972-01-01','2015-07-01',-100000); -- SALARY check 조건 
-----------------------------------------------------------
-- 테이블 생성 후 체크 제약 조건 추가
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
('John','Doe','j.doe@postgresqltutoiral.com'); -- 이미 있음 (unique 조건 위반) --> 에러
-----------------------------------------------------------
-- unique index 생성
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
('John','Doe','j.doe@postgresqltutorial.com'); -- 기존에 존재하는 이메일 주소를 입력하려고 함 --> 실패
-----------------------------------------------------------
-- not null
create table INVOICE
(ID serial primary key,
PRODUCT_ID int not null,
QTY numeric not null check(QTY > 0),
NET_PRICE numeric check(NET_PRICE > 0));

insert into INVOICE (PRODUCT_ID, QTY, NET_PRICE)
values
(null,1,1); -- not null 조건 위반 (PRODUCT_ID)
-----------------------------------------------------------

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------