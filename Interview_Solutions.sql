/*
Interview solution submittes May 2022, and updated July 2022.
*/

use Interview_Questions;


Create table if not exists teachers(id integer, name varchar(100), school_id varchar(100), age integer);
Create table if not exists schools(id integer, name varchar(100));
INsert IGNORE into schools (id, name) 
    values 
        (1, 'Smith_HS'),
        (2, 'Johnson_HS'),
        (3, 'Williams_HS'),
        (4, 'Brown_HS'),
        (5, 'Jones_HS'),
        (6, 'Garcia_HS');
Insert IGNORE into teachers (id, name, school_id, age) 
    values 
        ('123', 'Adelind',	6,	36),
        ('120',	'Damaris',	4,	49),
        ('165', 'Valaree', 2, 37),
        ('142', 'Floris', 5, 64),
        ('155', 'Cesya', 1, 37),
        ('175', 'Carmita', 3, 42),
        ('133', 'Tamiko', 3, 37),
        ('117', 'Dorena', 4, 55),
        ('188', 'Pia', 5, 39),
        ('122', 'Kirby', 3, 37),
        ('136', 'Conney', 4, 29),
        ('138', 'Noreen', 6, 34),
        ('154', 'Janey', 6, 45),
        ('200', 'Madelyn', 4, 48),
        ('130', 'Dora', 3, 58),
        ('182', 'Sallyanne', 3, 27),
        ('107', 'Ernesta', 4, 	62),
        ('189', 'Evie', 5, 63),
        ('109', 'Dorene', 6, 40),
        ('173', 'Eveleen', 4, 26),
        ('181',	'Rudy',	2, 41);
/* Please write SQL queries to answer the following: */

/* 1. Output a list of all teacher names and the name of the school they teach. */
SELECT t.Name as teacher,  s.name as school
FROM teachers t , schools s
WHERE t.school_id = s.id
GROUP BY s.name, t.Name; 
 
 

/* 2. Output the school name and average age of teachers at each school. */
SELECT s.name as School_Name,  AVG(t.age) as AVG_age
FROM teachers t, schools s
WHERE s.id = t.school_id
GROUP BY s.name;

/* 3. Output the name and age of the oldest teacher(s) at each school. */

SELECT t.school_id, t.Name as teacher_name, t.age as teacher_age, s1.name as School_name
FROM teachers t 
    INNER JOIN schools s1 ON s1.id = t.school_id AND t.age = (
		SELECT MAX(t1.age) 
        FROM teachers t1  
        WHERE t1.school_id=s1.id
        )
group by t.school_id, t.Name, t.age , s1.name
order by t.school_id
;


/* 4. Challenge: Output the difference in age between each teacher and the next oldest teacher at each school.*/

 
SELECT t.school_id, t.name ,t.age, t.age-( ifnull((
                                SELECT t1.age 
                                FROM teachers t1 
                                WHERE t.school_id = t1.school_id AND t.id != t1.id AND t.age >= t1.age 
                                ORDER BY t1.age DESC LIMIT 1),0) )AS Difference
FROM teachers t
GROUP BY t.school_id, t.age, t.name,  t.id
ORDER BY t.school_id  
;


