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
IF TRIM(USUARIO)= "" THEN usuario = "SISTEMAS"
COD = ucase(TRIM(Request.QueryString("pos")))
COM = ucase(TRIM(Request.QueryString("com")))
colo= ucase(TRIM(Request.QueryString("colo")))
FECHA ="{ fn NOW() }"

letras="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
RESPONSE.Write(mid(letras,6,1))
aCol = split(colo,",")
response.Write("<br>")
RESPONSE.Write(mid(letras,6,1))
response.Write("<br>")
response.Write("<br>")
response.Write("<br>")
cad = "select color, combin from rayacolor where color = '"&cod&"' " & _
" and combin = '"&com&"' "
response.write(cad)
rs.open cad,cnn
CAD = ""
if rs.recordcount > 0  then 
    for i=0 to ubound(aCol)
        cad = cad + " update rayacolor set codcol= '"&aCol(i)&"', estado = 'A', " & _
                    " fecha = "&fecha&", usuario = '"&usuario&"'                " & _
                    " where color = '"&cod&"' and combin = '"&com&"'            " & _
                    " AND letra = '"&mid(letras,i+1,1)&"'                         "
    next        
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
RS.CLOSE
RS.OPEN "SELECT DESCRIPCION FROM RAYADOS WHERE COLOR = '"&COD&"' AND COMBIN = '"&COM&"'", CNN
DES = RS("DESCRIPCION")
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">

cad = '../rayaCOL.asp?perfil=1&pos='+ '<%=trim(cod)%>'+ '&COM='+ '<%=COM%>' + '&DCOM='+'<%=DES%>'
parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
