SELECT  MIN(DFECDOC) AS FECHA,
	CCODIGO AS CODTEL, MIN(CDESCRI) AS DESTEL, CNUMORD AS OC, MIN(COLOR) AS DESCOL, LOTE AS PARTIDA, SUM(BULTOS) AS ROLLOS, 
	SUM(KGNETO) AS KILOS, CCODPROV AS RUC, CNOMPROV AS PROVEEDOR, MIN(CRFNDOC) AS GUIA 
FROM
	(SELECT * from
		(select * from
			(select * from RS_ALMOVD
				where ESTADO='V' AND CTD='PE' AND CALMA='00MT' 
				
			 ) as tt1
			where tt1.cdescri not like '%cuello%'
		) as tt2
		where tt2.cdescri not like '%puño%'
	) AS TT3

GROUP BY   CCODIGO, CNUMORD,
		  LOTE, CCODPROV, CNOMPROV
HAVING SUM(BULTOS) > 0 AND SUM(KGNETO) > 0
ORDER BY PARTIDA



/*
SELECT * from
		(select * from
			(select * from RS_ALMOVD
				where ESTADO='V' AND CTD='PE' AND CALMA='00MT' 
				
			 ) as tt1
			where tt1.cdescri not like '%cuello%'
		) as tt2
		where tt2.cdescri not like '%puño%' AND LOTE='10069'
*/