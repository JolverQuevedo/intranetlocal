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
USUARIO = REQUEST.Cookies("USER")

COD = TRIM(Request.QueryString("COD"))
COL = TRIM(Request.QueryString("col"))
TAL = trim(Request.QueryString("tal"))
rea = trim(Request.QueryString("rea"))
SUN = trim(Request.QueryString("SUN"))

ACOL = SPLIT(COL,",")
ATAL = SPLIT(TAL, ",")

RESPONSE.Write("<BR>")
RESPONSE.Write((COL))
RESPONSE.Write("<BR>")
RESPONSE.Write((TAL))
RESPONSE.Write("<BR>")

if ubound(acol) = -1 then 
    redim preserve acol(0)
    acol(0) = "0000"
end if    
if ubound(atal) = -1 then 
    redim preserve atal(0)
    atal(0)= "000"
end if    
FECHA ="{ fn NOW() }"

cad = ""
FOR I=LBOUND(ACOL) TO UBOUND(ACOL)
    FOR J=LBOUND(ATAL) TO UBOUND(ATAL)
        RS.OPEN "SELECT AVIO FROM AVIOSDETA WHERE AVIO='"&COD&"' AND CODCOL = '"&ACOL(I)&"' AND CODTALLA = '"&ATAL(J)&"'", CNN
        IF RS.RECORDCOUNT > 0 THEN
            CAD = CAD +   " UPDATE AVIOSDETA SET         " & _
                          " estado = 'A' ,               " & _
                          " USUARIO ='"&USUARIO&"',      " & _
                          " FECHA = "&fecha&"            " & _
                          " WHERE CODCOL = '"&ACOL(I)&"' " & _             
                          " AND CODTALLA = '"&ATAL(J)&"' " & _
                          " AND AVIO = '"&COD&"' ;       " 
        ELSE  
            cad = cad + " INSERT INTO AVIOSDETA (AVIO, CODCOL, CODTALLA,    " & _
                        " USUARIO, FECHA, ESTADO) VALUES ('"&COD &"',       " & _
                        " '"&ACOL(I)&"', '"&ATAL(J)&"', '"&USUARIO&"',      " & _
                        " "&fecha&" , 'A');                                 " 
            cad  = cad + " exec RS_AR_I_AVIOS  '"&cod+acol(i)+atal(j)&"', 'S', '"&usuario&"', '"&rea&"' , '"&SUN&"'; "	            
       END IF           
       RS.CLOSE      
    NEXT                    
NEXT
 
Response.Write(CAD)
'RESPONSE.END

' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)

if  err.number <> 0 then
    Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
    Cnn.RollbackTrans
    Cnn.Abort
else
    Cnn.CommitTrans	
end if
 
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

%>
<script language="jscript" type="text/jscript" >
pos = '<%=cod%>'
top.window.location.replace('../fichaaviodeta.asp?pos='+pos)
</script>
</body>
</html>
