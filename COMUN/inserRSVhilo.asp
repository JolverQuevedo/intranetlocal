<%@ Language=VBScript %>
<%Response.Buffer = TRUE%>
<%Session.LCID=2057%>
<%Usu = Request.Cookies("Usuario")("USUARIO")%>
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
pos   = TRIM(Request.querystring("po"))
kil   = TRIM(Request.querystring("akil"))
hil   = TRIM(Request.querystring("ahil"))
alm   = TRIM(Request.querystring("ori"))
ori   = TRIM(Request.querystring("ori"))
dele  = TRIM(Request.querystring("dele"))
qty   = TRIM(Request.querystring("qty"))
LT1   = TRIM(Request.querystring("LT1"))
ser   = TRIM(Request.querystring("ser"))
KOD   = TRIM(Request.querystring("KOD"))
DES   = TRIM(Request.querystring("DES"))
lin   = TRIM(Request.querystring("lin"))
FEC   ="{ fn NOW() }"
aHil  = split(hil,",")
aKil  = split(kil, ",")
cad   =  ""
 Cnn.BeginTrans	
   ' response.write(hil)
   ' primero borro; por si acaso le den F5 a la página O SEA UNA CANCELACION
    msg = 0
    for i = 0 to ubound(ahil)
        cad = cad + " delete rsv_tela where ofi= '"&ofi&"' and alm= '"&alm&"'        " & _
                    " and codigo = '"&ahil(i)&"' and tipo ='"&lt1&"' and clase = 's' " & _
                    " and coddes = '"&kod&"'  and almdes = '"&des&"';                "
        ' dele = 1 es una reserva
        ' dele = 2 es una cancelacion y ya está eliminado por la instruccion anterior
        cnn.execute (cad)
        if cint(dele) = 1 then          
            if cdbl(akil(i)) > 0 then
            'response.write(akil(i))
            mda =  " SELECT DISTINCT SK_CCODIGO,SK_NSKDIS= ISNULL((select SK_NSKDIS-(select CAN = CASE    " & _
                    " WHEN SUM(QTY)>0 THEN SUM(QTY) WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END            " & _
                    " from rsv_tela  where CODIGO = '"&ahil(i)&"' and almdes = '"&des&"' and              " & _   
                    " coddes = '"&kod&"') from rsfaccar..AL0001STOC                                       " & _
                    " where sk_calma = ('"&ori&"')  and sk_ccodigo= '"&ahil(i)&"'),0), UPPER(sk_calma) AS " & _   
                    " SK_CALMA,   RSV = (SELECT ISNULL(sum(CASE WHEN QTY=0 THEN KGS ELSE QTY END),0)      " & _
                    " FROM RSV_TELA WHERE CODIGO='"&ahil(i)&"' AND ALM='"&ori&"'  and ofi ='"&ofi&"'      " & _
                    " and replace(PO,' ','') = '"&po&"' and almdes = '"&des&"' and coddes = '"&kod&"'),   " & _   
                    " FEC = (SELECT FECHA FROM RSV_TELA WHERE CODIGO='"&ahil(i)&"' AND ALM='"&ori&"'      " & _
                    " and ofi ='"&ofi&"'     and replace(PO,' ','') = '"&po&"' and almdes = '"&des&"'     " & _
                    " and coddes = '"&kod&"')                                                             " & _
                    " FROM RSFACCAR..AL0001STOC WHERE SK_CALMA = '"&ori&"' AND SK_CCODIGO = '"&ahil(i)&"' " 
                rs.open mda,cnn               
               ' response.write(mda)
                response.write("<br>")
                'response.Write((cdbl(rs("SK_NSKDIS")))) 
                if rs.recordcount > 0 then 
                    rs.movefirst
                   
                   ' response.write("<br>")
                    response.Write(((cdbl(rs("SK_NSKDIS"))+ cdbl(rs("RSV"))   ) - cdbl(akil(i))) )
                   ' response.write("<br>")
                   ' response.Write(cdbl(akil(i)) )
                   ' response.write("<br>")
                    'response.End
                    if ((cdbl(rs("SK_NSKDIS"))+ cdbl(rs("RSV"))   ) - cdbl(akil(i))) > 0 then
                        cad = cad + " insert into rsv_tela (ofi,po,alm,codigo,kgs,qty,      " & _
                                    " usuario,fecha,estado,TIPo,                            " & _
                                    " clase, almdes, coddes ) values ('"&ofi&"','"&pos&"',  " & _
                                    " '"&alm&"','"&aHil(i)&"',                              " & _
                                    " "&aKil(i)&",0,'"&usu&"',  "&fec&", 'R', '"&LT1&"',    " & _
                                    " 'S', '"&DES&"', '"&KOD&"' ) ;                         "
                    else
                        msg = 1
                    end if
                end if
                    rs.close
            end if     
        END IF
    next  




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
RESPONSE.Write(cad)
response.write("<br>")
	
%>


<script language="jscript" type="text/jscript">
  
   msg = '<%=msg%>'

   if (parseInt(msg, 10) == 1) {
       alert('No alcanza el stock para el servicio INSER...')
       ln = parseInt('<%=lin%>',10)
       dato = 'OC' + ln.toString()
       parent.document.getElementById(dato).checked = false
       /* ln = parseInt('<%=lin%>', 10)
       dato = 'if' + ln.toString()
       parent.document.getElementById(dato).style.display = 'none'
      ln= parseInt(ln,10) * 2
       dato = 'RV' + ln.toString()
       parent.document.getElementById(dato).onclick
       */
   }
   
</script>


</BODY>
</HTML>
