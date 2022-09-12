USE [master]

CREATE DATABASE [Fakultet]
GO

USE [Fakultet]

/***Pravljenje tabele Predmet ***/
CREATE TABLE [dbo].[Student](
	[BI] [int] NOT NULL,
	[Grupa_ID] [int] NOT NULL,
	[Ime_Prezime] [nvarchar](50) NOT NULL,
	[Godina_Studija] [int] NOT NULL,
	[Datum_Rodjenja] [date] NOT NULL,
	[Grad] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/* Pravljenje tabele Predmet */
CREATE TABLE [dbo].[Predmet](
	[Predmet_ID] [int] NOT NULL,
	[Naziv_Predmeta] [nvarchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[Predmet_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*Pravljenje tabele Ispit */
CREATE TABLE [dbo].[Ispit](
	[BI] [int] NOT NULL,
	[Predmet_ID] [int] NOT NULL,
	[Ocena] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Ispit]  WITH CHECK ADD  CONSTRAINT [ispit_fk_1] FOREIGN KEY([BI])
REFERENCES [dbo].[Student] ([BI])
GO

ALTER TABLE [dbo].[Ispit] CHECK CONSTRAINT [ispit_fk_1]
GO

ALTER TABLE [dbo].[Ispit]  WITH CHECK ADD  CONSTRAINT [ispit_fk_2] FOREIGN KEY([Predmet_ID])
REFERENCES [dbo].[Predmet] ([Predmet_ID])
GO

ALTER TABLE [dbo].[Ispit] CHECK CONSTRAINT [ispit_fk_2]
GO

INSERT INTO [dbo].[Student]
           ([BI]
           ,[Grupa_ID]
           ,[Ime_Prezime]
           ,[Godina_Studija]
           ,[Datum_Rodjenja]
           ,[Grad])
     VALUES
           (20110234,1,'Petar Milosavljevic',4,'1992-10-13','Beograd'),
           (20130110,1,'Marija Mikic',4,'1994-02-05','Beograd'),
           (20140098,1,'Ana Savic',4,'1995-07-16','Novi Sad'),
           (20180013,3,'Jasmina Borisavljevic',3,'1999-09-19','Beograd'),
           (20190264,3,'Andrija Nestorovic',3,'2000-03-27','Nis'),
           (20190542,3,'Nikolija Dragic',3,'2000-12-10','Subotica'),
           (20200056,2,'Sofija Radovic',2,'2001-09-20','Kragujevac'),
           (20220205,2,'Marko Jankovic',1,'2003-05-26','Beograd'),
           (20220782,2,'Nikola Stojsavljevic',1,'2003-01-30','Cacak')
GO

INSERT INTO [dbo].[Predmet]
           ([Predmet_ID]
           ,[Naziv_Predmeta])
     VALUES
           (1,'Matematika'),
           (2,'Statistika'),
           (3,'Ekonomija'),
           (4,'Finansijski menadzment'),
           (5,'Osnove programiranja'),
           (6,'Simulacije i simulacioni jezici')
GO

INSERT INTO [dbo].[Ispit]
           ([BI]
           ,[Predmet_ID]
           ,[Ocena])
     VALUES
           (20130110,1,5),
           (20130110,3,6),
           (20130110,4,8),
           (20140098,2,9),
           (20140098,5,9),
           (20180013,2,6),
           (20180013,4,6),
           (20180013,6,7),
           (20190542,1,7),
           (20190542,4,7),
           (20190542,5,8),
           (20190264,5,8),
           (20190264,6,6),
           (20200056,1,6),
           (20200056,2,6),
           (20200056,3,6),
           (20220205,3,7),
           (20220205,5,9),
           (20220782,4,5),
           (20220782,5,8),
           (20220782,6,8)
GO


select *
from Student
where Datum_Rodjenja in(select min(datum_rodjenja)
						from Student
						group by Grupa_ID)
group by bi,grupa_id, Ime_Prezime, Godina_Studija, Grad, Datum_Rodjenja
