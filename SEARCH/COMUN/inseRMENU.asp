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
CHK = Request.FORM("CHK")
COD = TRIM(Request.Form("COD"))
MEN = TRIM(Request.Form("MEN"))
PRG = TRIM(Request.Form("PRG"))

FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT menu from menu where menu= '"&COD&"'"
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = 0 then
		CAD =	" UPDATE  MENU set DESMENU = '"&MEN&"', " & _
				" ESTADO = 'A' " & _
				" WHERE MENU = '"&COD&"';"
	ELSE			
				
		CAD =	" UPDATE  MENU set " & _
				" ESTADO = 'E'  " & _ 
				" WHERE   MENU = '"&COD&"' ; "
				
	end if		
		
else	
	cad = ""
	if TRIM(cod) = "AUTO" then
		cad = "select top 1 MENU from MENU order by CONVERT(INT,MENU) desc"
		RS.CLOSE
		rs.open cad,cnn
		if rs.recordcount > 0 then
			cod = cint(rs("MENU")) + 1
			prog = TRIM(PRG) + TRIM(CSTR(COD))
		ELSE
			COD = "1"
		END IF		
	end if
	CAD = cad +	" insert into MENU  " & _
				" (MENU, DESMENU, PROGRAMA, ESTADO) " & _
				" values('"&COD&"', '" & MEN & "', '" & PROG & "', 'A')  " 
End if
'Response.Write (CAD)
'Response.end'
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
Response.Redirect("../MANTMENU.ASP?PERFIL=1&POS="+ TRIM(CSTR(COD)) )
%>
</BODY>
</HTML>
