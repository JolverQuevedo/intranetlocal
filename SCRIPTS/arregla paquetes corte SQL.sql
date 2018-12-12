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
-- =============================================
-- Author:		Mabel Molina
-- Create date: 16-02-2017
-- Description:	arregla las caNTIDADES DE LAS 
--				PLANILLAS DE PAQUETES DE CORTE
-- =============================================
CREATE PROCEDURE ARREGLA_PAQUETES
 @CORTE CHAR(5),
 @PQT CHAR(3),
 @QTY INT
 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	update 
	DBPROD.dbo.PRODETCOR 
	set cd_ncant = @QTY
	where cd_cnrocorte=@CORTE and cd_csecuen = @PQT

	UPDATE 
	DBPROD..PROPARCOR 
	SET CD_NCANT = @QTY 
	WHERE CD_CNROCORTE = @CORTE AND CD_CSECUEN= @PQT

END
GO
