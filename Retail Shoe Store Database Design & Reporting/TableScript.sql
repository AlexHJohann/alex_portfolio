

Create database Sales_BC
GO
USE Sales_BC
GO

CREATE TABLE [dbo].[Customer](
	[Customer_Id] [bigint] NOT NULL,
	[Name] [varchar](50) NULL,
	[EMail_Id] [varchar](75) NULL,
	[Phone_Number] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC
))
GO


CREATE TABLE [dbo].[PaymentType](
	[PaymentType_Id] [tinyint] NOT NULL,
	[Name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentType_Id] ASC
))
GO



CREATE TABLE [dbo].[Store](
	[Store_Id] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Postal_Code] [varchar](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[Store_Id] ASC
))
GO

CREATE TABLE [dbo].[Transaction_Details](
	[Id] [int] NOT NULL,
	[Customer_Id] [bigint] NOT NULL FOREIGN KEY REFERENCES Customer(Customer_Id),
	[Store_Id] [int] NOT NULL FOREIGN KEY REFERENCES Store(Store_Id),
	[Purchase_DateTime] [datetime] NULL,
	[Amount_cents] [int] NULL,
	[PaymentType_Id] [tinyint] NOT NULL FOREIGN KEY REFERENCES PaymentType(PaymentType_Id),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))



INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (104, N'Alex Johnson', 'alex.johnson@example.com', '1234567890')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (105, N'Maria Garcia', 'maria.garcia@example.com', '2345678901')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (106, N'Michael Smith', 'michael.smith@example.com', '3456789012')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (107, N'Linda Martinez', 'linda.martinez@example.com', '4567890123')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (108, N'James Brown', 'james.brown@example.com', '5678901234')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (109, N'Patricia Davis', 'patricia.davis@example.com', '6789012345')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (110, N'Robert Wilson', 'robert.wilson@example.com', '7890123456')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (111, N'Jennifer Taylor', 'jennifer.taylor@example.com', '8901234567')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (112, N'William Anderson', 'william.anderson@example.com', '9012345678')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (113, N'John Doe', 'john.doe@example.com', '0987654321')
INSERT [dbo].[Customer] ([Customer_Id], [Name], [EMail_Id], [Phone_Number]) VALUES (114, N'Mike Smith', 'mike.smith@example.com', '0987651234')



INSERT [dbo].[PaymentType] ([PaymentType_Id], [Name]) VALUES (1, N'Cash')
INSERT [dbo].[PaymentType] ([PaymentType_Id], [Name]) VALUES (2, N'Credit Card')
INSERT [dbo].[PaymentType] ([PaymentType_Id], [Name]) VALUES (3, N'Debit Card')
INSERT [dbo].[PaymentType] ([PaymentType_Id], [Name]) VALUES (4, N'Gift Card')
INSERT [dbo].[PaymentType] ([PaymentType_Id], [Name]) VALUES (99, N'No Charge')
GO



INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (3, N'Walmart', N'Burnaby', N'V5A1S6')
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (1, N'Safeway', N'Burnaby', N'V5A1S7')
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (4, N'Price Smart', N'Burnaby', N'V6A1S6')
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (2, N'Save On Foods', N'Burnaby', N'V6A1S7')   
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (5, N'T&T', N'Burnaby', N'V7A1S6')
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (6, N'Costco', N'Burnaby', N'V8A1S6')
INSERT [dbo].[Store] ([Store_Id], [Name], [City], [Postal_Code]) VALUES (7, N'Whole Foods', N'Burnaby', N'V9A1S6')




/* add data to Transaction_Details table */
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (7, 104, 3, CAST(N'2023-07-01T11:00:00.000' AS DateTime), 34300, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (8, 105, 4, CAST(N'2023-07-02T12:00:00.000' AS DateTime), 72000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (9, 106, 5, CAST(N'2023-07-03T13:00:00.000' AS DateTime), 10000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (10, 107, 6, CAST(N'2023-07-04T14:00:00.000' AS DateTime), 20000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (11, 108, 7, CAST(N'2023-07-05T15:00:00.000' AS DateTime), 30000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (12, 109, 1, CAST(N'2023-07-06T16:00:00.000' AS DateTime), 40000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (13, 110, 2, CAST(N'2023-07-07T17:00:00.000' AS DateTime), 50000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (14, 111, 3, CAST(N'2023-07-08T18:00:00.000' AS DateTime), 60000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (15, 112, 4, CAST(N'2023-07-09T19:00:00.000' AS DateTime), 70000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (16, 113, 5, CAST(N'2023-07-10T20:00:00.000' AS DateTime), 80000, 4)

INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (17, 104, 6, CAST(N'2023-07-11T21:00:00.000' AS DateTime), 90000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (18, 105, 7, CAST(N'2023-07-12T22:00:00.000' AS DateTime), 10000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (19, 106, 1, CAST(N'2023-07-13T23:00:00.000' AS DateTime), 20000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (20, 107, 2, CAST(N'2023-07-14T00:00:00.000' AS DateTime), 30000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (21, 108, 3, CAST(N'2023-07-15T01:00:00.000' AS DateTime), 40000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (22, 109, 4, CAST(N'2023-07-16T02:00:00.000' AS DateTime), 50000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (23, 110, 5, CAST(N'2023-07-17T03:00:00.000' AS DateTime), 60000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (24, 111, 6, CAST(N'2023-07-18T04:00:00.000' AS DateTime), 70000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (25, 112, 7, CAST(N'2023-07-19T05:00:00.000' AS DateTime), 80000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (26, 113, 1, CAST(N'2023-07-20T06:00:00.000' AS DateTime), 90000, 2)

INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (27, 104, 2, CAST(N'2023-07-21T07:00:00.000' AS DateTime), 10000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (28, 105, 3, CAST(N'2023-07-22T08:00:00.000' AS DateTime), 20000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (29, 106, 4, CAST(N'2023-07-23T09:00:00.000' AS DateTime), 30000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (30, 107, 5, CAST(N'2023-07-24T10:00:00.000' AS DateTime), 40000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (31, 108, 6, CAST(N'2023-07-25T11:00:00.000' AS DateTime), 50000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (32, 109, 7, CAST(N'2023-07-26T12:00:00.000' AS DateTime), 60000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (33, 110, 1, CAST(N'2023-07-27T13:00:00.000' AS DateTime), 70000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (34, 111, 2, CAST(N'2023-07-28T14:00:00.000' AS DateTime), 80000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (35, 112, 3, CAST(N'2023-07-29T15:00:00.000' AS DateTime), 90000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (36, 113, 4, CAST(N'2023-07-30T16:00:00.000' AS DateTime), 10000, 4)

INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (37, 104, 5, CAST(N'2023-07-31T17:00:00.000' AS DateTime), 20000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (38, 105, 6, CAST(N'2023-08-01T18:00:00.000' AS DateTime), 30000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (39, 106, 7, CAST(N'2023-08-02T19:00:00.000' AS DateTime), 40000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (40, 107, 1, CAST(N'2023-08-03T20:00:00.000' AS DateTime), 50000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (41, 108, 2, CAST(N'2023-08-04T21:00:00.000' AS DateTime), 60000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (42, 109, 3, CAST(N'2023-08-05T22:00:00.000' AS DateTime), 70000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (43, 110, 4, CAST(N'2023-08-06T23:00:00.000' AS DateTime), 80000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (44, 111, 5, CAST(N'2023-08-07T00:00:00.000' AS DateTime), 90000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (45, 112, 6, CAST(N'2023-08-08T01:00:00.000' AS DateTime), 10000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (46, 113, 7, CAST(N'2023-08-09T02:00:00.000' AS DateTime), 20000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (48, 105, 2, CAST(N'2023-08-11T04:00:00.000' AS DateTime), 40000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (49, 106, 3, CAST(N'2023-08-12T05:00:00.000' AS DateTime), 50000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (50, 107, 4, CAST(N'2023-08-13T06:00:00.000' AS DateTime), 60000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (51, 108, 5, CAST(N'2023-08-14T07:00:00.000' AS DateTime), 70000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (52, 109, 6, CAST(N'2023-08-15T08:00:00.000' AS DateTime), 80000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (53, 110, 7, CAST(N'2023-08-16T09:00:00.000' AS DateTime), 90000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (54, 111, 1, CAST(N'2023-08-17T10:00:00.000' AS DateTime), 10000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (55, 112, 2, CAST(N'2023-08-18T11:00:00.000' AS DateTime), 20000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (56, 113, 3, CAST(N'2023-08-19T12:00:00.000' AS DateTime), 30000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (58, 105, 5, CAST(N'2023-08-21T14:00:00.000' AS DateTime), 50000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (59, 106, 6, CAST(N'2023-08-22T15:00:00.000' AS DateTime), 60000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (60, 107, 7, CAST(N'2023-08-23T16:00:00.000' AS DateTime), 70000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (61, 108, 1, CAST(N'2023-08-24T17:00:00.000' AS DateTime), 80000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (62, 109, 2, CAST(N'2023-08-25T18:00:00.000' AS DateTime), 90000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (63, 110, 3, CAST(N'2023-08-26T19:00:00.000' AS DateTime), 10000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (64, 111, 4, CAST(N'2023-08-27T20:00:00.000' AS DateTime), 20000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (65, 112, 5, CAST(N'2023-08-28T21:00:00.000' AS DateTime), 30000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (66, 113, 6, CAST(N'2023-08-29T22:00:00.000' AS DateTime), 40000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (68, 105, 1, CAST(N'2023-08-31T00:00:00.000' AS DateTime), 60000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (69, 106, 2, CAST(N'2023-09-01T01:00:00.000' AS DateTime), 70000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (70, 107, 3, CAST(N'2023-09-02T02:00:00.000' AS DateTime), 80000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (71, 108, 4, CAST(N'2023-09-03T03:00:00.000' AS DateTime), 90000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (72, 109, 5, CAST(N'2023-09-04T04:00:00.000' AS DateTime), 10000, 4)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (73, 110, 6, CAST(N'2023-09-05T05:00:00.000' AS DateTime), 20000, 1)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (74, 111, 7, CAST(N'2023-09-06T06:00:00.000' AS DateTime), 30000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (75, 112, 1, CAST(N'2023-09-07T07:00:00.000' AS DateTime), 40000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (76, 113, 2, CAST(N'2023-09-08T08:00:00.000' AS DateTime), 50000, 4)

INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (78, 105, 4, CAST(N'2023-09-10T10:00:00.000' AS DateTime), 70000, 2)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (79, 106, 5, CAST(N'2023-09-11T11:00:00.000' AS DateTime), 80000, 3)
INSERT INTO [dbo].[Transaction_Details] ([Id], [Customer_Id], [Store_Id], [Purchase_DateTime], [Amount_cents], [PaymentType_Id]) VALUES (80, 107, 6, CAST(N'2023-09-12T12:00:00.000' AS DateTime), 90000, 4)





GO
