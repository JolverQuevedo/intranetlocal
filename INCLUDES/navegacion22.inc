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
		//LLENA(pos,t)
		oldrow=pos
		return true;
		}

function EDITA(ff) {
	var t = document.all.TABLA;
	var pos = parseInt(ff, 10)
	COD = ltrim(t.rows(pos).cells(0).innerText);
	ECL = ltrim(t.rows(pos).cells(1).innerText);
	DES = ltrim(t.rows(pos).cells(2).innerText);
	OBS = ltrim(t.rows(pos).cells(3).innerText);
	ART = ltrim(t.rows(pos).cells(4).innerText);
	DMOD = ltrim(t.rows(pos).cells(5).innerText);
	GEN = trim(t.rows(pos).cells(6).innerText);
	DGEN = trim(t.rows(pos).cells(7).innerText);
	TIP = trim(t.rows(pos).cells(8).innerText);
	TPRE = trim(t.rows(pos).cells(9).innerText);
	CON = trim(t.rows(pos).cells(10).innerText);
	FOT = trim(t.rows(pos).cells(11).innerText);
	datos = '&cod=' + COD + '&ECL=' + ECL + '&DES=' + DES;
	datos += '&ART=' + ART + '&GEN=' + GEN + '&DMODELO=' + DMOD;
	datos += '&TIP=' + TIP + '&CON=' + CON + '&FOT=' + FOT;
	//alert(datos)
	// variable que manda los datos al proto
	HLP = parseInt('<%=request.querystring("hlp")%>',10)
	//alert(HLP)
	if (HLP == 1) {
		window.opener.document.all.EST.value = COD;
		window.opener.document.all.ECL.value = ECL;
		window.opener.document.all.DESE.value = DES;
		window.opener.document.all.FOT.src = "BAKE/recuperaFOTOESTILO.asp?ID=" + COD + "&CLI=" + '<%=pos%>';
		window.opener.document.all.FOT.width = "200";
		window.opener.document.all.GEN.value = GEN;
		window.opener.document.all.DGEN.value = DGEN;
		window.opener.document.all.TIP.value = TIP;
		window.opener.document.all.TPRE.value = TPRE;
		window.close();
		}
	else 
	{	window.open('fichaest.asp?cli=' + clien + datos) 	}
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
{	cad = 'detaestilo.asp?pos='+pos 
	window.location.replace(cad)
	}
	function atras()
	{	var t = document.all.TABLA;
	cad =  'comun/prevestilo.asp?pos='+pos+ '&est=' + ((t.rows(1).cells(0).innerText))+'&hlp=' + '<%=Request.QueryString("HLP")%>'
		document.all.bake.style.display='block'
		document.all.bake.src=cad
		}

		function retrocede()
		{ if (oldrow > 1)
		dd(oldrow-1)
		}

		function pagina()
		{	var t = document.all.TABLA;
		cad = 'detaestilo.asp?pos='+pos + '&est=' + (t.rows(t.rows.length-1).cells(0).innerText)+ '&hlp='+'<%=request.querystring("hlp")%>'
	//alert(cad)
	window.location.replace(cad)
}
		
function ultima()
{	cad =  'comun/lastestilo.asp?pos='+pos + '&est=' + '<%=est%>' + '&hlp='+ '<%=Request.QueryString("HLP")%>'
	document.all.bake.style.display='block'
	document.all.bake.src=cad
	}
	
	
function avanza()
{   var t = document.all.TABLA;
	var XX = parseInt(t.rows.length-1,10)
	if (oldrow <XX )
{    dd(oldrow+1) }
}

</script>

