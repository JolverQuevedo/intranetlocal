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
-- ================================================
-- Author:		Mabel Molina
-- Create date: 11-Jul-2011
-- Description:	Acumula pasadas y altura por 
--				franja para el resumen de colores
-- ================================================
ALTER PROCEDURE FIBRA_LETRA
	-- Add the parameters for the stored procedure here
	@col varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM (
			select FIBRA1,letra1, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra1, FIBRA1
			UNION
			select FIBRA2,letra2, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra2, FIBRA2
			UNION
			select FIBRA3,letra3, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra3, FIBRA3
			UNION
			select FIBRA4,letra4, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra4, FIBRA4
			UNION
			select FIBRA5,letra5, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra5, FIBRA5
			UNION
			select FIBRA6,letra6, sum(altura) as altu, sum(pasadas) as pasa from rayasec
			WHERE COMBIN = '00' AND COLOR = @COL 
			group by letra6, FIBRA6)UU
			WHERE NOT FIBRA1 IS NULL AND LEN(LTRIM(RTRIM(FIBRA1))) >0


ORDER BY 1,2



END
GO
