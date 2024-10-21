--Removing bad data (Big Query subscription account)

DELETE FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master
WHERE ride_length_min < 0

--This query removes the rows from the divvy_trips_2023_q1_master table


--Removing bad data (Big Query Sandbox account)

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean AS
SELECT *
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master
WHERE ride_length_min >= 0

--This query creates a new table divvy_trips_2023_q1_master_clean that excludes the rows with negative values. 

