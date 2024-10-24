# Cyclistic Case Study

### A Google Data Analytics Capstone Project

<br/>

**INTRODUCTION**

Cyclistic is a bikeshare company in Chicago. In 2016, it launched a successful bikeshare offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geo-tracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

It operates on a subscription-based model with pricing plan options for single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are called Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Marketing Director, Lily Moreno believes that maximizing the number of annual members will be key to the company’s future growth.

In order to do that, the team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

**SCENARIO**

You are a junior data analyst working in the marketing analyst team at Cyclistic. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

**EXCUTIVE SUMMARY**

This case study is a capstone project for the Google Data Analytics Professional Certification. It follows the six phases of the data analysis process: ASK, PREPARE, PROCESS, ANALYZE, SHARE, and ACT.

In this case study, we seek to understand the behavioral differences between the two user groups of Cyclistic Bikeshare: the casual riders and the annual members. Our task is to examine the historical bike trip data of Cyclistic, and to analyze usage patterns, behaviors, and preferences of the two customer groups. We apply data science techniques using SQL (BigQuery) to perform data cleaning, wrangling, and exploratory data analysis; and Tableau, to reveal patterns and insights.

The business goal of Cyclistic is to maximize the number of annual memberships. As annual members have been identified as more profitable to the company, converting casual riders into annual members is key to the company’s future growth. The company’s Marketing Director, Lily Moreno, has set a clear business objective: design marketing strategies aimed at converting casual riders into
annual members.

Our study is aimed at providing data-driven insights to tailor strategies that resonate with casual riders, addressing their needs and preferences, and ultimately, encouraging them to become annual members. We believe that understanding the riders' behavior could be instrumental in crafting an effective marketing strategy.

Our hope is that our work will play a vital role in shaping Cyclistic's future marketing strategies and contribute to its mission of inclusive, accessible, and profitable bike-sharing.

<br/>

### ASK

**STATEMENT OF THE PROBLEM**

To understand the differences in the usage patterns between casual riders and members of Cyclistic, in order to design a new marketing strategy aimed at converting casual riders into members.

The analysis will try to answer the following key questions:

- How do annual members and casual riders use Cyclistic bikes differently?
- What are the patterns or behaviors unique to casual riders that could potentially be addressed by a targeted marketing campaign?
- What are the trends over time for these two user groups? Are there seasonal patterns that could inform the timing of the marketing campaign?

**BUSINESS TASK**

To analyze Cyclistic's historical bike trip data and understand how casual riders and annual members use Cyclistic bikes differently and use these insights to design a new marketing strategy aimed at converting casual riders into annual members.

**KEY SATEKEHOLDERS**

- Lily Moreno: The director of marketing responsible for developing campaigns and initiatives to promote the bike-sharing program.
- Cyclistic Marketing Analytics Team: A team of data analysts responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
- Cyclistic's Executive Team: The detail-oriented executive team who will decide whether to approve the recommended marketing program.  

**ASSUMPTIONS**

We are working under the assumption that the provided data is accurate, up-to-date, and representative of the larger rider population. We also assume that the riders' behaviors are largely influenced by their status as casual riders or annual members, not by other unrecorded factors.

<br/>

### PREPARE

**DATA CONTEXT**

Our data, sourced from Cyclistic's historical trip records, covers a three-month worth of ride information, providing insights into the usage patterns of both casual riders and annual members. The key variables in our dataset include the start and end times of each trip, start and end station details, rideable type, and whether the rider is a casual user or an annual member.

**DATA LOCATION AND ORGANIZATION**

Cyclistic is a fictional company. The data used for this case study has been made available by Motivate International Inc. It represents the historical trip data of Divvy bicycle sharing service in Chicago. It is a public data that is available for download and use to explore how different customer types are using Cyclistic bikes. The data is in a structured format like a CSV file, with each row representing a bike trip and columns indicating bike type, start time, end time, start station, end station, and user type.

**DATA CREDIBILITY AND BIAS**

The data seems to be auto-generated from the infrastructure of the company that operates the bike-sharing service and hence reliable. However, we must take note that the data could contain biases based on operational constraints or data collection methods. For example, the data only includes people who have chosen to use the Cyclistic service and might not represent the entire population of bike riders in Chicago.

**LICENSING, PRIVACY, SECURITY, AND ACCESSIBILITY**

The data has been provided under a data license agreement, which permits its use for analysis but prohibits sharing the data as a standalone dataset. Privacy is preserved as no personally identifiable information is included in the data. Security will involve storing the downloaded data in a secure location, perhaps encrypted if needed. Accessibility refers to ensuring that the data and the subsequent analysis are available to all stakeholders involved in the project.

**DATA INTEGRITY**

The integrity of the date will be verified by performing exploratory data analysis (EDA) to identify any inconsistencies, missing values, outliers, or duplicate entries.

**RELEVANCE TO THE BUSINESS TASK**

The data contains information on bike trips by both casual riders and annual members, which is directly relevant to the business question of understanding how the two types of users utilize the Cyclistic bikes differently. By analyzing patterns and trends in the data, you can extract insights to inform a marketing strategy aimed at converting casual riders into annual members.

**POTENTIAL PROBLEMS**

Potential problems could include missing data, errors in the data, or bias in the data. The data might also lack certain information that could be useful for the analysis, such as demographic details of riders or specific reasons for choosing a casual ride vs. membership.

**KEY TASKS:**

- Download the data and store it appropriately.
- Load the data to BigQuery.
- Identify how it’s organized.
- Sort and filter the data.
- Determine the credibility of the data.  

<br/>

```SQL
--Combining the monthly tables to one quarter table

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1 AS (
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202301-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202302-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202303-divvy-tripdata`
  );
```
This query creates a table of 13 columns and 639,424 rows, containing the tripdata
for the first quarter of 2023.

<br/>

### PROCESS

**KEY TASKS:**

- Check the data for errors.
- Choose your tools.
- Transform the data so you can work with it effectively.
- Document the cleaning process.  

<br/>

```SQL
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
```

<br/>

<img width="621" alt="Missing_Values" src="https://github.com/user-attachments/assets/17e38f4c-85a2-4d52-b743-3901d2ef8242">

<br/> 
<br/>

COMMENTS ON CLEANING THE DATA:

As revealed, the missing values are in the columns; start_station_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng. These missing data may refer to the location of the riders and the distance of the rides. To recall, our task is to analyze “and understand how casual riders and annual members use Cyclistic bikes differently and use these insights to design a new marketing strategy aimed at converting casual riders into annual members”. We can proceed with cleaning the data but doing so may exclude some info on the behavioral patterns of the riders, approximately 14.5% of the data will be lost. Since our analysis will focus on the behavioral patterns of the riders such as, the classification of the riders whether members or casual riders, the length of the rides, peak days, and rideable type, we can probably forego cleaning the data of missing (NA) values and leave the dataset intact. Cleaning the data of NA values is only deemed necessary in this case if we will include in our analysis the demography of the riders and the distance of the rides.

<br/>

```SQL
--Adding the ride_length and day_of_week columns

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master AS
SELECT *, TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_sec, TIMESTAMP_DIFF(ended_at, started_at, SECOND)/60 AS ride_length_min, FORMAT_TIMESTAMP('%a', TIMESTAMP(started_at)) AS day_of_week, EXTRACT(DAYOFWEEK FROM TIMESTAMP(started_at)) AS day_of_week_num 
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1

--This query creates a table with four additional columns, namely: 
--ride_length_sec, ride_length_min, day_of_week, and day_of_week_num
```

<br/>

After converting and inspecting data, it was noticed that the column ride_length has some negative values, probably because start_time and end_time were swapped for these rides, or the system simply registered and recorded the rides incorrectly. So, rides with negative ride_length values must be excluded.

<br/>

```SQL
--Removing bad data (Big Query subscription account)

DELETE FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master
WHERE ride_length_min < 0

--This query removes the rows from the divvy_trips_2023_q1_master table
```

<br/>

```SQL
--Removing bad data (Big Query Sandbox account)

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean AS
SELECT *
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master
WHERE ride_length_min >= 0

--This query creates a new table divvy_trips_2023_q1_master_clean that excludes the rows with negative values. 
```

<br/>

### ANALYZE

**KEY TASKS:**

- Conduct descriptive analysis.
- Identify trends and relationships.

<br/>

```SQL
--Proportion of Rider Type

SELECT member_casual AS rider_type, COUNT(*) AS num_riders, 
  ((COUNT(*) / SUM(COUNT(*)) OVER ())*100) AS proportion
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/fb532acb-cba6-4268-a4f0-dc295be6a3d3">

<br/>
<br/>

```SQL
--Mean, Max, Min of ride_length

SELECT member_casual, ROUND(AVG(ride_length_min), 4) AS avg_ride_length,
  ROUND(MAX(ride_length_min), 4) AS max_ride_length,
  ROUND(MIN(ride_length_min), 4) AS min_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/9e813b65-d951-4cbd-998b-1a8743f129f7">

<br/>
<br/>

```SQL
--Count of rides per day of week

SELECT day_of_week, COUNT(ride_id) AS number_of_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY day_of_week, day_of_week_num
ORDER BY day_of_week_num
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/db863aa4-49b4-40f0-822e-798cb291eee2">

<br/>
<br/>

```SQL
--Average ride_length per day_of_week

SELECT day_of_week, ROUND(AVG(ride_length_min), 4) AS avg_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY day_of_week, day_of_week_num
ORDER BY day_of_week_num
```

<br/> 

<img width="468" alt="image" src="https://github.com/user-attachments/assets/9f46603f-57b3-41f4-b71e-6106f78434f9">

<br/>
<br/>

```SQL
--Count of rides by per day of week by rider_type

SELECT member_casual, day_of_week, COUNT(ride_id) AS number_of_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual, day_of_week, day_of_week_num
ORDER BY member_casual, day_of_week_num
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/c3905de5-4753-40a3-96fc-a14531d10ca2">

<br/>
<br/>

```SQL
--Average ride_length per day of week by rider_type

SELECT member_casual, day_of_week, ROUND(AVG(ride_length_min), 4) AS avg_ride_length
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY member_casual, day_of_week, day_of_week_num
ORDER BY member_casual, day_of_week_num
```

<br/>
 
<img width="468" alt="image" src="https://github.com/user-attachments/assets/ae0fe085-b2eb-4570-aef6-6f9bec646c39">

<br/>
<br/>

```SQL
--Proportion of Bike Type

SELECT rideable_type, COUNT(*) AS num_rides, 
  ROUND(((COUNT(*) / SUM(COUNT(*)) OVER ())*100), 2) AS proportion
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY rideable_type
ORDER BY proportion DESC
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/e503bca4-b185-4d6b-931d-f3a425043e96">

<br/>
<br/>

```SQL
--Bike Usage Preference By Rider Type

SELECT member_casual, rideable_type, COUNT(*) AS num_rides
FROM fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1_master_clean
GROUP BY rideable_type, member_casual
ORDER BY member_casual 
```

<br/>

<img width="468" alt="image" src="https://github.com/user-attachments/assets/56f7c1a3-8918-45e8-9648-785aeb331137">

<br/>
<br/>

### SHARE

For additional insights, please check my [Tableau Public Dashboard](https://public.tableau.com/views/Cyclistic_17285654688300/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).
<br/>
Another version can also be found in my [Looker Studio Dashboard](https://lookerstudio.google.com/s/vjkK170-95w).
<br/>
...and another in my [Power BI Dashboard](https://app.powerbi.com/links/QeooPDKKA7?ctid=48ef51c9-8211-4b4f-8986-7b185d527f71&pbi_source=linkShare).

<br/>

**Proportion of Rider Type**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/a8bfbefc-0139-4a83-aae1-22e562641ba3">

The chart indicates that more than half of all riders are member riders.

<br/>

**Number of Rides Per Day of Week**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/80c316d2-8ab5-46e2-9d9c-754ca2ba8e21">

The chart shows that most rides were started on Tuesday (113,112), Wednesday (107,569) followed by Thursday (95,546).

<br/>

**Average Ride Length per Day of Week**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/0bc2621f-5ebd-4dee-9fec-dae149c33100">

The chart shows that riders rent bikes for longer duration during weekends.

<br/>

**Number of Rides per Day of Week By Rider Type**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/a40c6a6b-f060-4f42-8e38-c4f1e2a5f3e5">

The chart shows that member riders have higher number of rides compared to casual riders on any day of the week, and they use the bikes more often on weekdays probably during workdays.

<br/>

**Average Ride Length per Day of Week By Rider Type**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/37b22869-9b00-43c1-8e67-bb9e71ea3918">

In contrast, casual riders take longer rides than member riders. The chart demonstrates that casual riders rent bikes for longer durations, especially on Saturday and Sunday probably for leisure. Members show a steady riding behavior, while they also tend to ride a little longer on weekends.

<br/>

**Proportion of Bike Type**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/d2b2819b-d251-446a-9ce7-b028e17d5a1b">

The plot shows that more than half of the bikes used are electric bikes.

<br/>

**Bike  Usage Preference By Rider Type**

<img width="468" alt="image" src="https://github.com/user-attachments/assets/43fdd52f-5a0a-4bfe-b26f-3aabc5d10813">

The charts show that no members are using the docked bike.  It's only popular to casual riders, but still the least popular among the three bike types.

<br/>


### ACT

**FINDINGS**

1.	Members use the bikes more often during weekdays while casual riders use the bikes more often during weekends, an indication that members use the bikes to commute for work or school while casual riders use them for leisure.
2.	Average ride times are longer during weekends, influenced by the riding behavior of the casual riders who take longer rides during weekends. Member riders, however, show a relatively steady ride length pattern throughout the week.
3.	Members take relatively shorter rides compared to casual riders. Average ride length for member riders  is 10.50 mins with a maximum ride length of 1560 mins, while the average ride length for casual riders is 22.35 mins with a maximum ride length of 33,604 mins.
4.	The docked bikes are the least popular among the types of bikes available and none of the member riders use them, only casual riders.

<br/>

**RECOMMENDATION**

1.	Create a membership package to categorize riders into three groups: Leisure Riders – people who use the bikes for leisure activities, Student – people who use the bikes for school, and Business Riders – people who use the bikes for work.
2.	Since casual riders take longer rides, create a reward system to convert casual riders to members using their minutes or kilometers earned.
3.	As casual riders’ usage rate is high during weekends, create a marketing campaign that include a weekend only membership.
4.	Organize member-exclusive events such as group rides, urban exploration challenges, or themed cycling events. This approach not only encourages more rides from current members but also entices casual riders to join as members to participate in these unique experiences.
5.	Launch seasonal campaigns by offering limited-time discounts, special weekday offers, or extended ride durations for members, to help in making the service more sustainable and manageable.
6.	Utilize social media platforms to engage with both casual riders and potential members. Share success stories and testimonials from Cyclistic members who have benefited from the membership. Create visually appealing content showcasing the joy of cycling during different seasons and scenarios, enticing casual riders to become members.


