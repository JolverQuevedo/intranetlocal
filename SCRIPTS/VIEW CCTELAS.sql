use modelador
go 

drop VIEW VIEW_CCTELAS

go


alter view ASIGNA_CCT
as


SELECT DISTINCT TOP 100 PERCENT
    cc.PARTIDA AS PAR, cc.TELA+CC.COLOR+CC.COMBI AS TEL, 
	AR_CDESCRI AS DESTELA,
	cc.PROVEEDOR AS RUC, (SELECT AC_CNOMBRE FROM RSCONCAR..CP0001MAES Where AC_CVANEXO='P' 
	And AC_CCODIGO= CC.PROVEEDOR COLLATE SQL_Latin1_General_CP1_CI_AI) AS PROVEE, ROUND(cc.PESOTOTAL, 3) AS KGS, 
	ROUND(cc.SALDO, 3) AS SALDO,   cc.TOTALROLLOS AS RLL, cc.CCT,  CONVERT(nVARCHAR(max), cc.fecini, 103)  AS FEC,
	 cc.CALIDAD AS CAL, cc.CONDICION AS COND, cc.CLIENTE AS CLI,   cl.NOMBRE AS DESCLI
FROM			CCTELA as cc 
INNER JOIN		CLIENTE as cl  ON cc.CLIENTE = cl.CODIGO 
INNER JOIN		RSFACCAR..AL0001ARTI ON AR_CCODIGO COLLATE SQL_Latin1_General_CP1_CI_AI= CC.TELA+CC.COLOR+CC.COMBI
WHERE CALIDAD = 1  AND YEAR(cc.FECINI) >= 2018 AND cc.ESTADO = 'A' AND cc.CONDICION = 'C' AND SALDO > 0 

go

 SELECT * FROM CCTELA
WHERE PARTIDA = '8853'
/*************************************************************************
	PARTIDAS DISPONIBLES PARA KILOS REQUERIDOS POR OFI/COLOR --> CLIENTE
**************************************************************************/
 SELECT DISTINCT et.OFI, et.PO, et.TELA,  ar_cdescri as DESCRI,
 (SELECT NOMBRE FROM CLIENTE WHERE CODIGO = CC.CLIENTE) AS NOMBRE,
 sum(kgs) as KREQ, partida, (SELECT pesototal FROM CCTELA WHERE PARTIDA = '8851' AND CLIENTE = '00001') as KPAR,
 CC.CLIENTE AS CODCLI,-- qty,
 (SELECT SALDO FROM CCTELA WHERE PARTIDA = '8851' AND CLIENTE = '00001') as SALDO
, estilo, ESTCLI, TEMPORADA, destem
 FROM EXPLOSION_TELA AS ET
 INNER JOIN CCTELA AS CC ON ET.TELA = CC.TELA+CC.COLOR+CC.COMBI 
 inner join VIEW_POS as vp on et.OFI = vp.ofi
inner join rsfaccar..al0001arti as ar on ar_ccodigo collate SQL_Latin1_General_CP1_CI_AI = CC.TELA+CC.COLOR+CC.COMBI 
 WHERE cc.CALIDAD = 1  AND YEAR(cc.FECHA) >= 2018 AND upper(cc.ESTADO) = 'A' 
AND PARTIDA = '8851' 
 AND CLIENTE = '00001' AND SALDO > 0
 group by et.ofi,et.po,et.tela, partida,cc.tela, CC.CLIENTE ,ar_cdescri, qty, estilo, ESTCLI, TEMPORADA, destem
 ORDER BY partida, et.OFI,et.PO
 