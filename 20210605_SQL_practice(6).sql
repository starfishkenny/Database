-- case (if���� ���� ����)
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
-- coalesce (�Է��� ���ڰ� �߿��� null���� �ƴ� ù��° ���� ����)
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
from TB_ITEM_COALESCE_TEST; -- DISCOUNT�� null�̸� 0�� �����ϰ�, null�� �ƴϸ� DISCOUNT���� ����

select PRODUCT, (PRICE - case when DISCOUNT is null then 0 else DISCOUNT end) as NET_PRICE
from TB_ITEM_COALESCE_TEST; -- DISCOUNT�� null�̸� 0�� �����ϰ�, null�� �ƴ϶�� DISCOUNT���� ����

----------------------------------------------------------------
-- nullif (�Է��� �ΰ��� ���ڰ��� �����ϸ� null�� �����ϰ� �ƴϸ� ù��° ���ڰ� ����)
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

-- ���� ��� ������ ���� ���ϱ�
select (sum(case when GENDER = 1 then 1 else 0 end) / sum(case when GENDER = 2 then 1 else 0 end)) * 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST;

-- �׽�Ʈ�� ���� ���ڸ� ���ڷ� ����
update TB_MEMBER_NULLIF_TEST
	set GENDER = 1
	where GENDER = 2;
	
commit;

select * from TB_MEMBER_NULLIF_TEST;

select (sum(case when GENDER = 1 then 1 else 0 end) / sum(case when GENDER = 2 then 1 else 0 end)) * 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST; -- ���� �߻�

-- nullif ��� -> ���� X
select (sum(case when GENDER = 1 then 1 else 0 end) / nullif(sum(case when GENDER = 2 then 1 else 0 end), 0)) -- ������ �հ谡 0�̸� null
* 100 as "MALE/FEMALE RATIO"
from TB_MEMBER_NULLIF_TEST;