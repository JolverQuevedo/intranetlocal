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
cli = TRIM(Request.querystring("cli"))

est = TRIM(Request.querystring("est"))
pos = TRIM(Request.querystring("pos"))
des = TRIM(Request.querystring("des"))
ttt = request.querystring("tem")
response.write(ttt)
response.write("<br>")
aCod = split(pos, ",")
aDes = split(des, ",")
FECHA ="{ fn NOW() }"

' CAPTURA TODOS LOS DATOS DE las tallas
'maxim = Request.Form("CONTADOR")
'dim aCod()
'dim aPos()
'cn = 0
'for i=0 to maxim
'	if len(trim(Request.Form("pos"&i))) > 0 then 
'		redim preserve aCod(cn)
'		redim preserve aPos(cn)
'		aCod(cn) = Request.Form("desc"&i)
'		aPos(cn) = trim(Request.Form("pos"&i))
'		cn = cn + 1	
'	end if	
'next
Dim tempo
Dim i, j 
For i = 0 To UBound(aCod) - 1
	For j = i To UBound(aCod)
		'Sort Ascending
		if  cint(aCod(i)) > cint(aCod(j)) Then
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
' INSERT AL MAESTRO DE RUTAS DE TELA SEGUN VERSION ....
' PRIMERO ELIMINA (POR SI ACASO HAN MODIFICADO SECUENCIAS 
' LUEGO HACE UN INSERT DESDE 0
' EL ARRAY A INSERTAR YA ESTÁ ORDENADO
'***********************************************************
CAD = ""
for k=0 to ubound(aCod)
    TALLA = "T"+TRIM(CSTR(k))
	CAD = CAD + " update  CLIENTE_TEMP_EST_TALLA SET  "&TALLA&" = '"&aDes(k)&"' " & _
                " WHERE CLI = '"&CLI&"'  AND CODTEM= '"&ttt&"' AND ESTilo = '"&EST&"'; "
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
URL= "../CLIENTE_TEMP_EST_TALLA.ASP?cli=" + trim(cli) + "&tem=" +ttt + "&est=" + est
'RESPONSE.Write(URL)	
'RESPONSE.END
%>
<script>
window.location.replace('<%=trim(url)%>')
</script>
</BODY>
</HTML>
