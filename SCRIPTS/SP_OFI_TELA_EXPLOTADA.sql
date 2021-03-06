USE [MODELADOR]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRE_explosion_telas]    Script Date: 08/03/2017 11:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================
-- Author:		Mabel Molina
-- Create date: 27-2-2017
-- Description:	Datos previos para la explosion de telas definitiva
-- ===================================================================
ALTER PROCEDURE [dbo].[SP_PRE_explosion_telas]
	-- Add the parameters for the stored procedure here
	@ofi char(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

select  AA.OFI,AA.PO,AA.COMBO,AA.UBI,AA.ID,AA.TELA, AA.FAMTEL, AA.OBS, AA.QTY*CANPZA AS QTY, KILOS*CANPZA AS KILOS, aa.CODETC, AR_CCODIGO, AR_CDESCRI, 
COLOR= CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END,
TT.HIL1 AS H1, TT.POR1 AS P1, (KILOS*CANPZA)*(TT.POR1/100) AS K1, 
TT.HIL2 AS H2, TT.POR2 AS P2, (KILOS*CANPZA)*(TT.POR2/100) AS K2,
TT.HIL3 AS H3, TT.POR3 AS P3, (KILOS*CANPZA)*(TT.POR3/100) AS K3,
TT.HIL4 AS H4, TT.POR4 AS P4, (KILOS*CANPZA)*(TT.POR4/100) AS K4,
TT.HIL5 AS H5, TT.POR5 AS P5, (KILOS*CANPZA)*(TT.POR5/100) AS K5,
TT.HIL6 AS H6, TT.POR6 AS P6, (KILOS*CANPZA)*(TT.POR6/100) AS K6

from View_OFI_DETA_TELAS AS AA
inner join ETC_DETA AS EA ON CODTIP ='T'  AND replace(dbo.getletras (EA.COMBO),' ' ,'') = replace(dbo.getletras (AA.COMBO),' ' ,'') AND EA.CODETC =AA.CODETC
INNER JOIN TELAS TT ON TT.TELA = AA.TELA
FULL OUTER join RSFACCAR..AL0001ARTI as bb on  left(AR_CCODIGO,6) collate SQL_Latin1_General_CP1_CI_AI = AA.tela AND 
REPLACE(AR_CDESCRI,' ' ,'') LIKE '%'+replace(dbo.getletras (CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END),' ' ,'')+'%'
where ofi =@ofi
ORDER BY OFI, PO, AA.UBI, AA.ID


END
