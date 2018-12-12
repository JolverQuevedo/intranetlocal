<BODY text=Wheat>
<!--#INCLUDE FILE = FUNCIONESCOMUNES.ASP -->
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{	var ok = VALIDA();
	if (ok == true )
	{ 	//window.location.replace(funcionalidad + cad); 		
		thisForm.submit();
	}
}
function NUEVO_onclick() 
{	
	thisForm.COD.value = 'AUTO';
	thisForm.NOM.value = '';
	thisForm.ZON.selectedIndex = -1;
	thisForm.PAI.selectedIndex = -1;
	thisForm.CIU.value = '';
	thisForm.TEL.value = '';
	thisForm.FAX.value = '';
	thisForm.DIR.value = '';
	DEST.style.display = 'none';
	CONT.style.display = 'none';
	TEMP.style.display = 'none';
}
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{
	var pos = parseInt(ff)
	for (i = 1; i<t.rows.length; i++)
		{	// tiene que volver a pintar las 10 lineas en dos tonos
			// pregunta si es divisible por 2 y hace el cambio	
			if ((i%2) ==0)
			{	
				eval("document.all.fila"+i+".style.backgroundColor='#F8FEFB'");
			}
			else
			{
				eval("document.all.fila"+i+".style.backgroundColor='#C5D6D9'");
			}
		}
	for (i = 1; i<t.rows.length; i++)
		{	var celpa = 'fila' + ff;
			// Averigua si el bucle llegó a la linea que hay que pintar en azul
			if (t.rows(i).id == celpa)
			{	// Rellena los valores en los textbox
				thisForm.COD.value = t.rows(pos).cells(0).innerText ;
				thisForm.NOM.value = t.rows(pos).cells(2).innerText ;
				thisForm.DIR.value = t.rows(pos).cells(3).innerText ;
				thisForm.CIU.value = t.rows(pos).cells(4).innerText ;
				var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
				var elemento = thisForm.ZON ;
				thisForm.ZON.selectedIndex = seleindice(subcadena,elemento);
				subcadena =  trim(t.rows(pos).cells(6).innerText) ;
				elemento = thisForm.PAI ;
				thisForm.PAI.selectedIndex = seleindice(subcadena,elemento);
				subcadena =  trim(t.rows(pos).cells(7).innerText) ;
				elemento = thisForm.CLI ;
				thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);	
				thisForm.FAX.value = t.rows(pos).cells(8).innerText ;
				thisForm.TEL.value = t.rows(pos).cells(9).innerText ;
				// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
				eval("document.all."+celpa+".style.backgroundColor='#99cc99'");	
				DEST.style.display = 'block';
				CONT.style.display = 'block';
				return true;	
			}
		}
	}
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
{
	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	//alert(pag + cad)
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
	var pk = 'CLIENTE';		// nombre de la columna
	var url = '<%=urlbase%>';		// pagina de inicio
	var pag = '<%=pagesize%>'; // # de registros a mostrar
	var cad = 'comun/BACKAvios.asp?POS='+ ORD + '&pag='+ pag ;
	cad = cad + '&ALIAS='+ tbl + '&pk='+pk + '&url=../'+ url ;
	cad = cad + '&pre='+TIP;
	cad = cad + '&tipo='+TIP;
	cad = cad + '&pref=tipo';
	window.location.replace( cad )	;
}
function ultima(url,alias,pk) 
{	var pagesize = '<%=pageSize%>';
	var cad = 'comun/lastcomun.asp?pag='+ pagesize ;
	cad = cad + '&ALIAS='+ alias + '&PK=' + pk + '&url=../'+url;
	cad = cad + '&pre='+TIP;
	cad = cad + '&tipo=cliente'
	cad = cad + '&pref=tipo';
	window.location.replace( cad );
}
function VALIDA()
{	cad = window.thisForm.COD.value;
	window.thisForm.COD.value = toAlpha(cad);
	 var ff = window.thisForm.NOM.value
		
	if ( window.thisForm.NOM.value  == "")  
	{	 alert('Debe informar el nombre del cliente');
		 window.thisForm.NOM.focus();
		 return false;
	}
	else {	cad = window.thisForm.NOM.value;
			window.thisForm.NOM.value = toAlpha(cad);
		 }	 
		
	if ( window.thisForm.PAI.selectedIndex  == -1 )
	{	alert('Debe Informar el Pais');
		window.thisForm.PAI.focus();
		return false;
	}
	if ( window.thisForm.ZON.selectedIndex  == -1 )
	{	alert('Debe Informar MERCADO DE  compra ');
		window.thisForm.ZON.focus();
		return false;
	}
	return true;
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	//var cad =	'COD='	 + thisForm.COD.value  + '&' ;
	//cad = cad + 'chk=1'	 
	thisForm.chk.value=1
	thisForm.submit();
	//window.location.replace(funcionalidad + cad); 
	//return true;
}
function BUSCA(url, tbl, ORD, des,pagesize) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.NOM.value == '')
	{	alert("Debe informar lo que desea informar en la descripción");
		window.thisForm.NOM.focus();
		return false;
	}
	
	pagesize = '<%=pagesize%>';
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&ORD=' + ORD + '&url=../'+url + '&des='+des ;
	cad = cad + '&KK='+ window.thisForm.txtDescripcion.value + '&COD=cliente' ;
	window.location.replace( cad );
}
</SCRIPT>
