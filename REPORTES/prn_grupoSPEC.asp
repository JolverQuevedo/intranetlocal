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
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="../includes/Cnn.inc"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Ficha de Como Medir</title>
</head>
<%
Set RS0 = Server.CreateObject("ADODB.Recordset")
	RS0.ActiveConnection = Cnn
	RS0.CursorType       = 3 'CONST adOpenStatic = 3
	RS0.LockType         = 1 'CONST adReadOnly = 1
	RS0.CursorLocation   = 3 'CONST adUseClient = 3
    set txtConection = nothing
    CLI = REQUEST.cookies("CLI")
    TEM = REQUEST.cookies("TEM")
    EST = REQUEST.cookies("EST")
    sp  = REQUEST.cookies("spe")
    vr  = right(REQUEST.cookies("ver"),3)
    med = REQUEST.cookies("med")
    MMd = REQUEST.cookies("MMD")
%>

<body><center>
 <%response.Cookies("orden") = "0"
    response.Cookies("grupo") = "000" %>
<!--#include file=spec_headgrupo.inc-->      
<img src="../bake/RECUPERAFOTOprn.ASP" />


<% cad = "select * from SPECS_GRUPOS  where SPEC= '"&sp&"' AND VER= '"&vr&"' "
rs0.open cad, cnn
if rs0.recordcount > 0 then rs0.movefirst%>
<%i = 1%>
<%do while not rs0.eof%>  
    <%response.Cookies("orden") = trim(RS0("orden"))
    response.Cookies("grupo") = trim(RS0("grupo")) %>
    <!--#include file=spec_headgrupo.inc-->      
    <!--#include file=prn_fichagrupodeta.inc-->
    <%rs0.movenext%>
    <%i = i +1 %>
<%loop%>

<%RS0.CLOSE%>
</center>
</body>
</html>
