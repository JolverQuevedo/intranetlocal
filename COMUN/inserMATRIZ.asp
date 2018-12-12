<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../includes/rutinas.asp"-->
<%'********************************************************************************************
'PROCESO        : INSERCION DE NUEVOS elementos para crear las OC en el Real desde la Intranet
'CREACION       : MABEL MOLINA
'FECHA CREACION : 
'FECHA MODIFIC  : 23/03/2017
'**********************************************************************************************%>
<%Response.Buffer = TRUE %>
<%
FAD = ""
COD = (Request.querystring("COD"))
TIP = (Request.querystring("TIP"))
MOV = (Request.querystring("MOV"))
ORI = (Request.querystring("ORI"))
DES = (Request.querystring("DES"))
OLD = (Request.querystring("OLD"))
SER = (Request.querystring("SER"))
REA = (Request.querystring("REA"))
ENT = (Request.querystring("ENT"))
REC = (Request.querystring("REC"))
LT1 = LCASE((Request.querystring("LT1")))
LT2 = LCASE((Request.querystring("LT2")))
url = (Request.querystring("url"))

FECHA ="{ fn NOW() }"

IF ucase(trim(cod)) = "AUTO" THEN

CAD =   " SELECT TOP 1 codigo  FROM MATRIZ_COMPRA_TELA  " & _
			" ORDER BY CODIGO DESC                      "
	RS.Open CAD, CNN
	IF RS.RecordCount > 0  THEN	
		RS.MOVEFIRST
		COD = CDBL(RS("CODIGO")) + 1
		COD = RIGHT("000" + LTRIM(RTRIM(COD)),3)
	else
        cod = "001"
    end if    	
	CAD =	" insert into MATRIZ_COMPRA_TELA            " & _
			" (CODIGO, TIPO, MOVIM, ALMORI, ALMDES,     " & _
            " CODSER, ENTREGA, RECIBE,  usuario,        " & _
            " fecha,LET1, LET2,OLDALM,CODMOV) values('"&COD&"'," & _
            " '" &tip& "',     '" & mov & "',           " & _
			" '" & ori & "', '"&des&"', '" & ser & "'   " & _
			" ,'"&ent&"', '" &rec& "',  '"&USUARIO&"',  " & _
			"   "&fecha&",'"&LT1&"','"&LT2&"','"&OLD&"','"&REA&"')" 
else	
		CAD =	" UPDATE MATRIZ_COMPRA_TELA set " & _
				" tipo      = '"&tip&"',        " & _ 
				" movim     = '"&mov&"',        " & _
				" almori    = '"&ori&"' ,       " & _
				" almdes    = '"&des&"' ,       " & _
                " OLDALM    = '"&OLD&"',        " & _
				" codser    = '"&ser&"' ,       " & _
				" entrega   = '"&ent&"' ,       " & _
				" recibe    = '"&rec&"' ,       " & _
                " LET1      = '"&LT1&"',        " & _
                " LET2      = '"&LT2&"',        " & _
                " CODMOV    = '"&REA&"',        " & _
				" USUARIO   = '"&USUARIO&"',    " & _
				" FECHA     = "&FECHA&"         " & _
				" WHERE codigo = '"&COD&"';     "

End if
cnn.BeginTrans
Response.Write(cad)
'Response.end
	cnn.Execute(CAD)
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
	Else
		cnn.RollbackTrans
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) 
	End if
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing
'regresa a la página de donde fué llamado, para que vea que agregó el registro
cod = cstr(cod)
eee= "../matriztelareal.asp"%>
<script>
top.window.location.replace('<%=trim(eee)%>')
</script>