-- create Tables for keycard project--
-- 3 main tables and 2 bridge tables will be created
-- 3 main tables are Users, Groups, Rooms.
-- 2 bridge tables will be Users_Groups which will link users and groups they belong to.  --
-- This was done because in the future a user could belong to two groups.--
-- the second bridge table will be grouprooms which will link which groups and the rooms they have access to.  --

-- create main tables and insert data--
drop table if exists Users;
drop table if exists Groups;
drop table if exists Rooms;
drop table if exists User_Groups;
drop table if exists Groups_Rooms;

CREATE TABLE Users(
    UserID int PRIMARY KEY, -- ID for User
    UserName varchar(50) not null              -- name for user
);

insert into Users values(1, 'Modesto');
insert into Users values(2, 'Ayine');
insert into Users values(3, 'Christopher');
insert into Users values(4, 'Cheong woo');
insert into Users values(5, 'Saulat');
insert into Users values(6, 'Heidy');


CREATE TABLE Groups(
    GroupID int PRIMARY KEY, -- ID for Group
    GroupName varchar(50) not null              -- name for Group
);

insert into Groups values(1, 'I.T.');
insert into Groups values(2, 'Sales');
insert into Groups values(3, 'Administration');
insert into Groups values(4, 'Operations');

CREATE TABLE Rooms(
    RoomID int PRIMARY KEY, -- ID for Room
    RoomName varchar(50) not null              -- name for Room
);

insert into Rooms values(1, '101');
insert into Rooms values(2, '102');
insert into Rooms values(3, 'Administration A');
insert into Rooms values(4, 'Administration B');

-- create link tables --
CREATE TABLE User_Groups
(
  UserID int NOT NULL REFERENCES Users(UserID),
  GroupID int NOT NULL REFERENCES Groups(GroupID),
  CONSTRAINT pk_User_Groups PRIMARY KEY(UserID, GroupID)
 );

INSERT INTO User_Groups (UserID, GroupID) VALUES ( 1, 1);
INSERT INTO User_Groups (UserID, GroupID) VALUES ( 2, 1);
INSERT INTO User_Groups (UserID, GroupID) VALUES ( 3, 2);
INSERT INTO User_Groups (UserID, GroupID) VALUES ( 4, 2);
INSERT INTO User_Groups (UserID, GroupID) VALUES ( 5, 3);

CREATE TABLE Groups_Rooms
(
  GroupID int NOT NULL REFERENCES Groups(GroupID),
  RoomID int NOT NULL REFERENCES Rooms(RoomID),
  CONSTRAINT pk_Groups_Rooms PRIMARY KEY(GroupID, RoomID)
 );

INSERT INTO Groups_Rooms (GroupID, RoomID) VALUES ( 1, 1);
INSERT INTO Groups_Rooms (GroupID, RoomID) VALUES ( 1, 2);
INSERT INTO Groups_Rooms (GroupID, RoomID) VALUES ( 2, 2);
INSERT INTO Groups_Rooms (GroupID, RoomID) VALUES ( 2, 3);

select * from Users;
select * from Groups;
select * from Rooms;
select * from User_Groups;
select * from Groups_Rooms;


-- SELECT STATEMENTS TO PROVIDE INFORMATION --
select g.GroupName, u.UserName
from Groups g 	left join User_Groups ug on g.GroupID = ug.GroupID
				left join Users u on ug.UserID = u.UserID
Order by g.GroupName, u.UserName;

select r.RoomName, g.GroupName
from Rooms r 	left join Groups_Rooms gr on r.RoomID = gr.RoomID
				left join Groups g on gr.GroupID = g.GroupID
Order by r.RoomName, g.GroupName;

select u.UserName, g.GroupName, r.RoomName
from Users u	left join User_Groups ug on u.UserID = ug.UserID
				left join Groups g on ug.GroupID = g.GroupID
                left join Groups_Rooms gr on g.GroupID = gr.GroupID
                left join Rooms r on gr.RoomID = r.RoomID
order by u.UserName, g.GroupName, r.RoomName;
