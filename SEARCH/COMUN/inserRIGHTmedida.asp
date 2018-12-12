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
ORD = TRIM(Request.querystring("ORD"))
DES = TRIM(Request.querystring("MED"))
COD = TRIM(Request.querystring("LIN"))
'' ACOD ES EL NUEMRO DE LINEA DEL GRUPO...
aCod = split(cod, ",")
' ADES VA CON EL CODIGO DE LA MEDIDA DED LA REFERENCIA
aDes = split(des, ",")
FECHA ="{ fn NOW() }"

' ORDENA LAS OPCIONES DE LA SECUENCIA
Dim tempo
Dim i, j 
For i = 0 To UBound(aCod) - 1
	For j = i To UBound(aCod)
		'Sort Ascending
		if cint(aCod(i)) > cint(aCod(j)) Then
		    tempo = aCod(i)
		    tem = aDes(i)
		    bad	  = aCod(i)	
		    aDes(i) = aDes(j)
		    aCod(i) = aCod(j)
		    aCod(j) = bad
		    aDes(j) = tem
		End if 'i > j
	next
next
'***********************************************************
' INSERT AL specS_meddias
' PRIMERO ELIMINA (POR SI ACASO HAN MODIFICADO SECUENCIAS 
' LUEGO HACE UN INSERT DESDE 0
' EL ARRAY A INSERTAR YA ESTÁ ORDENADO
'***********************************************************


CAD =       " DELETE specs_medidas WHERE spec= '"&sp&"'  and ver = '"&vr&"' and orden = '"&ord&"' and  grupo ='"&gru&"' ; "
CAD = cad + " DELETE specs_grupos  WHERE spec= '"&sp&"'  and ver = '"&vr&"'  and  grupo ='"&gru&"' ; "

cad = cad + " insert into specs_grupos (SPEC, VER, ORDEN,GRUPO)     " & _
            " VALUES ( '"&sp&"', '"&vr&"','"&ord&"','"&GRU&"' ) ;   "

for k=0 to ubound(aCod)
	CAD = CAD + " INSERT INTO specs_medidas (SPEC, VER, ORDEN,GRUPO, LIN, MEDIDA) " & _
				" VALUES ( '"&sp&"', '"&vr&"','"&ord&"','"&GRU&"', "&K+1&", '"&Ades(K)&"' ) ; "
next
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
URL= "../rightMedida.ASP?pos=" + TRIM (gru)
url = url + "&spp="+ Request.querystring("spe") + "&ch=true" +"&ord="+ ord
RESPONSE.Write(URL)	
'RESPONSE.END
%>
<script>
parent.window.location.replace('<%=trim(url)%>')
</script>
</BODY>
</HTML>
