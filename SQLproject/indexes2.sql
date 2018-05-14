
------------------------------NONCLUSTERED INDEXES
--Remainder of non-indexed foreign keys created with object explorer
--see sql for discovering which keys those are

CREATE NONCLUSTERED INDEX ix_schedule_lecture
ON Schedule ([LectureID])


-----------------------------UNIQUE INDEXES

ALTER TABLE AddressTable
ADD CONSTRAINT unique_address UNIQUE (AddressLine, City, St, Zip)

ALTER TABLE Lecture
ADD CONSTRAINT unique_lecture UNIQUE (LectureTitle)

ALTER TABLE SqlSatEvent
ADD CONSTRAINT unique_event UNIQUE (VenueID, EventDate)

ALTER TABLE Track
ADD CONSTRAINT unique_track UNIQUE (TrackTitle)

ALTER TABLE Vendor
ADD CONSTRAINT unique_vendor UNIQUE (CompanyName)

ALTER TABLE Venue
ADD CONSTRAINT unique_venue UNIQUE (VenueName)



------------------------------OTHER

INSERT INTO LectureLevel VALUES('Beginner')
INSERT INTO LectureLevel VALUES('Intermediate')
INSERT INTO LectureLevel VALUES('Advanced')
INSERT INTO LectureLevel VALUES('Non-Technical')