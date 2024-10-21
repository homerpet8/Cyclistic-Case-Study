--Descriptive analysis 


--Proportion of Rider Type

SELECT member_casual AS rider_type, COUNT(*) AS num_riders, 
  ((COUNT(*) / SUM(COUNT(*)) OVER ())*100) AS proportion
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual


--Mean, Max, Min of ride_length

SELECT member_casual, ROUND(AVG(ride_length_min), 4) AS avg_ride_length,
  ROUND(MAX(ride_length_min), 4) AS max_ride_length,
  ROUND(MIN(ride_length_min), 4) AS min_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual


--Count of rides per day of week

SELECT day_of_week, COUNT(ride_id) AS number_of_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY day_of_week, day_of_week_num
ORDER BY day_of_week_num


--Average ride_length per day_of_week

SELECT day_of_week, ROUND(AVG(ride_length_min), 4) AS avg_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY day_of_week, day_of_week_num
ORDER BY day_of_week_num


--Count of rides by per day of week by member_type

SELECT member_casual, day_of_week, COUNT(ride_id) AS number_of_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual, day_of_week, day_of_week_num
ORDER BY member_casual, day_of_week_num


--Average ride_length per day of week by member_type

SELECT member_casual, day_of_week, ROUND(AVG(ride_length_min), 4) AS avg_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual, day_of_week, day_of_week_num
ORDER BY member_casual, day_of_week_num


--Proportion of Bike Type

SELECT rideable_type, COUNT(*) AS num_rides, 
  ROUND(((COUNT(*) / SUM(COUNT(*)) OVER ())*100), 2) AS proportion
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY rideable_type
ORDER BY proportion DESC


--Bike Usage Preference By Rider Type

SELECT member_casual, rideable_type, COUNT(*) AS num_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY rideable_type, member_casual
ORDER BY member_casual DESC

