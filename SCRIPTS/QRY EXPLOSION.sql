select DISTINCT et.*, ft.descripcion as famtel, BB.AR_CDESCRI,
PZA = CASE ET.ID WHEN 0 THEN DES01 WHEN 1 THEN DES02 WHEN 2 THEN DES03 WHEN 3 THEN DES04 WHEN 4 THEN DES05
WHEN 5 THEN DES06 WHEN 6 THEN DES07 WHEN 7 THEN DES08 WHEN 8 THEN DES09 WHEN 9 THEN DES10 WHEN 10 THEN DES11 WHEN 11 THEN DES12 WHEN 12 THEN DES13 
WHEN 13 THEN DES14 WHEN 14 THEN DES15 END
from EXPLOSION_TELA as et inner join  FAMTELAS AS FT ON LEFT(FT.CORREL, 2) = LEFT(et.crudo, 2) 
INNER JOIN ETC AS EE ON ET.ETC = EE.CODETC
INNER join RSFACCAR..AL0001ARTI as bb on  AR_CCODIGO collate SQL_Latin1_General_CP1_CI_AI = ET.tela
where OFI = '00009190'

--EXEC SP_OFI_TELA_EXPLOTADA '00009190'