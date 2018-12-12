<%@ Language=VBScript %>
<% Session.LCID = 2058 'Puntos y comas%>
<%  Response.Buffer = true %>
<!--#include file="../includes/rutinas.asp"-->

<%
usr = REQUEST.Cookies("USER")
COD		= TRIM(Request.form("COD"))
DES		= TRIM(Request.form("DESW"))
FAM		= TRIM(Request.form("FAM"))
TIPTEL	= TRIM(Request.form("TIPTEL"))
CODTIT	= TRIM(Request.form("CODTIT"))
FINI	= TRIM(Request.FORM("FINI"))
STAT	= TRIM(REQUEST.Form("STAT"))
PC		= replace(TRIM(Request.form("PC")),",",".")
IF PC = "" THEN PC = 0
PA		= replace(TRIM(Request.form("PA")),",",".")
IF PA = "" THEN PA = 0
RT		= replace(Request.form("RT"),",",".")
IF RT = "" THEN RT = 0
RA		= replace(Request.form("RA"),",",".")
IF RA = "" THEN RA = 0
TMIN	= replace(Request.QueryString("TMIN"),",",".")
IF TMIN = "" THEN TMIN = 0
TMAX	= replace(Request.QueryString("TMAX"),",",".")
IF TMAX = "" THEN TMAX = 0
AC		= replace(TRIM(Request.form("AC")),",",".")
IF AC = "" THEN AC = 0
AT		= replace(TRIM(Request.form("AT")),",",".")
IF AT = "" THEN AT = 0
AA		= replace(TRIM(Request.form("AA")),",",".")
IF AA = "" THEN AA = 0
CUR		= replace(TRIM(Request.form("CUR")),",",".")
IF CUR = "" THEN CUR = 0
COL		= replace(TRIM(Request.form("COL")),",",".")
IF COL = "" THEN COL = 0
LM1		= replace(TRIM(Request.form("LM1")),",",".")
IF LM1 = "" THEN LM1 = 0
LM2		= replace(TRIM(Request.form("LM2")),",",".")
IF LM2 = "" THEN LM2 = 0
LM3		= replace(TRIM(Request.form("LM3")),",",".")
IF LM3 = "" THEN LM3 = 0
M1		= TRIM(Request.form("M1"))
M2		= TRIM(Request.form("M2"))
M3		= TRIM(Request.form("M3"))
M4		= TRIM(Request.form("M4"))
M5		= TRIM(Request.form("M5"))
M6		= TRIM(Request.form("M6"))
P1		= TRIM(Request.form("P1"))
P2		= TRIM(Request.form("P2"))
P3		= TRIM(Request.form("P3"))
P4		= TRIM(Request.form("P4"))
P5		= TRIM(Request.form("P5"))
P6		= TRIM(Request.form("P6"))
IF TRIM(P2) = "" THEN P2 = 0
IF TRIM(P3) = "" THEN P3 = 0
IF TRIM(P4) = "" THEN P4 = 0
IF TRIM(P5) = "" THEN P5 = 0
IF TRIM(P6) = "" THEN P6 = 0

EA1		= replace(TRIM(Request.form("EA1")),",",".")
EA2		= replace(TRIM(Request.form("EA2")),",",".")
EA3		= replace(TRIM(Request.form("EA3")),",",".")
IF EA1 = "" THEN EA1 = 0
IF EA2 = "" THEN EA2 = 0
IF EA3 = "" THEN EA3 = 0
EL1		= replace(TRIM(Request.form("EL1")),",",".")
EL2		= replace(TRIM(Request.form("EL2")),",",".")
EL3		= replace(TRIM(Request.form("EL3")),",",".")
IF EL1 = "" THEN EL1 = 0
IF EL2 = "" THEN EL2 = 0
IF EL3 = "" THEN EL3 = 0
REV     = replace(TRIM(REQUEST.Form("REV")),",",".")
IF REV = "" THEN REV = 0
DDL     = replace(TRIM(REQUEST.Form("DDL")),",",".")
IF DDL = "" THEN DDL = 0
MON		= replace(TRIM(Request.form("MON")),",",".")

CTO		= replace(TRIM(Request.form("CTO")),",",".")
IF CTO = "" THEN CTO = 0
UNI		= TRIM(Request.form("UNI"))
CMAQ	= TRIM(Request.form("CMAQ"))
PAL		= replace(TRIM(Request.form("PAL")),",",".")
IF PAL = "" THEN PAL = 0
TMINL	= replace(Request.QueryString("TMINL"),",",".")
IF TMINL = "" THEN TMINL = 0
TMAXL	= replace(Request.QueryString("TMAXL"),",",".")
IF TMAXL = "" THEN TMAXL = 0
ATL		= replace(TRIM(Request.form("ATL")),",",".")
IF ATL = "" THEN ATL = 0
AAL		= replace(TRIM(Request.form("AAL")),",",".")
IF AAL = "" THEN AAL = 0
RTTL	= replace(Request.form("RTTL"),",",".")
IF RTTL = "" THEN RTTL = 0
RTAL	= replace(Request.form("RTAL"),",",".")
IF RTAL = "" THEN RTAL = 0
CURLAV	= replace(TRIM(Request.form("CURLAV")),",",".")
IF CURLAV = "" THEN CURLAV = 0
COLLAV	= replace(TRIM(Request.form("COLLAV")),",",".")
IF COLLAV = "" THEN COLLAV = 0
ELL1	= replace(Request.FORM("ELL1"),",",".")
ELL2	= replace(Request.FORM("ELL2"),",",".")
ELL3	= replace(Request.FORM("ELL3"),",",".")
IF ELL1 = "" THEN ELL1 = 0
IF ELL2 = "" THEN ELL2 = 0
IF ELL3 = "" THEN ELL3 = 0
EAL1	= replace(Request.FORM("EAL1"),",",".")
EAL2	= replace(Request.FORM("EAL2"),",",".")
EAL3	= replace(Request.FORM("EAL3"),",",".")
IF EAL1 = "" THEN EAL1 = 0
IF EAL2 = "" THEN EAL2 = 0
IF EAL3 = "" THEN EAL3 = 0
REVL	= replace(Request.form("REVL"),",",".")
'RESPONSE.WRITE(REVL)
'RESPONSE.WRITE("<br>")
IF trim(REVL) = "" THEN REVL = 0
'RESPONSE.WRITE(REVL)
'RESPONSE.WRITE("<br>")
DDLL	= replace(Request.form("DDLL"),",",".")
IF DDLL = "" THEN DDLL = 0
UNI		= TRIM(Request.form("UNI"))
MON		= TRIM(Request.form("MON"))
RCOD	= TRIM(Request.QueryString("RCOD"))
FIC		= TRIM(Request.form("FICH"))
FEC		= "GETDATE()"
EDO		= "A"
OBS		= TRIM(Request.form("CONTENIDO"))
DDP		= TRIM(Request.form("DESARROLLO"))
SFAM	= TRIM(Request.form("SFAM"))
%>
<!--#include file="../includes/Cnn.inc"-->
<% cad = ""
IF (TRIM(COD) = "AUTO")	 THEN
CAD= "SELECT TELA, DESCRIPCION FROM TELAS WHERE LTRIM(RTRIM(DESCRIPCION)) = LTRIM(RTRIM('"&DES&"'))"
RS.OPEN CAD, CNN
    IF RS.RECORDCOUNT > 0 THEN
        COD = RS("TELA")
        Response.Redirect("../fichatelas.asp?tel="+COD )
    END IF
    RS.CLOSE
    'INSERT
    ' PRIMERO VER EL ULTIMO CORRELATIVO
    CAD = cad + " update famtelas set correl = CORREL + 1, " & _ 
			    " usuario = '"&usr&"', fecha = "&fec&", estado = 'A' " & _
			    " where famtela = '"&FAM&"'; "
    '	busca si encuentra un código duplicado
	    KAD =   " SELECT CORREL FROM FAMTELAS " & _
			    " WHERE  FAMTELA = '"&FAM&"'; "

	    RS.Open KAD, Cnn
	    cod = cdbl(RS("CORREL"))
	    COD = "00000" + TRIM(RS("CORREL"))
	    COD = RIGHT(COD,6)
	    RS.CLOSE
response.write(cod)
response.Write("<BR>")
CAD = CAD + " insert into TELAS	(							" & _
			" TELA, DESCRIPCION, TIPOTELA, FAMILIA,			" & _
			" PESOCRU, PESOACA,RENDTUB, RENDABI,			" & _
			" ANCHCRU, ANCHTUB, ANCHABI,	CURZAS, 		" & _
			" COLUMNAS, LM1, LM2, LM3, TOLMIN, TOLMAX,		" & _
			" HIL1, HIL2, HIL3, HIL4, HIL5, HIL6, 			" & _
			" POR1, POR2, POR3, POR4, POR5, POR6,ENCABI1,	" & _
			" ENCABI2, ENCABI3, ENCLAR1, ENCLAR2,ENCLAR3,	" & _
			" REVIRADO, MONEDA, INCACA,COSTO,UNIDAD,		" & _
			" MAQUINA, PESOLAV, TOLMINL, TOLMAXL,ANCHTUBLAV," & _
			" ANCHABILAV, RENTTLAV, RENTALAV, CURZALAV, 	" & _
			" COLLAV, ENCLLAV1, ENCLLAV2,ENCLLAV3, ENCALAV1," & _
			" ENCALAV2, ENCALAV3, REVLAV, INCDLAV, TITULO,  " & _
			" STAT, FECINI, REALSOFT, USUARIO, FECHA,		" & _
			"  ESTADO, FICHA,subfam, FCREA, usucrea) VALUES('"&COD&"',		" & _
			" '"&DES&"','"&TIPTEL&"', '"&FAM&"',  "&PC&",	" & _
			" "&PA&", "&RT&", "&RA&", "&AC&", "&AT&", 		" & _
			" "&AA&", "&CUR&", "&COL&", "&LM1&", "&LM2&",   " & _
			" "&LM3&", "&TMIN&","&TMAX&", '"&M1&"','"&M2&"'," & _			
			" '"&M3&"', '"&M4&"', '"&M5&"','"&M6&"', "&P1&"," & _
			" "&P2&", "&P3&", "&P4&", "&P5&", "&P6&",		" & _
			" "&EA1&", "&EA2&", "&EA3&", "&EL1&", "&EL2&",  " & _
			" "&EL3&", "&REV&", '"&MON&"', "&DDL&", "&CTO&"," & _
			" '"&UNI&"', '"&CMAQ&"', "&PAL&", "&TMINL&",    " & _
			" "&TMAXL&", "&ATL&", "&AAL&", "&RTTL&",        " & _
			" "&RTAL&", "&CURLAV&", "&COLLAV&",  "&ELL1&",  " & _
			" "&ELL2&", "&ELL3&", "&EAL1&", "&EAL2&",       " & _
			" "&EAL3&", "&REVL&", "&DDLL&", '"&CODTIT&"',   " & _
			" '"&STAT&"', "&fec&", '"&REALCOD&"', '"&USR&"'," & _
			" "&FEC&",  '"&EDO&"', '"&FIC&"', '"&sfam&"', "&fec&", '"&usr&"');  " 
			
		cad = cad + " insert into [tela-obs]		" & _
					" (tela, observacion, COMENTARIO) values	" & _
					" ('"&cod&"', '"&OBS&"', '"&DDP&"');		"		
		CAD = CAD + "EXEC RS_AR_I_TELA '"&COD&"', 'N', '"&USR&"'   "			
ELSE
'UPDATE
cad =	cad + " update telas set		" & _
		" DESCRIPCION	= '"&DES&"',	" & _
		" TIPOTELA		= '"&TIPTEL&"',	" & _
		" PESOCRU		= "&PC&",		" & _
		" PESOACA		= "&PA&",		" & _
		" RENDTUB		= "&RT&",		" & _
		" RENDABI		= "&RA&",		" & _
		" ANCHCRU		= "&AC&",		" & _
		" ANCHTUB		= "&AT&",		" & _
		" ANCHABI		= "&AA&",		" & _
		" CURZAS		= "&CUR&",	    " & _
		" COLUMNAS		= "&COL&",	    " & _
		" LM1		    = "&LM1&",	    " & _
		" LM2		    = "&LM2&",	    " & _
		" LM3		    = "&LM3&",	    " & _
		" TOLMIN	    = "&TMIN&",	    " & _
		" TOLMAX	    = "&TMAX&",	    " & _
		" HIL1			= '"&M1&"',	    " & _
		" HIL2			= '"&M2&"',	    " & _
		" HIL3			= '"&M3&"',	    " & _
		" HIL4			= '"&M4&"',	    " & _
		" HIL5			= '"&M5&"',	    " & _
		" HIL6			= '"&M6&"',	    " & _
		" Por1			= "&P1&",		" & _
		" POR2			= "&P2&",		" & _
		" POR3			= "&P3&",		" & _
		" Por4			= "&P4&",		" & _
		" POR5			= "&P5&",		" & _
		" POR6			= "&P6&",		" & _
		" ENCABI1		= "&EA1&",		" & _
		" ENCABI2		= "&EA2&",		" & _
		" ENCABI3		= "&EA3&",		" & _
		" ENCLAR1		= "&EL1&",		" & _
		" ENCLAR2		= "&EL2&",		" & _
		" ENCLAR3		= "&EL3&",		" & _
		" REVIRADO		= "&REV&",		" & _
		" MONEDA		= '"&MON&"',	" & _
		" INCACA		= "&DDL&",		" & _
		" COSTO			= "&CTO&",		" & _
		" UNIDAD		= '"&UNI&"',	" & _
		" MAQUINA		= '"&CMAQ&"',	" & _
		" PESOLAV		= "&PAL&",		" & _
		" TOLMINL		= "&TMINL&",	" & _
		" TOLMAXL		= "&TMAXL&",	" & _
		" ANCHTUBLAV	= "&ATL&",	    " & _
		" ANCHABILAV	= "&AAL&",	    " & _
		" RENTTLAV  	= "&RTTL&",	    " & _
		" RENTALAV	    = "&RTAL&",	    " & _
		" CURZALAV	    = "&CURLAV&",   " & _
		" COLLAV	    = "&COLLAV&",   " & _
		" ENCLLAV1	    = "&ELL1&",     " & _
		" ENCLLAV2	    = "&ELL2&",     " & _
		" ENCLLAV3	    = "&ELL3&",     " & _
		" ENCALAV1	    = "&EAL1&",     " & _
		" ENCALAV2	    = "&EAL2&",     " & _
		" ENCALAV3	    = "&EAL3&",     " & _
		" REVLAV	    = "&REVL&",     " & _
		" INCDLAV       = "&DDLL&",     " & _
		" TITULO	    = '"&CODTIT&"', " & _
		" STAT  	    = '"&STAT&"',   " & _
		" SUBFAM		= '"&SFAM&"',   " & _
		" REALSOFT	    = '"&RCOD&"',   " & _
		" FECHA			= "&FEC&",		" & _
		" USUARIO		= '"&USR&"',	" & _
		" ESTADO		= 'A',	        " & _
		" FICHA			= '"&FIC&"'		" & _
		" where tela = '"&cod&"';		"
	
				
END IF 

'response.write(cad)
'response.Write("<BR>")
rs.open "select * from [tela-obs] where tela = '"&cod&"'",cnn
if rs.recordcount > 0 then
	cad = cad + " update [tela-obs]	 set	" & _
				" observacion = '"&OBS&"',	" & _
				" COMENTARIO = '"&DDP&"'    " & _
				" where tela = '"&cod&"';	"		
else
    cad = cad + " insert into [tela-obs]					" & _
				" (tela, observacion, COMENTARIO) values	" & _
				" ('"&cod&"', '"&OBS&"', '"&DDP&"');		"		
end if	
		
' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE(cad)
'rESPONSE.END
'*****************************
'		ENVIO DE MENSAJES
'*****************************
cnn.BeginTrans
	'On Error Resume Next
	cnn.Execute(CAD)
	
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
		
		
	Else
		cnn.RollbackTrans
		'Muestro el mensaje de que se produjo un error al intentar realizar la operación
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) ' volvemos al formulario
	End if
	

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing


%>
<script type="text/jscript" language="jscript">
window.location.replace('../fichatelas.asp?tel='+'<%=trim(cod)%>')
</script>
