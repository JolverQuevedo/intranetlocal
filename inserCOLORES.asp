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
DES = ucase(TRIM(Request.QueryString("DES")))
TON = ucase(TRIM(Request.QueryString("TON")))
TEN = ucase(TRIM(Request.QueryString("TEN")))
CLI = ucase(TRIM(Request.QueryString("CLI")))
COL = ucase(TRIM(Request.QueryString("COL")))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))
FECHA ="{ fn NOW() }"



cad = "select "&pk&", "&ds&", cliente from "&tbl&" where "&ds&" = '"&des&"' and cliente = '"&cli&"'"
'cad = "select "&pk&", "&ds&", cliente from "&tbl&" where "&ds&" = '"&des&"' and cliente = '"&cli&"' and tono = '"&TON&"' "
rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
top.window.alert("Color Duplicado")
</script>
<%cnn.execute "update colores set estado ='a' where codigo = '"&cod&"' "%>
<script type="text/jscript" language="jscript">
cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'
top.window.location.replace(cad)
</script>
<%
response.End
end if
rs.close

CAD = " SELECT "&PK&", ESTADO FROM "&TBL&" WHERE "&PK&"='"&COD&"' "
'response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount

CAD = ""
IF TOTALREG>0 THEN	
	if chk = "" then
	    CAD = CAD +	" UPDATE  "&TBL&" set           " & _
				    " "&DS&" = '"&DES&"',           " & _ 
					" COLCLI = '"&COL&"',           " & _
				    " ESTADO = 'A',                 " & _
				    " USUARIO = '"&USUARIO&"',      " & _
				    " FECHA = "&fecha&"             " & _
				    " WHERE   "&PK&" = '"&COD&"';   "
	else
		CAD =CAD +	" UPDATE "&TBL&"                    " & _
				    " SET  USUARIO = '"&USUARIO&"',     " & _
				    " FECHA = "&fecha&" ,               " & _
				    " ESTADO = 'E'	                    " & _ 
				    " WHERE "&PK&" = '"&COD&"';         "
		cad = cad + " UPDATE RAYADOS SET 		        " & _
		            " ESTADO = 'E',                     " & _
				    " USUARIO = '"&USUARIO&"',          " & _
				    " FECHA = "&fecha&"                 " & _
				    " WHERE COLOR = '"&COD&"' AND       " & _
				    " COMBIN = '00' ;                   "
        cad = cad + " UPDATE RAYACOLOR SET 		        " & _
		            " ESTADO = 'E',                     " & _
				    " USUARIO = '"&USUARIO&"',          " & _
				    " FECHA = "&fecha&"                 " & _
				    " WHERE COLOR = '"&COD&"' AND       " & _
				    " COMBIN='00' AND CODCOL='"&COD&"'; "  
        cad = cad + " UPDATE RAYASEC SET 		        " & _
		            " ESTADO = 'E',                     " & _
				    " USUARIO = '"&USUARIO&"',          " & _
				    " FECHA = "&fecha&"                 " & _
				    " WHERE COLOR = '"&COD&"' AND       " & _
				    " COMBIN='00' AND CODCOL='"&COD&"'  " & _
				    " AND SEC = 1;                      "      				    
				cod=""
	end if	
else 
    VAD = "EXEC CM_I_COLORES '', '"&DES&"', '"&CLI&"', '"&TEN&"', '"&TON&"' , '"&COL&"', '1', '1', '1', '"&USUARIO&"' "
	RS.CLOSE
	RS.OPEN VAD, CNN
	RS.MOVEFIRST
	COD = RS("CODIGO")
    rs.close
    ton = left(cod,2)
    rs.open "select letra from tonos where tono = '"&ton&"'",cnn
    rs.movefirst
    rre = rs("letra")
    rs.close
    ten = mid(cod,3,2)
    rs.open "select letra from tenido where tenido = '"&ten&"'",cnn
    rs.movefirst
    rre = rre + rs("letra")+right(cod,4)
	RS.CLOSE
	CAD =   " update rayados set REALSYS = '"&rre&"' " & _
            " where color = '"&cod&"'                "
End if
' Inicia transacci�n , para que los datos no queden a medias
'RESPONSE.WRITE("<br>")
'RESPONSE.WRITE(CAD)
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
'regresa a la p�gina de donde fu� llamado, para que vea que agreg� el registro
%>
<script language="javascript" type="text/jscript">

cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>&CLIFIL=<%=cli%>'

top.window.location.replace(cad)
</script>
</BODY>
</HTML>
