<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
pro = LEFT(Request.QueryString("PRO"),10)
VVV = right(Request.QueryString("PRO"),3)
'RESPONSE.Write(VVV)
cad = "SELECT TALLA, orden FROM [PROTO-TALLAS] WHERE PROTO = '"&PRO&"' AND VERSION = '"&vvv&"' ORDER BY ORDEN"
rs.open cad,cnn
rs.movefirst
t=0
do while not rs.eof%>
    <Script type="text/jscript" language="jscript">
        t = parseInt('<%=t%>',10)
        talla = '<%=rs("talla")%>'
        eval("top.window.opener.window.thisForm.x" + t + ".value=talla")
    </script>
    <% rs.movenext
        t= t + 1
    loop%>
     <Script type="text/jscript" language="jscript">
         fob = '<%=formatnumber(request.querystring("fob"),2,,true) %>'
         eval("top.window.opener.window.thisForm.FOB1.value=fob")
         eval("top.window.opener.window.thisForm.FOB2.value=fob")
         eval("top.window.opener.window.thisForm.FOB3.value=fob")
         eval("top.window.opener.window.thisForm.FOB4.value=fob")
         eval("top.window.opener.window.thisForm.FOB5.value=fob")
         eval("top.window.opener.window.thisForm.FOB6.value=fob")
         
         eval("top.window.opener.window.document.all.IT1.innerHTML=1")
         top.window.close();
    </script>
<HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

</BODY>
</HTML>
