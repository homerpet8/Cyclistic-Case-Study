--Combining the monthly tables to one quarter table

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1 AS (
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202301-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202302-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202303-divvy-tripdata`
  );