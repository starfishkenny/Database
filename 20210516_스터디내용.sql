select count(*), A.film_id
from film_actor A
	where 0 < 200
group by A.film_id
order by A.film_id;

select * from film;
select * from film_actor;

select count(*) from film B where B.rental_rate = 2.99;

create table EMP
(A int primary key,
B varchar (100) not null,
C varchar (100) not null);

create table DEPT
(C varchar(100) primary key,
D int not null,
E int not null);

insert into EMP
(A, B, C)
values
(1, 'b', 'w'),
(3, 'd', 'w'),
(5, 'y','y');

insert into DEPT
(C,D,E)
values
('x',1,5);

select * from EMP A
	left outer join DEPT B on A.C = B.C;