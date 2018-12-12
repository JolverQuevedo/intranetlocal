<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">

function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{
	var pos = parseInt(ff)
	for (i = 1; i<t.rows.length; i++)
		{	// tiene que volver a pintar las 10 lineas en dos tonos
			// pregunta si es divisible por 2 y hace el cambio	
			if ((i%2) ==0)
			{	
				eval("document.all.fila"+i+".style.backgroundColor='#F8FEFB'");
			}
			else
			{
				eval("document.all.fila"+i+".style.backgroundColor='#C5D6D9'");
			}
		}
	for (i = 1; i<t.rows.length; i++)
		{ 
			var celpa = 'fila' + ff;
			// Averigua si el bucle llegó a la linea que hay que pintar en azul
			if (t.rows(i).id == celpa)
			{	// Rellena los valores en los textbox
				// LA PRIMERA COLUMNA ES EL CODIGO
				// LA SEGUNDA ES LA DESCRIPCION
				thisForm.COD.value = trim(t.rows(pos).cells(0).innerText );
				thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
				// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
				eval("document.all."+celpa+".style.backgroundColor='#99cc99'");		
				return true;
			}
		}
	}
}

</SCRIPT>
