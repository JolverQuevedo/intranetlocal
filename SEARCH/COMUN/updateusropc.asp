<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
OPC = CINT(Request.QueryString("opc"))
Response.Write(Request.QueryString)

	MEN = Request.QueryString("MENu")
	sss = (Request.QueryString("sub"))
	usr = (Request.QueryString("usr"))
	opc = (Request.QueryString("opc"))
	FECHA ="{ fn NOW() }"
	'	busca si encuentra un código duplicado
	CAD =	" SELECT * FROM [usr-opc]	" & _
			" WHERE MENU = '"&MEN&"'	" & _
			" AND SUBMENU= '"&sss&"'	" & _
			" AND USUARIO= '"&USR&"'	"
	rs.open cad,cnn
	if rs.recordcount > 0 then		
		if opc = 0 then
			CAD =	" DELETE  [usr-opc]			" & _
					" WHERE MENU = '"&MEN&"'	" & _
					" AND SUBMENU= '"&sss&"'	" & _
					" AND USUARIO= '"&USR&"'	"
		else
			CAD =	" UPDATE  [usr-opc]			" & _
					" set perfil = '"&opc&"'	" & _
					" WHERE MENU = '"&MEN&"'	" & _
					" AND SUBMENU= '"&sss&"'	" & _
					" AND USUARIO= '"&USR&"'	"
		end if		
	else
		CAD =	" INSERT INTO [usr-opc]	(	" & _
				" MENU, SUBMENU, PERFIL,	" & _
				" USUARIO ) VALUES (		" & _
				" '"&MEN&"', '"&sss&"',		" & _
				" '"&opc&"', '"&USR&"' )	"	
	end if 				
Response.Write (CAD)
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
%>

</BODY>
</HTML>
