USE [MODELADOR]
GO
/****** Object:  StoredAJUcedure [dbo].[FICHAAJUSTE]    Script Date: 13/02/2017 09:46:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================
-- Author:		MABEL MOLINA
-- Create date: 13-feb-2017
-- Description:	Devuelve los campos de cabecera de la Ficha AJUSTE
-- =======================================================================

CREATE PROCEDURE  [dbo].[FICHAAJUSTE]  
@AJU char(10), 
@ver char(3),
@CLI CHAR(5) as

DECLARE  @n int
DECLARE  @v int
DECLARE  @c char(3)

set @n= (select count(*) from AJUSTEs where AJUSTE = @AJU and version =@VER)
set @v= (select count(*) from AJUSTEs where AJUSTE = @AJU )
set @v = @v+1

set @c = (select right('000'+ltrim(rtrim(@v)),3))


	SELECT		P1.AJUSTE AS AJU,			P1.VERSION AS VER,		P1.CLIENTE AS CLI, 
				C1.NOMBRE AS NOM,			P1.ESTILO AS EST,       E1.ESTCLI AS ECL, 
				P1.DESCRIPCION AS [DES],	E1.CODARTICULO AS ART,	E1.GENERO AS GEN, 
				G1.DESCRIPCION AS DGEN,		E1.TIPOPRENDA AS TIP,	T3.DESCRIPCION AS TPRE, 
				P1.TELA AS TEL,				T1.DESCRIPCION AS DTEL, P1.TEMPORADA AS TEM, 
				T2.DESCRIPCION AS DTEM,		P1.MOTIVO AS MOT,       P1.ESTADO AS EDO,
				V1.GG,						RT =isnull(cast(V1.RT as numeric(6,2)),0),	
				RA = isnull(cast(V1.RA as numeric(6,2)),0),		at = isnull(V1.AT,0),		
				aa = isnull(V1.AA,0),   pa= isnull(V1.PA,0),
				P2.SOLICITA AS OBS,			mcor = REPLACE(P1.MINcor, ',', '.'),
				MCOS = REPLACE(P1.MINcos , ',', '.'),		REPLACE(p1.minaca, ',', '.') AS MACA,
				MADI = REPLACE(P1.MINADI , ',', '.'),		REPLACE(P1.EFICOR, ',', '.') AS ECOR,
				ECOS = REPLACE(P1.EFICOS , ',', '.'),		REPLACE(P1.EFIACA, ',', '.') AS EACA,		
				EADI = REPLace(P1.EFIADI, ',', '.'),		P1.ADICIONAL AS DESADI,     
				p1.COTIZACION AS COTI, P1.OBS AS ADIC
				
	FROM
						 AJUSTES		 AS P1 
			INNER JOIN   [AJUSTE-OBS] AS P2 ON P1.AJUSTE = P2.AJUSTE AND P1.VERSION = P2.VERSION
			INNER JOIN   ESTILOS	 AS E1 ON P1.CLIENTE = E1.CLIENTE AND P1.ESTILO = E1.CODEST 
			INNER JOIN   TELAS		 AS T1 ON P1.TELA = T1.TELA 
			INNER JOIN   TEMPORADAS  AS T2 ON P1.TEMPORADA = T2.CODIGO AND P1.CLIENTE = T2.CLIENTE 
			INNER JOIN   CLIENTE     AS C1 ON E1.CLIENTE = C1.CODIGO AND T2.CLIENTE = C1.CODIGO 
			INNER JOIN   GENEROS     AS G1 ON E1.GENERO = G1.GENERO 
			INNER JOIN   TIPPRENDA   AS T3 ON E1.TIPOPRENDA = T3.TIPO
			INNER JOIN	 VIEW_TELAS  AS V1 ON P1.TELA = V1.TELA
WHERE P1.AJUSTE = @AJU AND P1.VERSION = @VER  
      








