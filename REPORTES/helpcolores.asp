<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
	<meta http-equiv="X-UA-Compatible" content="IE=10"/>

<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = './helpcolores.asp?'
var alias = 'VIEW_COLORES'
var TBL = 'COLORES'
var PK  = 'CODIGO'
var DS  = 'DESCRIPCION'
var largo = 8  // es el largo del PK (se usa en el dataentry)
var largo2 = 100  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
'if nivel = 1 then	pagesize = 10 else pagesize =20
pagesize=1000
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_COLORES"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "./helpcolores.asp?elid="&request.QueryString("elid")&"&cliente="&request.QueryString("cliente")&"&"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "Help DE COLORES"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = '../comun/INSERCOLORES.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=11"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
<form name="thisForm" id="thisForm" method="post" action="COLORES.asp">
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then	pos = ""

des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then	des = ""

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pagesize&" * " & _
		" from "&ALIAS&"  WHERE " & _
        " EDO = 'A' and codcli='"&Request.QueryString("cliente")&"' AND"
        if len(TRIM(DES))>0 then
            cad = cad + " "&DS&" >= '"&DES&"' " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " "&indice&" >= '"& POS &"'" & _
            " ORDER BY  descripcion   " 
        end if
        'response.write(cad)
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<%  RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("<font color=Application('titulo')>")
		RESPONSE.Write("TABLA VACIA")	
		RESPONSE.Write("</font>")
		SINDATOS =0
		'RESPONSE.End()
	END IF	
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
'*********************************************************************%>
<table id="TABLA" align="center"  width="100%" bordercolor="<%=application("color2")%>"
	  bgcolor="<%=application("borde")%>"  cellpadding="2"  cellspacing="1"  border="1">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center" ><font face="arial" color="<%=APPLICATION("COLOR2")%>" size="1"><b><%=TRIM(RS.FIELDS(I).NAME)%></b></font></td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>

<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" ondblclick="seleccionar('<%=TRIM(RS.FIELDS.ITEM(1))%>')">       
		<%for i=0 to LIMITE%>
			<td class="DESCRIPTORnavy" ><%=TRIM(RS.FIELDS.ITEM(I))%></b>&nbsp;</td>
	  	<%NEXT%>	
		<%RS.MOVENEXT%>
		<%CONT = CONT + 1%>
  </tr>
	<%loop%>
	
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="../imagenes/primera.gif" style="cursor:hand;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="../IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR" onClick="atras(alias, '<%=indice%>')" style="CURSOR:HAND" /></td>
		<td><img src= "../imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="../imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="../imagenes/next.gif" alt="PAGINA SIGUIENTE"	onclick="pagina('<%=urlBase%>'+'?pos=')" style="CURSOR:HAND" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "../imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>', '<%=RS.Fields.Item(0).Name%>')" 
		    style="cursor:hand;" /></td>
	    <td><img src="../imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:hand;" /></td>
        <td><img src="../imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:hand;" /></td>
	    <td id="seeker" name="seeker" style="display:none">
	        <table align="center" width="100%" bordercolor="#<%=application("color2")%>" bgcolor="<%=application("color1")%>" 
	         cellpadding="0"  cellspacing="1"  border="1">
	          <tr>  
	                <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		                <b><%=pk%></b></font></td>
		            <td><input id="kod" name="kod" value="" /></td>    
	          </tr>
	          <tr>  
	                <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		                <b><%=DS%></b></font></td>
		            <td><input id="ds" name="ds" value="" /></td>    
	          </tr>
	          <tr>  
	                <td align="center" style="cursor:hand" onClick="document.all.seeker.style.display='none'"><font face="arial" color="red" size="1">
		                <b><u>(X) Cerrar</u></b></font></td>
		            <td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:hand" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		                <font face="arial" color='<%=Application("Titulo")%>' size="1"><b><U>FILTRAR</U></b></font></td>
	          </tr>
	         </table> 
	    </td>	
	</tr>
	</table>
<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<%Set   RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.CursorType       = 3 'CONST adOpenStatic = 3
		RS2.LockType         = 1 'CONST adReadOnly = 1 %>
 <!--#include file="../COMUN/COMUNCOLORES.ASP"-->
<script type="text/jscript" language="jscript">
function seleccionar(value){
	//alert(value);
    console.log("window.opener.document.getElementById('<%=request.QueryString("elid")%>').value('"+value+"')");
	eval("window.opener.document.getElementById('<%=request.QueryString("elid")%>').focus()");
    eval("window.opener.document.getElementById('<%=request.QueryString("elid")%>').value=('"+value+"')");
    
    window.close();
}
function BUSCA(url, alias) 
{	
    if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el C�digo o la descripci�n");
		window.thisForm.kod.focus();
	}
    cad = url+'pos=' + trim(window.thisForm.kod.value)
    cad += '&des=' + ltrim(window.thisForm.ds.value)
	window.location.replace( cad );
	return true;
}
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
dd2('1');
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		//eval("DATAENTRY.style.display='block'");
		thisForm.COD.maxLength=largo
		thisForm.DES.maxLength=largo2
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {   thisForm.kod.maxLength=largo
		        //thisForm.ds.maxLength=largo2
		    }
		}   function GRABAR_onclick() 
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
	// captura el valor del �ltimo c�digo mostrado en el GRID
	var cad = t.rows(i).cells(0).innerText;
	window.location.replace(pag + cad)	;
}
function primera(pag) 
{	window.location.replace(pag  + '?usr=1')	;
}
function atras(alias, pk) 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	niv =('1')
	pagesize = '1000';
	var cad = 'comun/BACK0.asp?pos='+ trim(cod) + '&pag='+ pagesize ;
	cad = cad + '&alias='+ alias + '&pk='+pk + '&url='+ url;
	window.location.replace(cad)	;
}
function ultima(url,alias,pk) 
{	niv =('1')
	pagesize = '1000';
	var cad = 'comun/LAST0.asp?pag='+ pagesize  ;
	cad = cad + '&ALIAS='+ alias   ;
	cad = cad + '&url=../'+url+ '&PK='+ 'CODIGO';
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
{	cad = 'REPORTES/prnTBL.asp?pk=' + PK + '&ds=' + DS+ '&tbl=' +alias + '&tit=' + 'Help DE COLORES'
	window.open(cad)
	}
	
function BUSCA(url, alias) 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el C�digo o la descripci�n");
		window.thisForm.kod.focus();
	}
    cad = url+'?pos=' + trim(window.thisForm.kod.value)
    cad += '&des=' + ltrim(window.thisForm.ds.value)
	window.location.replace( cad );
	return true;
}
		function dd(ff) 
		{	var pos = parseInt(ff,10)
			var t = document.all.TABLA;
			if ((oldrow%2) ==0)
				eval("document.all.fila" + oldrow + ".style.backgroundColor='#F0F0F0'");
			else
				eval("document.all.fila" + oldrow + ".style.backgroundColor='#FFFFFF'");
			// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
			eval("document.all.fila"+ff+".style.backgroundColor='#DDEBC6'");
			
			oldrow=pos
			return true;
		}
 
	</script>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
