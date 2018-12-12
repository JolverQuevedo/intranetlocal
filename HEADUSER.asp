<%@ Language=VBScript %>
<% Response.Buffer = true %>
<html xmlns="http://www.w3.org/1999/xhtml">

<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="HITEPIMA.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNdos.ASP"-->
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
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
' recibe tabla, primary key, y descripcion
tbl = trim(application("owner"))+".USUARIOS"
DS = "USUARIO"

cad =	"select * from "&TBL&" order by "&DS&" "

	RS.Open CAD, Cnn
IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head></head>
<body topmargin=0 leftmargin=20 rightmargin=20 border="0" text="black">
<table width="100%">
	<tr>
		<td align= left width="15%">
			<img style="CURSOR: 
			hand"
			 onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=9');" src="imagenes/ATRAS.gif" >
			
		</td>
		<td align= middle WIDTH=10%>
			<font face=arial size= 3 color=darkblue><B>USUARIO :</B></font>
		</td>
		<td width=30%><select id="user" class="DATOSGRANDE" ONCHANGE="CAMBIA()">
		<OPTION VALUE= NULL></OPTION>
		<% DO WHILE NOT RS.EOF%>
		<option value='<%=RS("USUARIO") %>'><%=RS("usuario") %></option>
		<%RS.MOVENEXT %>
		<%LOOP %>
		</select> 
		</td>
		
		<td align=right width="15%"> 
		  	<img src="imagenes/logo.Gif" BORDER=0  ONCLICK="CAMBIA(this.value)"
		  	STYLE="CURSOR:HAND" >
		  </td>
        </tr></tr>
	<tr>
	<td colspan=4>
			<hr>
		</td>
	</tr>
</table>

<script>
function CAMBIA(opc)
{   cad = 'menuusr.asp?pos='+document.all.user.value
    top.window.frames[2].location.replace(cad)
}
</script>

</form>
</body>
</html>
