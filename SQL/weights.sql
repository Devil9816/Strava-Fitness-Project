select *
from weightloginfo_merged;

-- lets perform a bit of cleaning operations

select count(*), count(distinct fat)
from weightloginfo_merged;

select count(fat) 
from weightloginfo_merged
where fat='';
-- we have 65/67 empty values in fat

select *
from weightloginfo_merged;

-- lets confirm weightpounds is a simple factor of weight kg since we know 1 kg is 2.20462 pounds

select weightkg, (2.20462* weightkg) as weightnew , weightpounds, (WeightPounds-(2.20462* weightkg)) as diff
from weightloginfo_merged;

select max(WeightPounds-(2.20462* weightkg)) as diff
from weightloginfo_merged;
-- this 10e-4 order so, we actually don't need weightpounds column

select *
from weightloginfo_merged;

-- ismanual report and logId also not choices of interest for our analysis 
-- lets move towards date,it is in text format do we actually need the exact time of weight measurement ... actually it is asked to measure our weight at same
-- time of day so we won't touch this, but we need to clean this, date and time in one column does not looks good

-- we can't use substring to extract date, because of varying size, regex should work well here....

select `date`, 
	str_to_date(`date`, '%m/%d/%Y %r') as fulldate,
    date(str_to_date(`date`, '%m/%d/%Y %r')) as dateonly,
    time(str_to_date(`date`, '%m/%d/%Y %r')) as timeonly    
from weightloginfo_merged;

select *
from weightloginfo_merged;

select id, 
	str_to_date(`date`, '%m/%d/%Y %r') as fulldate,
    date(str_to_date(`date`, '%m/%d/%Y %r')) as dateonly,
    time(str_to_date(`date`, '%m/%d/%Y %r')) as timeonly,
    weightkg, bmi
from weightloginfo_merged;


CREATE TABLE `weightloginfo_merged2` (
  `Id` double DEFAULT NULL,
  `FullDate` text,
  `DateOnly` date,
  `TimeOnly` time,
  `WeightKg` double DEFAULT NULL,
  `BMI` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from weightloginfo_merged2;

insert into weightloginfo_merged2
select id, 
	str_to_date(`date`, '%m/%d/%Y %r') as fulldate,
    date(str_to_date(`date`, '%m/%d/%Y %r')) as dateonly,
    time(str_to_date(`date`, '%m/%d/%Y %r')) as timeonly,
    weightkg, bmi
from weightloginfo_merged;

select *
from weightloginfo_merged2;

-- Now lets save this data and move to EDA

select id, dateonly, WeightKg , bmi
from weightloginfo_merged2
order by id , dateonly desc;

select id, max(WeightKg) as maxi, min(WeightKg) as mini, ( max(WeightKg) - min(WeightKg) ) as diff
from weightloginfo_merged2 
group by id;

select id, ( max(WeightKg) - min(WeightKg) ) as diff
from weightloginfo_merged2 
group by id
order by 2 desc;

-- highest weight difference is 1.8 kg... this is same as what we got from pandas 

select *
from weightloginfo_merged2 ;

-- lets work on bmi; i wish to see the users who went from overweight to normal
select id , 
	case 
		when bmi >= 25 then 'overweight'
        else 'normal'
	end as weightcategory
from weightloginfo_merged2
order by 1, 2 desc ;

select id, 
	case 
		when bmi >= 25 then 'overweight'
        else 'normal'
	end as weightcategory
from weightloginfo_merged2
group by id, weightcategory
order by 1, 2 desc ;

-- we found no change in weight/ bmi category






































