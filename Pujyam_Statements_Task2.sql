use Pujyam_Database
go



--creating task2 student table
create table task2_child(
uniqueid varchar(100) primary key,
schoolid varchar(100),
locality varchar(100),
province varchar(100),
gender varchar(100),
age varchar(100),
)

--creating task2 child activityenglish table
create table task2_activityenglish (
uniqueid varchar(100),
readbook varchar(100),
watchtv varchar(100),
useinternet varchar(100),
writeemail varchar(100),
constraint fk_activityenglish foreign key(uniqueid) references task2_child
)

--creating table for child english speaking.
create table task2_speakenglish (
uniqueid varchar(100),
engmom varchar(100),
engdad varchar(100),
engsibling varchar(100),
engfriends varchar(100),
engschool varchar(100),
constraint fk_speakenglish foreign key(uniqueid) references task2_child
)

--creating table for child health conditions
create table task2_childhealth(
uniqueid varchar(100),
eyesight varchar(100),
hearingproblem varchar(100),
headaches varchar(100),
fever varchar(100),
stomachpain varchar(100),
noproblems varchar(100),
constraint fk_childhealth foreign key(uniqueid) references task2_child
)


--INSERTING DATA INTO TASK2 CHILD
INSERT INTO task2_child(uniqueid,schoolid,locality,province,gender,age)
select UNIQUEID,SCHOOLID,
case
when LOCALITY = '1' then 'rural'
when LOCALITY = '2' then 'urban' end,
case
when PROVINCE = '1' then 'Ben Tre'
when PROVINCE = '2' then 'Da Nang'
when PROVINCE = '3' then 'Hung Yen'
when PROVINCE = '4' then 'Lao Cai'
when PROVINCE = '5' then 'Phu Yen' end,
case
when GENDER = '1' then 'Male'
when GENDER = '2' then 'Female' end,
AGE from [dbo].[vietnam_wave_1]




--inserting data into task2_activityenglish table
insert into task2_activityenglish(uniqueid,readbook,watchtv,useinternet,writeemail)
select UNIQUEID,
case 
when STATEN01 ='0' then 'Reads Rarely'
when STATEN01 ='1' then 'Reads Often'
when STATEN01 ='2' then 'Reads Occasionally' 
when STATEN01 ='' then 'Unknown' end,
case
when STATEN02 = '0' then 'Watch Rarely'
when STATEN02 = '1' then 'Watch Often'
when STATEN02 = '2' then 'Watch Occasionally' 
when STATEN02 ='' then 'Unknown' end,
case
when STATEN03 = '0' then 'Useinternet Rarely'
when STATEN03 = '1' then 'Useinternet Often'
when STATEN03 = '2' then 'Useinternet Occasionally' 
when STATEN03 ='' then 'Unknown' end,
case
when STATEN04 = '0' then 'writeemail Rarely'
when STATEN04 = '1' then 'writeemail Often'
when STATEN04 = '2' then 'writeemail Occasionally' 
when STATEN04 ='' then 'Unknown' end from [dbo].[vietnam_wave_1]



--inserting data into task2_speakenglish table
insert into task2_speakenglish(uniqueid,engmom,engdad,engsibling,engfriends,engschool)
select UNIQUEID, 
case 
when STSPEN01 ='0' then 'Rarely Speak In English With Mom'
when STSPEN01 ='1' then 'Often Speak In English With Mom'
when STSPEN01 ='2' then 'Occasionally Speak In English With Mom' 
when STSPEN01 = '' then 'Unknown' end,
case 
when STSPEN02 ='0' then 'Rarely Speak In English With Dad'
when STSPEN02 ='1' then 'Often Speak In English With Dad'
when STSPEN02 ='2' then 'Occasionally Speak In English With Dad'
when STSPEN02 = '' then 'Unknown' end,
case 
when STSPEN03 ='0' then 'Rarely Speak In English With Siblings'
when STSPEN03 ='1' then 'Often Speak In English With Siblings'
when STSPEN03 ='2' then 'Occasionally Speak In English With Siblings'
when STSPEN03 = '' then 'Unknown' end,
case 
when STSPEN04 ='0' then 'Rarely Speak In English With Friends'
when STSPEN04 ='1' then 'Often Speak In English With Friends'
when STSPEN04 ='2' then 'Occasionally Speak In English With Friends'
when STSPEN04 = '' then 'Unknown' end,
case 
when STSPEN05 ='0' then 'Rarely Speak In English With Schoolmates'
when STSPEN05 ='1' then 'Often Speak In English With Schoolmates'
when STSPEN05 ='2' then 'Occasionally Speak In English With Schoolmates'
when STSPEN05 = '' then 'Unknown' end 
from [dbo].[vietnam_wave_1]



--inserting data into task2_childhealth table
insert into task2_childhealth(uniqueid,eyesight,hearingproblem,headaches,fever,stomachpain,noproblems)
select UNIQUEID,
case 
when STDHLTH1 = '0' then 'Dont Have Eyesight'
when STDHLTH1 = '1' then 'Have Eyesight'
when STDHLTH1 = '' then 'Unknown' end,
case 
when STDHLTH2 = '0' then 'Dont Have Hearing Problem'
when STDHLTH2 = '1' then 'Have Hearing Problem'
when STDHLTH2 = '' then 'Unknown' end,
case 
when STDHLTH3 = '0' then 'Dont Have Headache'
when STDHLTH3 = '1' then 'Have Headache'
when STDHLTH3 = '' then 'Unknown' end,
case 
when STDHLTH4 = '0' then 'Dont Have Fever'
when STDHLTH4 = '1' then 'Have Fever'
when STDHLTH4 = '' then 'Unknown' end,
case 
when STDHLTH5 = '0' then 'Dont Have Stomach Pain'
when STDHLTH5 = '1' then 'Have Stomach Pain'
when STDHLTH5 = '' then 'Unknown' end, 
case 
when STDHLTH0 = '0' then 'Dont Have Any Problems'
when STDHLTH0 = '1' then 'Have Problems'
when STDHLTH0 = '' then 'Unknown' end 
from [dbo].[vietnam_wave_1]

select * from task2_childhealth




--Report 1
create or alter view t2engactivity as
select readbook as Activity,count(readbook) as counts from [dbo].[task2_activityenglish]
where readbook = 'Reads Rarely' group by readbook
union
select readbook,count(readbook) as counts from [dbo].[task2_activityenglish]
where readbook = 'Reads Often' group by readbook
union
select readbook,count(readbook) as counts from [dbo].[task2_activityenglish]
where readbook = 'Reads Occasionally' group by readbook
union
select watchtv,count(watchtv) as counts from [dbo].[task2_activityenglish]
where watchtv = 'Watch Rarely' group by watchtv
union
select watchtv,count(watchtv) as counts from [dbo].[task2_activityenglish]
where watchtv = 'Watch Often' group by watchtv
union
select watchtv,count(watchtv) as counts from [dbo].[task2_activityenglish]
where watchtv = 'Watch Occasionally' group by watchtv
union
select useinternet,count(useinternet) as counts from [dbo].[task2_activityenglish]
where useinternet = 'Useinternet Rarely' group by useinternet
union
select useinternet,count(useinternet) as counts from [dbo].[task2_activityenglish]
where useinternet = 'Useinternet Often' group by useinternet
union
select useinternet,count(useinternet) as counts from [dbo].[task2_activityenglish]
where useinternet = 'Useinternet Occasionally' group by useinternet
union
select writeemail,count(writeemail) as counts from [dbo].[task2_activityenglish]
where writeemail = 'Writeemail Rarely' group by writeemail
union
select writeemail,count(writeemail) as counts from [dbo].[task2_activityenglish]
where writeemail = 'Writeemail Often' group by writeemail
union
select writeemail,count(writeemail) as counts from [dbo].[task2_activityenglish]
where writeemail = 'Writeemail Occasionally' group by writeemail

select * from t2engactivity


--Report 2
create or alter view t2speakenglish as
select engmom as Communication,count(engmom) as counts from [dbo].[task2_speakenglish]
where engmom = 'Rarely Speak In English With Mom' group by engmom
union
select engmom ,count(engmom) as counts from [dbo].[task2_speakenglish]
where engmom = 'Often Speak In English With Mom' group by engmom
union
select engmom ,count(engmom) as counts from [dbo].[task2_speakenglish]
where engmom = 'Occasionally Speak In English With Mom' group by engmom
union
select engdad ,count(engdad) as counts from [dbo].[task2_speakenglish]
where engdad = 'Rarely Speak In English With Dad' group by engdad
union
select engdad ,count(engdad) as counts from [dbo].[task2_speakenglish]
where engdad = 'Often Speak In English With Dad' group by engdad
union
select engdad ,count(engdad) as counts from [dbo].[task2_speakenglish]
where engdad = 'Occasionally Speak In English With Dad' group by engdad
union
select engsibling ,count(engsibling) as counts from [dbo].[task2_speakenglish]
where engsibling = 'Rarely Speak In English With Siblings' group by engsibling
union
select engsibling ,count(engsibling) as counts from [dbo].[task2_speakenglish]
where engsibling = 'Often Speak In English With Siblings' group by engsibling
union
select engsibling ,count(engsibling) as counts from [dbo].[task2_speakenglish]
where engsibling = 'Occasionally Speak In English With Siblings' group by engsibling
union
select engfriends ,count(engfriends) as counts from [dbo].[task2_speakenglish]
where engfriends = 'Rarely Speak In English With Friends' group by engfriends
union
select engfriends ,count(engfriends) as counts from [dbo].[task2_speakenglish]
where engfriends = 'Often Speak In English With Friends' group by engfriends
union
select engfriends ,count(engfriends) as counts from [dbo].[task2_speakenglish]
where engfriends = 'Occasionally Speak In English With Friends' group by engfriends
union
select engschool ,count(engschool) as counts from [dbo].[task2_speakenglish]
where engschool = 'Rarely Speak In English With Schoolmates' group by engschool
union
select engschool ,count(engschool) as counts from [dbo].[task2_speakenglish]
where engschool = 'Often Speak In English With Schoolmates' group by engschool
union
select engschool ,count(engschool) as counts from [dbo].[task2_speakenglish]
where engschool = 'Occasionally Speak In English With Schoolmates' group by engschool

select * from t2speakenglish

--Report 3
create or alter view t2childhealth as
select eyesight as Health_Conditions,count(eyesight) as counts from [dbo].[task2_childhealth]
where eyesight = 'Dont Have Eyesight' group by eyesight
union
select eyesight,count(eyesight) as counts from [dbo].[task2_childhealth]
where eyesight = 'Have Eyesight' group by eyesight
union
select hearingproblem,count(hearingproblem) as counts from [dbo].[task2_childhealth]
where hearingproblem = 'Dont Have Hearing Problem' group by hearingproblem
union
select hearingproblem,count(hearingproblem) as counts from [dbo].[task2_childhealth]
where hearingproblem = 'Have Hearing Problem' group by hearingproblem
union
select headaches,count(headaches) as counts from [dbo].[task2_childhealth]
where headaches = 'Dont Have Headache' group by headaches
union
select headaches,count(headaches) as counts from [dbo].[task2_childhealth]
where headaches = 'Have Headache' group by headaches
union
select fever,count(fever) as counts from [dbo].[task2_childhealth]
where fever = 'Dont Have Fever' group by fever
union
select fever,count(fever) as counts from [dbo].[task2_childhealth]
where fever = 'Have Fever' group by fever
union
select stomachpain,count(stomachpain) as counts from [dbo].[task2_childhealth]
where stomachpain = 'Dont Have Stomach Pain' group by stomachpain
union
select stomachpain,count(stomachpain) as counts from [dbo].[task2_childhealth]
where stomachpain = 'Have Stomach Pain' group by stomachpain
union
select noproblems,count(noproblems) as counts from [dbo].[task2_childhealth]
where noproblems = 'Dont Have Any Problems' group by noproblems
union
select noproblems,count(noproblems) as counts from [dbo].[task2_childhealth]
where noproblems = 'Have Problems' group by noproblems

select * from t2childhealth