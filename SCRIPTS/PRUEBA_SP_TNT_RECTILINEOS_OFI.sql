
DECLARE @PED CHAR(8), @CLI CHAR(5), @ART CHAR(25)
SET @CLI='0001'
SET @art = '9000170108000100'
    -- Insert statements for procedure here
DECLARE  @id int, @tal varchar(5), @TEL VARCHAR(25), @OFI CHAR(8),@T0 varCHAR(5),@DES VARCHAR(200),@C0 NUMERIC(12,3)
DECLARE @T1 varCHAR(5), @T2 varCHAR(5),@T3 varCHAR(5),@T4 varCHAR(5),@T5 varCHAR(5),@T6 varCHAR(5),@T7 varCHAR(5),@T8 varCHAR(5),@T9 varCHAR(5)
DECLARE @POS VARCHAR(MAX), @fil varchar(10)
DECLARE @QUERY VARCHAR(1255),@query2 varchar(2000)



CREATE TABLE [dbo].[#TMP1](
	[CLI]		CHAR(5)	,
	[OFI]		CHAR(8),
	[TELA]		char(25),
	[DESCRI]	VARCHAR(200),
	[Row#]		varchar(10))

SELECT Talla, Orden  INTO #TMP2 FROM CLIENTE_TALLA
WHERE (CodCliente = @cli) AND ESTADO = 'A'
ORDER BY Orden
--select * from #tmp2
-- BARRE LA TABLA QUE TIENE TODAS LAS TALLAS
WHILE (EXISTS(SELECT top 1 ORDEN FROM #TMP2 order by orden )) -- PRIME WHILE 
	BEGIN
		SET @ID	   = (SELECT TOP 1 ORDEN FROM  #TMP2  ORDER BY orden)
		SET @tal   = CONVERT(CHAR(5),(SELECT TOP 1 talla FROM #TMP2 WHERE orden = @id )) -- va buscando las tallas
		SET @QUERY = 'ALTER TABLE #tmp1 ADD [' + LTRIM(RTRIM(@tal)) + '] numeric(12)'
		exec(@query)	
				
		DELETE #TMP2 WHERE orden = @id 
	END -- PRIMER WHILE 
-- #tmp1 es la tabla que tiene las tallas en columnas 
-- select * from tempo
SELECT DISTINCT ET.OFI,ROW_NUMBER() OVER(ORDER BY et.ofi,tela) AS Row#,  c0=(ceiling(CAN0*1.05*canpza)) , c1=(ceiling(CAN1*1.05*canpza)), c2=(ceiling(CAN2*1.05*canpza)),
c3=(ceiling(CAN3*1.05*canpza)), c4=(ceiling(CAN4*1.05*canpza)), c5=(ceiling(CAN5*1.05*canpza)), c6=(ceiling(CAN6*1.05*canpza)), 
c7=(ceiling(CAN7*1.05*canpza)), c8=(ceiling(CAN8*1.05*canpza)), c9=(ceiling(CAN9*1.05*canpza)), tela, AR_CDESCRI , t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
INTO #TMP3
FROM [PO-DETA] PD 
INNER JOIN EXPLOSION_TELA ET ON REPLACE(PD.PO,' ' ,'') = REPLACE(ET.PO,' ' , '') AND PD.UBI =ET.UBI
INNER JOIN RSFACCAR..AL0001ARTI AR ON AR_CCODIGO COLLATE SQL_Latin1_General_CP1_CI_AI= TELA
inner join view_pedido_tela_deta vp on vp.codigo = et.crudo AND vp.OFI= ET.OFI
WHERE LEFT(TELA,1) ='9' AND et.OFI = (select OFIs from TEMPO where ET.OFI = ofis)
group by TELA, AR_CDESCRI , can0, can1, can2,can3,can4, can5, can6, can7, can8, can9,canpza, t0,t1,t2,t3,t4,t5,t6,t7,t8,t9, ET.OFI
order by OFI, tela
--SELECT * FROM #TMP3
-- TENGO LAS OFI's QUE VOY A AGRUPAR Y LAS GUARDO EN EL #TMP2
WHILE (EXISTS(SELECT top 1 OFI,TELA FROM #TMP3 order by Row# )) -- SEGUNDO WHILE 
	BEGIN
		SET @fil	= (SELECT TOP 1 Row#			   FROM  #TMP3  ORDER BY Row#)
		SET @TEL	= (SELECT TOP 1 LTRIM(RTRIM(TELA)) FROM  #TMP3  ORDER BY Row#) -- la TELA
		SET @PED	= (SELECT TOP 1 LTRIM(RTRIM(OFI))  FROM  #TMP3  ORDER BY Row#) -- la OFI
		SET @DES	= (SELECT TOP 1 AR_CDESCRI		   FROM  #TMP3  ORDER BY Row#) -- la DESCRIPCION DE LA TELA
		SET @T0		= (SELECT TOP 1 ltrim(rtrim(T0))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T1		= (SELECT TOP 1 ltrim(rtrim(T1))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T2		= (SELECT TOP 1 ltrim(rtrim(T2))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T3		= (SELECT TOP 1 ltrim(rtrim(T3))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T4		= (SELECT TOP 1 ltrim(rtrim(T4))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T5		= (SELECT TOP 1 ltrim(rtrim(T5))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T6		= (SELECT TOP 1 ltrim(rtrim(T6))   FROM  #TMP3  ORDER BY row#)-- va buscando las tallas
		SET @T7		= (SELECT TOP 1 ltrim(rtrim(T7))   FROM  #TMP3  ORDER BY Row#)-- va buscando las tallas
		SET @T8		= (SELECT TOP 1 ltrim(rtrim(T8))   FROM  #TMP3  ORDER BY Row#)-- va buscando las tallas
		SET @T9		= (SELECT TOP 1 ltrim(rtrim(T9))   FROM  #TMP3  ORDER BY Row#)-- va buscando las tallas
	
		SET @QUERY2 = 'INSERT INTO #TMP1 (CLI,OFI, TELA, DESCRI, row#,['+@t0+'])'		
		set @query2 = @query2 + 'VALUES('''+ @cli+''','''+@PED+''','''+@TEL+''','''+@DES+''','''+@fil+''','
		set @query2 = @query2 +'(SELECT C0 FROM  #TMP3  where row#='+@fil+'))'
		EXEC (@QUERY2)
		if len(@t1) > 0 
			SET @query2 = 'UPDATE #TMP1 SET [' +@T1+ '] = '+ '(SELECT C1 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)											  
		if LEN(@t2) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T2+ '] = '+ '(SELECT C2 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t3) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T3+ '] = '+ '(SELECT C3 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t4) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T4+ '] = '+ '(SELECT C4 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t5) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T5+ '] = '+ '(SELECT C5 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t6) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T6+ '] = '+ '(SELECT C6 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t7) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T7+ '] = '+ '(SELECT C7 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t8) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T8+ '] = '+ '(SELECT C8 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)
		if LEN(@t9) > 0
			SET @query2 = 'UPDATE #TMP1 SET [' +@T9+ '] = '+ '(SELECT C9 FROM  #TMP3  WHERE row#='+@fil+') where row#=' + @fil
			EXEC (@QUERY2)		
		DELETE #TMP3 WHERE Row#=@fil
	END -- SEGUNDO WHILE 

SELECT * FROM #TMP1
insert INTO #TMP2 select Talla, Orden  FROM CLIENTE_TALLA
WHERE (CodCliente = @cli) AND ESTADO = 'A'
ORDER BY Orden
set @QUERY = 'select OFI, TELA, OFI, DESCRI '
WHILE (EXISTS(SELECT top 1 ORDEN FROM #TMP2 order by orden )) -- TERCER WHILE 
	BEGIN
		SET @ID	   = (SELECT TOP 1 ORDEN FROM  #TMP2  ORDER BY orden)
		SET @tal   = (SELECT TOP 1 ltrim(rtrim(TALLA)) FROM  #TMP2  ORDER BY orden)
		set @QUERY = @QUERY + ', SUM(isnull(['+@TAL+'],0)) as [' + @tal+ '] '				
		DELETE #TMP2 WHERE orden = @id 
	END -- TERCER WHILE 
set @QUERY = @QUERY + ' from #tmp1'
set @QUERY = @QUERY + ' where tela = ' + @art
set @QUERY = @QUERY + ' group by cli, tela, OFI, descri'

PRINT(@QUERY)

exec(@query)	



/*


drop table #tmp1
drop table #tmp2
drop table #tmp3	
*/



