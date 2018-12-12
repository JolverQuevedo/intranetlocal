<body text="Wheat">

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function GRABAR_onclick() 
{ var ok = VALIDA();
	//alert(VALIDA())
/*	document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
*/	
	var cad = ''
		cad += '&des=' + Left(thisForm.TIP.value,largo2)  ;
		cad += '&url=' + url
		cad += '&tbl=' + TBL
		cad += '&PK='  + PK
		cad += '&DS='  + DS	
	    cad += '&chk=' + chk   
	    cad += '&LARGO=' + largo 
        cad += '&COD=' + ltrim(thisForm.COD.value );
	    cad += '&TIP=' + ltrim(thisForm.TIP.value ) ;
        cad += '&MOV=' + ltrim(thisForm.MOV.value ) ;
        cad += '&ORI=' + ltrim(thisForm.ORI.value ) ;
        cad += '&DES=' + ltrim(thisForm.DES.value ) ;
        cad += '&OLD=' + ltrim(thisForm.OLD.value ) ;
        cad += '&SER=' + ltrim(thisForm.SER.value ) ;
        cad += '&ENT=' + ltrim(thisForm.ENT.value ) ;
        cad += '&REC=' + ltrim(thisForm.REC.value ) ;
        cad += '&LT1=' + ltrim(thisForm.LT1.value ) ;
        cad += '&LT2=' + ltrim(thisForm.LT2.value ) ;
        cad += '&REA=' + ltrim(thisForm.REA.value ) ;
      //   alert(cad)
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
    thisForm.TIP.value = ''
    thisForm.MOV.value = ''
    thisForm.ORI.value = ''
    thisForm.DES.value = ''
    thisForm.OLD.value = ''
    thisForm.SER.value = ''
    thisForm.ENT.value = ''
    thisForm.REC.value = ''
    thisForm.LT1.value = ''
    thisForm.LT2.value = ''
    thisForm.REA.value = ''
}
else
{	thisForm.COD.readOnly= false;
	thisForm.COD.value = '';
	thisForm.COD.focus();
}
thisForm.DES.value = '';
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
	thisForm.TIP.value = ltrim(t.rows(pos).cells(1).innerText) ;
    thisForm.MOV.value = ltrim(t.rows(pos).cells(2).innerText) ;
    thisForm.ORI.value = ltrim(t.rows(pos).cells(3).innerText) ;
    thisForm.DES.value = ltrim(t.rows(pos).cells(4).innerText) 
    thisForm.OLD.value = ltrim(t.rows(pos).cells(5).innerText) ;
    thisForm.SER.value = ltrim(t.rows(pos).cells(6).innerText) ;
    thisForm.ENT.value = ltrim(t.rows(pos).cells(7).innerText) ;
    thisForm.REC.value = ltrim(t.rows(pos).cells(8).innerText) ;
    thisForm.LT1.value = ltrim(t.rows(pos).cells(9).innerText) ;
    thisForm.LT2.value = ltrim(t.rows(pos).cells(10).innerText) ;
    thisForm.REA.value = ltrim(t.rows(pos).cells(11).innerText) ;
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;
}
function VALIDA()
{	
	
	if (trim(window.thisForm.TIP.value) == "" && largo2 > 0 )
	{	alert('Debe Informar EL tipo de OC');
		window.thisForm.TIP.focus();
		return false;
	}		
	return true;
}

function imprime()
{	cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + '<%=titulo%>'
	window.open(cad)
	}
	
</script>
