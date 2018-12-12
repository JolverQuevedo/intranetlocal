SELECT PP.PO, 
SUM(PP.KGS) AS KILOSASIGNADOS, 
SUM(PP.CANT) AS PDASIGNADAS, 
sum(PP.KGS) / sum(PP.CANT) AS CONS

FROM     dbo.PO_PARTIDA AS PP 
INNER JOIN dbo.ASIGNA_CCT AS AC ON PP.CCT = AC.CCT

WHERE  (AC.TEL = '6000000704001000') AND (AC.CLI = '00001')

GROUP BY AC.CLI, PP.PO, AC.SALDO