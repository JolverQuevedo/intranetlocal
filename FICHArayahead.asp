<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=3"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
pos= request.querystring("pos")
des= request.querystring("des")
Dim TITULO
TITULO = "COMBINACIONES PARA LISTADO : " + pos + " --> " + des
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<table width="100%" >
	<tr>
		<td align= "left" width="20%"><img src="imagenes/CERRAR.gif" style="cursor:hand;" alt="" onClick="javascript: top.window.close();" /></td>
		<td align="center">
	        <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center"	width="100%" bordercolor="#f7d975">
	            <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
	        </table>
		</td>
		<td align="right" width="20%"><img src="imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	    <td colspan="3"><hr /></td>
	</tr>
</table>
</body>
</html>
