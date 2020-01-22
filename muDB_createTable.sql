USE MU_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Student;

DROP TABLE IF EXISTS Lease;

DROP TABLE IF EXISTS Room;

DROP TABLE IF EXISTS Invoices;

DROP TABLE IF EXISTS Advisor;

DROP TABLE IF EXISTS Vehicle;

DROP TABLE IF EXISTS Lot;

DROP TABLE IF EXISTS NextOfKin;

DROP TABLE IF EXISTS StudentNextOfKin;

DROP TABLE IF EXISTS Course;

DROP TABLE IF EXISTS StudentInCourse;

DROP TABLE IF EXISTS ResidenceHall;

DROP TABLE IF EXISTS Flats;

DROP TABLE IF EXISTS Inspections;

DROP TABLE IF EXISTS Staff;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Advisor (

advisorNum INTEGER NOT NULL,

fName VARCHAR(25) NOT NULL,

lName VARCHAR(25) NOT NULL,

position VARCHAR(25) NOT NULL,

deptName VARCHAR(25) NOT NULL, 

internalPhone VARCHAR(12) NOT NULL,

email VARCHAR(50) NOT NULL,

roomNum INTEGER NOT NULL,

PRIMARY KEY (advisorNum)
);
CREATE INDEX advisorFName on Advisor(fName);
CREATE INDEX advisorLName on Advisor(lName);
CREATE INDEX advisorPhone on Advisor(internalPhone);

CREATE TABLE Student (

muId INTEGER NOT NULL,

fName VARCHAR(25) NOT NULL,

lName VARCHAR(25) NOT NULL,

street VARCHAR(50) NOT NULL,

city VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

phoneNumber VARCHAR(12) NOT NULL,

email VARCHAR(50) NOT NULL,

DateOfBirth DATE NOT NULL,

gender VARCHAR(6) NOT NULL,

schoolRank VARCHAR(9) NOT NULL,

nationality VARCHAR(50) NOT NULL,

specialNeeds VARCHAR(50),

major VARCHAR(50) NOT NULL,

minor VARCHAR(50),

comments char(100),

advisorNum INTEGER NOT NULL,

PRIMARY KEY (muId),
FOREIGN KEY (advisorNum) REFERENCES Advisor (advisorNum)
);
CREATE INDEX studentFName on Student(fName);
CREATE INDEX studentLName on Student(lName);

CREATE TABLE Lot (
lotNum INTEGER NOT NULL,

lotName VARCHAR(25) NOT NULL,

street VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

maxSpace INTEGER NOT NULL,

availability INTEGER NOT NULL,

PRIMARY KEY(lotNum)
);
CREATE INDEX lotsName on Lot(lotName);

CREATE TABLE Vehicle (
VINNum CHAR(17) NOT NULL,

color VARCHAR(10) NOT NULL,

licensePlate VARCHAR(10) NOT NULL,

manufacturer VARCHAR(25) NOT NULL,

brand VARCHAR(25) NOT NULL,

studentMuId INTEGER NOT NULL,

lotNum INTEGER NOT NULL,

PRIMARY KEY(VINNum),
FOREIGN KEY (studentMuId) REFERENCES Student(muId),
FOREIGN KEY (lotNum) REFERENCES Lot(lotNum)
);
CREATE INDEX VehicleLicensePlate on Vehicle(licensePlate);

CREATE TABLE NextOfKin (
kinId INTEGER NOT NULL,

fName VARCHAR(25) NOT NULL,

lName VARCHAR(25) NOT NULL,

street VARCHAR(50) NOT NULL,

city VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

phoneNum VARCHAR(12) NOT NULL,

PRIMARY KEY(kinId)
);
CREATE INDEX nextOfKinFName on NextOfKin(fName);
CREATE INDEX nextOfKinLName on NextOfKin(lName);

CREATE TABLE StudentNextOfKin (
kinId INTEGER NOT NULL,

studentMuId INTEGER NOT NULL,

relationship VARCHAR(25),

PRIMARY KEY(kinId, studentMuId),
FOREIGN KEY (kinId) REFERENCES NextOfKin (kinId),
FOREIGN KEY (studentMuId) REFERENCES Student (muId)
);

CREATE TABLE Course (

courseNum INTEGER NOT NULL,

courseTitle VARCHAR(25) NOT NULL,

PRIMARY KEY(courseNum)
);
CREATE INDEX courseName on Course(courseTitle);

CREATE TABLE StudentInCourse (

courseNum INTEGER NOT NULL,

muId INTEGER NOT NULL,

semester VARCHAR(25) NOT NULL,

yearOfClass INTEGER NOT NULL,

courseInstructor VARCHAR(50) NOT NULL,

instructorPhone VARCHAR(12) NOT NULL,

instructorEmail VARCHAR(50) NOT NULL,

roomNum INTEGER NOT NULL,

deptNum INTEGER NOT NULL,

PRIMARY KEY(courseNum, muId),
FOREIGN key (courseNum) references Course (courseNum),
FOREIGN key (muId) references Student (muId)
);

CREATE TABLE ResidenceHall (

hallNumber INTEGER NOT NULL,

hallName VARCHAR(25) NOT NULL,

street VARCHAR(50) NOT NULL,

city VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

phoneNumber VARCHAR(12) NOT NULL,

manager INTEGER NOT NULL,

PRIMARY KEY(hallNumber)
);
CREATE INDEX residenceHallName ON residenceHall(hallName);

CREATE TABLE Flats (

flatNum INTEGER NOT NULL,

apartmentNum INTEGER NOT NULL,

street VARCHAR(50) NOT NULL,

city VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

numOfSingleRoom INTEGER NOT NULL,

PRIMARY KEY(flatNum)
);
CREATE INDEX flatsApartmentNum ON Flats(apartmentNum);

CREATE TABLE Room (

placeNum INTEGER NOT NULL,

roomNum INTEGER NOT NULL,

rentRate INTEGER NOT NULL,

hallNum INTEGER NULL,

flatNum INTEGER NULL,

PRIMARY KEY (placeNum),
FOREIGN KEY (hallNum) REFERENCES ResidenceHall (hallNumber),
FOREIGN KEY (flatNum) REFERENCES Flats (flatNum)
);

CREATE TABLE Lease (

leaseNum INTEGER NOT NULL,

leasePeriod VARCHAR(11) NOT NULL,

occupantLeave DATE NOT NULL, 

placeNum INTEGER NOT NULL,

muId INTEGER NOT NULL,

PRIMARY KEY (leaseNum),
FOREIGN KEY (placeNum) REFERENCES Room (placeNum),
FOREIGN KEY (muId) REFERENCES Student (muId)
);

CREATE TABLE Invoices (

invoiceNum INTEGER NOT NULL,

semesterDue VARCHAR(11) NOT NULL,

payDATE DATE, 

payMethod VARCHAR(25) NOT NULL,

leaseNum INTEGER NOT NULL,

PRIMARY KEY (invoiceNum),
FOREIGN KEY (leaseNum) REFERENCES Lease (LeaseNum)
);

CREATE TABLE Staff (

staffNum INTEGER NOT NULL,

fName VARCHAR(25) NOT NULL,

lName VARCHAR(25) NOT NULL,

email VARCHAR(50) NOT NULL,

street VARCHAR(50) NOT NULL,

city VARCHAR(25) NOT NULL,

postCode INTEGER NOT NULL,

dateOfBirth DATE NOT NULL,

gender VARCHAR(6) NOT NULL,

position VARCHAR(25) NOT NULL,

workLocation INTEGER NOT NULL,

PRIMARY KEY(staffNum),

FOREIGN KEY (workLocation) REFERENCES ResidenceHall (hallNumber)
);
CREATE INDEX staffFNamee ON Staff(fName);
CREATE INDEX staffLName ON Staff(lName);
CREATE INDEX staffDOB ON staff(dateOfBirth);

CREATE TABLE Inspections (

inspectNum INTEGER NOT NULL,

inspectDate DATE NOT NULL,

flatNum INTEGER NOT NULL,

staffNum INTEGER NOT NULL,

conditionOfFlat VARCHAR(25) NOT NULL,

comments VARCHAR(100) NOT NULL,

PRIMARY KEY (inspectNum),
FOREIGN KEY (staffNum) REFERENCES Staff (staffNum),
FOREIGN KEY (flatNum) REFERENCES Flats (flatNum)
);
CREATE INDEX inspectDate ON Inspections(inspectDate);

-- ALTER TABLE ResidenceHall
-- ADD CONSTRAINT residence_hall_is_managed FOREIGN KEY (manager) REFERENCES Staff (staffNum);

INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2000, 'Cong', 'Pu', 'Professor', 'Computer Science', '30455555555','pu@marshall.edu',203);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2001, 'Chaz', 'MadeUpName', 'Professor', 'English', '30455555556','MadeUpName@marshall.edu',330);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2002, 'Gary', 'G', 'Professor', 'Theatre', '30455555557','pu@marshall.edu',210);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2003, 'Adam', 'Scott', 'Professor', 'Archaelogy', '30455555558','Scott@marshall.edu',204);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2004, 'Hal', 'Jordan', 'Professor', 'Aerodynamics', '30455555559','Jordan@marshall.edu',344);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2005, 'Guy', 'Gardner', 'Professor', 'Physical Education', '30455555560','gardner@marshall.edu',102);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2006, 'John', 'Stuart', 'Professor', 'Architecture', '30455555561','stuart@marshall.edu',205);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2007, 'Kyle', 'Rainer', 'Professor', 'Graphic Design', '30455555562','Rainer@marshall.edu',103);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2008, 'Simon', 'Baz', 'Professor', 'Criminal Justice', '30455555563','Baz@marshall.edu',222);
INSERT INTO Advisor(advisorNum, fName, lName, position, deptName, internalPhone, email, roomNum) Values(2009, 'Jessica', 'Cruz', 'Professor', 'Psychology', '30455555564','cruz@marshall.edu',410);

INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1001, 'Frank', 'Quinzel', '3rd Street', 'Charleston', 27003, 3045551001, 'Frank1001@marshall.edu', '1988-8-12', 'Male', 'Senior', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1002, 'Alfred', 'Webb', '1st Street', 'Beckley', 28001, 3045551002, 'Alfred1002@marshall.edu', '1992-4-5', 'Male', 'Freshman', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1003, 'Damien', 'Ker', '4th Street', 'Parkersburg', 26004, 3045551003, 'Damien1003@marshall.edu', '1972-8-23', 'Male', 'Senior', 'American', 'Physical Education', 2005);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1004, 'Pamela', 'Nigma', '4th Street', 'Charleston', 27004, 3045551004, 'Pamela1004@marshall.edu', '1957-7-26', 'Female', 'Freshman', 'American', 'Architecture', 2006);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1005, 'Kara', 'Webb', '4th Street', 'Huntington', 25004, 3045551005, 'Kara1005@marshall.edu', '1987-0-10', 'Female', 'Senior', 'American', 'Aerodynamics', 2004);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1006, 'Alan', 'Wayne', '1st Street', 'Parkersburg', 26001, 3045551006, 'Alan1006@marshall.edu', '1971-1-27', 'Male', 'Sophomore', 'American', 'Theatre', 2002);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1007, 'Richard', 'Gordon', '4th Street', 'Huntington', 25004, 3045551007, 'Richard1007@marshall.edu', '1989-5-9', 'Male', 'Freshman', 'American', 'Architecture', 2006);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1008, 'Helena', 'Ivy', '5th Street', 'Huntington', 25005, 3045551008, 'Helena1008@marshall.edu', '1977-12-24', 'Female', 'Freshman', 'American', 'Computer Science', 2000);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1009, 'Jean-Paul', 'Moore', '3rd Street', 'Beckley', 28003, 3045551009, 'Jean-Paul1009@marshall.edu', '1983-8-10', 'Male', 'Junior', 'American', 'Graphic Design', 2007);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1010, 'Nathan', 'Moore', '3rd Street', 'Huntington', 25003, 3045551010, 'Nathan1010@marshall.edu', '1974-6-22', 'Male', 'Junior', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1011, 'Charlie', 'Gordon', '2nd Street', 'Huntington', 25002, 3045551011, 'Charlie1011@marshall.edu', '1980-6-16', 'Male', 'Freshman', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1012, 'Nathan', 'Cobble', '4th Street', 'Charleston', 27004, 3045551012, 'Nathan1012@marshall.edu', '1997-3-18', 'Male', 'Senior', 'American', 'Psychology', 2009);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1013, 'Edward', 'Cobble', '1st Street', 'Beckley', 28001, 3045551013, 'Edward1013@marshall.edu', '1959-6-20', 'Male', 'Sophomore', 'American', 'Graphic Design', 2007);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1014, 'Alan', 'Bertinelli', '1st Street', 'Charleston', 27001, 3045551014, 'Alan1014@marshall.edu', '1969-1-2', 'Male', 'Sophomore', 'American', 'Psychology', 2009);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1015, 'Charlie', 'Jones', '4th Street', 'Parkersburg', 26004, 3045551015, 'Charlie1015@marshall.edu', '1998-8-27', 'Male', 'Freshman', 'American', 'Graphic Design', 2007);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1016, 'Barbara', 'Ivy', '4th Street', 'Huntington', 25004, 3045551016, 'Barbara1016@marshall.edu', '1986-10-2', 'Female', 'Freshman', 'American', 'Aerodynamics', 2004);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1017, 'Pamela', 'Quietly', '4th Street', 'Parkersburg', 26004, 3045551017, 'Pamela1017@marshall.edu', '1985-5-4', 'Female', 'Graduate', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1018, 'Oswald', 'Pennyworth', '5th Street', 'Charleston', 27005, 3045551018, 'Oswald1018@marshall.edu', '1959-1-6', 'Male', 'Graduate', 'American', 'Physical Education', 2005);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1019, 'Cassandra', 'Moore', '5th Street', 'Parkersburg', 26005, 3045551019, 'Cassandra1019@marshall.edu', '1952-7-20', 'Female', 'Junior', 'American', 'Aerodynamics', 2004);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1020, 'Pamela', 'Cain', '1st Street', 'Charleston', 27001, 3045551020, 'Pamela1020@marshall.edu', '1995-12-17', 'Female', 'Graduate', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1021, 'Jim', 'Ivy', '3rd Street', 'Charleston', 27003, 3045551021, 'Jim1021@marshall.edu', '1999-5-21', 'Male', 'Junior', 'American', 'Theatre', 2002);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1022, 'Richard', 'Todd', '2nd Street', 'Beckley', 28002, 3045551022, 'Richard1022@marshall.edu', '1995-3-1', 'Male', 'Freshman', 'American', 'Aerodynamics', 2004);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1023, 'Harley', 'Ker', '5th Street', 'Parkersburg', 26005, 3045551023, 'Harley1023@marshall.edu', '1987-0-8', 'Female', 'Junior', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1024, 'Betty', 'Quietly', '4th Street', 'Parkersburg', 26004, 3045551024, 'Betty1024@marshall.edu', '1953-12-15', 'Female', 'Graduate', 'American', 'English', 2001);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1025, 'Jim', 'Kane', '3rd Street', 'Beckley', 28003, 3045551025, 'Jim1025@marshall.edu', '1960-10-3', 'Male', 'Freshman', 'American', 'Psychology', 2009);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1026, 'Cassandra', 'Bertinelli', '2nd Street', 'Beckley', 28002, 3045551026, 'Cassandra1026@marshall.edu', '1971-2-11', 'Female', 'Sophomore', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1027, 'Pamela', 'Brown', '1st Street', 'Beckley', 28001, 3045551027, 'Pamela1027@marshall.edu', '1978-12-19', 'Female', 'Junior', 'American', 'Psychology', 2009);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1028, 'Connor', 'Valley', '1st Street', 'Parkersburg', 26001, 3045551028, 'Connor1028@marshall.edu', '1979-12-23', 'Male', 'Senior', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1029, 'Richard', 'Nigma', '2nd Street', 'Charleston', 27002, 3045551029, 'Richard1029@marshall.edu', '1951-2-18', 'Male', 'Graduate', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1030, 'Selina', 'Gordon', '5th Street', 'Beckley', 28005, 3045551030, 'Selina1030@marshall.edu', '1980-12-9', 'Female', 'Freshman', 'American', 'Graphic Design', 2007);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1031, 'Stephanie', 'Cobble', '2nd Street', 'Parkersburg', 26002, 3045551031, 'Stephanie1031@marshall.edu', '1994-0-1', 'Female', 'Sophomore', 'American', 'Aerodynamics', 2004);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1032, 'Pamela', 'Payne', '3rd Street', 'Beckley', 28003, 3045551032, 'Pamela1032@marshall.edu', '1952-3-26', 'Female', 'Senior', 'American', 'Psychology', 2009);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1033, 'Betty', 'Moore', '1st Street', 'Huntington', 25001, 3045551033, 'Betty1033@marshall.edu', '1994-2-14', 'Female', 'Graduate', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1034, 'Helena', 'Moore', '5th Street', 'Parkersburg', 26005, 3045551034, 'Helena1034@marshall.edu', '1975-2-12', 'Female', 'Senior', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1035, 'Kara', 'Bertinelli', '5th Street', 'Parkersburg', 26005, 3045551035, 'Kara1035@marshall.edu', '1967-1-10', 'Female', 'Graduate', 'American', 'Theatre', 2002);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1036, 'Damien', 'Quinzel', '2nd Street', 'Parkersburg', 26002, 3045551036, 'Damien1036@marshall.edu', '1958-0-23', 'Male', 'Senior', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1037, 'Pamela', 'Nigma', '3rd Street', 'Charleston', 27003, 3045551037, 'Pamela1037@marshall.edu', '1969-12-1', 'Female', 'Junior', 'American', 'Criminal Justice', 2008);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1038, 'Selina', 'Moore', '3rd Street', 'Beckley', 28003, 3045551038, 'Selina1038@marshall.edu', '1959-11-13', 'Female', 'Freshman', 'American', 'Archaelogy', 2003);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1039, 'Pamela', 'Quietly', '1st Street', 'Huntington', 25001, 3045551039, 'Pamela1039@marshall.edu', '1971-2-14', 'Female', 'Junior', 'American', 'Graphic Design', 2007);
INSERT INTO Student(muId, fName, lName, street, city, postCode, phoneNumber, email, dateOfBirth, gender,schoolRank,nationality,major,advisorNum) VALUES(1040, 'Damien', 'Valley', '2nd Street', 'Huntington', 25002, 3045551040, 'Damien1040@marshall.edu', '1955-0-22', 'Male', 'Sophomore', 'American', 'Archaelogy', 2003);

INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(1, 'Lot 1', '22 3rd Avenue', 25701, 300, 100);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(2, 'Lot 2', '24 3rd Avenue', 25701, 444, 14);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(3, 'Lot 3', '25 3rd Avenue', 25701, 200, 100);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(4, 'Lot 4', '26 3rd Avenue', 25701, 400, 400);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(5, 'Lot 5', '22 5th Avenue', 25701, 200, 140);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(6, 'Lot 6', '10 5th Avenue', 25701, 30, 0);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(7, 'Lot 7', '30 5th Avenue', 25701, 20, 5);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(8, 'Lot 8', '33 5th Avenue', 25701, 450, 225);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(9, 'Lot 9', '30 6th Avenue', 25701, 200, 10);
INSERT INTO Lot(lotNum, lotName, street, postCode, maxSpace, availability) VALUES(10, 'Lot 10', '40 6th Avenue', 25701, 1000, 500);

INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('1234tgm4j3ju2ne44', 'White', '4RT567', 'Ford', 'Explorer', 1036, 3);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('1234384jfnfi2ne44', 'White', '4RJ567', 'Chevy', 'Silverado', 1022, 4);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('48nfnuisndfjnjhgu', 'Red', '5RT567', 'Ford', 'Explorer', 1003, 5);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('jdfisioghsdihggoi', 'Red', '7JGF67', 'Ford', 'Explorer', 1028, 4);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('dkfjidjsf884hiof8', 'Silver', '8JF567', 'Kia', 'Spectra', 1020, 7);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('f4ijfos88ihghsdgn', 'Silver', 'NF89FF', 'Ford', 'Explorer', 1011, 8);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('3uhriu4ghfi7duihf', 'Blue', 'FLASH', 'Mazda', 'Three', 1039, 9);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('38yfh8syd9fh8dsfo', 'Blue', 'GREEN L', 'Ford', 'Explorer', 1024, 7);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('fi8sdoyf8hsduofhj', 'Yellow', 'FKNIFD', 'Voltswagon', 'Beetle', 1001, 2);
INSERT INTO Vehicle(VINNum, color, licensePlate, manufacturer, brand, studentMuId, lotNum) VALUES('8y38orhieh8y48hfi', 'Yellow', 'WALLYWEST', 'Kia', 'Sorento', 1012, 3);

INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(101, 'Holderby Hall', '1720 5th Avenue', 'Huntington', 25701, '3045555101', 2001);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(102, 'Towers West', '1820 5th Avenue', 'Huntington', 25701, '3045555102', 2002);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(103, 'Towers East', '1860 5th Avenue', 'Huntington', 25701, '3045555103', 2003);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(104, 'Freshman Hall', '1910 5th Avenue', 'Huntington', 25703, '3045555104', 2004);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(105, 'Buskirk', '1710 5th Avenue', 'Huntington', 25701, '3045555105', 2005);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(106, 'Hall #6', '1620 5th Avenue', 'Huntington', 25700, '3045555106', 2006);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(107, 'Hall #7', '1630 5th Avenue', 'Huntington', 25700, '3045555107', 2007);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(108, 'Hall #8', '1640 5th Avenue', 'Huntington', 25700, '3045555108', 2008);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(109, 'Hall #9', '1650 5th Avenue', 'Huntington', 25700, '3045555109', 2009);
INSERT INTO ResidenceHall(hallNumber, hallName, street, city, postCode, phoneNumber, manager) VALUES(110, 'Hall #10', '1660 5th Avenue', 'Huntington', 25700, '3045555110', 2010);

INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(201, 101, '456 Village Street #101', 'Huntington', 25702, 4);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(202, 102, '456 Village Street #102', 'Huntington', 25702, 3);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(203, 103, '456 Village Street #103', 'Huntington', 25702, 5);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(204, 104, '456 Village Street #104', 'Huntington', 25702, 2);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(205, 201, '456 Village Street #201', 'Huntington', 25702, 3);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(206, 202, '456 Village Street #202', 'Huntington', 25702, 4);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(207, 203, '456 Village Street #203', 'Huntington', 25702, 6);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(208, 101, '510 Village Street #101', 'Huntington', 25702, 4);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(209, 102, '510 Village Street #102', 'Huntington', 25702, 5);
INSERT INTO Flats(flatNum, apartmentNum, street, city, postCode, numOfSingleRoom) VALUES(210, 103, '510 Village Street #103', 'Huntington', 25702, 4);

Insert Into Room(placeNum, roomNum, rentRate, hallNum) VALUES(1001, 111, 400, 101);
Insert Into Room(placeNum, roomNum, rentRate, hallNum) VALUES(1002, 120, 500, 101);
Insert Into Room(placeNum, roomNum, rentRate, hallNum) VALUES(1003, 310, 450, 102);
Insert Into Room(placeNum, roomNum, rentRate, hallNum) VALUES(1004, 111, 350, 104);
Insert Into Room(placeNum, roomNum, rentRate, hallNum) VALUES(1005, 432, 600, 106);
Insert Into Room(placeNum, roomNum, rentRate, flatNum) VALUES(1006, 101, 400, 201);
Insert Into Room(placeNum, roomNum, rentRate, flatNum) VALUES(1007, 101, 400, 201);
Insert Into Room(placeNum, roomNum, rentRate, flatNum) VALUES(1008, 102, 600, 202);
Insert Into Room(placeNum, roomNum, rentRate, flatNum) VALUES(1009, 103, 700, 203);
Insert Into Room(placeNum, roomNum, rentRate, flatNum) VALUES(1010, 202, 630, 206);

INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1001001,'FALL', '2019-12-13', 1001, 1025);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1001002,'SPRING', '2019-05-15', 1001, 1025);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1002001,'FALL', '2019-12-13', 1002, 1020);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1003001,'FALL', '2019-12-13', 1003, 1010);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1004001,'FALL', '2019-12-13', 1004, 1039);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1005001,'SPRING', '2019-05-15', 1005, 1002);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1006001,'SPRING', '2019-05-15', 1006, 1024);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1007001,'SUMMER', '2019-08-01', 1007, 1028);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1008001,'SUMMER', '2019-08-01', 1008, 1030);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1009001,'SUMMER', '2019-08-01', 1009, 1013);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1010001,'FALL', '2019-12-13', 1010, 1027);
INSERT INTO Lease(leaseNum, leasePeriod,occupantLeave, placeNum, muId) VALUES(1010000,'SPRING', '2019-05-15', 1001, 1025);

INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(1, 'FALL', '2019-09-28', 'Visa', 1001001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(2, 'SPRING', '2019-02-01', 'Visa', 1001002); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(3, 'FALL', '2019-09-26', 'Mastercard',  1002001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(4, 'FALL', '2019-08-28', 'Chase',1003001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(5, 'FALL', '2019-08-28', 'Visa',1004001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(6, 'SPRING', '2019-01-13', 'Chase',1005001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(7, 'SPRING', '2019-01-31', 'Mastercard',1006001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(8, 'SUMMER', '2019-06-20', 'Mastercard',1007001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(9, 'SUMMER', '2019-06-12', 'Visa',1008001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(10, 'SUMMER', '2019-06-10', 'Check', 1009001); 
INSERT INTO Invoices(invoiceNum, semesterDue, payDate, payMethod, leaseNum) VALUES(11, 'FALL', '2019-09-28', 'Mastercard',1010001); 

INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2001, 'Bruce', 'Wayne', 'batman@marshall.edu', '2nd Street', 'Huntington', 25702, '1939-05-01', 'Male', 'Manager', 101);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2002, 'Clark', 'Kent', 'superman@marshall.edu', '1st Street', 'Huntington', 25702, '1938-06-01', 'Male', 'Manager', 102);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2003, 'Arthur', 'Curry', 'aquaman@marshall.edu', '3rd Street', 'Huntington', 25702, '1939-05-01', 'Male', 'Manager', 103);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2004, 'Johhn', 'Jones', 'martianmanhunter@marshall.edu', '1st Street', 'Huntington', 25702, '1955-11-15', 'Male', 'Manager', 104);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2005, 'Barry', 'Allen', 'flash@marshall.edu', '3rd Street', 'Huntington', 25702, '1956-10-23', 'Male', 'Manager', 105);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2010, 'Victor', 'Stone', 'cyborg@marshall.edu', '4th Street', 'Huntington', 25702, '1980-10-07', 'Male', 'Manager', 110);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2007, 'Nathaniel', 'Adam', 'captainatom@marshall.edu', '1st Street', 'Huntington', 25702, '1939-05-01', 'Male', 'Manager', 107);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2008, 'Billy', 'Batson', 'shazam@marshall.edu', '1st Street', 'Huntington', 25702, '1941-03-10', 'Male', 'Manager', 108);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2009, 'Giovani', 'Zatara', 'zatara@marshall.edu', '5th Street', 'Huntington', 25702, '1938-06-01', 'Male', 'Manager', 109);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2006, 'Diana', 'Prince', 'wonderwoman@marshall.edu', '1st Street', 'Huntington', 25702, '1941-10-08', 'Female', 'Manager', 110);
INSERT INTO Staff(staffNum, fName, lName,email, street, city, postCode, dateOfBirth, gender, position, workLocation) VALUES(2011, 'Donna', 'Troy', 'troiya@marshall.edu', '1st Street', 'Huntington', 25702, '1965-06-30', 'Female', 'Front Desk', 110);

INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(1, '2019-04-23', 201, 2001, 'Satisfactory', 'They need to be reminded of command strips and not to use nails.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(2, '2019-06-23', 201, 2001, 'Unsatisfactory', 'They destroyed a wall removing nails. Deposit should not be returned.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(3, '2019-05-01', 203, 2002, 'Satisfactory', 'No comment.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(4, '2019-07-23', 204, 2003, 'Satisfactory', 'Recently vacuumed and scrubbed.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(5, '2019-08-29', 203, 2005, 'Satisfactory', 'No comment.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(6, '2019-09-03', 207, 2006, 'Unsatisfactory', 'New scratches on wall.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(7, '2019-09-13', 208, 2007, 'Satisfactory', 'No comment.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(8, '2019-10-01', 209, 2008, 'Satisfactory', 'Clean.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(9, '2019-10-18', 209, 2009, 'Satisfactory', 'No comment.');
INSERT INTO Inspections(inspectNum, inspectDate, flatNum, staffNum, conditionOfFlat, comments) VALUES(10, '2019-12-01', 210, 2010, 'Satisfactory', 'No comment.'); 

INSERT INTO Course(courseNum, courseTitle) VALUES(1, 'Math 1');
INSERT INTO Course(courseNum, courseTitle) VALUES(2, 'Math 2');
INSERT INTO Course(courseNum, courseTitle) VALUES(3, 'English 1');
INSERT INTO Course(courseNum, courseTitle) VALUES(4, 'English 2');
INSERT INTO Course(courseNum, courseTitle) VALUES(5, 'English 3');
INSERT INTO Course(courseNum, courseTitle) VALUES(6, 'Science 1');
INSERT INTO Course(courseNum, courseTitle) VALUES(7, 'Science 2');
INSERT INTO Course(courseNum, courseTitle) VALUES(8, 'Art');
INSERT INTO Course(courseNum, courseTitle) VALUES(9, 'JiuJitsu');
INSERT INTO Course(courseNum, courseTitle) VALUES(10, 'UnderWater Basket Weaving');

INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(1, 1025, 'FALL', 2018, 'Ted Kord', '5555555555', 'bluebeetle@marshall.edu', 435,1);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(2, 1036, 'FALL', 2018, 'Ted Kord', '5555555555', 'bluebeetle@marshall.edu', 435,1);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(3, 1020, 'FALL', 2018, 'Carter Hall', '5555555556', 'hawkman@marshall.edu', 223,2);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(4, 1025, 'FALL', 2018, 'Carter Hall', '5555555556', 'hawkman@marshall.edu', 245,2);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(5, 1025, 'SPRING', 2019, 'Carter Hall', '5555555556', 'hawkman@marshall.edu', 250,2);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(6, 1002, 'FALL', 2018, 'Wally West', '5555555557', 'bestflash@marshall.edu', 235,3);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(7, 1002, 'SPRING', 2019, 'Wally West', '5555555557', 'bestflash@marshall.edu', 235,3);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(8, 1038, 'FALL', 2018, 'Kyle Rainer', '5555555558', 'greenlantern4@marshall.edu', 235,3);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(9, 1027, 'SUMMER', 2018, 'Dick Grayson', '5555555559', 'nightwing@marshall.edu', 455,5);
INSERT INTO studentInCourse(courseNum, muId, semester, yearOfClass, courseInstructor, instructorPhone, instructorEmail,roomNum, deptNum) VALUES(10, 1025, 'SUMMER', 2018, 'Dr. Straw', '5555555555', 'strawman@marshall.edu', 435,10);

INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(1, 'Franklin', 'Quinzel', '3rd Street', 'Charleston', 27003, '1234567890');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(2, 'Alfonse', 'Webb', '1st Street', 'Beckley', 28001, '1234567891');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(3, 'Damon', 'Ker', '4th Street', 'Parkersburg', 26004, '1234567892');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(4, 'Pam', 'Nigma', '4th Street', 'Charleston', 27004, '1234567893');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(5, 'Aladin', 'Wayne', '1st Street', 'Parkersburg', 26001, '1234567894');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(6, 'Rick', 'Gordon', '4th Street', 'Huntington', 25004, '1234567895');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(7, 'Heather', 'Ivy', '5th Street', 'Huntington', 25005, '1234567896');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(8, 'John', 'Moore', '3rd Street', 'Beckley', 28003, '1234567897');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(9, 'Ellard', 'Cobble', '1st Street', 'Beckley', 28001, '1234567898');
INSERT INTO nextOfKin(kinId, fName, lName, street, city, postCode, phoneNum) VALUES(10, 'Aaron', 'Bertinelli', '1st Street', 'Charleston', 27001, '1234567899');

INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(1, 1001, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(2, 1002, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(2, 1005, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(3, 1003, 'Guardian');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(4, 1004, 'Mother');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(5, 1006, 'Grandpa');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(6, 1007, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(6, 1011, 'Uncle');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(7, 1008, 'Mother');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(8, 1009, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(8, 1010, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(9, 1012, 'Father');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(9, 1013, 'Uncle');
INSERT INTO studentNextOfKin(kinId, studentMuId,relationship) VALUES(10, 1014, 'Father');
/* source C:/Users/nate2/OneDrive/Documents/CS 410 Database Engineering/muDB_CREATETABLE.sql;*/