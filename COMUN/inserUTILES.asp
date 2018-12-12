<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<% 
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
COD = ucase(TRIM(Request.QueryString("cod")))
DES = ucase(TRIM(Request.QueryString("DES")))
FAM = ucase(TRIM(Request.QueryString("FAMILIA")))
UNIDAD = ucase(TRIM(Request.QueryString("UNIDAD")))
MONEDA = ucase(TRIM(Request.QueryString("MONEDA")))
COSTO = ucase(TRIM(Request.QueryString("COSTO")))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))
FECHA ="{ fn NOW() }"



cad = "select "&pk&", "&ds&" from "&tbl&" where "&ds&" = '"&des&"' and estado= 'a'"
rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
top.window.alert("Util Duplicado")
cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'
top.window.location.replace(cad)
</script>
<%
response.End
end if
rs.close

CAD = " SELECT "&PK&" FROM "&TBL&" WHERE "&PK&"='"&COD&"' "
'response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE
IF TOTALREG>0 THEN	
	if chk = "" then
		CAD =	" UPDATE  "&TBL&" set           " & _
				" "&DS&" = '"&DES&"',           " & _ 
				" UNIDAD = '"&UNIDAD&"',        " & _
				" MONEDA = '"&MONEDA&"',        " & _
				" COSTO = "&COSTO&",            " & _
				" ESTADO = 'A',                 " & _
				" USUARIO = '"&USUARIO&"',      " & _
				" FECHA = "&fecha&"             " & _
				" WHERE   "&PK&" = '"&COD&"';   "
	else
		CAD =	" UPDATE "&TBL&"                " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE "&PK&" = '"&COD&"';     "
				cod=""
	end if	
else 
	XX = "UT" + TRIM(FAM)+"%"
	CAD = " SELECT COUNT(codigo) FROM utiles WHERE codigo like '"&XX&"' "
	RESPONSE.WRITE("<br>")
	response.Write(cad)
	rs.open cad,cnn
	IF RS.recordcount > 0 THEN CORR = CDBL(RS.FIELDS.ITEM(0))+1 ELSE CORR = 0
	RS.CLOSE
	COD = "UT" + TRIM(FAM) + RIGHT("00000" + TRIM(CSTR(CORR)),5)
	RESPONSE.Write(COD)
	CAD = 	" insert into "&TBL&"                	" & _
			" ("&PK&", "&DS&", FAMUTI,           	" & _
			"  UNIDAD,   	" & _
			" MONEDA,  COSTO, ESTADO, usuario, 	 	" & _
			" fecha) values('"&COD&"', '"&DES&"',	" & _
			" '"&FAM&"', '"&UNIDAD&"', '"&MONEDA&"'," & _
			" "&COSTO&", 'A', '"&USUARIO&"',    	" & _
			" "&fecha&" )  ;							" 
	CAD = CAD + " EXEC RS_AR_I_UTILES  '"&COD&"', '"&USUARIO&"'; "
End if
' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'RESPONSE.END
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
%>
<script language="javascript" type="text/jscript">

cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'

top.window.location.replace(cad)
</script>
</BODY>
</HTML>
