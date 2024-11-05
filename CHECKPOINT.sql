CREATE TABLE Costumers(
costumerid int NOT NULL PRIMARY KEY,
firstname varchar(300) NOT NULL,
lastname varchar(300) NOT NULL,
email varchar(350) NOT NULL,
phone varchar(200) NOT NULL,
adress varchar(200) NOT NULL,
city varchar(200) NOT NULL,
country varchar(200) NOT NULL,
zipcode varchar(200) CHECK (zipcode>=0),
);

----------------------------------------------------------------------

CREATE TABLE Categories(
categoryid int NOT NULL PRIMARY KEY, 
categoryname varchar(200) NOT NULL,
categorydescription varchar(200) NOT NULL,
);
-----------------------------------------------------------------------

CREATE TABLE products(
productid int NOT NULL PRIMARY KEY,
productname varchar(200) NOT NULL,
productdescription varchar(200) NOT NULL,
price varchar(200) CHECK (price>0),
stockquantity varchar(200) CHECK (stockquantity>=0),
Categoryid int FOREIGN KEY(categoryid) REFERENCES Categories(categoryid),
);
-----------------------------------------------------------------------

CREATE TABLE orders(
orderid int NOT NULL PRIMARY KEY,
costumerid int FOREIGN KEY (costumerid) REFERENCES Costumers(costumerid),
orderdate date,
totalamount float CHECK (totalamount>0),
);
------------------------------------------------------------------------

CREATE TABLE orderdetails(
orderdetailid int NOT NULL PRIMARY KEY,
orderid int FOREIGN KEY (orderid) REFERENCES orders(orderid),
);
------------------------------------------------------------------------

