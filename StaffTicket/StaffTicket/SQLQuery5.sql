/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Staff_ID]
      ,[Username]
      ,[Password]
      ,[IsActive]
  FROM [Ticket].[dbo].[Staff]
  ;


  INSERT INTO [Ticket].[dbo].[Staff] values('Admin', 'admin123' ,0);
INSERT INTO [Ticket].[dbo].[Staff] values('PETER', 'peter123' ,0);
INSERT INTO [Ticket].[dbo].[Staff] values('CHRIS', 'chris123' ,0);

delete from [Ticket].[dbo].[Staff] where Staff_ID in (7,8,9);

INSERT INTO TICKET_MASTER values('mayanky@mail.usf.edu', 'Mayank Yadav', '', 
CURRENT_TIMESTAMP, 'Phone', 'Request','Upload Dark Knight','','New',1, '', '',0,0);

INSERT INTO TICKET_MASTER values('mayanky@mail.usf.edu', 'Mayank Yadav', '', 
CURRENT_TIMESTAMP, 'Web', 'Complain','Movie not Playing','','New',2, '', '',0,0);

INSERT INTO TICKET_MASTER values('44', CURRENT_TIMESTAMP, 'Web', 'Request','','New',3, '', '','N');
INSERT INTO TICKET_MASTER values('mayanky@mail.usf.edu', 'Mayank Yadav', '', 
CURRENT_TIMESTAMP, 'Web', 'Request','Add Chris Pratt Movies','','New',3, '', '',0,0);


select * from ticket_master;
select * from staff;

INSERT INTO TICKET_Activity values(4, 'Create', 'Complian about a movie', 'I would like to Complian about a movie - Some movie Name',Current_Timestamp, 0, '0', 0);
INSERT INTO TICKET_Activity values(4, 'Assign', 'Staff has been assigned to your ticket', 'Admin (1) has been assigned to your ticket',Current_Timestamp, 1, '0', 0);
UPDATE TICKET_MASTER SET ASSIGNTO = 1 WHERE TICKETID = 4;
INSERT INTO TICKET_Activity values(4, 'Reply', 'Reply to Complian about a movie', 'It was a our fault. We have taken care of it.',Current_Timestamp, 1, '0', 0);
INSERT INTO TICKET_Activity values(4, 'Priority', 'Priority Changed', 'Your ticket priority has been changed to 2',Current_Timestamp, 1, '0', 0);
UPDATE TICKET_MASTER SET PRIORITY = '2' WHERE TICKETID = '4';
INSERT INTO TICKET_Activity values(4, 'Ticket Status', 'Ticket Status has been changed', 'Ticket has been changed to waiting for customer response',Current_Timestamp, 1, '0', 0);
UPDATE TICKET_MASTER SET TICKETSTATUS = 'Waiting' WHERE TICKETID = '4';

select * from ticket_master;
select * from staff;
INSERT INTO TICKET_Activity values(5, 'Create', 'Movie not Playing', 'I would like to Complain for movie not playing - Brave',Current_Timestamp, 3, '0', 0);
INSERT INTO TICKET_Activity values(5, 'Assign', 'Staff has been assigned to your ticket', 'Peter (3) has been assigned to your ticket',Current_Timestamp, 3, '0', 0);
UPDATE TICKET_MASTER SET ASSIGNTO = '3' WHERE TICKETID = '5';
INSERT INTO TICKET_Activity values(5, 'Reply', 'Reply to Movie Not Playable', 'We have corrected product. You can watch it now.',Current_Timestamp, 3, '0', 0);
INSERT INTO TICKET_Activity values(5, 'Priority', 'Priority Changed', 'Your ticket priority has been changed to 1',Current_Timestamp, 3, '0', 0);
UPDATE TICKET_MASTER SET PRIORITY = '1' WHERE TICKETID = '5';
INSERT INTO TICKET_Activity values(5, 'Ticket Status', 'Ticket Status has been changed', 'Ticket has been changed to waiting for customer response',Current_Timestamp, 3, '0', 0);
UPDATE TICKET_MASTER SET TICKETSTATUS = 'Waiting' WHERE TICKETID = '5';
INSERT INTO TICKET_Activity values(5, 'Customer', 'Customer Replied', 'Thank You',Current_Timestamp, 0, '0', 0);
INSERT INTO TICKET_Activity values(5, 'Ticket Status', 'Ticket Status has been changed', 'Ticket has been changed to Resolved',Current_Timestamp, 3, '0', 0);
UPDATE TICKET_MASTER SET TICKETSTATUS = 'Resolved' WHERE TICKETID = '5';

update ticket_master set AssignTo = null where TicketID=5;
select * from staff;