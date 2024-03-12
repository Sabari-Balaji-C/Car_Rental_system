create database car_rental;
use car_rental;

-- 1.Vehicle table
create table vehicle (
    vehicleId int primary key,
    make varchar(100),
    model varchar(100),
    year int,
    dailyRate decimal(10, 2),
    status enum('1','0'),
    passengerCapacity int,
    engineCapacity int 
);
drop table Vehicle;
select * from Vehicle;
insert into Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
values
(1, 'Toyota', 'Camry', 2022, 50.00, '1', 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, '1', 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, '0', 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, '1', 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, '1', 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, '0', 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, '1', 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, '1', 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, '0', 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, '1', 4, 2500);

-- 2.Customer table
create table Customer (
    customerId int primary key,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(100),
    phoneNumber varchar(100)
);
insert into Customer (customerID, firstName, lastName, email, phoneNumber)
values
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');
drop table Customer;
desc Customer;
select * from customer;

-- 3.Lease table
create table Lease (
    leaseId int primary key,
    vehicleId int,
    customerId int,
    startDate date,
    endDate date,
    type enum('DailyLease', 'MonthLylease'),
    foreign key (vehicleId) references Vehicle(vehicleId),
    foreign key (customerId) references Customer(customerId)
);
insert into Lease (leaseID, vehicleID, customerID, startDate, endDate, Type)
values
(1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'DailyLease'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease');
select * from Lease;
desc lease;
drop table Lease;

-- 4. Payment table
create table Payment (
    paymentId int primary key,
    leaseId int,
    paymentDate date,
    amount decimal(10, 2),
    foreign key (leaseId) references Lease(leaseId)
);
insert into Payment (paymentID, leaseID, paymentDate, amount)
values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);
select * from Payment;
desc Payment;

select * from Vehicle;
select * from customer;
select * from Lease;
select * from Payment;

-- 1. Update the daily rate for a Mercedes car to 68.
update Vehicle set dailyRate=68 where make="Mercedes";

-- 2. Delete a specific customer and all associated leases and payments. 
delete from Payment where leaseId=1;
delete from Lease where CustomerId=1;
delete from Customer where customerId=1;

-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate".
 alter table Payment 
change paymentDate  transactionDate date ;

-- 4. Find a specific customer by email. 
select * from Customer where email="robert@example.com";

-- 5. Get active leases for a specific customer.
select l.*
from Lease l
join Customer c on l.customerID = c.customerID
where l.endDate >= "2023-03-12";

select * from Vehicle;
select * from customer;
select * from Lease;
select * from Payment;

-- 6. Find all payments made by a customer with a specific phone number.
select p.* from Payment p
join Lease l on p.leaseId=l.leaseId
join customer c on l.customerId=c.customerId
where c.phoneNumber="555-123-4567";

-- 7. Calculate the average daily rate of all available cars.
select avg(dailyRate) as average  from Vehicle;

-- 8. Find the car with the highest daily rate.
select max(dailyRate) as Max_dailyRate from Vehicle;

-- 9. Retrieve all cars leased by a specific customer.
select c.customerId,v.*,l.leaseId,l.startDate,l.endDate,l.type from vehicle v
join Lease l on v.vehicleId=l.vehicleId
join Customer c on l.customerId=c.customerId
where c.customerId = 2;

-- 10. Find the details of the most recent lease.
select * from Lease order by startDate desc limit 1;

select * from Vehicle;
select * from customer;
select * from Lease;
select * from Payment;

-- 11. List all payments made in the year 2023.
select * from Payment where year(TransactionDate)=2023;

-- 12. Retrieve customers who have not made any payments.
select c.* from Customer c
join Lease l on c.customerId=l.customerId
join Payment p on l.leaseId=p.leaseId
where p.paymentId is null;

-- 13. Retrieve Car Details and Their Total Payments.
select v.* ,p.amount from Vehicle v
join Lease l on v.vehicleId=l.vehicleId
join Payment p on l.leaseId=p.leaseId
where v.make="Honda";

-- 14. Calculate Total Payments for Each Customer.
select sum(p.amount) as total  from Payment p
join Lease l on p.LeaseId=l.leaseId
join Customer c on l.customerId=c.customerId
group by c.customerId;

-- 15. List Car Details for Each Lease.
select l.leaseId, v.* from Lease l
join Vehicle v  on l.vehicleId=v.vehicleId;

select * from Vehicle;
select * from customer;
select * from Lease;
select * from Payment;

-- 16. Retrieve Details of Active Leases with Customer and Car Information.
select v.* from Lease l
join Vehicle v  on l.vehicleId=v.vehicleId
where l.endDate <="2023-12-03";

-- 17. Find the Customer Who Has Spent the Most on Leases. 
select c.*from Customer c
join Lease l on c.customerId=l.customerId
join Payment p on l.leaseId=p.leaseId
order by amount desc limit 1;

-- 18. List All Cars with Their Current Lease Information.
select v.make,l.* from Lease l
join Vehicle v on l.vehicleId=v.vehicleId;

