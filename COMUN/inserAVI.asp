<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

DIM COD_AVIO

COD = TRIM(Request.form("COD"))
DES = TRIM(Request.form("DES"))
FAM = trim(Request.Form("FM"))
NIV = TRIM(Request.form("NIV"))
ORI = TRIM(Request.form("ORI"))
TIP = TRIM(Request.form("TIP"))
UNI = TRIM(Request.form("UNI"))
MON = TRIM(Request.form("MON"))
CTO = TRIM(Request.form("CTO"))
REA = TRIM(Request.form("REA"))
SUN = TRIM(Request.form("SUN"))
cst = TRIM(Request.form("cst"))
FECHA ="{ fn NOW() }"
chk = request.QueryString("chk")


IF TRIM(COD)= "AUTO" THEN
' SI COD = "AUTO"... ES INSERT
    CAD =   " SELECT DESCRIPCION, CODIGO FROM AVIOS WHERE  DESCRIPCION= '"&DES&"' "
	RS.Open CAD, CNN
	if RS.RECORDCOUNT > 0 then
    ' ESTAN CREANDO UN CODIGO DUPLICADO	O DESELIMINANDOLO
	    COD =  RS("CODIGO")
	    CAD =	" UPDATE AVIOS					" & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,			" & _
				" ESTADO = 'A'					" & _ 
				" WHERE CODIGO = '"&COD&"' ;	"
	ELSE
	' SE HACE EL INSERT
	    CAD =	    " UPDATE  FAMAVIOS set CORREL = CORREL + 1          " & _
	                " WHERE CODIGO = '"&FAM&"' ;                        " 
	    CAD = CAD + " insert into AVIOS (CODIGO,  REALSOFT,             " & _
				    " DESCRIPCION, UNIDAD,  MONEDA, COSTO, ESTADO,      " & _
				    " usuario, fecha, famavi,TIPEXPLO, tipavi, ORIGEN)  " & _
				    " SELECT RTRIM(LTRIM(STR(CORREL))) , '"&REA&"',     " & _
				    " '"&DES&"',  '" & UNI & "',  '" & MON & "',        " & _
				    " '"&CTO&"','A', '"&USUARIO&"', "&fecha&" ,         " & _
				    " '"&FAM&"', '"&NIV&"', '"&TIP&"', '"&ORI&"'        " & _
				    " FROM FAMAVIOS WHERE CODIGO = '"&FAM&"' ;          " 
		cad = cad + " INSERT INTO AVIOSDETA (AVIO, CODCOL, CODTALLA,    " & _
		            " USUARIO, FECHA, ESTADO) SELECT                    " & _
		            " RTRIM(LTRIM(STR(CORREL))) ,'0000', '00000',       " & _
				    " '"&USUARIO&"', "&fecha&" , 'A'                    " & _   	
       		        " FROM FAMAVIOS WHERE CODIGO = '"&FAM&"' ;          "  		
        
    END IF
ELSE
'	busca EL código PARA UPDATE O DELETE
	CAD =   " SELECT CODIGO FROM AVIOS WHERE CODIGO= '"&COD&"' "
    'RS.CLOSE
	RS.Open CAD, CNN
	if RS.RECORDCOUNT > 0 then
		IF CHK="0" THEN
			CAD =	" UPDATE  AVIOS set				" & _
					" UNIDAD = '"&UNI&"',			" & _  
					" DESCRIPCION = '"&des&"',		" & _  					
					" MONEDA = '"&MON&"',			" & _ 
					" COSTO = '"&CTO&"',			" & _
					" TIPAVI = '"&TIP&"',			" & _
					" ORIGEN = '"&ORI&"',			" & _
					" ESTADO = 'A',					" & _
					" USUARIO = '"&USUARIO&"',		" & _
                    " REALSOFT = '"&REA&"',		" & _
					" FECHA = "&fecha&"				" & _
					" WHERE  CODIGO = '"&COD&"';	"
		else
			CAD =	" UPDATE AVIOS					" & _
					" SET  USUARIO = '"&USUARIO&"', " & _
					" FECHA = "&fecha&" ,			" & _
					" ESTADO = 'E'					" & _ 
					" WHERE CODIGO = '"&COD&"' ;	"
		END IF	
	END IF			
End if

Response.Write(CAD)
'response.end
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)


cSql = 	" SELECT RTRIM(LTRIM(STR(CORREL))) from  FAMAVIOS WHERE CODIGO = '"&FAM&"' ; " 	    
		    rs.close
		    rs.open cSql,cnn
		    rs.movefirst
		    IF COD = "AUTO" THEN  COD = rs.fields(0) ELSE XX =  rs.fields(0)
            cas = " exec RS_AR_I_AVIOS '"&cod&"',  'N', '"&usuario&"', '"&rea&"', '"&SUN&"', '"&cst&"' "	
            response.write(cas)
		cnn.execute(" exec RS_AR_I_AVIOS  '"&cod&"',  'N', '"&usuario&"' , '"&rea&"', '"&SUN&"', '"&cst&"' "	)
		cnn.execute(" exec RS_AR_I_AVIOS_SMA  '"&cod&"',  'N', '"&usuario&"', '"&rea&"', '"&SUN&"', '"&cst&"' "	)


if  err.number <> 0 then
    Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
    Cnn.RollbackTrans
    Cnn.Abort
else
    Cnn.CommitTrans	
end if
 response.write (dddd)
'RESPONSE.END

IF COD = "AUTO" THEN
    CAD = "SELECT STR(CORREL,10,0) AS CORREL FROM FAMAVIOS WHERE CODIGO = '"&FAM&"' "
    Response.Write(CAD)
    RS.CLOSE
    RS.OPEN CAD, CNN
    COD =TRIM(RS("CORREL"))
    'Response.Write(COD)
    RS.CLOSE
END IF
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

XURL="../avios.asp?pos="+CSTR(COD)+"&perfil=1"
Response.Redirect(XURL)
%>
</body>
</html>
