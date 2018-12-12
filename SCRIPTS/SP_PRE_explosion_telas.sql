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
-- ===================================================================
-- Author:		Mabel Molina
-- Create date: 27-2-2017
-- Description:	Datos previos para la explosion de telas definitiva
-- ===================================================================
alter PROCEDURE SP_PRE_explosion_telas
	-- Add the parameters for the stored procedure here
	@ofi char(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

select  AA.OFI,AA.PO,AA.COMBO,AA.UBI,AA.ID,AA.TELA, AA.FAMTEL, AA.OBS, AA.QTY*CANPZA AS QTY, KILOS*CANPZA AS KILOS, aa.CODETC, AR_CCODIGO, AR_CDESCRI, COLOR= CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END

from View_OFI_DETA_TELAS AS AA
inner join ETC_DETA AS EA ON CODTIP ='T' AND EA.UBI = AA.UBI AND EA.CODETC =AA.CODETC
FULL OUTER join RSFACCAR..AL0001ARTI as bb on  left(AR_CCODIGO,6) collate SQL_Latin1_General_CP1_CI_AI = tela AND 
REPLACE(AR_CDESCRI,' ' ,'') LIKE '%'+replace(dbo.getletras (CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END),' ' ,'')+'%'
where ofi =@ofi
ORDER BY OFI, PO, AA.UBI, AA.ID


END
GO
