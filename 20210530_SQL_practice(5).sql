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
