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