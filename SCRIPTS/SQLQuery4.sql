declare @ord varchar(10), @lin char(4)

set @ord = '0000031653'
set @lin = '0001'


Select  c6_ccodigo, C6_CITEM, sum(c6_ncantid)  as atendido,
(select oc_ncanord from   RSFACCAR..CO0001MOVd 
Where OC_CNUMORD=@ord and C6_CITEM=oc_citem) as ordenado
From RSFACCAR..AL0001MOVD  
INNER JOIN RSFACCAR..AL0001MOVC as ccc ON C5_CTD = C6_CTD AND C5_CALMA = C6_CALMA AND C5_CNUMDOC = C6_CNUMDOC
Where C5_CNUMORD= @ord  and C5_CTD = 'PE'
and C6_CITEM= @lin
group by c6_ccodigo, C6_CITEM


