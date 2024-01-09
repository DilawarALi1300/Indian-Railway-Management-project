
## **Indian Trains Schedule and Information System :**

## **Description:**

The Indian Train Schedule and Information System is a comprehensive database project designed to manage and analyze information related to train schedules, stations, and details about various trains. This project is particularly useful for railway systems, allowing them to efficiently organize and retrieve essential information for both operational and analytical purposes
## Data Base Used : 
[1:Train_info](https://github.com/DilawarALi1300/Indian-Railway-Management-project/blob/main/train_info.csv) : Contains information about trains, including train number, name, source station, and destination station.

[2:Train_schedule](https://github.com/DilawarALi1300/Indian-Railway-Management-project/blob/main/train_schedule.csv):Stores details about the schedule for each train, including arrival and departure times, distances, and days of operation.

## **Tools Used :** 
MySQL

## Queries and Analysis

A series of SQL queries have been developed to perform various analyses on the Indian Railways database. The queries cover aspects such as total trains, average distances, travel times, common routes, and more. These analyses provide valuable insights into the functioning of the railway system.

## Questions Explored

1.  **Total number of unique stations.**
    `SELECT DISTINCT Station_Name FROM Train_Schedule;`
    
 <img width="132" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/ce0cd0b6-83c0-4334-aa31-1853a27d1700">
    
  **Ans:** 98647 Stations
    
2.  **Total number of trains in the database.**
    `SELECT DISTINCT COUNT(Train_name) AS Total_Trains FROM Train_info;`
   <img width="96" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/5c7515e8-bd3f-4f10-9a75-e43b281d8d45">

    
3.  **Trains covering the maximum distance.**
    `SELECT Train_info.Train_Name, Train_schedule.Train_No, MAX(Train_schedule.Distance) AS Max_Distance
    FROM Train_schedule
    JOIN Train_info ON Train_schedule.Train_no = Train_info.Train_no 
    GROUP BY Train_info.Train_Name, Train_schedule.Train_no 
    ORDER BY Max_distance DESC LIMIT 10;`
 <img width="211" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/d78dbd1e-8c96-4874-bcd7-6da81f01984f">

    
4.  **Average distance traveled by each train.**
    `SELECT Train_info.Train_Name, Train_schedule.Train_No, AVG(Train_schedule.Distance) AS Avg_Distance
    FROM Train_schedule
    JOIN Train_info ON Train_schedule.Train_no = Train_info.Train_no 
    GROUP BY Train_info.Train_Name, Train_schedule.Train_no;`
<img width="199" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/cfe9309b-35ae-4ef0-87f6-b54ceab946c2">
 
    
5.  **Trains with the longest travel time.**   
    `SELECT ts.Train_No, ti.Train_Name, MAX(TIMEDIFF(ts.Arrival_time, ts.Departure_Time)) AS MaxTravelTime
    FROM Train_Schedule ts
    JOIN Train_info ti ON ts.Train_No = ti.Train_No
    WHERE ts.Arrival_time IS NOT NULL AND ts.Departure_Time IS NOT NULL
    GROUP BY ts.Train_No, ti.Train_Name
    ORDER BY MaxTravelTime DESC LIMIT 5;`
<img width="219" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/17ce6d19-a258-4128-9da9-056b195c5afe">

    
6.  **Number of trains passing through each station.**    
    `SELECT Station_Name, COUNT(DISTINCT Train_No) AS TrainsCount
    FROM Train_Schedule
    GROUP BY Station_Name;`
<img width="151" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/57664945-e37c-4886-be6a-d1673aebe278">

    
7.  **Average percentage of stops at each station for a given train.**  
    `SELECT ts.Train_No, ti.Train_Name, 100 * COUNT(DISTINCT ts.Station_Code) / COUNT(*) AS Percentage_of_Stops
    FROM Train_Schedule ts
    JOIN Train_info ti ON ts.Train_No = ti.Train_No
    GROUP BY ts.Train_No, ti.Train_Name;`
<img width="226" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/91d420c7-2694-49af-b7e1-65bdf0c411c7">

    
8.  **Trains with the highest number of stops.**
    `SELECT Train_Schedule.Train_no, Train_info.Train_Name, COUNT(*) AS NumberOfStops
    FROM Train_Schedule
    JOIN Train_info ON Train_Schedule.Train_no = Train_info.Train_no
    GROUP BY Train_Schedule.Train_No, Train_info.Train_Name
    ORDER BY NumberOfStops DESC LIMIT 5;`
<img width="215" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/6e20e445-bc8a-4c7a-b358-98638fc8d857">

    
9.  **Total travel time for each train.**  
    `SELECT Train_info.Train_No, Train_info.Train_Name, SUM(TIMEDIFF(Train_Schedule.Arrival_time, Train_Schedule.Departure_Time)) AS Total_Travel_Time
    FROM Train_Schedule
    JOIN Train_info ON Train_Schedule.Train_No = Train_info.Train_No
    WHERE Train_Schedule.Arrival_time IS NOT NULL AND Train_Schedule.Departure_Time IS NOT NULL
    GROUP BY Train_info.Train_No, Train_info.Train_Name;`
<img width="329" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/1c08550c-d931-421a-99bd-5c320755d74c">

    
10.  **Most common routes based on source and destination stations.**
`SELECT ti.Source_Station_Name, ti.Destination_Station_Name, COUNT(*) AS Frequency
FROM Train_info ti
GROUP BY ti.Source_Station_Name, ti.Destination_Station_Name
ORDER BY Frequency DESC LIMIT 5;`
<img width="277" alt="image" src="https://github.com/DilawarALi1300/Indian-Railways-Management-project/assets/155839093/27f4863a-064e-45fb-8bd8-833bf19dfca3">


# Conclusion

The Indian Railways SQL Project provides a comprehensive analysis of the railway system through the lens of a well-structured database and insightful SQL queries. By examining various aspects such as train schedules, distances, travel times, and stops, we gain valuable insights into the functioning of the Indian Railways.

The database, named [Indian_Railways](https://github.com/DilawarALi1300/Indian-Railway-Management-project/blob/main/Indian%20Railways%20Management.sql), is designed to store essential information about trains and their schedules. The SQL queries developed for this project enable users to explore and analyze different facets of the data, providing a deeper understanding of the railway operations.

Throughout the project, I addressed diverse questions, including the total number of trains, average distances traveled, trains covering the maximum distance, and the most common routes based on source and destination stations. These analyses offer stakeholders, railway operators, and enthusiasts a valuable resource for making informed decisions, optimizing operations, and understanding the dynamics of the Indian Railways system.

As the project evolves, there is room for further exploration, improvement, and contribution. Whether for academic purposes, operational enhancements, or simply out of curiosity, the Indian Railways SQL Project stands as a foundation for ongoing discussions, analyses, and advancements within the realm of railway management and analytics.

## Contributing

Contributions are welcome! Feel free to open issues, submit pull requests, or provide suggestions for improvement. Your input is valuable in making this project better.

## License

This project is licensed under the [MIT License](https://opensource.org/license/mit/). Feel free to use, modify, and distribute the code for your own projects.
