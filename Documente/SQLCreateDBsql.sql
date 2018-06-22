use [Licenta]
go

IF OBJECT_ID('dbo.RightResults') IS NOT NULL
    DROP TABLE dbo.RightResults;
go
IF OBJECT_ID('dbo.Car') IS NOT NULL
    DROP TABLE dbo.Car;
go
IF OBJECT_ID('dbo.Query') IS NOT NULL
    DROP TABLE dbo.Query;
go
IF OBJECT_ID('dbo.QueryLatency') IS NOT NULL
    DROP TABLE dbo.QueryLatency;
go
IF OBJECT_ID('dbo.DataEvent') IS NOT NULL
    DROP TABLE dbo.DataEvent;
go
IF OBJECT_ID('dbo.AproximateResult') IS NOT NULL
    DROP TABLE dbo.AproximateResult;
go
IF OBJECT_ID('dbo.insertEventData') IS NOT NULL
    DROP proc dbo.insertEventData;
go
create table RightResults(
idResult int primary key identity(1,1),
timestmp int,
roadSegment int,
avreage float
)
go
create table Car(
 IdCar int primary key identity(1,1),
 TimeStmp int,
 RoadSegment varchar(50) not null,
 Speed float
)
go
create table DataEvent(
IdDataEvent int primary key identity(1,1),
ActivityCode int ,
StartTime datetime,
StatusEvent varchar(50) not null
)
go
create table Query (
IdQuery int primary key identity(1,1),
TimeStQ int, 
Avreage float,
GroupId int,
)
go
create table AproximateResult(
IdQuery int primary key identity(1,1),
WindowDim int,
GroupId int,
Avreage float

)
go
create table QueryLatency(
IdQueryLatency int primary key identity(1,1),
dimSize int,
KeyQL nvarchar(100),
ValueQL float
)
go

