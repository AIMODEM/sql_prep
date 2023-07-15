/* In this video we will discuss a problem where we need to find player with no of gold medals won by them
only for players who won only gold medals.
YouTube link : https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E
*/
-- Write a query to find num of gold medals per swimmer for swimmers who won only gold medals. 
-- The swimmer should have won only gold medals but not won any other medals like Silver or Bronze.
-- 2 methods : 1) Using sub query 2) Using group by having cte

/*
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');
*/

select * from events;

-- Solution 1:
SELECT GOLD as player_name, count(1) as Num_of_Gold_Medals
FROM   events
WHERE GOLD NOT IN (SELECT SILVER FROM events UNION ALL SELECT BRONZE FROM events)
GROUP BY GOLD
order by Num_of_Gold_Medals DESC; -- ASC

-- Solution 2:
with cte as (
SELECT  gold as player_name, 'Gold' as medal_type   FROM events
UNION   ALL SELECT  Silver as player_name, 'Silver' as medal_type   FROM events
UNION   ALL SELECT  bronze as player_name, 'bronze' as medal_type   FROM events)
SELECT  player_name , COUNT(1) as Num_of_gold_medals
FROM cte 
GROUP BY player_name
HAVING count(distinct medal_type)=1 and max(medal_type)='gold';
