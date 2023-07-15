/* 
YouTube link : https://www.youtube.com/watch?v=FZ0GCcnIIWA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=2
Solving a REAL Business Use Case Using SQL | Business Days Excluding Weekends and Public Holidays.

In this video we are going to solve a very important business use case where we need to find difference
between 2 dates excluding weekends and public holidays.
Basically we need to find business days between 2 given dates using SQL.
*/

/*
-- =================================================================
create table tickets (
ticket_id varchar(10),
create_date date,
resolved_date date
);

delete from tickets;

insert into tickets values
(1,'2022-08-01','2022-08-03'),
(2,'2022-08-01','2022-08-12'),
(3,'2022-08-01','2022-08-16');
-- =================================================================
create table holidays(
holiday_date date,
reason varchar(100)
);

delete from holidays;

insert into holidays values
('2022-08-11','Rakhi'),
('2022-08-15','Independence day');
-- =================================================================
*/

SELECT * FROM tickets;
SELECT * FROM holidays;

-- Basically we need to find business days between 2 given dates using SQL.
-- excluding weekends and public holidays.
   -- we'll first consider weekends and the consider public holidays.
   -- we'll then merge them.

-- we'll first find the difference between these two dates.
SELECT *, DATEDIFF(DAY, create_date, resolved_date) as Num_of_days_diff
FROM tickets;

-- Now subtract the weeekends from the Num_of_days_diff.
-- find the num of weeks between these 2 dates.
SELECT *, DATEDIFF(DAY, create_date, resolved_date) as Num_of_days_diff,
        DATEPART(WEEK, create_date) as week_num_create,
        DATEPART(WEEK, resolved_date) as week_num_resolved,
        DATEDIFF(WEEK, create_date, resolved_date) as Num_of_weeks_diff
FROM tickets;

-- Now we got the num of weeks between 2 dates.
-- every week will have 2 weekends, so subtract the num of days
-- based on Num_of_weeks_diff.
-- Num_of_days_diff - 2*(Num_of_weeks_diff)
SELECT *, DATEDIFF(DAY, create_date, resolved_date) as Num_of_days_diff,
        DATEDIFF(DAY, create_date, resolved_date) - 2 * DATEDIFF(WEEK, create_date, resolved_date) as business_days
FROM tickets;

-- Now, we got the num of business days after removing weekends.
-- we also have to remove the public holidays to get actual business days.

SELECT  ticket_id, create_date, resolved_date, COUNT(holiday_date) as Num_of_holidays
FROM    tickets
LEFT JOIN   holidays ON holiday_date BETWEEN create_date AND resolved_date
GROUP BY    ticket_id, create_date, resolved_date;

-- Now we got the num of holidays.
-- now combine them together.

SELECT  *,
        2*DATEDIFF(WEEK, create_date, resolved_date) as Num_of_weekends,
        DATEDIFF(DAY, create_date, resolved_date) - 2 * DATEDIFF(WEEK, create_date, resolved_date) - Num_of_holidays as business_days,
        DATEDIFF(DAY, create_date, resolved_date) as todal_num_of_days
FROM    (select    ticket_id, create_date, resolved_date, COUNT(holiday_date) as Num_of_holidays
         FROM   tickets
         LEFT JOIN holidays ON holiday_date BETWEEN create_date AND resolved_date
         GROUP BY ticket_id, create_date, resolved_date
         ) A;

-- Total business days = Total num of days btw 2 dates - (Total_holidays + 2*(Num_of_weeks))
-- we now got the final number of business days between the 2 given dates.

-- ASSIGNMENT :
    -- What if the public holiday falls on weekend ???