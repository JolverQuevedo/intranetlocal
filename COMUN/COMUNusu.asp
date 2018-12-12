<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	var cad =		 'cod=' + thisForm.COD.value ;
		cad = cad + '&des=' + thisForm.DES.value ;
		cad = cad + '&nom=' + thisForm.NOM.value ;
		cad = cad + '&url=' + url
		cad = cad + '&tbl=' + TBL
		cad = cad + '&PK=' + PK
		cad = cad + '&DS=' + DS		
		//alert(cad)
	if (ok == true )
	{ 	window.location.replace(funcionalidad + cad); }
}
function NUEVO_onclick() {

thisForm.DES.value = '';
thisForm.NOM.value = '';
thisForm.COD.value = '';
	thisForm.COD.disabled = false;
	thisForm.COD.readOnly = false ;
thisForm.DES.value = '';
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
				thisForm.NOM.value = ltrim(t.rows(pos).cells(2).innerText) ;
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
	var cad = 'comun/BACK0.asp?pos='+ cod + '&pag='+ pagesize ;
	cad = cad + '&alias=usuarios&pk='+pk + '&url=../usuarios.asp?';
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
	var cad = 'comun/last.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias  + '&PK='+ '<%=indice%>'; ;
	cad = cad + '&url=../'+url
	//alert(cad)
	window.location.replace( cad );
}
function VALIDA()
{
	if (window.thisForm.COD.value == "")
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	if ( window.thisForm.DES.value  == "" ) 
	{
		alert('Debe Informar el PASSWORD');
		window.thisForm.DES.focus();
		return false;
	}
	if ( window.thisForm.NOM.value  == "" ) 
	{
		alert('Debe Informar el Nombre Completo');
		window.thisForm.NOM.focus();
		return false;
	}
	else {	cad = window.thisForm.NOM.value;
			window.thisForm.NOM.value = toAlpha(cad);
		 }
	return true;
}
function BUSCA(url, tbl, cod, des) 
	//	&& operador "AND"
	//  || operador "OR"
{	if (window.thisForm.NOM.value == '' )
	{	alert("Debe informar  EL Nombre del usuario");
		window.thisForm.NOM.focus();
	}
	
	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	
	var cad = 'comun/busca.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl='+ tbl + '&cod='+cod;
	cad = cad + '&url=../'+url + '&des='+des
	cad = cad + '&PK='+ window.thisForm.COD.value + '&KK=' + window.thisForm.NOM.value;
	//alert(cad)
	window.location.replace( cad );
}

</SCRIPT>
