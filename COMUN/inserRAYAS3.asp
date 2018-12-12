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
COM = "00"
letra = ucase(TRIM(Request.QueryString("letras")))
franja = ucase(TRIM(Request.QueryString("franjas")))
lin = ucase(TRIM(Request.QueryString("lin")))
fibras = cint(ucase(TRIM(Request.QueryString("fibras"))))
FECHA ="{ fn NOW() }"

response.Write(fib)
response.Write("<br>")
response.Write(lin)


cad = "select color, combin from rayasec where color = '"&cod&"' " & _
" and combin = '"&com&"'"%>
<TABLE BORDER=2>
<TR>
 <TD><B>Form Variable</B></TD>
 <TD><B>Value</B></TD>
</TR>
<%
Dim Item
For Each Item In Request.Form
%>
<TR>
 <TD><FONT SIZE="-1"><%= Item %></FONT></TD>
 <TD><FONT SIZE="-1"><%= Request.Form(Item) %>&nbsp;</FONT></TD>
</TR>
<% Next %>
</TABLE>
<%
rs.open cad,cnn
if rs.recordcount > 0   then
  
    CAD = ""
    minimo = REQUEST.QueryString("lin")
    regis = cint(rs.recordcount)
    if minimo <= regis then tope = minimo else tope = regis
   
    ' actualiza las filas existentes si 
    for i=0 to tope-1
        LS = "PAS"&I
        IF TRIM(REQUEST.FORM(LS)) = "" THEN PASA = 0 ELSE PASA  = REQUEST.FORM(LS)
        LS = "ALT"&I
        IF TRIM(REQUEST.FORM(LS))="" THEN ALTU=0 ELSE  ALTU  = REQUEST.FORM(LS)
        
        for p=0 to fibras+1
            LETT = "LETRA"&(P+1)
            FIBR = "FIBRA"&(P+1)
            ls = "LEC"&(i)&(p+1)
            letris= request.Form(ls)
            LS = "FIB"&I&(P+1)
            FIBIS = REQUEST.FORM(LS)
            
            cad = cad + " update rayasec set "&LETT&" = '"&letris&"',           " & _
                        " altura = "&ALTU&", estado = 'A',                      " & _
                        " fecha = "&fecha&", usuario = '"&usuario&"'  ,         " & _
                        " PASADAS = "&PASA&" , "&FIBR&" = '"&FIBIS&"'           " & _
                        " where color = '"&cod&"' and combin = '"&com&"'        " & _
                        " AND SEC = "&I+1&"    ;                                "

        next

    next        

    for j=i to tope -1
         for p=0 to fibras+1
            LETT = "LETRA"&(P+1)
            FIBR = "FIBRA"&(P+1)
            ls = "LEC"&(i)&(p+1)
            letris= request.Form(ls)
            LS = "FIB"&I&(P+1)
            FIBIS = REQUEST.FORM(LS)
            cad = cad + " insert into RAYASEC (COLOR, COMBIN, SEC, "&FIBR&",    " & _
                    " ALTURA, "&LETT&", USUARIO, FECHA, ESTADO, PASADAS)        " & _
                    " VALUES ('"&COD&"', '"&com&"', "&j+1&", '"&FIBIS&"',       " & _
                    " '"&ALTU&"' ,  '"&LETIS&"',                                " & _
                    " '"&USUARIO&"', "&FECHA&", 'A', '"&PASA&"' );              "
        NEXT
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
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
cad = '../rayasec.asp?perfil=1&pos='+ '<%=trim(cod)%>'+'&tel='+'<%=request.querystring("tel")%>'
window.location.replace(cad)
</script>
</BODY>
</HTML>
