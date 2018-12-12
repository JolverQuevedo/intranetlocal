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
sp    = left(TRIM(Request.cookies("spe")),10)
vr    = RIGHT(TRIM(Request.cookies("ver")),3)
sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)
cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")

gru   = TRIM(Request.querystring("gru"))
oor   = TRIM(Request.querystring("oor"))

cad = "select * from specs_grupos WHERE SPEC= '"&SP&"' AND VER = '"&VR&"' and grupo = '"&gru&"' and orden= '"&oor&"'  "
rs.open cad,cnn
if rs.recordcount <= 0 then
    cad = "insert into SPECS_grupos (SPEC, VER, ORDEN, GRUPO) select '"&SP&"', '"&VR&"', '"&oor&"', '"&gru&"' "
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
end if


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>
<script>

parent.window.location.replace("../leftgrupo.asp")
</script>
</BODY>
</HTML>
