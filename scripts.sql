USE [master]
GO
/****** Object:  Database [StudentAttendanceDB]    Script Date: 11/09/2024 3:09:17 PM ******/
CREATE DATABASE [StudentAttendanceDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentAttendanceDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\StudentAttendanceDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentAttendanceDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\StudentAttendanceDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [StudentAttendanceDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentAttendanceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentAttendanceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [StudentAttendanceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentAttendanceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentAttendanceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [StudentAttendanceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentAttendanceDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StudentAttendanceDB] SET  MULTI_USER 
GO
ALTER DATABASE [StudentAttendanceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentAttendanceDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentAttendanceDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentAttendanceDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentAttendanceDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentAttendanceDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StudentAttendanceDB] SET QUERY_STORE = OFF
GO
USE [StudentAttendanceDB]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[AttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[EnrollmentID] [int] NULL,
	[ScheduleID] [int] NULL,
	[UpdatedAt] [datetime] NULL,
	[Status] [nvarchar](10) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Note] [nvarchar](50) NULL,
 CONSTRAINT [PK__Attendan__8B69263C9E1D9919] PRIMARY KEY CLUSTERED 
(
	[AttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassCode] [nvarchar](20) NOT NULL,
	[ClassName] [nvarchar](100) NOT NULL,
	[Note] [nvarchar](50) NULL,
	[SemesterID] [int] NULL,
 CONSTRAINT [PK__Classes__CB1927A0E0036371] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseCode] [nvarchar](20) NOT NULL,
	[CourseName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DepartmentID] [int] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NULL,
	[StudentID] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[EnrolledAt] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__Enrollme__7F6877FB4B0225BD] PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[Room] [nvarchar](50) NULL,
	[TimeSlotID] [int] NOT NULL,
	[TeacherID] [int] NULL,
	[Date] [date] NULL,
	[CourseID] [int] NULL,
	[SubstituteTeacherId] [int] NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK__Schedule__9C8A5B69E92C6B1D] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semesters]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semesters](
	[SemesterID] [int] IDENTITY(1,1) NOT NULL,
	[SemesterName] [nvarchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SemesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [int] NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[Password] [nvarchar](32) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NULL,
	[DepartmentID] [int] NULL,
	[Avatar] [varchar](100) NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__Students__32C52A79E68ED68E] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Avatar] [nchar](10) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NULL,
	[Role] [nvarchar](10) NOT NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__Users__1788CCACDB745DB5] PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSlots]    Script Date: 11/09/2024 3:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSlots](
	[TimeSlotID] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
 CONSTRAINT [PK_TimeSlots] PRIMARY KEY CLUSTERED 
(
	[TimeSlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attendance] ON 

INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (41, 16, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (42, 17, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (43, 133, 8, CAST(N'2024-10-21T10:20:00.000' AS DateTime), N'Absent', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (44, 134, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (45, 135, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (46, 136, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (47, 137, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (48, 138, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (49, 139, 8, NULL, N'Future', CAST(N'2024-10-16T22:55:27.923' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (81, 16, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (82, 17, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (83, 133, 27, NULL, N'Absent', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (84, 134, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (85, 135, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (86, 136, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (87, 137, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (88, 138, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (89, 139, 27, NULL, N'Future', CAST(N'2024-10-16T22:57:21.447' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (121, 16, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (122, 17, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (123, 133, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (124, 134, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (125, 135, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (126, 136, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (127, 137, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (128, 138, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (129, 139, 40, NULL, N'Future', CAST(N'2024-10-16T22:57:57.297' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (147, 29, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (148, 30, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (149, 31, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (150, 32, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (151, 33, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (152, 34, 29, NULL, N'Future', CAST(N'2024-10-16T23:09:28.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (187, 29, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (188, 30, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (189, 31, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (190, 32, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (191, 33, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (192, 34, 36, NULL, N'Future', CAST(N'2024-10-16T23:09:55.273' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (244, 43, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (245, 44, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (246, 45, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (247, 46, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (248, 47, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (249, 48, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (250, 49, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (251, 50, 54, NULL, N'Future', CAST(N'2024-10-17T12:09:57.987' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (253, 10, 60, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (254, 11, 60, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (255, 12, 60, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (256, 10, 61, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (257, 11, 61, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (258, 12, 61, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (259, 10, 62, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (260, 11, 62, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (261, 12, 62, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (262, 10, 63, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (263, 11, 63, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (264, 12, 63, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (265, 10, 64, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (266, 11, 64, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (267, 12, 64, NULL, N'Future', CAST(N'2024-10-17T12:12:35.530' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (268, 10, 65, NULL, N'Present', CAST(N'2024-10-17T12:12:52.980' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (269, 11, 65, NULL, N'Future', CAST(N'2024-10-17T12:12:52.980' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (270, 12, 65, NULL, N'Future', CAST(N'2024-10-17T12:12:52.980' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (271, 179, 60, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (272, 179, 61, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (273, 179, 62, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (274, 179, 63, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (275, 179, 64, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (276, 179, 65, NULL, N'Future', CAST(N'2024-10-17T12:13:39.270' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (277, 180, 60, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (278, 181, 60, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (279, 180, 61, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (280, 181, 61, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (281, 180, 62, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (282, 181, 62, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (283, 180, 63, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (284, 181, 63, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (285, 180, 64, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (286, 181, 64, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (287, 180, 65, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (288, 181, 65, NULL, N'Future', CAST(N'2024-10-18T00:08:22.293' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (289, 182, 60, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (290, 182, 61, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (291, 182, 62, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (292, 182, 63, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (293, 182, 64, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (294, 182, 65, NULL, N'Future', CAST(N'2024-10-18T00:17:56.603' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (295, 183, 60, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (296, 183, 61, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (297, 183, 62, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (298, 183, 63, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (299, 183, 64, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (300, 183, 65, NULL, N'Future', CAST(N'2024-10-18T00:18:35.213' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (301, 184, 60, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (302, 184, 61, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (303, 184, 62, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (304, 184, 63, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
GO
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (305, 184, 64, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (306, 184, 65, NULL, N'Future', CAST(N'2024-10-18T00:20:50.900' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (307, 185, 60, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (308, 185, 61, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (309, 185, 62, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (310, 185, 63, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (311, 185, 64, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (312, 185, 65, NULL, N'Future', CAST(N'2024-10-18T00:34:02.263' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (398, 232, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (399, 233, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (400, 234, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (402, 236, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (403, 237, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (404, 238, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (405, 239, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (406, 240, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (407, 241, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (408, 242, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (409, 243, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (410, 244, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (412, 246, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (413, 247, 76, NULL, N'Future', CAST(N'2024-10-18T00:58:58.037' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (414, 16, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (415, 16, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (416, 16, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (417, 16, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (418, 17, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (419, 17, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (420, 17, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (421, 17, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (422, 133, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (423, 133, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (424, 133, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (425, 133, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (426, 134, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (427, 134, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (428, 134, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (429, 134, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (430, 135, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (431, 135, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (432, 135, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (433, 135, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (434, 136, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (435, 136, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (436, 136, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (437, 136, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (438, 137, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (439, 137, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (440, 137, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (441, 137, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (442, 138, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (443, 138, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (444, 138, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (445, 138, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (446, 139, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (447, 139, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (448, 139, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (449, 139, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (450, 248, 8, NULL, N'Absent', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (451, 248, 27, NULL, N'Absent', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (452, 248, 39, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (453, 248, 40, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (454, 248, 41, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (455, 248, 42, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (456, 248, 78, NULL, N'Future', CAST(N'2024-10-21T01:37:05.090' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (479, 29, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (480, 29, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (481, 29, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (482, 29, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (483, 29, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (484, 29, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (485, 29, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (486, 29, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (487, 29, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (488, 29, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (489, 29, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (490, 30, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (491, 30, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (492, 30, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (493, 30, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (494, 30, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (495, 30, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (496, 30, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (497, 30, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (498, 30, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (499, 30, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (500, 30, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (501, 31, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (502, 31, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (503, 31, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (504, 31, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (505, 31, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (506, 31, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (507, 31, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (508, 31, 56, NULL, N'Present', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (509, 31, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (510, 31, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (511, 31, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (512, 32, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (513, 32, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
GO
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (514, 32, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (515, 32, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (516, 32, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (517, 32, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (518, 32, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (519, 32, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (520, 32, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (521, 32, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (522, 32, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (523, 33, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (524, 33, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (525, 33, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (526, 33, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (527, 33, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (528, 33, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (529, 33, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (530, 33, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (531, 33, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (532, 33, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (533, 33, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (534, 34, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (535, 34, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (536, 34, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (537, 34, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (538, 34, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (539, 34, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (540, 34, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (541, 34, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (542, 34, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (543, 34, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (544, 34, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (556, 249, 29, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (557, 249, 36, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (558, 249, 44, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (559, 249, 45, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (560, 249, 46, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (561, 249, 47, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (562, 249, 48, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (563, 249, 49, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (564, 249, 55, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (565, 249, 56, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (566, 249, 57, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (567, 249, 58, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (568, 249, 59, NULL, N'Future', CAST(N'2024-10-21T22:38:56.813' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (569, 16, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (570, 16, 80, CAST(N'2024-10-25T15:24:48.723' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'string')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (571, 16, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (572, 16, 83, CAST(N'2024-10-26T18:50:11.527' AS DateTime), N'Absent', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'string')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (573, 17, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (574, 17, 80, CAST(N'2024-10-25T00:00:00.000' AS DateTime), N'Absent', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (575, 17, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (576, 17, 83, CAST(N'2024-10-26T18:50:11.527' AS DateTime), N'Absent', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'string')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (577, 133, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (578, 133, 80, CAST(N'2024-10-25T17:02:10.803' AS DateTime), N'Absent', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'string')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (579, 133, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (580, 133, 83, CAST(N'2024-10-26T18:50:11.537' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (581, 134, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (582, 134, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (583, 134, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (584, 134, 83, CAST(N'2024-10-26T18:50:11.540' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (585, 135, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (586, 135, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (587, 135, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (588, 135, 83, CAST(N'2024-10-26T18:50:11.540' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (589, 136, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (590, 136, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (591, 136, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (592, 136, 83, CAST(N'2024-10-26T18:50:11.540' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (593, 137, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (594, 137, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (595, 137, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (596, 137, 83, CAST(N'2024-10-26T18:50:11.540' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (597, 138, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (598, 138, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (599, 138, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (600, 138, 83, CAST(N'2024-10-26T18:50:11.540' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (601, 139, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (602, 139, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (603, 139, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (604, 139, 83, CAST(N'2024-10-26T18:50:11.543' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (605, 248, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (606, 248, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (607, 248, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (608, 248, 83, CAST(N'2024-10-26T18:50:11.543' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (609, 260, 8, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (610, 260, 27, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (611, 260, 39, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (612, 260, 40, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (613, 260, 41, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (614, 260, 42, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (615, 260, 78, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (616, 260, 79, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (617, 260, 80, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (618, 260, 81, NULL, N'Future', CAST(N'2024-10-23T22:23:59.493' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (619, 260, 83, CAST(N'2024-10-26T18:50:11.543' AS DateTime), N'Present', CAST(N'2024-10-23T22:23:59.493' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (620, 10, 84, CAST(N'2024-10-28T10:36:00.083' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (621, 11, 84, CAST(N'2024-10-28T10:36:00.083' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (622, 12, 84, CAST(N'2024-10-28T10:36:00.083' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (623, 179, 84, CAST(N'2024-10-28T10:36:00.083' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (624, 180, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
GO
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (625, 181, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (626, 182, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Absent', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (627, 183, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Absent', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (628, 184, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Absent', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (629, 185, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Present', CAST(N'2024-10-23T22:26:43.907' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (630, 261, 60, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (631, 261, 61, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (632, 261, 62, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (633, 261, 63, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (634, 261, 64, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (635, 261, 65, NULL, N'Future', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (636, 261, 84, CAST(N'2024-10-28T10:36:00.087' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (637, 10, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (638, 11, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Absent', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (639, 12, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (640, 179, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (641, 180, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (642, 181, 85, CAST(N'2024-10-28T10:37:36.683' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (643, 182, 85, CAST(N'2024-10-28T10:37:36.687' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (644, 183, 85, CAST(N'2024-10-28T10:37:36.687' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (645, 184, 85, CAST(N'2024-10-28T10:37:36.687' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (646, 185, 85, CAST(N'2024-10-28T10:37:36.687' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (647, 261, 85, CAST(N'2024-10-28T10:37:36.687' AS DateTime), N'Present', CAST(N'2024-10-23T22:27:13.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (648, 16, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (649, 17, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (650, 133, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (651, 134, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (652, 135, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (653, 136, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (654, 137, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (655, 138, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (656, 139, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (657, 248, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (658, 260, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (659, 262, 8, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (660, 262, 27, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (661, 262, 39, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (662, 262, 40, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (663, 262, 41, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (664, 262, 42, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (665, 262, 78, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (666, 262, 79, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (667, 262, 80, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (668, 262, 81, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (669, 262, 83, CAST(N'2024-10-26T18:50:11.543' AS DateTime), N'Present', CAST(N'2024-10-25T10:43:38.643' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (670, 262, 86, NULL, N'Future', CAST(N'2024-10-25T10:43:38.643' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (671, 16, 87, CAST(N'2024-10-29T13:01:09.513' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (672, 16, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (673, 17, 87, CAST(N'2024-10-29T13:01:09.517' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (674, 17, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (675, 133, 87, CAST(N'2024-10-29T13:01:09.520' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (676, 133, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (677, 134, 87, CAST(N'2024-10-29T13:01:09.520' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (678, 134, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (679, 135, 87, CAST(N'2024-10-29T13:01:09.520' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (680, 135, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (681, 136, 87, CAST(N'2024-10-29T13:01:09.523' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (682, 136, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (683, 137, 87, CAST(N'2024-10-29T13:01:09.523' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (684, 137, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (685, 138, 87, CAST(N'2024-10-29T13:01:09.523' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (686, 138, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (687, 139, 87, CAST(N'2024-10-29T13:01:09.527' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (688, 139, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (689, 248, 87, CAST(N'2024-10-29T13:01:09.527' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (690, 248, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (691, 260, 87, CAST(N'2024-10-29T13:01:09.527' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (692, 260, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (693, 262, 87, CAST(N'2024-10-29T13:01:09.527' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (694, 262, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (695, 263, 8, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (696, 263, 27, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (697, 263, 39, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (698, 263, 40, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (699, 263, 41, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (700, 263, 42, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (701, 263, 78, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (702, 263, 79, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (703, 263, 80, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (704, 263, 81, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (705, 263, 83, CAST(N'2024-10-26T18:50:11.543' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (706, 263, 86, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (707, 263, 87, CAST(N'2024-10-29T13:01:09.530' AS DateTime), N'Present', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (708, 263, 88, NULL, N'Future', CAST(N'2024-10-25T11:01:52.343' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (709, 16, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (710, 17, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (711, 133, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (712, 134, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (713, 135, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (714, 136, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (715, 137, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (716, 138, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (717, 139, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (718, 248, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (719, 260, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (720, 262, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (721, 263, 90, NULL, N'Future', CAST(N'2024-10-25T11:15:39.050' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (722, 16, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (723, 17, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (724, 133, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
GO
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (725, 134, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (726, 135, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (727, 136, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (728, 137, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (729, 138, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (730, 139, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (731, 248, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (732, 260, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (733, 262, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (734, 263, 91, NULL, N'Future', CAST(N'2024-10-25T11:16:43.733' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (735, 16, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (736, 17, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (737, 133, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (738, 134, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (739, 135, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (740, 136, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (741, 137, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (742, 138, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (743, 139, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (744, 248, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (745, 260, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (746, 262, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (747, 263, 92, NULL, N'Future', CAST(N'2024-10-25T11:17:50.770' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (748, 16, 93, CAST(N'2024-11-08T14:14:41.490' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (749, 17, 93, CAST(N'2024-11-08T14:14:41.490' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (750, 133, 93, CAST(N'2024-11-08T14:14:41.490' AS DateTime), N'Absent', CAST(N'2024-10-25T11:19:50.667' AS DateTime), N'1')
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (751, 134, 93, CAST(N'2024-11-08T14:14:41.493' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (752, 135, 93, CAST(N'2024-11-08T14:14:41.493' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (753, 136, 93, CAST(N'2024-11-08T14:14:41.493' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (754, 137, 93, CAST(N'2024-11-08T14:14:41.497' AS DateTime), N'Absent', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (755, 138, 93, CAST(N'2024-11-08T14:14:41.497' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (756, 139, 93, CAST(N'2024-11-08T14:14:41.497' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (757, 248, 93, CAST(N'2024-11-08T14:14:41.500' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (758, 260, 93, CAST(N'2024-11-08T14:14:41.500' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (759, 262, 93, CAST(N'2024-11-08T14:14:41.500' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (760, 263, 93, CAST(N'2024-11-08T14:14:41.503' AS DateTime), N'Present', CAST(N'2024-10-25T11:19:50.667' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (761, 16, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (762, 16, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (763, 16, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (764, 16, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (765, 17, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (766, 17, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (767, 17, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (768, 17, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (769, 133, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (770, 133, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (771, 133, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (772, 133, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (773, 134, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (774, 134, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (775, 134, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (776, 134, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (777, 135, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (778, 135, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (779, 135, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (780, 135, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (781, 136, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (782, 136, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (783, 136, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (784, 136, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (785, 137, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (786, 137, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (787, 137, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (788, 137, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (789, 138, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (790, 138, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (791, 138, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (792, 138, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (793, 139, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (794, 139, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (795, 139, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (796, 139, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (797, 248, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (798, 248, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (799, 248, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (800, 248, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (801, 260, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (802, 260, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (803, 260, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (804, 260, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (805, 262, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (806, 262, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (807, 262, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (808, 262, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (809, 263, 94, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (810, 263, 95, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (811, 263, 96, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (812, 263, 97, NULL, N'Future', CAST(N'2024-10-25T11:32:36.850' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (813, 29, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (814, 30, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (815, 31, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (816, 32, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (817, 33, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (818, 34, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (820, 249, 89, NULL, N'Future', CAST(N'2024-10-25T11:33:08.143' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (821, 10, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (822, 11, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (823, 12, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (824, 179, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (825, 180, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
GO
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (826, 181, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (827, 182, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (828, 183, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (829, 184, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (830, 185, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (831, 261, 98, NULL, N'Future', CAST(N'2024-10-25T11:36:32.117' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (832, 10, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (833, 11, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (834, 12, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (835, 179, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (836, 180, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (837, 181, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (838, 182, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (839, 183, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (840, 184, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (841, 185, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (842, 261, 99, NULL, N'Future', CAST(N'2024-10-25T11:39:36.937' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (846, 10, 80, CAST(N'2024-10-25T00:00:00.000' AS DateTime), N'Present', CAST(N'2024-10-25T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Attendance] ([AttendanceID], [EnrollmentID], [ScheduleID], [UpdatedAt], [Status], [CreatedAt], [Note]) VALUES (849, 43, 80, CAST(N'2024-10-25T16:52:30.200' AS DateTime), N'Present', CAST(N'2024-10-25T00:00:00.000' AS DateTime), N'string')
SET IDENTITY_INSERT [dbo].[Attendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (2, N'SE1708-NET', N'Software', N'Sep 20 2024  1:44PM', 9)
INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (3, N'SE1728', N'Software', N'Sep 20 2024  1:44PM', 10)
INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (4, N'SE1714-NJ', N'Software', N'Sep 20 2024  1:44PM', 10)
INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (8, N'SE1716-JS2', N'Software', N'Oct 10 2024  5:55PM', 10)
INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (25, N'SE13213', N'Software', N'Oct 18 2024 12:56AM', 10)
INSERT [dbo].[Classes] ([ClassID], [ClassCode], [ClassName], [Note], [SemesterID]) VALUES (27, N'SE1111', N'123', N'1', NULL)
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (1, N'PRM392', N'Mobile Programming', N'Mobile Programming(PRM392)
', 3, CAST(N'2024-09-20T13:44:06.270' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (2, N'PRN231', N'Building Cross-Platform Back-End Application With .NET', N'Building Cross-Platform Back-End Application With .NET(PRN231)
', 3, CAST(N'2024-09-20T13:44:06.270' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (3, N'HCM202', N'Ho Chi Minh Ideology', N'Ho Chi Minh Ideology(HCM202)
', 3, CAST(N'2024-09-20T13:44:06.270' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (5, N'PRN221', N'Advanced Cross-Platform Application Programming With .NET	', N'Advanced Cross-Platform Application Programming With .NET	', 3, CAST(N'2024-10-14T15:05:43.923' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (6, N'PMG201c', N'Project management	', N'Project management	', 3, CAST(N'2024-10-14T15:06:07.883' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (7, N'EXE101', N'Experiential Entrepreneurship 1	', N'Experiential Entrepreneurship 1	', 3, CAST(N'2024-10-14T15:06:17.403' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (8, N'PRU212', N'C# Programming and Unity	', N'C# Programming and Unity	', 3, CAST(N'2024-10-14T15:06:28.557' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [CourseCode], [CourseName], [Description], [DepartmentID], [CreatedAt]) VALUES (9, N'SWD392', N'SW Architecture and Design	', N'SW Architecture and Design	', 3, CAST(N'2024-10-14T15:06:38.953' AS DateTime))
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (1, N'Computer Science', N'Department of Computer Science', CAST(N'2024-09-20T13:43:50.607' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (2, N'Artificial Intelligence', N'Department of Mathematics', CAST(N'2024-09-20T13:43:50.607' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (3, N'Software Engineering', N'Software Engineering', CAST(N'2024-09-20T13:43:50.607' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (4, N'Business Administration', N'Business Administration', CAST(N'2024-10-10T18:01:48.710' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (5, N'Japanese', N'Japanese', CAST(N'2024-10-10T18:02:02.423' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Description], [CreatedAt]) VALUES (6, N'Multimedia Communications', N'Multimedia Communications', CAST(N'2024-10-10T18:02:07.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 

INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (10, 4, 3, N'Active', CAST(N'2024-09-20T13:49:37.283' AS DateTime), CAST(N'2024-09-20T13:49:37.283' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (11, 4, 21, N'Active', CAST(N'2024-10-08T23:06:52.387' AS DateTime), CAST(N'2024-10-08T23:06:52.500' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (12, 4, 22, N'Active', CAST(N'2024-10-08T23:06:52.390' AS DateTime), CAST(N'2024-10-08T23:06:52.517' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (16, 3, 23, N'Active', CAST(N'2024-10-10T20:37:09.433' AS DateTime), CAST(N'2024-10-10T20:37:09.537' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (17, 3, 24, N'Active', CAST(N'2024-10-10T20:37:09.433' AS DateTime), CAST(N'2024-10-10T20:37:09.557' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (29, 2, 8, N'Active', CAST(N'2024-10-10T20:55:09.757' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (30, 2, 10, N'Active', CAST(N'2024-10-10T20:55:09.760' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (31, 2, 19, N'Active', CAST(N'2024-10-10T20:55:09.760' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (32, 2, 25, N'Active', CAST(N'2024-10-10T20:55:09.760' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (33, 2, 51, N'Active', CAST(N'2024-10-10T20:55:09.760' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (34, 2, 20, N'Active', CAST(N'2024-10-10T20:55:09.760' AS DateTime), CAST(N'2024-10-10T20:55:09.777' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (43, 8, 1, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (44, 8, 3, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (45, 8, 8, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (46, 8, 10, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (47, 8, 19, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (48, 8, 25, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (49, 8, 51, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (50, 8, 20, NULL, CAST(N'2024-10-11T14:10:19.550' AS DateTime), CAST(N'2024-10-11T14:10:19.550' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (133, 3, 1, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (134, 3, 3, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (135, 3, 10, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (136, 3, 19, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (137, 3, 25, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (138, 3, 51, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (139, 3, 20, NULL, CAST(N'2024-10-11T17:26:17.867' AS DateTime), CAST(N'2024-10-11T17:26:17.867' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (179, 4, 25, N'Active', CAST(N'2024-10-17T12:13:35.300' AS DateTime), CAST(N'2024-10-17T12:13:35.303' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (180, 4, 20, N'Active', CAST(N'2024-10-17T23:58:34.057' AS DateTime), CAST(N'2024-10-17T23:58:34.133' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (181, 4, 14, N'Active', CAST(N'2024-10-17T23:59:50.127' AS DateTime), CAST(N'2024-10-17T23:59:50.130' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (182, 4, 8, N'Active', CAST(N'2024-10-18T00:17:51.720' AS DateTime), CAST(N'2024-10-18T00:17:51.787' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (183, 4, 55, N'Active', CAST(N'2024-10-18T00:18:11.857' AS DateTime), CAST(N'2024-10-18T00:18:11.853' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (184, 4, 1, N'Active', CAST(N'2024-10-18T00:20:39.680' AS DateTime), CAST(N'2024-10-18T00:20:39.680' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (185, 4, 19, N'Active', CAST(N'2024-10-18T00:34:02.123' AS DateTime), CAST(N'2024-10-18T00:34:02.193' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (232, 25, 23, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (233, 25, 24, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (234, 25, 76, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (236, 25, 78, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (237, 25, 79, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (238, 25, 80, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (239, 25, 1, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (240, 25, 10, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (241, 25, 19, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (242, 25, 25, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (243, 25, 51, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (244, 25, 20, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (246, 25, 21, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (247, 25, 14, NULL, CAST(N'2024-10-18T00:56:35.620' AS DateTime), CAST(N'2024-10-18T00:56:35.620' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (248, 3, 59, N'Active', CAST(N'2024-10-21T01:37:05.067' AS DateTime), CAST(N'2024-10-21T01:37:05.060' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (249, 2, 55, N'Active', CAST(N'2024-10-21T22:38:56.680' AS DateTime), CAST(N'2024-10-21T22:38:56.763' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (250, 27, 1, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (251, 27, 3, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (252, 27, 8, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (253, 27, 10, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (254, 27, 19, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (255, 27, 25, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (256, 27, 51, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (257, 27, 20, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (259, 27, 55, NULL, CAST(N'2024-10-21T23:35:03.850' AS DateTime), CAST(N'2024-10-21T23:35:03.850' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (260, 3, 14, N'Active', CAST(N'2024-10-23T22:23:59.447' AS DateTime), CAST(N'2024-10-23T22:23:59.453' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (261, 4, 59, N'Active', CAST(N'2024-10-23T22:27:13.837' AS DateTime), CAST(N'2024-10-23T22:27:13.837' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (262, 3, 61, N'Active', CAST(N'2024-10-25T10:43:38.610' AS DateTime), CAST(N'2024-10-25T10:43:38.617' AS DateTime))
INSERT [dbo].[Enrollments] ([EnrollmentID], [ClassID], [StudentID], [Status], [EnrolledAt], [CreatedAt]) VALUES (263, 3, 63, N'Active', CAST(N'2024-10-25T11:01:52.300' AS DateTime), CAST(N'2024-10-25T11:01:52.307' AS DateTime))
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedules] ON 

INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (8, 3, N'string', 3, 2, CAST(N'2024-10-16' AS Date), 2, 3, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (27, 3, N'DE-C301', 4, 2, CAST(N'2024-09-14' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (29, 2, N'DE-C302', 1, 2, CAST(N'2024-09-13' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (36, 2, N'DE-C301	', 4, 2, CAST(N'2024-09-18' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (39, 3, N'DE-301', 3, 2, CAST(N'2024-09-04' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (40, 3, N'DE-301', 4, 2, CAST(N'2024-09-06' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (41, 3, N'DE-301', 3, 2, CAST(N'2024-09-11' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (42, 3, N'DE-301', 4, 2, CAST(N'2024-09-13' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (44, 2, N'DE-C301', 3, 2, CAST(N'2024-10-14' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (45, 2, N'DE-C301	', 3, 2, CAST(N'2024-10-15' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (46, 2, N'DE-C301	', 4, 2, CAST(N'2024-10-16' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (47, 2, N'DE-C301	', 4, 2, CAST(N'2024-10-17' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (48, 2, N'DE-C301	', 4, 2, CAST(N'2024-10-19' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (49, 2, N'DE-C301	', 4, 2, CAST(N'2024-09-04' AS Date), 1, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (54, 8, N'A101', 1, 3, CAST(N'2024-10-15' AS Date), 7, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (55, 2, N'DE-C301	', 4, 2, CAST(N'2024-09-15' AS Date), 1, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (56, 2, N'DE-C301	', 4, 2, CAST(N'2024-10-23' AS Date), 1, 3, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (57, 2, N'DE-C301', 3, 2, CAST(N'2024-10-15' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (58, 2, N'DE-C301', 2, 2, CAST(N'2024-10-17' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (59, 2, N'DE-C301', 4, 2, CAST(N'2024-10-17' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (60, 4, N'A101', 1, 2, CAST(N'2024-10-17' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (61, 4, N'A101', 2, 2, CAST(N'2024-10-18' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (62, 4, N'A101', 3, 2, CAST(N'2024-10-19' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (63, 4, N'A101', 1, 2, CAST(N'2024-10-20' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (64, 4, N'A101', 3, 2, CAST(N'2024-10-22' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (65, 4, N'A101', 1, 2, CAST(N'2024-10-23' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (76, 25, N'EEss', 1, 2, CAST(N'2024-11-01' AS Date), 8, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (78, 3, N'DE-301', 3, 2, CAST(N'2024-11-02' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (79, 3, N'A102', 1, 2, CAST(N'2024-10-24' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (80, 3, N'string', 3, 2, CAST(N'2024-10-25' AS Date), 2, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (81, 3, N'A-102', 4, 2, CAST(N'2024-10-26' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (83, 3, N'123', 3, 2, CAST(N'2024-10-26' AS Date), 3, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (84, 4, N'A101', 1, 2, CAST(N'2024-10-27' AS Date), 3, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (85, 4, N'A101', 1, 2, CAST(N'2024-10-28' AS Date), 3, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (86, 3, N'BA', 4, 2, CAST(N'2024-12-07' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (87, 3, N'B2', 3, 2, CAST(N'2024-10-29' AS Date), 2, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (88, 3, N'AB', 4, 2, CAST(N'2024-10-30' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (89, 2, N'DE-C302', 1, 2, CAST(N'2024-10-01' AS Date), 3, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (90, 3, N'BE', 4, 2, CAST(N'2024-11-03' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (91, 3, N'B-202', 3, 2, CAST(N'2024-11-04' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (92, 3, N'DE-C302', 3, 2, CAST(N'2024-11-06' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (93, 3, N'BA-222', 3, 2, CAST(N'2024-11-08' AS Date), 2, NULL, N'Present')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (94, 3, N'a2', 3, 2, CAST(N'2024-11-09' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (95, 3, N'A2', 3, 2, CAST(N'2024-11-10' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (96, 3, N'stringa', 3, 2, CAST(N'2024-11-12' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (97, 3, N'string', 3, 2, CAST(N'2024-11-11' AS Date), 2, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (98, 4, N'A101', 1, 2, CAST(N'2024-11-01' AS Date), 9, NULL, N'Future')
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [Room], [TimeSlotID], [TeacherID], [Date], [CourseID], [SubstituteTeacherId], [Status]) VALUES (99, 4, N'A101', 1, 2, CAST(N'2024-11-02' AS Date), 9, NULL, N'Future')
SET IDENTITY_INSERT [dbo].[Schedules] OFF
GO
SET IDENTITY_INSERT [dbo].[Semesters] ON 

INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (1, N'Spring2022', CAST(N'2022-09-01' AS Date), CAST(N'2023-12-15' AS Date), CAST(N'2024-09-20T13:44:30.750' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (2, N'Summer2022', CAST(N'2024-01-15' AS Date), CAST(N'2024-05-15' AS Date), CAST(N'2024-09-20T13:44:30.750' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (4, N'Fall2022
', CAST(N'2022-09-01' AS Date), CAST(N'2022-12-01' AS Date), CAST(N'2024-10-19T00:41:28.253' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (5, N'Spring2023', CAST(N'2023-01-01' AS Date), CAST(N'2023-05-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (6, N'Summer2023', CAST(N'2023-06-01' AS Date), CAST(N'2023-08-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (7, N'Fall2023', CAST(N'2023-09-01' AS Date), CAST(N'2023-12-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (8, N'Spring2024', CAST(N'2024-01-01' AS Date), CAST(N'2024-05-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (9, N'Summer2024', CAST(N'2024-06-01' AS Date), CAST(N'2024-08-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Done')
INSERT [dbo].[Semesters] ([SemesterID], [SemesterName], [StartDate], [EndDate], [CreatedAt], [Status]) VALUES (10, N'Fall2024', CAST(N'2024-09-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2024-10-19T00:43:13.220' AS DateTime), N'Active')
SET IDENTITY_INSERT [dbo].[Semesters] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (1, 1, N'Nguyễn Thùy Dung', CAST(N'2024-10-10' AS Date), N'Male', N'st@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúcv', 2, N'no-image.jpg', CAST(N'2024-09-20T13:43:59.113' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (3, 2, N'Phạm Trần Hoàng Long', CAST(N'2000-03-30' AS Date), N'Male', N'charlie@example.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'anh3.jpg  ', CAST(N'2024-09-20T13:43:59.113' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (8, 3, N'Phạm Minh Đức', CAST(N'2024-10-05' AS Date), N'Male', N'charlise@example.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'anh4.jpg  ', CAST(N'2024-10-05T10:32:51.117' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (10, 4, N'Lê Thành Đạt 1', CAST(N'2024-11-22' AS Date), N'Male', N'charlise232@example.com', N'123123', N'1234124', N'Phúc Yên', 2, NULL, CAST(N'2024-10-05T10:33:48.293' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (12, 6, N'Phạm Minh Đức', CAST(N'2024-10-05' AS Date), N'Male', N'Anhhuydeptrai@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'anh7.jpg  ', CAST(N'2024-10-05T11:04:13.550' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (14, 7, N'Bùi Đoàn Hùng Sơn', CAST(N'2024-10-05' AS Date), N'Male', N'AHuyPro@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-05T11:08:46.987' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (17, 8, N'Nguyễn Xuân Hoàng', CAST(N'2024-10-05' AS Date), N'Male', N'AHuyPro21@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'anh9.jpg  ', CAST(N'2024-10-05T11:09:46.603' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (19, 9, N'Bùi Trung Thịnh', CAST(N'2024-10-05' AS Date), N'Male', N'AHuyPro211@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 1, N'no-image.jpg', CAST(N'2024-10-05T11:10:04.583' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (20, 10, N'Vương Kiên Trung', CAST(N'2024-10-05' AS Date), N'male', N'anha@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-05T11:17:42.753' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (21, 11, N'Phạm Văn	 Mạnh', CAST(N'2024-10-05' AS Date), N'male', N'anh2a@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-05T11:18:16.487' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (22, 12, N'Trần Thị Thuỳ Dung', CAST(N'2024-10-05' AS Date), N'male', N'anh22a@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-05T11:21:19.763' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (23, 13, N'Nguyễn Công Tuyền', CAST(N'2024-10-05' AS Date), N'male', N'anh22aSSS@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-05T11:21:41.467' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (24, 14, N'Đào Quang Duy', CAST(N'2002-10-05' AS Date), N'Male', N'huygoku37@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-05T16:11:41.467' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (25, 15, N'Phạm Đình Huy', CAST(N'2024-10-10' AS Date), N'Male', N'huygoku327@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-05T16:12:30.280' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (31, 16, N'Nguyễn Văn Khánh', CAST(N'2024-10-09' AS Date), N'Male', N'huygoku13227@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 1, N'no-image.jpg', CAST(N'2024-10-05T16:18:31.790' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (50, 17, N'Nguyễn Quốc Tuyên', CAST(N'2024-10-05' AS Date), N'male', N'sds32@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-05T16:56:44.477' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (51, 18, N'Đào Thế Anh', CAST(N'2024-10-05' AS Date), N'male', N'sds322@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-05T16:58:51.740' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (55, 19, N'Trần Văn Hoàng', CAST(N'2024-10-05' AS Date), N'male', N'sds32222@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 1, N'no-image.jpg', CAST(N'2024-10-05T17:00:26.593' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (59, 20, N'Nguyễn Văn Hoàng', CAST(N'2024-10-07' AS Date), N'Male', N'huypdhe@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 3, N'no-image.jpg', CAST(N'2024-10-07T08:27:28.030' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (61, 21, N'Phạm Duy	 Khanh', CAST(N'2024-10-09' AS Date), N'Male', N'huygoku3227@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-07T08:29:31.210' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (63, 22, N'Nguyễn Bình Minh', NULL, N'Male', N'huygoku322227@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 1, N'no-image.jpg', CAST(N'2024-10-07T08:32:09.540' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (76, 23, N'Văn Công Quang Minh', CAST(N'2024-10-07' AS Date), N'Male', N'23@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-07T08:50:31.950' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (78, 25, N'Phạm Đình Huy', CAST(N'2024-10-18' AS Date), N'Female', N'huygok22u327@Gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 2, N'no-image.jpg', CAST(N'2024-10-07T09:52:46.240' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (79, 26, N'Nguyễn Duy Đức Chính', NULL, N'Male', N'chinhndgt@gmail.com', N'123', N'123412415', N'1231312', 2, N'no-image.jpg', CAST(N'2024-10-07T09:56:56.803' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (80, 27, N'Vũ Xuân Anh', NULL, N'Male', N'2g@gmail.com', N'123', N'123412415', N'Phúc Yên Vĩnh Phúc', 1, N'no-image.jpg', CAST(N'2024-10-07T09:59:29.237' AS DateTime))
INSERT [dbo].[Students] ([StudentID], [StudentCode], [FullName], [DateOfBirth], [Gender], [Email], [Password], [PhoneNumber], [Address], [DepartmentID], [Avatar], [CreatedAt]) VALUES (87, 29, N'binhminhnguyen', CAST(N'2024-11-19' AS Date), N'Male', N'minh12@gmail.com', N'123', N'123123', N'Hà Nội', 2, NULL, CAST(N'2024-11-08T14:08:07.103' AS DateTime))
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 

INSERT [dbo].[Teachers] ([TeacherID], [Username], [Password], [Avatar], [FullName], [Email], [Role], [CreatedAt]) VALUES (1, N'admin', N'123', NULL, N'Admin User', N'admin@gmail.com', N'admin', CAST(N'2024-09-20T13:43:55.120' AS DateTime))
INSERT [dbo].[Teachers] ([TeacherID], [Username], [Password], [Avatar], [FullName], [Email], [Role], [CreatedAt]) VALUES (2, N'huypd', N'123', NULL, N'Phạm Huy', N'huypd@gmail.com', N'teacher', CAST(N'2024-09-20T13:43:55.120' AS DateTime))
INSERT [dbo].[Teachers] ([TeacherID], [Username], [Password], [Avatar], [FullName], [Email], [Role], [CreatedAt]) VALUES (3, N'hungtd', N'123', NULL, N'Trần Hùng', N'1232@gmail.com', N'teacher', CAST(N'2024-09-20T13:43:55.120' AS DateTime))
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
INSERT [dbo].[TimeSlots] ([TimeSlotID], [StartTime], [EndTime]) VALUES (1, CAST(N'07:30:00' AS Time), CAST(N'10:00:00' AS Time))
INSERT [dbo].[TimeSlots] ([TimeSlotID], [StartTime], [EndTime]) VALUES (2, CAST(N'10:10:00' AS Time), CAST(N'12:20:00' AS Time))
INSERT [dbo].[TimeSlots] ([TimeSlotID], [StartTime], [EndTime]) VALUES (3, CAST(N'12:50:00' AS Time), CAST(N'15:10:00' AS Time))
INSERT [dbo].[TimeSlots] ([TimeSlotID], [StartTime], [EndTime]) VALUES (4, CAST(N'15:20:00' AS Time), CAST(N'17:40:00' AS Time))
GO
/****** Object:  Index [UQ_Attendance]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [UQ_Attendance] UNIQUE NONCLUSTERED 
(
	[EnrollmentID] ASC,
	[ScheduleID] ASC,
	[UpdatedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Courses__FC00E000D16F3CA2]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Courses] ADD UNIQUE NONCLUSTERED 
(
	[CourseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_courses_departmentid]    Script Date: 11/09/2024 3:09:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_courses_departmentid] ON [dbo].[Courses]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Departme__D949CC345BE9D018]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Departments] ADD UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Enrollment]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Enrollments] ADD  CONSTRAINT [UQ_Enrollment] UNIQUE NONCLUSTERED 
(
	[ClassID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_enrollments_classid]    Script Date: 11/09/2024 3:09:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_enrollments_classid] ON [dbo].[Enrollments]
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_enrollments_studentid]    Script Date: 11/09/2024 3:09:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_enrollments_studentid] ON [dbo].[Enrollments]
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_schedules_classid]    Script Date: 11/09/2024 3:09:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_schedules_classid] ON [dbo].[Schedules]
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Semester__7B4EBE0F9312E74C]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Semesters] ADD UNIQUE NONCLUSTERED 
(
	[SemesterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Students__1FC886040E94B7BF]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [UQ__Students__1FC886040E94B7BF] UNIQUE NONCLUSTERED 
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Students__A9D10534612CEFAB]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [UQ__Students__A9D10534612CEFAB] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_students_departmentid]    Script Date: 11/09/2024 3:09:18 PM ******/
CREATE NONCLUSTERED INDEX [idx_students_departmentid] ON [dbo].[Students]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4856C1F7A]    Script Date: 11/09/2024 3:09:18 PM ******/
ALTER TABLE [dbo].[Teachers] ADD  CONSTRAINT [UQ__Users__536C85E4856C1F7A] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [DF_Attendance_Status]  DEFAULT (N'Future') FOR [Status]
GO
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [DF__Attendanc__Recor__123EB7A3]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Classes] ADD  CONSTRAINT [DF__Classes__Created__4F7CD00D]  DEFAULT (getdate()) FOR [Note]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Departments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Enrollments] ADD  CONSTRAINT [DF__Enrollmen__Enrol__5BE2A6F2]  DEFAULT (getdate()) FOR [EnrolledAt]
GO
ALTER TABLE [dbo].[Enrollments] ADD  CONSTRAINT [DF__Enrollmen__Creat__5CD6CB2B]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Semesters] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF__Students__Create__4222D4EF]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Teachers] ADD  CONSTRAINT [DF__Users__CreatedAt__38996AB5]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK__Attendanc__Enrol__1332DBDC] FOREIGN KEY([EnrollmentID])
REFERENCES [dbo].[Enrollments] ([EnrollmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK__Attendanc__Enrol__1332DBDC]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK__Attendanc__Sched__14270015] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedules] ([ScheduleID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK__Attendanc__Sched__14270015]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Semesters] FOREIGN KEY([SemesterID])
REFERENCES [dbo].[Semesters] ([SemesterID])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Semesters]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK__Enrollmen__Class__5DCAEF64] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Classes] ([ClassID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK__Enrollmen__Class__5DCAEF64]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK__Enrollmen__Stude__5EBF139D] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([StudentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK__Enrollmen__Stude__5EBF139D]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK__Schedules__Class__5812160E] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Classes] ([ClassID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK__Schedules__Class__5812160E]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_Courses] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_Courses]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_SubstituteTeachers] FOREIGN KEY([SubstituteTeacherId])
REFERENCES [dbo].[Teachers] ([TeacherID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_SubstituteTeachers]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_TimeSlots] FOREIGN KEY([TimeSlotID])
REFERENCES [dbo].[TimeSlots] ([TimeSlotID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_TimeSlots]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_Users] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teachers] ([TeacherID])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_Users]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [CK_Attendance_Status] CHECK  (([Status]='Future' OR [Status]='Present' OR [Status]='Absent' OR [Status]='Late' OR [Status]='Excused'))
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [CK_Attendance_Status]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [CK__Students__Gender__412EB0B6] CHECK  (([Gender]='Other' OR [Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [CK__Students__Gender__412EB0B6]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [CK__Users__Role__37A5467C] CHECK  (([Role]='teacher' OR [Role]='admin'))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [CK__Users__Role__37A5467C]
GO
/****** Object:  StoredProcedure [dbo].[CreateAttendanceForClass]    Script Date: 11/09/2024 3:09:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateAttendanceForClass]
    @ScheduleID INT -- Khai báo tham số với kiểu dữ liệu INT
AS
BEGIN
    SET NOCOUNT ON; -- Ngăn chặn thông báo số hàng bị ảnh hưởng

    -- Thêm bản ghi điểm danh cho tất cả sinh viên có trong lớp học
    INSERT INTO Attendance (EnrollmentID, ScheduleID, Status, CreatedAt)
    SELECT 
        E.EnrollmentID,  -- Lấy EnrollmentID từ bảng Enrollment
        @ScheduleID,     -- Sử dụng ScheduleID từ tham số đầu vào
        'Future',        -- Trạng thái mặc định là 'Future'
        GETDATE()       -- Ghi lại thời gian hiện tại
    FROM 
        Enrollments E
    INNER JOIN 
        Schedules S ON S.ScheduleID = @ScheduleID  -- Kết nối với bảng Schedule để lấy thông tin lịch học
    WHERE 
        E.ClassID = S.ClassID;  -- Điều kiện liên kết lớp học
END
EXEC CreateAttendanceForClass @ScheduleID = 8;
GO
/****** Object:  StoredProcedure [dbo].[CreateAttendanceForClasss]    Script Date: 11/09/2024 3:09:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateAttendanceForClasss]
    @ScheduleID INT -- Khai báo tham số với kiểu dữ liệu INT
AS
BEGIN
    SET NOCOUNT ON; -- Ngăn chặn thông báo số hàng bị ảnh hưởng

    -- Thêm bản ghi điểm danh cho tất cả sinh viên có trong lớp học, nếu chưa tồn tại
    INSERT INTO Attendance (EnrollmentID, ScheduleID, Status, CreatedAt)
    SELECT 
        E.EnrollmentID,  -- Lấy EnrollmentID từ bảng Enrollment
        @ScheduleID,     -- Sử dụng ScheduleID từ tham số đầu vào
        'Future',        -- Trạng thái mặc định là 'Future'
        GETDATE()       -- Ghi lại thời gian hiện tại
    FROM 
        Enrollments E
    INNER JOIN 
        Schedules S ON S.ScheduleID = @ScheduleID  -- Kết nối với bảng Schedule để lấy thông tin lịch học
    WHERE 
        E.ClassID = S.ClassID -- Điều kiện liên kết lớp học
        AND NOT EXISTS (
            SELECT 1
            FROM Attendance A
            WHERE A.EnrollmentID = E.EnrollmentID
            AND A.ScheduleID = @ScheduleID
        ); -- Điều kiện kiểm tra sự tồn tại của bản ghi trong bảng Attendance
END
GO
USE [master]
GO
ALTER DATABASE [StudentAttendanceDB] SET  READ_WRITE 
GO
