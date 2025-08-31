select *
from dailyactivity_merged;

-- lets see the differences between totaldistance and trackerdistance
select TotalDistance, TrackerDistance, (TotalDistance - TrackerDistance) as diff
from dailyactivity_merged
order by diff desc;

select count(*)
from dailyactivity_merged;

select min(TotalDistance - TrackerDistance) as diff
from dailyactivity_merged;

select TotalDistance, TrackerDistance
from dailyactivity_merged
where TotalDistance != TrackerDistance;

select  totaldistance, TrackerDistance
from dailyactivity_merged
where TotalDistance != TrackerDistance;

select count(*)
from dailyactivity_merged;

SELECT COUNT(DISTINCT Id) FROM dailyactivity_merged;

-- we found that there was ~98.4% match from pandas, but here is 100% lets try to understand this
-- error was due to incorrect loading of csv into sql; i had to change the datatype of Id to double while import to fix this.

select count(*)
from dailyactivity_merged;

select TotalDistance, TrackerDistance, (TotalDistance - TrackerDistance) as diff
from dailyactivity_merged
where (TotalDistance - TrackerDistance) != 0
order by diff desc;

-- this behaviour matches with our pandas analysis

select count(loggedactivitiesdistance) as num
from dailyactivity_merged
where LoggedActivitiesDistance != 0;
-- only 32/940 rows are non zero; we will be dropping this

select *
from dailyactivity_merged;

select id, 
	activitydate, 
	totalsteps, totalDistance, 
	veryactivedistance, (moderatelyactivedistance + lightactivedistance) as mediumactivedistance, sedentaryactivedistance,
    veryactiveminutes, (fairlyactiveminutes + lightlyactiveminutes) as mediumactiveminutes,sedentaryminutes,
    calories
from dailyactivity_merged;




CREATE TABLE `dailyactivity_merged2` (
  `Id` double DEFAULT NULL,
  `ActivityDate` text,
  `TotalSteps` int DEFAULT NULL,
  `TotalDistance` double DEFAULT NULL,
  `VeryActiveDistance` double DEFAULT NULL,
  `MediumActiveDistance` double DEFAULT NULL,
  `SedentaryActiveDistance` int DEFAULT NULL,
  `VeryActiveMinutes` int DEFAULT NULL,
  `MediumActiveMinutes` int DEFAULT NULL,
  `SedentaryMinutes` int DEFAULT NULL,
  `Calories` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from dailyactivity_merged2;

insert into dailyactivity_merged2
select id, 
	activitydate, 
	totalsteps, totalDistance, 
	veryactivedistance, (moderatelyactivedistance + lightactivedistance) as mediumactivedistance, sedentaryactivedistance,
    veryactiveminutes, (fairlyactiveminutes + lightlyactiveminutes) as mediumactiveminutes,sedentaryminutes,
    calories
from dailyactivity_merged;


-- now we will change the date format and data type from text to date ... then we are good to go... 

select *
from dailyactivity_merged2;

select ActivityDate, str_to_date(activitydate, '%m/%d/%Y')
from dailyactivity_merged2;

update dailyactivity_merged2
set activitydate = str_to_date(activitydate, '%m/%d/%Y');

select ActivityDate
from dailyactivity_merged2;

-- now we need to change the data type

alter table dailyactivity_merged2
modify column activitydate date;

--  lets perform some analysis over this dataset

select *
from dailyactivity_merged2;

select id, sum(totalsteps) as total
from dailyactivity_merged2
group by id
order by total desc;


select *
from dailyactivity_merged2;


-- don't do randomly think through what u are doing

-- 1. Give me total steps counts trend per day ... I want to understand if our device has helped the users for walk more ...
-- 2. Do the same... avg total calories per day....



select activitydate, sum(totalsteps), count(*) as users
from dailyactivity_merged2
group by activitydate;


-- the number of users have decreased from 33(2016-04-12) to 24(2016-05-11)
-- lets me do the same for calories

select activitydate, avg(totalsteps), avg(Calories), count(*) as users
from dailyactivity_merged2
group by activitydate;

-- using avg is a better indicator here...

select activitydate, avg(VeryActiveDistance), avg(MediumActiveDistance), avg(SedentaryActiveDistance),
	avg(VeryActiveMinutes), avg(MediumActiveMinutes), avg(SedentaryMinutes),
	count(*) as users
from dailyactivity_merged2
group by activitydate;


































