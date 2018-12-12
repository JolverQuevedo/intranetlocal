select  v.ESTCLI, v.DESEST, v.GENERO AS CGEN,
DGEN, v.TIPO AS TIP, v.DTIP,
v.CODEST, cast(v.FOTO as image), v.CONTENIDO 
from (select ee.ESTCLI , EE.DESCRIPCION as DESEST, EE.GENERO ,
GG.DESCRIPCION as dgen, TP.TIPO, TP.DESCRIPCION as dtip ,
EE.CODEST, EE.CONTENIDO,  cast(EE.FOTO as varbinary) AS foto
from POS PP
INNER JOIN estilos	EE ON PP.CLIENTE = EE.CLIENTE
			 AND ee.CODEST = PP.CODEST
INNER JOIN TIPPRENDA TP ON EE.TIPOPRENDA = TP.TIPO
INNER JOIN GENEROS GG ON GG.genero = ee.genero
where PP.cliente = '00024' and pp.estado ='a' and 
pp.OFI is null and not pp.cotizacion is null
group by   ee.ESTCLI, EE.DESCRIPCION, EE.GENERO ,
GG.DESCRIPCION, TP.TIPO, TP.DESCRIPCION ,
EE.CODEST, EE.CONTENIDO,  cast(EE.FOTO as varbinary) 
) v