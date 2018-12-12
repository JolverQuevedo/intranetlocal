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
ofi = TRIM(Request.QueryString("ofi"))
est = TRIM(Request.QueryString("est"))
FECHA ="{ fn NOW() }"

CAD = " update ofis    SET CODEST = '"&est&"' WHERE CODIGO = '"&ofi&"'                                   ;           " & _
      " update pos     SET CODEST = '"&est&"' WHERE ofi = (select codigo from ofis where codigo = '"&ofi&"') ;       " & _
      " update PROTOS  SET ESTILO = '"&est&"' WHERE cotizacion = (select cotizacion from pos where ofi = '"&ofi&"'); "    

response.Write(cad)

RESPONSE.WRITE("<br>")
'RESPONSE.END

Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
response.write (url+cod)

%>
<script language="javascript" type="text/jscript">

cad ="../modiest.asp"

top.window.location.replace(cad)
</script>
</BODY>
</HTML>
