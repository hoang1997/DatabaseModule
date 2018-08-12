/*Task 1*/
-- dropping database if already exists --
DROP DATABASE IF EXISTS assignment;

-- drop user if already exists --
DROP USER IF EXISTS 'newuser'@'localhost';

-- Creating database --
CREATE DATABASE assignment;
USE assignment;

-- Creating tables and dropping tables if they already exist
CREATE TABLE IF NOT EXISTS Customers(
LastName    VARCHAR(20) NOT NULL,
FirstName   VARCHAR(20) NOT NULL,
Email       VARCHAR(50) NOT NULL,
PRIMARY KEY(Email)
);

CREATE TABLE IF NOT EXISTS Staff(
ID          INT NOT NULL,
LastName    VARCHAR(20) NOT NULL,
FirstName   VARCHAR(20) NOT NULL,
Email       VARCHAR(50) NOT NULL,
Age         INT NOT NULL,
PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS Suppliers(
Name        VARCHAR(30) NOT NULL,
Email       VARCHAR(50) NOT NULL,
PRIMARY KEY(Email)
);

CREATE TABLE IF NOT EXISTS Addresses(
Email       VARCHAR(50) UNIQUE,
Street      VARCHAR(120) NOT NULL,
City        VARCHAR(100)NOT NULL,
PostCode    VARCHAR(10) NOT NULL,
PRIMARY KEY(Email),
FOREIGN KEY(Email) REFERENCES Customers(Email) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS sAddresses(
Email       VARCHAR(50) NOT NULL,
Street      VARCHAR(120) NOT NULL,
City        VARCHAR(100)NOT NULL,
PostCode    VARCHAR(10) NOT NULL,
PRIMARY KEY(Email),
FOREIGN KEY(Email) REFERENCES Suppliers(Email) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Item(
ID          INT NOT NULL,
LatinName   VARCHAR(50) NOT NULL,
PopularName VARCHAR(50) NOT NULL,
Description VARCHAR(255) NOT NULL,
Category    VARCHAR(50) NOT NULL,
Season      VARCHAR(50) NOT NULL,
AfterCare   VARCHAR(255) NOT NULL,
Price       DECIMAL(5,2) NOT NULL,
PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS cOrder(
ID          INT NOT NULL,
ItemID      INT NOT NULL,
Email       VARCHAR(50) NOT NULL,
OrderDate   DATE NOT NULL,
OrderStatus VARCHAR(50) NOT NULL DEFAULT "Pending Payment",
Discount    DECIMAL(5,2),
Total       DECIMAL(5,2) NOT NULL,
PayStatus   VARCHAR(50) NOT NULL,
PRIMARY KEY(ID, ItemID),
FOREIGN KEY(ItemID) REFERENCES Item(ID) 
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(Email) REFERENCES Customers(Email) 
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Invoice(
ID          INT NOT NULL AUTO_INCREMENT,
OrderID     INT NOT NULL,
Email       VARCHAR(50) NOT NULL,
DateSent    DATETIME,
PRIMARY KEY(ID),
FOREIGN KEY(Email) REFERENCES Customers(Email)
);

CREATE TABLE IF NOT EXISTS PurchaseOrder(
ID          INT NOT NULL,
StaffID  INT NOT NULL,
ItemID      INT NOT NULL,
SupplierEmail VARCHAR(50) NOT NULL,
OrderDate   DATETIME,
PayDate     DATETIME,
OrderStatus VARCHAR(50) NOT NULL DEFAULT "Processing",
PRIMARY KEY(ID, ItemID),
FOREIGN KEY(SupplierEmail) REFERENCES Suppliers(Email) 
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(ItemID) REFERENCES Item(ID)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(StaffID) REFERENCES Staff(ID)
ON UPDATE CASCADE ON DELETE CASCADE
);

-- Altering tables -- 
ALTER TABLE Addresses AUTO_INCREMENT = 100;
ALTER TABLE sAddresses AUTO_INCREMENT = 200;
ALTER TABLE Invoice AUTO_INCREMENT = 100;

-- Modifying Column and adding constraints
ALTER TABLE PurchaseOrder ADD FOREIGN KEY(ID) REFERENCES Item(ID);

-- Inserting values into the tables
INSERT INTO Customers
VALUES ('Rayat','Shantae','sRayat1998@yahoo.co.uk'),
       ('Houghton','Sam', 'SamHoughton1997@gmail.com'),
       ('Spriggs','Milly', 'MillzSpriggz@live.co.uk'),
       ('Muchunga','Melly', 'MellySchmelly@gmail.com'),
       ('Redwood','Amy', 'AmyReds134@outlook.com'),
       ('Hoang','Joe', 'josephhoang97@gmail.com'),
       ('Smith','Richard', 'Ricard123Smith@outlook.com'),
       ('Rodgers','Robert', 'Roberto12345@yahoo.com'),
       ('Perry','Cole', 'ColePezza1253@gmail.co.uk'),
       ('Walford','Adam', 'AdamWalford1997@gmail.com');

INSERT INTO Staff
VALUES (1,'Smith','John','jSmith@lgc.co.uk',25),
       (2,'Whittiker','Amy','aWhittiker@lgc.co.uk',50),
       (3,'Neil','Lucy','lNeil@lgc.co.uk',32),
       (4,'Halliwell','Charlie','cHalliwell@lgc.co.uk',18),
       (5,'Murray','James','jMurray@lgc.co.uk',20),
       (6,'Robins','Francesca','fRobins@lgc.co.uk',82),
       (7,'Harris','Josh','jHarris@lgc.co.uk',45),
       (8,'Wells','Joe','jWells@lgc.co.uk',60);

INSERT INTO Suppliers
VALUES ('Plants R Us', 'Jacob.Smitt@plantsrus.co.uk'),
       ('TreeGrow', 'sMatthews@tg.co.uk'),
       ('Wilkinson Flowers inc', 'aHaliface@wflowers.com'),
       ('Seeds n Trees', 'sales@seedsntrees.co.uk'),
       ('Flower Pot Men', 'jonTrillby@fpmen.co.uk'),
       ('Flower Potters', 'j.murray@fPotters.co.uk');
       
INSERT INTO Addresses
VALUES ('sRayat1998@yahoo.co.uk','73 Guild Street','LONDON','EC3R 3UT'),
       ('SamHoughton1997@gmail.com','807 Hessle Rd', 'Hull','HU4 6QE'),
       ('MillzSpriggz@live.co.uk','3 Castle View', 'Egremont','CA22 2NA'),
       ('MellySchmelly@gmail.com','9 Moorlands Cl', 'Hindhead', 'GU26 6SY,'),
       ('AmyReds134@outlook.com','18 Clos Pantyfedwen','Borth', 'SY24 5HW'),
       ('josephhoang97@gmail.com','6 Cranleigh Gardens', 'Kingston upon Thames', 'KT25TX'),
       ('Ricard123Smith@outlook.com','Stanswood Rd', 'Southampton', 'SO451AA'),
       ('Roberto12345@yahoo.com','12 Dulwich Way','Rickmansworth','WD33PY'),
       ('ColePezza1253@gmail.co.uk','Far Westhouse', 'Carnforth', 'LA6'),
       ('AdamWalford1997@gmail.com','8 Lubbards Cl', 'Rayleigh','SS69PY');

INSERT INTO sAddresses
VALUES ('Jacob.Smitt@plantsrus.co.uk', '8 Lubbards Cl','Sheffield','SS6 9PY'),
       ('sMatthews@tg.co.uk','Cherry Tree Ln', 'London','SL00EE'),
       ('aHaliface@wflowers.com','55 St Oswalds Rd', 'Hebburn','NE311HS'),
       ('sales@seedsntrees.co.uk','24 Plymouth Rd', 'Sheffield','S72DE'),
       ('jonTrillby@fpmen.co.uk','131a Queen St', 'London','LS27 0QP'),
       ('j.murray@fPotters.co.uk','9 Roebuck Ave','Fareham','PO15 6TN');

INSERT INTO Item
VALUES  (1,
         'Ausbrother',
         'Rosa Lady Emma Hammilton',
         'Rosa Lady Emma Hamilton is a sensational shrub rose with repeat flushes of double flowers in summer.',
         'Rose Shrub',
         'June - August',
         'Water regularly in spring and summer in the first season after planting. Use rose fertiliser',
         20),
        (2,
         'Harmisty',
         'Rosa Chandos Beauty',
         'Rosa Chandos Beauty is a rose you can lose your heart to, combining an exceptionally powerful fragrance',
         'Rose Shrub',
         'June - August',
         'Water regularly in spring and summer in the first season after planting. Use rose fertiliser',
         20),
        (3,
         'Malus domestica',
         'Apple Coxs Orange Pippin',
         'reliable-cropping self-fertile form of the most famous of all dessert apples.',
         'Apple Tree','October',
         'When planting, dig in lots of compost or well-rotted farmyard mature to the soil. Stake tree firmly after planting. Prune in summer if needed.',
         42),
        (4,
         'Daucus carota',
         'Carrot - Cosmic Purple',
         'Adds a new dimension to salads and stir-fries with its rich red-purple skin and bright orange flesh.',
         'Deciduous',
         'June-November',
         'Plant in small clumps - do not split into individual plants as this will damage the roots.',
        5.99),
        (5,
         'Allium roseum',
         'Allium roseum',
         'Allium roseum is an extremely pretty, hardy allium, treasured for its loose domed clusters of pink flowers.',
         'Perrenial',
         'May - June',
         'Plant the bulbs in autumn at a depth of 10cm',
         0.50),
        (6,
         'Beta vulgaris',
         'Beetroot', 
         'Easy to grow and packed with nutrients, beetroot is perfect for both novice and experienced gardeners',
         'Deciduous',
         'June - October',
         'Water regularly to prevent the soil from drying out and keep the plants cool and moist. This will help to avoid plants running to seed.',
         3.99),
        (7,
         'prostrate shore juniper',
         'Juniperus conferta Schlager',
         'Juniperus rigida subsp. conferta Schlager compact low mat forming conifer with blue green foliage with lime green tips in spring',
         'Shrub',
         'N/A',
         'Plant with generous quantities of well- rotted garden compost, or farmyard manure well turned into the existing soil.',
         11);

INSERT INTO cOrder
VALUES (100, 3, 'josephhoang97@gmail.com', '2017-12-30', 'Sent', 0, 42, 'Received'),
       (100, 2, 'josephhoang97@gmail.com', '2017-12-30', 'Sent', 0, 20, 'Received'),
       (101, 2, 'SamHoughton1997@gmail.com', '2017-11-27', 'Not Paid', 0, 20, 'Not Received'),
       (101, 1, 'SamHoughton1997@gmail.com', '2017-11-27', 'Not Paid', 20, 18, 'Not Received'),
       (103, 7, 'MillzSpriggz@live.co.uk', '2018-01-11', 'Paid', 0, 11, 'Received'),
       (104, 4, 'Ricard123Smith@outlook.com', '2018-01-15', 'Paid', 30, 4.20, 'Received'),
       (105, 5, 'sRayat1998@yahoo.co.uk', '2018-01-22', 'Not Paid', 0, 0.50, 'Not Received'),
       (106, 3, 'MellySchmelly@gmail.com', '2017-09-23', 'Paid', 10, 37.80, 'Received'),
       (107, 6, 'josephhoang97@gmail.com', '2018-01-08', 'Not Paid', 10, 3.60, 'Not Received'),
       (108, 1, 'AdamWalford1997@gmail.com', '2017-07-15', 'Paid', 0, 20, 'Received'),
       (109, 6, 'ColePezza1253@gmail.co.uk', '2017-01-25', 'Paid', 0, 3.99, 'Received');

INSERT INTO Invoice(OrderID, Email,DateSent)
VALUES (100,'josephhoang97@gmail.com','2017-12-30'),
       (101,'SamHoughton1997@gmail.com','2017-11-27'),
       (103, 'MillzSpriggz@live.co.uk','2018-01-11'),
       (104, 'Ricard123Smith@outlook.com','2018-01-15'),
       (105, 'sRayat1998@yahoo.co.uk','2018-01-22'),
       (106, 'MellySchmelly@gmail.com','2017-09-23'),
       (107, 'josephhoang97@gmail.com','2018-01-08'),
       (108, 'AdamWalford1997@gmail.com','2017-07-15'),
       (109, 'ColePezza1253@gmail.co.uk','2017-01-25');

INSERT INTO PurchaseOrder
VALUES (1, 3, 3, 'Jacob.Smitt@plantsrus.co.uk','2017-11-01','2017-11-03', 'Paid'),
       (2, 5, 2, 'Jacob.Smitt@plantsrus.co.uk','2017-12-15','2017-12-18', 'Paid'),
       (3, 2, 1, 'aHaliface@wflowers.com','2017-12-17','2017-12-20', 'Paid'),
       (4, 5, 6, 'jonTrillby@fpmen.co.uk','2018-01-01','2017-01-03', 'Paid'),
       (5, 1, 7, 'sales@seedsntrees.co.uk','2018-01-03','2018-01-06', 'Paid');

-- Deleting Staff whose age is over 60 as they probably not working there anymore --
DELETE FROM Staff WHERE Age > 60;

-- Updating Columns after one of the staff got married -- 
UPDATE Staff SET LastName = 'Rodwell' WHERE ID = 2;

/*TASK 2*/
-- INNER JOIN --
SELECT CONCAT(Customers.FirstName," ", Customers.LastName) AS Name, Customers.Email, cOrder.ItemID, cOrder.OrderDate, cOrder.Total
FROM cOrder INNER JOIN Customers ON cOrder.Email = Customers.Email
Order BY cOrder.OrderDate DESC;

-- LEFT JOIN --
SELECT Customers.FirstName, Customers.LastName, cOrder.OrderDate, cOrder.OrderStatus
FROM cOrder LEFT JOIN Customers ON cOrder.Email = Customers.Email
ORDER BY Customers.LastName ASC;

-- RIGHT JOIN -- 
SELECT Staff.Email, PurchaseOrder.ItemID, PurchaseOrder.OrderStatus, PurchaseOrder.OrderDate
FROM Staff
RIGHT JOIN PurchaseOrder
ON Staff.ID = PurchaseOrder.StaffID
ORDER BY PurchaseOrder.OrderDate ASC;

-- UNION JOIN --
SELECT Email FROM Customers
UNION
SELECT Email FROM Suppliers
ORDER BY Email;

SELECT City From Addresses
UNION 
SELECT City FROM sAddresses;

-- CREATING COPIES OF TABLES --

CREATE TABLE copy_of_Customers LIKE Customers;
INSERT copy_of_Customers SELECT * FROM Customers;
 
CREATE TABLE copy_of_Staff LIKE Staff;
INSERT copy_of_Staff SELECT * FROM Staff;

CREATE TABLE copy_of_Suppliers LIKE Suppliers;
INSERT copy_of_Suppliers SELECT * FROM Suppliers;

CREATE TABLE copy_of_Addresses LIKE Addresses;
INSERT copy_of_Addresses SELECT * FROM Addresses;

CREATE TABLE copy_of_sAddresses LIKE sAddresses;
INSERT copy_of_sAddresses SELECT * FROM sAddresses;

CREATE TABLE copy_of_Items LIKE Item;
INSERT copy_of_Items SELECT * FROM Item;

CREATE TABLE copy_of_cOrder LIKE cOrder;
INSERT copy_of_cOrder SELECT * FROM cOrder;

CREATE TABLE copy_of_Invoice LIKE Invoice;
INSERT copy_of_Invoice SELECT * FROM Invoice;

CREATE TABLE copy_of_PurchaseOrder LIKE PurchaseOrder;
INSERT copy_of_PurchaseOrder SELECT * FROM PurchaseOrder;


-- CREATING USER AND GRANTING READ PERMISSIONS --
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON *.* TO 'newuser'@'localhost';

-- CREATING STORED PROCEDURE TO COUNT PAID ORDERS AND NOT PAID ORDERS --
DELIMITER //
DROP PROCEDURE IF EXISTS CountOrderByPaymentStatus//
CREATE PROCEDURE CountOrderByPaymentStatus(
    IN receivedStatus VARCHAR(25),
    IN notReceivedStatus VARCHAR(25),
    OUT ReceivedTotal INT,
    OUT NotReceivedTotal INT)
BEGIN
SELECT 
    COUNT(*)  INTO ReceivedTotal
    FROM cOrder
    Where PayStatus = receivedStatus;
SELECT 
    COUNT(*)  INTO NotReceivedTotal
    FROM cOrder
    Where PayStatus = notReceivedStatus;
END//
DELIMITER ;

CALL CountOrderByPaymentStatus("Received", "Not Received", @ReceivedTotal, @NotReceivedTotal);
SELECT @ReceivedTotal,@NotReceivedTotal;
