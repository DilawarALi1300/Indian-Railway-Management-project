create database Indian_Railways;
Use Indian_Railways;
select * from train_info;
Select * from Train_schedule;
Desc Train_schedule;
ALTER TABLE Train_Schedule
MODIFY COLUMN Arrival_time TIME;
ALTER TABLE Train_Schedule
MODIFY COLUMN Departure_Time TIME;


SELECT Train_No, Train_Name, Source_Station_Name 
FROM TRain_info;

#1 Total Stations 
SELECT DISTINCT Station_Name 
FROM Train_Schedule;

#2 Total No.of Trains
Select Distinct count(Train_name) as Total_Trains
from Train_info;


#3 Avg Distance Traveled By Each Train
SELECT Train_info.Train_Name, Train_schedule.Train_No, AVG(Train_schedule.Distance) AS Avg_Distance
FROM Train_schedule
JOIN Train_info ON Train_schedule.Train_no = Train_info.Train_no 
Group By Train_info.Train_Name,Train_schedule.Train_no ;

# Top trains which covers Max Distance
SELECT Train_info.Train_Name, Train_schedule.Train_No, max(Train_schedule.Distance) AS MAx_Distance
FROM Train_schedule
JOIN Train_info ON Train_schedule.Train_no = Train_info.Train_no 
Group By Train_info.Train_Name,Train_schedule.Train_no 
Order By Max_distance Desc
Limit 10;

#4 Train Train Arrival time
SELECT Train_info.Train_No, Train_info.Train_Name, Train_Schedule.Arrival_time
FROM Train_Schedule
JOIN Train_info ON Train_Schedule.Train_No = Train_info.Train_No
WHERE Train_Schedule.Arrival_time IS NOT NULL;

#5  Travel time 
    SELECT Train_info.Train_No,Train_info.Train_Name,Train_Schedule.Departure_Time,Train_Schedule.Arrival_time,
    CASE
	WHEN Train_Schedule.Arrival_time >= Train_Schedule.Departure_Time
	THEN TIMEDIFF(Train_Schedule.Arrival_time, Train_Schedule.Departure_Time)
        ELSE TIMEDIFF(ADDTIME(Train_Schedule.Arrival_time, '24:00:00'),Train_Schedule.Departure_Time)
    END AS Time_Taken
FROM Train_Schedule JOIN Train_info ON Train_Schedule.Train_No = Train_info.Train_No
WHERE Train_Schedule.Departure_Time IS NOT NULL AND Train_Schedule.Arrival_time IS NOT NULL;


# 6  Trains with longest Travel time ;
SELECT ts.Train_No,ti.Train_Name,MAX(TIMEDIFF(ts.Arrival_time, ts.Departure_Time)) AS MaxTravelTime
FROM Train_Schedule ts
JOIN Train_info ti ON ts.Train_No = ti.Train_No
WHERE ts.Arrival_time IS NOT NULL AND ts.Departure_Time IS NOT NULL
GROUP BY ts.Train_No, ti.Train_Name
ORDER BY MaxTravelTime DESC LIMIT 5;

# 7 Trains On Monday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Monday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 8 Trains on Tuesday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Tuesday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 9 Trains on Wednesday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Wednesday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 10 Trains on Thursday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Thursday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 11 Trains on Friday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Friday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 12 Trains on Saturday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Saturday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 13 Trains on Sunday
SELECT DISTINCT Train_schedule.Train_no,Train_info.train_Name,Days
FROM Train_schedule 
JOIN Train_info  ON Train_schedule.Train_no = Train_info.Train_No
Where days="Sunday"
Group by Train_schedule.Train_no,Train_info.train_Name;

# 14 Trains Passing Through Each Station
SELECT Station_Name, COUNT(DISTINCT Train_No) AS TrainsCount
FROM Train_Schedule
GROUP BY Station_Name;

# 15  Trains With  Number of Stops 
SELECT Train_Schedule.Train_no,Train_info.Train_Name, (COUNT(*)) AS NumberOfStops
FROM Train_Schedule
Join Train_info on Train_Schedule.Train_no = Train_info.Train_no
GROUP BY Train_Schedule.Train_No,Train_info.Train_Name
ORDER BY NumberOfStops DESC ;

# 16 Trains with Highest Number of Stops
SELECT Train_Schedule.Train_no,Train_info.Train_Name, (COUNT(*)) AS NumberOfStops
FROM Train_Schedule
Join Train_info on Train_Schedule.Train_no = Train_info.Train_no
GROUP BY Train_Schedule.Train_No,Train_info.Train_Name
ORDER BY NumberOfStops DESC
LIMIT 5;

# 17 Train Stop Percentage at Each Station
SELECT ts.Train_No,ti.Train_Name,100 * COUNT(DISTINCT ts.Station_Code) / COUNT(*) AS Percentage_of_Stops
FROM Train_Schedule ts
JOIN Train_info ti ON ts.Train_No = ti.Train_No
GROUP BY ts.Train_No, ti.Train_Name;

# 18 Time Spent At Station By Each Train
SELECT ts.Train_No,ti.Train_Name,ts.Station_Code,ts.Station_Name,
    TIMEDIFF(ts.Departure_Time, ts.Arrival_time) AS Time_Spent_At_Station
FROM Train_Schedule ts
JOIN Train_info ti ON ts.Train_No = ti.Train_No
WHERE ts.Arrival_time IS NOT NULL AND ts.Departure_Time IS NOT NULL
GROUP BY ts.Train_No, ti.Train_Name, ts.Station_Code, ts.Station_Name ,Time_Spent_At_Station; 


# 19 Get Train Information  by Train Number
DELIMITER //

CREATE PROCEDURE GetTrainInformation(IN p_TrainNo INT)
BEGIN
    SELECT ti.Train_No, ti.Train_Name, ts.*
    FROM Train_info ti
    JOIN Train_Schedule ts ON ti.Train_No = ts.Train_No
    WHERE ti.Train_No = p_TrainNo;
END //

DELIMITER ;

call GetTrainInformation(107)

# 20 Get Train Schedule by Train Number
DELIMITER //

CREATE PROCEDURE GetTrainSchedule(IN p_TrainNo INT)
BEGIN
    SELECT *
    FROM Train_Schedule
    WHERE Train_No = p_TrainNo;
END //

DELIMITER ;

 CALL GetTrainSchedule(107);
 
 
 # 21 Most Common Routes
 SELECT ti.Source_Station_Name,ti.Destination_Station_Name,COUNT(*) AS Frequency
FROM Train_info ti
GROUP BY ti.Source_Station_Name, ti.Destination_Station_Name
ORDER BY Frequency DESC LIMIT 5;

# 22 Stations with Maximum Stops
SELECT ts.Station_Name, COUNT(ts.SN) AS StopsCount
FROM Train_Schedule ts
GROUP BY ts.Station_Name
ORDER BY StopsCount DESC LIMIT 5;

# 23 Station with Minimum Stops
SELECT ts.Station_Name, COUNT(ts.SN) AS StopsCount
FROM Train_Schedule ts
GROUP BY ts.Station_Name
ORDER BY StopsCount ASC LIMIT 5; 

    
    


 

