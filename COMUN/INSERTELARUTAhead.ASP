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
TEL = ucase(TRIM(Request.QueryString("TEL")))
VER = ucase(TRIM(Request.QueryString("VER")))
DES = ucase(TRIM(Request.QueryString("DES")))
LAV = ucase(TRIM(Request.QueryString("LAV")))
VOL = ucase(TRIM(Request.QueryString("VOL")))
DEK = ucase(TRIM(Request.QueryString("DEK")))
TBL = TRIM(Request.QueryString("TBL"))
URL = TRIM(Request.QueryString("URL"))
FECHA ="{ fn NOW() }"


cad = 	" select tela, version, descriptor from telarutahead " & _
		" where descriptor = '"&des&"' AND TELA= '"&TEL&"'"
rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
	ver= rs.fields.item(1)
	des= rs.fields.item(2)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
top.window.alert("Descriptor duplicado")
cad = trim('<%=url%>')+ 'perfil=1&tel='+ '<%=trim(cod)%>'
cad += '&ver=' + '<%=ver%>'
cad += '&des=' + '<%=des%>'
top.window.location.replace(cad)
</script>

<%
response.End
end if
rs.close

cad = 	" select tela, version, descriptor from telarutahead 	" & _
		" where tela = '"&tel&"' and version = '"&ver&"'		"
'response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE
IF TOTALREG>0 THEN	
	if chk = "" then
		CAD =	" UPDATE  "&TBL&" set           " & _
				" descriptor = '"&DES&"',       " & _
				" VOLTEADO = '"&VOL&"' ,		" & _
				" LAVAPANO = '"&LAV&"',			" & _
				" ESTADO = 'A',                 " & _
				" USUARIO = '"&USUARIO&"',      " & _
				" FECHA = "&fecha&"             " & _
				" WHERE   tela = '"&tel&"' and	" & _
				" version = '"&ver&"';		    "
	else
		CAD =	" UPDATE "&TBL&"                " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE   tela = '"&tel&"' and	" & _
				" version = '"&ver&"';		    "
				cod=""
	end if	
else
    if 	trim(ver) = "AUTO" then
		cad = "select version from TELARUTAHEAD where tela = '"&tel&"'"
		RESPONSE.Write(CAD)
        rs.open cad, cnn
        xx = "000"
        if rs.recordcount > 0  then
            rr = cInt(rs.recordcount)+1
			ver = xx + trim(cstr(rr))    
            ver = right(ver,3)
		else
			ver = "001"	
        end if    
		
    end if       
	RESPONSE.WRITE("<BR>") 
		RESPONSE.WRITE(ver) 
'RESPONSE.END
	CAD = 	" insert into "&TBL&"   (tela, 		" & _
			" VERSION, DESCRIPTOR, ESTADO,    	" & _
			" usuario, fecha ,VOLTEADO,LAVAPANO)" & _
			" values('"&TEL&"', '"&VER&"' ,		" & _
			" '"&DES&"', 'A', '"&USUARIO&"',	" & _
			" "&fecha&", '"&VOL&"', '"&LAV&"' ) " 
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

cad  = trim('<%=url%>')+ '<%=trim(TEL)%>'+'&perfil=1'
cad += '&dek=' + '<%=dek%>'
//alert(cad)
top.window.location.replace(cad)
</script>
</BODY>
</HTML>
