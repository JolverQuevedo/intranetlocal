<body>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">

var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
function NUEVO() {
    cad = 'FichaOC.asp?oc='
    //alert(cad)
    window.open(cad,'FICHA_OC',opc)
}
function edita()
{	var pos = parseInt(oldrow,10)
	var t = document.all.TABLA;
    oc = trim(t.rows(pos).cells(0).innerText )

     sit = parseInt(trim(t.rows(pos).cells(8).innerText ),10);
     if (sit  == 7)
     {   alert("Orden de Compra ANULADA")
        return true;
     }
    cad = 'FichaOC.asp?oc=' + oc
    //alert(cad)
    window.open(cad,'FICHA_OC',opc)
}
function elimina()
{	var pos = parseInt(oldrow,10)
	var t = document.all.TABLA;
    sit = parseInt(trim(t.rows(pos).cells(8).innerText ),10);
    
    switch(sit)
 {
 case 1:
    anu()
    break;
 case 2:
    anu()
    break;
 case 3:
       alert("Orden de Compra entregada por el proveedor")
    return true;
    break;
 case 4:
       alert("Orden de Compra tiene recepcion parcial")
    return true;
    break;
 case 5:
       alert("Orden de Compra recibida en su totalidad")
    return true;
    break;
 case 6:
       alert("Orden de Compra ya liquidada")
    return true;
    break;
 default:
    alert("Orden de Compra ANULADA")
    return true;
 }
	return true;
}
function anu()
{   var si
	{si = confirm("¿ Confirma la Eliminación de esta Orden de Compra ? ");} 
	if (si == false)
	{ return false;}
    var pos = parseInt(oldrow,10)
	var t = document.all.TABLA;

	cad=  'comun/deleoc.asp?oc=' + trim(t.rows(pos).cells(0).innerText );
    cad += '&fecha='+ trim(t.rows(pos).cells(1).innerText )
	window.location.replace(cad); 

}

function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
    //alert(ff)
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	oldrow=pos
	return true;
}

function imprime()
{	var pos = parseInt(oldrow,10)
	var t = document.all.TABLA;
    
     sit = parseInt(trim(t.rows(pos).cells(8).innerText ),10);
     if (sit  == 7)
     {   alert("Orden de Compra ANULADA")
        return true;
     }

	cad=  'reportes/prnoc.asp?oc=' + trim(t.rows(pos).cells(0).innerText );
	window.open(cad)
	}
	
function BUSCA(url, alias) 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el Código o la descripción");
		window.thisForm.kod.focus();
	}
    cad = url+'?pos=' + trim(window.thisForm.kod.value)
    cad += '&des=' + ltrim(window.thisForm.ds.value)
	window.location.replace( cad );
	return true;
}
</SCRIPT>
