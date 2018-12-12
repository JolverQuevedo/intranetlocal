 SELECT COTIZACION ,* FROM PROTOS WHERE CLIENTE = '00001' AND ESTILO = '00643' ORDER BY FECHA DESC
 SELECT * FROM ESTILOS WHERE CLIENTE = '00001' AND ESTCLI = '5482992'



delete cotihilado where cotizacion like '%1600'
delete COTIRUTA where cotizacion like '%1600'
delete [COTI-TENIDO] where cotizacion like '%1600'
delete cotizacion where cotizacion like '%1600'
update protos set cotizacion = null where cotizacion like '%1600'
