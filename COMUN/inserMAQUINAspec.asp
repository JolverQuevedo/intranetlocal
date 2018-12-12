<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<html>
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

sp  =  REQUEST.cookies("spe")
vr  =  right(REQUEST.cookies("ver"),3)

maxi = cint(request.querystring("tope")) -1
'response.write (maxi)
FECHA ="{ fn NOW() }"
' PRIMERO ME CHIFO LO QUE HABIA PARA EMPEZAR EN BLANCO Y RESETEAREL CONTADOR DE LINEAS
CAD = " set dateformat dmy ; DELETE SPECS_MAQUINAS WHERE SPEC= '"&SP&"' AND VER = '"&VR&"'; " 


cnt = 1
for k=0 to MAXI
    KI = K+1
    MAQ = trim(ucase(REQUEST.FORM("MAQ"&KI)))
    PTO = trim(UCASE(REQUEST.FORM("PTO"&KI)))
    MED = trim(UCASE(REQUEST.FORM("MED"&KI)))
    HIL = trim(UCASE(REQUEST.FORM("HIL"&KI)))
    KON = RIGHT("00"+ TRIM(CSTR(CNT)),2)
    IF LEN(TRIM(MAQ))> 0  THEN
	    CAD = CAD + " INSERT INTO SPECS_MAQUINAS            " & _
                    " SELECT '"&SP&"', '"&VR&"', '"&KON&"', " & _
                    " '"&MAQ&"' , '"&PTO&"', '"&MED&"',     " & _
                    " '"&HIL&"', '"&USUARIO&"', GETDATE(),  " & _
                    " 'A' ;                                 "
        CNT = CNT + 1
    END IF
next


'RESPONSE.Write(CAD)
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
%>
<script>
   window.location.replace("../maquinasSPEC.asp")
</script>
</BODY>
</HTML>
