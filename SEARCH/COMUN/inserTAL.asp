<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
COD = TRIM(Request.QueryString("COD"))
URL = TRIM(Request.QueryString("URL"))
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT TALLA FROM TALLAS " & _
			" WHERE  TALLA = '"&COD&"' "
	
	rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
    top.window.alert("Talla duplicada")
    cad = '../CODTALLA.ASP?POS='+ '<%=trim(cod)%>'
    top.window.location.replace(cad)
</script>

<%
response.End
end if
rs.close
CAD = " SELECT TALLA FROM TALLAS WHERE TALLA='"&COD&"' "
response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE
IF TOTALREG>0 THEN	
	if chk = "" then
		CAD =	" UPDATE  TALLAS set            " & _
				" ESTADO = 'A',                  " & _
				" USUARIO = '"&USUARIO&"',      " & _
				" FECHA = "&fecha&"             " & _
				" WHERE   talla = '"&COD&"';   "
	else
		CAD =	" UPDATE TALLAS                 " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE TALLA = '"&COD&"';     "
				cod=""
	end if	
else
	CAD = 	" insert into tallas              " & _
			" (TALLA,ESTADO,                    " & _
			" usuario, fecha )                  " & _
			" values('"&COD&"',                 " & _
			"  'A', '"&USUARIO&"', "&fecha&" )  " 
End if
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

   cad = '../CODTALLA.ASP?POS='+ '<%=trim(cod)%>'
   top.window.location.replace(cad)
</script>
</BODY>
</HTML>
