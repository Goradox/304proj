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
    password            VARCHAR(64),
    isAdmin             BIT,
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
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin) VALUES ('Admin', 'Adam', 'yourmom@gmail.com', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'admin' , '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1);

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
UPDATE product SET productDesc = 'Though their portrayals will vary across culture — from brooding sexy ones in Twilight and Anne Rice novels to terrifying monstrous Count Orlok in Nosferatu — there are a few things that remain the same: vampires feed on the living to remain immortal, they avoid sunlight, and their hearts are vulnerable to sharp objects — you know, just like you and me. Often a metaphor for the dangers of sexual desire, vampires have remained firmly in the cultural consciousness for over a hundred and fifty years.' WHERE productId = 2;
UPDATE product SET productDesc = 'A female spirit whose haunting howls herald a coming death. Banshees are a part of Irish mythology best known for their ubiquity in modern metaphor (“screams like a banshee”) and their tendency to support Siouxsie Sioux in concert.' WHERE productId = 3;
UPDATE product SET productDesc = 'While its name derives from Haitian folklore, the zombies we’re most accustomed to originate from the mid-20th century. In particular, we’re talking about the creatures in I am Legend by Richard Matheson and the classic films of George Romero (Night of the Living Dead, Dawn of the Dead). Divorced from all semblance of their former selves and highly infectious, these shambling corpses have only one desire: to consume human flesh.' WHERE productId = 4;
UPDATE product SET productDesc = 'Cut off one head, and two more will take its place. This was the challenge that faced Heracles when he was commanded to slay the Hydra of Lerna, a many-headed beast, during the second of his labors.'WHERE productId = 5;
UPDATE product SET productDesc = 'Part lion, part goat, part snake. It seems entirely plausible that the chimera owes its existence to someone viewing three adjacent animals from far away — but who knows? The term chimera is now used to describe anything puzzlingly composed of more than one pre-existing thing.'WHERE productId = 6;
UPDATE product SET productDesc = 'Apologies to Bigfeet aficionados, but we’re grouping these giant ape-men together. Known for their ability to remain out of focus in photographs, they remain a point of fascination for real-world true believers. As recently as February 2019, retired baseball player Jose Canseco was selling tour packages to join him on Bigfoot hunts.'WHERE productId = 7;
UPDATE product SET productDesc = 'the dragon features in the mythology of numerous civilisations around the world — and is often used as a symbol of royal power. Perhaps the single most common mythological creature found in fantasy fiction, they continue to capture readers'' imaginations with their various depictions on page and screen.'WHERE productId = 8;
UPDATE product SET productDesc = '“Hi, I’m a unicorn. You may recognize me from such places as Every Child’s Birthday Party and 90% of All Items in a Gift Store.” At some point in the past, unicorns were retconned to fart rainbows, which perfectly encapsulates their anything-goes mythology. In picture books for under-fives, the unicorn remains a popular central figure.'WHERE productId = 9;
UPDATE product SET productDesc = 'What’s scarier than a serpent? One that’s been cross-bred with a rooster and can kill with a single stare! Not content with just one power, certain myths also suggest basilisks have the ability to turn silver into gold. The return on investment isn’t as good as what Rumplestiltskin offered, but it’s still not bad. The legend of the Warsaw Basilisk saw the creature defeated by a cunning local doctor who created a suit made of feathers and mirrors. Fun!'WHERE productId = 10;
UPDATE product SET productDesc = 'A universal symbol of resurrection, whether representing a character’s spiritual resurgence or their literal return from the grave. Also featured heavily in royal heraldry, the mythological creature is said to stem from Greek and Roman mythology.'WHERE productId = 11;
UPDATE product SET productDesc = 'With the body of a lion and the head, wings, and front feet of an eagle, the Griffin seems almost tailor-made for riding — were they not such temperamental creatures. Some versions of the griffin are known for jealously guarding gold (much like their dragon cousins). As a symbol, this majestic being can be seen in heraldry as well as in logos like that of Vauxhall Motors.'WHERE productId = 12;
UPDATE product SET productDesc = 'An enduring motif in mythology across Europe, werewolves (or lycanthropes, to give them their SAT name) served a similar function to witches, as men were commonly hunted and executed in the belief that they transformed into ravenous creatures called werewolves. In more recent times, they have become the subject of classic horror films, and even the object of affection in certain corners of paranormal romance.'WHERE productId = 13;
UPDATE product SET productDesc = 'With the bottom half of a goat and the top half of a human, Satyrs and Fauns are somewhat similar. That is, with the exception that Satyrs are a lot more interested in chasing women, while a faun is much more likely to invite you in for a lovely cup of cocoa.'WHERE productId = 14;
UPDATE product SET productDesc = 'With the top half of a human and the full body of a horse, Centaurs have long served as antagonists in Greek mythology, falling victim to classical heroes like Heracles and Theseus. These days, Centaurs can mostly be found filling up the darker corners of the user-contributed fan site, DeviantArt. (Warning: do NOT run that search).'WHERE productId = 15;
UPDATE product SET productDesc = 'With the head of a bull and the body of a man, you can’t blame the top-heavy minotaur for being an angry fellow. Trapped at the center of a labyrinth built by cruel King Minos of Crete (who lends his name to the creature), the legendary Minotaur was finally slain by the Athenian Theseus.'WHERE productId = 16;
UPDATE product SET productDesc = 'Not all Mermaids want to be where the people are, and walk on those — what do you call them? — feet. Presumably invented in the parched, sun-baked minds of ancient sailors, Mermaids are the human/fish hybrids that rule the underwater kingdom. Their mythos has since been informed by Greek sirens, and they are seen as both menaces and potential lovers to those who travel by sea.'WHERE productId = 17;
UPDATE product SET productDesc = 'A fantastical creature or a product of ancient misogyny? You be the judge! According to Ovid’s telling in Metamorphoses, Medusa was a beautiful maiden who was transformed by Athena in a jealous rage. Where once she had a lovely mane of hair and a gorgeous face, there were now only snakes for locks and a visage that turned men instantly to stone. Thankfully, the great hero Perseus was on hand to cut off her head and take it as a trophy. She really was too good for this world.'WHERE productId = 18;
UPDATE product SET productDesc = 'With powers similar to fairies, Goblins are best characterized by their greed, short temper, and penchant for mischief. They also tend to be a whole lot uglier than their tiny cousins — needless to say, you don’t want to get them mixed up.'WHERE productId = 19;
UPDATE product SET productDesc = 'Sometimes supernatural, often magical or ethereal, and almost always tiny, these winged spirits appear in a bunch of European pagan traditions. Though some may be malicious, most depictions of faeries paint them as semi-benevolent elemental beings — protectors of nature, be they water nymphs or woodland fairies.'WHERE productId = 20;
UPDATE product SET productDesc = 'Huge, monstrous creatures with an appetite for human flesh — that of children, in particular. Ogres have turned up in a variety of fairy tales and myths including those of The Odyssey, Beowulf, Gilgamesh, and Puss in Boots. The animated film Shrek would have you believe that ogres are secretly gentle beings with layers of emotion, but don''t let your guard down around them!'WHERE productId = 21;
UPDATE product SET productDesc = 'They''re giants, but with only one eye — which makes them a bit less formidable than their two-eyed cousins. In The Odyssey, Odysseus is trapped in the cave home of Polyphemus the Cyclops. Odysseus tells the giant that his name is ''Nobody'' and blinds him with a sharpened spike. When Polyphemus calls for help, he screams that he has been “hurt by Nobody,” which confuses the other cyclopses long enough for Odysseus to escape. Silly cyclops.'WHERE productId = 22;
UPDATE product SET productDesc = 'If you ever wondered what that red-faced monster emoji was (see above) then here''s the answer! Giant ogre-like monsters of Japanese mythology, the Oni are man-eaters often depicted carrying heavy iron clubs. During the Japanese spring festival, it’s not unusual to witness a custom in which dried beans are tossed around to ward off Oni.'WHERE productId = 23;
UPDATE product SET productDesc = 'In Jewish folklore, the Golem is an automaton made of clay: an early magical robot who is said to protect or terrorize people (depending on who you ask). The most famous variation is the Golem of Prague, which was created to protect the Jewish ghettos from the wrath of the Holy Roman Empire.'WHERE productId = 24;
UPDATE product SET productDesc = 'Where fairies tend to be elemental (in that they’re part of nature), gnomes are their domestic cousins, known for living in walls and underground. In Cologne, the legend of the Heinzelmännchen tells of house gnomes who did the town''s work at night, so that the citizens could just laze about all day. But that changed when a tailor’s wife had the bright idea to scatter peas on the ground to make them slip up and leave town.'WHERE productId = 25;
UPDATE product SET productDesc = 'An imp is a European mythological being similar to a fairy or demon, frequently described in folklore and superstition. The word may perhaps derive from the term ympe, used to denote a young grafted tree. Imps are often described as troublesome and mischievous more than seriously threatening or dangerous, and as lesser beings rather than more important supernatural beings. The attendants of the devil are sometimes described as imps. They are usually described as lively and having small stature.'WHERE productId = 26;
UPDATE product SET productDesc = 'Wraith is one of several traditional terms for a ghost or spirit.'WHERE productId = 27;
UPDATE product SET productDesc = ' Chinese mythological creatures usually capable of shapeshifting, who may either be benevolent or malevolent spirits. In Chinese mythology and folklore, the fox spirit takes variant forms'WHERE productId = 28;
UPDATE product SET productDesc = 'A cat'WHERE productId = 29;