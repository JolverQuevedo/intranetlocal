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
OPC = Request.QueryString("OPC")
tel = ucase(TRIM(Request.QueryString("tel")))
COD = ucase(TRIM(Request.QueryString("cod")))
DES = ucase(TRIM(Request.QueryString("DES")))
RAP = ucase(TRIM(Request.QueryString("RAP")))
FRA = ucase(TRIM(Request.QueryString("FRA")))
OBS = ucase(TRIM(Request.QueryString("OBS")))
NUME = ucase(TRIM(Request.QueryString("NUME")))
CLI = ucase(TRIM(Request.QueryString("CLI")))
COL = ucase(TRIM(Request.QueryString("COL")))
'PAS = ucase(TRIM(Request.QueryString("PAS")))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))
Usuario = TRIM(Request.QueryString("usr"))
FECHA ="{ fn NOW() }"
'response.write(usuario)
'response.Write("<br>")
cad = "select "&pk&", "&ds&", cliente from "&tbl&" where "&ds&" = '"&des&"' and cliente = '"&cli&"'"

rs.open cad,cnn
'RESPONSE.END
if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
   response.Write(cad)
    %>
    <script type="text/jscript" language="jscript">
    top.window.alert("Ya Existe un listado con esta descripcion, para este mismo CLIENTE")
    </script>
    <%cnn.execute "update colores set estado ='a' where codigo = '"&cod&"' "%>
    <script type="text/jscript" language="jscript">
    cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'
    top.window.location.replace(cad)
    </script>
    <%
    '
end if
'response.End
rs.close

CAD = " SELECT *  FROM "&TBL&" WHERE "&PK&"='"&COD&"' "
response.Write(opc)

rs.open cad,cnn

TOTALREG = rs.recordcount

CAD = ""
IF TOTALREG>0 THEN	
	if chk = "4" then
        numc = rs("numcol")
        numf = rs("numfra")
        rapp = rs("rapport")

	    CAD = CAD +	" UPDATE  "&TBL&" set           " & _
				    " "&DS&" = '"&DES&"',           " & _ 
				    " COLCLI = '"&COL&"',           " & _
                    " cliente = '"&cli&"',          " & _
				    " numcol = "&nume&",            " & _
				    " rapport = "&rap&",            " & _
                    " OBS    = '"&OBS&"',           " & _
				    " numfra = "&fra&",             " & _
				    " ESTADO = 'A',                 " & _
				    " USUARIO = '"&USUARIO&"',      " & _
				    " FECHA = "&fecha&"             " & _
				    " WHERE   "&PK&" = '"&COD&"';   "
        ' ***********************************************************************
        ' verificar que la modificación VARIA los datos de secuencia y colores
        ' ***********************************************************************
        IF OPC <> "ACTUALIZA" THEN
            CAD = cad + " delete rayacolor              " & _
                        " WHERE COLOR = '"&COD&"';      " & _
                        " delete rayasec                " & _
                        " WHERE COLOR = '"&COD&"';      " 
            franjas()
       
        END IF
        
        
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
       		    
				cod=""
	end if	
else 
    
    VAD = "EXEC CM_I_COLORES '', '"&DES&"', '"&CLI&"', '99', '99' , '"&COL&"', "&nume&", "&rap&", "&FRA&",  '"&USUARIO&"'; "
	RS.CLOSE
	RS.OPEN VAD, CNN
    cod = rs("codigo")
	cad = cad + "insert into telacolor (tela, color, combin, usuario, fecha, estado)       " & _
                " values ('"&tel&"', '"&cod&"', '00', '"&usuario&"', "&fecha&",'a');       "

    CAD = CAD + " UPDATE  "&TBL&" set  OBS = '"&OBS&"' WHERE   "&PK&" = '"&COD&"';         "

    RESPONSE.WRITE(CAD)
End if

sub franjas()
for i =1 to cint(FRA)
    cad = cad + " insert into RAYASEC (COLOR, COMBIN, SEC,          " & _
                " ALTURA, LETRA1, USUARIO, FECHA, ESTADO, PASADAS)  " & _
                " VALUES ('"&COD&"', '00', "&I&", NULL,             " & _
                " NULL, '"&USUARIO&"', "&FECHA&", 'A', NULL );      "
next


end sub

' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")


'RESPONSE.WRITE(CAD)
'RESPONSE.END


IF LEN(TRIM(CAd))> 0 then
    Cnn.BeginTrans	
    Cnn.Execute(CAD)
    if  err.number <> 0 then
	    Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	    Cnn.RollbackTrans
	    Cnn.Abort
    else
	    Cnn.CommitTrans	
    end if
end if

RESPONSE.WRITE("<br>")


RESPONSE.WRITE(CAD)
RESPONSE.WRITE("<br>")


RESPONSE.WRITE(err.number)
'RESPONSE.END
'RESPONSE.END

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">

cad = trim('<%=url%>')+ 'perfil=1&tel='+ '<%=trim(tel)%>' + '&pos=' + '<%=cod%>'
parent.window.location.replace(cad)

</script>
</BODY>
</HTML>
