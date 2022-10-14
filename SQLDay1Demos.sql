USE ImpactBatch15;

/*
	SQL- Structured Query Lang.
		. DDL (Data Definition Lang.)=> CREATE, ALTER, DROP - {all database objects}, TRUNCATE(table,view) 
		. DML (Data Manipulation Lang.)=> INSERT, UPDATE, DELETE - {data -> tables, views}
		. DCL (Data Control Lang.)=> GRANT, REVOKE
		. TCL (Transaction Control Lang.)=> COMMIT, ROLLBACK
		. DQL (Data Query Lang.)=> SELECT
*/

/*
Schema - Logical group of database objects
	finance.Employee 
	hr.Employee
	finance.tab1
	hr.tab2
	hr.tab3
	dbo.tab4
	finance.tab5
	finance.tab6
	finance.proc1
	hr.proc2
	finance.udf1
	hr.udf2
*/

create table testtable
(
	col1 int,
	col2 varchar(20)
);

ALTER TABLE dbo.testtable ADD col3 MONEY;

DROP TABLE testtable;
---------------------------------------------------------------------
CREATE SCHEMA PatientAdministration;

CREATE TABLE PatientAdministration.Patient
(
	PatientID INT,
	PatientName VARCHAR(20),
	Gender VARCHAR(1),
	DOB DATE
);

SELECT * FROM PatientAdministration.Patient;

INSERT INTO PatientAdministration.Patient VALUES 
(101,'Raj Sharma','M','12-Jan-2009');

INSERT INTO PatientAdministration.Patient VALUES 
(102,'Priya Sharma','F','19-Oct-2013');

INSERT INTO PatientAdministration.Patient VALUES 
(103,'Fiona Dcosta','F','30-Mar-2011'),
(104,'Gary Smith','F','14-Oct-2015');

INSERT INTO PatientAdministration.Patient VALUES 
(105,'Barry Singh',NULL,'21-Sep-2023');
/**
DB Constraints
	. Primary Key ====> unique + not null 
	. Unique Key ====> unique including 1 null value
	. Foreign Key
	. DEFAULT
	. CHECK
	. NOT NULL
*/

DROP TABLE PatientAdministration.Patient

CREATE TABLE PatientAdministration.Patient
(
	PatientID INT PRIMARY KEY IDENTITY(1,1),
	PatientName VARCHAR(20) NOT NULL,
	Gender VARCHAR(1) CHECK (Gender IN('M','F','O','U')),
	DOB DATE CHECK (DOB < GETDATE()) NOT NULL,
	CreatedDate DATE DEFAULT GETDATE()
);

INSERT INTO PatientAdministration.Patient VALUES
(101,'Raj','M','12-Jan-2001','14-Oct-2022');	-- error

INSERT INTO PatientAdministration.Patient (PatientName,Gender,DOB)
VALUES ('Raj','M','12-Jan-2001'),
('Sam','M','23-Mar-2011'),
('Stacy','F','30-Oct-2005'),
('Raju','O','25-Sep-2009');

SELECT * FROM PatientAdministration.Patient;

INSERT INTO PatientAdministration.Patient (PatientName,Gender,DOB)
VALUES ('Bob',NULL,'12-Jan-2009')


CREATE TABLE PatientAdministration.PatientAddress
(
	
	AddressID INT PRIMARY KEY IDENTITY(1,1),
	PatientID INT REFERENCES PatientAdministration.Patient (PatientID) ON DELETE CASCADE,
	City VARCHAR(20),
	State VARCHAR(20),
	Postcode VARCHAR(20),
	Country VARCHAR(20)
);


INSERT INTO PatientAdministration.PatientAddress 
(PatientID, City,State,Postcode,Country) VALUES
(1,'Mumbai','MH','400070','IN'),
(2,'Beging','BE','73733','CH')

INSERT INTO PatientAdministration.PatientAddress 
(PatientID, City,State,Postcode,Country) VALUES
(99,'Mumbai','MH','400070','IN')

SELECT * FROM PatientAdministration.Patient
SELECT * FROM PatientAdministration.PatientAddress











