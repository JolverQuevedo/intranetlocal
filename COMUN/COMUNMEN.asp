<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR() 
{ var ok = VALIDA();
	
	if (ok == true )
	{ 	thisForm.COD.readOnly = false;
		thisForm.COD.disabled = false;
		thisForm.PRG.readOnly = false;
		thisForm.PRG.disabled = false;
		thisForm.submit() }
}
function NUEVO_onclick() {
thisForm.COD.value = 'AUTO';
thisForm.MEN.value = '';
thisForm.PRG.value = 'SUBMENU.ASP?TIPO=';
thisForm.MEN.focus();

}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	thisForm.CHK.value = 1
	thisForm.COD.readOnly = false;
	thisForm.COD.disabled = false;
	thisForm.PRG.readOnly = false;
	thisForm.PRG.disabled = false;
	thisForm.submit();
	return true;
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
		{ 
			var celpa = 'fila' + ff;
			// Averigua si el bucle llegó a la linea que hay que pintar en azul
			if (t.rows(i).id == celpa)
			{	// Rellena los valores en los textbox
				thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
				thisForm.MEN.value = ltrim(t.rows(pos).cells(1).innerText) ;
				thisForm.PRG.value = ltrim(t.rows(pos).cells(2).innerText) ;
				
				// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
				eval("document.all."+celpa+".style.backgroundColor='#99cc99'");		
				return true;
			}
		}
	}
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
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	window.location.replace(pag  + '?usr=1')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; } 
	else 
	{pagesize = 16 ;}
	var cad = 'comun/BACK.asp?cod='+ cod + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url;
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '16'; }
	else 
	{pagesize = 15 ;}
	var cad = 'comun/last.asp?pag='+ trim(pagesize)  ;
	cad = cad + '&ALIAS='+ alias   ;
	cad = cad + '&url=../'+trim(url)+ '&PK=MENU'
	window.location.replace( cad );
}



function VALIDA()
{		
	var ff = window.thisForm.MEN.value;
	if ( window.thisForm.MEN.value  == "" ) 
	{	alert('Debe Informar el TITULO del Menú');
		window.thisForm.PRG.focus();
		return false;
	}
	
	return true;
}
function BUSCA(url, tbl, cod, des) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.DES.value == '' && window.thisForm.COD.value == '')
	{	alert("Debe informar al menos el Código o la descripción");
		window.thisForm.COD.focus();
	}
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&cod='+cod;
	cad = cad + '&url=../'+url + '&des='+des
	cad = cad + '&PK='+ window.thisForm.COD.value + '&KK=' + window.thisForm.DES.value;
	alert(cad)
	window.location.replace( cad );
}
</SCRIPT>
