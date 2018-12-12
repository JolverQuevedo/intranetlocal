<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	/*document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
	*/
	var cad =   'cod=' + trim(thisForm.COD.value)  ;
		cad += '&des=' + Left(thisForm.DES.value,largo2)  ;
		cad += '&url=' + url
		cad += '&tbl=' + TBL
		cad += '&PK='  + PK
		cad += '&DS=DESCRIPCION' 
	    cad += '&chk=' + chk   
	    cad += '&LARGO=' + largo  
	    cad += '&tipo='  + trim(thisForm.TIPO.value)
	    cad += '&marca=' + trim(thisForm.MARCA.value)
	    cad += '&modelo=' + trim(thisForm.MODELO.value)
	    cad += '&galga=' + trim(thisForm.GALGA.value)
	    cad += '&agujas=' + trim(thisForm.AGUJAS.value)
	    cad += '&diametro=' + trim(thisForm.DIAMETRO.value)
	    cad += '&sistemas=' + trim(thisForm.SISTEMAS.value)
	    cad += '&ALIMENTA=' + trim(thisForm.ALIMENTA.value)
	if (ok == true )
	{ 	//alert(cad)
	    document.all.ACTIV.src=(funcionalidad + cad); }
}

function NUEVO_onclick() {
chk="0"
thisForm.TIPO.selectedIndex =-1;
thisForm.MARCA.selectedIndex =-1;
thisForm.MODELO.selectedIndex =-1;
thisForm.GALGA.value = '';
thisForm.AGUJAS.value = '';
thisForm.DIAMETRO.value = '';
thisForm.SISTEMAS.value = '';
thisForm.ALIMENTA.value = '';
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
}
function COPIADOR() 
{
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
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	else
	{ chk = "1" }
	var cad 
	CAD  = 'COD='  + thisForm.COD.value  ;
	cad += '&chk=' + chk  
	cad += '&url=' + url ;
	cad += '&tbl=' + TBL
	cad += '&PK='  + PK
	cad += '&DS='  + DS		
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
	thisForm.COD.readOnly= true;
	var subcadena =  trim(t.rows(pos).cells(2).innerText) ;
	var elemento = thisForm.TIPO ;
	thisForm.TIPO.selectedIndex = seleindice(subcadena,elemento);
    var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.MARCA ;
	thisForm.MARCA.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(6).innerText) ;
	var elemento = thisForm.MODELO ;
	thisForm.MODELO.selectedIndex = seleindice(subcadena,elemento);
	thisForm.GALGA.value = ltrim(t.rows(pos).cells(8).innerText) ;
	thisForm.AGUJAS.value = ltrim(t.rows(pos).cells(9).innerText) ;
	thisForm.DIAMETRO.value = ltrim(t.rows(pos).cells(10).innerText) ;
	thisForm.SISTEMAS.value = ltrim(t.rows(pos).cells(11).innerText) ;
	thisForm.ALIMENTA.value = ltrim(t.rows(pos).cells(12).innerText) ;	
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
	if (trim(window.thisForm.DES.value) == "" )
	{	alert('Debe Informar la Descripción de la Máquina');
		window.thisForm.DES.focus();
		return false;
	}
	else
	    window.thisForm.DES.value = Left(window.thisForm.DES.value, largo2)
	if (window.thisForm.TIPO.selectedIndex==-1 || window.thisForm.TIPO.selectedIndex==0)
	{	alert('Seleccione el tipo de Màquina por favor')
		window.thisForm.TIPO.focus();
		return false;
	}
	if (window.thisForm.MARCA.selectedIndex==-1 || window.thisForm.MARCA.selectedIndex==0)
	{	alert('Seleccione la marca por favor')
		window.thisForm.MARCA.focus();
		return false;
	}
	if (window.thisForm.MODELO.selectedIndex==-1 || window.thisForm.MODELO.selectedIndex==0)
	{	alert('Seleccione el Modelo de Màquina por favor')
		window.thisForm.MODELO.focus();
		return false;
	}
	thisForm.GALGA.value = toInt(thisForm.GALGA.value)
 	if (isInt(thisForm.GALGA.value)== false || ltrim(rtrim(thisForm.GALGA.value))=='')
	{	alert("Dato Inválido")
		window.thisForm.GALGA.focus();
		return false;
	}
	thisForm.AGUJAS.value = toInt(thisForm.AGUJAS.value)
 	if (isInt(thisForm.AGUJAS.value)== false || ltrim(rtrim(thisForm.AGUJAS.value))=='')
	{	alert("Dato Inválido")
		window.thisForm.AGUJAS.focus();
		return false;
	}
	thisForm.DIAMETRO.value = toInt(thisForm.DIAMETRO.value)
 	if (isInt(thisForm.DIAMETRO.value)== false || ltrim(rtrim(thisForm.DIAMETRO.value))=='')
	{	alert("Dato Inválido")
		window.thisForm.DIAMETRO.focus();
		return false;
	}
	thisForm.SISTEMAS.value = toInt(thisForm.SISTEMAS.value)
 	if (isInt(thisForm.SISTEMAS.value)== false || ltrim(rtrim(thisForm.SISTEMAS.value))=='')
	{	alert("Dato Inválido")
		window.thisForm.SISTEMAS.focus();
		return false;
	}
	thisForm.ALIMENTA.value = toInt(thisForm.ALIMENTA.value)
 	if (isInt(thisForm.ALIMENTA.value)== false || ltrim(rtrim(thisForm.ALIMENTA.value))=='')
	{	alert("Dato Inválido")
		window.thisForm.ALIMENTA.focus();
		return false;
	}
			
	return true;
}

function imprime()
{	cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + '<%="TIPOS DE MAQUINAS DE TEJEDURIA"%>'
	window.open(cad)
	}
	
function BUSCA(url, alias) 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el Código o la descripción");
		window.thisForm.kod.focus();
	}
    cad = url+'?pos=' + trim(window.thisForm.kod.value)
    cad += '&des=' + trim(window.thisForm.ds.value)
	window.location.replace( cad );
	return true;
}
</SCRIPT>
