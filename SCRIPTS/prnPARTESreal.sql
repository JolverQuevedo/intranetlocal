Select a1_calma AS ALMA, A1_CDESCRI AS DESCRI From RSFACCAR..AL0001ALMA 

Select A1_CDESCRI AS DESALM,TM_CDESCRI AS DESMOV, * From RSFACCAR..AL0001MOVC inner join RSFACCAR..AL0001ALMA on A1_CALMA = c5_calma inner join RSFACCAR..AL0001TABM on TM_CTIPMOV=c5_ctipmov AND TM_CCODMOV=c5_ccodmov Where C5_CALMA='00H6' AND C5_CTD='' 

--update RSFACCAR..CO0001MOVC set oc_csitord ='5' where oc_cnumord = '0000031635'
-- PE = '00018400001'

-- datos cabecera DOCUMENTO
Select A1_CDESCRI,TM_CDESCRI, * 
From RSFACCAR..AL0001MOVC 
inner join RSFACCAR..AL0001ALMA on A1_CALMA = c5_calma
inner join RSFACCAR..AL0001TABM on TM_CTIPMOV=c5_ctipmov AND TM_CCODMOV=c5_ccodmov
Where C5_CALMA='00H0' AND C5_CTD='PE' AND C5_CNUMDOC='00018100135'


-- detalle del DOCUMENTO
Select A.C6_CITEM,A.C6_CCODIGO,A.C6_CDESCRI,A.C6_CCODMON,A.C6_NPREUNI,B.AR_CUNIDAD AS cUniMed,A.C6_NCANTID ,AR_CUNIDAD, AR_CFSERIE , * 
From RSFACCAR..AL0001MOVD  a
inner join RSFACCAR..AL0001ARTI  b on C6_CCODIGO= AR_CCODIGO
Where C6_CALMA='00H0' AND C6_CTD='PE' AND C6_CNUMDOC='00018100135' ORDER BY a.C6_CITEM


Select A.C6_CITEM,A.C6_CCODIGO,A.C6_CDESCRI,A.C6_CCODMON,A.C6_NPREUNI,B.AR_CUNIDAD AS cUniMed,A.C6_NCANTID 
From RSFACCAR..AL0001MOVD A 
LEFT JOIN RSFACCAR..AL0001ARTI B ON B.AR_CCODIGO=A.C6_CCODIGO 
Where C6_CALMA='00H0' AND C6_CTD='pe' AND C6_CNUMDOC='00018100135' 
Order by C6_CALMA,C6_CTD,C6_CNUMDOC,C6_CITEM