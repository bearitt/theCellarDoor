
CREATE TABLE customer (
    customerId          INT AUTO_INCREMENT,
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
    admin               BIT NOT NULL,
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT AUTO_INCREMENT,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ordersummary (
    orderId             INT AUTO_INCREMENT,
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
    categoryId          INT AUTO_INCREMENT,
    categoryName        VARCHAR(50),
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT AUTO_INCREMENT,
    productName         VARCHAR(60),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(1000),
    productImage        LONGBLOB,
    productDesc         VARCHAR(1000),
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
    customerId          INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),
    PRIMARY KEY (customerId, productId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT AUTO_INCREMENT,
    warehouseName       VARCHAR(30),
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT AUTO_INCREMENT,
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
    reviewId            INT AUTO_INCREMENT,
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

INSERT INTO category(categoryName) VALUES ('Red Wine');
INSERT INTO category(categoryName) VALUES ('Rose');
INSERT INTO category(categoryName) VALUES ('White Wine');
INSERT INTO category(categoryName) VALUES ('Sparkling Wine');
INSERT INTO category(categoryName) VALUES ('Dessert Wine');
INSERT INTO category(categoryName) VALUES ('Accessories');

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test',0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby',0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password',0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw',0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test',0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Barret', 'Jackson', 'barret.jackson@gmail.com', '587-586-9357', '1574 Crest Ridge Lane', 'Kelowna', 'BC', 'V1Z 4E1', 'Canada', 'bearlion' , 'flyingfoxindustries',1);
