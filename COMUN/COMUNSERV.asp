<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{	var ok = VALIDA();
	var costo = '<%=costo%>' 
	var cad =		'cod=' + thisForm.COD.value ;
		cad = cad + '&des=' + thisForm.DES.value  ;
		cad = cad + '&MON=' + thisForm.MON.value  ;
		cad = cad + '&CTO=' + thisForm.CTO.value  ;
		cad = cad + '&MER=' + thisForm.MER.value  ;
		cad = cad + '&SER=' + thisForm.SER.value  ;
		cad = cad + '&UNI=' + thisForm.UNI.value  ;
		cad = cad + '&url=' + url + '?costo=' + trim(costo)
		cad = cad + '&tbl=' + TBL
		cad = cad + '&PK=' + PK
		cad = cad + '&DS=' + DS		
		 
		//alert(cad)
	if (ok == true )
	{ 	window.location.replace(funcionalidad + cad); }
}
function NUEVO_onclick() {

thisForm.COD.value = 'AUTO';
thisForm.DES.value = '';
thisForm.MON.selectedIndex = -1;
thisForm.SER.selectedIndex = -1;
thisForm.UNI.selectedIndex = -1;
thisForm.CTO.value = '';
thisForm.MER.value = '';


}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'COD='	 + thisForm.COD.value  + '&' ;
	cad = cad + 'chk=1' 	
	cad = cad + '&url=' + url ;
	cad = cad + '&tbl=' + TBL
	cad = cad + '&PK=' + PK
	cad = cad + '&DS=' + DS		
	//alert(funcionalidad + cad)
	window.location.replace(funcionalidad + cad); 
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
				// LA PRIMERA COLUMNA ES EL CODIGO
				// LA SEGUNDA ES LA DESCRIPCION
				thisForm.COD.value = trim(t.rows(pos).cells(0).innerText );
				thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
				thisForm.MER.value = ltrim(t.rows(pos).cells(2).innerText) ;
				var subcadena =  trim(t.rows(pos).cells(3).innerText) ;
				var elemento = thisForm.MON ;
				thisForm.MON.selectedIndex = seleindice(subcadena,elemento);
				thisForm.CTO.value = ltrim(t.rows(pos).cells(4).innerText) ;	
				var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
				var elemento = thisForm.SER ;
				thisForm.SER.selectedIndex = seleindice(subcadena,elemento);
				var subcadena =  trim(t.rows(pos).cells(7).innerText) ;
				var elemento = thisForm.UNI ;
				thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);				
				
				
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
	var cad = 'comun/BACKServicio.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url 
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/LASTServicio.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias   ;
	cad = cad + '&url=../'+url+ '&PK='+ '<%=indice%>';
	//alert(cad)
	window.location.replace( cad );
}
function VALIDA()
{	var ff = window.thisForm.DES.value;
	if ( window.thisForm.DES.value  == "" || ff.length > 100) 
	{	alert('Debe Informar la descripción\no la descripción excede los 100 caracteres');
		window.thisForm.DES.focus();
		return false;
	}
	else 
	{	cad = window.thisForm.DES.value;
		window.thisForm.DES.value = toAlpha(cad);
	}
	cos = trim(thisForm.MER.value)
	if ( cos.length == 0  )
	{	alert("Debe informar  el % de MERMA del servicio");
		thisForm.MER.focus();
		return false;
	}
	if ( isNaN(cos)== true)
		{	alert("El porcentaje de Merma DEBE ser un número ")
			thisForm.MER.focus();
			return false;}
	if (parseFloat(cos)> 100)
	{	alert("El porcentaje de merma NO DEBE SER MAYOR A 100%");
		thisForm.MER.focus();
		return false;
	}
	if (thisForm.SER.selectedIndex== -1)
	{	alert("No ha, seleccionado el Tipo de Servicio");
		thisForm.SER.focus();
		return false;
	}
	if (thisForm.UNI.selectedIndex== -1 || trim(thisForm.UNI.value) == '' )
	{	alert("No ha, seleccionado la UNIDAD de Servicio");
		thisForm.UNI.focus();
		return false;
	}		 		 
			 
	if (thisForm.MON.selectedIndex== -1)
		{	alert("No ha, seleccionado Moneda");
			thisForm.MON.focus();
			return false;
		}
	if (thisForm.CTO.value == '' ||thisForm.CTO.value == 0 || isNaN(thisForm.CTO.value) )
	{	alert("Por favor informe el costo")
		thisForm.CTO.focus();
		return false;
	}
	
	return true;
}
function BUSCA(url, tbl, cod, des) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (trim(window.thisForm.srch.value) == '' )
	{	alert("Debe informar  la descripción");
		window.thisForm.srch.focus();
	}
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&cod='+cod;
	cad = cad +  '&des='+des
	cad = cad + '&PK=' + '&KK=' + window.thisForm.srch.value;
	cad = cad +'&url=../'+url 
	cad = cad +'&MARK='+ '<%=costo%>'
	//alert(cad)
	window.location.replace( cad );
}

</SCRIPT>
