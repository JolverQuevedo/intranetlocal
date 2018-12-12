DECLARE @OFI VARCHAR(8)
SET @OFI = '00011262' 
--SELECT * FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = '00011262'

SELECT DISTINCT et.OFI, et.PO, ET.COMBO, ET.COLPZA, MIN(ET.QTY) AS QTY, SUM(ET.KGS) AS KGS,ET.TELA,
                ft.descripcion AS FAMTEL, BB.AR_CDESCRI AS DESTEL, VO.ESTCLI, 
				(SELECT ISNULL(CAN0,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q0,
				(SELECT ISNULL(CAN1,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q1,
				(SELECT ISNULL(CAN2,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q2,
				(SELECT ISNULL(CAN3,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q3,
				(SELECT ISNULL(CAN4,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q4,
				(SELECT ISNULL(CAN5,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q5,
				(SELECT ISNULL(CAN6,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q6,
				(SELECT ISNULL(CAN7,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q7,
				(SELECT ISNULL(CAN8,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q8,
				(SELECT ISNULL(CAN9,0) AS CAN0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS Q9,
				(SELECT T0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T0,
				(SELECT T1 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T1,
				(SELECT T2 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T2,
				(SELECT T3 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T3,
				(SELECT T4 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T4,
				(SELECT T5 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T5,
				(SELECT T6 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T6,
				(SELECT T7 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T7,
				(SELECT T8 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T8,
				(SELECT T9 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where PP.ofi = ET.OFI AND ET.UBI = PD.UBI) AS T9,
				ISNULL((SELECT ISNULL(_XS ,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R0],
				ISNULL((SELECT ISNULL(_S  ,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R1],
				ISNULL((SELECT ISNULL(_M  ,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R2],
				ISNULL((SELECT ISNULL(_L  ,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R3],
				ISNULL((SELECT ISNULL(_XL ,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R4],
				ISNULL((SELECT ISNULL(_XXL,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R5],
				ISNULL((SELECT ISNULL(_3XL,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R6],
				ISNULL((SELECT ISNULL(_4XL,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R7],
				ISNULL((SELECT ISNULL(_5XL,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R8],
				ISNULL((SELECT ISNULL(_6XL,0)   FROM VIEW_RECTILINEOS_OFI  AS OO  WHERE OO.OFI = ET.OFI AND OO.UBI = ET.UBI AND OO.TELA = ET.TELA),0) AS [R9], 	
				et.ubi, et.tela
         FROM EXPLOSION_TELA AS et
              INNER JOIN FAMTELAS AS FT ON LEFT(FT.CORREL, 2) = LEFT(et.crudo, 2)
              INNER JOIN ETC AS EE ON ET.ETC = EE.CODETC
			  INNER JOIN VIEW_OFIS AS VO ON VO.OFI = ET.OFI
              INNER JOIN RSFACCAR..AL0001ARTI AS bb ON AR_CCODIGO COLLATE SQL_Latin1_General_CP1_CI_AI = ET.tela
        WHERE ET.OFI =  @OFI  AND ee.codtip = 'T'
		GROUP BY ET.OFI, PO,UBI, COMBO, TELA,ft.descripcion , AR_CDESCRI, ET.COLPZA, ET.ETC, VO.ESTCLI order by et.ubi,et.tela




--  ET.UBI, 
	--	SELECT top 1 T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,* FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = '00009507'
	--	SELECT * FROM VIEW_OFIS   WHERE OFI =  '00009507' ORDER BY UBI, TELA


	
				/*, 
				(SELECT top 1 ISNULL(Q0,0) AS Q0 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q1,0) AS Q1 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q2,0) AS Q2 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q3,0) AS Q3 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q4,0) AS Q4 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q5,0) AS Q5 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q6,0) AS Q6 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q7,0) AS Q7 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				(SELECT top 1 ISNULL(Q8,0) AS Q8 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = @OFI),
				SELECT * FROM [EXPLOSION_TELA] WHERE PO = '218-716-BB'
				









				(SELECT (CONCAT(DES01+' ' , ISNULL(DES02, ''),' ' , ISNULL(DES03,''),' ' , 
				ISNULL(DES04,''), ' ', ISNULL(DES05,''), ' ', ISNULL(DES06,''), ' ',
				ISNULL(DES07,''), ' ', ISNULL(DES08,''), ' ', ISNULL(DES09,''), ' ',
				ISNULL(DES10,''), ' ', ISNULL(DES11,''), ' ', ISNULL(DES12,''), ' ', 
				ISNULL(DES13,''), ' ', ISNULL(DES14,'') ) )
				FROM ETC AS CCC WHERE ET.ETC = CCC.CODETC) AS PZAS

				


                */
                      