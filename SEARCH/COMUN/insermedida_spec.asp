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

maxi = request.form("cnt")
'response.write (maxi)
FECHA ="{ fn NOW() }"
col = request.form("tal")
'response.write(col)
'response.end



for k=0 to MAXI
    GRUPO = REQUEST.FORM("gru"&K)
    MEDIDA = REQUEST.FORM("med"& K)
    LIN = REQUEST.FORM("lin"&K)
    ORDEN = REQUEST.FORM("ord"&K)
    TOLERA = REQUEST.FORM("tol"&K)
        for y= 0 to col
            talla = request.form("m"&y&"c"&k)
            colu = "T"&y
	        CAD = CAD + " update specs_medidas  set          " & _
                        " TOLERA  = '"&TOLERA&"',            " & _
                        " "&colu&" = '"&talla&"'         " & _    
                        " where spec= '"&sp&"' and ver = '"&vr&"' and orden = '"&ORDEN&"' and     " & _
                        " lin = '"&Lin&"' and grupo = '"&GRUPO&"' and medida = '"&MEDIDA&"'; "
        next
  
next


RESPONSE.Write(CAD)
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
URL= "../fichamedidas.ASP?cli=" + TRIM(cli) + "&tmp=" + tmp + "&est=" + est
url = url + "&spe="+ Request.querystring("sp")+"-"+ Request.querystring("vr")
'RESPONSE.Write(URL)	
'RESPONSE.END
%>
<script>
window.location.replace('<%=trim(url)%>')
</script>
</BODY>
</HTML>
