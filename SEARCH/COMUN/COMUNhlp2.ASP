<script ID="clientEventHandlersJS" LANGUAGE="javascript">
oldrow=1
function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	thisForm.COD.value = t.rows(pos).cells(0).innerText ;
	thisForm.DES.value = t.rows(pos).cells(1).innerText ;
	thisForm.TIP.value = t.rows(pos).cells(2).innerText ;
	oldrow=pos
	return true;

}
</SCRIPT>