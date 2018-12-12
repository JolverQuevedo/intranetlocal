<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
  //alert(VALIDA())
/*document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
  */
    if (ok == true )
	{ 	var cad =   'cod=' + trim(thisForm.COD.value);
		cad += '&des=' + toAlpha(Left(thisForm.DES.value,largo2));
	    cad += '&LARGO=' + largo;
		cad += '&tbl=' + TBL;
		cad += '&PK='  + PK;
		cad += '&DS='  + DS;
	    cad += '&chk=' + chk;
        cad += '&tel=' + trim(thisForm.TEL.value);
	    cad += '&nume=' + thisForm.NUME.value;  
	    cad += '&RAP=' + thisForm.RAP.value;  
	    cad += '&OBS=' + ltrim(thisForm.OBS.value);  
	    cad += '&FRA=' + thisForm.FRA.value;  
	    cad += '&CLI=' + thisForm.CLI.value;  
	    cad += '&COL=' + thisForm.COL.value;  
        cad += '&usr=' + '<%=trim(txtUsuario)%>'
        opc = ''        
    
       if(chk=='4') 
       {    var si
	        si = confirm("¿ Confirma la Modificación de este Registro y la eliminación/n de los datos heredados en la secuencia? ");
	        if (si == false)  
                {  return false;}
           
            opc= 'ACTUALIZA'
       }
    
    //   alert()
       cad += '&opc=' + opc
       cad += '&url=' + url;
    //  alert(funcionalidad+cad)
       document.all.ACTIV.src=(funcionalidad + cad); 
    }
}

function NUEVO_onclick() {
chk="0"
	thisForm.COD.value = 'AUTO';
	thisForm.CLI.selectedIndex = -1;
	thisForm.COL.value  = '';
    thisForm.DES.value  = '';
    thisForm.NUME.value = '';
    thisForm.RAP.value  = '';
    thisForm.FRA.value  = '';
    thisForm.OBS.value  = '';
	thisForm.CLI.disabled=false;	
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad  =	'COD='	 + thisForm.COD.value;
		cad += '&chk=1';	
		cad += '&url=' + url;
		cad += '&tbl=' + TBL;
		cad += '&PK='  + PK;
		cad += '&DS='  + DS;
	window.location.replace(funcionalidad + cad); 
	return true;
}

function dd(ff) 
{	var pos = parseInt(ff,10);
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	// Rellena los valores en los textbox
	cor = 'rayasec.asp?pos='+trim(t.rows(pos).cells(0).innerText)+'&TEL='+ trim(t.rows(pos).cells(9).innerText);
    //alert(cor)
    top.window.frames.item("rightFrame").window.location.replace(cor);
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
    thisForm.COL.value = ltrim(t.rows(pos).cells(2).innerText) ; 
    thisForm.NUME.value = ltrim(t.rows(pos).cells(3).innerText); 
    thisForm.RAP.value = ltrim(t.rows(pos).cells(4).innerText) ; 
    thisForm.FRA.value = ltrim(t.rows(pos).cells(7).innerText) ; 
    NUME = ltrim(t.rows(pos).cells(3).innerText); 
    RAPP = ltrim(t.rows(pos).cells(4).innerText) ; 
    FRAN = ltrim(t.rows(pos).cells(7).innerText) ; 
	var subcadena =  trim(t.rows(pos).cells(5).innerText) ;
	var elemento  = thisForm.CLI;
	thisForm.CLI.selectedIndex = seleindice(subcadena,elemento); 
    thisForm.OBS.value = ltrim(t.rows(pos).cells(8).innerText) ; 
	thisForm.COD.readOnly = true;
	//thisForm.CLI.disabled = true;
	oldrow=pos;	
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
  ff =oldrow  + 1;
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina(pag) 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cod = t.rows(i).cells(0).innerText;
	window.location.replace('rayados.asp?pos=' + cod + '&tel='+'<%=tel%>');
}
function primera(pag) 
{	window.location.replace('rayados.asp?pos=' + '<%=pos%>' + '&tel='+'<%=tel%>')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	pagesize = '<%=pagesize%>';
	var cad = 'comun/BACKrayas.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&tel=' + '<%=tel%>'
	window.location.replace(cad);
}
function ultima(url,alias,pk) 
{	pagesize = '<%=pagesize%>';
	var cad = 'comun/LASTrayas.asp?pos=&pag='+ pagesize ;
	cad = cad + '&tel=' + '<%=tel%>';
	window.location.replace( cad );
}
function VALIDA()
{	if (trim(window.thisForm.DES.value)=='')
	{	alert('Ingrese la Descripcion por favor');
		window.thisForm.DES.focus();
		return false;
	}		
	if (window.thisForm.CLI.selectedIndex==0)
	{	alert('Seleccione CLIENTE por favor');
		window.thisForm.CLI.focus();
		return false;
	}	
	if (trim(window.thisForm.NUME.value)=='')
	{	alert('Ingrese el 	numero de colores que conforman la raya');
		window.thisForm.NUME.focus();
		return false;
	}		
	if (trim(window.thisForm.RAP.value)=='')
	{	alert('Ingrese el largo del Rapport que forma la raya');
		window.thisForm.RAP.focus();
		return false;
	}	
		if (trim(window.thisForm.FRA.value)=='')
	{	alert('Ingrese el número de franjas que forma la raya');
		window.thisForm.FRA.focus();
		return false;
	}		
	if (parseInt(window.thisForm.FRA.value,10)< parseInt(window.thisForm.NUME.value,10))
	{   alert("El número de FRANJAS no puede ser menor al Número de Colores de la RAYA");
	    window.thisForm.FRA.value = '';
	    window.thisForm.FRA.focus();
	    return false;
	}
	
	return true;
}

function imprime()
{	cad = 'REPORTES/prnrayatela.asp?tel='+ trim(document.all.TEL.value) +'&pos=' + trim(document.all.COD.value)

	window.open(cad);
	}
	
function BUSCA(url, alias) 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el Código o la descripción");
		window.thisForm.kod.focus();
	}
    cad = url+'?pos=' + trim(window.thisForm.kod.value);
    cad += '&des=' + ltrim(window.thisForm.ds.value);
	window.location.replace( cad );
	return true;
}
</script>
