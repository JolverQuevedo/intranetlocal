SELECT distinct
t1.etc,t1.ubi,t1.ofi,t1.po,t1.tela,t1.qty,t1.kgs,t1.estilo,t1.estcli,t1.colpza,t1.destem,t1.estcli,
t2.DES01,
t2.DES02,
t2.DES03,
t2.DES04,
t2.DES05,
t2.DES06,
t2.DES07,
t2.DES08,
t2.DES09,
t2.DES10,
t2.DES11,
t2.DES12,
t2.DES13,
t2.DES14,
t2.DES15,
t1.combo,
t3.col01,
t3.col02,
t3.col03,
t3.col04,
t3.col05,
t3.col06,
t3.col07,
t3.col08,
t3.col09,
t3.col10,
t3.col11,
t3.col12,
t3.col13,
t3.col14, t4.AR_CDESCRI,
t3.col15
  FROM  VIEW_EXPLOSION_TELAS as t1
inner join etc as t2 on t1.ETC=t2.CODETC 
inner join View_ETC_FICHA as t3 on t2.CODETC=t3.CODETC and t1.estcli=t3.estcli and t3.codtip='T' 			and replace(t1.combo,' ','')=replace(t3.combo,' ','')
inner join RSFACCAR.dbo.AL0001ARTI as t4 on t1.TELA collate Modern_Spanish_CI_AS= t4.AR_CCODIGO collate Modern_Spanish_CI_AS 
WHERE  ESTILO = '00006' AND TEMPORADA = '035'
AND CLI = '00001'
AND PO = '218-665'
order by t1.ubi

SELECT * FROM  VIEW_EXPLOSION_TELAS WHERE ESTILO = '00006' AND TEMPORADA = '035' AND CLI = '00001' AND PO = '218-665' 
SELECT * FROM View_ETC_FICHA WHERE CODETC = '0000000400' AND COMBO IN (SELECT REPLACE(COMBO,' ','') FROM VIEW_EXPLOSION_TELAS WHERE ESTILO = '00006' AND TEMPORADA = '035' AND CLI = '00001' AND PO = '218-665' ) ORDER BY UBI
SELECT * FROM ETC WHERE CODCLI = '00001' and CODTEM = '035' and CODEST='00777' 

