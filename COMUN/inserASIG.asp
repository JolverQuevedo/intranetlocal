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
response.write(request.QueryString())
PO   = TRIM(Request.Form("posi"))
aPo  = split(po, ",")
CCT  = TRIM(Request.form("cctt"))
KGS  = TRIM(Request.form("Kili"))
aKg  = split(kgs, ",")
CAN  = TRIM(Request.form("canti"))
aCn  = split(can, ",")
itm  = TRIM(Request.form("ubic"))
aIt  = split(itm, ",")
SAL  = TRIM(Request.form("saldo"))
FECHA ="{ fn NOW() }"

cad = "set dateformat dmy; "
for i=0 to ubound(aPo)
    if len(trim(aKg(i)))> 0 then
        CAD = cad + " insert into po_partida select '"&aPo(i)&"',   " & _
                    " '"&cct&"',"&ait(i)&","&aKg(i)&", "&aCn(i)&", '', '' ,     " & _
                    " '"&usuario&"', "&fecha&", 'A' ;               "
    end if
next
cad = cad + " update CCTELA set saldo = "&sal&" where cct = '"&cct&"' ; "
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

 
    top.window.opener.location.reload();
    window.close()
 
</script>
</BODY>
</HTML>
