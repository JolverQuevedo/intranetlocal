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
	LLENA(pos,t)
	oldrow=pos
	return true;	
}						
function tempo()
{	cad =  'help/existe2.asp?pos='+(thisForm.COD.value)
	cad += param
	cad += '&col=COD'
	cad += '&url='+pag
    document.all.bake.src=cad
}
function primera()
{	window.location.replace(pag)
}
function ultima()
{	cad =  'comun/last2.asp?pos='+(thisForm.COD.value)
  cad += param
  cad += URL
  document.all.bake.src=cad
}
function siguiente()
{ var t = document.all.TABLA;
  cad = pag + '&pos=' +(t.rows(t.rows.length-1).cells(0).innerText)
  // OJO: pag tiene que venir con el primer parámetro (nnn.asp?xx=99)
  window.location.replace(cad)
}
function anterior()
{ var t = document.all.TABLA;
  cad =  'comun/prev2.asp?pos='+((t.rows(1).cells(0).innerText))
  cad += param
  cad += '&size='+size
	cad += '&url=' + pag
  document.all.bake.src=cad
}
function retrocede()
{ if (oldrow > 1)
    dd(oldrow-1)
}
function avanza()
{   var t = document.all.TABLA;
    var XX = parseInt(t.rows.length-1,10)
    if (oldrow <XX )
    {    dd(oldrow+1) }
}

</script>

