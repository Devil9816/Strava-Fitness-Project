select *
from heartrate_seconds_merged;

select count(*)
from heartrate_seconds_merged;

-- this took around 25-30 min simply to load 1.2 lakhs rows out of 24lakh, we won't work on high rows dataset on sql for this project  
