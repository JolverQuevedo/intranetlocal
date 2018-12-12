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
' PARAMETRO
cad = TRIM(Request.QueryString("param"))
aPar = split(cad, ",",-1,1)
response.Write(cad)
' VALOR DEL PARAMETRO
cad = TRIM(Request.QueryString("VALU"))

aVal =Split(cad, ",", -1, 1)

tt = len(trim(application("owner")))
tt = tt+1
'tabla = right(tbl,(len(tbl)- tt))

menu=request.QueryString("menu")
smen=request.QueryString("subm")
CADENA = ""
FOR I=1 TO UBOUND (aPAR)
    if trim(aPar(i)) <> "" then
        CADENA = CADENA + "&" + ucase(TRIM(APAR(I))) + "=" + ucase(TRIM(AVAL(I)))
    end if
NEXT
'response.WRITE(CADENA)
CAD =   " update "&trim(application("owner"))&".submenu " & _
        " SET PARAMETROS= '"&CADENA&"'                  " & _
        " WHERE menu='"&menu&"' and submenu = '"&smen&"'"
response.Write(cad)


' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE(CAD)
'RESPONSE.END
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados, Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">

cad = '../subparam.asp?menu=' + '<%=trim(request.QueryString("menu")) %>'+ '&subm='+ '<%=trim(request.QueryString("subm")) %>'
top.window.location.replace(cad)
</script>
</body>
</html>
