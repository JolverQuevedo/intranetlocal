<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function veri(opc) 
{ 	cod = trim(eval("document.all.COD"+opc+".value"))
    com = trim(eval("document.all.COM"+opc+".value"))
    des = ltrim(eval("document.all.DES"+opc+".value"))
    cad =  'comun/inserrayas2.asp?cod=' + cod
    cad += '&com=' + com + '&des='+ des 
   /* document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
   */
    document.all.ACTIV.src= cad
}

function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad  =	'COD='	 + thisForm.COD.value  ;
		cad += '&chk=1' ;	
		cad += '&url=' + url ;
		cad += '&tbl=' + TBL ;
		cad += '&PK='  + PK ;
		cad += '&DS='  + DS	;
	window.location.replace(funcionalidad + cad); 
	return true;
}

function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	cor = 'rayacol'
    CAD = '.asp?pos='+'<%=trim(pos)%>'+'&com='+ trim(eval("document.all.COM"+pos+".value"))
	CAD += '&dcom='+ ltrim(eval("document.all.DES"+pos+".value"))
	CAD += '&des='+ '<%=des %>'
	
    top.window.frames.item("rightFrame").window.location.replace(cor+CAD)
     cor = 'RAYASEC2'
    top.window.frames.item("bottomFrame").window.location.replace(cor+CAD)
	oldrow=pos;
	return true;
}

</script>
