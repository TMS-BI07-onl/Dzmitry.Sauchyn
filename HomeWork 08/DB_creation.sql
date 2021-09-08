/*
Создаем таблицу Trainers. Информация о тренере.
*/
CREATE TABLE Trainers (
    [TrainerID] int IDENTITY(1,1),
	[FirstName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	[Gender] nvarchar(10) NOT NULL,
	[BirthDate] date,
	[PassportNumber] varchar(20) UNIQUE NOT NULL,
	[CareerStart] date,
	[Rank] nvarchar(10),
	[Country] nvarchar(20) NOT NULL,
	PRIMARY KEY (TrainerID)
);

/*
Создаем таблицу Swimmers. Информация о плавце.
*/
CREATE TABLE Swimmers (
    [SwimmerID] int IDENTITY(1,1),
	[FirstName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	[Gender] nvarchar(10) NOT NULL,
	[BirthDate] date,
	[PassportNumber] varchar(20) UNIQUE NOT NULL,
	[TrainerID] int,
	[CareerStart] date,
	[Rank] nvarchar(10),
	[Country] nvarchar(20) NOT NULL,
	[DopingRec] bit NOT NULL,
	PRIMARY KEY (SwimmerID)
);

/*
Создаем таблицу Competitions. Соревнования.
*/
CREATE TABLE Competitions (
    [CompetitionID]  int IDENTITY(1,1),
	[CompetitionDate] date NOT NULL,
	[SwimmerID] int,
	[StyleID] nvarchar(10),
	[ResultTime] time, --это время заплыва?
	[DisqID] int, --это что?
	[PoolID] int,
	PRIMARY KEY (CompetitionID)
);

/*
Создаем таблицу SwimmingPools. Бассейны.
*/
CREATE TABLE SwimmingPools (
    [SwimmingPoolID]  int IDENTITY(1,1),
	[SwimmingPoolName] nvarchar(50) NOT NULL,
	[Country] nvarchar(20) NOT NULL,
	[City] nvarchar(20) NOT NULL,
	[Address] nvarchar(20) NOT NULL,
	PRIMARY KEY (SwimmingPoolID)
);

/*
Создаем таблицу Styles. Информация о стилях плавания.
*/
CREATE TABLE Styles (
    [StyleID] int IDENTITY(1,1),
	[Style] nvarchar(20) NOT NULL,
	[Distance] int,
	PRIMARY KEY (StyleID)
);

/*
Создаем таблицу Disqualification. Информация о дисквалификации.
*/
CREATE TABLE Disqualification (
    [DisqualificationID] int IDENTITY(1,1),
	[Term] decimal(5,2) NOT NULL,
	[Reason] nvarchar(40),
	PRIMARY KEY (DisqualificationID)
);

/*
Создаем таблицу SponsorPayments. Информация о спонсорских платежах.
*/
CREATE TABLE SponsorPayments (
    [SponsorPaymentsID] int IDENTITY(1,1),
	[CompetitionID] int,
	[SponsorID] int,
	[SumMoney] money NOT NULL,
	[PayDate] date NOT NULL
	PRIMARY KEY (SponsorPaymentsID)
);

/*
Создаем таблицу Sponsors. Информация о спонсорах.
*/
CREATE TABLE Sponsors (
    [SponsorID] int IDENTITY(1,1),
	[CompetitionID] int,
	[FirstName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	PRIMARY KEY (SponsorID)
);





/*
Добавляем FK
*/

ALTER TABLE [dbo].[Swimmers]
ADD CONSTRAINT [swimmers_trainerid_fk]
FOREIGN KEY (TrainerId) REFERENCES Trainers (TrainerID)

ALTER TABLE [dbo].[SponsorPayments]
ADD CONSTRAINT [sponsorpayments_competitionid_fk]
FOREIGN KEY (CompetitionID) REFERENCES Competitions (CompetitionID)

ALTER TABLE [dbo].[SponsorPayments]
ADD CONSTRAINT [sponsorpayments_sponsors_fk]
FOREIGN KEY (SponsorID) REFERENCES Sponsors (SponsorID)

ALTER TABLE [dbo].[Competitions]
ADD CONSTRAINT [swimmer_competitions_fk]
FOREIGN KEY (SwimmerID) REFERENCES Swimmers (SwimmerID)