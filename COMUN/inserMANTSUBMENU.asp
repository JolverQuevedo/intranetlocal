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
COD = TRIM(Request.QueryString("MENU"))
DES = TRIM(Request.QueryString("DESMENU"))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))


FECHA ="{ fn NOW() }"
	'busca si encuentra un código duplicado
	CAD =   " SELECT "&PK&" FROM "&TBL&" " & _
			" WHERE   "&PK&" = '"&COD&"'"
			
			'cad = " select menu from menu where menu = '"&COD&"'"
	'Response.Write(CAD)'
	'response.end'
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "" then
		CAD =	" UPDATE  "&TBL&" set " & _
				" "&DS&" = '"&DES&"'  " & _ 
				" WHERE   "&PK&" = '"&COD&"';"
	end if		
		
else	
	cad = ""
	if cod = "" then
		cad = "select top 1 "&pk&" from "&tbl&" order by "&pk&" desc"
		RS.CLOSE
		rs.open cad,cnn
		if rs.recordcount > 0 then
			cod = cint(rs(pk)) + 1
		ELSE
			COD = "1"
		END IF		
			cero = ""
			for i= 0 to largo
				cero = cero + "0"
			next	
			cod = right(CERO + trim(cod),largo)
		
	end if
	CAD = cad +	" insert into "&TBL&"  " & _
				" ("&PK&", "&DS&"" & _
				" values('"&COD&"', '" & DES & "')  " 
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
Response.Redirect(URL+COD+"&NIVEL=1" )
%>
</BODY>
</HTML>
