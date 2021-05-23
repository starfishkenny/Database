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
from 'E:\DB_CATEGORY.csv'
delimiter ','
csv header;
-------------------------------------------------------
select * from CATEGORY_IMPORT;
-------------------------------------------------------
delete from CATEGORY_IMPORT;
commit;
-------------------------------------------------------
copy CATEGORY_IMPORT(CATEGORY_ID,"NAME",LAST_UPDATE)
from 'E:\DB_CATEGORY.txt'
delimiter '|'
csv header;
-------------------------------------------------------
copy CATEGORY_IMPORT(CATEGORY_ID,"NAME",LAST_UPDATE)
from 'E:\DB_CATEGORY_2.csv'
delimiter ','
csv;
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
