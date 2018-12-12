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
CHK = Request.form("chk")
COD = TRIM(Request.fORM("KOD"))
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
BRU = TRIM(Request.form("PBRUTO"))
NET = TRIM(Request.form("NETO"))
DOC = TRIM(Request.form("DOCE"))
PRE = TRIM(Request.form("PREUNI"))
IF UNI="UN" THEN
	FOB = PRE
ELSE
	FOB = DOC	
END IF	
if len(trim(fob))	 <=0 then fob = 0
'Response.end
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT codigo FROM PRENDAS " & _
			" WHERE   CODIGO = '"&COD&"' " 
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
				" FOB			= "&FOB&", " & _
				" MONEDA		= '"&MON&"', " & _
				" GRUPO			= '"&GRU&"', " & _
				" PESOBRUTO		= '"&BRU&"', " & _
				" TIPPRENDA		= '"&TIP&"', " & _
				" CLIENTE		= '"&CLI&"', " & _
				" PESONETO		= '"&NET&"', " & _
				" ESTADO		= 'A',		" & _
				" TALLA			= '"&TAL&"',  " & _
				" USUARIO		= '"&USUARIO&"', " & _
				" FECHA			= "&fecha&"  " & _
				" WHERE   CODIGO = '"&COD&"';"
	else
		CAD =	" UPDATE PRENDAS SET " & _
				" USUARIO = '"&USUARIO&"', " & _
				" FECHA   = "&fecha&" , " & _
				" ESTADO  = 'E'	" & _ 
				" WHERE CODIGO = '"&COD&"';"
		COD	=	LEFT(COD, LEN(COD)-1)
	end if		
		
else	
	CAD =	" insert into PRENDAS  " & _
			" (CODIGO, DESCRIPCION, PROTO, VERSION, MINUTAJE, UNIDAD, " & _
			"  FOB, PESOBRUTO,PESONETO, CLIENTE, " & _
			"  MONEDA, TIPPRENDA,GENERO," & _
			"  ESTADO, TALLA, " & _
			" usuario, fecha, GRUPO )" & _
			" values('"&COD&"', '"&DES&"','"&PRO&"','"&VER&"', " & _
			" '"&MIN&"', '"&UNI&"', '"&FOB&"',  " & _
			" '"&BRU&"', '"&NET&"', '"&CLI&"', '"&MON&"', " & _
			" '"&TIP&"',  '"&GEN&"', " & _
			"  'A', '"&TAL&"', '"&USUARIO&"', "&fecha&", '"&GRU&"')  " 
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

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
URL = "../MODELOS.ASP?POS="+  TRIM(COD)
Response.Write("<BR>")
Response.Write("<BR>")
Response.Write("<BR>")
'Response.Write(URL)

'Response.End
Response.Redirect(URL)
%>
</BODY>
</HTML>
