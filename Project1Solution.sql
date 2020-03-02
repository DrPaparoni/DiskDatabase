/********************************************************************/
/*  Date		Name			Description                         */
/*  --------------------------------------------------------------- */
/*                                                                  */
/*  2/28/2020	Eric Walter		Initial deployed                    */
/********************************************************************/

USE master;
GO

--Remove & create disk inventory
DROP DATABASE IF EXISTS disk_inventoryEW;
go

CREATE DATABASE disk_inventoryEW;
go

use disk_inventoryEW;
go

--Create Lookup Table
CREATE TABLE genre (
	genre_id int not null PRIMARY KEY,
	[description] VARCHAR(60) NOT NULL
);

CREATE TABLE status (
	status_id int not null PRIMARY KEY,
	[description] VARCHAR(60) NOT NULL
)
;
CREATE TABLE CDType (
	TypeID int not null PRIMARY KEY,
	[description] VARCHAR(60) NOT NULL
);

CREATE TABLE ArtistType(
	Artist_Type_ID int not null PRIMARY KEY,
	[description] VARCHAR(60) NOT NULL
);

CREATE TABLE Borrower (
	Borrower_ID int not null PRIMARY KEY,
	fname VARCHAR (60) NOT NULL,
	lname VARCHAR (60) NOT NULL,
	Borrower_Phone_Number VARCHAR(15) NOT NULL
);

CREATE TABLE Artist (
	Artist_ID int not null PRIMARY KEY,
	fname VARCHAR (60) NOT NULL,
	lname VARCHAR (60) NULL,
	Artist_Type_ID int not null REFERENCES ArtistType(Artist_Type_ID)
);

CREATE TABLE CD(
	CD_ID int not null PRIMARY KEY,
	CD_name VARCHAR(60) NOT NULL,
	Release_Date date not null,
	Genre_ID int not null REFERENCES genre(genre_ID),
	Status_ID int not null REFERENCES [Status](Status_ID),
	TypeID int not null references CDType(TypeID)
);

CREATE TABLE CDArtist(
	CD_ID int not null references cd(CD_ID),
	artist_ID int not null references artist(Artist_ID)
	PRIMARY KEY (CD_ID, Artist_ID)
);

CREATE TABLE CDBorrower(
	borrower_ID int not null references borrower(borrower_ID),
	CD_ID int not null references CD(CD_ID),
	borrowed_date date not null,
	returned_date date null,
	PRIMARY KEY (borrower_ID, CD_ID, borrowed_date)
)

--Drop and create login
IF SUSER_ID('diskUserEW') IS NULL
	CREATE LOGIN diskUserEW WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryEW;

DROP USER IF EXISTS diskUserEW;

CREATE USER diskUserEW FOR LOGIN diskUserEW;

--grant read permissions to user
ALTER ROLE db_datareader ADD MEMBER diskUserEW;