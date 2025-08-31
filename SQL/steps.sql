select *
from dailysteps_merged;

CREATE TABLE `dailysteps_merged2` (
  `Id` double DEFAULT NULL,
  `ActivityDay` text,
  `StepTotal` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into dailysteps_merged2
select *
from dailysteps_merged;

select *
from dailysteps_merged2;

select count(*)
from dailysteps_merged2;

-- lets adjust the date first

update dailysteps_merged2
set activityday = str_to_date(activityday, '%m/%d/%Y');

select *
from dailysteps_merged2;

alter table dailysteps_merged2
modify column activityday date;

select *
from dailysteps_merged2;

-- EDA
select id, sum(steptotal)
from dailysteps_merged2
group by id
order by 2 desc;

select id, avg(steptotal)
from dailysteps_merged2
group by id
order by 2 desc;
















