<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
  //alert(VALIDA())
/*  document.all.ACTIV.style.visibility='visible'
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
	    cad += '&TON=' + thisForm.TON.value;  
	    cad += '&TEN=' + thisForm.TEN.value;  
	    cad += '&CLI=' + thisForm.CLI.value;  
	    cad += '&COL=' + thisForm.COL.value; 
	
	if (ok == true )
	{ 	document.all.ACTIV.src=(funcionalidad + cad); }
}

function NUEVO_onclick() {
chk="0"
	thisForm.COD.value = 'AUTO';
    thisForm.TON.selectedIndex = -1;
	thisForm.TEN.selectedIndex = -1;
	thisForm.CLI.selectedIndex = -1;
	thisForm.COL.value = '';
    thisForm.DES.value = '';
    thisForm.TON.disabled=false;
	thisForm.TEN.disabled=false;
	thisForm.CLI.disabled=false;	
}
function elimina()
{	var si
	{si = confirm("� Confirma la Eliminaci�n de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad  =	'COD='	 + thisForm.COD.value  ;
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
    thisForm.COL.value = ltrim(t.rows(pos).cells(8).innerText) ; 
    var subcadena =  trim(t.rows(pos).cells(6).innerText) ;
	var elemento = thisForm.TON ;
	thisForm.TON.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.TEN ;
	thisForm.TEN.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(2).innerText) ;
	var elemento = thisForm.CLI ;
	thisForm.CLI.selectedIndex = seleindice(subcadena,elemento); 
	thisForm.COD.readOnly= true
	thisForm.TON.disabled=true;
	thisForm.TEN.disabled=true;
	thisForm.CLI.disabled=true;
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
{	
	
	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del �ltimo c�digo mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	cad = cad+'&CLIFIL=<%=Request.QueryString("CLIFIL")%>'
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	window.location.replace(pag  + '?usr=1&CLIFIL=<%=Request.QueryString("CLIFIL")%>')	;
}
function atras(alias, pk) 
{	
	//url =url+='CLIFIL=<%=Request.QueryString("CLIFIL")%>&';
	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	var cad = 'comun/BACKcolores.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url;
	cad = cad + '&CLIFIL=<%=Request.QueryString("CLIFIL")%>'
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	
	
	url =url+='?CLIFIL=<%=Request.QueryString("CLIFIL")%>';
	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	var cad = 'comun/LASTcolores.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias   ;
	
	cad = cad + '&url=../'+url+ '&PK='+ '<%=indice%>';
	
	window.location.replace( cad );
}
function VALIDA()
{	if (trim(window.thisForm.DES.value)=='')
	{	alert('Ingrese la Descripcion por favor')
		window.thisForm.DES.focus();
		return false;
	}	
	if (window.thisForm.TON.selectedIndex==0)
	{	alert('Seleccione el TONO por favor')
		window.thisForm.TON.focus();
		return false;
	}		
	if (window.thisForm.TEN.selectedIndex==0)
	{	alert('Seleccione TIPO DE TENIDO por favor')
		window.thisForm.TEN.focus();
		return false;
	}		
	if (window.thisForm.CLI.selectedIndex==0)
	{	alert('Seleccione CLIENTE por favor')
		window.thisForm.CLI.focus();
		return false;
	}	
	return true;
}

function imprime()
{	
	cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + '<%=TITULO%>'
	window.open(cad)
}
	
function BUSCA(url, alias) 
{	if(window.thisForm.kod != undefined && window.thisForm.ds != undefined && window.thisForm.CLIEFILTRO != undefined){
		if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '' && trim(window.thisForm.CLIEFILTRO.value) == '')
		{	alert("Debe informar al menos el C�digo o la descripci�n");
			window.thisForm.kod.focus();
		}
		
	}
	
    	var kod=(window.thisForm.kod )?trim(window.thisForm.kod.value):"";
		var des =(window.thisForm.ds )?window.thisForm.ds.value:"";
		var clie=(window.thisForm.CLIEFILTRO )?trim(window.thisForm.CLIEFILTRO.value):"";
		cad = url+'?pos=' + kod
		cad += '&des=' + des
		cad += '&CLIFIL=' + clie
		//alert(cad)
		window.location.replace( cad );
		return true;
}
seleindice('<%=Request.QueryString("CLIFIL")%>',window.thisForm.CLIEFILTRO)
</script>
