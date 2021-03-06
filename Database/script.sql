USE [batchs]
GO
/****** Object:  Table [dbo].[BatchFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchFinal](
	[BatchID] [varchar](50) NOT NULL,
	[BatchName] [varchar](50) NULL,
	[Tank1] [varchar](50) NULL,
	[Tank2] [varchar](50) NULL,
	[Tank3] [varchar](50) NULL,
	[Tank4] [varchar](50) NULL,
	[Tank5] [varchar](50) NULL,
	[Tank6] [varchar](50) NULL,
	[Tank7] [varchar](50) NULL,
	[Tank8] [varchar](50) NULL,
	[Tank9] [varchar](50) NULL,
	[Works] [int] NULL,
	[DateT] [date] NULL,
	[TimeT] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Batchs]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Batchs](
	[BatchID] [int] NOT NULL,
	[BatchName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Batchs] PRIMARY KEY CLUSTERED 
(
	[BatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchsDetails]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchsDetails](
	[BatchID] [int] NOT NULL,
	[TankID] [int] NULL,
	[TankName] [varchar](50) NULL,
	[MixWeight] [float] NULL,
	[LowWeight] [float] NULL,
	[FreeFallWeight] [float] NULL,
	[HighSpeed] [float] NULL,
	[LowSpeed] [float] NULL,
	[Working] [varchar](50) NULL,
	[Orders] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchWeight]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchWeight](
	[BatchID] [int] NOT NULL,
	[BatchName] [varchar](50) NULL,
	[TankName] [varchar](50) NULL,
	[FinalWeight] [real] NULL,
	[Works] [int] NULL,
	[DateT] [date] NULL,
	[TimeT] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NameTankFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NameTankFinal](
	[BatchID] [varchar](50) NOT NULL,
	[BatchName] [varchar](50) NOT NULL,
	[Tank1N] [varchar](50) NOT NULL,
	[Tank2N] [varchar](50) NOT NULL,
	[Tank3N] [varchar](50) NOT NULL,
	[Tank4N] [varchar](50) NOT NULL,
	[Tank5N] [varchar](50) NOT NULL,
	[Tank6N] [varchar](50) NOT NULL,
	[Tank7N] [varchar](50) NOT NULL,
	[Tank8N] [varchar](50) NOT NULL,
	[Works] [int] NOT NULL,
	[DateT] [date] NOT NULL,
	[TimeT] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tanks]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tanks](
	[TankID] [int] NOT NULL,
	[TankName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tanks] PRIMARY KEY CLUSTERED 
(
	[TankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[BatchsDetails]  WITH CHECK ADD  CONSTRAINT [FK_BatchsDetails_Batchs] FOREIGN KEY([BatchID])
REFERENCES [dbo].[Batchs] ([BatchID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BatchsDetails] CHECK CONSTRAINT [FK_BatchsDetails_Batchs]
GO
/****** Object:  StoredProcedure [dbo].[ADD_Batch_Weight]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ADD_Batch_Weight]

@BatchID int,
@BatchName varchar(50),
@TankName varchar(50),
@FinalWeight real,
@Works int,
@DateT date,
@TimeT varchar(50)

as

INSERT INTO [batchs].[dbo].[BatchWeight]
           ([BatchID]
           ,[BatchName]
           ,[TankName]
           ,[FinalWeight]
           ,[Works]
           ,[DateT]
           ,[TimeT])
     VALUES
           (@BatchID,
           @BatchName,  
           @TankName, 
           @FinalWeight,  
           @Works,
           @DateT,
           @TimeT)

GO
/****** Object:  StoredProcedure [dbo].[ADD_Batchs_Details]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ADD_Batchs_Details]

@BatchID int,
@TankID int,
@TankName varchar(50),
@MixWeight float,
@LowWeight float,
@FreeFallWeight float,
@HighSpeed float,
@LowSpeed float,
@Working varchar(50),
@Orders int

as

INSERT INTO [BatchsDetails]
           ([BatchID]
           ,[TankID]
           ,[TankName]
           ,[MixWeight]
           ,[LowWeight]
           ,[FreeFallWeight]
           ,[HighSpeed]
           ,[LowSpeed]
           ,[Working]
           ,[Orders])
     VALUES
           (@BatchID,
           @TankID
           ,@TankName
           ,@MixWeight
           ,@LowWeight
           ,@FreeFallWeight
           ,@HighSpeed
           ,@LowSpeed
           ,@Working
           ,@Orders)

GO
/****** Object:  StoredProcedure [dbo].[del_BatchName]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[del_BatchName]

@BatchName varchar(50)

as


DELETE FROM [Batchs]WHERE BatchName=@BatchName

GO
/****** Object:  StoredProcedure [dbo].[DELETE_BatchFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DELETE_BatchFinal]
as

DELETE FROM [batchs].[dbo].[BatchFinal]
    
DELETE FROM [batchs].[dbo].[NameTankFinal]

DELETE FROM [batchs].[dbo].[BatchWeight]

GO
/****** Object:  StoredProcedure [dbo].[DELETE_Batchs]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DELETE_Batchs]
as

DELETE FROM [batchs].[dbo].[Batchs]

GO
/****** Object:  StoredProcedure [dbo].[GET_ALL_BatchName]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GET_ALL_BatchName]


as

 SELECT * FROM  Batchs

GO
/****** Object:  StoredProcedure [dbo].[GET_ALL_Report_BatchFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_ALL_Report_BatchFinal]

@BatchName varchar (50),
@myFrom Date,
@myTo Date



as

SELECT [BatchID]
      ,[BatchName]
      ,[Tank1]
      ,[Tank2]
      ,[Tank3]
      ,[Tank4]
      ,[Tank5]
      ,[Tank6]
      ,[Tank7]
      ,[Tank8]
      ,[Tank9]
      ,[Works]
      ,[DateT]
      ,[TimeT]
  FROM [batchs].[dbo].[BatchFinal]
  WHERE BatchName =@BatchName And [DateT] between @myFrom and @myTo order by BatchID

GO
/****** Object:  StoredProcedure [dbo].[Get_BatchsDetails]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_BatchsDetails]
@BatchName varchar (50)
as 
      

	SELECT Batchs.BatchName, BatchsDetails.*
FROM   Batchs INNER JOIN
       BatchsDetails ON Batchs.BatchID = BatchsDetails.BatchID where BatchName=@BatchName

GO
/****** Object:  StoredProcedure [dbo].[GET_LAST_BatchFinal_ID]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GET_LAST_BatchFinal_ID]
as
select ISNULL (Count(BatchID)+1,1) from BatchFinal

GO
/****** Object:  StoredProcedure [dbo].[GET_LAST_Batchs_ID]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GET_LAST_Batchs_ID]
as
select ISNULL (MAX(BatchID)+1,1) from Batchs

GO
/****** Object:  StoredProcedure [dbo].[GET_LAST_BatchWeight_ID]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GET_LAST_BatchWeight_ID]
as
select ISNULL (MAX(BatchID)+1,1) from BatchWeight

GO
/****** Object:  StoredProcedure [dbo].[GET_LAST_NameTankFinal_ID]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GET_LAST_NameTankFinal_ID]
as
select ISNULL (Count(BatchID)+1,1) from NameTankFinal

GO
/****** Object:  StoredProcedure [dbo].[INSERT_Batchs]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[INSERT_Batchs]
@BatchID INT,
@BatchName varchar (50)

as

INSERT INTO [Batchs]
           ([BatchID]
           ,[BatchName])
     VALUES
           (@BatchID,
           @BatchName)

GO
/****** Object:  StoredProcedure [dbo].[INSERT_Tanks]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[INSERT_Tanks]


@TanksID int,
@TanksName varchar(50)

as

INSERT INTO [Tanks]
          
           ([TankID]
           ,[TankName])
         
     VALUES
          
          ( @TanksID
           ,@TanksName)

GO
/****** Object:  StoredProcedure [dbo].[InsertBatchFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertBatchFinal]
@BatchID varchar(50),
@BatchName varchar(50),
@Tank1 varchar(50),
@Tank2 varchar(50),
@Tank3 varchar(50),
@Tank4 varchar(50),
@Tank5 varchar(50),
@Tank6 varchar(50),
@Tank7 varchar(50),
@Tank8 varchar(50),
@Tank9 varchar(50),
@Works int,
@Date date,
@Time varchar(50)
as
INSERT INTO [BatchFinal]

           ([BatchID]
           ,[BatchName]
           ,[Tank1]
           ,[Tank2]
           ,[Tank3]
           ,[Tank4]
           ,[Tank5]
           ,[Tank6]
           ,[Tank7]
           ,[Tank8]
           ,[Tank9]
           ,[Works]
           ,[DateT]
           ,[TimeT])
     VALUES
           (@BatchID,@BatchName
           ,@Tank1 
           ,@Tank2 
           ,@Tank3 
           ,@Tank4 
           ,@Tank5 
           ,@Tank6 
           ,@Tank7 
           ,@Tank8 
           ,@Tank9 
           ,@Works
           ,@Date
           ,@Time)

GO
/****** Object:  StoredProcedure [dbo].[InsertNameTankFinal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertNameTankFinal]
@BatchID int,
@BatchName varchar(50),
@Tank1N varchar(50),
@Tank2N varchar(50),
@Tank3N varchar(50),
@Tank4N varchar(50),
@Tank5N varchar(50),
@Tank6N varchar(50),
@Tank7N varchar(50),
@Tank8N varchar(50),
@Works int,
@Date date,
@Time varchar(50)

as
INSERT INTO [NameTankFinal]
           ([BatchID]
           ,[BatchName]
           ,[Tank1N]
           ,[Tank2N]
           ,[Tank3N]
           ,[Tank4N]
           ,[Tank5N]
           ,[Tank6N]
           ,[Tank7N]
           ,[Tank8N]
           ,[Works]
           ,[DateT]
           ,[TimeT])
     VALUES
           (@BatchID,@BatchName
           ,@Tank1N 
           ,@Tank2N 
           ,@Tank3N 
           ,@Tank4N 
           ,@Tank5N 
           ,@Tank6N
           ,@Tank7N 
           ,@Tank8N 
           ,@Works
           ,@Date
           ,@Time)

GO
/****** Object:  StoredProcedure [dbo].[TankNameVal]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TankNameVal]
@BatchName varchar (50),
@myFrom Date,
@myTo Date
as
SELECT sum(FinalWeight)FROM BatchWeight WHERE TankName =@BatchName And [DateT] between @myFrom and @myTo

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_Batchs]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UPDATE_Batchs]

@BatchID int,
@BatchName varchar(50)

 
as

UPDATE [batchs].[dbo].[Batchs]
   SET [BatchID] = @BatchID
      ,[BatchName] = @BatchName
      
 WHERE BatchID=@BatchID

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_Batchs_Details]    Script Date: 25/05/2018 06:17:47 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UPDATE_Batchs_Details]

 @BatchID int,
@TankID int,
@TankName varchar(50),
@MixWeight float,
@LowWeight float,
@FreeFallWeight float,
@HighSpeed float,
@LowSpeed float,
@Working varchar(50),
@Orders int

as

UPDATE [batchs].[dbo].[BatchsDetails]
    
    SET[BatchID] = @BatchID,
       [TankID] = @TankID
      ,[TankName] = @TankName
      ,[MixWeight] = @MixWeight
      ,[LowWeight] = @LowWeight
      ,[FreeFallWeight] = @FreeFallWeight
      ,[HighSpeed] = @HighSpeed
      ,[LowSpeed] = @LowSpeed
      ,[Working] = @Working
      ,[Orders] = @Orders
 WHERE TankID= @TankID and  BatchID = @BatchID

GO
