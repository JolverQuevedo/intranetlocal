<body text="navy">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">


function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	// Rellena los valores en los textbox
	thisForm.COD.value = ltrim(t.rows[pos].cells[0].innerText );
	thisForm.DES.value = ltrim(t.rows[pos].cells[1].innerText) ;
    thisForm.CCT.value = ltrim(t.rows[pos].cells[8].innerText) ;
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;
}
function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	if (oldrow>1)
		dd(oldrow-1);
}
function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	
  var max 
  ff =oldrow  + 1
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina() 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = '?cli='+ '<%=Request.QueryString("cli")%>'+ '&pos='+ trim(t.rows[i].cells[0].innerText);
	window.location.replace(url + cad)	;
}
function primera() 
{
    window.location.replace(url  + '?pos='+ '<%=request.querystring("pos")%>'+ '&cli='+ '<%=request.querystring("cli")%>')	;
}
function atras() 
{	var t = document.all.TABLA;
	var cod = t.rows[1].cells[0].innerText; // primer valor del browse
	var cad = 'comun/BACKasig.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&cli='+ '<%=request.querystring("cli")%>';
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima() 
{	
	var cad = 'comun/LASTasig.asp?pag='+ pagesize  ;
	cad = cad + '&cli='+ '<%=request.querystring("cli")%>';
	
	//alert(cad)
	window.location.replace( cad );
}
function ficha2() {

niv = parseInt('<%=nivel%>')
if (niv != 1)
{	alert("OJO: Ud. solo es usuario de lectura")
	return true
    }

var opc =  "directories=no, height=600, hotkeys=no, location=no," ;
	opc += "menubar=no, resizable=YES, left=0, top=0,scrollbars=yes," ;
	opc += "status=no, titlebar=no, toolbar=no, width=800";	
cad = 'FICHAasigna.asp?pos=' + thisForm.COD.value
//alert(thisForm.CLI.value)
cad += '&cli=' + thisForm.CLI.value
cad += '&tel=' + thisForm.DES.value
cad += '&cct=' + thisForm.CCT.value
window.open(cad,'', opc)
}


function imprime()
{	cad = 'REPORTES/prnASIGNA.asp?cct='+ trim(thisForm.CCT.value)
	window.open(cad)
	}
	
function BUSCA() 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.tel.value) == '')
	{	alert("Debe informar al menos la Partida o la Tela");
		window.thisForm.kod.focus();
	}
  // alert()
    cad =url+'?pos=' + trim(window.thisForm.kod.value)
    cad += '&tel=' + ltrim(window.thisForm.tel.value)
    cad += '&cli='+ '<%=request.querystring("cli")%>';
	//alert(cad)
    window.location.replace( cad );
	return true;
}
</script>
