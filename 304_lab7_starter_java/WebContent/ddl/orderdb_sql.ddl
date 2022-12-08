CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(MAX),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(MAX),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Human like');
INSERT INTO category(categoryName) VALUES ('Unhuman');


--https://reedsy.com/discovery/blog/mythical-creatures;
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('BogeyMan', 1, '',18.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Vampire',1,'24 - 12 oz bottles',19.00,'img/1.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Banshee',1,'12 - 550 ml bottles',10.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Zombie',1,'48 - 6 oz jars',22.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Hydra',2,'36 boxes',21.35,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Chimera',2,'12 - 8 oz jars',25.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Yeti',2,'12 - 1 lb pkgs.',30.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Dragon',2,'12 - 12 oz jars',40.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Unicorn',2,'18 - 500 g pkgs.',97.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Basilisk',2,'12 - 200 ml jars',31.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Pheonix',2,'1 kg pkg.',21.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Griffin',2,'10 - 500 g pkgs.',38.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Werewolf',1,'40 - 100 g pkgs.',23.25,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Satyrs',1,'24 - 250 ml bottles',15.50,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Centaurs',1,'32 - 500 g boxes',17.45,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Minotaur',1,'20 - 1 kg tins',39.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Mermaid',1,'16 kg pkg.',62.50,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Gorgon',1,'10 boxes x 12 pieces',9.20,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Goblin',1,'30 gift boxes',81.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Fairy',1,'24 pkgs. x 4 pieces',10.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Ogre',1,'24 - 500 g pkgs.',21.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Cyclops',1,'24 - 12 oz bottles',14.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Oni',1,'24 - 12 oz bottles',18.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Golems',2,'24 - 250 g  jars',19.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Gnomes',1,'24 - 4 oz tins',18.40,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Imp',2,'12 - 12 oz cans',9.65,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Wraith',2,'32 - 1 kg pkgs.',14.00,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nine-tailed fox',2,'32 - 8 oz bottles',21.05,'');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Cat',2,'24 - 12 oz bottles',14.00,'');

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
 UPDATE Product SET productImageURL = 'img/boogey_man.jpg' WHERE ProductId = 1;
 UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 2;
 UPDATE Product SET productImageURL = 'img/banshee.jpg' WHERE ProductId = 3;
 UPDATE Product SET productImageURL = 'img/zombie.jpg' WHERE ProductId = 4;
 UPDATE Product SET productImageURL = 'img/hydra.jpg' WHERE ProductId = 5;
 UPDATE Product SET productImageURL = 'img/chimera.jpg' WHERE ProductId = 6;
 UPDATE Product SET productImageURL = 'img/yeti.jpg' WHERE ProductId = 7;
 UPDATE Product SET productImageURL = 'img/dragon.jpg' WHERE ProductId = 8;
 UPDATE Product SET productImageURL = 'img/unicorn.jpg' WHERE ProductId = 9;
 UPDATE Product SET productImageURL = 'img/basilisk.jpg' WHERE ProductId = 10;
 UPDATE Product SET productImageURL = 'img/pheonix.jpg' WHERE ProductId = 11;
 UPDATE Product SET productImageURL = 'img/griffin.jpg' WHERE ProductId = 12;
 UPDATE Product SET productImageURL = 'img/warewolf.jpg' WHERE ProductId = 13;
 UPDATE Product SET productImageURL = 'img/satyrs.jpg' WHERE ProductId = 14;
 UPDATE Product SET productImageURL = 'img/centaurs.jpg' WHERE ProductId = 15;
 UPDATE Product SET productImageURL = 'img/minotaur.jpg' WHERE ProductId = 16;
 UPDATE Product SET productImageURL = 'img/mermaid.jpg' WHERE ProductId = 17;
 UPDATE Product SET productImageURL = 'img/gorgon.jpg' WHERE ProductId = 18;
 UPDATE Product SET productImageURL = 'img/goblin.jpg' WHERE ProductId = 19;
 UPDATE Product SET productImageURL = 'img/fairy.jpg' WHERE ProductId = 20;
 UPDATE Product SET productImageURL = 'img/ogre.jpg' WHERE ProductId = 21;
 UPDATE Product SET productImageURL = 'img/cyclops.jpg' WHERE ProductId = 22;
 UPDATE Product SET productImageURL = 'img/oni.jpg' WHERE ProductId = 23;
 UPDATE Product SET productImageURL = 'img/golem.jpg' WHERE ProductId = 24;
 UPDATE Product SET productImageURL = 'img/gnome.jpg' WHERE ProductId = 25;
 UPDATE Product SET productImageURL = 'img/imp.jpg' WHERE ProductId = 26;
 UPDATE Product SET productImageURL = 'img/wraith.jpg' WHERE ProductId = 27;
 UPDATE Product SET productImageURL = 'img/nine-tailed_fox.jpg' WHERE ProductId = 28; 
 UPDATE Product SET productImageURL = 'img/cat.jpg' WHERE ProductId = 29; 

--adding description
UPDATE product SET productDesc = 'The bogeyman can take many forms, but their purpose remains constant: to scare the living daylights out of children and coerce them into good behavior. A bogeyman might be an actual human (in one of the tales of Struwwelpeter, a tailor cuts off a boy''s thumbs because he sucks them too much), but in most cases, it''s a supernatural force of some type.' WHERE productId = 1;
