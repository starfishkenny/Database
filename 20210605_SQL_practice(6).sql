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

----------------------------------------------------------------
-- cast (������ ���� Ư�� ������ Ÿ������ ����ȯ�� �����ϵ��� ��)
select cast ('100' as integer);

select '100'::integer; -- ���� ���� ���

select cast ('10c' as integer); -- ����ȯ �Ұ���

select cast '10c'::integer;

select cast ('2015-01-01' as date);

select '2015-01-01'::date;

select cast ('10.2' as double precision); -- '10.2'��� ���ڿ��� �Ǽ������� ����ȯ

select '10.2'::double precision;

----------------------------------------------------------------
-- with (select���� ����� �ӽ� �������� �����صΰ� SQL������ ��ġ ���̺�ó�� �ش� ������ �ҷ��� �� ����)
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

-- with���� �̿��ؼ� �ش� ������ TMP1���� �����ϰ�Ʒ� select������ TMP1�� ��ȸ��
-- TMP1 ���տ��� �󿵽ð��� ������ LONG�� ������ �����

----------------------------------------------------------------
-- ��� ���� (with�� Ȱ��)
create table TB_EMP_RECURSIVE_TEST
(EMPLOYEE_ID serial primary key,
FULL_NAME varchar not null,
MANAGER_ID int);

insert into TB_EMP_RECURSIVE_TEST
(EMPLOYEE_ID,FULL_NAME,MANAGER_ID)
values
(1 , '�̰��', NULL)
, (2 , '������', 1)
, (3 , '��¹�', 1)
, (4 , '�ϼ���', 1)
, (5 , '�۹鼱', 1)
, (6 , '�̽���', 2)
, (7 , 'ȫ�߼�', 2)
, (8 , '��̼�', 2)
, (9 , '�輱��', 2)
, (10, '�̼���', 3)
, (11, '�輱��', 3)
, (12, '�輱��', 3)
, (13, '�̿���', 3)
, (14, '����', 4)
, (15, '�̽ÿ�', 4)
, (16, '�ּ���', 7)
, (17, '������', 7)
, (18, '�ֹ���', 8)
, (19, '������', 8)
, (20, '�밡��', 8);

commit;

select * from TB_EMP_RECURSIVE_TEST;

with recursive TMP1 as
	(select EMPLOYEE_ID,MANAGER_ID,FULL_NAME,0 LVL
	from TB_EMP_RECURSIVE_TEST where MANAGER_ID is null -- �ֻ��� �����ں��� ��� ����
	union
	select E.EMPLOYEE_ID,E.MANAGER_ID,E.FULL_NAME,S.LVL + 1
	from TB_EMP_RECURSIVE_TEST E, TMP1 S where S.EMPLOYEE_ID = E.MANAGER_ID)
select EMPLOYEE_ID, MANAGER_ID, LPAD(' ',4 * (LVL)) || FULL_NAME as FULL_NAME
from TMP1;

with recursive TMP1 as
	(select EMPLOYEE_ID,MANAGER_ID,FULL_NAME,0 LVL
	from TB_EMP_RECURSIVE_TEST where MANAGER_ID = 2 -- '������' ������� ��� ����
	union
	select E.EMPLOYEE_ID,E.MANAGER_ID,E.FULL_NAME,S.LVL + 1
	from TB_EMP_RECURSIVE_TEST E, TMP1 S where S.EMPLOYEE_ID = E.MANAGER_ID)
select EMPLOYEE_ID, MANAGER_ID, LPAD(' ',4 * (LVL)) || FULL_NAME as FULL_NAME
from TMP1;

----------------------------------------------------------------
-- tranaction (begin, commit, rollback)
-- Postgresql�� DDL�� Ŀ���� �ؾ��� (����Ŭ�� �� �ʿ� ����)
create table TB_ACCOUNT_TRANSACTION_TEST
(ID int generated by default as IDENTITY,
NAME varchar(100) not null,
BALANCE dec(15,2) not null,
primary key(ID));

commit;

----------------------------------------------------------------
begin; -- ��������

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