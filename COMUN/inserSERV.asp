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
MON = TRIM(Request.QueryString("MON"))
CTO = TRIM(Request.QueryString("CTO"))
MER = TRIM(Request.QueryString("MER"))
SER = TRIM(Request.QueryString("SER"))
UNI = TRIM(Request.QueryString("UNI"))
url = TRIM(Request.QueryString("url"))
dest = TRIM(Request.QueryString("dest"))


FECHA ="{ fn NOW() }"
marca = right(trim(url),1)
IF COD <> "AUTO" THEN
'	busca si encuentra un código duplicado
	CAD =   " SELECT CODIGO FROM SERVICIOS " & _
			" WHERE  CODIGO = '"&COD&"' "
	RS.Open CAD, CNN
	IF RS.RecordCount > 0 THEN	
		RS.Close
		if chk = "" then
			CAD =	" UPDATE  SERVICIOS set		" & _
					" DESCRIPCION='"&DES&"', 	" & _
					" UNIDAD = '"&UNI&"',		" & _ 
					" MERMA = "&MER&" ,			" & _
					" TIPO = '"&SER&"',			" & _
					" COSTO = "&CTO&" ,			" & _
					" MONEDA = '"&MON&"' ,		" & _
                    " MERMA = '"&mER&"',           " & _
					" ESTADO = 'A',				" & _
					" USUARIO = '"&USUARIO&"',	" & _
					" FECHA = "&fecha&"			" & _
					" WHERE CODIGO = '"&COD&"';	"
		else
			CAD =	" UPDATE SERVICIOS				" & _
					" SET  USUARIO = '"&USUARIO&"', " & _
					" FECHA = "&fecha&" ,			" & _
					" ESTADO = 'E'					" & _ 
					" WHERE  CODIGO= '"&COD&"' ;	"	
		end if		
	END IF 
else	
	
	CAD = "SELECT TOP 1 CODIGO FROM SERVICIOS ORDER BY CODIGO DESC"
	RS.OPEN CAD, CNN
	IF RS.RECORDCOUNT > 0 THEN 
		COD = CiNT(RS("CODIGO")) + 1
		COD = RIGHT("00000" + TRIM(CSTR(COD)),6)
	ELSE
		COD = "000000"
	END IF		
	CAD =	" insert into SERVICIOS					" & _
			" (CODIGO, DESCRIPCION,	COSTO,			" & _
			" MERMA, TIPO, UNIDAD, MONEDA,			" & _
			" ESTADO, usuario, fecha) values		" & _
			" ('"&COD&"', '" & DES & "', "&CTO&",	" & _
			" "&MER&",								" & _
			" '"&SER&"', '"&UNI&"',  '"&MON&"',		" & _
			" 'A', '"&USUARIO&"', "&fecha&")		" 
End if
'Response.Write (CAD)
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
Response.Redirect("../servicios.asp?POS="+COD+ "&PERFIL=1"  )
%>
</BODY>
</HTML>
