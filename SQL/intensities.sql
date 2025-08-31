select *
from dailyintensities_merged;

select id, 
	activityday,
	round(veryactivedistance,2) as veryactivedistance , round((moderatelyactivedistance + lightactivedistance),2) as mediumactivedistance, sedentaryactivedistance,
    veryactiveminutes, (fairlyactiveminutes + lightlyactiveminutes) as mediumactiveminutes,sedentaryminutes   
from dailyintensities_merged;



CREATE TABLE `dailyintensities_merged2` (
  `Id` double DEFAULT NULL,
  `ActivityDay` text,  
   `VeryActiveDistance` double DEFAULT NULL,
  `MediumActiveDistance` double DEFAULT NULL,  
  `SedentaryActiveDistance` int DEFAULT NULL,
  `VeryActiveMinutes` int DEFAULT NULL,
  `MediumActiveMinutes` int DEFAULT NULL,
  `SedentaryMinutes` int DEFAULT NULL  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into dailyintensities_merged2
select id, 
	activityday,
	round(veryactivedistance,2) as veryactivedistance , round((moderatelyactivedistance + lightactivedistance),2) as mediumactivedistance, sedentaryactivedistance,
    veryactiveminutes, (fairlyactiveminutes + lightlyactiveminutes) as mediumactiveminutes,sedentaryminutes   
from dailyintensities_merged;


select *
from dailyintensities_merged2;

select ActivityDay, str_to_date(activityday, '%m/%d/%Y')
from dailyintensities_merged2;

update dailyintensities_merged2
set activityday = str_to_date(activityday, '%m/%d/%Y');

select ActivityDay
from dailyintensities_merged2;

-- now we need to change the data type

alter table dailyintensities_merged2
modify column activityday date;

select activityday, round(avg(VeryActiveDistance),2), round(avg(MediumActiveDistance),2), round(avg(SedentaryActiveDistance),2),
	avg(VeryActiveMinutes), avg(MediumActiveMinutes), avg(SedentaryMinutes),
	count(*) as users
from dailyintensities_merged2
group by activityday;



















