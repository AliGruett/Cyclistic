--IMPORT DATA

--Append all tables by using UNION ALL.

SELECT *
FROM `my-data-project-381018.cyclistic.May_2022` 

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.June_2022_1`

 UNION ALL

SELECT * 
FROM `my-data-project-381018.cyclistic.June_2022_2` 
 
 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.July_2022_1` 

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.July_2022_2` 

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Aug_2022_1`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Aug_2022_2` 
 
 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Sep_2022_1`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Sep_2022_2`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Oct_2022_1`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Oct_2022_2`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Nov_2022_1`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Nov_2022_2` 

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Dec_2022`
 
 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Jan_2023` 

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Feb_2023`  

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Mar_2023`

 UNION ALL

SELECT *
FROM `my-data-project-381018.cyclistic.Apr_2023` ;

--Count # of rows in new data set created.
SELECT COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`;



--PREPARE AND CLEAN DATA

--Finding the minimum and maximum values of latitude and longitude values to ensure they make sense (latitudes should be -90 to 90 and longitudes -180 to 180)
SELECT
 MIN(start_lng) AS MinStartLng,
 MAX(start_lng) AS MaxStartLng,
 MIN(start_lat) AS MinStartLat, 
 MAX(start_lat) AS MaxStartLat
FROM `my-data-project-381018.cyclistic.May22_Apr23`;

SELECT  
 MIN(end_lng) AS MinEndLng,
 MAX(end_lng) AS MaxEndLng, 
 MIN(end_lat) AS MinEndLat, 
 MAX(end_lat) AS MaxEndLat
FROM `my-data-project-381018.cyclistic.May22_Apr23`;
--The max end_lng and min end_lat are shown as 0

--Determine how many instances there are where they are equal to 0
SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 end_lng = 0;
--8 instances

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 end_lat=0;
--8 instances

--Viewing the max start and end dates to ensure they are within the Mauy 2022-April 2023 timeframe
SELECT 
 MIN(started_at) AS MinStartedAt, 
 MAX(started_at) AS MaxStartedAt, 
 MIN(ended_at) AS MinEndedAt, 
 MAX(ended_at) AS MaxEndedAt
FROM `my-data-project-381018.cyclistic.May22_Apr23`;
--This looks ok

--Are there any start and end stations that have multiple latitude and longitude values? If so, what is the range.
SELECT 
 start_station_name, 
 COUNT(distinct start_lat) AS num_of_distinct_values, 
 MIN(start_lat) AS min, 
 MAX(start_lat) AS max, 
 MAX(start_lat)-MIN(start_lat) AS difference
FROM `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
 start_station_name
ORDER BY 
 difference DESC;

SELECT 
 end_station_name, 
 COUNT(distinct end_lat) AS num_of_distinct_values, 
 MIN(end_lat) AS min, 
 MAX(end_lat) AS max, 
 MAX(end_lat)-MIN(end_lat) AS difference
FROM `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
 end_station_name
ORDER BY 
difference DESC;

SELECT 
 start_station_name, 
 COUNT(distinct start_lng) AS num_of_distinct_values, 
 MIN(start_lng) AS min, 
 MAX(start_lng) AS max, 
 MAX(start_lng)-MIN(start_lng) AS difference
FROM `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
  start_station_name
ORDER BY 
 difference DESC;

SELECT 
  end_station_name, 
  COUNT(distinct end_lng) AS num_of_distinct_values, 
  MIN(end_lng) AS min, 
  MAX(end_lng) AS max, 
  MAX(end_lng)-MIN(end_lng) AS difference
FROM `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
  end_station_name
ORDER BY 
  difference DESC;
--there are a lot of null values for start and end station names. The range between the min and max latitude and longitude values doesn't appear to be too large.

--Are all ride_id's distinct? Compare total number of rides to total number of distinct ride ids.
SELECT 
  COUNT(ride_id)
FROM `my-data-project-381018.cyclistic.May22_Apr23`;

SELECT 
 COUNT(distinct ride_id)
FROM `my-data-project-381018.cyclistic.May22_Apr23`;
--there are 8 duplicate ride ids

SELECT 
 ride_id, 
 COUNT(*) AS num_rides
FROM `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
 ride_id
HAVING 
 num_rides>1
ORDER BY 
 num_rides DESC;

--determine what may be the cause of the errors.
SELECT *
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 ride_id='9.68806E+15'OR 
 ride_id='2.98E+61' OR 
 ride_id='8.95515E+15' OR 
 ride_id='5.63E+14' OR 
 ride_id='1.28E+18' OR 
 ride_id='3.58317E+15' OR 
 ride_id='3.58317E+15' OR 
 ride_id='5.41E+19'
ORDER BY ride_id;
--The duplicates appear to be 2 completely different rides for all duplicate ride_ids.

--View the distinct values and their frequencies in the member_casual and rideable_type column. Make sure there are no errors with data entry for these two columns.
SELECT 
 member_casual, 
 COUNT(*)
FROM  `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
 member_casual 
ORDER BY 
 2 DESC;

SELECT 
 rideable_type, 
 COUNT(*) 
FROM  `my-data-project-381018.cyclistic.May22_Apr23`
GROUP BY 
 rideable_type 
ORDER BY 
 2 DESC;
--looks good

--Based on the above analysis, the null values for the start and end station names should be taken out. A new dataset will be created.
SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 start_station_name IS NULL;
--435,155

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 end_station_name IS NULL;
--492,807

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 start_station_id IS NULL;
--435,287

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 end_station_id IS NULL;
--492,948

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 start_station_name IS NULL AND
 start_station_id IS NULL;
--435,155

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 start_station_name IS NULL OR 
 start_station_id IS NULL;
--435,287

--There are more instances where the station_id is NULL than the station_name. In most cases both the station_name and station_id will be NULL at the same time. I would like to use the station_names rather than id's in my analysis so I will only remove rows where the the station_name is NULL regardless of whether the station_id is NULL.
SELECT *
FROM `my-data-project-381018.cyclistic.May22_Apr23`
WHERE 
 start_station_name IS NOT NULL AND
 end_station_name IS NOT NULL;

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23_v2`;
--there are 4,534,245 rows in this new dataset compared to the 5,859,061 rows in the original set

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23_v2`
WHERE 
 start_station_name IS NULL;

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23_v2`
WHERE 
 end_station_name IS NULL;

SELECT 
 COUNT(*)
FROM `my-data-project-381018.cyclistic.May22_Apr23_v2`
WHERE 
 end_station_id IS NULL OR
 start_station_id IS NULL;
--checked for both start and end stations and there are no NULLs. There are 246 rows where either the end_station_id is NULL or start_station_id is NULL

--create new columns
SELECT *,
 CAST(started_at AS date) AS start_date,
 CAST(started_at AS time) AS start_time,
 CAST(ended_at AS date) AS end_date,
 CAST(ended_at AS time) AS end_time
FROM `my-data-project-381018.cyclistic.May22_Apr23_v2`;
--save as new v3 of data

SELECT *,
 EXTRACT(day FROM start_date) AS day,
 EXTRACT(month FROM start_date) AS month,
 EXTRACT(year FROM start_date) as year,
 EXTRACT(hour FROM start_time) as hour,
 EXTRACT(dayofweek FROM start_date) AS dayofweek,
 CONCAT(start_station_name, ", ",end_station_name) as start_end,
 TIMESTAMP_DIFF(ended_at, started_at,MINUTE) AS trip_duration
FROM `my-data-project-381018.cyclistic.May22_Apr23_v3`;
--save as new v4 of data



--ANALYZE DATA

--Average trip duration between members and casual riders
SELECT 
 member_casual, 
 month, 
 avg(trip_duration) AS Avg_Duration
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 member_casual, 
 month
ORDER BY 
 month;

SELECT 
 member_casual, 
 hour, 
 avg(trip_duration) AS Avg_Duration
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 member_casual, 
 hour
ORDER BY 
 hour;

SELECT 
 member_casual, 
 dayofweek, 
 avg(trip_duration) AS Avg_Duration
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 member_casual, 
 dayofweek
ORDER BY 
 dayofweek;

--Top 10 most popular start and end stations by rider type
SELECT 
 start_station_name, 
 start_station_id,
 member_casual, 
 COUNT(*) AS rides
FROM`my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 start_station_id, 
 start_station_name, 
 member_casual
ORDER BY 
 rides DESC
LIMIT 
 10;

SELECT 
 end_station_id,
 end_station_name,
 member_casual, 
 COUNT(*) AS rides
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 end_station_id, 
 end_station_name,
 member_casual
ORDER BY 
 rides DESC
LIMIT 10;

--Round trips
--Create new table so can map the most common round trip locations 
SELECT 
 end_station_name, 
 start_station_name, 
 member_casual, 
 dayofweek, 
 ROUND(start_lat,3) AS round_start_lat, 
 ROUND(start_lng,3) AS round_start_lng, 
 COUNT(*) AS num_rides,
 (CASE
   WHEN start_station_name="Streeter Dr & Grand Ave" THEN "Attraction"
   WHEN start_station_name="Michigan Ave & Oak St" THEN "Attraction"
   WHEN start_station_name="DuSable Lake Shore Dr & North Blvd" THEN "Attraction"
   WHEN start_station_name="Theater on the Lake" THEN "Attraction"
   WHEN start_station_name="DuSable Lake Shore Dr & Diversey Pkwy" THEN "Attraction"
   WHEN start_station_name="Indiana Ave & Roosevelt Rd" THEN "Attraction"
   WHEN start_station_name="DuSable Lake Shore Dr & Monroe St" THEN "Attraction"
   WHEN start_station_name="Millennium Park" THEN "Attraction"
   WHEN start_station_name="Montrose Harbor" THEN "Attraction"
   WHEN start_station_name="Shedd Aquarium" THEN "Attraction"
   WHEN start_station_name="Dusable Harbor" THEN "Attraction"
   WHEN start_station_name="Adler Planetarium" THEN "Attraction"
   WHEN start_station_name="Michigan Ave & 8th St" THEN "Attraction"
   WHEN start_station_name="Buckingham Fountain" THEN "Attraction"
   WHEN start_station_name="Fort Dearborn Dr & 31st St" THEN "Attraction"
   WHEN start_station_name="Loomis St & Lexington St" THEN "University"
   WHEN start_station_name="University Ave & 57th St" THEN "University"
   WHEN start_station_name="State St & 33rd St" THEN "University"
   WHEN start_station_name="Ellis Ave & 60th St" THEN "University"
   WHEN start_station_name="State St & Chicago Ave" THEN "University"
   WHEN start_station_name="Morgan St & Polk St" THEN "University"
   WHEN start_station_name="Clark St & Elm St" THEN "Business/Housing"
   WHEN start_station_name="Broadway & Barry Ave" THEN "Business/Housing"
   WHEN start_station_name="McClurg Ct & Ohio St" THEN "Business/Housing"
   ELSE "none"
  END)
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
WHERE 
 start_station_name=end_station_name
GROUP BY 
 start_station_name, 
 end_station_name, 
 member_casual, 
 dayofweek, 
 round_start_lat, 
 round_start_lng
ORDER BY 
 num_rides DESC;

--Create new table so can graph by weekday
SELECT 
 end_station_name, 
 start_station_name,
 member_casual, 
 dayofweek, 
 ROUND(start_lat,3) AS round_start_lat, 
 ROUND(start_lng,3) AS round_start_lng, 
 COUNT(*) AS num_rides
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
WHERE 
 start_station_name=end_station_name
GROUP BY 
 start_station_name, 
 end_station_name, 
 member_casual,
 dayofweek, 
 round_start_lat, 
 round_start_lng
ORDER BY 
 num_rides DESC;

SELECT 
 member_casual,
 COUNT(CASE WHEN start_station_name=end_station_name THEN member_casual END) as num_roundtrips,
 COUNT(*) AS total_num_trips
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 member_casual;

SELECT 
 member_casual, count(*)
FROM`my-data-project-381018.cyclistic.May22_Apr23_v4`
WHERE 
 start_station_name=end_station_name
GROUP BY 
 member_casual;

--Number of trips and average trip duration by rider type and bike type
SELECT 
 member_casual, 
 rideable_type,
 COUNT(ride_id) AS number_of_rides, 
 AVG(trip_duration) AS avg_trip_duration
FROM `my-data-project-381018.cyclistic.May22_Apr23_v4`
GROUP BY 
 rideable_type,
 member_casual
ORDER BY 
 avg_trip_duration DESC;
