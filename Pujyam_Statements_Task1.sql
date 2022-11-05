
USE Pujyam_Database
GO

--security implementation
CREATE LOGIN User1
WITH PASSWORD = 'User123';

CREATE USER User2 FOR LOGIN User1;


--creating child table 
create table child(
childid varchar(30),
round int,
chid varchar(30),
country varchar(50),
child_sex varchar(100),
inround varchar(100),
inall_rounds varchar(100)
PRIMARY KEY(chid)
)

--creating  child habbits table
create table child_avgbmi(
chid varchar(30),
country varchar(50),
child_height varchar(50),
child_weight varchar(100),
child_bmi varchar(100)
constraint FK_habbits FOREIGN KEY(chid) references child
)

--creating table for child height & weight for age
create table height_weight(
chid varchar(30), 
country varchar(50),
child_sex varchar(100),
underweight varchar(100),
shortheight varchar(100),
thinness varchar(100),
constraint FK_height_weight FOREIGN KEY(chid) references child
)

--creating table for child vaccines
create table vaccines (
chid varchar(30),
country varchar(50),
tetanus varchar(100),
bcg varchar(100),
measles varchar(100),
dpt varchar(100),
hib varchar(100),
polio varchar(100),
constraint FK_vaccines FOREIGN KEY(chid) references child
)

--creating table for childs basic needs
create table basic_needs (
chid varchar(30),
country varchar(50),
typesite varchar(100),
drinking_water varchar(100),
toilet varchar(100),
electricity varchar(100),
cooking_fuels varchar(100),
ownhouse varchar(100),
ownland varchar(100),
constraint FK_basic_needs FOREIGN KEY(chid) references child
)

--creating table for natural calamities
create table natural_calamities (
chid varchar(30), 
country varchar(50),
droughts varchar(100),
floods varchar(100),
crop_failure varchar(100),
natural_disasters varchar(100),
constraint FK_natural_calamities FOREIGN KEY(chid) references child
)

--creating table for child education and wellbeing
create table education_wellbeing(
chid varchar(30), 
country varchar(50),
typesite varchar(100),
hsleep varchar(100),
hplay varchar(100),
hschool varchar(100),
preprimary varchar(100),
literate varchar(100),
canread varchar(100),
canwrite varchar(100),
constraint FK_education_wellbeing FOREIGN KEY(chid) references child
)



--Stored Procedures

--procedure for inserting data into child table

CREATE or alter PROCEDURE Insertinto_child 
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = 'INSERT INTO child(childid,round,chid,country,child_sex,inround,inall_rounds)
select childid,round,concat(childid,round) as chid,country,
case
when chsex= ''1'' then ''Male''
when chsex= ''2'' then ''Female'' end,
case
when inround= ''0'' then ''No''
when inround= ''1'' then ''Yes'' end,
case
when panel12345= ''0'' then ''No''
when panel12345= ''1'' then ''Yes'' end from '+ @TableName 

 EXECUTE sp_executesql @Sql

END

--PROCEDURE FOR INSERTING DATA INTO child_avgbmi TABLE
CREATE or alter PROCEDURE Insertinto_avgbmi
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = 'INSERT INTO child_avgbmi(chid,country,child_height,child_weight,child_bmi)
select concat(childid,round) as chid,country,chheight,chweight,bmi from '+ @TableName 

 EXECUTE sp_executesql @Sql

END


--PROCEDURE FOR INSERTING DATA INTO height weight table
CREATE or alter PROCEDURE Insertinto_ageheightweight
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = '
INSERT INTO [dbo].[height_weight](chid,country,child_sex,underweight,shortheight,thinness)
select concat(childid,round) as chid,country,
case  
when chsex = ''1'' then ''Male''
when chsex = ''2'' then ''Female'' END ,
case
when underweight = ''0'' then ''Not Underweight''
when underweight = ''1'' then ''Moderately Underweight''
when underweight = ''2'' then ''Severly Underweight''
when underweight ='' '' then ''Not defined'' end,
case
when stunting = ''0'' then ''Not short''
when stunting = ''1'' then ''Moderately short''
when stunting = ''2'' then ''Severly short'' 
when stunting = '' '' then ''not defined''end ,
case
when thinness = ''0'' then ''Not thin''
when thinness = ''1'' then ''Moderately thin''
when thinness = ''2'' then ''Severly thin'' 
when thinness = '' '' then ''not defined''end
from '+ @TableName 

 EXECUTE sp_executesql @Sql

END

--Procedure for inserting data into vaccines table

CREATE or alter PROCEDURE Insertinto_vaccines
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = '
INSERT INTO vaccines(chid,country,tetanus,bcg,measles,dpt,hib,polio)
select concat(childid,round) as chid,country,
case
when tetanus = ''0'' then ''Not Taken Tetanus''
when tetanus = ''1'' then ''Taken Tetanus''
when tetanus = '''' then ''not defined'' end,
case
when bcg = ''0'' then ''Not Taken Bcg''
when bcg = ''1'' then ''Taken Bcg''
when bcg = '''' then ''not defined'' end,
case
when measles = ''0'' then ''Not Taken Measles''
when measles = ''1'' then ''Taken Measles''
when measles = '''' then ''not defined'' end ,
case
when dpt = ''0'' then ''Not Taken Dpt''
when dpt = ''1'' then ''Taken Dpt'' 
when dpt = '''' then ''not defined'' end ,
case
when hib = ''0'' then ''Not Taken Hib''
when hib = ''1'' then ''Taken Hin'' 
when hib = '''' then ''not defined'' end ,
case
when polio = ''0'' then ''Not Taken Polio''
when polio = ''1'' then ''Taken Polio'' 
when polio = '''' then ''not defined'' end  from '+ @TableName 

 EXECUTE sp_executesql @Sql

END


--procedure for inserting data into basic needs table
CREATE or alter PROCEDURE Insertinto_basicneeds
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = '
INSERT INTO basic_needs(chid,country,typesite,drinking_water,toilet,electricity,cooking_fuels,ownhouse,ownland)
SELECT concat(childid,round) as chid,country,
case
when typesite = ''1'' then ''Urban''
when typesite = ''2'' then ''Rural''
when typesite = ''77'' then ''Unknown''
when typesite = '''' then ''Unknown'' end,
case 
when drwaterq = ''0'' then ''No Access To Drinking Water''
when drwaterq = ''1'' then ''Has Access To Drinking Water''
when drwaterq = '''' then ''Not defined'' end,
case 
when toiletq = ''0'' then ''No Access To Toilets''
when toiletq = ''1'' then ''Has Access To Toilets''
when toiletq = '''' then ''Not defined'' end ,
case 
when elecq = ''0'' then ''No Access To Electricity''
when elecq = ''1'' then ''Has Access To Electricity''
when elecq = '''' then ''Not defined'' end ,
case 
when cookingq = ''0'' then ''No Access To Cooking Fuels''
when cookingq = ''1'' then ''Has Access To Cooking Fuels''
when cookingq = '''' then ''Not defined'' end ,
case 
when ownhouse = ''0'' then ''No Own House''
when ownhouse = ''1'' then ''Has Own House''
when ownhouse = '''' then ''Not defined'' end ,
case 
when ownlandhse = ''0'' then ''No Own Land''
when ownlandhse = ''1'' then ''Has Own Land''
when ownlandhse = '''' then ''Not defined'' end  from '+ @TableName 

 EXECUTE sp_executesql @Sql

END

--procedure for inserting data into natural_calamities table
CREATE or alter PROCEDURE Insertinto_naturalcalamities
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = '
INSERT INTO natural_calamities(chid,country,droughts,floods,crop_failure,natural_disasters)
SELECT concat(childid,round) as chid,country,
case 
when shenv1 = ''0'' then ''No Droughts''
when shenv1 = ''1'' then ''Droughts''
when shenv1 = '''' then ''Not defined'' end,
case 
when shenv2 = ''0'' then ''No Floods''
when shenv2 = ''1'' then ''Floods''
when shenv2 = '''' then ''Not defined'' end ,
case 
when shenv6 = ''0'' then ''No Crop Failures''
when shenv6 = ''1'' then ''Crop Failures''
when shenv6 = '''' then ''Not defined'' end ,
case 
when shenv9 = ''0'' then ''No Natural Disasters''
when shenv9 = ''1'' then ''Natural Disasters''
when shenv9 = '''' then ''Not defined'' end  FROM '+ @TableName 

 EXECUTE sp_executesql @Sql

END

--procedure for inserting data into basic needs table
CREATE or alter PROCEDURE Insertinto_educationwellbeing
@TableName NVARCHAR(128)
AS 
BEGIN 
  SET NOCOUNT ON;
  DECLARE @Sql NVARCHAR(MAX);

SET @Sql = '
INSERT INTO education_wellbeing(chid,country,typesite,hsleep,hplay,hschool,preprimary,literate,canread,canwrite)
SELECT concat(childid,round) as chid,country,
case 
when typesite = ''1'' then ''Urban''
when typesite = ''2'' then ''Rural''
when typesite = '''' then ''Not defined'' end,hsleep,hplay,hschool,
case 
when preprim = ''0'' then ''Not Attended''
when preprim = ''1'' then ''Attended''
when preprim = '''' then ''Not defined'' end ,
case 
when literate = ''0'' then ''Illiterate''
when literate = ''1'' then ''Literate''
when literate = '''' then ''Not defined'' end ,
case 
when levlread = ''1'' then ''Cant Read Anything''
when levlread = ''2'' then ''Can Read Letters''
when levlread = ''3'' then ''Can Read Words''
when levlread = ''4'' then ''Can Read Sentences''
when levlread = '''' then ''Not defined'' end ,
case 
when levlwrit = ''1'' then ''Cant Write Anything''
when levlwrit = ''2'' then ''Writes With Difficulties''
when levlwrit = ''3'' then ''Writes Without Difficulties''
when levlwrit = '''' then ''Not defined'' end  FROM '+ @TableName 

 EXECUTE sp_executesql @Sql

END

--inserting data into child table
exec Insertinto_child ethiopia_constructed
exec Insertinto_child india_constructed
exec Insertinto_child peru_constructed
exec Insertinto_child vietnam_constructed

--inserting data into child_avgbmi table
exec Insertinto_avgbmi ethiopia_constructed
exec Insertinto_avgbmi india_constructed
exec Insertinto_avgbmi peru_constructed
exec Insertinto_avgbmi vietnam_constructed

--inserting data into height weight table
exec Insertinto_ageheightweight ethiopia_constructed
exec Insertinto_ageheightweight india_constructed
exec Insertinto_ageheightweight peru_constructed
exec Insertinto_ageheightweight vietnam_constructed

--inserting data into vaccines table
exec Insertinto_vaccines ethiopia_constructed
exec Insertinto_vaccines india_constructed
exec Insertinto_vaccines peru_constructed
exec Insertinto_vaccines vietnam_constructed

--inserting data into basic needs table
exec Insertinto_basicneeds ethiopia_constructed
exec Insertinto_basicneeds india_constructed
exec Insertinto_basicneeds peru_constructed
exec Insertinto_basicneeds vietnam_constructed

--inserting data into natural calamities table
exec Insertinto_naturalcalamities ethiopia_constructed
exec Insertinto_naturalcalamities india_constructed
exec Insertinto_naturalcalamities peru_constructed
exec Insertinto_naturalcalamities vietnam_constructed

--inserting data into  education and wellbeing table
exec Insertinto_educationwellbeing ethiopia_constructed
exec Insertinto_educationwellbeing india_constructed
exec Insertinto_educationwellbeing peru_constructed
exec Insertinto_educationwellbeing vietnam_constructed




--report for average hours spent on
create or alter view hours_spent as
Select
country,
round(Avg(Cast( hsleep  As float)),2) As sleep_avg,
round(Avg(Cast( hplay  As float)),2) As play_avg,
round(Avg(Cast( hschool  As float)),2) As school_avg
From education_wellbeing 
where  hsleep is not null and hsleep != ' ' and  hplay is not null and hplay != ' ' and  hschool is not null and hschool != ' '
group by country


--report for child height weight averages
create or alter view heightweight_avgs as
Select 'Avg Bmi' as AvgType,
country ,
round(Avg(Cast(child_bmi As float)),2) As averages
From  child_avgbmi  group by country
union
Select 'Avg Height',
country ,
round(Avg(Cast(child_height As float)),2) As averages
From  child_avgbmi  group by country
union
Select 'Avg Weight',
country ,
round(Avg(Cast(child_weight As float)),2) As averages
From  child_avgbmi group by country



--Report  for checking height weight and thinness
create or alter view checkheightweight as 
select country,child_sex,underweight as category,count(underweight) as counts from [dbo].[height_weight]
where underweight = 'Not Underweight' group by country,underweight,child_sex
union
select country,child_sex,underweight,count(underweight) as cnt from [dbo].[height_weight]
where underweight = 'Moderately Underweight' group by country,underweight,child_sex
union
select country,child_sex,underweight,count(underweight) as cnt from [dbo].[height_weight] 
where underweight = 'Severly Underweight' group by country,underweight,child_sex
union
select country,child_sex,shortheight,count(shortheight) as cnt from [dbo].[height_weight] 
where shortheight = 'Not short' group by country,shortheight,child_sex
union
select country,child_sex,shortheight,count(shortheight) as cnt from [dbo].[height_weight]  
where shortheight = 'Moderately short' group by country,shortheight,child_sex
union
select country,child_sex,shortheight,count(shortheight) as cnt from [dbo].[height_weight] 
where shortheight = 'Severly short' group by country,shortheight,child_sex
union
select country,child_sex,thinness,count(thinness) as cnt from [dbo].[height_weight] 
where thinness = 'Not thin' group by country,thinness,child_sex
union
select country,child_sex,thinness,count(thinness) as cnt from [dbo].[height_weight]  
where thinness = 'Moderately thin' group by country,thinness,child_sex
union
select country,child_sex,thinness,count(thinness) as cnt from [dbo].[height_weight] 
where thinness = 'Severly thin' group by country,thinness,child_sex



--Report  for natural disasters
create or alter view check_nature_calamities as
select country,droughts,count(droughts) as counts from [dbo].[natural_calamities] 
where droughts = 'No Droughts' group by country,droughts
union 
select country,droughts,count(droughts) as drought_count from [dbo].[natural_calamities]
where droughts = 'Droughts' group by country,droughts
union 
select country,floods,count(floods) as flood_count from [dbo].[natural_calamities]
where floods = 'No Floods' group by country,floods
union 
select country,floods,count(floods) as flood_count from [dbo].[natural_calamities]
where floods = 'Floods' group by country,floods
union
select country,crop_failure,count(crop_failure) as crop_count from [dbo].[natural_calamities]
where crop_failure = 'No Crop Failures' group by country,crop_failure
union 
select country,crop_failure,count(crop_failure) as crop_count from [dbo].[natural_calamities]
where crop_failure = 'Crop Failures' group by country,crop_failure
union 
select country,natural_disasters,count(natural_disasters) as disaster_count from [dbo].[natural_calamities]
where natural_disasters = 'No Natural Disasters' group by country,natural_disasters
union 
select country,natural_disasters,count(natural_disasters) as disaster_count from [dbo].[natural_calamities]
where natural_disasters = 'Natural Disasters' group by country,natural_disasters


select * from check_nature_calamities order by country


--Report  for vaccines
create or alter view Check_vaccines as
select country,tetanus as vaccines,count(tetanus) as counts from [dbo].[vaccines]
where tetanus = 'Not Taken Tetanus' group by country,tetanus
union
select country,tetanus,count(tetanus) as counts from [dbo].[vaccines]
where tetanus = 'Taken Tetanus' group by country,tetanus
union
select country,bcg,count(bcg) as counts from [dbo].[vaccines]
where bcg = 'Not Taken Bcg' group by country,bcg
union
select country,bcg,count(bcg) as counts from [dbo].[vaccines]
where bcg = 'Taken Bcg' group by country,bcg
union
select country,measles,count(measles) as counts from [dbo].[vaccines]
where measles = 'Not Taken Measles' group by country,measles
union
select country,measles,count(measles) as counts from [dbo].[vaccines]
where measles = 'Taken Measles' group by country,measles
union
select country,dpt,count(dpt) as counts from [dbo].[vaccines]
where dpt = 'Not Taken Dpt' group by country,dpt
union
select country,dpt,count(dpt) as counts from [dbo].[vaccines]
where dpt = 'Taken Dpt' group by country,dpt
union
select country,hib,count(hib) as counts from [dbo].[vaccines]
where hib = 'Not Taken Hib' group by country,hib
union
select country,hib,count(hib) as counts from [dbo].[vaccines]
where hib = 'Taken Hib' group by country,hib
union
select country,polio,count(polio) as counts from [dbo].[vaccines]
where polio = 'Not Taken Polio' group by country,polio
union
select country,polio,count(polio) as counts from [dbo].[vaccines]
where polio = 'Taken Polio' group by country,polio


select * from check_vaccines order by country


--report for basic needs table
create or alter view check_basic_needs as
select country,typesite,drinking_water as basic_needs,count(drinking_water) as counts from [dbo].[basic_needs]
where drinking_water ='No Access To Drinking Water' group by country,typesite,drinking_water 
union
select country,typesite,drinking_water,count(drinking_water) as counts from [dbo].[basic_needs]
where drinking_water ='Has AccessTo Drinking Water' group by country,typesite,drinking_water 
union
select country,typesite,toilet,count(toilet) as counts from [dbo].[basic_needs]
where toilet ='No Access To Toilets' group by country,typesite,toilet 
union
select country,typesite,toilet,count(toilet) as counts from [dbo].[basic_needs]
where toilet ='Has Access To Toilets' group by country,typesite,toilet 
union
select country,typesite,electricity,count(electricity) as counts from [dbo].[basic_needs]
where electricity ='No Access To Electricity' group by country,typesite,electricity 
union
select country,typesite,electricity,count(toilet) as counts from [dbo].[basic_needs]
where electricity ='Has Access To Electricity' group by country,typesite,electricity 
union
select country,typesite,cooking_fuels,count(cooking_fuels) as counts from [dbo].[basic_needs]
where cooking_fuels ='No Access To Cooking Fuels' group by country,typesite,cooking_fuels 
union
select country,typesite,cooking_fuels,count(cooking_fuels) as counts from [dbo].[basic_needs]
where cooking_fuels ='Has Access To Cooking Fuels' group by country,typesite,cooking_fuels 