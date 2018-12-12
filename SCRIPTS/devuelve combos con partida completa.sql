declare @cli char(5)
declare @est char(5)
declare @tem char(3)
declare @COM char(200)
set @cli = '00001'
set @est = '00006'
set @tem= '035'
SET @COM = 'BONNIESURF702'
--EXEC SP_DESPACHO_PARTIDAS_COMBO '00001', '00006', '035' , 'BONNIESURF702' 

SELECT DISTINCT ET.COMBO, ET.UBI, PPO.CCT,  ET.TELA AS TELA, ET.COLPZA, et.QTY, ppo.CANT, et.po, PPO.KGS
INTO #TMP1
FROM     dbo.CCTELA AS CCT 
INNER JOIN			PO_PARTIDA		AS PPO ON CCT.CCT = PPO.CCT 
RIGHT OUTER JOIN	EXPLOSION_TELA	AS ET  ON CCT.TELA + CCT.COLOR + CCT.COMBI = ET.TELA AND PPO.PO = ET.PO AND PPO.ubi = ET.UBI 
LEFT OUTER JOIN		VIEW_POS		AS vp  ON ET.PO = vp.PO
WHERE  (vp.CLI = @cli) AND (vp.CODEST = @est) AND (vp.TEMPORADA = @tem) AND NOT LEFT(ET.TELA,1) = '9'


SELECT DISTINCT ET.COMBO, ET.UBI, PPO.CCT,  ET.TELA AS TELA, ET.COLPZA, et.QTY, ppo.CANT,et.po, PPO.KGS
INTO #TMP2
FROM				CCTELA			AS CCT 
INNER JOIN			PO_PARTIDA		AS PPO ON CCT.CCT = PPO.CCT 
RIGHT OUTER JOIN	EXPLOSION_TELA	AS ET  ON CCT.TELA + CCT.COLOR + CCT.COMBI = ET.TELA AND PPO.PO = ET.PO AND PPO.ubi = ET.UBI 
LEFT OUTER JOIN		VIEW_POS		AS vp  ON ET.PO = vp.PO
WHERE  (vp.CLI = @cli) AND (vp.CODEST = @est) AND (vp.TEMPORADA = @tem) AND NOT LEFT(ET.TELA,1) = '9' AND NOT PPO.CCT IS NULL

select DISTINCT A2.COMBO, A2.UBI, A2.CCT, A2.TELA, A2.COLPZA, A2.QTY, A2.CANT, A2.PO, A2.KGS 
INTO #TMP3  
from		#tmp1 AS A1 
INNER JOIN	#TMP2 AS A2 ON A1.COMBO=A2.COMBO AND A1.UBI = A2.UBI AND A1.COLPZA=A2.COLPZA AND A1.CCT = A2.CCT


SELECT * INTO #TMP4 FROM (
SELECT * FROM #TMP3
UNION
SELECT VP.COMBO, VP.UBI, '' AS CCT, VP.TELA, VP.COLPZA, 0 AS QTY0, VP.QTY, VP.PO, VP.KGS
FROM VIEW_EXPLOSION_TELAS AS VP 
INNER JOIN  #TMP3 AS A3 ON A3.PO = VP.PO AND  VP.COMBO = A3.COMBO
WHERE  (vp.CLI = @cli) AND (vp.ESTILO = @est) AND (vp.TEMPORADA = @tem) AND  LEFT(VP.TELA,1) = '9'

)MM

/*
SELECT T1.PO, T1.COMBO, T1.UBI, T1.CCT, T1.COLPZA, T1.TELA, AR_CDESCRI, T1.CANT, T1.KGS , ISNULL(CC.PARTIDA,'') AS PARTIDA
FROM #TMP4 AS T1
INNER JOIN RSFACCAR..AL0001ARTI ON AR_CCODIGO COLLATE SQL_Latin1_General_CP1_CI_AI = TELA
LEFT OUTER JOIN CCTELA AS CC ON CC.CCT = T1.CCT
WHERE REPLACE(COMBO,' ' , '') = REPLACE(@COM, ' ' , '')
ORDER BY  PO, COMBO, TELA

*/
select * from #tmp4
SELECT distinct po ,combo, ubi, colpza, tela, ofi,  qty, sum(kgs) as kgs
into #tmp5
FROM  VIEW_EXPLOSION_TELAS AS VP  
WHERE REPLACE(vp.COMBO,' ' , '') = replace(@com, ' ' ,'')
and cli=@cli and temporada = @tem and estilo= @est 
group by combo, ubi, colpza, tela, ofi, po , qty
order by po, ofi,combo, ubi, colpza


alter table #tmp5 add chk char(1) 
go
update #tmp5 set chk = ''
go
declare @cad varchar(300)
declare @con char(200)


SELECT * INTO #TTT FROM #TMP5
set @con = (select top 1 REPLACE(COMBO,' ' , '') as combo from #ttt)
--print @con

WHILE EXISTS(select * from #tmp4 where REPLACE(COMBO,' ' , '') =  @con)
	BEGIN
		set @cad = (select top 1 replace(po+combo+convert(varchar(5),ubi)+colpza+tela,' ','') from #tmp4)
		update #tmp5  set chk='1' 
		where replace(po+combo+convert(varchar(5),ubi)+colpza+tela,' ','') = @cad

		DELETE #tmp4 where replace(po+combo+convert(varchar(5),ubi)+colpza+tela,' ','') = @cad

		set @cad = (select top 1 replace(po+combo+convert(varchar(5),ubi)+colpza+tela,' ','') from #tmp4)
	END


-- esto es lo que hay en la explosion de telas, hay que poner las cantidades de la po_partida
	select distinct tt.* from #tmp5 as t5
	inner join #ttt as tt on t5.po= tt.po 
	
	where REPLACE(t5.COMBO,' ' , '') =  @coN and t5.chk = '1' 
	and t5.po not in (Select (po) from #tmp5 as d where  REPLACE(COMBO,' ' , '') =  @coN and chk='')
	order by po


/*
DROP TABLE #TMP1
DROP TABLE #TMP2
DROP TABLE #TMP3
DROP TABLE #TMP4
DROP TABLE #TMP5
DROP TABLE #Ttt
*/