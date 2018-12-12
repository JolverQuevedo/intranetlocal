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

COD = ucase(TRIM(Request.QueryString("cod")))
DES = ucase(TRIM(Request.QueryString("DES")))
com = ucase(TRIM(Request.QueryString("com")))
FECHA ="{ fn NOW() }"
fot = trim(cod)+trim(com)+".jpg"
letras="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

cad = "select color, combin from rayados where color = '"&cod&"' and combin = '"&com&"'"
response.write(cad)
rs.open cad,cnn

if rs.recordcount > 0  then 
    cad =   " update rayados set descripcion = '"&des&"',   " & _
            " foto = '"&fot&"', estado = 'a',               " & _
            " fecha = "&fecha&", usuario = '"&usuario&"'      " & _
            " where color = '"&cod&"' and combin = '"&com&"'"  
else 
    cAD =   " insert into rayados (color, combin, descripcion,  " & _
            " foto, usuario, fecha, estado) values ( '"&cod&"', " & _
            " '"&com&"', '"&des&"', '"&fot&"', '"&usuario&"',   " & _
            " "&fecha&", 'A');                                  "
            
    ss = "select numcol from colores where codigo = '"&cod&"' "            
    rs.close
    rs.open ss, cnn
    colo = cint(rs("numcol"))
    for i=1 to  colo 
        leta = mid(letras,i,1)
        cad = cad + "insert into rayacolor (color, combin, codcol, letra,   " & _
                    " usuario, fecha, estado) values ('"&cod&"', '"&com&"', " & _
                    " null, '"&LETA&"', '"&USUARIO&"', "&FECHA&", 'A');     "        
    next  
    ' INSERTA LA TELA LISTADO COMBINACION .....
    CAD = CAD + " INSERT INTO TELACOLOR (TELA, COLOR, COMBIN, USUARIO, FECHA, ESTADO)    " & _
                " SELECT TELA, COLOR, '"&COM&"', '"&USUARIO&"', "&FECHA&",'A' FROM      " & _
                " TELACOLOR WHERE COLOR= '"&COD&"' AND COMBIN ='00' ;                   "

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

cad = '../rayacombo.asp?perfil=1&pos='+ '<%=trim(cod)%>'
parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
