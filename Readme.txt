ABOUT THE PROJECT
The file will have four folders:
•	ClientTicket
•	StaffTicket
•	MailService
•	Screenshot
NOTE – Sometimes you might have to click a Button or Link Button two times (not double click) to launch its “on_click” method. Also I had to replace some Link Button with Button on some places because they were unresponsive , don’t know why, but replacing them with simple Button worked.

Screenshot
This folder contains screenshots of all above working three project. This folder also contains SQL Scripts, to run in Microsoft SQL Server. I had Microsoft SQL Server 2008 R2 on my system.

MailService
It is a Windows Service. This Module is responsible for creating ticket via mail. The service will check every five minutes that it has received an email or not. Based on the subject it will decide to create a new one (insert in ticket master and create an activity of it) or append to an existing one (insert in ticket activity). If the Subject is in the form “Ticket:6 ; This is subject”, then it will extract the Ticket Id from subject using Regular Expression. If it does not find any Ticket ID, then it will create new ticket instead. It will also check whether the email has been blocked or not. It uses IMAPX for reading emails. It also checks for any collaborator in the email and add them ticket collaborator table. The company email id is “helpdeskcts6716@gmail.com” and password is “AP_5@ukH”. For this functionality to work, we have to turn on the “Less Secure App Access” Permission on the email, its already been done.

ClientTicket
It is an ASP.NET Website. This Module is for Client Side. The default page is ClientLogin.aspx, the web config was updated for this. Used ADO.NET and Entity Framework to communicate with Database. The client can do following:
•	Login (Email and Password) – Create a Session 
•	Register (Full Name, Email, Password, Confirm Password, Gender, StreetAddress1, StreetAdddress2, City, State, Country, Zip) – Insert record in Client Table
•	Client Dashboard – View all tickets created on this account (Ticket ID, Email, Subject, Assigned To, Priority, Creation Date) – Populate Grid View with all Tickets from Ticket Master
•	Create Ticket (Category, Subject, Description) – Insert record in ticket master and creating activity of the same.
•	Delete Ticket – Set the IsDeleted to true (or 1). The ticket on delete from user interface does not delete, only the “IsDeleted” bit value is set to true, this is done so that if required the tickets can be inspected in the future. Also create activity on the same.
•	View all activities on a particular ticket – Populate List Views and Labels from ticket master and ticket activity
•	Post Reply – Create an ticket activity of the reply posted
•	Logout – Assign the Session Variable to NULL

StaffTicket
It is an ASP.NET Website. This Module is for Server side or Staff side. The default page is StaffLogin.aspx, the web config was updated for this. Used ADO.NET and Entity Framework to communicate with Database. The Staff can do following:
•	Login (Email and Password) – Create a Session
•	Register (Email, Password and Confirm Password) - Insert record in Staff Table
•	Staff Dashboard – View All Created Tickets where IsDeleted is false (or 0). Populate Grid View with all Tickets from ticket master.
•	Staff Dashboard – View All Created Tickets Assigned to them. Populate Grid View with all Tickets where “assign to” is equal to logged in staff
•	Create Ticket (Full Name, Email, Ticket Source, Category, Subject, Description, and Priority) – Insert record in Ticket Master and also create activity for the same.
•	Block list – View, Add and Delete emails to block list. Insert or Delete from Block list. Populate the grid view with block list table.
•	View all activities on a particular ticket - Populate List Views and Labels from ticket master and ticket activity.
•	Post Reply and send an email about the posted reply to the client - Create a ticket activity of the reply posted and also send email using SMTP, also get collaborator from ticket collaborator table (if any).
•	Add Client to Block list – Insert client’s email to block list table.
•	Delete Ticket - Set the IsDeleted to true (or 1). The ticket on delete from user interface does not delete, only the “IsDeleted” bit value is set to true, this is done so that if required the tickets can be inspected in the future. Also create activity on the same.
•	Assign Ticket to them self – Create an activity for the same and update the ticket master table, “assign to” their staff id.
•	Change the Ticket Status of a Ticket – Update in Ticket Master and create an activity of the same
•	Change Priority of a Ticket – Update in Ticket Master and create an activity of the same
•	Logout - Assign the Session Variable to NULL
