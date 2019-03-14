USE ALee_2019

GO
/*drop tables*/
DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS GuestLevel;
DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS Counts;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS SuppliesReceived;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Roles;


CREATE TABLE Roles(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Description VARCHAR(MAX)

);
CREATE TABLE Location(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);
CREATE TABLE Users(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	RoleID INT FOREIGN KEY REFERENCES Roles(ID)
);

/* Created tables */
CREATE TABLE Tavern(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	LocationID INT FOREIGN KEY REFERENCES Location(ID),
	OwnerID INT FOREIGN KEY REFERENCES Users(ID)
);

CREATE TABLE Supplies(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Unit VARCHAR(50),
);
CREATE TABLE SuppliesReceived(
	ID INT identity Primary Key,
	Date DATETIME,
	QTY DECIMAL,
	COST DECIMAL,
	SupplyID INT,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE ServiceStatus(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);

CREATE TABLE Service(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	StatusID INT FOREIGN KEY REFERENCES ServiceStatus(ID),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

CREATE TABLE GuestStatus(
	ID INT identity Primary Key,
	Name VARCHAR(100)
);

CREATE TABLE Guest(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Notes VARCHAR(250),
	Birthdate Date,
	CakeDays date,
	GuestStatusID INT FOREIGN KEY REFERENCES GuestStatus(ID)
);
CREATE TABLE Sales(
	ID INT identity Primary Key,
	ServiceID INT FOREIGN KEY REFERENCES Service(ID),
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	Price DECIMAL,
	PurchaseDate DATE,
	Amount DECIMAL,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE Counts(
	SupplyID INT identity Primary Key,
	Date Date,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID),
	Count DECIMAL
);
CREATE TABLE GuestClass(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);


CREATE TABLE GuestLevel(
	ID INT identity Primary Key,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	ClassID INT FOREIGN KEY REFERENCES GuestClass(ID),
	Date date
);

/* creates rooms*/
CREATE TABLE Rooms(
	ID INT IDENTITY Primary Key,
	Status VARCHAR(250),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

/*Creates rooms stayed in */
CREATE TABLE RoomStay(
	ID INT IDENTITY Primary Key,
	SaleID INT,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	RoomID INT FOREIGN KEY REFERENCES Rooms(ID),
	Date Date,
	Rate DECIMAL
);

/*
/*Adds a primary key to table user*/
ALTER TABLE Users ADD PRIMARY KEY ID;

/*Adds to the supplies table a foreign key that references another table */
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (TavernID) References Tavern(TavernID);
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (SupplyID) References Supplies(SupplyID);

/*Alter a table in some way by dropping the TestDrop text field in SuppliesReceived*/
ALTER TABLE SuppliesReceived DROP COLUMN EmployeeReceiverName;
*/

/* adding data to the tavern */



INSERT INTO Roles
VALUES
('Manager', 'manages the place'),
('greeter', 'greets guest'),
('maid',' cleans the joint'),
('cook', 'cooks food'),
('idiot', 'let people make fun of him');
/*adding data to location*/
INSERT INTO Location
VALUES
('Philly'),
('Springfield'),
('Mt Laurel'),
('Chester'),
('Not Philly
');
/* adding data to the user */

INSERT INTO Users
VALUES
('Joanna', '1'),
('Peter', '2'),
('Steven','3'),
('Rob', '4'),
('Carrie', '5');
INSERT INTO Tavern 
VALUES
('Howl By the Moon','1', '1'),
('Moes Tavern', '2', '2'),
('Miller Ale House', '3','3'),
('Maggies Pub', '4','4'),
('Xfinity', '5','5');

/* adding data to the supplies */
INSERT INTO Supplies
VALUES
('Miller Lite','ounces'),
('Toilet Paper','roll'),
('Mugs','pounds'),
('Water','gallons'),
('Apple Cider Vinegar','jugs');

/* adding data to the supplies being received */

INSERT INTO SuppliesReceived
VALUES
(01/01/2011, 100, 1000,1,2),
(02/02/2012, 50, 500,5,3),
(03/03/2013, 99, 12,2,5),
(04/04/2014, 23, 3,3,2),
(05/05/2015, 4, 66,1,3);

/* adding data to the statuses of the service */
INSERT INTO ServiceStatus
VALUE
('Active'),
('Inactive'),
('Out of Stock'),
('Discontinued');

/* adding data to the services */
INSERT INTO Service
VALUES
('Room Service' , 1,5),
('Chiropractor' , 2,4),
('Television' , 1,3),
('Grub Hub' , 2,2),
('Room Service' , 1,2);

INSERT INTO GuestStatus
VALUE
('Sick'),
('0HP'),
('Alive'),
('Hungry'),
('Excited');

INSERT INTO Guest
VALUES
('Eric','manager',2/12/2012,5/23/1990,2),
('Bruce','CEO',3/31/1990,5/23/2011,3),
('Clark','reporter',5/30/2012,3/03/1930,1),
('Barry','scientist',1/11/2011,2/26/2000,5),
('Dianna','amazon',12/12/2012,10/2010,2);

/* adding data to the sales */

INSERT INTO Sales
VALUE
(3,3,199.99,01/12/2020,199.99,4),
(2,2,67.45,12/11/2000,199.99,5),
(3,5,150.00,05/11/1999,150.0,1),
(5,2,1099.00,01/12/2020,35.0,2),
(1,1,245.02,01/12/2020,245.02,3);


INSERT INTO Counts
VALUE
('3',11/11/2011,5,10.1),
('2',12/12/2012,5,10.1),
('4',03/23/1993,5,10.1),
('1',04/05/1996,5,10.1),
('3',08/14/2019,5,10.1);


INSERT INTO GuestClass
VALUE
('Warrior'),
('Mge'),
('Archer'),
('Thief'),
('Pirate');

INSERT INTO Rooms
VALUES
('Vacant',1),
('Occupied',2),
('Out of Order', 3),
('No longer avaiable',4),
('redesigning',5);

INSERT INTO RoomStay
VALUES
(1,4,5,'03/10/2019',10.00),
(2,1,5,'12/10/2012',1.00),
(3,3,5,'08/10/2015',23.50),
(4,2,5,'04/10/2017',154.00),
(5,2,5,'01/10/2020',999.00);

--1. Write a query to return users who have admin roles
SELECT Users.name,roles.name FROM Users INNER JOIN Roles ON RoleID = Roles.ID WHERE Roles.ID = 'Admin';

--2. Write a query to return users who have admin roles and information about their taverns 
SELECT Users.Name,Roles.name, Location.Name FROM Users INNER Join Roles ON RoleID = Roles.ID 
INNER JOIN Location ON Location.ID = Location.ID WHERE Roles.ID = 'Admin';

--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels 
SELECT Guest.Name, GuestLevel.ID FROM GuestLevel INNER JOIN Guest ON GuestLevel.GuestID = Guest.ID ORDER BY Guest.Name ASC;

--4. Write a query that returns the top 10 sales in terms of sales price and what the services were 
SELECT TOP 10 Service.Name, Sales.Price FROM Sales INNER JOIN Service ON ServiceID = Service.ID;

--5. Write a query that returns guests with 2 or more classes 
SELECT Guest.Name From Guest INNER JOIN GuestLevel ON Guest.ID = ClassID INNER JOIN GuestClass ON GuestLevel.ID = GuestClass.ID
ORDER BY Guest.Name;

--6. Write a query that returns guests with 2 or more classes with levels higher than 5 
SELECT Guest.Name FROM Guest INNER JOIN GuestLevel ON Guest.ID = ClassID INNER JOIN GuestClass ON GuestLevel.ID = GuestClass.ID 
WHERE GuestLevel.ID > 5
ORDER BY Guest.Name;

--7. Write a query that returns guests with ONLY their highest level class 
SELECT Guest.Name, GuestClass.Name, MAX(GuestLevel.ID) FROM GuestLevel INNER JOIN Guest ON GuestLevel.GuestID = Guest.ID 
INNER JOIN GuestClass ON GuestLevel.ClassID = GuestClass.ID;

--8. Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them) 
SELECT Guest.Name,RoomStay.ID, RoomStay.Date FROM Guest JOIN RoomStay ON Guest.ID = GuestID WHERE RoomStay.Date BETWEEN '01/01/2019' AND '12/12/2019';

--9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it. 
--hit a road block adding an identity atm,working on it
SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Taverns' 
UNION ALL 
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
Then CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') Else '' END), ',') as queryPiece 
FROM INFORMATION_SCHEMA.COLUMNS as cols 
WHERE TABLE_NAME = 'Taverns' 
UNION ALL 
--adds primary key
SELECT CONCAT( cols.COLUMN_NAME,' PRIMARY KEY ', 'IDENTITY(1,1)') as queryPiece FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE as cols WHERE COLUMN_NAME='TavernID'
UNION

SELECT ')'; 



-- LAB 
SELECT * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
 

select * from INFORMATION_SCHEMA.COLUMNS 
select * from INFORMATION_SCHEMA.TABLES 
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 



select sysObj.name, sysCol.name 
from sys.objects sysObj inner join sys.columns sysCol on sysObj.object_id = sysCol.object_id 
where sysCol.is_identity = 1