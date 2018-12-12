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
		cad += '&des=' + Left(thisForm.DES.value,largo2)  ;
	    cad += '&LARGO=' + largo    ;
		cad += '&url=' + url;
		cad += '&tbl=' + TBL;
		cad += '&PK='  + PK;
		cad += '&DS='  + DS	;
	    cad += '&chk=' + chk;
	    cad += '&MATERIA=' + thisForm.MATERIA.value;  
	    cad += '&TITULO=' + thisForm.TITULO.value;  
	    cad += '&ORIGEN=' + thisForm.ORIGEN.value;  
	    cad += '&ACABADO=' + thisForm.ACABADO.value;  
	    cad += '&UNIDAD=' + thisForm.UNIDAD.value;  
	    cad += '&MONEDA=' + thisForm.MONEDA.value;  
	    cad += '&REALSOFT=' + thisForm.REALSOFT.value;  
	    cad += '&FILAMENTO=' + thisForm.FILAMENTO.value;  
	    cad += '&COSTO=' + thisForm.COSTO.value;  
	if (ok == true )
	{ 	document.all.ACTIV.src=(funcionalidad + cad); }
}

function NUEVO_onclick() {
chk="0"
	thisForm.COD.value = '';
    thisForm.DES.value = '';
    thisForm.MATERIA.selectedIndex = 0;
    thisForm.TITULO.selectedIndex = 0;
    thisForm.ORIGEN.selectedIndex = 0;
    thisForm.ACABADO.selectedIndex = 0;
    thisForm.UNIDAD.selectedIndex = 0;
    thisForm.MONEDA.selectedIndex = 0;
    thisForm.REALSOFT.selectedIndex = 0;
    thisForm.FILAMENTO.value = '';
    thisForm.COSTO.value = '';
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
	var subcadena =  trim(t.rows(pos).cells(11).innerText) ;
	var elemento = thisForm.TITULO ;
	thisForm.TITULO.selectedIndex = seleindice(subcadena,elemento);
	
    thisForm.FILAMENTO.value = ltrim(t.rows(pos).cells(17).innerText) ; 
    thisForm.COSTO.value = ltrim(t.rows(pos).cells(5).innerText) ; 
    var subcadena =  trim(t.rows(pos).cells(12).innerText) ;
	var elemento = thisForm.ORIGEN ;
	thisForm.ORIGEN.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(6).innerText) ;
	var elemento = thisForm.REALSOFT ;
	thisForm.REALSOFT.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(13).innerText) ;
	var elemento = thisForm.ACABADO ;
	thisForm.ACABADO.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(15).innerText) ;
	var elemento = thisForm.UNIDAD ;
	thisForm.UNIDAD.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(3).innerText) ;
	var elemento = thisForm.MONEDA ;
	thisForm.MONEDA.selectedIndex = seleindice(subcadena,elemento);
    var subcadena =  trim(t.rows(pos).cells(14).innerText) ;
	var elemento = thisForm.MATERIA ;
	thisForm.MATERIA.selectedIndex = seleindice(subcadena,elemento);
    
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;
}
function llenado()
{   thisForm.COD.readOnly= false;
    thisForm.DES.readOnly= false;
 
    thisForm.COD.value  = trim(thisForm.MATERIA.value); 
  thisForm.COD.value += thisForm.TITULO.value;
  if(trim(thisForm.FILAMENTO.value)=='')
    thisForm.COD.value += '000';
  else
  { thisForm.FILAMENTO.value = toInt(trim(thisForm.FILAMENTO.value))   
    thisForm.COD.value += strzero(trim(thisForm.FILAMENTO.value),3);
  }
    
  thisForm.COD.value += thisForm.ORIGEN.value;
  thisForm.COD.value += thisForm.ACABADO.value;    
  
  thisForm.DES.value  = thisForm.MATERIA.options(thisForm.MATERIA.selectedIndex).innerHTML;
  // CAMBIA LA ESTRUCTURA DE DESCRIPTOR PARA EL POLIESTER
   if(trim(thisForm.FILAMENTO.value)=='')
    {  thisForm.DES.value += ' TIT. ' + thisForm.TITULO.options(thisForm.TITULO.selectedIndex).innerHTML;
    }
  else
    {  tit  = ' ' + toInt(Left(thisForm.TITULO.options(thisForm.TITULO.selectedIndex).innerHTML,3)) + '/'
       tit += toInt(trim(thisForm.FILAMENTO.value)) + '/' 
       tit += toInt(Right(thisForm.TITULO.options(thisForm.TITULO.selectedIndex).innerHTML,1))
       thisForm.DES.value += tit
    }
   
  thisForm.DES.value += ' ' + thisForm.ORIGEN.options(thisForm.ORIGEN.selectedIndex).innerHTML;  
  thisForm.DES.value += ' ' + thisForm.ACABADO.options(thisForm.ACABADO.selectedIndex).innerHTML;

  thisForm.COD.readOnly= true;
  thisForm.DES.readOnly= true;
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
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	var cad = 'comun/LAST0.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias   ;
	cad = cad + '&url=../'+url+ '&PK='+ '<%=indice%>';
	window.location.replace( cad );
}
function VALIDA()
{	KKK = trim(thisForm.COD.value)
    if (KKK.length !=12)
	{	alert('   Por favor REVISE los datos informados, \nlas caracteristicas básicas están incompletas');
		window.thisForm.MATERIA.focus();
		return false;
	}
	if (window.thisForm.MATERIA.selectedIndex==0)
	{	alert('Seleccione el tipo de MATERIA PRIMA por favor')
		window.thisForm.MATERIA.focus();
		return false;
	}		
	if (window.thisForm.TITULO.selectedIndex==0)
	{	alert('Seleccione el TITULO por favor')
		window.thisForm.TITULO.focus();
		return false;
	}		
	if (window.thisForm.ORIGEN.selectedIndex==0)
	{	alert('Seleccione el ORIGEN por favor')
		window.thisForm.ORIGEN.focus();
		return false;
	}		
	if (window.thisForm.ACABADO.selectedIndex==0)
	{	alert('Seleccione el ACABADO por favor')
		window.thisForm.ACABADO.focus();
		return false;
	}		
	if (window.thisForm.UNIDAD.selectedIndex==0)
	{	alert('Seleccione la UNIDAD de medida por favor')
		window.thisForm.UNIDAD.focus();
		return false;
	}		
	if (window.thisForm.MONEDA.selectedIndex==0)
	{	alert('Seleccione la MONEDA de compra por favor')
		window.thisForm.MONEDA.focus();
		return false;
	}	
	if (trim(window.thisForm.COSTO.value)=='')
	{	alert('Informe el COSTO por favor')
		window.thisForm.COSTO.focus();
		return false;
	}
	else
	{   window.thisForm.COSTO.value = toInt(window.thisForm.COSTO.value)
	    if(isDec(window.thisForm.COSTO.value)==false)
	    {    window.thisForm.COSTO.focus();
	        alert("Valor inválido para el costo")
	        return false;
	    }   
	}

	if (trim(window.thisForm.FILAMENTO.value)!='')
	{	// verificar que sea un entero
	    window.thisForm.FILAMENTO.value = toInt(window.thisForm.FILAMENTO.value);
		if (isInt(window.thisForm.FILAMENTO.value)==false)
		{   window.thisForm.FILAMENTO.focus();
		    alert("Valor inválido para el número de filamentos")
		    return false;
		}
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
