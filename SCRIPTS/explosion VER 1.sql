
/*
select * from [po-deta] where po = '217-96'
select * from [pos] where po = '217-96'
select * from ajustes where COTIZACION = '0000001431'
select * from OFI_POS where po = '217-96'
select * from [AJUSTE-DETAllES]  where ajuste = '00000174' and version = '027'
*/
select  AA.* , AR_CCODIGO, AR_CDESCRI, COLOR= CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END
from View_OFI_DETA_TELAS AS AA
inner join ETC_DETA AS EA ON CODTIP ='T' AND EA.UBI = AA.UBI AND EA.CODETC =AA.CODETC
FULL OUTER join RSFACCAR..AL0001ARTI as bb on  left(AR_CCODIGO,6) collate SQL_Latin1_General_CP1_CI_AI = tela AND 
REPLACE(AR_CDESCRI,' ' ,'') LIKE '%'+replace(dbo.getletras (CASE AA.ID WHEN 0 THEN EA.COL01 WHEN 1 THEN EA.COL02 WHEN 2 THEN COL03 WHEN 3 THEN COL04 WHEN 4 THEN COL05
WHEN 5 THEN COL06 WHEN 6 THEN COL07 WHEN 7 THEN COL08 WHEN 8 THEN COL09 WHEN 9 THEN COL10 WHEN 10 THEN COL11 WHEN 11 THEN COL12 WHEN 12 THEN COL13 
WHEN 13 THEN COL14 WHEN 14 THEN COL15 END),' ' ,'')+'%'
where ofi = '00008492'
ORDER BY OFI, PO, AA.UBI, AA.ID
--SELECT * FROM RSFACCAR..AL0001ARTI WHERE AR_CCODIGO LIKE'600091%'



-------------------------------------------------------------------------------------------------------------------------------
/*
select AA.* , AR_CCODIGO, AR_CDESCRI INTO #TMP1  
from View_OFI_DETA_TELAS  AS AA
FULL OUTER join RSFACCAR..AL0001ARTI as bb on  left(AR_CCODIGO,6) collate SQL_Latin1_General_CP1_CI_AI = tela AND 
REPLACE(AR_CDESCRI,' ' ,'') LIKE '%'+replace(dbo.getletras (aa.combo),' ' ,'')+'%'
where ofi = '00008492'
ORDER BY OFI, PO, UBI, ID

ALTER TABLE #TMP1 ADD
COLUMNA  CHAR(2),
COLOR  VARCHAR(100)	
-- CREO UN TEMPORAL PARA RECDORRER COMPLETANDO DATOS
SELECT * INTO #TMP2 FROM #TMP1

-- BORRO EL TEMPORAL 1 PARA HACER EL INSERT DE LOS REGISTROS ENCONTRADOS CON MATCHING O CON HORROR

DECLARE @po CHAR(20), @ubi int, @id int, @combo varCHAR(100), @TELA CHAR(6), @CODREAL CHAR(25), @DESREAL CHAR(100), @ETC  CHAR(10), @OFI CHAR(8),
	@famtel char(100),@obs varchar(200)
	WHILE (EXISTS(SELECT @PO FROM #TMP2 ORDER BY PO, UBI, ID, COMBO))
			BEGIN
				SET @PO		 = (SELECT TOP 1 PO		FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @UBI	 = (SELECT TOP 1 UBI	FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @ID		 = (SELECT TOP 1 ID     FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)        
				SET @etc     = (SELECT TOP 1 etc    FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @COMBO   = (SELECT TOP 1 COMBO  FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @OFI     = (SELECT TOP 1 OFI    FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @tela    = (SELECT TOP 1 tela   FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @famtel  = (SELECT TOP 1 famtel FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)
				SET @obs     = (SELECT TOP 1 obs    FROM #TMP2 ORDER BY PO, UBI, ID, COMBO)

				INSERT INTO #TMP1 VALUES(@OFI,@PO,@COMBO, @UBI,@id,@tela,@obs,@qty, @kilos,@cli, @est, @tem, @codreal, @desreal)
				SELECT 
				CASE WHEN ID = 0 THEN COL01 END 
				FROM ETC_DETA WHERE CODTIP ='T' AND UBI = @UBI AND CODETC =@ETC


				UPDATE USUARIOS SET SALDO = SALDO + TT.MONTO
				FROM USUARIOS BB 
				INNER JOIN #TMP2 TT ON TT.SOCIO = BB.USUARIO
				WHERE TT.POLLA = @POLLA




	-- ELIMINA LA POLLA QUE SE TRABAJO
				DELETE #TMP2 WHERE PO = @PO and UBI = @UBI AND ID = @ID AND COMBO = @COMBO

			END

SELECT * FROM #TMP1

DROP TABLE #TMP1



*/