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
DES = ucase(TRIM(Request.QueryString("DES")))
MER = TRIM(Request.QueryString("MER"))
cto = TRIM(Request.QueryString("CTO"))

Response.Write(mer)
Response.Write("<br>")
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT TENIDO FROM TENIDO " & _
			" WHERE  TENIDO = '"&COD&"' "
	
	RS.Open CAD, CNN
	RESPONSE.Write(CHK)
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "" then
		CAD =	" UPDATE TENIDO set " & _
				" DESTENIDO	    = '"&DES&"',  " & _ 
				" ESTADO		= 'A',  " & _
				" USUARIO		= '"&USUARIO&"', " & _
				" FECHA			= "&fecha&" , " & _
				" MERMA			= "&MER&" , "  & _ 
				" costoKG		= "&CTO&"  "  & _ 
				" WHERE   " & _
				" TENIDO = '"&COD&"' ; "
	else
		CAD =	" UPDATE TENIDO " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" , " & _
				" ESTADO = 'E'	" & _ 
				" WHERE " & _
				" TENIDO = '"&COD&"' ; "	
	end if		
		
else	
RS.CLOSE
CAD = "SELECT TOP 2 TENIDO FROM TENIDO ORDER BY TENIDO DESC"
	RS.OPEN CAD, CNN
	IF RS.RECORDCOUNT>0 THEN
		rs.movelast
	    COD = CINT(RS("TENIDO"))+1
	    COD = RIGHT("00" + CSTR(COD),2)
	ELSE
	    COD = "01"
	END IF    
	CAD =	" insert into TENIDO  " & _
				" (TENIDO, DESTENIDO, " & _
				" MERMA, ESTADO, usuario, fecha, costoKG )" & _
				" values('"&COD&"', '" & DES & "', " & _
				" " & MER & ", 'A', '"&USUARIO&"', "&fecha&" , "&CTO&")  " 
End if
Response.Write (CAD)
'Response.end
' Inicia transacción , para que los datos no queden a medias
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
cod = cstr(cod)
cad = "../TENIDO.asp?POS="+COD 
%>
<script language="jscript" type="text/jscript">
top.window.location.replace('<%=cad %>')
</script>
</BODY>
</HTML>
