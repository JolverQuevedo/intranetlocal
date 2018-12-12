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
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE bakeAVIOS 
	-- Add the parameters for the stored procedure here
	@pos char(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT codigo as COD, REPLACE(descripcion , '"',' ') AS DES, CODUNI AS UNI, DESUNI AS DUNI, 
		CODMON AS MON, DESMON AS DMON, CODEXP AS CODEXP, DESEXP AS DEXPLOSION, 
		CODTIP AS AREA,destip as Darea, PORMER 
		from VIEW_AVIOS	 where EDO = 'A' 		
		 and CODIGO= @pos ORDER BY DESCRIPCION 
END
GO
