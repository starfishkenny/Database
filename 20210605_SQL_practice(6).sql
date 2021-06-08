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