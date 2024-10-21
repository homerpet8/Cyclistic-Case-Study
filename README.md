# Cyclistic Case Study

### A Google Data Analytics Capstone Project

**INTRODUCTION**

Cyclistic is a bikeshare company in Chicago. In 2016, it launched a successful bikeshare offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geo-tracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

It operates on a subscription-based model with pricing plan options for single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are called Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Marketing Director, Lily Moreno believes that maximizing the number of annual members will be key to the company’s future growth.

In order to do that, the team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

**SCENARIO**

You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

**EXCUTIVE SUMMARY**

This case study is a capstone project for the Google Data Analytics Professional Certification. It follows the six phases of the data analysis process: ASK, PREPARE, PROCESS, ANALYZE, SHARE, and ACT.

In this case study, we seek to understand the behavioral differences between two user groups of Cyclistic Bikeshare: the casual riders and the annual members. Our task is to examine the historical bike trip data of Cyclistic, and to analyze usage patterns, behaviors, and preferences of the two customer groups. We apply data science techniques including data cleaning and wrangling, exploratory data analysis, and visualization, using R, to reveal patterns and insights.

The business goal of Cyclistic is to maximize the number of annual memberships. As annual members have been identified as more profitable to the company, converting casual riders into annual members is key to the company’s future growth. The company’s Marketing Director, Lily Moreno, has set a clear business objective: design marketing strategies aimed at converting casual riders into
annual members.

Our study is aimed at providing data-driven insights to tailor strategies that resonate with casual riders, addressing their needs and preferences, and ultimately, encouraging them to become annual members. We believe that understanding these riders' behavior could be instrumental in crafting an effective marketing strategy.

Our hope is that our work will play a vital role in shaping Cyclistic's future marketing strategies and contribute to its mission of inclusive, accessible, and profitable bike-sharing

### ASK

**STATEMENT OF THE PROBLEM**

To understand the differences in the usage patterns between casual riders and members of Cyclistic, in order to design a new marketing strategy aimed at converting casual riders into members.

The analysis will try to answer the following key questions:

• How do annual members and casual riders use Cyclistic bikes differently?
• What are the patterns or behaviors unique to casual riders that could potentially be addressed by a targeted marketing campaign?
• What are the trends over time for these two user groups? Are there seasonal patterns that could inform the timing of the marketing campaign?

**BUSINESS TASK**

To analyze Cyclistic's historical bike trip data and understand how casual riders and annual members use Cyclistic bikes differently and use these insights to design a new marketing strategy aimed at converting casual riders into annual members.

**KEY SATEKEHOLDERS**

• Lily Moreno: The director of marketing who is responsible for developing campaigns and initiatives to promote the bike-sharing program.
• Cyclistic Marketing Analytics Team: A team of data analysts responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
• Cyclistic's Executive Team: The notoriously detail-oriented executive team who will decide whether to approve the recommended marketing program.

**ASSUMPTIONS**

We are working under the assumption that the provided data is accurate, up-to-date, and representative of the larger rider population. We also assume that the riders' behaviors are largely influenced by their status as casual riders or annual members, not by other unrecorded factors.

### PREPARE

**DATA CONTEXT**

Our data, sourced from Cyclistic's historical trip records, covers a three-month worth of ride information, providing insights into the usage patterns of both casual riders and annual members. The key variables in our dataset include the start and end times of each trip, start and end station details, rideable type, and whether the rider is a casual user or an annual member.

**DATA LOCATION AND ORGANIZATION**

The data used for this case study has been made available by Motivate International Inc. It represents the historical trip data of Cyclistic bikes. It is a public data that is available for download and use to explore how different customer types are using Cyclistic bikes. The data is in a structured format like a CSV file, with each row representing a bike trip and columns indicating bike type, start time, end time, start station, end station, and user type.

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

• Download data and store it appropriately.

• Identify how it’s organized.

• Sort and filter the data.

• Determine the credibility of the data.


```
--combining the monthly tables to one quarter table

CREATE TABLE fluted-expanse-414509.Cyclistic.divvy_trips_2023_q1 AS (
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202301-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202302-divvy-tripdata`
  UNION ALL
  SELECT * FROM `fluted-expanse-414509.Cyclistic.202303-divvy-tripdata`
  );
```


**PROCESS**

**KEY TASKS:**

•	Check the data for errors.

•	Choose your tools.

•	Transform the data so you can work with it effectively.

•	Document the cleaning process.


```
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


Result:



COMMENTS ON CLEANING THE DATA:

As revealed, the missing values are in the columns; start_station_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng. These missing data may refer to the location of the riders and the distance of the rides. To recall, our task is to analyze “and understand how casual riders and annual members use Cyclistic bikes differently and use these insights to design a new marketing strategy aimed at converting casual riders into annual members”. We can proceed with cleaning the data but doing so may exclude some info on the behavioral patterns of the riders, approximately 14.5% of the data will be lost. Since our analysis will focus on the behavioral patterns of the riders such as, the classification of the riders whether members or casual riders, the length of the rides, peak days, and rideable type, we can probably forego cleaning the data of missing (NA) values and leave the dataset intact. Cleaning the data of NA values is only deemed necessary in this case if we will include in our analysis the demography of the riders and the distance of the rides.



