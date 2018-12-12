<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	var cad =		'cod=' + thisForm.COD.value + '&' ;
		cad = cad + 'des=' + toAlpha(thisForm.DES.value)  ;
		cad = cad + '&tbl=' + TBL
		cad = cad + '&cli=' + '<%=cli%>'  ;
		cad = cad + '&PK=' + PK
		cad = cad + '&DS=' + DS	
		cad = cad + '&tip=' + trim(thisForm.TIPPRE.value)		
		cad = cad + '&gen=' + trim(thisForm.GEN.value)	
		cad = cad + '&url=' + url
		cad = cad + '&cliente=' + '<%=cliente%>'
		//alert(cad)
	if (ok == true )
	{ 	window.location.replace(funcionalidad + cad); }
}
function NUEVO_onclick() {
thisForm.COD.value = '';
thisForm.COD.disabled = false;
thisForm.COD.readOnly = false ;
thisForm.DES.value = '';
thisForm.GEN.disabled = false
thisForm.TIPPRE.disabled = false
thisForm.GEN.value = ''
thisForm.DESGEN.value = ''
thisForm.TIPPRE.value = ''
thisForm.DESTPREN.value = ''
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'COD='	 + thisForm.COD.value  + '&' ;
	cad = cad + 'chk=1' 	
	cad = cad + '&url=' + url ;
	cad = cad + '&cliente=' + cliente;
	cad = cad + '&des=' + thisForm.DES.value  ;
	cad = cad + '&cli=' + '<%=cli%>'  ;
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
				thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
				thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
				thisForm.GEN.value = ltrim(t.rows(pos).cells(4).innerText) ;
				thisForm.DESGEN.value = ltrim(t.rows(pos).cells(5).innerText) ;
				thisForm.TIPPRE.value = ltrim(t.rows(pos).cells(2).innerText) ;
				thisForm.DESTPREN.value = ltrim(t.rows(pos).cells(3).innerText) ;
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
	kag = 'ESTILOS.ASP'
	kag = kag +'?cli=' + '<%=cli%>'
	window.location.replace(kag + '&pos='+cad)	;
}
function primera(pag) 
{	kag = 'DETAESTILO.ASP'
	kag = kag +'?cli=' + '<%=cli%>'
	window.location.replace(kag+ '&pos=0')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/BACKEST.asp'
	cad = cad + '?POS='		+ cod 
	cad = cad + '&pag='		+ pagesize ;
	cad = cad + '&cli='		+ '<%=cli%>'
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/lastEST.asp?pag='+ pagesize  ;
	cad = cad + '&cli='  + '<%=cli%>'
	window.location.replace( cad );
}
function VALIDA()
{
	if (window.thisForm.COD.value == "")
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	thisForm.GEN.disabled = false
	thisForm.TIPPRE.disabled = false
	if (window.thisForm.GEN.value == "")
	{	alert('Debe Informar el Género');
		HELP('HELP/HLPGEN.asp')
		return false;
	}
	if (window.thisForm.TIPPRE.value == "")
	{	alert('Debe Informar el Tipo de Prenda');
		HELP('HELP/HLPTIPPREN.asp')
		return false;
	}
	
	return true;
}
function BUSCA(url, tbl, cod, des) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.DES.value == '' && window.thisForm.COD.value == '')
	{	alert("Debe informar  la descripción");
		window.thisForm.DES.focus();
	}
	
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cli = '<%=cli%>'
	var cliente = '<%=cli%>'
	url = url + '?codcli=' + trim(cli)
	var cad = 'comun/buscaCOLOR.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&cod='+cod;
	cad = cad + '&des='+des;
	cad = cad + '&pre=' + trim(cli) ; 
	cad = cad + '&pref=cliente' ;
	cad = cad + '&cli=' + ltrim(cli) 
	cad = cad + '&PK='+ window.thisForm.COD.value + '&KK=' + window.thisForm.DES.value;
	cad = cad + '&url=../'+url
	//alert(cad)
	window.location.replace( cad );
}

</SCRIPT>
