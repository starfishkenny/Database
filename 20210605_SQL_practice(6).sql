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