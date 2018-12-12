<BODY text=Wheat>
<!--#INCLUDE FILE = FUNCIONESCOMUNES.ASP -->
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
 var opc = "directories=no,height=700," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=yes," ;
	opc = opc + "left=400,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=yes,toolbar=no," ;
	opc = opc + "width=300";
	
function GRABAR_onclick() 
{	var ok = VALIDA();
	document.all.ACTIV.style.visibility = 'hidden';
    document.all.ACTIV.style.height = 2;
	if (ok == true )
	{ 	thisForm.action = "comun/INSERAVI.Asp?CHK=0"
		thisForm.submit()	}
	
}
function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	thisForm.action = "comun/INSERAVI.Asp?CHK=1"
	thisForm.submit()	
	return true;
}
function NUEVO_onclick() 
{	thisForm.COD.value = 'AUTO';
	thisForm.DES.value = '';
	thisForm.UNI.selectedIndex = 0;
	thisForm.MON.selectedIndex = 0;
	thisForm.NIV.disabled=false;
	thisForm.NIV.selectedIndex = 0;
	thisForm.TIP.selectedIndex = 0;
	thisForm.ORI.selectedIndex = 0;
	thisForm.CTO.value = 0;
	thisForm.FAM.value = ''
    thisForm.REA.value = ''
    thisForm.SUN.value = ''
	thisForm.FM.value = ''
    thisForm.cst.checked = false

	thisForm.HLP.style.display='block';
	document.all.EDI.style.display='none'
    var opc = "directories=no,height=700," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=yes," ;
	opc = opc + "left=400,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=yes,toolbar=no," ;
	opc = opc + "width=300";
	document.all.ACTIV.style.visibility = 'visible'

	window.open('help/hlpfamavios.asp','FAM_AVIO',opc)
}
function edita()
{	document.all.DES.value= ''
	document.all.ACTIV.style.visibility = 'visible'
	document.all.ACTIV.src='help/paramavios.asp?fam='+trim(document.all.FM.value)
}

function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='#99CC99'");
		oldrow=pos
			// Rellena los valores en los textbox
			thisForm.COD.value = t.rows(pos).cells(0).innerText ;
			thisForm.DES.value = t.rows(pos).cells(1).innerText ;
			var subcadena =  trim(t.rows(pos).cells(2).innerText) ;
			var elemento = thisForm.UNI ;
			thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
			var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
			var elemento = thisForm.MON ;
			thisForm.MON.selectedIndex = seleindice(subcadena,elemento);
			var subcadena =  trim(t.rows(pos).cells(9).innerText) ;
			var elemento = thisForm.NIV ;
			thisForm.NIV.selectedIndex = seleindice(subcadena,elemento);
			var subcadena =  trim(t.rows(pos).cells(13).innerText) ;
			var elemento = thisForm.ORI ;
			thisForm.ORI.selectedIndex = seleindice(subcadena,elemento);
			var subcadena =  trim(t.rows(pos).cells(11).innerText) ;
			var elemento = thisForm.TIP ;
			thisForm.TIP.selectedIndex = seleindice(subcadena,elemento);
			thisForm.FM.value = t.rows(pos).cells(7).innerText ;
			thisForm.FAM.value = t.rows(pos).cells(8).innerText ;
			thisForm.CTO.value = parseFloat(t.rows(pos).cells(6).innerText) ;
            thisForm.REA.value = t.rows(pos).cells(16).innerText ;
            thisForm.SUN.value = t.rows(pos).cells(21).innerText ;
            thisForm.cst.value = t.rows(pos).cells(23).innerText ;
            if(trim(t.rows(pos).cells(23).innerText)== 'S')
                thisForm.cst.checked= true;
			thisForm.HLP.style.display='none';
			thisForm.NIV.disabled = 'true'
		return true;	
	}
}
function retrocede() 
{ 
var t = document.all.TABLA;
var ff = 1;
  for (i = 1; i<t.rows.length; i++)
  {	// averigua cual fila este en verde
	if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
	{		ff = i -1; 	}
  }
  dd(ff);
}
function avanza() 
{
var t = document.all.TABLA;
var ff = 1;
  for (i = 1; i<t.rows.length; i++)
  {	// averigua cual fila este en verde
	if (eval("document.all.fila"+i+".style.backgroundColor") == "#99cc99")
	{	  ff = i +1; 	}	
  }
  var max 
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina(pag) 
{
	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	//alert(pag + cad)
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	
	window.location.replace(pag )	;
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
{   if (document.all.thisForm.COD.value == 'AUTO')
    {   if (document.all.ACTIV.style.visibility == 'visible')
        parent.item('ACTIV').verifica()
    }   
          
    cc =ltrim(rtrim(window.thisForm.DES.value))
    if (cc.length > 200)
    {   alert("Avise a Sistemas, \nCodigo de Error:\AVIO_DES>200\n"+cc.length)
        return false;
    }
	if (trim(window.thisForm.COD.value) == 'AUTO' && trim(window.thisForm.FM.value)=='' )
	{	window.open('help/HLPFAMAVIOS.ASP')
		return false;
	}
	if ( trim(window.thisForm.NIV.value)  == '') 
	{	alert('Debe Informar el Nivel de Detalle del Avio');
		window.thisForm.NIV.focus();
		return false;
	}
	if ( trim(window.thisForm.ORI.value)  == '') 
	{	alert('Debe Informar el Origen del Avio');
		window.thisForm.ORI.focus();
		return false;
	}
	if ( trim(window.thisForm.TIP.value)  == '') 
	{	alert('Debe Informar el tipo de avio');
		window.thisForm.TIP.focus();
		return false;
	}
	if ( trim(window.thisForm.UNI.value)  == '') 
	{	alert('Debe Informar unidad de medida');
		window.thisForm.UNI.focus();
		return false;
	}
	if ( trim(window.thisForm.MON.value)  == '') 
	{	alert('Debe Informar MONEDA');
		window.thisForm.MON.focus();
		return false;
	}
	if ( trim(window.thisForm.CTO.value)  == '') 
	{	alert('Debe Informar el Costo del avio');
		window.thisForm.CTO.focus();
		return false;
	}
    if ( trim(window.thisForm.REA.value)  == '') 
	{	alert('Debe Informar la cuenta contable a la que pertenece el avio');
		window.thisForm.REA.focus();
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

function calcHeight()
{
  //find the height of the internal page   
  var the_height=
    document.getElementById('ACTIV').contentWindow.
      document.body.scrollHeight;

  //change the height of the iframe
  document.getElementById('ACTIV').height=
      the_height;
}

</SCRIPT>
