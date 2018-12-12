<body>

<script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/jscript">

function NUEVO_onclick() {
cad= ficha + "."
chk="0"
window.open(cad)
}
function fichas() {
cad = ficha + thisForm.COD.value
niv = parseInt('<%=nivel%>')
if (niv != 1)
{	alert("OJO: Ud. solo es usuario de lectura")
	return true
    }
var opc =  "directories=no, height=600, hotkeys=no, location=no," ;
	opc += "menubar=no, resizable=YES, left=0, top=0,scrollbars=yes," ;
	opc += "status=no, titlebar=no, toolbar=no, width=800";	
window.open(cad,'', opc)
}



function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	// llena el codigo del PK activo para edici�n en ficha
	
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
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del �ltimo c�digo mostrado en el GRID
	var cad ='<%=Request.QueryString("pos")%>';
   // alert((pag + cad + '&ofi='+t.rows(i).cells(0).innerText)	)
    //return true
	window.location.replace(pag + cad + '&ofi='+t.rows(i).cells(0).innerText)	;
}
function primera(pag) 
{	window.location.replace(pag  + '?usr=1'+'&pos='+'<%=Request.QueryString("pos")%>'+'&ofi=')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	var cad = 'comun/BACKofis2.asp?ofi='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&CLI='+ '<%=Request.QueryString("pos")%>';
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	var cad = 'comun/LASTofis2.asp?pag='+ pagesize  ;
	cad = cad + '&CLI='+ '<%=Request.QueryString("pos")%>';
	
	//alert(cad)
	window.location.replace( cad );
}

function imprime()
{	cad = 'REPORTES/prnofis.asp?CLI=' +'<%=Request.QueryString("pos")%>';
	window.open(cad)
	}
	
function BUSCA(url, alias) 
{	if (trim(document.all.kod.value) == '' && trim(document.all.pro.value) == ''&& trim(document.all.est.value) == '')
	{	alert("Debe informar algun dato");
		window.thisForm.kod.focus();
	}
    if (trim(document.all.kod.value) != '')
        document.all.kod.value = strzero(trim(document.all.kod.value),8) 

    if (trim(document.all.pro.value) != '')
        document.all.pro.value = strzero(trim(document.all.pro.value),10) 
    cad = url+'?ofi=' + document.all.kod.value +'&pos='+'<%=Request.QueryString("pos")%>'+ '&pro=' + document.all.pro.value + '&est=' + document.all.est.value
    //alert(cad)
	window.location.replace( cad );
	return true;
}


</script>
