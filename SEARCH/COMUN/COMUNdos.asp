<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
		oldrow=pos
		return true;
	}
}
</SCRIPT>