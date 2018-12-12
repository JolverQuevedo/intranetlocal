USE MODELADOR
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================================
-- Author:		MABEL MOLINA
-- Create date: 01-MAR-2018
-- Description:	Devuelve los campos de cabecera de la Ficha de ARTICULOS PARA REAL
-- ==================================================================================


CREATE PROCEDURE DBO.SP_SHOW
@COD VARCHAR(25)
AS

if @COD =''

SELECT	'' AS AR_CCODIGO,  '' AS AR_CDESCRI,  '' AS AR_CUNIDAD,  '' AS AR_CDESCR2 , '' AS AR_CMONCOM,  '' AS AR_CLUGORI, 
	    '' AS AR_CCUENTA,  '' AS AR_CTIPO,    '' AS AR_CLINEA ,    '' AS AR_CTIPEXI,  '' AS AR_CLINEA,   '' AS AR_CGRUPO,
	    '' AS ar_cmarca,   '' AS AR_CFAMILI,  '' AS ar_cmodelo ,    0 AS AR_NLONSER,  '' AS AR_CFLOTE,   '' AS AR_CFRESTA,
	    '' AS AR_CFLGRCN,   0 AS AR_NTASRCN,  '' AS AR_CANOFAB


ELSE
	Select AR_CCODIGO, AR_CDESCRI, AR_CUNIDAD, AR_CDESCR2 , AR_CMONCOM, AR_CLUGORI, 
	AR_CCUENTA, AR_CTIPO, AR_CLINEA , AR_CTIPEXI, AR_CLINEA, AR_CGRUPO, AR_CANOFAB,
	ar_cmarca, AR_CFAMILI, ar_cmodelo , AR_NLONSER, AR_CFLOTE, AR_CFRESTA,
	AR_CFLGRCN, AR_NTASRCN
	From RSFACCAR..AL0001ARTI 
	Where AR_CCODIGO=@COD
	order by ar_ccodigo desc    