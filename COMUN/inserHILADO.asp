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
MATERIA = ucase(TRIM(Request.QueryString("MATERIA")))
TITULO = ucase(TRIM(Request.QueryString("TITULO")))
ORIGEN = ucase(TRIM(Request.QueryString("ORIGEN")))
ACABADO = ucase(TRIM(Request.QueryString("ACABADO")))
UNIDAD = ucase(TRIM(Request.QueryString("UNIDAD")))
MONEDA = ucase(TRIM(Request.QueryString("MONEDA")))
REALSOFT = (Request.QueryString("REALSOFT"))
FILAMENTO = ucase(TRIM(Request.QueryString("FILAMENTO")))
COSTO = ucase(TRIM(Request.QueryString("COSTO")))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("largo"))
FECHA ="{ fn NOW() }"



cad = "select "&pk&", "&ds&" from "&tbl&" where ("&ds&" = '"&des&"' or "&pk&" = '"&cod&"') and estado= 'a'"
rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
top.window.alert("Hilado Duplicado")
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
				" REAlsoft = '"&REALSOFT&"',    " & _
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
	CAD = 	" insert into "&TBL&"               " & _
			" ("&PK&", "&DS&", FIBRA,         " & _
			" TITULO, ORIGEN, ACABADO, UNIDAD,  " & _
			" MONEDA, REALSOFT, FILAMENTOS,     " & _
			" COSTO, ESTADO, usuario, fecha )   " & _
			" values('"&COD&"', '" & DES & "',  " & _
			" '"&MATERIA&"', '"&TITULO&"',      " & _
			" '"&ORIGEN&"', '"&ACABADO&"',      " & _
			" '"&UNIDAD&"', '"&MONEDA&"',       " & _
			" '"&REALSOFT&"', '"&FILAMENTO&"',  " & _
			" "&COSTO&", 'A', '"&USUARIO&"',    " & _
			" "&fecha&" )  " 
        DES = LEFT(DES,59)
        CAD= CAD +  " INSERT INTO RSFACCAR..AL0001ARTI                      " & _
                    " (AR_CCODIGO,	AR_CDESCRI, AR_CUNIDAD, AR_CCUENTA,     " & _
                    "   AR_NIGVPOR,	AR_CTIPO,	AR_CGRUPO,		            " & _
                    "   AR_CFAMILI,	AR_CMODELO,	AR_CMONCOM, AR_CFSTOCK,     " & _
                    "   AR_CFDECI,		AR_CFPRELI,	AR_CFSERIE,             " & _
                    "   AR_CFLOTE,		AR_CESTADO,	AR_CUSUCRE, AR_DFECCRE,	" & _
                    "   AR_DFECMOD,	AR_CMARCA,	AR_CCUENTR,  AR_CCLAART)    " & _
                    "  VALUES                                               " & _
                    "  ('"&cod&"','"&des&"', '"&UNIdad&"', '241102',        " & _
                    "   '18',      'N',    'HL',	                        " & _
                    "   'MP',      'MP',  'US',		  'S',	                " & _
                    "   'S',		'S',	  	  'N',                      " & _
                    "   'N',		'V',		'AUTOM',	 "&FECHA&",	    " & _
                    "   NULL,		'MAT PRIM',			'',     'HL') ;     " 


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
