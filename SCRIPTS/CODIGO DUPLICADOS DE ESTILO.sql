--select * from ordencompra
select FECCREA, * from estilos as ee
where right(cODARTICULO,5)  = '18548'
 order by right(cODARTICULO,5) desc



 select arti, dupli, CLIENTE, cc.NOMBRE, CODEST, estcli, ss.feccrea  from 
	(SELECT cliente+right(cODARTICULO,5) as arti, count(*) as dupli
	FROM estilos as ss 
	GROUP BY cliente+right(cODARTICULO,5),right(cODARTICULO,5)
	HAVING count(*) > 1 and right(cODARTICULO,5) > '18327'
	) pp
	inner join ESTILOS ss on right(ss.cODARTICULO,5)= right(pp.arti,5)
	inner join CLIENTE cc on cc.CODIGO = ss.CLIENTE