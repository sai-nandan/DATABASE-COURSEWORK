
USE Pujyam_Database
GO


--adding id column for manchester street table
ALTER TABLE [manchester_street]
ADD ID INT IDENTITY;
ALTER TABLE [manchester_street]
ADD CONSTRAINT PK_Id PRIMARY KEY NONCLUSTERED (ID);

--adding geo location to manchesterstreet table
alter table [dbo].[manchester_street] ADD [GeoLocation] GEOGRAPHY

UPDATE [dbo].[manchester_street]
SET [GeoLocation] = geography::Point(Latitude, Longitude, 4326)
WHERE [Longitude] IS NOT NULL
AND [Latitude] IS NOT NULL
AND CAST(Latitude AS decimal(10, 6)) BETWEEN -90 AND 90
AND CAST(Longitude AS decimal(10, 6)) BETWEEN -90 AND 90




--creating mid2018 table 
create table mid2018(
Areacode varchar(100),
Lsoa varchar(100),
Allages varchar(100)
)


--inserting data into mid 2018 table
Insert into mid2018(Areacode,Lsoa,Allages)
select Contents,substring(F3,1,len(F3)-4),F4 from [dbo].[Mid_2018_Persons] where F3  is not null

--creating view by joining manchester crimes data with area codes from population data
create view joinedcrimes as
select * from mid2018 inner join manchester_street on mid2018.Areacode = manchester_street.[LSOA code]
select * from joinedcrimes

--Report 1 for task3
create or alter view area_wise_crimes as
select Lsoa,count([Crime ID]) as crime_count,sum(distinct(cast(Allages as int))) as people from joinedcrimes 
group by Lsoa

select * from area_wise_crimes

--Report 2 for task3
create view mccrimetype as
select distinct[Crime type], count(*) as counts from [dbo].[manchester_street] group by [Crime type]





--Report for plotting Salford anti social behaviour
create or alter view salfordcrimes as
select ID,Lsoa,Longitude,Latitude,[Crime type], GeoLocation from joinedcrimes 
where [Crime type] like  '%Anti-social%' and Lsoa like '%Salford%'



-- vehicle crime reports for greater manchester
create or alter view vehiclecrimes as
select ID,Lsoa,Longitude,Latitude,[Crime type], GeoLocation from joinedcrimes 
where [Crime type] like  '%Vehicle crime%' and Lsoa like '%Manchester%'


--Burglary reports for Bolton
create or alter view burglaryreport as
select ID,Lsoa,Longitude,Latitude,[Crime type], GeoLocation from joinedcrimes 
where [Crime type] like  '%Burglary%' and Lsoa like '%Bolton %'



--sexual offence report in wigan
create or alter view sexualoffence as
select ID,Lsoa,Longitude,Latitude,[Crime type], GeoLocation from joinedcrimes 
where [Crime type] like  '%Violence and sexual offences%' and Lsoa like '%wigan%'