select * from room as r left join schedule as s on r.RoomID = s.RoomID join SqlSatEvent as q on s.EventID=q.EventID

--Imagine that you are a speaker, and want to add the presentation to the event.
--The presentation has to have a name, small description, difficulty level, duration, and tracks - 
--more then one is allowed. This presentation, as you understand, has to be connected to a speaker(s)

USE SQLSaturday
GO
CREATE PROCEDURE addPresentation4 (@fname varchar(255), @lname varchar(255))
AS 
BEGIN
	SET NOCOUNT ON
    BEGIN TRY
	
	IF exists (SELECT ParticipantID from Participant where @fname = FirstName AND @lname = Participant.LastName)
	BEGIN
		DECLARE @participantid int
		SELECT @participantid =  ParticipantID from Participant where @fname = FirstName AND @lname = Participant.LastName
		SELECT @participantid;
	END
	ELSE
	RAISERROR ('Participant not found - check with administrator',16,1)
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




