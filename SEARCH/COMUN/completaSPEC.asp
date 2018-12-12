<%@ Language=VBScript%>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
sp     = left(TRIM(Request.cookies("spe")),10)
vr     = RIGHT(TRIM(Request.cookies("ver")),3)

nume   = (Request.Form("nume"))

medi   = Request.Form("MED")
mode   = TRIM(Request.Form("MMD"))
obse   = left(TRIM(Request.Form("Textarea1")),500)
come   = left(TRIM(Request.Form("Textarea2")),500)
nota   = left(TRIM(Request.Form("Textarea3")),500)


cad =   " UPDATE SPECS_HEAD SET             " & _
        " obs           = '"&obse&"' ,      " & _
        " comentarios   = '"&come&"',       " & _
        " modelista     = '"&mode&"' ,      " & _
        " numpro        = '"&nume&"',       " & _
        " nota          = '"&nota&"',       " & _
        " tipmed        = '"&medi&"',       " & _
        " usuario       = '"&usuario&"',    " & _
        " fecha         = getdate(),        " & _
        " estado        = 'A'               " & _
        " WHERE SPEC    = '"&SP&"' AND      " & _
        " VER = '"&VR&"';                   "
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

<script>
    window.location.replace('../adicionalesSPEC.asp')
</script>
</BODY>
</HTML>
