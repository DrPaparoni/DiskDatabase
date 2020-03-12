/********************************************************************/
/*  Date		Name			Description                         */
/*  --------------------------------------------------------------- */
/*                                                                  */
/*  2/28/2020	Eric Walter		Initial deployed                    */
/*  3/5/2020	Eric Walter		added insert statements to all tables.*/
/*  3/12/2020	Eric Walter		added reports about cd status       */
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
	Borrower_Phone_Number VARCHAR(15) NOT NULL             --made phone number requred
);

CREATE TABLE Artist (
	Artist_ID int not null PRIMARY KEY,
	fname VARCHAR (60) NOT NULL,
	lname VARCHAR (60) NULL,        --allowed artists with no last name
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



--Project 3

USE [disk_inventoryEW]
GO
-- Insert Status
INSERT INTO [dbo].[status]
           ([status_id],
		   [description])
     VALUES
           (1,'Available'),
		   (2,'On loan'),
		   (3,'Damaged'),
		   (4,'Missing')
GO
--Insert Genre
INSERT INTO [dbo].[genre]
           ([genre_id],
		   [description])
     VALUES
           (1,'Classic Rock'),
		   (2,'Country'),
		   (3,'Jazz'),
		   (4,'AltRock'),
		   (5,'Metal')
GO
--Insert CD Type
INSERT INTO [dbo].[CDType]
           ([TypeID],[description])
     VALUES
           (1,'CD'),
		   (2,'Vinyl'),
		   (3,'8Track'),
		   (4,'Cassette'),
		   (5,'DVD')
GO

--Insert Cd artist type
INSERT INTO [dbo].[ArtistType]
           ([Artist_Type_ID]
           ,[description])
     VALUES
           (1, 'Solo'),
		   (2, 'Group')
GO


--insert cd table part C
INSERT INTO [dbo].[CD]
           ([CD_ID]
           ,[CD_name]
           ,[Release_Date]
           ,[Genre_ID]
           ,[Status_ID]
           ,[TypeID])
     VALUES
           (1, 'Crazy Train', '1/1/1995', 1,1,1),
		   (2, 'No More Tears', '11/21/1995', 1,1,1),
		   (3, 'Red', '11/13/2008', 2,2,1),
		   (4, 'Jagged Little Pill', '1/5/1995', 1,2,1),
		   (5, 'Candy-O', '10/10/1992', 1,2,2),
		   (6, 'Hotel California', '11/1/1977', 1,1,1),
		   (7, 'One of These Nights', '4/1/1975', 1,2,2),
		   (8, 'The Long Run', '10/21/1979', 1,2,2),
		   (9, 'Hints, Allegations, and Things Left Unsaid', '1/1/1995', 4,2,1),
		   (10, 'Blender', '1/29/2000', 4,1,1),
		   (11, 'Dirt', '1/27/1992', 4,1,2),
		   (12, 'Unplugged', '5/23/1996', 4,1,2),
		   (13, 'Facelift', '8/22/1990', 4,1,2),
		   (14, 'Black Gives Way to Blue', '11/21/2009', 4,1,2),
		   (15, 'Live', '11/11/2009', 4,1,2),
		   (16, 'Ten', '12/1/1991', 4,1,2),
		   (17, 'Vitalogy', '3/22/1994', 4,1,2),
		   (18, 'No Code', '4/2/1996', 4,1,2),
		   (19, 'Backspacer', '5/21/2009', 1,1,1),
		   (20, 'Home', '1/19/1995', 1,2,1)
GO

UPDATE CD
SET Release_Date = '11/11/2011'
WHERE CD_ID = 20;
go

--Insert Borrower rows part D
INSERT INTO [dbo].[Borrower]
           ([Borrower_ID],[fname],[lname],[Borrower_Phone_Number])
     VALUES
           (1,'Mickey', 'Mouse', '111-111-1234'),
		   (2,'Miney', 'Mouse', '111-111-1234'),
		   (3,'Daisy', 'Duck', '123-111-1234'),
		   (4,'Daffy', 'Duck', '444-111-1234'),
		   (5,'Donald', 'Duck', '555-111-1234'),
		   (6,'Huey', 'Duck', '666-111-1234'),
		   (7,'Dewey', 'Duck', '777-111-1234'),
		   (8,'Loui', 'Duck', '888-111-1234'),
		   (9,'Elmer', 'Fudd', '999-111-1234'),
		   (10,'Buzz', 'Lightyear', '122-111-1234'),
		   (11,'Sherrif', 'Woody', '133-111-1234'),
		   (12,'Little Bo', 'Peep', '144-111-1234'),
		   (13,'Slinky', 'Dog', '155-111-1234'),
		   (14,'Mr. Potato', 'Head', '166-111-1234'),
		   (15,'Mr. ', 'Spell', '177-111-1234'),
		   (16,'Race', 'Car', '188-111-1234'),
		   (17,'T', 'Rez', '199-111-1234'),
		   (18,'Mrs.', 'Potato', '211-111-1234'),
		   (19,'Sargeant', 'Soldier', '311-111-1234'),
		   (20,'Jessie', 'Cowgirl', '111-111-1234')
		   
GO
--Delete the last borrower
DELETE Borrower
WHERE Borrower_ID = 20;
--Insert Artist rows part E
INSERT INTO [dbo].[Artist]
           ([Artist_ID],[fname],[lname],[Artist_Type_ID])
     VALUES
           (1, 'Ozzy', 'Osbourne', 1),
		   (2, 'Taylor', 'Swift', 1),
		   (3, 'Alanis', 'Morrisette', 1),
		   (4, 'Chris', 'Daughtry', 1),
		   (5, 'The Cars', null, 2),
		   (6, 'Black Sabbath', null, 2),
		   (7, 'The Eagles', null, 2),
		   (8, 'Patsy', 'Cline', 1),
		   (9, 'Pearl Jam', NULL, 2),
		   (10, 'Shinedown', null, 2),
		   (11, 'Collective Soul', null, 2),
		   (12, 'Five Finger Death Punch', null, 2),
		   (13, 'Disturbed', NULL, 2),
		   (14, 'Stone Temple Pilots', NULL, 2),
		   (15, 'Breaking Benjamin', NULL, 2),
		   (16, 'Seether', null, 2),
		   (17, 'Audioslave', null, 2),
		   (18, 'Daftpunk', null, 2),
		   (19, 'Snoop', 'Dogg', 1),
		   (20, 'Alice In Chains', null, 2)
GO

--CDBorrower insert part F
INSERT INTO [dbo].[CDBorrower]
           ([borrower_ID],[CD_ID],[borrowed_date],[returned_date])
     VALUES
           (2, 4, '1-2-2019', '2-20-2019'),
		   (3, 5, '11-12-2019', '12-21-2019'),
		   (4, 6, '1-22-2019', '2-22-2019'),
		   (2, 7, '7-22-2019', '8-20-2019'),
		   (5, 2, '10-2-2019', '12-20-2019'),
		   (5, 7, '4-2-2019', '5-20-2019'),
		   (5, 7, '8-22-2019', '9-22-2019'),
		   (5, 8, '11-2-2019', '12-20-2019'),
		   (11, 14, '7-26-2019', null),
		   (12, 15, '8-25-2019', '9-26-2019'),
		   (13, 15, '10-24-2019', '11-20-2019'),
		   (14, 11, '10-23-2019', '11-26-2019'),
		   (15, 11, '11-22-2018', '12-2-2018'),
		   (15, 12, '12-12-2018', null),
		   (8, 8, '3-21-2019', '6-23-2019'),
		   (9, 4, '4-2-2019', '7-20-2019'),
		   (10, 9, '5-25-2019', '6-22-2019'),
		   (4, 3, '6-2-2019', '7-29-2019'),
		   (7, 4, '1-22-2019', '2-22-2019'),
		   (2, 14, '5-12-2019', '6-2-2019')
GO

--Insert CDArtist rows PART G
INSERT INTO [dbo].[CDArtist]
           ([CD_ID]
           ,[artist_ID])
     VALUES
           (1,1),
		   (2,1),
		   (3,3),
		   (4,4),
		   (5,6),
		   (6,8),
		   (7,8),
		   (8,8),
		   (8,6),
		   (8,7),
		   (9,12),
		   (10,12),
		   (11,18),
		   (12,16),
		   (13,15),
		   (14,15),
		   (15,12),
		   (15,15),
		   (16,16),
		   (17,17)

GO

--H. List the disks on load that have not been returned
SELECT borrower_ID as Borrower_ID, CD_ID as Disk_ID, borrowed_date as Borrowed_Date, returned_date as Return_date
FROM CDBorrower
WHERE returned_date IS NULL;


-------------------------------------- Project 4 Starts here----------------------------------------------------------

--3. Show the disks in your database and any associated Individual artists only
select CD_name as 'CD Name', convert(varchar(10), Release_Date, 101) as 'Release Date', fname as 'Artist First Name', lname as 'Artist Last Name'
	--substring(fname, 1, charindex(fname, ' '))
from CD
join CDArtist on CD.CD_ID = CDArtist.CD_ID
join Artist on CDArtist.artist_ID = Artist.Artist_ID
where Artist_Type_ID = 1
order by lname, fname, CD_name;
go

--4. Create a view called View_Individual_Artist that shows the artists’ names and not group names. Include the artist id in the view definition but do not display the id in your output.
create view View_Individual_Artists as
	select Artist_ID, fname, lname
	from Artist
	where Artist_Type_ID = 1;
go
select fname as 'First Name', lname as 'Last Name'
from View_Individual_Artists
order by lname, fname;

--5. Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view
select CD_name as 'CD Name', convert(varchar(10), Release_Date, 101) as 'Release Date', fname as 'Group Name'
FROM CD
join CDArtist on CD.CD_ID = CDArtist.CD_ID
join Artist on CDArtist.artist_ID = Artist.Artist_ID
where artist.Artist_ID not in (select artist_ID from View_Individual_Artists)
order by [Group Name], [CD Name];

--6. Show which disks have been borrowed and who borrowed them.
SELECT fname as 'First', lname as 'Last', CD_name as 'CD Name', borrowed_date as 'Borrowed Date', returned_date as 'Returned Date'
from Borrower b
join CDBorrower  db on b.Borrower_ID = db.borrower_ID
join CD d on db.CD_ID = d.CD_ID
order by [CD Name], lname, fname, borrowed_date, returned_date;

--7. Show the number of times each disk has been borrowed.
select c.CD_ID, CD_name, count(*) as 'Times Borrowed'
from CD C
join CDBorrower cb on c.CD_ID = cb.CD_ID
group by c.CD_ID, CD_name
-- having cont(*) > 1
order by CD_ID, CD_name;

--8. Show the disks outstanding or on-loan and who has each disk.
SELECT CD_name as 'CD name', borrowed_date as Borrowed, returned_date as Returned, lname as 'Last Name'
from CD c
join CDBorrower cb on c.CD_ID = cb.CD_ID
join Borrower b on cb.borrower_ID = b.Borrower_ID
WHERE returned_date is null
order by CD_name;
