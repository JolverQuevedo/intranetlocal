	<BODY text=Wheat>
<!--#INCLUDE FILE = FUNCIONESCOMUNES.ASP -->
<script ID="clientEventHandlersJS" LANGUAGE="javascript">

function VALIDA()
{	aColor = Array()
	aCant = Array()
	aColor[0] = thisForm.COL0.value
	aCant[0] = 1
	if (aColor[0]== '')
	{	alert('Debe informar por lo menos un COLOR por artículo')
		HELP('help/hlpCOLORESARTICULO.asp?cli='+thisForm.CLI.value, 0)
		return false;
	}
	for (i=3;i<37; i+=3)
	{	for(j=0; aColor.lenght; j++ )
		{	if (eval("thisForm.COL"+i+".value")== aColor[j]) 
			alert('Código de Color Duplicado, REVISE')
			return false;
		}
	}
	thisForm.action='comun/inserfichamodelo.asp'
	//alert("submit")
	thisForm.submit();
}

</SCRIPT>
