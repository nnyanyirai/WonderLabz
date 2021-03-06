USE [master]
GO
/****** Object:  Database [WonderLabz_BankAPI_DB]    Script Date: 4/25/2021 11:04:49 PM ******/
CREATE DATABASE [WonderLabz_BankAPI_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WonderLabz_BankAPI_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\WonderLabz_BankAPI_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WonderLabz_BankAPI_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\WonderLabz_BankAPI_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WonderLabz_BankAPI_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET  MULTI_USER 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [WonderLabz_BankAPI_DB]
GO
/****** Object:  Table [dbo].[tblAccountRules]    Script Date: 4/25/2021 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountRules](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[RuleCode] [int] NULL,
	[RuleDescription] [varchar](100) NOT NULL,
	[Value] [money] NULL,
	[CreatedBy] [bigint] NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_tblAccountRules] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountsBalances]    Script Date: 4/25/2021 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountsBalances](
	[BalanceID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [bigint] NOT NULL,
	[Balance] [money] NULL,
	[BalanceDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblAccountsBalances] PRIMARY KEY CLUSTERED 
(
	[BalanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblClientAccounts]    Script Date: 4/25/2021 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClientAccounts](
	[AccountID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountNo] [nvarchar](20) NULL,
	[AccName] [nvarchar](500) NULL,
	[StreetAddress] [nvarchar](500) NULL,
	[TownCity] [bigint] NULL,
	[Country] [bigint] NULL,
	[AccTypeID] [bigint] NULL,
	[TransTypeID] [bigint] NULL,
	[ProcessedBy] [bigint] NULL,
	[DateProcessed] [datetime] NOT NULL,
	[AccountStatus] [int] NULL,
 CONSTRAINT [PK_tblClientAccounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTransactionHistory]    Script Date: 4/25/2021 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTransactionHistory](
	[HistoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [bigint] NULL,
	[Action] [varchar](200) NOT NULL,
	[AccTypeID] [int] NULL,
	[TransTypeID] [int] NULL,
	[Debit] [money] NULL,
	[UserID] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[Credit] [money] NULL,
 CONSTRAINT [PK_tblTransactionHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTransferFunds]    Script Date: 4/25/2021 11:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTransferFunds](
	[TransferID] [int] IDENTITY(1,1) NOT NULL,
	[FromAccount] [bigint] NOT NULL,
	[ToAccount] [bigint] NOT NULL,
	[Amount] [money] NULL,
	[CreatedBy] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[TransactionType] [int] NOT NULL,
	[AccountType] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAccountRules] ON 

INSERT [dbo].[tblAccountRules] ([RuleID], [RuleCode], [RuleDescription], [Value], [CreatedBy], [DateCreated]) VALUES (6, 1, N'Minimum Deposit
', 1000.0000, 1, CAST(N'2021-04-25T00:00:00.000' AS DateTime))
INSERT [dbo].[tblAccountRules] ([RuleID], [RuleCode], [RuleDescription], [Value], [CreatedBy], [DateCreated]) VALUES (9, 2, N'Overdraft Limit
', 100000.0000, 1, CAST(N'2021-04-25T00:00:00.000' AS DateTime))
INSERT [dbo].[tblAccountRules] ([RuleID], [RuleCode], [RuleDescription], [Value], [CreatedBy], [DateCreated]) VALUES (12, 3, N'Minimum Balance
', 1000.0000, 1, CAST(N'2021-04-25T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblAccountRules] OFF
GO
SET IDENTITY_INSERT [dbo].[tblAccountsBalances] ON 

INSERT [dbo].[tblAccountsBalances] ([BalanceID], [AccountID], [Balance], [BalanceDate]) VALUES (1, 14, 3997.0000, CAST(N'2021-04-25T22:02:29.483' AS DateTime))
INSERT [dbo].[tblAccountsBalances] ([BalanceID], [AccountID], [Balance], [BalanceDate]) VALUES (2, 15, 5998.0000, CAST(N'2021-04-25T22:02:40.273' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblAccountsBalances] OFF
GO
SET IDENTITY_INSERT [dbo].[tblClientAccounts] ON 

INSERT [dbo].[tblClientAccounts] ([AccountID], [AccountNo], [AccName], [StreetAddress], [TownCity], [Country], [AccTypeID], [TransTypeID], [ProcessedBy], [DateProcessed], [AccountStatus]) VALUES (14, N'ACCNO23042021153729', N'Chad Nyanyirai', N'test 1223', 1, 1, 1, 1, 1, CAST(N'2021-04-23T15:37:34.317' AS DateTime), 1)
INSERT [dbo].[tblClientAccounts] ([AccountID], [AccountNo], [AccName], [StreetAddress], [TownCity], [Country], [AccTypeID], [TransTypeID], [ProcessedBy], [DateProcessed], [AccountStatus]) VALUES (15, N'ACCNO25042021211949', N'Norbert Nyanyirai', N'123 test', 1, 1, 2, 1, 1, CAST(N'2021-04-25T21:19:50.103' AS DateTime), 1)
INSERT [dbo].[tblClientAccounts] ([AccountID], [AccountNo], [AccName], [StreetAddress], [TownCity], [Country], [AccTypeID], [TransTypeID], [ProcessedBy], [DateProcessed], [AccountStatus]) VALUES (16, N'ACCNO25042021212028', N'Samuel Nyanyirai', N'123 test', 1, 1, 2, 1, 1, CAST(N'2021-04-25T21:20:28.843' AS DateTime), 0)
INSERT [dbo].[tblClientAccounts] ([AccountID], [AccountNo], [AccName], [StreetAddress], [TownCity], [Country], [AccTypeID], [TransTypeID], [ProcessedBy], [DateProcessed], [AccountStatus]) VALUES (17, N'ACCNO25042021225304', N'Patience Nyanyirai', N'123 test', 1, 1, 2, 1, 1, CAST(N'2021-04-25T22:53:05.860' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblClientAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTransactionHistory] ON 

INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (1, 14, N'Initial deposity for Account Opening of 1,000.000', 2, 1, 0.0000, 1, CAST(N'2021-04-25T21:53:58.427' AS DateTime), 1000.0000)
INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (2, 15, N'Initial deposity for Account Opening of 10,000.000', 2, 1, 0.0000, 1, CAST(N'2021-04-25T21:57:46.713' AS DateTime), 10000.0000)
INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (3, 14, N'Withidrawn an amount of 100.000', 2, 2, 100.0000, 1, CAST(N'2021-04-25T22:11:56.773' AS DateTime), 0.0000)
INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (4, 14, N'Deposity of 15,000.000', 2, 1, 0.0000, 1, CAST(N'2021-04-25T22:15:09.527' AS DateTime), 15000.0000)
INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (5, 14, N'Deposity of 15,000.000', 2, 1, 0.0000, 1, CAST(N'2021-04-25T22:19:32.517' AS DateTime), 15000.0000)
INSERT [dbo].[tblTransactionHistory] ([HistoryID], [AccountID], [Action], [AccTypeID], [TransTypeID], [Debit], [UserID], [DateCreated], [Credit]) VALUES (10, 14, N'Internal transfer from account ID: 14.000 to account ID: 14.000', 1, 1, 2001.0000, 0, CAST(N'2021-04-25T22:42:14.173' AS DateTime), 0.0000)
SET IDENTITY_INSERT [dbo].[tblTransactionHistory] OFF
GO
ALTER TABLE [dbo].[tblAccountsBalances] ADD  CONSTRAINT [DF__tblAccoun__Balan__4222D4EF]  DEFAULT (getdate()) FOR [BalanceDate]
GO
ALTER TABLE [dbo].[tblClientAccounts] ADD  CONSTRAINT [DF__tblClient__DateP__403A8C7D]  DEFAULT (getdate()) FOR [DateProcessed]
GO
ALTER TABLE [dbo].[tblTransactionHistory] ADD  CONSTRAINT [DF__tblTransa__DateC__36B12243]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tblTransferFunds] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tblClientAccounts]  WITH CHECK ADD  CONSTRAINT [FK_tblClientAccounts_tblClientAccounts] FOREIGN KEY([AccountID])
REFERENCES [dbo].[tblClientAccounts] ([AccountID])
GO
ALTER TABLE [dbo].[tblClientAccounts] CHECK CONSTRAINT [FK_tblClientAccounts_tblClientAccounts]
GO
USE [master]
GO
ALTER DATABASE [WonderLabz_BankAPI_DB] SET  READ_WRITE 
GO
