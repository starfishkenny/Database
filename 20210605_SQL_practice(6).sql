-- case (if절과 같은 로직)
select
	sum(case 
		when RENTAL_RATE = 0.99 then 1
		else 0 end) as "C",
	sum(case
		when RENTAL_RATE = 2.99 then 1
		else 0 end) as "B",
	sum(case
		when RENTAL_RATE = 4.99 then 1
		else 0 end) as "A"
from film;

select RENTAL_RATE, count(*) CNT
from FILM
group by RENTAL_RATE;

select * from
	(select sum(case when RENTAL_RATE = 0.99 then CNT else 0 end) as C,
			sum(case when RENTAL_RATE = 2.99 then CNT else 0 end) as B,
			sum(case when RENTAL_RATE = 4.99 then CNT else 0 end) as A
		from (select RENTAL_RATE, count(*) CNT from FILM group by RENTAL_RATE) A
	) A;
----------------------------------------------------------------
-- coalesce (입력한 인자값 중에서 null값이 아닌 첫번째 값을 리턴)
create table TB_ITEM_COALESCE_TEST
(ID serial primary key,
PRODUCT varchar(100) not null,
PRICE numeric not null,
DISCOUNT numeric);

insert into TB_ITEM_COALESCE_TEST (PRODUCT,PRICE,DISCOUNT)
values
('A',1000,10),
('B',1500,20),
('C',800,5),
('D',500,null);

commit;

select * from TB_ITEM_COALESCE_TEST;

select PRODUCT, (PRICE - DISCOUNT) as NET_PRICE
from TB_ITEM_COALESCE_TEST;

select PRODUCT, (PRICE - coalesce(DISCOUNT,0)) as NET_PRICE
from TB_ITEM_COALESCE_TEST; -- DISCOUNT가 null이면 0을 리턴하고, null이 아니면 DISCOUNT값을 리턴

select PRODUCT, (PRICE - case when DISCOUNT is null then 0 else DISCOUNT end) as NET_PRICE
from TB_ITEM_COALESCE_TEST; -- DISCOUNT가 null이면 0을 리턴하고, null이 아니라면 DISCOUNT값을 리턴

----------------------------------------------------------------
-- nullif (입력한 두개의 인자값이 동일하면 null을 리턴하고 아니면 첫번째 인자값 리턴)
create table TB_MEMBER_NULLIF_TEST
(ID serial primary key,
FIRST_NAME varchar(50) not null,
LAST_NAME varchar(50) not null,
GENDER smallint not null);

insert into TB_MEMBER_NULLIF_TEST
(FIRST_NAME,LAST_NAME,GENDER)
values
('John','Doe',1),
('David','Dave',1),
('Bush','Lily',2);

commit;

select * from TB_MEMBER_NULLIF_TEST;

-- 여자 대비 남자의 비율 구하기
select (sum(case when GENDER = 1 then 1 else 0 end) / sum(case when GENDER = 2 then 1 else 0 end)) * 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST;

-- 테스트를 위해 여자를 남자로 변경
update TB_MEMBER_NULLIF_TEST
	set GENDER = 1
	where GENDER = 2;
	
commit;

select * from TB_MEMBER_NULLIF_TEST;

select (sum(case when GENDER = 1 then 1 else 0 end) / sum(case when GENDER = 2 then 1 else 0 end)) * 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST; -- 오류 발생

-- nullif 사용 -> 오류 X
select (sum(case when GENDER = 1 then 1 else 0 end) / nullif(sum(case when GENDER = 2 then 1 else 0 end), 0)) -- 여성의 합계가 0이면 null
* 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST;

----------------------------------------------------------------
-- cast (데이터 값을 특정 데이터 타입으로 형변환이 가능하도록 함)
select cast ('100' as integer);

select '100'::integer; -- 위와 같은 결과

select cast ('10c' as integer); -- 형변환 불가능

select cast '10c'::integer;

select cast ('2015-01-01' as date);

select '2015-01-01'::date;

select cast ('10.2' as double precision); -- '10.2'라는 문자열을 실수형으로 형변환

select '10.2'::double precision;

----------------------------------------------------------------
-- with (select문의 결과를 임시 집합으로 저장해두고 SQL문에서 마치 테이블처럼 해당 집합을 불러올 수 있음)
select 
	FILM_ID,
	TITLE,
	(case when LENGTH < 30 then 'SHORT'
		  when LENGTH >= 30 and LENGTH < 90 then 'MEDIUM'
		  when LENGTH > 90 then 'LONG' end) LENGTH
from FILM;

with TMP1 as
	(select 
	FILM_ID,
	TITLE,
	(case when LENGTH < 30 then 'SHORT'
		  when LENGTH >= 30 and LENGTH < 90 then 'MEDIUM'
		  when LENGTH > 90 then 'LONG' end) LENGTH
	 from FILM)
select * from TMP1 where LENGTH = 'LONG';

-- with문을 이용해서 해당 집합을 TMP1으로 지정하고아래 select문에서 TMP1을 조회함
-- TMP1 집합에서 상영시간이 구분이 LONG인 집합을 출력함

----------------------------------------------------------------
-- 재귀 쿼리 (with를 활용)
create table TB_EMP_RECURSIVE_TEST
(EMPLOYEE_ID serial primary key,
FULL_NAME varchar not null,
MANAGER_ID int);

insert into TB_EMP_RECURSIVE_TEST
(EMPLOYEE_ID,FULL_NAME,MANAGER_ID)
values
(1 , '이경오', NULL)
, (2 , '김한이', 1)
, (3 , '김승범', 1)
, (4 , '하선주', 1)
, (5 , '송백선', 1)
, (6 , '이슬이', 2)
, (7 , '홍발순', 2)
, (8 , '김미순', 2)
, (9 , '김선태', 2)
, (10, '이선형', 3)
, (11, '김선미', 3)
, (12, '김선훈', 3)
, (13, '이왕준', 3)
, (14, '김사원', 4)
, (15, '이시원', 4)
, (16, '최선영', 7)
, (17, '박태후', 7)
, (18, '최민준', 8)
, (19, '정택헌', 8)
, (20, '노가람', 8);

commit;

select * from TB_EMP_RECURSIVE_TEST;

with recursive TMP1 as
	(select EMPLOYEE_ID,MANAGER_ID,FULL_NAME,0 LVL
	from TB_EMP_RECURSIVE_TEST where MANAGER_ID is null -- 최상위 관리자부터 재귀 시작
	union
	select E.EMPLOYEE_ID,E.MANAGER_ID,E.FULL_NAME,S.LVL + 1
	from TB_EMP_RECURSIVE_TEST E, TMP1 S where S.EMPLOYEE_ID = E.MANAGER_ID)
select EMPLOYEE_ID, MANAGER_ID, LPAD(' ',4 * (LVL)) || FULL_NAME as FULL_NAME
from TMP1;

with recursive TMP1 as
	(select EMPLOYEE_ID,MANAGER_ID,FULL_NAME,0 LVL
	from TB_EMP_RECURSIVE_TEST where MANAGER_ID = 2 -- '김한이' 사원부터 재귀 시작
	union
	select E.EMPLOYEE_ID,E.MANAGER_ID,E.FULL_NAME,S.LVL + 1
	from TB_EMP_RECURSIVE_TEST E, TMP1 S where S.EMPLOYEE_ID = E.MANAGER_ID)
select EMPLOYEE_ID, MANAGER_ID, LPAD(' ',4 * (LVL)) || FULL_NAME as FULL_NAME
from TMP1;

----------------------------------------------------------------
-- tranaction (begin, commit, rollback)
-- Postgresql은 DDL도 커밋을 해야함 (오라클은 할 필요 없음)
create table TB_ACCOUNT_TRANSACTION_TEST
(ID int generated by default as IDENTITY,
NAME varchar(100) not null,
BALANCE dec(15,2) not null,
primary key(ID));

commit;

----------------------------------------------------------------
begin; -- 생략가능

insert into TB_ACCOUNT_TRANSACTION_TEST
(NAME,BALANCE)
values
('Alice',10000);

commit;

insert into TB_ACCOUNT_TRANSACTION_TEST
(NAME,BALANCE)
values
('Danny',20000);

rollback;

select * from TB_ACCOUNT_TRANSACTION_TEST;