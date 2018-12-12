0<%@ Language=VBScript %>
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

ord = ucase(TRIM(Request.QueryString("ord")))
Tal = ucase(TRIM(Request.QueryString("Tal")))
agu = ucase(TRIM(Request.QueryString("agu")))
anc = ucase(TRIM(Request.QueryString("anc")))

FECHA ="{ fn NOW() }"



cad = "select codigo, talla from rectil_cli_talla where codigo = '"&cod&"' and talla = '"&tal&"'"
rs.open cad,cnn
' era un INSERT....
if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
top.window.alert("Talla Duplicada")
</script>
<%cnn.execute "update rectil_cli_talla set estado ='a' where codigo = '"&cod&"' "%>
<script type="text/jscript" language="jscript">
cad = '../ficharectil.asp?pos='+ '<%=cod%>'
parent.window.location.replace(cad)
</script>
<%
response.End
end if
rs.close

CAD = " SELECT CODIGO,TALLA, ESTADO FROM rectil_cli_talla WHERE CODIGO = '"&COD&"' AND TALLA = '"&TAL&"' " 
response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount

CAD = ""
IF TOTALREG>0 THEN	
	if chk = "1" then
    ' DELETE
	    CAD = CAD +	" UPDATE rectil_cli_talla set   " & _
				    " ESTADO = 'e',                 " & _
				    " USUARIO = '"&USUARIO&"',      " & _
				    " FECHA = "&fecha&"             " & _
				    " WHERE  CODIGO = '"&COD&"' AND " & _
                    " TALLA = '"&TAL&"' ;           "
	else
    ' UPDATE
		CAD =CAD +	" UPDATE rectil_cli_talla           " & _
				    " SET  USUARIO = '"&USUARIO&"',     " & _
				    " FECHA = "&fecha&" ,               " & _
                    " ANCHO     = '"&ANC&"',            " & _
                    " TALLA     = '"&TAL&"',            " & _
                    " AGUJAS    = '"&AGU&"',            " & _
				    " ESTADO = 'A'	                    " & _ 
				    " WHERE  CODIGO = '"&COD&"' AND     " & _
                    " TALLA = '"&TAL&"' ;               "
	end if	
else 
    IF TOTALREG<=0 THEN	
        rs.close
        CAD = " SELECT CODIGO,TALLA, ESTADO FROM rectil_cli_talla WHERE CODIGO = '"&COD&"' AND ORDEN= '"&ORD&"' " 
        response.Write(cad)
        rs.open cad,cnn
        TOTALREG = rs.recordcount
    END IF
    IF TOTALREG>0 THEN	
         CAD =CAD +	" UPDATE rectil_cli_talla           " & _
				    " SET  USUARIO = '"&USUARIO&"',     " & _
				    " FECHA = "&fecha&" ,               " & _
                    " ANCHO     = '"&ANC&"',            " & _
                    " TALLA     = '"&TAL&"',            " & _
                    " AGUJAS    = '"&AGU&"',            " & _
				    " ESTADO = 'A'	                    " & _ 
				    " WHERE  CODIGO = '"&COD&"' AND     " & _
                    " ORDEN = '"&ORD&"' ;               "
	ELSE	
    
        cad = cad +  " INSERT INTO rectil_cli_talla (CODIGO, " & _
                    " ORDEN, TALLA, AGUJAS, ANCHO, USUARIO, " & _
                    " FECHA, ESTADO) VALUES ('"&COD&"',     " & _
                    " '"&ORD&"', '"&TAL&"', '"&AGU&"',      " & _
                    " '"&ANC&"', '"&USUARIO&"', "&FECHA&", 'A' ); "
    end if
End if
' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'RESPONSE.END
IF LEN(TRIM(CAd))> 0 then
    Cnn.BeginTrans	
    Cnn.Execute(CAD)
    if  err.number <> 0 then
	    Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	    Cnn.RollbackTrans
	    Cnn.Abort
    else
	    Cnn.CommitTrans	
    end if
end if
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">

cad = '../ficharectil.asp?perfil=1&pos='+ '<%=trim(cod)%>'

top.window.location.replace(cad)
</script>
</BODY>
</HTML>
