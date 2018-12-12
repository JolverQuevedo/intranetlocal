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
CREATE PROCEDURE ESTILOS_CLIENTE
	-- Add the parameters for the stored procedure here
	@CLI VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select v.ESTCLI, v.ESTILO AS DES_ESTILO, v.GENERO AS CGEN, DGEN, v.TIPO AS TIP, v.DTIP, V.DESCLI, 
v.CODEST, V.TELA, V.TEMPORADA, V.TEJIDO, 
V.CODARTICULO, V.DESTEM , cast(v.FOTO as image) AS FOTO, v.CONTENIDO 

from (SELECT EE.ESTCLI, EE.DESCRIPCION AS ESTILO, EE.GENERO, GG.DESCRIPCION AS dgen, 
	TP.TIPO, TP.DESCRIPCION AS dtip, EE.CODEST, EE.CONTENIDO, 
	CAST(EE.FOTO AS varbinary) AS foto, cl.NOMBRE AS DESCLI,  PR.TELA,
	PR.TEMPORADA, TEL.DESCRIPCION AS TEJIDO, 
    EE.CODARTICULO, TEM.DESCRIPCION AS DESTEM
FROM         dbo.POS AS PP 
	INNER JOIN dbo.CLIENTE AS cl ON cl.CODIGO = PP.CLIENTE 
	INNER JOIN dbo.ESTILOS AS EE ON PP.CLIENTE = EE.CLIENTE AND EE.CODEST = PP.CODEST 
	INNER JOIN dbo.TIPPRENDA AS TP ON EE.TIPOPRENDA = TP.TIPO 
	INNER JOIN dbo.GENEROS AS GG ON GG.GENERO = EE.GENERO 
	INNER JOIN dbo.COTIZACION AS CC ON PP.COTIZACION = CC.COTIZACION 
	INNER JOIN dbo.PROTOS AS PR ON CC.PROTO = PR.PROTO AND CC.[VERSION] = PR.[VERSION] 
	INNER JOIN dbo.TELAS AS TEL ON PR.TELA = TEL.TELA 
	INNER JOIN dbo.TEMPORADAS AS TEM ON PR.TEMPORADA = TEM.CODIGO AND PR.CLIENTE = TEM.CLIENTE
WHERE     (PP.CLIENTE = @CLI) AND (PP.ESTADO = 'a') AND (PP.OFI IS NULL) AND (NOT (PP.COTIZACION IS NULL))
 group by ee.ESTCLI, EE.DESCRIPCION, EE.GENERO , GG.DESCRIPCION,
 TP.TIPO, TP.DESCRIPCION , CL.NOMBRE, EE.CODEST, PR.TELA, PR.TEMPORADA, TEL.DESCRIPCION, 
 EE.CODARTICULO, TEM.DESCRIPCION ,
  EE.CONTENIDO, cast(EE.FOTO as varbinary) ) v 
END
GO
