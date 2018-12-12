<BODY text=Wheat>
<!--#INCLUDE FILE = FUNCIONESCOMUNES.ASP -->
<script ID="clientEventHandlersJS" LANGUAGE="javascript">

function FICHA()
{	var hlp= 'FichaTELAS.asp?tel='+trim(thisForm.TELA.value);
	var opc = "height=500,width=600,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=1,resizable=1,scrollbars=1,status=1,toolbar=0" 
niv= parseInt('<%=NIVEL%>'	,10)
if (niv == 1 )
	window.open(hlp,'cc',opc)
else 
	alert ('Usuario no autorizado a realizar modificaciones')
return true
}
function RUTA()
{	var t = document.all.TABLA;
	i = 1 ;
	var ff = 1;
	cod = ''
	for (i = 1; i<t.rows.length/2; i++)
	{	// averigua cual fila este en verde
		if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
		{		cod = ltrim(t.rows(i*2-1).cells(0).innerText );	
				break; 	}
	}
	var opc = "directories=no,height=590," ;
	opc = opc + "hotkeys=no,location=NO," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=790";
	window.open('telas-ruta.asp?cod='+ cod+'&perfil=<%=NIVEL%>',"TELAS_RUTA",opc)	
//window.open('fichaRUTATELAS.asp?cod='+ cod,"HOJA_DE_RUTA_TELAS")
}
function TEJE()
{	var t = document.all.TABLA;
	i = 1 ;
	var ff = 1;
	cod = ''
	for (i = 1; i<t.rows.length/2; i++)
	{	// averigua cual fila este en verde
		if (eval("document.all.fila"+i+".style.backgroundColor") == "'#BBEBC6'")
		{		cod = ltrim(t.rows(i*2-1).cells(0).innerText );	
				break; 	}
	}
	var opc = "height=500,width=600,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=1,resizable=1,scrollbars=1,status=1,toolbar=0" 
window.open('fichaTELATEJ.asp?TEL='+ cod,"RUTA_TEJEDURIA",opc)
}
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#FFFFFF'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#F0F0F0'");
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='#DDEBC6'");
		oldrow=pos
		thisForm.TELA.value = ltrim(t.rows(pos).cells(0).innerText )
	}
}
function retrocede() 
{ 
var t = document.all.TABLA;
var ff = 1;
  for (i = 1; i<t.rows.length/2; i++)
  {	// averigua cual fila este en verde
	if (eval("document.all.fila"+i+".style.backgroundColor") == "'#DDEBC6'")
	{		ff = i -1; 	}
  }
  dd(ff);
}
function avanza() 
{
var t = document.all.TABLA;
var ff = 1;
  for (i = 1; i<t.rows.length/2; i++)
  {	// averigua cual fila este en verde
	if (eval("document.all.fila"+i+".style.backgroundColor") == "'#DDEBC6'")
	{	  ff = i +1; 	}	
  }
  var max 
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = (t.rows.length-1)-1;
	// captura el valor del último código mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	//alert(pag + cad);
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	
	window.location.replace(pag )	;
}
function atras() 
{
	var t = document.all.TABLA;
	var ORD = t.rows(1).cells(0).innerText; // primer valor del browse
	var tbl = '<%=alias%>';		// tabla
	var pk = '<%=indice%>';		// nombre de la columna
	var url = '<%=urlbase%>';		// pagina de inicio
	var pag = '<%=pagesize%>'; // # de registros a mostrar
	var cad = 'comun/BACKTelas.asp?POS='+ ORD + '&pag='+ pag ;
	cad = cad + '&ALIAS='+ tbl + '&pk='+pk + '&url=../'+ url ;
	//alert(cad)
	window.location.replace( cad )	;
}
function ultima(url,alias,pk) 
{	var pagesize = '<%=pageSize%>';
	var cad = 'comun/lastTelas.asp?pag='+ pagesize ;
	cad = cad + '&ALIAS='+ alias + '&PK=' + pk + '&url=../'+url;
	//alert(cad)
	window.location.replace( cad );
}

function BUSCA(url, tbl, ORD, des,pagesize) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.DES.value == '')
	{	alert("Debe informar lo que desea informar en la descripción");
		window.thisForm.DES.focus();
		return false;
	}
	
	pagesize = '<%=pagesize%>';
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&ORD=' + ORD + '&url=../'+url + '&des='+document.all.ds.value ;
	cad = cad + '&KK='+ window.thisForm.DES.value + '&COD=tela' ;
	alert(cad);
	window.location.replace( cad );
}
</SCRIPT>