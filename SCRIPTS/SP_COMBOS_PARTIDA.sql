-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Mabel Molina
-- Create date: 30-10-2008
-- Description:	Devuelve los Combos que tienen
--				partida asignada con colores completos
-- =====================================================
--DROP PROCEDURE SP_COMBOS_PARTIDA
GO
ALTER PROCEDURE SP_COMBOS_PARTIDA
	-- Add the parameters for the stored procedure here
@cli char(5),
@est char(5),
@tem char(3)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT DISTINCT ET.COMBO, ET.UBI, PPO.CCT,  ET.TELA AS TELA, ET.COLPZA
INTO #TMP1
FROM     dbo.CCTELA AS CCT 
INNER JOIN			PO_PARTIDA		AS PPO ON CCT.CCT = PPO.CCT 
RIGHT OUTER JOIN	EXPLOSION_TELA	AS ET  ON CCT.TELA + CCT.COLOR + CCT.COMBI = ET.TELA AND PPO.PO = ET.PO AND PPO.ubi = ET.UBI 
LEFT OUTER JOIN		VIEW_POS		AS vp  ON ET.PO = vp.PO
WHERE  (vp.CLI = @CLI) AND (vp.CODEST = @EST) AND (vp.TEMPORADA = @TEM) AND NOT LEFT(ET.TELA,1) = '9'



SELECT DISTINCT ET.COMBO, ET.UBI, PPO.CCT,  ET.TELA AS TELA, ET.COLPZA
INTO #TMP2
FROM     dbo.CCTELA AS CCT 
INNER JOIN			PO_PARTIDA		AS PPO ON CCT.CCT = PPO.CCT 
RIGHT OUTER JOIN	EXPLOSION_TELA	AS ET  ON CCT.TELA + CCT.COLOR + CCT.COMBI = ET.TELA AND PPO.PO = ET.PO AND PPO.ubi = ET.UBI 
LEFT OUTER JOIN		VIEW_POS		AS vp  ON ET.PO = vp.PO
WHERE  (vp.CLI = @CLI) AND (vp.CODEST = @EST) AND (vp.TEMPORADA = @TEM) AND NOT LEFT(ET.TELA,1) = '9'
AND NOT PPO.CCT IS NULL

select DISTINCT A2.COMBO  from #tmp1 AS A1 
INNER JOIN #TMP2 AS A2 ON A1.COMBO=A2.COMBO AND A1.UBI = A2.UBI AND A1.COLPZA=A2.COLPZA AND A1.CCT = A2.CCT



--SELECT * FROM #TMP1
--SELECT * FROM #TMP1
DROP TABLE #TMP1
DROP TABLE #TMP2


END
GO
