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
<%
CLI = REQUEST.QUERYSTRING("CLI")
TEM = REQUEST.QUERYSTRING("TEM")
EST = REQUEST.QUERYSTRING("EST")
Spe = REQUEST.QUERYSTRING("Spe")
med = REQUEST.QUERYSTRING("med")
MMD = REQUEST.QUERYSTRING("MMD")
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin=0 border=0 text="#000000">


<%=spe%>



</body>
</HTML>
