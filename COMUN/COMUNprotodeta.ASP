<body>
<script ID="clientEventHandlersJS" LANGUAGE="jscript" type="text/jscript">
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
	//LLENA(pos,t)
	oldrow=pos
	return true;	
}						
function tempo()
{	cad =  'help/existe2.asp?pos='+(thisForm.COD.value)
	cad += param
	cad += '&col=COD'
	cad += '&url='+pag
    document.all.body0.src=cad
}
//PRIMERA PAGINA
function primera(pos)
{	window.location.replace('detaproto.asp?pos='+ pos)
}
//PAGINA ANTERIOR
function atras(pos)
{ var t = document.all.TABLA;
  cad =  'comun/backprotos.asp?cli=' + pos
  cad += '&pro='   +((t.rows(1).cells(0).innerText))
  cad += '&ver='   +((t.rows(1).cells(1).innerText))
  document.all.body0.style.display='block'
  document.all.body0.src=cad
}
//REGISTRO ANTERIOR
function retrocede()
{ if (oldrow > 1)
    dd(oldrow-1)
}
//REGISTRO SIGUIENTE
function avanza()
{   var t = document.all.TABLA;
    var XX = parseInt(t.rows.length-1,10)
    if (oldrow <XX )
    {    dd(oldrow+1) }
}
//PAGINA SIGUIENTE
function pagina(pos)
{ var t = document.all.TABLA;
  cad = 'detaproto.asp?pos=' + pos
  cad += '&pro=' + (t.rows(t.rows.length-1).cells(0).innerText)
  cad += '&ver=' + (t.rows(t.rows.length-1).cells(1).innerText)
   window.location.replace(cad)
}
//ULTIMA PAGINA
function ultima(pos)
{	cad =  'comun/lastdetaproto.asp?pos='+ pos
//document.all.body0.style.display='block'
  document.all.body0.src=cad
}


</script>
