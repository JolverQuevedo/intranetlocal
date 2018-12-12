<%@ Language=VBScript %>
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
NOM = TRIM(Request.QueryString("NOM"))
DES = TRIM(Request.QueryString("DES"))
'	busca si encuentra un código duplicado

	CAD =   " SELECT USUARIO FROM USUARIOS " & _
			" WHERE  USUARIO = '"&COD&"' "
	RS.Open CAD, CNN
	Response.Write(CAD)
	'Response.END
if NOT RS.EOF OR NOT RS.BOF then	
	IF RS.RecordCount > 0 THEN	
		RS.Close
		if chk = "" then
			CAD =	" UPDATE  USUARIOS set " & _
					" CLAVE		= '"&DES&"',  " & _
					" NOMBRES	= '"&NOM&"'  " & _
					" WHERE   " & _
					" USUARIO = '"&COD&"' ; "
		else
			CAD =	" DELETE FROM  USUARIOS  WHERE " & _
					" USUARIO = '"&COD&"'; "	
					COD=""
		end if		
	end if 	
else	
	CAD =	" insert into usuarios  " & _
			" (USUARIO, CLAVE, NOMBRES) " & _
			" values('"&COD&"', '" & DES & "', " & _
			" '" & NOM & "' )"
End if
Response.Write (CAD)
Response.Write("../USUARIOS.asp?POS="+COD )
'Response.end
' Inicia transacción , para que los datos no queden a medias

Cnn.Execute(CAD)

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
cod = cstr(cod)
Response.Redirect("../USUARIOS.asp?POS="+COD )
%>
</BODY>
</HTML>
