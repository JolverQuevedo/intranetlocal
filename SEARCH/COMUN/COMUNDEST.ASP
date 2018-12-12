<body>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ 
    var ok = VALIDA();
	/*
	document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
    */
	var cad =   'cod=' + trim(thisForm.COD.value)  ;
		cad += '&des=' + thisForm.DES.value  ;
	    cad += '&chk=' + chk;
	    cad += '&DIR=' + thisForm.DIR.value;  
	    cad += '&ZIPC=' + thisForm.ZIPC.value;  
	    cad += '&PAIS=' + thisForm.PAIS.value;  
	    cad += '&cli='  + thisForm.CLI.value  ;
       
	if (ok == true )
	{ //	document.all.ACTIV.STYLEDISPLAY='block'
    document.all.ACTIV.src=(funcionalidad + cad); }

}

function NUEVO_onclick() {
chk="0"
thisForm.COD.readOnly= false;
thisForm.COD.value = 'AUTO';
thisForm.COD.readOnly= true;
thisForm.DES.focus();

thisForm.DES.value = '';
thisForm.DIR.value = '' ;
thisForm.ZIPC.value =''; 
thisForm.PAIS.selectedIndex = -1;

}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'COD='	 + thisForm.COD.value  ;
	cad += '&chk=1' ;
    cad += '&cli='+ thisForm.CLI.value  ;

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
	thisForm.DIR.value = ltrim(t.rows(pos).cells(2).innerText) ;
	thisForm.ZIPC.value = ltrim(t.rows(pos).cells(3).innerText) ;	
	var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.PAIS ;
	thisForm.PAIS.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
	var elemento = thisForm.GRUP;
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
	window.location.replace('detadestin.asp?cli='+'<%= Request.QueryString("CLI")%>'+ '&pos=' + cad)	;
}
function primera(pag) 
{	kad = 'detadestin.asp?cli='+'<%= Request.QueryString("CLI")%>'+ '&pos='
    //alert(kad)
    window.location.replace(kad)	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('<%=nivel%>')
	pagesize = '<%=pagesize%>';
	var cad = 'comun/BACKdestin.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&cli='+ '<%= Request.QueryString("CLI")%>' 
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
	if (window.thisForm.COD.value == ""  && window.thisForm.COD.value!= 'AUTO')
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	if (trim(window.thisForm.DES.value) == '' )
	{	alert("Debe informar el nombre del Destino");
		window.thisForm.DES.focus();
        return false;
	}	
    if (window.thisForm.PAIS.selectedIndex == -1 )
	{	alert("Debe informar el PAIS");
		window.thisForm.PAIS.focus();
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
    
    cad += '&hlp='+'<%=hlp%>'
    alert(cad)
	window.location.replace( cad );
	return true;
}
</SCRIPT>
