use hrdata;
/* clean up statements
#SET SQL_SAFE_UPDATES = 0;
#Update hrdataset_v14_14 Set salary=  REPLACE(salary, ',', '')
#where salary LIKE'%,%';

#ALTER TABLE hrdataset_v14_14 Modify column salary int(11);  
*/

select * from hrdataset_v14_14;

#who was termindated
select *
from hrdataset_v14_14
where termD=1
order by empID asc
;

#scored of performance and engagement socre
select termReason, EngagementSurvey, EmpSatisfaction, Absences, PerformanceScore, Salary
from hrdataset_v14_14
where termD=1
;

#second highest salary of employee
select empID, salary, termReason
from hrdataset_v14_14
where termD=1
order by salary desc
limit 1,1;
;


select termReason, count(Absences) as peopleFired, avg(EngagementSurvey) as averageEngagementScorebyDepartment, avg(EmpSatisfaction) as averageEmpSatisfactionbyDepartment
from hrdataset_v14_14
where termD=1
group by termReason
;

#manager termination data
select ManagerName, Count(termD) as peopleFired, department
from hrdataset_v14_14
where termD=1
group by ManagerName, department
;

#percentage of termindated by gender--wrong

select  h.sex, count(h.termD) as peopleFired, count(h.termD)/temp.TOTAL *100  as percentagebyRace
from hrdataset_v14_14 as h
INNER JOIN (SELECT COUNT(*) as TOTAL from hrdataset_v14_14 h1 where h1.termD=1 ) as temp 
where h.termD=1
group by h.sex, h.termD, temp.TOTAL, empID
order by empID asc
;


#percentage of fired that are by race
#one comment on this data set, is if hispanic is overlapping with white as there is a recent census change
select  h.racedesc, count(h.termD), count(h.termD)/temp.TOTAL *100  
from hrdataset_v14_14 as h
INNER JOIN (SELECT COUNT(*) as TOTAL from hrdataset_v14_14 h1 where h1.termD=1 ) as temp 
where h.termD=1
group by h.racedesc, h.termD, temp.TOTAL
order by count(h.termD) desc
;


#percentage of fired that are by department
# the production department has an overwhelming number of terminations
select  h.department, count(h.termD) as firedperdepartment, count(h.termD)/temp.TOTAL *100  as percentage
from hrdataset_v14_14 as h
INNER JOIN (SELECT COUNT(*) as TOTAL from hrdataset_v14_14 h1 where h1.termD=1 ) as temp 
where h.termD=1
group by h.department, h.termD, temp.TOTAL
Order by count(h.termD) desc
;

select  termReason, Count(termD) as peoplefired
from hrdataset_v14_14 
where termD=1
group by termReason, termD
order by Count(termD) desc
;

#average lenght of stay based on reason for leaving
select empID, termReason, dateofHire, dateofTermination, datediff(dateofHire,dateofTermination) as LOS
from hrdataset_v14_14 
where termD=1
group by termReason, dateofHire, dateofTermination, empID
order by empid asc
;







