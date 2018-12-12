<% Response.Buffer = true %>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function dd(ff) 
{	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
		thisForm.COD.value  = t.rows(pos).cells(0).innerText ;
		thisForm.DES.value  = t.rows(pos).cells(1).innerText ;
		//thisForm.TXTOBS.value = t.rows(pos).cells(11).innerText;
		//thisForm.TXTDUPLICADO.value = t.rows(pos).cells(11).innerText;
		subcadena =  trim(t.rows(pos).cells(5).innerText) ;
		elemento = thisForm.TON ;
		thisForm.TON.selectedIndex = seleindice(subcadena,elemento);	
		subcadena =  trim(t.rows(pos).cells(6).innerText) ;
		elemento = thisForm.TEN ;
		thisForm.TEN.selectedIndex = seleindice(subcadena,elemento);	
		subcadena =  trim(t.rows(pos).cells(4).innerText) ;
		elemento = thisForm.CLI ;
		thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);	
		thisForm.TON.disabled = true
		thisForm.TEN.disabled = true
		thisForm.CLI.disabled = true
		
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
		oldrow=pos
		return true;
	}
}
function NUEVO()
{	thisForm.COD.value = '';
	thisForm.DES.value = '';
	thisForm.TON.disabled=false;
	thisForm.TEN.disabled=false;
	thisForm.CLI.disabled = false;	
	thisForm.TON.selectedIndex= 0;
	thisForm.TEN.selectedIndex = -1;
	thisForm.CLI.selectedIndex = -1;
	thisForm.CLI.focus();
	return true;
}
function GRABA()
{	var cad = 'comun/inserCOL.asp';
	chk='0'
	cad = cad + '?COD=' + trim(thisForm.COD.value);
	cad = cad + '&TEN=' + thisForm.TEN.value;
	cad = cad + '&TON=' + thisForm.TON.value;
	cad = cad + '&CLI=' + thisForm.CLI.value;
	cad = cad + '&chk=' + chk;
	if (ltrim(toAlpha(thisForm.DES.value))== '')
	{	alert("Debe informar el nombre del color");
		return false;
	}
	cad = cad + '&des=' + ltrim(toAlpha(thisForm.DES.value));
	cad = cad + '&url=colores.asp';
	//alert(cad)
	window.location.replace(cad)	 
}
function DGRABA()
{	var cad = 'comun/inserCOL.asp';
	chk='1'
	cad = cad + '?COD=' + trim(thisForm.COD.value);
	cad = cad + '&TEN=' + thisForm.TEN.value;
	cad = cad + '&TON=' + thisForm.TON.value;
	cad = cad + '&CLI=' + '<%=CLI%>';	
	cad = cad + '&DESCAR=' + '<%=DEScar%>';
	cad = cad + '&chk=' + chk;
	if (ltrim(toAlpha(thisForm.DES.value))== '')
	{	alert("Debe informar el nombre del color");
		return false;
	}
	cad = cad + '&des=' + ltrim(toAlpha(thisForm.DES.value));
	cad = cad + '&url=colores.asp';
	//alert(cad)
	window.location.replace(cad)	 
}

function DELE()
{ if (trim(thisForm.COD.value) == '')	
  {		alert("No tiene registros que eliminar");
		return true;
	}
	if (confirm("¿ Realmente desea anular este color ?")== true)
	{	chk = '1';
		DGRABA();
	}
return true;		
}
function fModificar()
	{
	chk = '2';
	GRABA();
	}
	
function codigo()
{	ton = trim(thisForm.TON.value) ;
	ten = trim(thisForm.TEN.value) ;
	thisForm.COD.value = ton + ten ;
return true
}
function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	for (i = 1; i<t.rows.length; i++)
	{ // averigua cual fila este en verde
	  if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
	  {		ff = i -1; 	}
	}
	dd(ff);
}
function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	for (i = 1; i<t.rows.length; i++)
	{	// averigua cual fila este en verde
		if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
		{	  ff = i +1; 	}	
	}
  var max 
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina() 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var kad = t.rows(i).cells(0).innerText;
	cad = 'colores.asp'
	cad = cad + '?pos='		+ kad
	cad = cad + '&cli='		+ '<%=cli%>'
	window.location.replace(cad )	;
	//alert(cad)
}
function primera() 
{	var cad = 'colores.asp'
	cad = cad + '?pos='
	cad = cad + '&cli='		+ '<%=cli%>'
	window.location.replace(cad)
}
function atras() 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/BACKcol.asp' 
	cad = cad + '?cod='+ cod 
	cad = cad + '&pag='+ pagesize ;
	cad = cad + '&url=../colores.asp'
	cad = cad + '&cli=' + '<%=cliente%>'
	window.location.replace(cad)	;
}
function ultima() 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/LASTcol.asp?pag='+ pagesize  ;
	cad = cad + '&url=../colores.asp'
	cad = cad + '&cli='		+ '<%=cli%>'
	window.location.replace( cad );
}
function VALIDA()
{
	if (window.thisForm.COD.value == "")
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	cad = window.thisForm.DES.value
	window.thisForm.DES.value = toAlpha(cad)
	return true;
}
function help(PAG,CLI,TEM,CAR)
{	var pag = PAG
	pag = pag + '?cli=' + CLI
	pag = pag + '&DCL=' + '<%=CLI%>'
	var opc = "directories=no,height=400," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=400";
	window.open(pag,'COLORES',opc)
	
}




function BUSCA(url, tbl, cod, des) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.DES.value == '')
	{	alert("Debe informar  la descripción");
		window.thisForm.DES.focus();
	}
	
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cli = '<%=codcli%>'
	var cliente = '<%=cliente%>'
	url = url + '?codcli=' + trim(cli)
	var cad = 'comun/buscaCOLOR.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&cod='+cod;
	cad = cad + '&des='+des;
	cad = cad + '&pre=' + trim(cli) ; 
	cad = cad + '&pref=cliente' ;
	cad = cad + '&cliente=' + ltrim(cliente) 
	cad = cad + '&PK='+ window.thisForm.COD.value + '&KK=' + window.thisForm.DES.value;
	cad = cad + '&url=../'+url
	//alert(cad)
	window.location.replace( cad );
}
</SCRIPT>