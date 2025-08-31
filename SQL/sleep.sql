select *
from sleepday_merged;

select *
from sleepday_merged
where totalsleeprecords > 2;
-- only 3 rows 

-- I am mostly interested in totalminutesasleep rather than totalsleeprecords, which might be no. of times  users slept assuming he recorded it or it was recorded alter
-- here i feeling the need for the guy who prepared the dataset


select id, sleepday,
	str_to_date(sleepday, '%m/%d/%Y %r') as fulldate
from sleepday_merged;

-- if we look closely we will see that, all the rows have same time; and what time data was collected in not relevant to our use case so lets pick only date here.
select id,
	date(str_to_date(sleepday, '%m/%d/%Y %r')) as fulldate, Totalminutesasleep
from sleepday_merged;

CREATE TABLE `sleepday_merged2` (
  `Id` double DEFAULT NULL,
  `Fulldate` date,  
  `TotalMinutesAsleep` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into sleepday_merged2
select id,
	date(str_to_date(sleepday, '%m/%d/%Y %r')) as fulldate, Totalminutesasleep
from sleepday_merged;


select * 
from sleepday_merged2;

-- we have cleaned data , we can now move to eda
-- but it would be better if we have sleep time in hours

-- our table as totalminutesasleep as int ...we should change it 
alter table sleepday_merged2
modify column TotalMinutesAsleep double;

select TotalMinutesAsleep, round((TotalMinutesAsleep*1.0/60),2) as totalsleephrs
from sleepday_merged2;

update sleepday_merged2
set totalminutesasleep = round((TotalMinutesAsleep*1.0/60),2);

select * 
from sleepday_merged2;

-- changing the column name 
ALTER TABLE sleepday_merged2
RENAME COLUMN TotalMinutesAsleep TO totalsleephrs;

select count(distinct id)
from sleepday_merged2;
-- we have 24 users

select * 
from sleepday_merged2
order by 1,3 desc;

-- lets try to understand if using our device has actually helped the user to sleep better
select *,
	row_number() over (partition by id order by fulldate) as rn_asc,
    row_number() over (partition by id order by fulldate desc) as rn_desc
from sleepday_merged2;

select *
from sleepday_merged2
where id = 2320127002;
-- this user has only one row, so we can't calculate the average; also for other users no of dates present is quite varying

select id, count(fulldate)
from sleepday_merged2
group by id;

-- i was planning to do an avg for first 15 days and last 15 days and compare them, but we can't proceed here like this.
 



















