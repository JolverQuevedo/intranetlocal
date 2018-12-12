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
TEL = TRIM(Request.Form("TELA"))
RUT= TRIM(Request.Form("RUT"))

FECHA ="{ fn NOW() }"

' CAPTURA TODOS LOS DATOS DE SERVICIOS
maxim = Request.Form("CONTADOR")
dim aSer() 
dim aCod()
dim aDes()
cn = 0
for i=0 to maxim
	if len(trim(Request.Form("pos"&i))) > 0 then 
		redim preserve aSer(cn)
		redim preserve aCod(cn)
		redim preserve aDes(cn)
		aSer(cn) = cint(Request.Form("pos"&i))
		aCod(cn) = Request.Form("cod"&i)
		aDes(cn) = trim(Request.Form("desc"&i))
		cn = cn + 1	
	end if	
next
' ORDENA LAS OPCIONES DE LA SECUENCIA
Dim tempo
Dim i, j 
For i = 0 To UBound(aSer) - 1
	For j = i To UBound(aSer)
		'Sort Ascending
		if aSer(i) > aSer(j) Then
		    tempo = aSer(i)
		    tem = aDes(i)
		    bad	  = aCod(i)	
		    aSer(i) = aSer(j)
		    aDes(i) = aDes(j)
		    aCod(i) = aCod(j)
		    aSer(j) = tempo
		    aCod(j) = bad
		    aDes(j) = tem
		End if 'i > j
	next
next
'***********************************************************
' INSERT AL MAESTRO DE RUTAS DE TELA SEGUN VERSION ....
' PRIMERO ELIMINA (POR SI ACASO HAN MODIFICADO SECUENCIAS 
' LUEGO HACE UN INSERT DESDE 0
' EL ARRAY A INSERTAR YA ESTÁ ORDENADO
'***********************************************************
CAD = " DELETE FROM telarutadeta WHERE TELA ='"&TEL&"' AND VERSION = '"&RUT&"' ; "
for k=0 to ubound(aSer)
	'cod = aCod(k)
	'des = aDes(k)
	'SER = ASER(K)
	'Response.Write(des)
	'Response.Write("-")
	'Response.Write(COD)
	'Response.Write("-")
	'Response.Write(K)
	'Response.Write("<BR>")
	CAD = CAD + " INSERT INTO telarutadeta (TELA, VERSION, SERVICIO, OPC) " & _
				" VALUES ('"&TEL&"', '"&RUT&"', '"&ACOD(K)&"', "&K+1&" ) ; "
	
	
	
next
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
URL= "../FICHARUTATELAS.ASP?tel=" +TRIM(TEL) + "&RUT=" + TRIM (RUT)
'RESPONSE.Write(URL)	
'RESPONSE.END
%>
<script>
window.location.replace('<%=trim(url)%>')
</script>
</BODY>
</HTML>
