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
		subcadena =  trim(t.rows(pos).cells(2).innerText) ;
		elemento = thisForm.CLI ;
		thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);	
		thisForm.CLI.disabled = true
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
		oldrow=pos
		return true;
	}
}
function NUEVO()
{	thisForm.COD.value = '';
	thisForm.COD.readOnly = false;
	thisForm.DES.value = '';
	thisForm.CLI.disabled = false;	
	thisForm.COD.disabled = false;
	thisForm.CLI.selectedIndex = -1;
	thisForm.COD.tabIndex=0
	thisForm.COD.focus();
	return true;
}
function GRABA()
{	var cad = 'comun/inserTEM.asp';
	chk='0'
	cad = cad + '?COD=' + trim(thisForm.COD.value);
	cad = cad + '&CLI=' + thisForm.CLI.value;
	cad = cad + '&chk=' + chk;
	if (ltrim(toAlpha(thisForm.DES.value))== '')
	{	alert("Debe informar el nombre del color");
		return false;
	}
	cad = cad + '&des=' + ltrim(toAlpha(thisForm.DES.value));
	cad = cad + '&url=TEMPORADAS.asp';
	//alert(cad)
	window.location.replace(cad)	 
}
function DELE()
{ if (trim(thisForm.COD.value) == '')	
  {		alert("No tiene registros que eliminar");
		return true;
	}
	if (confirm("¿ Realmente desea anular esta Temporada ?")== true)
	{	chk = '1';
		GRABA();
	}
return true;		
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
	cad = 'TEMPORADAS.asp'
	cad = cad + '?pos='		+ kad
	cad = cad + '&cli='		+ '<%=cli%>'
	window.location.replace(cad )	;
}
function primera() 
{	var cad = 'TEMPORADAS.asp'
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
	var cad = 'comun/BACKtem.asp' 
	cad = cad + '?cod='+ cod 
	cad = cad + '&pag='+ pagesize ;
	cad = cad + '&url=../TEMPORADAS.asp'
	cad = cad + '&cli=' + '<%=cliente%>'
	window.location.replace(cad)	;
}
function ultima() 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/LASTTEM.asp?pag='+ pagesize  ;
	cad = cad + '&url=../TEMPORADAS.asp'
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
	window.open(pag,'temporadas',opc)
	
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
	var cad = 'comun/buscaTEM.asp?pagesize='+ pagesize ;
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