<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1

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
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;	
}
function FICHA()
{ if (brow!= '1')
    return true;
  else
  { hlp += '?dat1='+thisForm.COD.value + '&dat2=' + thisForm.DES.value
    window.open(hlp)
  }
}
function tempo()
{	cad =  'help/existe.asp?pos='+(thisForm.COD.value)
	cad += param
	cad += '&col=COD'
	cad += '&url=../tablas.asp?'
    document.all.bake.src=cad
    }
function NUEVO()
{	if (brow != '1')
  { thisForm.COD.value = '';
    thisForm.COD.readOnly = false;
    thisForm.DES.value = '';
    thisForm.COD.disabled = false;
    thisForm.COD.tabIndex=0
    thisForm.COD.focus();
    return true;
  }
  else
  { window.open(hlp)
  }
}
function primera()
{	window.location.replace(pag) }
function ultima()
{	cad =  'comun/last.asp?pos='+(thisForm.COD.value)
cad += param
cad += '&url=../tablas.asp?'
document.all.bake.src=cad
}
function siguiente()
{  var t = document.all.TABLA;
   window.location.replace(pag + (t.rows(t.rows.length-1).cells(0).innerText))
}
function anterior()
{   var t = document.all.TABLA;
    cad =  'comun/prev.asp?pos='+((t.rows(1).cells(0).innerText))
	cad += param
	cad+= '&size='+size
	cad += '&url=../tablas.asp?'
    document.all.bake.src=cad
}    
function retrocede()
{   if (oldrow > 1)
        dd(oldrow-1)
}
function GRABA()
{   cad =  'comun/insertbl.asp?pos='+(thisForm.COD.value)
	cad += param
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&url=../tablas.asp?'
    document.all.bake.src=cad
}

function DELE()
{   cad  =  'comun/insertbl.asp?pos='+(thisForm.COD.value)
    cad += param
    cad += '&des=' + (thisForm.DES.value)
    cad += '&chk=1'
    cad += '&url=../tablas.asp?'

    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)
    {   //alert(cad)
    document.all.bake.src=cad
    }
}
function fBuscar(pos)
{   cad =  'tablas.asp?pos=' + (pos)
    cad += '&tbl=' + tabla
	cad += '&size='+size
	top.window.location.replace(cad)
}
function avanza()
{   var t = document.all.TABLA;
    if (oldrow < t.rows.length-1)
        dd(oldrow+1)
}


</script>

