--Adding the ride_length and day_of_week columns

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master AS
SELECT *, TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_sec, TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60 AS ride_length_min, FORMAT_TIMESTAMP('%a', TIMESTAMP(started_at)) AS day_of_week, EXTRACT(DAYOFWEEK FROM TIMESTAMP(started_at)) AS day_of_week_num 
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1

--This query creates a table with four additional columns, namely: 
--ride_length_sec, ride_length_min, day_of_week, and day_of_week_num
