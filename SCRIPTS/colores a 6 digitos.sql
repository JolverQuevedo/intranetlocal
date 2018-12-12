

-- este update hay que hacerlo diario
-- crea el codigo e color a 6 digitos para los pases de telas al Real

	update  modelador..rayados 
	set realsys =
	 (select ltrim(rtrim(letra))from modelador..tonos where tonos.tono = substring(rr.color,1,2))+ 
	(select  ltrim(rtrim(letra)) from modelador..tenido where tenido.tenido = substring(rr.color,3,2))+
	substring(rr.color,5,4)  
	from modelador..rayados rr 
	where realsys is null
