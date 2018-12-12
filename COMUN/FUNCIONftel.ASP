<!--#include file="FUNCIONESCOMUNES.ASP" -->
<script id="clientEventHandlersJS" language="javascript" type="text/jscript">
function GRABA()
{	//llenado()
	if ( trim(thisForm.FAM.value) == '')
		{	alert("Debe informar la Familia de Tela");
			thisForm.FAM.focus();
			return false;
		}
		
	if (trim(thisForm.TIPTEL.value) == '' )
	{	alert("Debe informar el Tipo de tela");
		thisForm.TIPTEL.focus();
		return false;
	}	
	if (trim(thisForm.STAT.value) == '' )
	{	alert("Debe informar el Stat de la tela");
		thisForm.STAT.focus();
		return false;
	}	
	if (trim(thisForm.M1.value) == '')
	{	alert("Debe informar por lo menos un tipo de hilo");
		HELP('help/hlphilos.asp?pos=1')
		return false;
	}	
	if (porcentaje(1) == false)
		{	thisForm.P1.focus();
			return false;
		}
	for (j=2; j<=6; j++)
	{	a = trim(eval("document.all.thisForm.M"+j+".value" ))
		b =	trim(eval("document.all.thisForm.P"+j+".value" ))
		if (isNaN(b)) 
		{	b = 0;	}
		if (a.length == 12 && b == '')
		{	alert("le falta informar Porcentaje de hilado")
			eval("document.all.thisForm.P"+j+".focus()" )
			return false;
		}
	}
	por = 0
	for (v=1; v<7; v++)
	{	if (trim(eval("thisForm.M"+v+".value")) !='' && trim(eval("thisForm.P"+v+".value"))=='')	
		{	alert("Debe Informar el % de Materia Prima")
			eval("thisForm.P"+v+".focus()")
			return false;
		}
	}
	
	for (s=1; s<7; s++)
	{	if (trim(eval("thisForm.P"+s+".value"))!='')
			por += parseFloat(eval("thisForm.P"+s+".value"))
	}
	
	if (parseInt(por,10) < 100)
	{	alert("La suma de los porcentajes de Materia prima no llega a 100%")
		return false;
	}
	thisForm.CMAQ.value = document.all.CODMAQ.innerHTML
	if (trim(thisForm.CMAQ.value) == '' )
	{	alert("Debe informar la Máquina de tejeduría");
		HELP('help/hlpmaquinas.asp')
		return false;
	}
	
		
	if (trim(thisForm.PC.value) == '' || isNaN(parseFloat(thisForm.PC.value)) )
	{	if (trim(thisForm.STAT.value) != "2")
		{	alert("Revise el PM2 crudo");
			thisForm.PC.value='';
			thisForm.PC.focus();
			return false;
		}
		else
			thisForm.PC.value=0;
	}
	at = eval("trim(thisForm.AT.value) == '' || isNaN(parseFloat(thisForm.AT.value))")
	aa = eval("trim(thisForm.AA.value) == '' || isNaN(parseFloat(thisForm.AA.value))")
	if ( at==true && aa==true )
	{	if (trim(thisForm.STAT.value) != "2")
		{	alert("Informe el Ancho abierto o el  Ancho tubular");
			thisForm.AT.focus();
			return false;
		}
		else
		{	thisForm.AT.value = 0 
			thisForm.AA.value = 0
			}
	}
	if (trim(thisForm.PA.value) == '' || isNaN(parseFloat(thisForm.PA.value)) )
	{	alert("Revise el PM2 ACABADO");
		thisForm.PA.value='';
		thisForm.PA.focus();
		return false;
	}
	if (trim(thisForm.UNI.value) == '' )
	{	alert("Debe informar la unidad de medida");
		thisForm.UNI.focus();
		return false;
	}	
	if (trim(thisForm.MON.value) == '')
	{	alert("Debe informar la moneda de compra");
		thisForm.MON.focus();
		return false;
	}		
	if (trim(thisForm.CTO.value) == '' )
	{	thisForm.CTO.value=0;
		return false;
	}	
	thisForm.CONTENIDO.value = toAlpha(thisForm.CONTENIDO.value)
//alert(thisForm.RCOD.value)
//	document.all.ACTIV.src = 'comun/inserTELA.asp?'
	
	PARA  = '?TMIN=' + document.all.TMIN.innerHTML
	PARA += '&TMAX=' + document.all.TMAX.innerHTML	
	PARA += '&TMINL=' + document.all.TMINL.innerHTML
	PARA += '&TMAXL=' + document.all.TMAXL.innerHTML
	PARA += '&Rcod=' + thisForm.RCOD.value	
    
	thisForm.action='comun/inserTELA.asp' + PARA
	thisForm.submit()
}
function PUNTO(obj)
{	var cad;
	cad = trim(obj);
	if (trim(cad)=='.')
		return ''
	else if (cad.substring(0,1) == '.')	
		return ltrim(cad.substring(1, cad.length-1)) ;
	else 
		return obj;
}

function winclave(){

	var hlp = "clavetela.asp";
	var ancho = 450
	var alto =  180
	var izq = ((screen.width - ancho) / 2) + 130
  	var arr = ((screen.height - alto) / 2) - 15
  
	var opc = "directories=no,height="+alto+"," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=no," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width="+ancho+",top=" + arr + ",left=" + izq;
	
	hlp = hlp + "?cod="+trim(thisForm.COD.value);
	window.open(hlp,"_blank",opc)
}
</script>
