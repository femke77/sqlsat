--IF EXISTS(select * from sys.databases where name='SQLSaturday')
--DROP DATABASE SQLSaturday
--GO
--CREATE DATABASE SQLSaturday
--GO
--USE SQLSaturday
--GO



--13 states have zipcodes that cross state lines and hundreds of cities share zip. No combination of city, state, zip are transitive
--dependendies. 

CREATE TABLE AddressTable
(
	AddressID int IDENTITY NOT NULL PRIMARY KEY,
	AddressLine varchar (255) NOT NULL,
	City varchar(255) NOT NULL,
	St varchar(4) NOT NULL,
	Zip varchar(10) NOT NULL

);

--email is not considered unique in all cases e.g. "customer_service@company.com" 
--phone is not unique e.g. 1-800 numbers or companies that use extensions based off a main line
--Participant is an organizer, lecturer, volunteer, or student any of whom may or may not be associated with a vendor (a business)
--Every participant can belong to 1 or more categories e.g. a lecturer may also be a student. 
CREATE TABLE Participant
(
	ParticipantID int IDENTITY NOT NULL PRIMARY KEY,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255) NOT NULL,
	AddressID int  NOT NULL,
	Email varchar(255) NOT NULL,
	Phone varchar(15) NOT NULL,
	PhoneExt varchar(6) NOT NULL,
	RaffleParticipant tinyint NULL,     
	VendorID int NULL	
);

--vendor is a business, participants can be associated with a vendor or not, these attributes are not the same as personal attributes ( more data!)
CREATE TABLE Vendor
(
	VendorID int IDENTITY NOT NULL PRIMARY KEY,
	CompanyName varchar(255) NOT NULL,
	AddressID int NOT NULL,
	Phone varchar(15),
	Email varchar(255)
);

--link vendors, events and tables, if tablenum is null, vendor is only a sponsor 
--stored procedure checks eventid and tablenumber and limits to 10 tables per eventid 
CREATE TABLE VendorEvent
(
	VendorID int NOT NULL,
	EventID int NOT NULL,  
	TableNumber int NULL,   
	TableDescription varchar(500) NULL, 
	RaffleParticipant tinyint NOT NULL
	PRIMARY KEY (VendorID, EventID)  
);

CREATE TABLE Volunteer
(
	ParticipantID int NOT NULL,
	EventID int NOT NULL
	PRIMARY KEY (ParticipantID, EventID)
);

CREATE TABLE Organizer
(
	ParticipantID int NOT NULL,
	EventID int NOT NULL,
	PRIMARY KEY (ParticipantID, EventID)

);

CREATE TABLE Lecturer
(
	ParticipantID int NOT NULL,
	EventID int NOT NULL,
	PRIMARY KEY (ParticipantID, EventID)

);

CREATE TABLE Student
(
	ParticipantID int NOT NULL,
	EventID int NOT NULL,
	PRIMARY KEY (ParticipantID, EventID)
);


--the event, get year in query with year(EventDate)
CREATE TABLE SqlSatEvent 
(	
	EventID int NOT NULL IDENTITY PRIMARY KEY,
	VenueID int NOT NULL,
	EventDate DATE NOT NULL,
	
);

--location of one event and contact info for who to set it up with/ask questions, purposely not done with participant id
CREATE TABLE Venue
(
	VenueID int NOT NULL IDENTITY PRIMARY KEY,
	VenueName varchar(255) NOT NULL,
	VenueAddressID int NOT NULL,
	ContactLastName varchar(255) NOT NULL,
	ContactFirstName varchar(255) NOT NULL,
	Email varchar(255) NULL,
	Phone varchar(15) NOT NULL,
	Ext varchar (6) NULL

);

-- capacities cannot be exceeded, put in stored procedure 
CREATE TABLE Room
(
	RoomNumber int NOT NULL, 
	VenueID int NOT NULL,
	Capacity int NOT NULL,
	PRIMARY KEY (RoomNumber, VenueID)
);

CREATE TABLE Lecture
(
	LectureID int IDENTITY NOT NULL PRIMARY KEY,
	LectureTitle varchar(255) NOT NULL,
	LectureLevel tinyint NOT NULL,
	Descripton varchar(500) NULL,
	MinutesDuration smallint NOT NULL DEFAULT '60',
	TrackID int NOT NULL

);

-- advanced, intermediate, beginner, non-technical
CREATE TABLE LectureLevel
(
	LectureID int NOT NULL PRIMARY KEY,
	DifficultyLevel varchar(20)
);


CREATE TABLE Track
(
	TrackID int IDENTITY NOT NULL PRIMARY KEY,
	TrackTitle varchar(255) NOT NULL,
	TrackDescription varchar(500),
);

--participants will grade the lectures with a char A B C D F
CREATE TABLE Grade
(
	LectureID int NOT NULL,
	ParticipantID int NOT NULL,
	Grade char(1) NOT NULL
	PRIMARY KEY (LectureID, ParticipantID)
);

--link lectures with lecturers - this assumes a lecture is its own entity and not dependent lecturer i.e. more than 1 person could teach same one
CREATE TABLE LecturerLecture
(
	LecturerID int NOT NULL,
	LectureID int NOT NULL
	PRIMARY KEY (LecturerID, LectureID)
)

--link students with lectures, this will naturally be many to many 
CREATE TABLE StudentLecture
(
	ParticipantID int NOT NULL,
	LectureID int NOT NULL,
	PRIMARY KEY (ParticipantID, LectureID)

)
--class can start at the same time at same event if different room, class can be same room if different times, if event is differnt the remaining 3
--can be the same. the same class, if taught by >1 lecturers (per previously stated assumption), could be at same time in different rooms. 
CREATE TABLE Schedule
(
	EventID int NOT NULL,
	LectureID int NOT NULL,
	RoomNumber int NOT NULL,
	LectureStart DATETIME NOT NULL,
	PRIMARY KEY (EventID, RoomNumber, LectureStart)  --this is automaticcally no go for repeat but duration checks need to be in the stored procedure
);