CREATE TABLE VEHICLES(
licenseplate varchar(6) NOT NULL,
make varchar(10) NOT NULL,
model varchar(10) NOT NULL,
yearr int CHECK(yearr>2000),
color varchar(10),
vin varchar(20),
);										 /*création de la table véhicules*/



CREATE TABLE DRIVERS(
firstname varchar(200) NOT NULL,
lastname varchar(200) NOT NULL,
licensenumber int CHECK(licensenumber>0),
phone int CHECK(phone>0000000),
adress varchar(200),
city varchar(200)NOT NULL,
statee varchar(200) NOT NULL,
zipcode varchar(200),
);									 /*création de la table conducteur*/

CREATE TABLE TRIPS(
vehicleid int CHECK(vehicleid>0),
driverid int CHECK(vehicleid>0),
startdate date,
enddate date,
startlocation varchar(200) NOT NULL,
endlocation varchar(200) NOT NULL,
distance int CHECK(vehicleid>0),
);									 /*création de la table voyages*/

CREATE TABLE Maintenance(
vehicleid int CHECK(vehicleid>0),
maintenancedate date,
descriptionn varchar(200) NOT NULL,
cost int CHECK(vehicleid>0),
);									/*création de la table maintenance*/


/*ajout des insertions sur la table véhicules*/
INSERT INTO VEHICLES VALUES('ABC123', 'toyota', 'corrolla', '2020', 'white', '1HGCM82633A004352');
INSERT INTO VEHICLES VALUES('XYZ789', 'ford', 'fusion', '2018', 'blue', '2HGCM82633A004353');

/*ajout des insertions sur la table conducteurs*/
INSERT INTO DRIVERS VALUES('Michael', 'Smith', 'D1234567', '1234567890', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO DRIVERS VALUES('Sarah', 'Connor', 'D7654321', '0987654321', '456 Elm St', 'Otherville', 'NY', '54321');

/*ajout des insertions sur la table voyages*/
INSERT INTO TRIPS VALUES('1', '1', '2024-07-01', '2024-07-02', 'los Angeles', 'San Francisco', '380');
INSERT INTO TRIPS VALUES('2', '2', '2024-07-03', '2024-07-04', 'NEW YORK', 'washington DC', '225');

/*ajout des insertions sur la table maintenance*/
INSERT INTO Maintenance VALUES('1', '2024-06-15', 'Oil change', '5000');
INSERT INTO Maintenance VALUES('2', '2024-06-20', 'Tire remplacement', '30000');

/*Update the cost of the second maintenance record to 350.00.*/
UPDATE Maintenance SET cost= '35000'
WHERE cost= '30000';

/*Delete the first vehicle from the Vehicles table.*/
DELETE FROM VEHICLES WHERE licenseplate= 'ABC123';


/*Insert one more record into the Trips table with the following details*/
INSERT INTO TRIPS VALUES('2', '1', '2024-07-05', '2024-07-06', 'Boston', 'philadelphia', '300');

/*Update the color of the second vehicle in the Vehicles table to "Red".*/ 
UPDATE VEHICLES SET color= 'red' 
WHERE color = 'blue';

/*Insert a new maintenance record into the Maintenance table with the following details:*/
INSERT INTO Maintenance VALUES('1', '2024-07-10', 'Brake inspection', '100.00');

/*Update the phone number of the first driver in the Drivers table to "2223334444".*/
UPDATE DRIVERS SET phone= '2223334444'
WHERE phone= '1234567890'; 


/*Delete the trip with TripID = 2 (vehicleid) from the Trips table.*/

DELETE FROM TRIPS WHERE vehicleid= '2'; 

