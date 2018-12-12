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
DES = TRIM(Request.QueryString("DES"))
COR = TRIM(Request.QueryString("COR"))
CTO = TRIM(Request.QueryString("CTO"))
URL = TRIM(Request.QueryString("URL"))
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT FAMTELA FROM "&OWNER&".FAMTELAS " & _
			" WHERE  FAMTELA = '"&COD&"' "
	
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "" then
		CAD =	" UPDATE  "&OWNER&".FAMTELAS set " & _
				" DESCRIPCION = '"&DES&"',  " & _
				" CORREL = '"&COR&"',  " & _ 
				" COSTO = '"&CTO&"',  " & _ 
				" ESTADO = 'A',  " & _
				" USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&"  " & _
				" WHERE  FAMTELA = '"&COD&"' ;"
	else
		CAD =	" UPDATE "&OWNER&".FAMTELAS " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" , " & _
				" ESTADO = 'E'	" & _ 
				" WHERE FAMTELA = '"&COD&"' ;"
	end if		
		
else	
	CAD =	" insert into "&OWNER&".FAMTELAS  " & _
				" (FAMTELA, DESCRIPCION,  CORREL, ESTADO," & _
				" usuario, fecha , COSTO)" & _
				" values('"&COD&"', '" & DES & "', " & _
				" '" & COR & "',  'A', '"&USUARIO&"', "&fecha&", '"&CTO&"' )  " 
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
Response.Write(url+cod)
'Response.End
Response.Redirect(URL+COD )
%>
</BODY>
</HTML>
