/* final project for MSDA Bridge Summer 2016
Cesar Espitia
cesar.espitia@gmail.com
*/

drop schema if exists BuildingEnergy;

/* Part 1
*/

CREATE SCHEMA BuildingEnergy;

USE BuildingEnergy;

/* Part 2
Create Tables EnergyCategories and EnergyTypes
*/

CREATE TABLE EnergyCategories(
    ECID int PRIMARY KEY, -- ID for Energy Category
    ECName varchar(50) not null              -- Name of Category
);

CREATE TABLE EnergyTypes(
    ETID int PRIMARY KEY, -- ID for Energy Category
    ETName varchar(50) not null,  -- Name of Type
    ECID int not null  -- energy category relation
);

insert into EnergyCategories values(1, 'Fossil');
insert into EnergyCategories values(2, 'Renewable');

insert into EnergyTypes values(1, 'Electricity', 1);
insert into EnergyTypes values(2, 'Gas', 1);
insert into EnergyTypes values(3, 'Steam', 1);
insert into EnergyTypes values(4, 'Fuel Oil', 1);
insert into EnergyTypes values(5, 'Solar', 2);
insert into EnergyTypes values(6, 'Wind', 2);


/* Part 3
Join Statement
*/

select ECName, ETName
from EnergyCategories EC
		join EnergyTypes ET
        on EC.ECID = ET.ECID
group by ECName, ETName
order by ETName Asc;

/* Part 4
Create Building and many2many relationships
*/

CREATE TABLE Buildings(
    BID int PRIMARY KEY, -- ID for Building
    BuildingName varchar(50) not null              -- Name of Building
);

insert into Buildings values(1, 'Empire State Building');
insert into Buildings values(2, 'Chrysler Building');
insert into Buildings values(3, 'Borough of Manhattan Community College');

-- creating linking table --

CREATE TABLE Buildings_EnergyTypes
(
  BID int NOT NULL REFERENCES Buildings(BID),
  ETID int NOT NULL REFERENCES EnergyTypes(ETID),
  CONSTRAINT pk_Buildings_EnergyTypes PRIMARY KEY(BID, ETID)
 );

INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 1, 1);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 1, 2);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 1, 3);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 2, 1);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 2, 3);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 3, 1);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 3, 3);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 3, 5);

/* Part 5
Join Statement
*/

select b.BuildingName, et.ETName
from Buildings b 	left join Buildings_EnergyTypes bet on b.BID = bet.BID
				left join EnergyTypes et on bet.ETID = et.ETID
group by b.BuildingName, et.ETName
Order by b.BuildingName;

/* Part 6
Add information to Building Energy Databse
*/

insert into Buildings values(4, 'Bronx Lion House');
insert into Buildings values(5, 'Brooklyn Childrens Museum');

insert into EnergyTypes values(7, 'Geothermal', 2);

INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 4, 7);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 5, 1);
INSERT INTO Buildings_EnergyTypes (BID, ETID) VALUES ( 5, 7);


/* Part 7 Write SQL displaying buildings that use renewable energy
*/

select b.BuildingName, et.ETName, ec.ECName
from Buildings b 	left join Buildings_EnergyTypes bet on b.BID = bet.BID
				left join EnergyTypes et on bet.ETID = et.ETID
                left join EnergyCategories ec on et.ECID = ec.ECID
where ec.ECID = 2
group by b.BuildingName, et.ETName, ec.ECName
Order by b.BuildingName;

/* Part 8
Frequencey Query
*/

select et.ETName, count(BID) as Count
from Buildings_EnergyTypes bet
	left join EnergyTypes et on bet.ETID = et.ETID
group by et.ETName
order by count desc;


select * from EnergyTypes;
select * from EnergyCategories;
select * from Buildings_EnergyTypes;

/* Part 9
Do one of the following
-- for 9A
-- You would change the EnergyTypes table only in this project tot he following.

ALTER TABLE EnergyTypes
CONTRAINT FK_EC
FOREIGN KEY (ECID) references EnergyCategories(ECID)
ON UPDATE CASCADE
ON DELETE CASCADE
);


--9B see attached PDF to github.

--9D
I would make 1 table changes.  The first is in the linking table Building_EnergyTypes and the second in ENergy Types.  
The linking table would have a date for the values entered into the table.
Report would then take the count of buildings with a specific energy type and show it as either a pie chart by year or a columb bar chart.

Example

1950 - 25% Gas 25% steam 50% electricity
2016 - 25% steam 25% solar 25% electricity 25% gas


*/