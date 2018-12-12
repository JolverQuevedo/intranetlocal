<BODY text=Wheat>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	var cad =		'cod=' + trim(thisForm.COD.value) + '&' ;
		cad = cad + 'des=' + thisForm.DES.value  ;
		cad = cad + '&url=' + url
		cad = cad + '&tbl=' + TBL
		cad = cad + '&PK=' + PK
		cad = cad + '&largo='+ largo
		cad = cad + '&DS=' + DS		
		//alert(cad)
	if (ok == true )
	{ 	window.location.replace(funcionalidad + cad); }
}
function NUEVO_onclick() {
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
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	var cad =	'COD='	 + thisForm.COD.value  + '&' ;
	cad = cad + 'chk=1' 	
	cad = cad + '&url=' + url ;
	cad = cad + '&tbl=' + TBL
	cad = cad + '&PK=' + PK
	cad = cad + '&DS=' + DS		
	//alert(funcionalidad + cad)
	window.location.replace(funcionalidad + cad); 
	return true;
}

function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#FFFFFF'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#F0F0F0'");
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='#DDEBC6'");
		oldrow=pos
		// Rellena los valores en los textbox
				thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
				thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
				thisForm.COD.readOnly= true
		return true;
	}
}

function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	for (i = 1; i<t.rows.length; i++)
	{ // averigua cual fila este en verde
	  if (eval("document.all.fila"+i+".style.backgroundColor") == '#DDEBC6')
	  {		ff = i -1; 	}
	}
	dd(ff);
}
function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	for (i = 1; i<t.rows.length; i++)
	{	// averigua cual fila este en verde
		if (eval("document.all.fila"+i+".style.backgroundColor") == '#DDEBC6')
		{	  ff = i +1; 	}	
	}
  var max 
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
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/BACK0.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url;
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '6'; }
	else 
	{pagesize = 16 ;}
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
	var ff = window.thisForm.DES.value;
	if ( window.thisForm.DES.value  == "" || ff.length > 100) 
	{	alert('Debe Informar la descripción\no la descripción excede los 100 caracteres');
		window.thisForm.DES.focus();
		return false;
	}
	else {	cad = window.thisForm.DES.value;
			window.thisForm.DES.value = toAlpha(cad);
		 }
	return true;
}

</SCRIPT>
