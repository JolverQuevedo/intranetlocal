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
COD = TRIM(Request.QueryString("POS"))
COL = TRIM(Request.QueryString("col"))
TAL = trim(Request.QueryString("tal"))
FECHA ="{ fn NOW() }"
if len(trim(col)) > 0 then 
    cad = " UPDATE AVIOSDETA SET        " & _
          " estado = 'E' ,              " & _
          " USUARIO ='"&USUARIO&"',     " & _
          " FECHA = "&fecha&"           " & _
          " WHERE CODCOL = '"&COL&"'    " & _             
          " AND AVIO = '"&COD&"' ;      " 
ELSE
    cad = " UPDATE AVIOSDETA SET        " & _
          " estado = 'E' ,              " & _
          " USUARIO ='"&USUARIO&"',     " & _
          " FECHA = "&fecha&"           " & _
          " WHERE CODTALLA = '"&TAL&"'  " & _             
          " AND AVIO = '"&COD&"' ;      " 
END IF
 
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
