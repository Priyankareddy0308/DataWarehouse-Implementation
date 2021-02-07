/****** Object:  Database ist722_hhkhan_cb7_dw    Script Date: 11/13/2020 7:27:29 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_hhkhan_cb7_dw
GO
CREATE DATABASE ist722_hhkhan_cb7_dw
GO
ALTER DATABASE ist722_hhkhan_cb7_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhkhan_cb7_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;


-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA group7
GO


/* Drop table group7.Dim_Date */

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Dim_Date') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Dim_Date 
;

/* Create table group7.Dim_Date */
CREATE TABLE group7.Dim_Date (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsAWeekday] varchar(1) NOT NULL DEFAULT (('N')) -- changed from [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_group7.Dim_Date] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

INSERT INTO group7.Dim_Date (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsAWeekday)
VALUES (-1, null, 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, '?')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[Date]'))
DROP VIEW [group7].[Date]
GO
CREATE VIEW [group7].[Date] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [FullDateUSA] AS [FullDateUSA]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [QuarterName] AS [QuarterName]
, [Year] AS [Year]
, [IsAWeekday] AS [IsAWeekday]
FROM group7.Dim_Date
GO


/* Drop table group7.Dim_Product_Plan */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Dim_Product_Plan') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Dim_Product_Plan 
;

/* Create table group7.Dim_Product_Plan */
CREATE TABLE group7.Dim_Product_Plan (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [Source]  nvarchar(4)   NOT NULL
,  [ProductName]  nvarchar(50)   NOT NULL
,  [ProductPrice]  money   NOT NULL
,  [ProductDepartment]  varchar(20)   NOT NULL
, CONSTRAINT [PK_group7.Dim_Product_Plan] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT group7.Dim_Product_Plan ON
;
INSERT INTO group7.Dim_Product_Plan (ProductKey, ProductID, Source, ProductName, ProductPrice, ProductDepartment)
VALUES (-1, -1, 'none', 'none','', 'none')
;
SET IDENTITY_INSERT group7.Dim_Product_Plan OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[Product_Plan]'))
DROP VIEW [group7].[Product_Plan]
GO
CREATE VIEW [group7].[Product_Plan] AS 
SELECT [ProductKey] AS [ProductKey]
, [ProductID] AS [ProductID]
, [Source] AS [Source]
, [ProductName] AS [ProductName]
, [ProductPrice] AS [ProductPrice]
, [ProductDepartment] AS [ProductDepartment]
FROM group7.Dim_Product_Plan
GO

/* Drop table group7.Dim_Customer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Dim_Customer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Dim_Customer 
;

/* Create table group7.Dim_Customer */
CREATE TABLE group7.Dim_Customer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerId]  int   NOT NULL
,  [CustomerName]  nvarchar(50)   NOT NULL
,  [CustomerEmail]  nvarchar(50)   NOT NULL
,  [Source]  nvarchar(4)   NOT NULL
,  [Customer_Zip]  varchar(20)   NULL
, CONSTRAINT [PK_group7.Dim_Customer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT group7.Dim_Customer ON
;
INSERT INTO group7.Dim_Customer (CustomerKey, CustomerId, CustomerName, CustomerEmail, Source, Customer_Zip)
VALUES (-1, -1, 'none', 'none','none', 'none')
;
SET IDENTITY_INSERT group7.Dim_Customer OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[Customer]'))
DROP VIEW [group7].[Customer]
GO
CREATE VIEW [group7].[Customer] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerId] AS [CustomerId]
, [CustomerName] AS [CustomerName]
, [CustomerEmail] AS [CustomerEmail]
, [Source] AS [Source]
, [Customer_Zip] AS [Customer_Zip]
FROM group7.Dim_Customer
GO


/* Drop table group7.Dim_Order_Bill */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Dim_Order_Bill') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Dim_Order_Bill 
;

/* Create table group7.Dim_Order_Bill */
CREATE TABLE group7.Dim_Order_Bill (
   [OrderKey]  int IDENTITY  NOT NULL
,  [OrderId]  int   NOT NULL
, [ProductId] int NOT NULL
,  [Source]  nvarchar(4)   NOT NULL
,  [OrderDate]  datetime   NOT NULL
,  [CustomerId]  int   NOT NULL
,  [OrderQuantity]  int   NOT NULL
, CONSTRAINT [PK_group7.Dim_Order_Bill] PRIMARY KEY CLUSTERED 
( [OrderKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT group7.Dim_Order_Bill ON
;
INSERT INTO group7.Dim_Order_Bill (OrderKey, OrderId,ProductId, Source, OrderDate, CustomerId, OrderQuantity)
VALUES (-1, -1, -1,'none', 1900-01-01, -1, -1)
;
SET IDENTITY_INSERT group7.Dim_Order_Bill OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[Order_Bill]'))
DROP VIEW [group7].[Order_Bill]
GO
CREATE VIEW [group7].[Order_Bill] AS 
SELECT [OrderKey] AS [OrderKey]
, [OrderId] AS [OrderId]
, [ProductId] AS [ProductId]
, [Source] AS [Source]
, [OrderDate] AS [OrderDate]
, [CustomerId] AS [CustomerId]
, [OrderQuantity] AS [OrderQuantity]
FROM group7.Dim_Order_Bill
GO


/* Drop table group7.Dim_Location */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Dim_Location') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Dim_Location 
;

/* Create table group7.Dim_Location */
CREATE TABLE group7.Dim_Location (
   [LocationKey]  int IDENTITY  NOT NULL
,  [ZipCode]  int   NOT NULL -- Changing to Int from varchar(20)
,  [Source] nvarchar(4) NOT NULL
,  [City]  nvarchar(50)   NOT NULL
,  [State]  char(2)   NOT NULL -- changing to char(2) from nvarchar(50)
, CONSTRAINT [PK_group7.Dim_Location] PRIMARY KEY CLUSTERED 
( [LocationKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT group7.Dim_Location ON
;
INSERT INTO group7.Dim_Location (LocationKey, ZipCode, Source, City, State)
VALUES (-1, -1, 'none', 'none', '')
;
SET IDENTITY_INSERT group7.Dim_Location OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[Location]'))
DROP VIEW [group7].[Location]
GO
CREATE VIEW [group7].[Location] AS 
SELECT [LocationKey] AS [Blank Dim Key]
, [ZipCode] AS [Blank Dim ID]
, [Source] AS [Source]
, [City] AS [Attribute1]
, [State] AS [Attribute2]
FROM group7.Dim_Location
GO



/* Drop table group7.Fact_RevenueStreams */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'group7.Fact_RevenueStreams') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE group7.Fact_RevenueStreams 
;

/* Create table group7.Fact_RevenueStreams */
CREATE TABLE group7.Fact_RevenueStreams (
   [ProductKey]  int   NOT NULL
,  [OrderKey]  int   NOT NULL
,  [LocationKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [RevenureEarned]  money   NULL
,  [Source]  nvarchar(4)   NOT NULL
) ON [PRIMARY]
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[group7].[RevenueStreams]'))
DROP VIEW [group7].[RevenueStreams]
GO
CREATE VIEW [group7].[RevenueStreams] AS 
SELECT [ProductKey] AS [ProductKey]
, [OrderKey] AS [OrderKey]
, [LocationKey] AS [LocationKey]
, [OrderDateKey] AS [OrderDateKey]
, [RevenureEarned] AS [RevenueEarned]
, [Source] AS [Source]
FROM group7.Fact_RevenueStreams
GO

ALTER TABLE group7.Fact_RevenueStreams ADD CONSTRAINT
   FK_group7_Fact_RevenueStreams_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES group7.Dim_Product_Plan
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE group7.Fact_RevenueStreams ADD CONSTRAINT
   FK_group7_Fact_RevenueStreams_OrderKey FOREIGN KEY
   (
   OrderKey
   ) REFERENCES group7.Dim_Order_Bill
   ( OrderKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE group7.Fact_RevenueStreams ADD CONSTRAINT
   FK_group7_Fact_RevenueStreams_LocationKey FOREIGN KEY
   (
   LocationKey
   ) REFERENCES group7.Dim_Location
   ( LocationKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE group7.Fact_RevenueStreams ADD CONSTRAINT
   FK_group7_Fact_RevenueStreams_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES group7.Dim_Date
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 ----- 11/17/2020 12:07 PM
 CREATE TABLE group7.Fact_RevenueStreams (
   [ProductKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [OrderKey]  int   NOT NULL
,  [LocationKey]  int   NOT NULL
,  [CustomerKey]  int NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [RevenureEarned] decimal(25,4) NOT NULL
,  [Source]  nvarchar(4)   NOT NULL
, CONSTRAINT pkFactRevenueStreams PRIMARY KEY ( ProductKey, OrderKey, LocationKey,CustomerKey,OrderdateKey,Source)
, CONSTRAINT fkFactRevenueStreamsProductKey FOREIGN KEY ( ProductKey,Source )
	REFERENCES group7.Dim_Product_Plan (ProductKey,Source)
, CONSTRAINT fkFactRevenueStreamsLocationKey FOREIGN KEY ( LocationKey,Source )
	REFERENCES group7.Dim_Location (LocationKey,Source)
, CONSTRAINT fkFactRevenueStreamsOrderDateKey FOREIGN KEY (OrderDateKey )
	REFERENCES group7.Dim_Date (DateKey)
, CONSTRAINT fkFactRevenueStreamsCustomerKey FOREIGN KEY (CustomerKey,Source )
	REFERENCES group7.Dim_Customer (CustomerKey,Source)
--, CONSTRAINT fkFactRevenueStreamsOrderKey FOREIGN KEY (OrderKey,Source )
	--REFERENCES group7.Dim_Order_Bill (OrderKey,Source)
) 
;