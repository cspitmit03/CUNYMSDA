/*
HW#4 Self Joins Assignment
 */

DROP TABLE IF EXISTS apple;

CREATE TABLE apple (
  EmpID int PRIMARY KEY, -- employee id --
  EmpName varchar(50) NOT NULL, -- employee name --
  EmpTitle varchar(50) NOT NULL, -- employee title--
  SupID int null -- supervisor of employee--
);

INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 1, 'Steve Jobs', 'CEO', NULL);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 2, 'Jonathan Ive', 'SVP, Industrial Design', 1);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 3, 'Timothy Cook','COO', 1);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 4, 'Scott Forstall','SVP IOS Software', 1);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 5, 'Kim Vorrath', 'VP, Program Management', 4);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 6, 'John Brandon', 'VP, Channel Sales', 3);
INSERT INTO apple ( EmpID, EmpName, EmpTitle, SupID ) VALUES ( 7, 'Michael Fenger', 'VP, Iphone Sales', 3);

select * from apple;

SELECT parent.EmpName AS Supervisor, child.EmpName AS Employee
  FROM apple parent
       left JOIN apple child
       ON child.SupID = parent.EmpID
ORDER BY Supervisor, Employee;
       