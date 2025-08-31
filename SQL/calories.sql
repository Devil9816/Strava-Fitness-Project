select *
from dailycalories_merged;

select count(*)
from dailycalories_merged;

select count(distinct id)
from dailycalories_merged;

select *
from dailycalories_merged;

-- for each user, i want to know how much calories he has burnt in a month

select id, sum(calories)
from dailycalories_merged
group by id;

select id, avg(calories) as average_calories_burnt
from dailycalories_merged
group by id
order by 2 desc; 

select id, round(avg(calories),2) as average_calories_burnt
from dailycalories_merged
group by id
order by 1 desc;

select *
from dailycalories_merged;


select activityday, 
	str_to_date(activityday, '%m/%d/%Y') as fulldate,
    year(str_to_date(activityday, '%m/%d/%Y')) as years,
    month(str_to_date(activityday, '%m/%d/%Y')) as months
from dailycalories_merged;

update  dailycalories_merged
set activityday = str_to_date(activityday, '%m/%d/%Y');

select *
from dailycalories_merged;

CREATE TABLE `dailycalories_merged2` (
  `Id` double DEFAULT NULL,
  `FullDate` date,
  `Calories` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from dailycalories_merged2;

insert into dailycalories_merged2
select *
from dailycalories_merged;

select *
from dailycalories_merged2;


-- EDA
select id, sum(calories)
from dailycalories_merged2
group by id;

select id, avg(calories)
from dailycalories_merged2
group by id;










