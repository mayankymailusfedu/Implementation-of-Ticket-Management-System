USE [master]
GO
/****** Object:  Database [Ticket]    Script Date: 4/23/2018 9:44:58 PM ******/
CREATE DATABASE [Ticket] ON  PRIMARY 
( NAME = N'Ticket', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Ticket.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Ticket_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Ticket_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Ticket] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ticket].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ticket] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ticket] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ticket] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ticket] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ticket] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ticket] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ticket] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ticket] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ticket] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ticket] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ticket] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ticket] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ticket] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ticket] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ticket] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Ticket] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ticket] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ticket] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ticket] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ticket] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ticket] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ticket] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ticket] SET RECOVERY FULL 
GO
ALTER DATABASE [Ticket] SET  MULTI_USER 
GO
ALTER DATABASE [Ticket] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ticket] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Ticket', N'ON'
GO
USE [Ticket]
GO
/****** Object:  Table [dbo].[BlockList]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockList](
	[BlockListID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BlockList] PRIMARY KEY CLUSTERED 
(
	[BlockListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Client_ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[Gender] [nvarchar](50) NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[StreetAddress1] [nvarchar](500) NULL,
	[StreetAddress2] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[Country] [nvarchar](500) NULL,
	[Zip] [nvarchar](50) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Client_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[Staff_ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](500) NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[Staff_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ticket_Activity]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket_Activity](
	[ActivityID] [int] IDENTITY(1,1) NOT NULL,
	[TicketID] [int] NOT NULL,
	[ActivityType] [nvarchar](100) NOT NULL,
	[Summary] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ActivityDate] [datetime] NOT NULL,
	[ActedBy] [int] NULL,
	[ActorName] [nvarchar](500) NULL,
	[Unread] [bit] NULL,
 CONSTRAINT [PK_Ticket_Activity] PRIMARY KEY CLUSTERED 
(
	[ActivityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ticket_Collaborator]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket_Collaborator](
	[CollaboratorID] [int] IDENTITY(1,1) NOT NULL,
	[TicketID] [int] NOT NULL,
	[Email] [nvarchar](500) NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[FieldType] [nvarchar](50) NULL,
 CONSTRAINT [PK_Ticket_Collaborator] PRIMARY KEY CLUSTERED 
(
	[CollaboratorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ticket_Master]    Script Date: 4/23/2018 9:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket_Master](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](500) NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
	[TicketSource] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](50) NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[AssignTo] [int] NULL,
	[TicketStatus] [nvarchar](50) NOT NULL,
	[Priority] [tinyint] NULL,
	[ClosedBy] [int] NULL,
	[ClosedDate] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[AcknowledgementSent] [bit] NOT NULL,
 CONSTRAINT [PK_Table_Master] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[BlockList] ON 

INSERT [dbo].[BlockList] ([BlockListID], [Email]) VALUES (7, N'abc@abc.com')
INSERT [dbo].[BlockList] ([BlockListID], [Email]) VALUES (11, N'Andy from Google <andy-noreply@google.com>')
SET IDENTITY_INSERT [dbo].[BlockList] OFF
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([Client_ID], [FullName], [Gender], [Email], [Password], [StreetAddress1], [StreetAddress2], [City], [State], [Country], [Zip]) VALUES (1, N'Mayank Yadav', N'Male', N'mayanky@mail.usf.edu', N'mayank123', N'10868', N'North Campus Mail Center', N'Tampa', N'Florida', N'United States', N'33620')
INSERT [dbo].[Client] ([Client_ID], [FullName], [Gender], [Email], [Password], [StreetAddress1], [StreetAddress2], [City], [State], [Country], [Zip]) VALUES (2, N'Tony', N'Male', N'tony@stark.com', N'tony123', N'10868', N'North Campus Mail Center', N'Tampa', N'Florida', N'United States', N'33620')
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([Staff_ID], [Username], [Password], [IsActive]) VALUES (1, N'Admin', N'admin123', 0)
INSERT [dbo].[Staff] ([Staff_ID], [Username], [Password], [IsActive]) VALUES (3, N'PETER', N'peter123', 0)
INSERT [dbo].[Staff] ([Staff_ID], [Username], [Password], [IsActive]) VALUES (4, N'CHRIS', N'chris123', 0)
INSERT [dbo].[Staff] ([Staff_ID], [Username], [Password], [IsActive]) VALUES (10, N'test', N'test123', 0)
INSERT [dbo].[Staff] ([Staff_ID], [Username], [Password], [IsActive]) VALUES (11, N'test123', N'test123', 0)
SET IDENTITY_INSERT [dbo].[Staff] OFF
SET IDENTITY_INSERT [dbo].[Ticket_Activity] ON 

INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (1, 1, N'Created', N'Access for less secure apps has been turned on', N'<html lang=en><head><meta content="date=no" name="format-detection"><meta content="email=no" name="format-detection"><style>.awl a {color: #FFFFFF; text-decoration: none;}.abml a {color: #000000; font-family: Roboto-Medium,Helvetica,Arial,sans-serif; font-weight: bold; text-decoration: none;}.adgl a {color: rgba(0, 0, 0, 0.87); text-decoration: none;}.afal a {color: #b0b0b0; text-decoration: none;}@media screen and (min-width: 600px) {.v2sp {padding: 6px 30px 0px;} .v2rsp {padding: 0px 10px;}}</style></head><body bgcolor="#FFFFFF" style="margin: 0; padding: 0;"><table border=0 cellpadding=0 cellspacing=0 height="100%" style="min-width: 348px;" width="100%"><Tbody><tr height=32px></tr><tr align=center><td width=32px></td><td><table border=0 cellpadding=0 cellspacing=0 style="max-width: 600px;"><Tbody><tr><td><table border=0 cellpadding=0 cellspacing=0 width="100%"><Tbody><tr><td align=left><img height=32 src="https://www.gstatic.com/accountalerts/email/googlelogo_color_188x64dp.png" style="display: block; width: 92px; height: 32px;" width=92></td><td align=right><img height=32 src="https://www.gstatic.com/accountalerts/email/shield.png" style="display: block; width: 32px; height: 32px;" width=32></td></tr></Tbody></table></td></tr><tr height=16></tr><tr><td><table bgcolor="#D94235" border=0 cellpadding=0 cellspacing=0 style="min-width: 332px; max-width: 600px; border: 1px solid #F0F0F0; border-bottom: 0; border-top-left-radius: 3px; border-top-right-radius: 3px;" width="100%"><Tbody><tr><td colspan=3 height=72px></td></tr><tr><td width=32px></td><td style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 24px; color: #FFFFFF; line-height: 1.25; min-width: 300px;">Access for less secure apps has been turned on</td><td width=32px></td></tr><tr><td colspan=3 height=18px></td></tr></Tbody></table></td></tr><tr><td><table bgcolor="#FAFAFA" border=0 cellpadding=0 cellspacing=0 style="min-width: 332px; max-width: 600px; border: 1px solid #F0F0F0; border-bottom: 1px solid #C0C0C0; border-top: 0; border-bottom-left-radius: 3px; border-bottom-right-radius: 3px;" width="100%"><Tbody><tr height=16px><td rowspan=3 width=32px></td><td></td><td rowspan=3 width=32px></td></tr><tr><td><table border=0 cellpadding=0 cellspacing=0 style="min-width: 300px;"><Tbody><tr><td style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 13px; color: #202020; line-height: 1.5;padding-bottom: 4px;">Hi Mayank,</td></tr><tr><td style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 13px; color: #202020; line-height: 1.5;padding: 4px 0;">You recently changed your security settings so that your Google Account <a>helpdeskcts6716@gmail.com</a> is no longer protected by modern security standards.<br><br>Please be aware that it is now easier for an attacker to break into your account. You can make your account safer again by undoing this change <a href="https://myaccount.google.com/lesssecureapps" style="text-decoration: none; color: #4285F4;" target="_blank">here</a>, then switching to apps made by Google such as Gmail to access your account.<br><br><b>Don&#39;t recognize this activity?</b><br>Review your <a data-meta-key="review-devices" href="https://accounts.google.com/AccountChooser?Email=helpdeskcts6716@gmail.com&amp;continue=https://myaccount.google.com/device-activity?rfn%3D28%26rfnc%3D1%26eid%3D7010760341004592899%26et%3D0%26asae%3D2" style="text-decoration: none; color: #4285F4;" target="_blank">recently used devices</a> now.</td></tr><tr><td style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 13px; color: #202020; line-height: 1.5; padding-top: 28px;">The Google Accounts team</td></tr><tr height=16px></tr><tr><td><table style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 12px; color: #B9B9B9; line-height: 1.5;"><Tbody><tr><td>This email can''t receive replies. For more information, visit the <a data-meta-key=help href="https://support.google.com/accounts/answer/6010255" style="text-decoration: none; color: #4285F4;" target="_blank">Google Accounts Help Center</a>.</td></tr></Tbody></table></td></tr></Tbody></table></td></tr><tr height=32px></tr></Tbody></table></td></tr><tr height=16></tr><tr><td style="max-width: 600px; font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 10px; color: #BCBCBC; line-height: 1.5;"></td></tr><tr><td><table style="font-family: Roboto-Regular,Helvetica,Arial,sans-serif; font-size: 10px; color: #666666; line-height: 18px; padding-bottom: 10px"><Tbody><tr><td>You received this mandatory email service announcement to update you about important changes to your Google product or account.</td></tr><tr height=6px></tr><tr><td><div style="direction: ltr; text-align: left">&copy; 2018 Google Inc., 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA</div><div style="display: none !important; mso-hide:all; max-height:0px; max-width:0px;">et:28</div></td></tr></Tbody></table></td></tr></Tbody></table></td><td width=32px></td></tr><tr height=32px></tr></Tbody></table><img height=1 src="https://notifications.googleapis.com/email/a.gif?t=AFG8qyWRJNJkg_52K6M0_ezXZ7epujVRPlsINiKvVkwXDgHAhckiCXnZdHwwS81iRswENO2ZaX-IY6QRRDDZd5dC7iv8ZaYxgaiaJOf805vAOXXWwahvzKEv3vKP24FcxXQ6WaGYDq0470mJvLWb1w5u10KBqP7R4QyqvYkyyi58vfodp4QYVqqB7wJl6_uK7ybjUX3qKV9Y4bMSG_7BwHlyRP1oxdpCERzjVVVgTuzAH3UIlvurzeltL7AQ38Qt4psjPSIv0eNcbcr2CTY" width=1></body></html>
', CAST(N'2018-03-26T23:08:28.380' AS DateTime), NULL, N'End User', 1)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (2, 2, N'Created', N'Mayank, welcome to your new Google Account', N'<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="viewport" content="target-densitydpi=device-dpi"/> -->
    <title>Get more from your new Google Account</title>
</head>
<body style="padding: 0; margin: 0;">
    <style>
@media screen{@font-face{font-family:''Open Sans'';font-style:normal;font-weight:300;src:local(''Open Sans Light''),local(''OpenSans-Light''),url(http://fonts.gstatic.com/s/opensans/v9/DXI1ORHCpsQm3Vp6mXoaTRampu5_7CjHW5spxoeN3Vs.woff2) format(''woff2''),url(http://fonts.gstatic.com/s/opensans/v9/DXI1ORHCpsQm3Vp6mXoaTaRDOzjiPcYnFooOUGCOsRk.woff) format(''woff'')}}body{padding:0;margin:0}@media only screen and (max-width:520px){-webkit-text-size-adjust:100%}
</style>
<center>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="520" bgcolor="#ffffff" style="background: #ffffff; max-width: 520px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; -ms-text-size-adjust: 100%;">
  <tr>
    <td width="20" bgcolor="#eeeeee" style="background: #eeeeee;"></td>
		<td width="480" style="-webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; -ms-text-size-adjust: 100%;">
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
				<tr>
					<td height="20" bgcolor="#eeeeee" style="background: #eeeeee;"></td>
				</tr>
				<tr>
					<td>
  				 <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="border-bottom: 1px solid #eeeeee;">
            <tr>
    			    <td height="49"></td>
             </tr>
             <tr>
      		    <td align="center" class="whom" style=''color:#4285f4; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:32px; font-weight:300; line-height:46px; margin:0; padding:0 25px 0 25px; text-align:center''>Hi Mayank,</td>
             </tr>
             <!--[if !mso]><!-- -->
              <tr>
        	      <td height="20"></td>
              </tr>
            <!--<![endif]-->
            
            <!--[if mso]>
              <tr>
                <td height="7">&nbsp;</td>
              </tr>
            <![endif]-->
            <tr>
      		    <td align="center" class="parasec" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''> I’m so glad you decided to try out Gmail.  Here are a few tips to get you up and running fast.</td>
             </tr>
             <tr>
      		    <td height="30">

</td>
             </tr>
             
  				 </table>
					</td>
				</tr>
        
        
        <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="border-bottom: 1px solid #eeeeee;">
            <tr>
        	    <td height="32"></td>
             </tr>
             <tr>
      		    <td align="center">
              <a href="https://www.google.com/appserve/mkt/p/AFIPhzVutKaeqXzdXI7uc1ge2Q7Vdw6cf8heJfas60ytKQ0yAZIKPgxLknlDSI4IXAWQ1IRAx1pA8IwBGnx6dhkALQv76JKUUGc2Y601Ws00VwuLY7FS1JaeK81TpAKWP8t2b1WSUvUQ8ZRUte4q4zFYLhVjqgHRoHasPdcLtpN71c7K0-Q8_BO_ddRYDBfr-B2-qgc8WhtwDwg3JQum8UwsCA9QYbu-7F6R9gg" target="_blank" style="color:#4285f4; text-decoration:underline">
             <img width="64" border="0" src="https://www.gstatic.com/images/branding/product/2x/assistant_48dp.png" alt="Google Assistant" style="width: 64px; text-align: center; border: none;">
             </a> 
              </td>
             </tr>
             <tr>
      		    <td height="15"></td>
             </tr>
             <tr>
      		    <td align="center" class="paraheading" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:24px; font-weight:300; line-height:33px; margin:0; padding:0 25px 0 25px; text-align:center''>Make Google do it</td>
             </tr>
             <tr>
      		    <td height="4" style="line-height: 4px; font-size: 4px;"></td>
             </tr>
             <tr>
               <td align="center" class="para" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''>The Google Assistant is an easier way to get things done on your new phone</td>
             </tr>
                          
<tr>
                                 <td height="20"></td>
                              </tr>
<tr>
                                 <td align="center" class="para" style="color:#757575; font-family:&quot;Roboto&quot;, OpenSans, &quot;Open Sans&quot;, Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center">
                                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzW3UQAwTK2TXVNcrbnByHBqEGGKdjV9wXnCIKLUgHYmXgwkbJNVexZUpErsFC5hOX5PdXin2PPYG4LUyr_1Y39KmjsUmOuihC_Z-cXf_KFrtZGgvRe-4A9Ly9NIsZSirUJu0pMuCIuOjQsMy-3yHbL3Q5UmUn-2QPGalfpXacIGmoiGmggu342KLrA6jsteNzl7dmrYGQ1RGALEPLxYHzjDivASb1lpHcSDrQ" target="_blank" style="color:#4285f4; text-decoration:underline">TRY IT</a>
                                 </td>
                              </tr>
             <tr>
        	    <td height="30"></td>
             </tr>
           </table>
          </td>
        </tr>

 <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="border-bottom: 1px solid #eeeeee;">
            <tr>
      		    <td height="32"></td>
             </tr>
             <tr>
      		    <td align="center">
              <a href="https://www.google.com/appserve/mkt/p/AFIPhzV0YBb9gKLNeaA_57k4TSq4VgKFeT9bZCA0YjMM4d88bIxVH-q0P5AlOumEaa4CwqGhKc3K-B4z7kqjbN-BdH6MejPyHZ4MPvSNHgdJbrPo4XlaLrzI7N_Are1rGPXRGX8PJ2ZFNRqSVKStqQcdxOLKfiDBwfc5EO-NKbsU2qQr5PU" target="_blank" style="color:#4285f4; text-decoration:underline">
              <img width="64" border="0" src="https://services.google.com/fh/files/emails/owe_gmail_128dp.png" alt="Gmail" style="width: 64px; text-align: center; border: none;">
              </a>
              </td>
             </tr>
             <tr>
      		    <td height="15"></td>
             </tr>
             <tr>
      		    <td align="center" class="paraheading" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:24px; font-weight:300; line-height:33px; margin:0; padding:0 25px 0 25px; text-align:center''>Gmail on the go</td>
             </tr>
             <tr>
      		    <td height="4" style="line-height: 4px; font-size: 4px;"></td>
             </tr>
             <tr>
               <td align="center" class="para" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''> With Gmail for <a href="https://www.google.com/appserve/mkt/p/AFIPhzV_17ir1k-M8IsmvuubnilkhBVKWw81u4beT631ojUp4z0JiB_l30nw8BAo7-eEG5-T1pLoh8Lu-YfqKeiPG_xOzfK2qyl4VUK9sJuQU11BCaJAp8XpAPuUd9EocFop5K7VyFZpoumhDR6xqSzP4NO0KmaC0CJco4qtbviJPHQdc7BUlI6fZdQULNo_6hOFIlSpxPp-B2v9nd7rVkkQjXY_-Yiu" target="_blank" style="color:#4285f4; text-decoration:underline">Android</a> and <a href="https://www.google.com/appserve/mkt/p/AFIPhzWAe_hSIe2IVVBpKefuAu85xasFPaCQ6maRj04p0XunLf0jC31ogKlKmqNw4-EeC9pnW4V0a1HapHYTEY89Djhrg7PfnAcru7UwhvTyX6gKPas8YLLz9-mcZSa25TxIMOyDNyG8m4hyTfBOTdN9yGeBvxiOmKeHjEImbstq_o3MeNUoi9w" target="_blank" style="color:#4285f4; text-decoration:underline">iOS</a>, you get real-time notifications so you don''t miss important emails.</td>
             </tr>
             <tr>
        	    <td height="30"></td>
             </tr>
           </table>
          </td>
        </tr>


         <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="border-bottom: 1px solid #eeeeee;">
            <tr>
              <td height="32"></td>
             </tr>
             <tr>
      		    <td align="center">
              <a href="https://www.google.com/appserve/mkt/p/AFIPhzUeN8NHRPcm5mtt3-ElotHqO1kZcBqM3KDvQ5Z48XvxiZ-9CrJ55-neyadHtncZrfTuO59Hacn-VUMmq2GI-wM5vZWa3aj6kMUyMLt_wjvVfrhP4tWfXMDRX01RhEc6NHbqz8XNIiKJMCLm4TREmTbkFwYK3ttd3stLv1XxMQ" target="_blank" style="color:#4285f4; text-decoration:underline">
             <img width="60" height="77" src="https://services.google.com/fh/files/emails/shield_logo_150_rt.png" alt="Trust shield" border="0" style="width: 60px; height: 77px; text-align: center; border: none;">
              </a>
              </td>
              
             </tr>
             <tr>
      		    <td height="15"></td>
             </tr>
             <tr>
      		    <td align="center" class="paraheading" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:24px; font-weight:300; line-height:33px; margin:0; padding:0 25px 0 25px; text-align:center''>You’re in control</td>
             </tr>
             <tr>
      		    <td height="4" style="line-height: 4px; font-size: 4px;"></td>
             </tr>
             <tr>
               <td align="center" class="para1" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 20px 0 20px; text-align:center''>Choose what’s right for you. You can review and adjust your privacy and security settings any time at <a href="https://www.google.com/appserve/mkt/p/AFIPhzW3RA4Y1YC-teLbs-hf8nnmgd5A542zgNTb29on5Qb5mK1MHsZ4sGnEtkUzhLZiJgcphYXaxEDl-wvISjI8hqWtfb5y3HFB3-YaO-Q3Ky-1bk5lNOPUM852ntltYJTFrzEJte3TIgFg9ca_rL_1A1OHWGIs29DKs1PEnb2oQVLY9t4" target="_blank" style="color:#4285f4; text-decoration:underline">My Account</a>.</td>
             </tr>
             <tr>
        	    <td height="30"></td>
             </tr>
           </table>
          </td>
        </tr>


       
        <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
            <tr>
              <td height="27"></td>
             </tr>
             <tr>
        	    <td align="center" class="parasec" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''>Replies to this email aren’t monitored, but if you have a question try the <a href="https://www.google.com/appserve/mkt/p/AFIPhzWpzSY0vNVyEgKm7CzGrA_dxAlux9rzDOORsQ_MPKK6ppiW_tE431D7AD8xJHjaTfCg0-do3Meim9Bh4qN9csFgunksM3gTS7e95-5Ms2seTbSTp4jKo1wV0WcD4Q-kQ66jdeVe78Mn_3JFHRBkPwPwKmctvN9PfHg" target="_blank" style="text-decoration:underline; color: #4285f4;">Help Center</a> or post it to the <a href="https://www.google.com/appserve/mkt/p/AFIPhzXL2uOdyIbG5J0LhLWaiKadn8RENzSau6OR6sUnxM4NkSGMmWlTMxOZOT4w8P3WBRA1AaqFn6awkyY2NfPgnNrM89OUVhW2o-sK0SjwDv-gHwZl_A39X9mvp92PpeuazFN8xWLan8ipP9uL2PLGYJwedCKjw8xDdPdaxm7QEbAcfHQ9JmAFvElW0AZ_JvLBLSM" target="_blank" style="color:#4285f4; text-decoration:underline; white-space: nowrap!important;">Gmail Help Forum</a> where my team and other expert users answer questions.

</td>
             </tr>
             <tr>
      		    <td height="25"></td>
             </tr>
             <tr>
      		    <td align="center" class="parasec" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''>Enjoy your new account,</td>
             </tr>
             
             <tr>
        	    <td align="center" style="padding-top:13px; padding-bottom:8px;">
              <img border="0" src="https://services.google.com/fh/files/emails/andy.png" alt="Andy" style="text-align: center; border: none;" width="75" height="45">
                            </td>
             </tr>
             
             
             
             
             <tr>
               <td align="center" class="parasec" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''>
               Gmail Community Manager
                </td>
             </tr>
             <tr>
              <td height="35"></td>
             </tr>
             <tr>
               <td align="center" class="para" style=''color:#757575; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:17px; font-weight:300; line-height:24px; margin:0; padding:0 25px 0 25px; text-align:center''> Keep in touch: <a href="https://www.google.com/appserve/mkt/p/AFIPhzU4AlDd0Rhsn-sTZ9PLBv7LyQABjSHLN2e-XYlsKCvAHIPYWYBwIJa2_UP-0H4XoUxDD2y22_eSMTkWRr-9iuJaaHJe2MwpBGAnp7X3t-qR93L45Yo9ILP7URzq1hU9mWjs7IadNdIMCtkO9lYMBgHOpInqAJjjIFH3fcwT-vL6" target="_blank" style="color:#4285f4; text-decoration:underline">Twitter</a>, <a href="https://www.google.com/appserve/mkt/p/AFIPhzUgCa01PC1BMgFZw4TiIkjS-S3mrJhzuRulcPs2B3jl_e240Pt8SAJAdjZ7msk1oSDdQncJj38GAZeMfZrIq1yqAxvEW28zyVTi2WVY4rL4eukIFB4g_EbK40CKcoDvORY4InWbQleY-B9tsmDOCgFNQetwla_LejakGPU" target="_blank" style="color:#4285f4; text-decoration:underline">Facebook</a>, <a href="https://www.google.com/appserve/mkt/p/AFIPhzVG8YUc-kmRsgRxqCDnmxUmkUydOmd8zJeNL-cxMhptkeDxxl3QDjxy3B_2XRdKAcmR9A7MvPBT8-K0Qn5CLmZ36b1I0lutuxOUXcIsWxUQk-_MrK-EkIWTlmdHcuvRIwnS8RwV8vLGxsUKrVjkiVdK-vYpFRK7sih4woOyYBg" target="_blank" style="color:#4285f4; text-decoration:underline">Google+</a> </td>
             </tr>
             <tr>
              <td height="27"></td>
             </tr>
              <tr>
              <td>
                 <table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td colspan="3" align="center" style="text-align: center; font-family: ''Roboto'',OpenSans,''Open Sans'',Arial,sans-serif; font-size: 17px; line-height: 24px; font-weight: 300; color: #757575;">Get Gmail on the go.
</td>
</tr>
<tr>
<td colspan="3" style="height:10px">
</td>
</tr>
<tr>
<td style="text-align:right; line-height:10px;" width="229">
<a href="https://www.google.com/appserve/mkt/p/AFIPhzXiRgf1krX_0WMabcVGWMmHk7AlrDhRDtOjNRGTe1mpodrNFATuEe5uHtjqEL4dipPmaj_EZJVALDliFdAENaQt89L4W1M_6w-3dQYLV1eKj7fqkxuPulJyLsgJAYaWCdooQbnz9gG81fFwtHuEwoROQYYYYBc0hiJv1_IBZ6P8bjyF1QH0NZGiS2JKfr2-QeFOWDubQr4rpEVarjc-QyG1Qty-FA" target="_blank" style="color:#4285f4; text-decoration:underline"><img src="https://services.google.com/fh/files/emails/en_generic_rgb_wo_60.png" alt="Google Play" width="162" height="48" style="max-width: none; height: 48px; width:162px; outline: none; display: block; -ms-interpolation-mode: bicubic; border-top-width: 0; border-right-width: 0; border-bottom-width: 0; border-left-width: 0;" align="right"></a>
</td>
<td width="21" height="48" style="width:21px;height:48px"> 
</td>
<td style="text-align:left; line-height:10px;" width="230">
<a href="https://www.google.com/appserve/mkt/p/AFIPhzVgpuhGK79cL3RoCEatv44YHznZS929hQ3b0CHyr0rpYKphvs2xOIEj4fJtVGAVTx2bn8ojn3R9ievVLbONkCckUCko9n55yTk2GOuadrQP1JfM5606wpszZclXpg5_JR_ins7n35CEdEpXorZuXuL7_wrkMWvQ_6xfGRCASCQCKTQUZ2FS" target="_blank" style="color:#4285f4; text-decoration:underline"><img src="https://services.google.com/fh/files/emails/one_wel_email_itunes_icon.png" alt="App Store" width="162" height="48" style="max-width: none; width:162; height: 48px; outline: none; display: block; -ms-interpolation-mode: bicubic; border-top-width: 0; border-right-width: 0; border-bottom-width: 0; border-left-width: 0;" align="left"></a>
</td>

</tr>
</table>
              </td>

             </tr>


             
             <tr>
              <td height="36"></td>

             </tr>
             
             
             
             
             
             <tr>
               <td align="center">
               <a href="https://www.google.com/appserve/mkt/p/AFIPhzV5gb7Alc1ixd2qBi0sleTK8La9lr_jK0iAbmMafLqLabXWlHyzl1veZL3gKevhHpdzBrBTYXaIQmbW6d97wZv6vAc6aT2RF8OyWCWPSdGLHkJIhkL6Jypa7r5s6eoU5OXBbPaSVmJD9gpgeBMinDnKlZUtJXgQyKw" target="_blank" style="color:#4285f4; text-decoration:underline">
               <img width="134" height="46" border="0" src="https://services.google.com/fh/files/emails/google_log_new.png" alt="Google" style="width: 134px; height: 46px; text-align: center; border: none;">
               </a>
               </td>
             </tr>
             <tr>
              <td height="31"></td>
             </tr>
             <tr>
              <td align="center">
                <table border="0" cellspacing="0" cellpadding="0" align="center" width="405" class="strip" style="padding-left:10px;padding-right:10px;"> 
                  <tr>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                      <a href="https://www.google.com/appserve/mkt/p/AFIPhzX7CjuiWaiyhFsndsKNLGF2-yD6gILu3ydy4ZL5ztfmDsiIjwc7U0BSFQZam2IT1LhMyFa2FVjx4gksEWkaWNJVmuJo7vbt3QL8zEHi7j0qmy_WZiYMfjwgx2z9PryokGB8nEkLM8xPYjE7F1-ELAlJ4TsOpbnIjHk" target="_blank" style="color:#4285f4; text-decoration:underline">
                        <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_googleg_32dp.png" alt="Google Search" style="width: 32px; text-align: center; border: none;">
                      </a>
                    </td>
                    
                    <td width="20" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzWmsqUaeorEAonx6-8-oXcgBL766CPe7O7ZsUuP7IRNNR7hlNYfvwY1UCbzm6wccdgCPibKDGeqVCoY0SR0vmKAjNwtkeH8VYtu6zzUNaxgSnwmgjBKDrQn9P6CE-aRGu873zVqHZewUvr0ggOukxVGH_O2qmx0lwPXncdcsyx8oWJj" target="_blank" style="color:#4285f4; text-decoration:underline">
                    <img src="https://services.google.com/fh/files/emails/owe-new_gmail_32dp.png" width="32" alt="Gmail">
                      </a>
                    </td>
                    
                    <td width="18" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzUzpXRtqu395gKGWipfxvCMsAkNX04UiNgOkQPRk6zSLlyoQGKcsAkaVGoSpuDATsTbFIqEl4PQswiyPL4NDcfEOtLomyRf4ZIjsxtqckuCHsST83hXCJYu_p0CvLL_BnIYHNBoV9LQHeRyzppeLLYyu76IY4H4GFiM4Ts" target="_blank" style="color:#4285f4; text-decoration:underline">
                    <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_maps_32dp.png" alt="Maps" style="width: 32px; text-align: center; border: none;">
                      </a>
                    </td>
                    
                    
                    <td width="20" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzVOTH6KuIFw6sOSQE2PsDRrGHA954JYH3tzesysmkgK5PBHiLJWs1h0kwkIIcdwXdjLvpO09ODBM6N8G48wQhC4jI1gV02sukDHQxlsvla1t1Gd7I1VY9E0ssPQx2A0bpvBVCHCcXwxqRnmipww5SFhWEp__wI" target="_blank" style="color:#4285f4; text-decoration:underline">
                    <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_youtube_32dp.png" alt="YouTube" style="width: 32px; text-align: center; border: none; -ms-interpolation-mode: bicubic;">
                      </a>
                    </td>
                    
                    <td width="22" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzWla9zAWOkZ4D9f61KIBmyZ46OLdLXOqgr_ryJX7Joe4CYFE9C3cw8ySmUsKEWUn3OeIib7LPht84I7iS5LGWCCiL0y_tKLBLgHG5_ED4B0UVc1SLS9Q3qxz07H3RATNI7IsTceRLKlvCgTWi5d8Hzo_yBvaJvmHU04" target="_blank" style="color:#4285f4; text-decoration:underline">
                    <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_drive_32dp.png" alt="Drive" style="width: 32px; text-align: center; border: none;">
                      </a>
                    </td>
                    
                    <td width="17" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                    <a href="https://www.google.com/appserve/mkt/p/AFIPhzWFNnOBCw2rUcqZifjGMr6_NN51u02M26EWfwpc-5Kf_yLyQXM9iR0Ywc4MQc0qqotdVu7kMMUhtqeOJmDsf9ddSkRRAhuLVI04JfMJv970JxLE2IK6mErbbA1kF8bftC4WBBCwKI36aEiN-kcZo7Vo41N7A8moLhh-kYQ" target="_blank" style="color:#4285f4; text-decoration:underline">
                      <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_photos_32dp.png" alt="Photos" style="width: 32px; text-align: center; border: none;"> 
                    </a>
                    </td> 
                    
                    <td width="16" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                      <a href="https://www.google.com/appserve/mkt/p/AFIPhzUfXJVpsca6Biu_KuAIksMxz5b1QrKcSQ9hi4FgQlTFrmN1VaN7FMtX09bTzHz3awsGv7dO9nuxFyeYWWtAG2b32vOGGDWikF8pIfGL81Ha5na3jvD7eSYt3NS1FYSZ1ffyRlnuPqf7MlsTaTno9MoyboIZsytkkpRg7orh" target="_blank" style="color:#4285f4; text-decoration:underline">
                        <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_play_32dp.png" alt="Play" style="width: 32px; text-align: center; border: none;"> 
                      </a>
                    </td>                    
                    <td width="18" style="margin:0; padding:0"></td>
                    <td width="32" class="prod-icon" style="margin:0; padding:0 0 0 0">
                      <a href="https://www.google.com/appserve/mkt/p/AFIPhzW8hF3ILRvIeAhOKOU1IB7Wfji9-gySH5DthJsLTlda7wbH1dj0KS-jOXFvBXTGs_fxQXWpGCCauKHee7VweszQUaui9S4tiaJ0HnBg70TtFtcBnNjpr4NT2b7AY2XITlHL65Idmr0taccnyVap1LNLV_yYMbU_mMOZVqGeb10v" target="_blank" style="color:#4285f4; text-decoration:underline">
                       <img width="32" border="0" src="https://services.google.com/fh/files/emails/owe_chrome_32dp.png" alt="Chrome" style="width: 32px; text-align: center; border: none;">
                      </a>
                    </td>
                  </tr>
                </table>
              </td>
             </tr>
             <tr>
  				<td height="28"></td>
				</tr>
        <tr>
          <td height="19" bgcolor="#eeeeee" style="background: #eeeeee;"></td>
          </tr>
             <tr>
             <td class="footer" valign="middle" style=''background:#eee; color:#777; font-family:"Roboto", OpenSans, "Open Sans", Arial, sans-serif; font-size:10px; font-weight:300; line-height:14px; margin:0; padding:0 6px 0 6px; text-align:center'' align="center">
                © 2018 Google LLC 1600 Amphitheatre Parkway, Mountain View, CA 94043<br>This email was sent to you because you created a Google Account.
            </td>
             </tr>
           </table>
          </td>
        </tr>
        
				<tr>
					<td height="18" bgcolor="#eeeeee" style="background: #eeeeee;"></td>
				</tr>
			</table>
		</td>
		<td width="20" bgcolor="#eeeeee" style="background: #eeeeee;"></td>
	</tr>
</table>
<div style="display:none; white-space:nowrap; font:15px courier; line-height:0;">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
</center>
<img height="1" src="https://www.google.com/appserve/mkt/img/AFIPhzVvxclQkOBC-OTK25UyOhMd4o51rYTuHGR1fQCBw3VN9w.gif" width="3">
</body>
</html>
', CAST(N'2018-03-26T23:08:29.197' AS DateTime), NULL, N'End User', 1)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (3, 4, N'Create', N'Complian about a movie', N'I would like to Complian about a movie - Some movie Name', CAST(N'2018-04-21T18:39:15.237' AS DateTime), 0, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (4, 4, N'Assign', N'Staff has been assigned to your ticket', N'Admin (1) has been assigned to your ticket', CAST(N'2018-04-21T18:40:25.720' AS DateTime), 1, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (5, 4, N'Reply', N'Reply to Complian about a movie', N'It was a our fault. We have taken care of it.', CAST(N'2018-04-21T18:43:26.903' AS DateTime), 1, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (6, 4, N'Priority', N'Priority Changed', N'Your ticket priority has been changed to 2', CAST(N'2018-04-21T18:44:44.150' AS DateTime), 1, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (7, 4, N'Ticket Status', N'Ticket Status has been changed', N'Ticket has been changed to waiting for customer response', CAST(N'2018-04-21T18:46:01.593' AS DateTime), 1, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (8, 5, N'Create', N'Movie not Playing', N'I would like to Complain for movie not playing - Brave', CAST(N'2018-04-21T18:49:43.513' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (9, 5, N'Assign', N'Staff has been assigned to your ticket', N'Peter (3) has been assigned to your ticket', CAST(N'2018-04-21T18:50:39.897' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (10, 5, N'Reply', N'Reply to Movie Not Playable', N'We have corrected product. You can watch it now.', CAST(N'2018-04-21T18:53:38.440' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (11, 5, N'Priority', N'Priority Changed', N'Your ticket priority has been changed to 1', CAST(N'2018-04-21T18:54:18.360' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (12, 5, N'Ticket Status', N'Ticket Status has been changed', N'Ticket has been changed to waiting for customer response', CAST(N'2018-04-21T18:55:15.690' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (13, 5, N'Customer', N'Customer Replied', N'Thank You', CAST(N'2018-04-21T18:56:04.697' AS DateTime), 0, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (14, 5, N'Ticket Status', N'Ticket Status has been changed', N'Ticket has been changed to Resolved', CAST(N'2018-04-21T18:56:35.717' AS DateTime), 3, N'0', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (15, 7, N'Create', N'fjvbjfv', N'jdbvjdbjvd', CAST(N'2018-04-22T17:40:37.837' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (16, 8, N'Create', N'lc vldf mv', N' ckv kcmvlcmvlmx;', CAST(N'2018-04-22T17:45:17.547' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (18, 2, N'Assigned To', N'Ticket Assigned To Staff', N'Your ticket has been assigned to Admin (1)', CAST(N'2018-04-22T21:07:18.483' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (19, 2, N'Deleted', N'Ticket has been Deleted', N'Your ticket has been Deleted Admin (1)', CAST(N'2018-04-22T21:20:52.807' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (20, 2, N'Deleted', N'Ticket has been Deleted', N'Your ticket has been Deleted Admin (1)', CAST(N'2018-04-22T21:24:40.007' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (21, 7, N'Ticket Status', N'Ticket Status has been chnaged', N'Your ticket status has been changed to 5 by Admin (1)', CAST(N'2018-04-22T22:12:11.337' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (22, 7, N'Priority', N'Priority Changed', N'Your ticket priority has been chnages to 5 by Admin (1)', CAST(N'2018-04-22T22:15:27.427' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (23, 7, N'Post Reply', N'Reply posted by Staff', N'Hello,

Post from staff', CAST(N'2018-04-22T22:17:57.610' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (24, 6, N'Post Reply', N'Reply posted by Staff', N'Hey,

Post from Staff', CAST(N'2018-04-22T22:38:02.683' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (25, 6, N'Post Reply', N'Reply posted by Staff', N'Hey,

Mail', CAST(N'2018-04-22T22:39:14.873' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (26, 6, N'Post Reply', N'Reply posted by Staff', N'Hey, 

Mail, mail', CAST(N'2018-04-22T22:41:40.650' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (27, 6, N'Post Reply', N'Reply posted by Staff', N'Hey,

Mail Test3', CAST(N'2018-04-22T22:45:06.037' AS DateTime), 1, N'Admin', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (28, 9, N'Create', N'Black Ops 2', N'Please upload black ops 3', CAST(N'2018-04-23T21:20:39.577' AS DateTime), 1, N'End User', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (29, 9, N'Post Reply', N'Reply posted by Staff', N'Hey,

How r you.

Ticket Status??', CAST(N'2018-04-23T21:39:11.347' AS DateTime), 1, N'End User', 0)
INSERT [dbo].[Ticket_Activity] ([ActivityID], [TicketID], [ActivityType], [Summary], [Description], [ActivityDate], [ActedBy], [ActorName], [Unread]) VALUES (30, 9, N'Deleted', N'Ticket has been Deleted', N'Your ticket has been Deleted by the end usermayanky@mail.usf.edu (1)', CAST(N'2018-04-23T21:40:56.883' AS DateTime), 1, N'End User', 0)
SET IDENTITY_INSERT [dbo].[Ticket_Activity] OFF
SET IDENTITY_INSERT [dbo].[Ticket_Master] ON 

INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (1, N'Google <no-reply@accounts.google.com>', NULL, NULL, CAST(N'2018-03-26T23:08:27.490' AS DateTime), N'Email', NULL, N'Access for less secure apps has been turned on', NULL, N'Open', 1, NULL, NULL, 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (2, N'Andy from Google <andy-noreply@google.com>', NULL, NULL, CAST(N'2018-03-26T23:08:29.140' AS DateTime), N'Email', NULL, N'Mayank, welcome to your new Google Account', 1, N'Open', 1, NULL, NULL, 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (4, N'mayanky@mail.usf.edu', N'Mayank Yadav', 0, CAST(N'2018-04-21T18:33:11.437' AS DateTime), N'Phone', N'Request', N'Upload Dark Knight', 1, N'Waiting', 2, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (5, N'mayanky@mail.usf.edu', N'Mayank Yadav', 0, CAST(N'2018-04-21T18:35:24.347' AS DateTime), N'Web', N'Complain', N'Movie not Playing', NULL, N'Resolved', 1, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (6, N'mayanky@mail.usf.edu', N'Mayank Yadav', 0, CAST(N'2018-04-21T18:36:28.353' AS DateTime), N'Web', N'Request', N'Add Chris Pratt Movies', 0, N'New', 3, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (7, N'gh@gh.com', N'hjd', 1, CAST(N'2018-04-22T17:40:37.540' AS DateTime), N'jbjbfv', N'vjfvn', N'fjvbjfv', NULL, N'5', 5, NULL, NULL, 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (8, N'rt@rt.com', N'jdbvjdfkvml', 1, CAST(N'2018-04-22T17:45:09.143' AS DateTime), N'k vkdlm', N'lcn lkdm ', N'lc vldf mv', NULL, N'New', 2, NULL, NULL, 0, 0)
INSERT [dbo].[Ticket_Master] ([TicketID], [Email], [FullName], [CreatedBy], [CreationDate], [TicketSource], [Category], [Subject], [AssignTo], [TicketStatus], [Priority], [ClosedBy], [ClosedDate], [IsDeleted], [AcknowledgementSent]) VALUES (9, N'mayanky@mail.usf.edu', N'Mayank Yadav', 1, CAST(N'2018-04-23T21:19:57.407' AS DateTime), N'Web', N'Request', N'Black Ops 2', NULL, N'New', 2, NULL, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[Ticket_Master] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [Email Unique]    Script Date: 4/23/2018 9:44:59 PM ******/
ALTER TABLE [dbo].[BlockList] ADD  CONSTRAINT [Email Unique] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Client]    Script Date: 4/23/2018 9:44:59 PM ******/
ALTER TABLE [dbo].[Client] ADD  CONSTRAINT [IX_Client] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ticket_Activity]  WITH NOCHECK ADD  CONSTRAINT [FK_Ticket_Master_Ticket_Master] FOREIGN KEY([TicketID])
REFERENCES [dbo].[Ticket_Master] ([TicketID])
GO
ALTER TABLE [dbo].[Ticket_Activity] CHECK CONSTRAINT [FK_Ticket_Master_Ticket_Master]
GO
ALTER TABLE [dbo].[Ticket_Collaborator]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Collaborator_Ticket_Master] FOREIGN KEY([TicketID])
REFERENCES [dbo].[Ticket_Master] ([TicketID])
GO
ALTER TABLE [dbo].[Ticket_Collaborator] CHECK CONSTRAINT [FK_Ticket_Collaborator_Ticket_Master]
GO
USE [master]
GO
ALTER DATABASE [Ticket] SET  READ_WRITE 
GO
