Use SqlSaturday
ALTER TABLE Grade
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID); 

ALTER TABLE Grade
ADD FOREIGN KEY (LectureID) REFERENCES Lecture(LectureID); 

ALTER TABLE Lecture
ADD FOREIGN KEY (TrackID) REFERENCES Track(TrackID); 

ALTER TABLE LectureLevel
ADD FOREIGN KEY (LectureID) REFERENCES Lecture(LectureID); 

ALTER TABLE Lecturer
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID); 

ALTER TABLE Lecturer
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID); 

ALTER TABLE LecturerLecture
ADD FOREIGN KEY (LecturerID) REFERENCES Participant(ParticipantID); 

ALTER TABLE LecturerLecture
ADD FOREIGN KEY (LectureID) REFERENCES Lecture(LectureID); 

ALTER TABLE Organizer
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID); 

ALTER TABLE Organizer
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID); 

ALTER TABLE Participant
ADD FOREIGN KEY (AddressID) REFERENCES AddressTable(AddressID); 

ALTER TABLE Participant
ADD FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID); 

ALTER TABLE Room
ADD FOREIGN KEY (VenueID) REFERENCES Venue(VenueID); 

ALTER TABLE Schedule
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID); 

ALTER TABLE Schedule
ADD FOREIGN KEY (LectureID) REFERENCES Lecture(LectureID); 

ALTER TABLE Schedule
ADD FOREIGN KEY (RoomID) REFERENCES Room(RoomID); 

ALTER TABLE SqlSatEvent
ADD FOREIGN KEY (VenueID) REFERENCES Venue(VenueID);

ALTER TABLE Student
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID);

ALTER TABLE Student
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID);

ALTER TABLE StudentLecture
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID);

ALTER TABLE StudentLecture
ADD FOREIGN KEY (LectureID) REFERENCES Lecture(LectureID);

ALTER TABLE Vendor
ADD FOREIGN KEY (AddressID) REFERENCES AddressTable(AddressID);

ALTER TABLE VendorEvent
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID);

ALTER TABLE Volunteer
ADD FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID);

ALTER TABLE Volunteer
ADD FOREIGN KEY (EventID) REFERENCES SqlSatEvent(EventID);

