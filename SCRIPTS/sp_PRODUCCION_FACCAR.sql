SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure sp_PRODUCCION_FACCAR
@anio char(4)
as
SELECT top 100 percent MONTH(C6_DFECDOC) AS MES,  LEFT(C6_CCODIGO,5) AS CODIGO, SUM(C6_NCANTID) AS CANT, AVG(C6_NPREUN1) AS UNIT, 
C6_CCODMON AS MON, C6_CALMA AS ALM , YEAR (C6_DFECDOC) as anio
into #partes
FROM rsfaccar..AL0001MOVD 
WHERE C6_CTD = 'PE' AND C6_CCODMOV IN ('EP','PR')
AND C6_CALMA IN ('00T1', '00T2')
and year(c6_dfecdoc) = 2012
GROUP BY LEFT(C6_CCODIGO,5), C6_CCODMON , MONTH(C6_DFECDOC), C6_CALMA, YEAR (C6_DFECDOC)
ORDER BY 2,1

select * from #PARTES