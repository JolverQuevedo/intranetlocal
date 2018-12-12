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
tel1 = ucase(TRIM(Request.QueryString("tel1")))
tel2 = ucase(TRIM(Request.QueryString("tel2")))
ver1 = ucase(TRIM(Request.QueryString("ver1")))
ver2 = ucase(TRIM(Request.QueryString("ver2")))
FECHA ="{ fn NOW() }"
CAD =   " insert into telarutahead  SELECT '"&tel2&"', '"&ver2&"', descriptor, volteado,    " & _
        " lavapano , '"&usuario&"',  "&fecha&", 'A' FROM telarutahead                       " & _
        " WHERE tela = '"&tel1&"'and version = '"&ver1&"' ;                                 " & _
        " insert into telarutadeta select '"&tel2&"', '"&ver2&"', servicio, opc             " & _
        " from telarutadeta where tela = '"&tel1&"' and version = '"&ver1&"'                "
       

%>

<script language="jscript" type="text/jscript">
//	alert("NO existe un artículo con este código")
</script>	

    <script language="jscript" type="text/jscript">
  
      //  alert("Presione el Check para crear la copia de la Ruta")
    </script>	
<%
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
</script>
</BODY>
</HTML>
