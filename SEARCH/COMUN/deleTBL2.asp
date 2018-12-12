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

COD = ucase(TRIM(Request.QueryString("cod")))
DES = ucase(TRIM(Request.QueryString("DES")))
TBL = TRIM(Request.QueryString("TBL"))
PK1  = TRIM(Request.QueryString("PK1"))
pk2  = TRIM(Request.QueryString("pk2"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))
FECHA ="{ fn NOW() }"


CAD = " SELECT "&PK1&", "&pk2&" FROM "&TBL&" WHERE "&PK1&"='"&COD&"' and "&pk2&" = '"&DES&"'"
response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE

CAD =	" UPDATE "&TBL&"                " & _
		" SET  USUARIO = '"&USUARIO&"', " & _
		" FECHA = "&fecha&" ,           " & _
		" ESTADO = 'E'	                " & _ 
		" WHERE "&PK1&" = '"&COD&"'     " & _
        " and "&pk2&" = '"&DES&"'       "
cod = cod - 1		

' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
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
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">

cad = trim('<%=url%>')+ '&perfil=1'

window.location.replace(cad)
</script>
</BODY>
</HTML>
