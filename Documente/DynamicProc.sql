--crearea unei proceduri care sa aduca rezultatul aproximat pentru toate dimensiunile de la 
IF OBJECT_ID('dbo.aproximate_result') IS NOT NULL
    DROP proc dbo.aproximate_result;
go
create proc aproximate_result  @maxTimeStmp int, @tip nvarchar(40)
as
begin
	DECLARE @sqlCommand nvarchar(1000), @sqlCommandInsert nvarchar(1000),@column nvarchar(75),@table nvarchar(100), @tsmp int
	DECLARE @IntVariable int, @whereClause varchar(100), @cnt int = 1, @groupByClause nvarchar(100),@aggreagteClause nvarchar(100)
	SET @column = ' GroupId '
	SET @table=' AproximateResult '
	set @whereClause =' WHERE TimeStQ < @tsmp '
	set @groupByClause =' GROUP BY '+ @column
	set @aggreagteClause =', AVG( Avreage) as aprox_avg_speed FROM Query '
	if(@tip='SPJAG')--select, project, join aggregate and group
	begin
		SET @sqlCommand = 'SELECT @tsmp-1,' + @column + @aggreagteClause + @whereClause + @groupByClause
	end
	if(@tip='SPJA')--select, project, join aggregate 
	begin
		SET @sqlCommand = 'SELECT @tsmp-1,1 ' + @aggreagteClause + @whereClause 
	end

	SET @sqlCommandInsert = 'INSERT INTO ' + @table + ' ' +@sqlCommand
	SET @IntVariable = 2;  
	while @cnt < @maxTimeStmp
	begin
		SET @cnt = @cnt + 1;
		EXECUTE sp_executesql @sqlCommandInsert, N'@tsmp int', @tsmp = @cnt
	end
end
go
IF OBJECT_ID('dbo.right_result') IS NOT NULL
    DROP proc dbo.right_result;
go
create proc right_result  @maxTimeStmp int, @tip nvarchar(40)
as
begin
	DECLARE @sqlCommand nvarchar(1000), @sqlCommandInsert nvarchar(1000),@column nvarchar(75),@table nvarchar(100), @tsmp int
	DECLARE @IntVariable int, @whereClause varchar(100), @cnt int = 0, @groupByClause nvarchar(100),@aggreagteClause nvarchar(100)
	SET @column = ' RoadSegment '--column for group by
	SET @table=' RightResults '--table to insert
	set @whereClause =' WHERE TimeStmp = @tsmp '
	set @groupByClause =' GROUP BY '+ @column
	set @aggreagteClause =', AVG( Speed) as right_avg_speed FROM Car '
	if(@tip='SPJAG')--select, project, join aggregate and group
	begin
		SET @sqlCommand = 'SELECT @tsmp,' + @column + @aggreagteClause + @whereClause + @groupByClause
	end
	if(@tip='SPJA')--select, project, join aggregate 
	begin
		SET @sqlCommand = 'SELECT @tsmp,1 ' + @aggreagteClause + @whereClause 
	end

	SET @sqlCommandInsert = 'INSERT INTO ' + @table + ' ' +@sqlCommand

	while @cnt < @maxTimeStmp
	begin
		SET @cnt = @cnt + 1;
		EXECUTE sp_executesql @sqlCommandInsert, N'@tsmp int', @tsmp = @cnt
	end
end
go
IF OBJECT_ID('dbo.final_resutls') IS NOT NULL
    DROP proc dbo.final_resutls;
go
create proc final_resutls 
as
begin
	DECLARE @rightAvg float,@appResult float, @avgRes float=0, @dims int,@ct int=1,@abs float
	SET @rightAvg= (SELECT AVG(avreage) from RightResults)
	SET @dims= (SELECT MAX(WindowDim) from AproximateResult)
	while @ct<= @dims
	begin
		--PRINT @ct
		SET @appResult =(select AVG(Avreage) from AproximateResult where WindowDim=@ct)
		if @rightAvg>@appResult
		begin
			SET @abs = @rightAvg-@appResult
		end
		if @rightAvg<@appResult
		begin
			SET @abs = @appResult-@rightAvg
		end
		SET @avgRes=@avgRes +@abs
		SET @ct=@ct+1
	end
	PRINT @avgRes/(@ct-1)
end
go

exec final_resutls
select keyQL,AVG(ValueQL) from QueryLatency 
group by KeyQL
go
