
                         ------SQL CASE STUDY 2-------
-----------------------MALDIVES VS LAKSHADWEEP SQL ANALYSIS-----------------

Create database MALDIVES_LAKSHADWEEP
-----------------------------------------
-- Table to store information about destinations (Maldives and Lakshadweep)
    CREATE TABLE Destination (
        DestinationID INT PRIMARY KEY,
        Name VARCHAR(255),
        GeographicalLocation VARCHAR(255),
        NumberofIslands INT,
        CapitalCity VARCHAR(255),
        TourismRevenue DECIMAL(10,2),
        UnderwaterActivities VARCHAR(1000),
        Accessibility VARCHAR(255),
        Culture VARCHAR(1000),
        Language VARCHAR(255),
        BestTimeToVisit VARCHAR(255),
        VisaRequirements VARCHAR(255),
        Currency VARCHAR(255),
        Transportation VARCHAR(255),
        AverageBudgetPerDay DECIMAL(10,2),
        ShoppingOptions VARCHAR(1000),
        DurationOfStay VARCHAR(255),
        UniqueFeatures VARCHAR(1000)
    );
    
    -- Table to store tourist attractions information
    CREATE TABLE TouristAttractions (
        AttractionID INT PRIMARY KEY,
        DestinationID INT,
        Name VARCHAR(255),
        Description VARCHAR(1000),
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Table to store tourist arrival statistics
    CREATE TABLE TouristArrivals (
        ArrivalID INT PRIMARY KEY,
        DestinationID INT,
        Year INT,
        NumberofVisitors INT,
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Table to store information about the significance of Indian tourists
    CREATE TABLE IndianTourists (
        IndianTouristID INT PRIMARY KEY,
        DestinationID INT,
        Year INT,
        NumberofTourists INT,
        FOREIGN KEY (DestinationID) REFERENCES Destination(DestinationID)
    );
    
    -- Inserting values into Destination table
    INSERT INTO Destination (DestinationID, Name, GeographicalLocation, NumberofIslands, CapitalCity, TourismRevenue, UnderwaterActivities, Accessibility, Culture, Language, BestTimeToVisit, VisaRequirements, Currency, Transportation, AverageBudgetPerDay, ShoppingOptions, DurationOfStay, UniqueFeatures)
    VALUES
    (1, 'Maldives', 'Indian Ocean, southwest of Sri Lanka', 1000, 'Malé', 11257.00, 'Diving with whale and sharks, Vibrant Coral Reefs, Banana Reef dives', 'Well-connected with international flights', 'Influenced by South Asian, Middle Eastern, and African cultures', 'Dhivehi', 'November to March (dry season)', '30-day visa on arrival', 'Maldivian Rufiyaa (MVR)', 'Seaplanes, speedboats, ferries', 17500.00, 'Vibrant markets in Male like Male Local Market and Majeedhee Magu', 'Ideal for 7-10 days', 'Overwater bungalows, extensive luxury resorts'),
    
    (2, 'Lakshadweep', 'Arabian Sea, off the southwest coast of India', 36, 'Kavaratti', 65.00, 'Snorkeling at Minicoy, Coral Reefs at Kadmat Island, Diving at Bangaram Atoll', 'Limited connectivity, primarily accessible by ships', 'Blend of Indian and Arabic influences', 'Malayalam, English', 'October to mid-May (avoiding monsoon)', 'No visa required for Indian tourists; foreign tourists need a visa', 'Indian Rupee (INR)', 'Limited to ships, boats, and ferries', 7300.00, 'Limited shopping options, with some markets like Agatti Island, Kavaratti', 'Ideal for 5-6 days', 'Less-commercialised atmosphere, pristine natural beauty');
    
    
    -- Inserting values into TouristAttractions table
    INSERT INTO TouristAttractions (AttractionID, DestinationID, Name, Description)
    VALUES
        (1, 1, 'Male', 'The vibrant capital is a gateway with colorful architectures and a hub for water sports.'),
        (2, 1, 'Maafushi', 'Known for its breathtaking beaches and versatile activities like snorkelling and sunbathing.'),
        (3, 1, 'Hithadhoo', 'A picturesque island in Addu City, celebrated globally for its natural reserves.'),
        (4, 2, 'Minicoy Island', 'A beach lover’s haven with numerous lagoons enhancing its charm.'),
        (5, 2, 'Kavaratti', 'The capital city is surrounded by abundant lagoons, offering scuba diving and aquarium tours.'),
        (6, 2, 'Kadmat Island', 'Famed for its beautiful coral reefs, an ideal spot for snorkelling and marine reserve tours.');
    
    
    -- Insert values for TouristArrivals table
    INSERT INTO TouristArrivals (ArrivalID, DestinationID, Year, NumberofVisitors) VALUES
    (1, 1, 2013, 4784),
    (2, 1, 2014, 7315),
    (3, 1, 2015, 17241),
    (4, 1, 2016, 8716),
    (5, 1, 2017, 6620),
    (6, 1, 2018, 10435),
    (7, 1, 2019, 6985),
    (8, 1, 2020, 3462),
    (9, 1, 2021, 13500),
    (10, 1, 2022, 22800),
    
    -- Values for Lakshadweep
    (11, 2, 2013, 1000),
    (12, 2, 2014, 2000),
    (13, 2, 2015, 4000),
    (14, 2, 2016, 2500),
    (15, 2, 2017, 1800),
    (16, 2, 2018, 3000),
    (17, 2, 2019, 2200),
    (18, 2, 2020, 1200),
    (19, 2, 2021, 3500),
    (20, 2, 2022, 6000);

	-- Inserting sample values into the IndianTourists table
    INSERT INTO IndianTourists (IndianTouristID, DestinationID, Year, NumberofTourists)
    VALUES
        (1, 1, 2021, 209198),  -- Maldives in 2021
        (2, 2, 2021, 50000),   -- Lakshadweep in 2021 (hypothetical value for illustration)
        (3, 1, 2022, 187000),  -- Maldives in 2022
        (4, 2, 2022, 60000),   -- Lakshadweep in 2022 (hypothetical value for illustration)
        (5, 1, 2023, 209198),  -- Maldives in 2023
        (6, 2, 2023, 100000);  -- Lakshadweep in 2023 (hypothetical value for illustration)

----------------------------------------------------
select * from Destination
select * from TouristArrivals
select * from IndianTourists
select * from TouristAttractions
------------------------------------------

--1)Retrieve the number of visitors to the Maldives in 2019?--need to try full join once

Select sum([NumberofVisitors] ) as Total_Number_of_Visitors from TouristArrivals
Where DestinationID = 1 and [Year] = '2019' 

--2)Retrieve the average budget per day and best time to visit for destinations with more than 
--10,000 tourists in 2022?

select T1.[Name] as Destination,T1.[DestinationID], ([AverageBudgetPerDay]*sum([NumberofTourists]+ [NumberofVisitors])) 
as averagebudgetperday,
T1.[BestTimeToVisit] from Destination as T1
join
TouristArrivals As T2
on
T1.DestinationID = T2.DestinationID 
join
IndianTourists as T3
on
T2.DestinationID = T3.DestinationID
where T3.NumberofTourists >10000 and  T3.[Year] = 2022 and T2.[Year] = 2022
Group by T1.[Name], [AverageBudgetPerDay],T1.[BestTimeToVisit], T1.[DestinationID]
--having T2.NumberofVisitors >=10000

select * from IndianTourists
where year = '2022'
select * from TouristArrivals
where year = '2022'
select * from Destination

--3)Retrieve the unique features of tourist attractions in Lakshadweep?

select destination.[Name],destination.UniqueFeatures, TouristAttractions.[Name], [Description] from Destination
join
TouristAttractions
on
Destination.DestinationID = TouristAttractions.DestinationID
where Destination.[Name] = 'Lakshadweep'

--4)Retrieve the number of Indian tourists who visited the Maldives in 2021?

select sum([NumberofTourists]) from IndianTourists
where DestinationID = 1 and [Year] = 2021

--------Or ----use below syntax if we need destination name in output

select [Name], sum([NumberofTourists]) from IndianTourists
join
Destination
on
IndianTourists.DestinationID = Destination.DestinationID
where [Name] = 'maldives' and [Year] = 2021
group by [Name]

--5)Find the destinations with the highest tourism revenue in 2022?

select * from Destination
select * from TouristArrivals
select * from IndianTourists
select * from TouristAttractions

--ANS:
select  Top 1 [Name], (sum(T2.[NumberofTourists]+T1.[NumberofVisitors]))*T3.[TourismRevenue] 
as highest_tourism_revenue
from TouristArrivals as T1
join
IndianTourists as T2
on
T1.DestinationID = T2.DestinationID
join
Destination as T3
on T2.DestinationID = T3.DestinationID
where T1.Year ='2022' and T2.year ='2022'
Group By T3.[Name], T3.[TourismRevenue]
Order by highest_tourism_revenue desc