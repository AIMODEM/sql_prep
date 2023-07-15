/*
YouTube Link : https://www.youtube.com/watch?v=oGYinDMDfnA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=3

Amazon SQL Interview Question for Data Analyst Position [2-3 Year Of Experience ] | Data Analytics.

we are going to discuss an SQL interview problem where we need to find number of employees inside the hospital.
We will solve this problem with 3 methods: 1) having 2) joins 3) magic

*/

/*
create  table hospital  (emp_id int,
                        action varchar(10),
                        time datetime);
insert into hospital values 
 ('1', 'in', '2019-12-22 09:00:00'),
 ('1', 'out', '2019-12-22 09:15:00'),
 ('2', 'in', '2019-12-22 09:00:00'),
 ('2', 'out', '2019-12-22 09:15:00'),
 ('2', 'in', '2019-12-22 09:30:00'),
 ('3', 'out', '2019-12-22 09:00:00'),
 ('3', 'in', '2019-12-22 09:15:00'),
 ('3', 'out', '2019-12-22 09:30:00'),
 ('3', 'in', '2019-12-22 09:45:00'),
 ('4', 'in', '2019-12-22 09:45:00'),
 ('5', 'out', '2019-12-22 09:40:00');
 */

 SELECT * FROM hospital;

 