--ASSUMPTIONS:  
--eventid is by dropdown menu | Las Vegas, 5/10/18   |
--                            | Los Angeles, 5/10/18 |
--lecture title and start time are needed to uniquely identify and update is for a different room at the same event, venue & time only
--otherwise delete schedule and insert new

USE SQLSaturday
GO
CREATE PROCEDURE updateRoomNumber1 (@eventid int, @lectitle varchar(255), @lecturestart datetime, @newroomid int)
AS 
BEGIN
	SET NOCOUNT ON
    BEGIN TRY
	
	IF exists (SELECT EventID, LectureTitle, LectureStart from Schedule as s left join Lecture as l on s.LectureID = l.LectureID 
				where LectureTitle = @lectitle AND EventID = @eventid AND LectureStart = @lecturestart)
	BEGIN
	    DECLARE @lectureid int
		SELECT @lectureid = LectureID from Lecture WHERE LectureTitle = @lectitle	
		
		DECLARE @venue int
		SELECT @venue = VenueID from SqlSatEvent WHERE EventID = @eventid 

		DECLARE @newroomvenue int
		SELECT @newroomvenue = VenueID from Room WHERE RoomID = @newroomid --new room venue = old room venue
			
		IF (@venue = @newroomvenue)
			UPDATE Schedule SET RoomID = @newroomid WHERE EventID = @eventid AND LectureStart = @lecturestart AND LectureID = @lectureid
		ELSE
			RAISERROR ('Cannot update room to new venue',18,1)
		
	END
	ELSE
		RAISERROR ('No schedule matching these parameters was found',16,1)
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
