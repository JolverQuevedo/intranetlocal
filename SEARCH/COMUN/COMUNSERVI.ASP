<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	//alert(VALIDA())
/*document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
*/
	var cad =   'cod=' + trim(thisForm.COD.value)  ;
        thisForm.DES.value=prepara(thisForm.DES.value)
		cad += '&des=' + rtrim(ltrim(Left(thisForm.DES.value,largo2)))  ;
        cad += '&MON=' + trim(thisForm.MON.value)  ;
        cad += '&MER=' + trim(thisForm.MERMA.value)  ;
        cad += '&UNI=' + trim(thisForm.UNI.value)  ;
        cad += '&CTO=' + trim(thisForm.CTO.value)  ;
		cad += '&url=' + url;
		cad += '&tbl=' + TBL;
		cad += '&PK='  + PK;
		cad += '&DS='  + DS	;
	    cad += '&chk=' + chk;
	    cad += '&TIP=' + thisForm.TIPO.value;  
	    cad += '&LARGO=' + largo    ;
       

	if (ok == true )
	{ 	document.all.ACTIV.src=(funcionalidad + cad); }
}

function NUEVO_onclick() {
chk="0"
if (auto==1)
{	thisForm.COD.readOnly= false;
	thisForm.COD.value = 'AUTO';
	thisForm.COD.readOnly= true;
	thisForm.DES.focus();
}
else
{	thisForm.COD.readOnly= false;
	thisForm.COD.value = '';
	thisForm.COD.focus();
}
thisForm.DES.value = '';
thisForm.MERMA.value = '';
thisForm.CTO.value = '';
thisForm.MON.selectedIndex = -1;
thisForm.UNI.selectedIndex = -1;
thisForm.TIPO.selectedIndex = -1;
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'COD='	 + thisForm.COD.value  ;
	cad += '&chk=1' ;	
	cad += '&url=' + url ;
	cad += '&tbl=' + TBL ;
	cad += '&PK='  + PK ;
	cad += '&DS='  + DS	;
	window.location.replace(funcionalidad + cad); 
	return true;
}

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
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	var subcadena =  trim(t.rows(pos).cells(2).innerText) ;
	var elemento = thisForm.TIPO ;
	thisForm.TIPO.selectedIndex = seleindice(subcadena,elemento);
    thisForm.MERMA.value = ltrim(t.rows(pos).cells(3).innerText) ;
    var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.UNI ;
	thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
    var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
	var elemento = thisForm.MON ;
	thisForm.MON.selectedIndex = seleindice(subcadena,elemento);
    thisForm.CTO.value = ltrim(t.rows(pos).cells(6).innerText) ;
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;
}
function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	if (oldrow>1)
		dd(oldrow-1);
}
function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	
  var max 
  ff =oldrow  + 1
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	window.location.replace(pag  + '?usr=1')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	var cad = 'comun/BACK0.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url;
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	
	var cad = 'comun/LAST0.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias   ;
	cad = cad + '&url=../'+url+ '&PK='+ '<%=indice%>';
	//alert(cad)
	window.location.replace( cad );
}
function VALIDA()
{	
	if (window.thisForm.COD.value == "" && largo > 0 && window.thisForm.COD.value!= 'AUTO')
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	else {	cad = window.thisForm.COD.value;
			ff = trim(window.thisForm.COD.value);
			if(ff.length > largo && largo > 0 && window.thisForm.COD.value!='AUTO')
			{	alert("El código no puede tener más de " + largo + " dígitos")
				return false;
			}
	}
	if (window.thisForm.UNI.selectedIndex<=0)
	{	alert('Seleccione la UNIDAD de medida por favor')
		window.thisForm.UNI.focus();
		return false;
	}		
	if (window.thisForm.MON.selectedIndex<=0)
	{	alert('Seleccione la MONEDA de compra por favor')
		window.thisForm.MON.focus();
		return false;
	}	
	if (trim(window.thisForm.CTO.value)=='')
	{	alert('Informe el COSTO por favor')
		window.thisForm.CTO.focus();
		return false;
	}
	else
	{   window.thisForm.CTO.value = toInt(window.thisForm.CTO.value)
	    if(isDec(window.thisForm.CTO.value)==false)
	    {    window.thisForm.CTO.focus();
	        alert("Valor inválido para el costo")
	        return false;
	    }   
	}
   if (window.thisForm.TIPO.selectedIndex<=0)
	{	alert('Seleccione la TIPO de compra por favor')
		window.thisForm.TIPO.focus();
		return false;
	}	
	return true;
}

function imprime()
{	cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + '<%=TITULO%>'
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
</SCRIPT>
