<%@ Language=VBScript %>
<%USR = Request.Cookies("Usuario")("USUARIO")%>
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
CHK = Request.form("chk")
COD = TRIM(Request.fORM("COD"))
'RESPONSE.Write(COD)
'RESPONSE.End()
DES = TRIM(Request.form("DES"))
PRO = TRIM(Request.form("PROTO"))
VER = TRIM(Request.form("VERSION"))
MIN = TRIM(Request.form("MIN"))
MON = TRIM(Request.form("MON"))
UNI = TRIM(Request.form("UNI"))
TAL = TRIM(Request.form("TIPRAT"))
TIP	= TRIM(Request.form("TIPPRE"))
GEN	= TRIM(Request.form("GEN"))
CLI = TRIM(Request.form("CLI"))
GRU = TRIM(Request.form("GRUP"))
PRE = TRIM(Request.form("PREUNI"))
sLINEA = TRIM(REQUEST.FORM("LIN"))
	FOB = PRE
if trim(FOB) = "" then
	fob = 0
end if	
'Response.end
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT codigo FROM PRENDAS " & _
			" WHERE   CODIGO = '"&COD&"'  AND CODIGO<>'AUTO' " 
	'Response.Write(CAD)
	'response.end
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "" then
		CAD =	" UPDATE  PRENDAS set " & _
				" DESCRIPCION	= '"&DES&"', " & _
				" PROTO			= '"&PRO&"', " & _
				" VERSION		= '"&VER&"', " & _
				" MINUTAJE		= '"&MIN&"', " & _
				" UNIDAD		= '"&UNI&"', " & _
				" GENERO		= '"&GEN&"', " & _
				" FOB			= "&FOB&",	 " & _
				" MONEDA		= '"&MON&"', " & _
				" GRUPO			= '"&GRU&"', " & _
				" TIPPRENDA		= '"&TIP&"', " & _
				" CLIENTE		= '"&CLI&"', " & _
				" ESTADO		= 'A',		 " & _
				" TALLA			= '"&TAL&"', " & _
				" USUARIO		= '"&USR&"', " & _
				" FECHA			= "&fecha&"  " & _
				" WHERE   CODIGO = '"&COD&"';"
	else
		CAD =	" UPDATE PRENDAS SET		" & _
				" USUARIO = '"&USR&"',		" & _
				" FECHA   = "&fecha&" ,		" & _
				" ESTADO  = 'E'				" & _ 
				" WHERE CODIGO = '"&COD&"';	"
		COD	=	RIGHT(COD, LEN(COD)-1)
	end if		
		
else	
	RS.CLOSE
	MAD = "SELECT rtrim(substring(codigo,2,13)) AS KKK FROM PRENDAS WHERE LEFT(CODIGO,1) = '"&SLINEA&"'"
	RS.OPEN MAD,CNN
	IF RS.RECORDCOUNT > 0 THEN
		COD = SLINEA + RIGHT("00000" + TRIM(CSTR(CDBL(RS("KKK"))+1)),5)
	ELSE
		COD = SLINEA + "00000"
	END IF		
	
	CAD =	" insert into PRENDAS  " & _
			" (CODIGO, DESCRIPCION, PROTO, VERSION, MINUTAJE, UNIDAD, " & _
			"  FOB, CLIENTE, " & _
			"  MONEDA, TIPPRENDA,GENERO," & _
			"  ESTADO, TALLA, " & _
			" usuario, fecha, GRUPO )" & _
			" values('"&COD&"' , '"&DES&"','"&PRO&"','"&VER&"', " & _
			" '"&MIN&"', '"&UNI&"', '"&FOB&"',  " & _
			" '"&CLI&"', '"&MON&"', " & _
			" '"&TIP&"',  '"&GEN&"', " & _
			"  'A', '"&TAL&"', '"&USR&"', "&fecha&", '"&GRU&"')  " 
	
			
End if
			
'Response.Write (CAD)
'Response.end
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
if chk = "1" then 
	
END IF	
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'SET RS2 = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
URL = "../PRENDAS.ASP?POS="+  TRIM(COD)	

Response.Write("<BR>")
Response.Write("<BR>")
Response.Write("<BR>")
Response.Write(URL)

'Response.End
Response.Redirect(URL)
%>
</BODY>
</HTML>
