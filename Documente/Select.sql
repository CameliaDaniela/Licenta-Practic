--selectarea mediei in mod static pentru un anumit timestamp
select  c.RoadSegment,avg( c.Speed) as SpeedSegment 
from Car c
where c.TimeStmp=1
group by  c.RoadSegment
go
--selectarea timestamp-ului maxim pentru a putea vedea cate tsmpuri au fost
select MAX(TimeStmp)
FROM Car
go

select*from Car
where RoadSegment=5
go


select * from AproximateResult
go
--see real final result
select  c.RoadSegment,avg( c.Speed) as SpeedSegment 
from Car c
group by  c.RoadSegment
go

--see the aproximative final result
select  c.GroupId,avg( c.Avreage) as SpeedSegment 
from Query c
where c.TimeStQ <2
group by c.GroupId
go
--SELECT PROJECT JOIN AGGREGATE GROUP
exec aproximate_result @maxTimeStmp= 30, @tip='SPJAG'
go
exec right_result @maxTimeStmp= 50, @tip='SPJAG'
go
--SELECT PROJECT JOIN AGGREGATE
exec aproximate_result @maxTimeStmp= 30, @tip='SPJA'
go
exec right_result @maxTimeStmp= 50, @tip='SPJA'
go
select * from Query
select * from Car
where Speed<50
