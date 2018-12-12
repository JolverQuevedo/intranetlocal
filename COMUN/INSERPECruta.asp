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

sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)
cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")


pos  = TRIM(Request.querystring("pos"))
aCod = split(pos, ",")
rut  = TRIM(Request.querystring("rut"))
aDes = split(rut, ",")
response.write(pos)
response.write("<br>")


' hay que ordenar los arrays
' ORDENA LAS OPCIONES DE LA ruta
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


cad =   " delete SPECruta WHERE SPEC= '"&SP&"' AND VER = '"&VR&"'; " 
response.write(aCod(0))
response.write("<br>")
for i= 0 to ubound(aCod)
    if aCod(i) > 0 then
        cad = cad + " insert into specruta select '"&sp&"', '"&vr&"', '"&(i+1)&"','"&aDes(i)&"', '"&usuario&"', getdate(), 'a' ; "
    end if
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
%>
</BODY>
<script language="jscript" type="text/jscript">
//cad = "../reportes/prn_spec.asp?sss="  + "<%=TRIM(Request.querystring("pos"))%>" + "&sp="+ "<%=Request.QueryString("sp")%>"+ "&vr=" + "<%=Request.QueryString("vr")%>"
    //alert(cad)
    cad = "../rutaSPEC.ASP"
parent.window.location.replace(cad)


</script>

</HTML>
