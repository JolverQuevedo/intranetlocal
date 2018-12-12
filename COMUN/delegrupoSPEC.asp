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

sp  = left(TRIM(Request.querystring("spe")),10)
vr  = RIGHT(TRIM(Request.querystring("spe")),3)
GRU = TRIM(Request.querystring("GRU"))
ord = TRIM(Request.querystring("ord"))

FECHA ="{ fn NOW() }"


'***********************************************************
' INSERT AL specS_meddias
' PRIMERO ELIMINA (POR SI ACASO HAN MODIFICADO SECUENCIAS 
' LUEGO HACE UN INSERT DESDE 0
' EL ARRAY A INSERTAR YA ESTÁ ORDENADO
'***********************************************************
CAD = " DELETE specs_medidas WHERE spec= '"&sp&"'  and ver = '"&vr&"' and orden = '"&ord&"' and  grupo ='"&gru&"' ; "
CAD = cad + " DELETE specs_grupos  WHERE spec= '"&sp&"'  and ver = '"&vr&"'  and  grupo ='"&gru&"'  and orden = '"&ord&"' ; "


RESPONSE.Write(CAD)
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
URL= "../leftgrupo.ASP?spe=" + sp + "-"+vr 
url = url + "&cli="+ Request.querystring("cli") + "&tem=" + Request.querystring("tem")
url = url + "&est="+ Request.querystring("est") 
RESPONSE.Write(URL)	
'RESPONSE.END
%>
<script>
window.location.replace('<%=trim(url)%>')
</script>
</BODY>
</HTML>
