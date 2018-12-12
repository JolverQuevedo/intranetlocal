<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />

<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=0;
var url = '../FAMAVIOS.asp?pos='
var alias = 'FAMAVIOS'
var pre=''
var tipo =''
var oldrow =1
var olddata =''
</script>
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
	pageSize = 100

'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "FAMAVIOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "FAMAVIOS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "FAMILIAS DE AVIO"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	
	dd(ff);
}
</script>
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT                " & _
		" CODIGO as COD,        " & _
		" DESCRIPCION AS DES,   " & _
		" TIPOAVIO  AS TIP      " & _
		" from "&ALIAS&"        " & _
		" where ESTADO = 'A'    " & _ 
		" ORDER BY DESCRIPCION  " 
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp2.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" text="#000000">
<form name="thisForm" METHOD="post" >
<table WIDTH=100%>
	<tr>
		<td align="left" width="5%"><img src="../imagenes/cerraR.gif" style="cursor:hand;" onclick="javascript: window.close();" /></td>
		<td align= "center"><font face=arial size= 3 color=DarkBlue><B><%=titulo%></b></font></td>
		<td align="center" width="5%"><img src="../imagenes/logo.GIF"  /></TD>
        </tr>
	</tr>
	<tr>
	<td COLSPAN=3>
			<hr>
		</td>
	</tr>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100% cellpadding=2  cellspacing=1 bordercolor=White bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%		LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<TD align="center" class="AMERICANwhite"><%=RS.FIELDS(I).NAME%></TD>
<%next%>	
</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN
cont=1%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor="<%=application("color1") %>"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 		
				ondblclick="redir('<%=cont%>')">
		<% else %>
			<tr bgcolor="<%=application("color2") %>"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  
				ondblclick="redir('<%=cont%>')">
	<%end IF%>

	<td class="DESCRIPTORnegro" >&nbsp;&nbsp;&nbsp;<%=TRIM(RS.FIELDS.ITEM(0))%>&nbsp;&nbsp;</td>
    <td class="DESCRIPTORnegro" ><%=TRIM(RS.FIELDS.ITEM(1))%></td>
    <td class="DESCRIPTORnegro" >&nbsp;&nbsp;&nbsp;<%=TRIM(RS.FIELDS.ITEM(2))%>&nbsp;&nbsp;</td>
	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
  <tr style="display:none" >
    <td><input type="text" id="COD" name="COD" width="10%" /></td>
    <td><input type="text" id="DES" name="DES" width="10%"  /></td>     
    <td><input type="text" id="TIP" name="TIP"  width="10%"  /></td>           
  </tr>
</table>

<%END IF %>
</TR></TD>
</TABLE>
<br>
<script>
dd2('1');
function redir(cont)
{	
    window.opener.window.thisForm.FM.value = thisForm.COD.value;
	window.opener.window.thisForm.FAM.value = thisForm.DES.value;
	window.opener.window.thisForm.DES.value = thisForm.DES.value;
	//window.opener.window.thisForm.DES.value = thisForm.DES.value;
	window.opener.window.thisForm.TIP.value = thisForm.TIP.value;
	var subcadena =  trim(thisForm.TIP.value) ;
	var elemento = window.opener.window.thisForm.TIP ;
	window.opener.window.thisForm.TIP.selectedIndex = seleindice(subcadena,elemento);
	cad = 'help/paramavios.asp?fam='+trim(thisForm.COD.value);

	window.opener.window.document.all.ACTIV.src=cad
	//alert(thisForm.TIP.value)
	this.window.close();
}
</script>    
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</BODY>
</HTML>
