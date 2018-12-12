<%@ Language=VBScript %>
<%Response.Buffer = TRUE%>
<%Session.LCID=2057%>
<%Usu = Request.Cookies("Usuario")("USUARIO")%>
<%'=Request.Cookies("Usuario")("USUARIO")%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>
<!--#include file="../includes/Cnn.inc"-->
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
ofi   = TRIM(Request.querystring("ofi"))
pos   = TRIM(Request.querystring("pos"))
kgs   = replace(TRIM(Request.querystring("kgs")),",","")
cod   = TRIM(Request.querystring("cod"))
alm   = TRIM(Request.querystring("alm"))
tip   = ucase(TRIM(Request.querystring("tip")))
qty   = TRIM(Request.querystring("qty"))
tal   = TRIM(Request.querystring("tal"))
LT2   = TRIM(Request.querystring("LT2"))
FEC   ="{ fn NOW() }"
if trim(kgs) = "" then kgs = 0

aqty= split(qty,",")
atal = split(tal,",")

response.write(qty)
response.write("<BR>")
response.write(TAL)


' primero borro; por si acaso le den F5 a la página
' telas tiene solo una tabla, Rectilineos usa 2!
    cad =   " delete rsv_tela where ofi= '"&ofi&"' and po= '"&pos&"'    " & _
            " and alm= '"&alm&"'  and codigo = '"&cod&"'                "
    'response.write(cad)
    response.write("<br>")
   ' cnn.execute(cad)
   ' es tela
    if cdbl(kgs) > 0 then
       cad = cad +  " insert into rsv_tela (ofi,po,alm,codigo,kgs,qty,usuario,fecha,estado,TIPo)    " & _
                    " values ('"&ofi&"','"&pos&"','"&alm&"','"&cod&"',"&kgs&",0,'"&usu&"',          " & _        
                    " "&fec&", 'R', '"&LT2&"' ) ;                                                   "
      '  RESPONSE.Write(CAD)
      ' response.write("<br>")
    
    END IF
    ' ES RECTILINEO
if tip = "R" then
    cad = cad + " delete rsv_talla where ofi= '"&ofi&"' and po= '"&pos&"'    " & _
                " and alm= '"&alm&"'  and codigo = '"&cod&"'        ;        "
    'response.write(cad)
    'response.write("<br>")
    'cnn.execute(cad)
    tot = 0
    for i = 0 to ubound(aTal)
        tot = tot  + aqty(i)
        cad = cad + " insert into rsv_talla (ofi,po,alm,codigo,LIN,talla,qty,usuario,   " & _
                    " fecha,estado) values ('"&ofi&"','"&pos&"','"&alm&"','"&cod&"',    " & _
                    " '"&I&"', '"&atal(i)&"',"&aqty(i)&",  '"&usu&"', "&fec&", 'R') ;   "
    next

    cad = cad + " insert into rsv_tela (ofi,po,alm,codigo,kgs,qty,usuario,fecha,estado, tipo)   " & _
                " values ('"&ofi&"','"&pos&"','"&alm&"','"&cod&"',0,"&tot&",'"&usu&"',    " & _        
                " "&fec&", 'R', '"&lt2&"') "     
        'RESPONSE.END
end if
Cnn.BeginTrans	
  RESPONSE.Write(CAD)
  response.write("<br>")
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
  

</BODY>
</HTML>
