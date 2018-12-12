<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
tel = ucase(TRIM(Request.QueryString("tel")))
CAD = " SELECT * FROM telas WHERE tela = '"&tel&"'"
rs.open cad, cnn

response.write(cad)
IF rs.recordcount <= 0 THEN%>

<script language="jscript" type="text/jscript">
	alert("NO existe un artículo con este código")
</script>	
<%else
    rs.close
    cad = "select top 1 version as mm from telarutahead where tela ='"&tel&"' order by version desc"
    rs.open cad, cnn
    response.Write(rs.recordcount)
    if rs.recordcount > 0 then
        RS.MOVEFIRST
        if isnull(rs("mm")) = true then 
            ver = "001" 
        else
            ver = cint(rs("mm"))+1
            VER = RIGHT("000" + TRIM(VER),3)
        end if
    ELSE
        VER = "001"
    END IF
%>

<script language="jscript" type="text/jscript">
    parent.document.all.RUT2.value = '<%=ver%>'
    alert("Presione el Check para crear la copia de la Ruta")
</script>	
<%END IF	
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
</script>
</BODY>
</HTML>
