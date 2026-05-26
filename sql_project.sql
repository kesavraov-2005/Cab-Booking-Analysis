create database sql_project;
use sql_project;

-- 1.	Select all rides where fare is greater than 200
select * from rides where fare > 200;
-- 2.	Retrieve users who signed up after '2023-01-01'
select user_id,user_name from users where signup_date > 2023-01-01;
-- 3.	Select drivers with rating greater than 4.5
select driver_id,driver_name,rating from drivers where rating > 4.5;
-- 4.	Get rides where distance is between 5 and 15 km
select driver_id,distance_km from rides where distance_km between 5 and 15;
-- 5.	Retrieve rides where status = 'completed' and fare > 100
select * from rides where status = 'completed' and fare > 100;
-- 6.	Select users from Chennai or Bangalore
select user_id, city from users where city = 'Chennai' or 'Bangalore';
-- 7.	Get drivers whose name starts with 'A'
select * from drivers where driver_name like 'a%';
-- 8.	Select rides where payment method is 'UPI' (using JOIN)
select r.ride_id, p.payment_method from rides as r  join payments as p on r.ride_id = p.ride_id where payment_method = 'UPI';
-- 9.	Retrieve rides where fare is not equal to 0
select ride_id, fare from rides where fare != 0;
-- 10.	Select users who signed up in the month of January
select user_id,user_name,signup_date from users where signup_date like '_%01%_';

-- 11.	Select user name and ride fare where fare > 200
select u.user_name,r.fare from users as u join rides as r on u.user_id = r.user_id where fare > 200;
-- 12.	Get driver name and ride distance where distance > 10
select d.driver_name, r.distance_km from drivers as d join rides as r on d.driver_id = r.driver_id where distance_km > 10;
-- 13.	Retrieve rides where payment status = 'failed' with user name
select r.ride_id, u.user_name from rides as r join users as u on r.user_id = u.user_id where status = 'cancelled';
-- 14.	Select users who booked rides (based on driver city different from user city)
select distinct u.* from rides as r join users as u on r.user_id = u.user_id join drivers as d on r.driver_id = d.driver_id where u.city != d.city;
-- 15.	Get completed rides with user and driver details
select r.user_id,d.* from rides as r join drivers as d on r.driver_id = d.driver_id where status = 'completed';
-- 16.	Select rides where driver rating > 4.5
select r.*, d.rating from rides as r join drivers as d on r.driver_id = d.driver_id where rating > 4.5;
-- 17.	Retrieve rides where payment method = 'Cash'
select r.*,p.payment_method from rides as r join payments as p on r.ride_id = p.ride_id where payment_method = 'cash';
-- 18.	Select rides where both user and driver belong to same city
select r.* from rides r join users u on r.user_id = u.user_id join drivers d on r.driver_id = d.driver_id where u.city = d.city;
-- 19.	Get rides where payment failed but ride is completed
select r.*,p.payment_status from rides as r join payments as p on r.ride_id = p.ride_id where payment_status ='failed' and status ='completed';
-- 20.	Select users who have taken rides with fare > 500
select u.*,r.fare from users as u join rides as r on r.user_id = u.user_id where fare > 500;

-- 21.	Find total rides per user where total rides > 2
select user_id, count(ride_id) as total_ride from rides group by user_id having count(ride_id) >2;
-- 22.	Get total earnings per driver where earnings > 1000
select driver_id, sum(fare) as total_fare from rides where fare > 1000 group by driver_id;
-- 23.	Calculate average fare per user city where avg fare > 150
select u.city, avg(r.fare) as average_fare from rides as r join users as u on r.user_id = u.user_id group by city having avg(fare) > 150;
-- 24.	Count rides per day where rides > 5
select ride_date, count(ride_id) as rides from rides where ride_id > 5 group by ride_date;
-- 25.	Find users with total distance traveled > 50 km
select user_id,sum(distance_km) as total_distance from rides group by user_id having sum(distance_km) > 50;
-- 26.	Get drivers with more than 3 completed rides
select driver_id,count(status) as complete_count from rides group by driver_id having count(status) > 3;
-- 27.	Find payment methods used more than 2 times
select payment_method, count(payment_method) as payment_method_count from payments group by payment_method having count(payment_method) > 2;
-- 28.	Get cities with more than 10 users
select city,count(user_id) as number_of_user from users where user_id > 10 group by city;
-- 29.	Find drivers with rating > 4.2 (instead of avg)
select driver_id,sum(rating) from drivers where rating > 4.2 group by driver_id;
-- 30.	Count cancelled rides per user where count > 1
select user_id,count(status) from rides where status = "cancelled" group by user_id having count(status) > 1;

-- 31.	Select top 5 rides with highest fare
select * from rides order by fare desc limit 5;
-- 32.	Get lowest 3 distance rides
select * from rides order by distance_km asc limit 3;
-- 33.	Retrieve top 5 users based on total spending
select user_id,sum(fare) as total_fare from rides group by user_id order by total_fare desc limit 5;
-- 34.	Select top 3 drivers with highest rating
select driver_id,sum(rating) as highest_rating from drivers group by driver_id order by highest_rating desc limit 3;
-- 35.	Get 2nd highest fare ride using LIMIT OFFSET
select ride_id,sum(fare) as total_fare from rides group by ride_id order by total_fare desc limit 1 offset 1;

-- 36.	Select users whose total spending is greater than average spending
select user_id,fare from rides where fare > (select avg(fare) from rides);
-- 37.	Get drivers earning more than average driver earning
select driver_id,fare from rides where fare > (select avg(fare) from rides);
-- 38.	Retrieve rides where fare > average fare
select * from rides where fare > (select avg(fare) from rides);
-- 39.	Select users who have no rides
select * from users where user_id not in(select user_id from rides);
-- 40.	Get drivers who have no completed rides
select driver_id from rides where ride_id not in (select ride_id from rides where status = 'completed');
-- 41.	Select rides with maximum fare
select * from rides where fare = (select max(fare) from rides);
-- 42.	Retrieve users with highest number of rides
select u.*,r.ride_id from users as u join rides as r on u.user_id = r.user_id where r.ride_id = (select ride_id from rides group by ride_id order by count(ride_id) limit 1);
-- 43.	Select second highest earning driver
select * from drivers where driver_id = (select driver_id from rides group by driver_id order by sum(fare) desc limit 1 offset 1);
-- 44.	Get rides where fare > user’s average fare
select r.* from rides r where r.fare > (select avg(fare) from rides where user_id = r.user_id);
-- 45.	Select users who made only one ride
select user_id from rides group by user_id having count(ride_id) = 1;

-- 46.	Update ride status to 'completed' where payment status = 'success'
update  rides as r, payments as p set r.status = "completed" where p.payment_status = 'success' ;
select status from rides;
-- 47.	Delete rides where status = 'cancelled' and fare = 0
delete from rides where status = 'cancelled' and fare = 0;
-- 48.	Update driver rating where rating < 3
update drivers set rating = 3 where rating < 3;
select rating from drivers;

-- 49.	Create a stored procedure to select rides of a user where fare > given amount
delimiter $$
create procedure get_user(in amount int)
begin 
	select user_id from rides where fare > amount;
end $$
call get_user(300)
-- 50.	Create a stored procedure to get drivers where rating > given value
delimiter $$
create procedure get_drivers_details(in value decimal(2,1))
begin
	select * from drivers where rating > value;
end $$
call get_drivers_details(4.5)

































