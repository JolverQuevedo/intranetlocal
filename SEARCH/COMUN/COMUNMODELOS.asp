<BODY text=Wheat>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR() 
{ var ok = VALIDA();
	if (ok == true )
	{ 	
		thisForm.submit(); 
	}
}
function FICHA(pos){
var hlp = "Fichamodelo.asp";
	hlp = hlp + "?cod=" + thisForm.KOD.value;
	hlp = hlp + "&tal=" + thisForm.TIPRAT.value;
var opc = "directories=no,height=500," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=yes," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=800";
	window.open(hlp,'PRENDA_DETALLE',opc)	
}
function NUEVO_onclick() {

thisForm.COD.value = '';
thisForm.KOD.value = '';
thisForm.COD.disabled = true;
thisForm.COD.readOnly = true ;
thisForm.KOD.value = ''
thisForm.chk.value = ''
thisForm.PRO.value=''
thisForm.PROTO.value = ''
thisForm.VER.value= ''
thisForm.VERSION.value = ''
thisForm.MIN.value = ''
thisForm.DES.value = ''
thisForm.LIN.style.display = 'block'
thisForm.TIPRAT.value = ''
thisForm.TAL0.value = ''
thisForm.TAL1.value = ''
thisForm.TAL2.value = ''
thisForm.TAL3.value = ''
thisForm.TAL4.value = ''
thisForm.TAL5.value = ''
thisForm.TAL6.value = ''
thisForm.TAL7.value = ''
thisForm.TAL8.value = ''
thisForm.TAL9.value = ''
thisForm.GEN.value =  ''
thisForm.DESGEN.value =  ''
thisForm.TIPPRE.value =  ''
thisForm.DESTPREN.value =  ''
thisForm.CLI.selectedIndex = -1
thisForm.GRUP.selectedIndex = -1
thisForm.UNI.value =  ''
thisForm.MON.value = ''
thisForm.DESMON.value = ''
thisForm.PREUNI.value = ''
thisForm.LIN.focus();
thisForm.marcatalla.value = 0
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	thisForm.chk.value =1;
	thisForm.submit(); 
	return true;
}
function ddxx(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#F8FEFB'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#C5D6D9'");
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='#99CC99'");
		oldrow=pos
		thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
		thisForm.KOD.value = ltrim(t.rows(pos).cells(0).innerText );
		thisForm.DES.value = ltrim(t.rows(pos).cells(3).innerText );
		thisForm.PROTO.value = ltrim(t.rows(pos).cells(1).innerText );
		thisForm.VERSION.value = ltrim(t.rows(pos).cells(2).innerText );
		thisForm.PRO.value = ltrim(t.rows(pos).cells(1).innerText );
		thisForm.VER.value = ltrim(t.rows(pos).cells(2).innerText );
		var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
		var elemento = thisForm.CLI ;
		thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);
		thisForm.DESGEN.value =  trim(t.rows(pos).cells(6).innerText) ;
		thisForm.DESTPREN.value =  trim(t.rows(pos).cells(7).innerText) ;
		thisForm.GEN.value =  trim(t.rows(pos).cells(13).innerText) ;
		thisForm.TIPPRE.value =  trim(t.rows(pos).cells(14).innerText) ;
		thisForm.MON.value =  trim(t.rows(pos).cells(15).innerText) ;
		thisForm.DESMON.value =  trim(t.rows(pos).cells(16).innerText) ;
		var subcadena =  trim(t.rows(pos).cells(12).innerText) ;
		var elemento = thisForm.UNI ;
		thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
		var subca =  ltrim(t.rows(pos).cells(29).innerText) ;
		var elemento = thisForm.GRUP ;
		thisForm.GRUP.selectedIndex = seleindice(subca,elemento);
		thisForm.PREUNI.value = trim(t.rows(pos).cells(11).innerText );
		thisForm.MIN.value = ltrim(t.rows(pos).cells(9).innerText );

		thisForm.TIPRAT.value = ltrim(t.rows(pos).cells(18).innerText) ;
		thisForm.TAL0.value = ltrim(t.rows(pos).cells(19).innerText) ;
		thisForm.TAL1.value = ltrim(t.rows(pos).cells(20).innerText) ;
		thisForm.TAL2.value = ltrim(t.rows(pos).cells(21).innerText) ;
		thisForm.TAL3.value = ltrim(t.rows(pos).cells(22).innerText) ;
		thisForm.TAL4.value = ltrim(t.rows(pos).cells(23).innerText) ;
		thisForm.TAL5.value = ltrim(t.rows(pos).cells(24).innerText) ;
		thisForm.TAL6.value = ltrim(t.rows(pos).cells(25).innerText) ;
		thisForm.TAL7.value = ltrim(t.rows(pos).cells(26).innerText) ;
		thisForm.TAL8.value = ltrim(t.rows(pos).cells(27).innerText) ;
		thisForm.TAL9.value = ltrim(t.rows(pos).cells(28).innerText) ;
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
	//alert(cod)
	var cad = 'comun/BACKPrendas.asp?pos='+ cod + '&pag='+ pagesize ;
	cad = cad + '&perfil='+niv  ;
	cad = cad + '&alias=PRENDAS'+ '&pk=CODIGO' + '&url='+ url;
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
	var cad = 'comun/lastPrendas.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS=prendas'  ;
	cad = cad + '&perfil='+niv  ;
	cad = cad + '&url=../'+url+ '&PK=codigo';
	//alert(cad)
	window.location.replace( cad );
}
function VALIDA()
{
	if (window.thisForm.DES.value == '' )
	{	alert("Debe informar la descripción");
		thisForm.DES.focus();
		return false;
	}		
	if (trim(thisForm.TIPRAT.value) == '' )
	{	alert("Debe informar la estructura de tallas de la Prenda");
		HELP('help/hlptallas.asp')
		return false;
	}
	if (trim(thisForm.GEN.value) == '' )
	{	alert("Debe informar el género de la Prenda");
		HELP('help/hlpGen.asp')
		return false;
	}
	if (trim(thisForm.TIPPRE.value) == '' )
	{	alert("Debe informar el tipo de Prenda");
		HELP('help/hlptipPREN.asp')
		return false;
	}
	if ( thisForm.CLI.selectedIndex <= 0) 
	{	alert('Debe Informar el Cliente');
		thisForm.CLI.focus();
		return false;
	}
	if ( trim(window.thisForm.UNI.value)  == '') 
	{	alert('Debe Informar unidad de medida');
		window.thisForm.UNI.focus()
		return false;
	}
	if ( trim(window.thisForm.MON.value)  == '') 
	{	alert('Debe Informar la MONEDA');
		HELP('help/hlpMON.asp')
		return false;
	}
	if (trim(window.thisForm.PREUNI.value) == ''&& isNaN(window.thisForm.PREUNI.value))
	{	alert('Debe Informar EL PRECIO BASE');
		return false;
	}
	if ( thisForm.GRUP.selectedIndex <= 0) 
	{	alert('Debe Informar el GRUPO DE LISTA ');
		thisForm.GRUP.focus();
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
	//alert(cad)
	window.location.replace( cad );
}
</SCRIPT>