USE [MODELADOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_DESPACHO_PARTIDAS_COMBO]    Script Date: 06/11/2018 11:30:29 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================
-- Author:		Mabel Molina
-- Create date: 30-10-2008
-- Description:	Devuelve las PARTIDAS ASIGNADAS A LOS Combos que tienen
--				partida asignada con colores completos
-- ============================================================================
--DROP PROCEDURE [SP_DESPACHO_CANTIDAD_PO]

CREATE PROCEDURE [dbo].[SP_DESPACHO_CANTIDAD_PO]
	
@cli char(5),
@est char(5),
@tem char(3),
@COM CHAR(200),
@PO  CHAR(25)

AS

set nocount on

BEGIN
SELECT  TOP 1 ET.PO,ET.ubi, COMBO,
T0,T1,T2,T3,T4,T5,T6,T7,T8,T9, C0,C1,C2,C3,C4,C5,C6,C7,C8,C9, 
(C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOT, qty, VPP.CANT
FROM		VIEW_EXPLOSION_TELAS	AS ET
inner join	VIEW_PO_DETA_105		as vp	ON VP.PO=ET.PO	  AND VP.UBI = ET.UBI 
INNER JOIN	VIEW_PO_PARTIDA			AS VPP	ON VPP.PO = ET.PO AND VPP.ubi = ET.UBI
WHERE	ET.PO = @PO AND REPLACE(COMBO,' ' , '') = @COM
		AND ET.CLI = @CLI AND ET.ESTILO = @EST AND ET.TEMPORADA = @TEM
order by ET.tela

END