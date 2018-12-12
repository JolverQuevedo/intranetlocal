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
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNdos.ASP"-->
<script language="javascript" type="text/jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERMANTSUBMENU.asp'
var oldrow=1
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<% POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT MENU, subMENU, PROGRAMA  " & _
		" FROM submenu  WHERE ESTADO = 'A'                  " & _
		" ORDER BY convert(integer, submenu)                " 

'Response.Write (CAD)'''''''''''''''''''''
CAD =   " SELECT MENU, DESMENU FROM MENU" & _
        " WHERE ESTADO = 'A'            " & _
        " ORDER BY DESMENU              "
	RS.Open CAD, Cnn
	CONT = 1
IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title></title></head>
<body topmargin="0" leftmargin="0" rightmargin="0" border="0" text="black">
<form name="thisForm" method="post" action="COMUN/INSERMANTSUBMENU.ASP">
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img style="CURSOR: hand" alt="atras"
			 onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=9');" src="imagenes/ATRAS.gif" />
		</td>
		<td align= "center">
			<font face="arial" size= "3" color="darkblue"><b>SELECCIONAR EL MENU :</b></font>
		</td>
		<td width="30%"><select id="MENU" class="DATOSGRANDE" onchange="CAMBIA(this.value)">
		<option value="NULL"></option>
		<% DO WHILE NOT RS.EOF%>
		<option value='<%=RS("MENU") %>'><%=RS("DESMENU") %></option>
		<%RS.MOVENEXT %>
		<%LOOP %>
		</select> 
		</td>
		<td align="right" width="15%"> 
		  	<img src="imagenes/logo.GIF"  alt="" />
		  </td>
        </tr>
	<tr><td colspan="4"><hr /></td>
	</tr>
</table>
<iframe id="SUBMENU" src="" frameborder="0" width="100%" height="80%"></iframe>

<script language=javascript type="text/jscript">
function CAMBIA(opc)
{   cad = 'submenudeta.asp?pos='+thisForm.MENU.value
    document.all.SUBMENU.src= cad
}
</script>

</form>
</body>
</html>
