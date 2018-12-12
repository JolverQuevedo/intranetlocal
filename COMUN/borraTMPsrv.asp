<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<html>
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

os  = left(TRIM(Request.querystring("os")),12)
com = TRIM(Request.querystring("com"))

CAD = " DELETE SERVITMP WHERE numord = '"&os&"'  and replace(combin,' ' , '' ) = '"&com&"' ; "
'RESPONSE.Write(CAD)
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

%>
</BODY>
</HTML>
