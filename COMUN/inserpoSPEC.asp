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


po   = TRIM(Request.querystring("pos"))
aPo = split(po, ",")
cad =   " delete SPEC_pos WHERE SPEC= '"&SP&"' AND VER = '"&VR&"'; " 

for i= 0 to ubound(aPo)
    cad = cad + " insert into spec_pos select '"&sp&"', '"&vr&"', '"&aPo(i)&"', '"&usuario&"', getdate(), 'a' ; "
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
    cad = "../HELP/POS_ESTILO_TEMPO.ASP"
parent.window.location.replace(cad)


</script>

</HTML>
