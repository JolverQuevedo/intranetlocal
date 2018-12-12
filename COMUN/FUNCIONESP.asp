<BODY text=Wheat>
<!--#INCLUDE FILE = FUNCIONESCOMUNES.ASP -->
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
var ventana_ficha=null

function ficha(niv)
{	
	thisForm.ESP.value = '' ;
	var hlp = "FichaPROTO.asp";
	hlp = hlp + "?PRO=" + trim(thisForm.PRO.value);
	hlp = hlp + "&VER=" + trim(thisForm.VER.value);
	var opc = "directories=no,height=600," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=yes," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=yes,titlebar=no,toolbar=no," ;
	opc = opc + "width=800";
	if (niv == 1 ){
		if(ventana_ficha!=null)
			ventana_ficha.close()
		
		ventana_ficha=window.open(hlp,'cc',opc)

		}
	else 
		alert ('Usuario no autorizado a realizar modificaciones')
return true
}

function PRINT()
{	if (trim(thisForm.ESP.value) == '' )
	{	alert("Este proto aún no tiene especificación");
		return false;
	}
	var hlp = "REPORTES/prnSPEC.asp";
	hlp = hlp + "?pro=" + trim(thisForm.PRO.value);
	hlp = hlp + "&VER=" + trim(thisForm.VER.value);
	window.open(hlp)
}

function dd(ff) 
{	var t = document.all.TABLA;
	var pos = parseInt(ff)
	if (parseInt(ff) > 0 && MARCA == 0)
	{	var celpa = 'fila' + ff;
		i = 1 ;
		while (i < t.rows.length)
		{	if ((i%2) == 0)
				eval("document.all.fila"+i+".style.backgroundColor='#F8FEFB'");
			else
				eval("document.all.fila"+i+".style.backgroundColor='#C5D6D9'");
			i++;
		}
		eval("document.all."+celpa+".style.backgroundColor='#99cc99'");
	}
	thisForm.PRO.value = t.rows(pos).cells(1).innerText ;
	thisForm.VER.value = t.rows(pos).cells(2).innerText ;
	thisForm.ESP.value = t.rows(pos).cells(0).innerText ;
	thisForm.TIME.value = t.rows(pos).cells(16).innerText ;
}
function retrocede() 
{ 
var t = document.all.TABLA;
var ff = 1;
  for (i = 1; i<t.rows.length; i++)
  {	// averigua cual fila este en verde
	if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
	{		ff = i -1; 	}
  }
  dd(ff);
}
function avanza() 
{
var t = document.all.TABLA;
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
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = (t.rows.length)-1;
	// captura el valor del último código mostrado en el GRID
	var cad = trim(t.rows(i).cells(1).innerText);
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	
	window.location.replace(pag + '?perfil='+ '<%=nivel%>' )	;
}
function atras() 
{
	var t = document.all.TABLA;
	var ORD = t.rows(1).cells(1).innerText; // primer valor del browse
	var tbl = '<%=alias%>';		// tabla
	var pk = '<%=indice%>';		// nombre de la columna
	var url = '<%=urlbase%>';		// pagina de inicio
	var pag = '<%=pagesize%>'; // # de registros a mostrar
	var cad = 'comun/BACK.asp?POS='+ ORD + '&pag='+ pag ;
	cad = cad + '&ALIAS='+ tbl + '&pk=PROTO&url=../'+ url ;
	//alert(cad)
	window.location.replace( cad )	;
}
function ultima(url,alias,pk) 
{	var pagesize = '<%=pageSize%>';
	var cad = 'comun/last.asp?pag='+ pagesize ;
	cad = cad + '&ALIAS='+ alias + '&PK=' + pk + '&url=../'+url;
	window.location.replace( cad );
}

function BUSCA(url, tbl, ORD, des,pagesize) 
{	if (window.thisForm.PRO.value == '')
	{	alert("Debe informar el numero de proto");
		window.thisForm.PRO.focus();
		return false;
	}
	
	pagesize = '<%=pagesize%>';
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&ORD=' + ORD + '&url=../'+url + '&des='+des ;
	cad = cad + '&KK='+ window.thisForm.PRO.value + '&COD=PROTO' ;
	//alert(cad);
	window.location.replace( cad );
}

</SCRIPT>