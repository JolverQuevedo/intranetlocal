<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%
    po = request.querystring("po")
    newfecha = request.querystring("newfecha")

    cad = "set dateformat dmy;update pos set fecha = cast('"&newfecha&"' as datetime) where po='"&po&"'"
    response.write(cad)
    'response.end
    cnn.execute(cad)

%>
<script language="javascript" type="text/jscript">
    //alert("datos actualizados correctamente")
    parent.location.reload()
</script>
</BODY>
</HTML>
