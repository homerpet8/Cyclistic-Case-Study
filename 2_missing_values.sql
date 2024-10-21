 --Checking the data of missing or NULL values

SELECT col_name, null_count 
FROM(
  SELECT COUNT(*) - COUNT(ride_id) ride_id,
    COUNT(*) - COUNT(rideable_type) rideable_type,
    COUNT(*) - COUNT(started_at) started_at,
    COUNT(*) - COUNT(ended_at) ended_at,
    COUNT(*) - COUNT(start_station_name) start_station_name,
    COUNT(*) - COUNT(start_station_id) start_station_id,
    COUNT(*) - COUNT(end_station_name) end_station_name,
    COUNT(*) - COUNT(end_station_id) end_station_id,
    COUNT(*) - COUNT(start_lat) start_lat,
    COUNT(*) - COUNT(start_lng) start_lng,
    COUNT(*) - COUNT(end_lat) end_lat,
    COUNT(*) - COUNT(end_lng) end_lng,
    COUNT(*) - COUNT(member_casual) member_casual
  FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1
  ) AS null_count
UNPIVOT (null_count FOR col_name IN (ride_id, rideable_type, started_at, ended_at, 
  start_station_name, start_station_id, end_station_name, end_station_id, 
  start_lat, start_lng, end_lat, end_lng, member_casual))


--Deleting rows with NULL values (This process is optional. Only if NA values affect the data being analyzed)

SELECT *
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1
WHERE start_station_name IS NULL
