<body>

<script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/jscript">

var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";

function edita()
{	perf = cInt('<%=txtPerfil %>',10)
    if (perf > 1)
    {   alert("Usuario de Lectura")
        return true
    }
    var pos = parseInt(oldrow,10)
	var t = document.all.TABLA;
    oc = trim(t.rows(pos).cells(0).innerText )
    TIPO = trim(t.rows(pos).cells(4).innerText )
    cad = 'Fichaliqui.asp?oc=' + oc+'&tip='+ TIPO
    alert(cad)
    window.open(cad,'LIQUI_OC',opc)
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
</script>
