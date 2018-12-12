use modelador
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MABEL MOLINA
-- Create date: 09-10-2018
-- Description:	CONVIERTE UN VALOR EN PORCENTUAL
-- PARA PODER MULTIPLICAR EL 100% + % ADICIONAL
-- DE LA FORMA CANT * 1.05 --> 105% DE CANT
-- =============================================
create FUNCTION PORCENTAJE
(
	@COBERTURA numeric (5,2)
)
RETURNS NUMERIC( 5,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @porcen numeric (5,2)
	DECLARE @ret numeric (5,2)
	--  porcentaje /100
	
	set	@porcen = @cobertura/100
	
	set @ret = 1 + @porcen
	-- Retornar el valor escalar
	RETURN @ret

END
GO
