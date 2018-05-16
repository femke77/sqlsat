--How many presentations did speakers present over the years at the events - not how many total they had, but those that were scheduled and presented.
--Expected result: 
--Speaker Full Name, Event Year, Number of the Presentations

CREATE PROCEDURE lecturerReport (@fname varchar(255), @lname varchar(255))
AS
BEGIN
	SET NOCOUNT ON;

	PRINT 'REPORT SECTION ONE: NUMBER OF LECTURES BY SPEAKER AND YEAR'
	PRINT '=========================================================='
	
	
	select count(*) as 'Number of Lectures Given', p.FirstName, p.LastName, sq.EventDate from Participant as p inner join LecturerLecture 
	as ll on p.ParticipantID = ll.LecturerID inner join Schedule as s on s.LectureID= ll.LectureID inner join SqlSatEvent
    as sq on s.EventID = sq.EventID group by p.FirstName, p.LastName, sq.EventDate




END
