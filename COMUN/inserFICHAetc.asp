<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%session.LCID = 2057 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%USER = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<% fec =  "{ fn NOW() }"
ETC = request.QueryString("ETC")
tip = request.QueryString("Tip")
mas = request.QueryString("maxi")
'CONSU = REQUEST.FORM("CONKI")
' PRIMERO BORRO LOS DATOS QUE HAYAN DE ANTERIORES OCACIONES

CAD = " DELETE ETC_DETA WHERE CODETC = '"&ETC&"' and codtip = '"&tip&"' ; "
' ACTUALIZAMOS LAS ETIQUETAS DE LAS COLUMNAS DE COLOR EN LA CABECERA
CAD = CAD + " UPDATE ETC SET "
FOR T= 1 TO 15
    OO = RIGHT("00"& T,2)
    DS = "DES"&OO
    DATA = TRIM(ucase(REQUEST.FORM("x"&T)))
    CAD = CAD + " "&DS&" = '"&DATA&"', "

NEXT
CAD = LEFT(CAD, LEN(CAD)-2 ) + "  WHERE CODETC = '"&ETC&"' and codtip = '"&tip&"' ;"

RESPONSE.WRITE (mas)
RESPONSE.WRITE ("<BR>")

' EMPEZAMOS A INGRESAR LOS COLORES/

letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
 Cnn.BeginTrans 
  CNT = 1
   FOR I = 0 TO mas
        KOM = "COL"& I
        KOMBO = REPLACE (UCASE(REQUEST.Form(kom))," " , "")
        IF LEN(TRIM(KOMBO)) >  0 THEN
            cn = right("000"+cstr(cnt),3)
            Cad = cad + " insert into ETC_DETA (CODETC, UBI, COMBO,  COL01,     " & _
                        " COL02, COL03, COL04, COL05, COL06, COL07, COL08,      " & _
                        " COL09, col10, col11, COL12, COL13, COL14, COL15,      " & _
                        " USUARIO, FECHA, ESTADO, CODTIP ) VALUES ('"&ETC&"',   " & _
                        "  '"&CN&"',  '"&KOMBO&"', "
            FOR J=1 TO 15
                COL =  REPLACE(UCASE(TRIM(Request.Form("C"& J & "C"  & i) )),",", "")
                CAD = CAD + " '"&COL&"', "
            next    
            CAD = CAD + " '"&USER&"', GETDATE(), 'A' , '"&TIP&"') ;"
            CNT = CNT  + 1
               cnn.execute (cad)
               cad = ""
        END IF
        
   next 

response.write (cad)
'RESPONSE.End
' Inicia transacción , para que los datos no queden a medias
	
 
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
Cnn.Close	
%>
<script language="jscript" type="text/jscript">

   window.location.replace("../ETC.asp?ETC="+'<%=ETC%>'+ '&TIP='+'<%=TIP%>')
    
</script>


<body>

</body>
</html>
