/*
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='63' Order by TG_CCLAVE
go
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='04' Order by TG_CCLAVE
go
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='03' Order by TG_CCLAVE
go
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE
go
Select A1_CALMA,A1_CDESCRI From RSFACCAR..AL0001ALMA Order by A1_CALMA
go
*/
Select * From RSFACCAR..CO0001MOVC Where OC_CNUMORD='0000030485'
go

Select C5_CTD AS MOV,C5_CNUMDOC AS NUMDOC, C5_CRFTDOC + ' ' + C5_CRFNDOC AS DOCREF,* From RSFACCAR..AL0001MOVC as MOVC  
WHERE MOVC.C5_CNUMORD = '0000030485' 
ORDER BY C5_CTIPMOV,C5_CTD+C5_CNUMDOC
go
--*************
-- ATENCION OC
--*************
Select OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDENADO,        
isnull((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A 
inner join RSFACCAR..al0001movd AS B 
	on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma 
	where C5_CNUMord='0000030485' 
--AND C6_CITEMOC = CC.OC_CITEM 
AND C6_Ccodigo = CC.OC_Ccodigo
and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'E'),0) As entra,
isnull((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A 
inner join RSFACCAR..al0001movd AS B 
	on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma 
	where C5_CNUMord='0000030485' 
--AND C6_CITEMOC = CC.OC_CITEM 
AND C6_Ccodigo = CC.OC_Ccodigo
and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'S'),0) As sale
From RSFACCAR..CO0001MOVD  AS CC
Where OC_CNUMORD='0000030485'  AND OC_CCODPRO='20101635440' AND OC_NCANORD > 0 
ORDER BY OC_CITEM
go





Select OC_CCODIGO,OC_CDESREF, OC_CUNIDAD, OC_NCANORD,        
(OC_NCANORD)*OC_NPREUN2 As ORDEN_VALOR_VENTA,        
(OC_NCANORD)*OC_NPREUNI As ORDEN_TOTAL,        
Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As ORDEN_IGV,       OC_NCANORD-OC_NCANSAL As ATEND,       (OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 As ATEND_VALOR_VENTA,       
(OC_NCANORD-OC_NCANSAL)*OC_NPREUNI As ATEND_TOTAL,       
Case  When OC_NIGV>0 Then(OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As ATEND_IGV,       
OC_NCANSAL,       
(OC_NCANSAL)*OC_NPREUN2 As XATEND_VALOR_VENTA,       
(OC_NCANSAL)*OC_NPREUNI As XATEND_TOTAL,       
Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As XATEND_IGV  
From RSFACCAR..CO0001MOVD  
Where OC_CNUMORD='0000030485'  AND OC_CCODPRO='20101635440' AND OC_NCANORD > 0 ORDER BY OC_CITEM
go
--*********
-- SISPAG
--*********
SELECT CP_CTIPDOC+CP_CNUMDOC AS CODEBUS,RTRIM(A.CP_CCODIGO) + ' ' + RTRIM(B.AC_CNOMBRE) AS PROVEE,A.CP_CIMAGEN,  CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NIMPOMN ELSE A.CP_NIMPOUS END IMPORTE, CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NSALDMN ELSE A.CP_NSALDUS END SALDO, CP_CTIPDOC,CP_CNUMDOC,CP_DFECDOC,CP_DFECVEN,CP_CCODMON,CP_CSUBDIA,CP_CCOMPRO,CP_CFECCOM  FROM RSCONCAR..CP0001CART AS A LEFT JOIN RSCONCAR..CP0001MAES AS B ON A.CP_CVANEXO=B.AC_CVANEXO AND A.CP_CCODIGO=B.AC_CCODIGO 
WHERE A.CP_CTDOCRE='OC'   AND A.CP_CNDOCRE='0000030485' ORDER BY PROVEE 
go
--*************
-- LIQUIDACION
--*************
Select LQ_CNUMLIQ, LQ_CNUMORD, LQ_CCODPRO,LQ_CTIPLIQ,LQ_CTIPDOC + ' ' + LQ_CNUMDOC AS DOCUM, LQ_DFECDOC,       LQ_CTIPMON, CASE LQ_CTIPMON WHEN 'MN' THEN  LQ_NIMPMN ELSE LQ_NIMPUS END AS IMPORTE,LQ_CSUBDIA, LQ_CCOMPRO,AC_CNOMBRE   From RSFACCAR..AL0001IMPD  Left Join RSCONCAR..CP0001MAES On LQ_CCODPRO=AC_CCODIGO   Where LQ_CNUMORD='0000030485' Order By LQ_CNUMORD
go
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='63' And TG_CCLAVE='S'
go
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='03' And TG_CCLAVE='US'
go


Select SUM((OC_NCANORD)*OC_NPREUN2) As ORDEN_VALOR_VENTA,        SUM((OC_NCANORD)*OC_NPREUNI) As ORDEN_TOTAL,       SUM(Case  When OC_NIGV>0 Then (OC_NCANORD)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As ORDEN_IGV,       SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUN2) As ATEND_VALOR_VENTA,       SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUNI) As ATEND_TOTAL,       SUM(Case  When OC_NIGV>0 Then (OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As ATEND_IGV,       SUM((OC_NCANSAL)*OC_NPREUN2) As XATEND_VALOR_VENTA,       SUM((OC_NCANSAL)*OC_NPREUNI) As XATEND_TOTAL,       SUM(Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As XATEND_IGV   From RSFACCAR..CO0001MOVD  Where OC_CNUMORD='0000030485'  GROUP BY OC_CNUMORD
go

Select Sum(CP_NIMPOMN) As Fact_MN_Total,Sum(CP_NIMPOUS) As Fact_US_Total,Sum (CP_NIGVMN) As Fact_MN_Igv, Sum(CP_NIGVUS) As Fact_US_Igv  From RSCONCAR..CP0001CART  Where CP_CTDOCRE='OC' AND CP_CNDOCRE='0000030485'  Group by CP_CTDOCRE,CP_CNDOCRE
go
Select * From RSCONCAR..CP0001CART  Where CP_CTDOCRE='OC' AND CP_CNDOCRE='0000030485  ' 
go
go
Select CP_CTIPDOC, SUM(CP_NSALDMN) as SALD_MN,SUM(CP_NSALDUS) as SALD_US  From RSCONCAR..CP0001CART  Where CP_CTDOCRE='OC' AND CP_CNDOCRE='0000030485'  Group by CP_CTIPDOC