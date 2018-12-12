<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	//alert(VALIDA())
	/*document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
	*/
	var cad =   'tel=' + trim(thisForm.TEL.value) 
		cad += '&ver=' + trim(thisForm.VER.value)  ;
		cad += '&des=' + toAlpha(Left(thisForm.DES.value,largo2) ) ;
		cad += '&vol=' + trim(thisForm.VOL.value)  ;
		cad += '&lav=' + trim(thisForm.LAV.value)  ;
		cad += '&tbl=' + TBL
	    cad += '&chk=' + chk   
        cad += '&DEK=' + '<%=DEK%>'
		cad += '&url=' + url
		
      //  alert(cad)
	if (ok == true )
	{ 	document.all.ACTIV.src=(funcionalidad + cad); }
}

function NUEVO_onclick() {
chk="0"

if (auto==1)
{	thisForm.VER.readOnly= false;
	thisForm.VER.value = 'AUTO';
	thisForm.VER.readOnly= true;
	thisForm.DES.focus();
}
else
{	thisForm.VER.readOnly= false;
	thisForm.VER.value = '';
	thisForm.VER.focus();
}
thisForm.DES.value = '';
thisForm.LAV.selectedIndex=0
thisForm.LAV.selectedIndex=0
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'tel='	 + trim(thisForm.TEL.value) 
	cad += '&ver=' + trim(thisForm.VER.value)  ;
	cad = cad + '&chk=1' 	
	cad = cad + '&url=' + url ;
	cad = cad + '&tbl=' + TBL
	cad = cad + '&PK=' + PK
	cad = cad + '&DS=' + DS		
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
	thisForm.VER.value = ltrim(t.rows(pos).cells(0).innerText );
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	var subcadena =  trim(t.rows(pos).cells(2).innerText) ;
	var elemento = thisForm.VOL ;
	thisForm.VOL.selectedIndex = seleindice(subcadena,elemento);
	var subcadena =  trim(t.rows(pos).cells(3).innerText) ;
	var elemento = thisForm.LAV ;
	thisForm.LAV.selectedIndex = seleindice(subcadena,elemento);
	thisForm.VER.readOnly= true
	oldrow=pos
	return true;
}
function retrocede() 
{	var t = document.all.TABLA;TEL
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

function imprime()
{		cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + '<%=titulo%>'
	window.open(cad)
}
	

</script>
