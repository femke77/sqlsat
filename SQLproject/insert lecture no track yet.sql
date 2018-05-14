
--assuming drop downs for track and lecture level 

USE SQLSaturday
GO
CREATE PROCEDURE addPresentation9 (@fname varchar(255), @lname varchar(255), @lectitle varchar(255), @lecdesc varchar(500),@diff tinyint, @dur smallint)
AS 
BEGIN
	SET NOCOUNT ON
    BEGIN TRY
	
	IF exists (SELECT l.ParticipantID from Lecturer as l left join Participant as p on l.ParticipantID = p.ParticipantID where
	 @fname = p.FirstName AND @lname = p.LastName)
	BEGIN
		DECLARE @participantid int
		DECLARE @lectureid int
		SELECT @participantid =  ParticipantID from Participant where @fname = FirstName AND @lname = Participant.LastName
		INSERT INTO Lecture VALUES (@lectitle, @diff, @lecdesc, @dur)		
		SELECT @lectureid = LectureID from Lecture where LectureTitle = @lectitle
		INSERT INTO LecturerLecture VALUES (@participantid, @lectureid)
	END
	ELSE
	RAISERROR ('Error - Lecturer ID not found',16,1)
	END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;

	SELECT 
		@ErrorMessage = ERROR_MESSAGE(),
	    @ErrorSeverity = ERROR_SEVERITY(),
		@ErrorState = ERROR_STATE();

	RAISERROR (@ErrorMessage, @ErrorSeverity,
	          @ErrorState);

END CATCH
END
GO
