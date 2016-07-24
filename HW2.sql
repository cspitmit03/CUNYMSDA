-- create video table for assignment--
-- #1 --

CREATE TABLE Videos(
    VideoID integer not null, -- ID for video
    title  text,              -- title for the video
    timing   real not null,   -- minutes converted to real number 3.5 = 3:30
    URL text,                 -- the location of the video in youtube
    primary key(VideoID)
);

insert into Videos values(1, 'Export Access Database to MySQL', 2+54/60, 'https://www.youtube.com/watch?v=m9LxGF3Qc90');
insert into Videos values(2, 'MySQL Workbench Tutorial', 13+47/60, 'https://www.youtube.com/watch?v=X_umYKqKaF0');
insert into Videos values(3, 'MySQL Tutorial', 41+9/60, 'https://www.youtube.com/watch?v=yPu6qV5byu4');


select * from Videos


-- create reviewers table for assignemnt --
-- #2 --
drop table Reviews;

CREATE TABLE Reviews(
    ReviewerID integer not null, 	-- ID for Reviewer
    ReviewerName text,            	 -- Name of Reviewer
    rating  integer,  				 -- rating for video
    review text,                 	 -- review of the video
    VideoID integer not null, 		 -- ID of the Video being reviewed
    primary key(ReviewerID)
);

insert into Reviews values(1, 'Cesar', 5, 'great video to move access data', 1);
insert into Reviews values(2, 'George', 4, 'nice and short, please make more!', 1);
insert into Reviews values(3, 'Alex', 4, 'lifesaver!', 3);
insert into Reviews values(4, 'Luciano', null, 'way to long, so long I didnt want to rate it!', 3);

select * from Reviews

-- join the tabels --
-- #3 --

select * 
from Videos a
left join Reviews b
on a.VideoID = b.VideoID