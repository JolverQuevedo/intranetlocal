<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0" />
</head>
<body>
<% 


'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
os   = ucase(TRIM(Request.querystring("OS")))
ser  = ucase(TRIM(Request.querystring("TOC")))
RUC  = TRIM(Request.QueryString("RUC"))
ATT  = ucase(TRIM(Request.QueryString("ATT")))
fpa  = TRIM(Request.QueryString("fpag"))
clI  = TRIM(Request.queryString("CLI"))
cla  = TRIM(Request.queryString("cla"))
CAM  = TRIM(Request.form("TCAM"))
MON  = TRIM(Request.QueryString("MON"))
fed  = TRIM(Request.queryString("fedo"))
fpa  = TRIM(Request.queryString("fpag"))
ENT  = ucase(TRIM(Request.queryString("DIR")))
fen  = TRIM(Request.queryString("fENT"))
tem  = TRIM(Request.queryString("tem"))
est  = TRIM(Request.queryString("est"))
usr  = TRIM(UCASE(usuario))

pun  = TRIM(Request.form("PUN"))
GLO  = left(TRIM(Request.form("GLO")),200)
sol  = replace(TRIM(Request.form("soles")),",","")
dol  = replace(TRIM(Request.form("dolares")), ",","")
ubi  = TRIM(Request.form("aUbi"))
aUbi =  split(ubi,",")
pos  = TRIM(Request.form("aPos"))
aPos = split(pos, ",")
Can  = TRIM(Request.form("aCan"))
aCan = split (can, ",")

Tal  = TRIM(Request.form("aTal"))
aTal = split (tal, ",")


com  = TRIM(Request.form("aCom"))
aCom = split (com, ",")

qty  = TRIM(Request.form("aQty"))
aQty = split (qty, ",")
tot = request.form("TOTCOL")
FECHA ="{ fn NOW() }"




response.write(com)
'for each control in request.queryString
'for indice=1 to request.queryString(control).count
'response.write control&"="&request.queryString(control)(indice)&" <br>"
'next
'next
'response.write("Parametros Form")
'for each control in request.form
'for indice=1 to request.form(control).count
'response.write control&"="&request.form(control)(indice)&"<br>"
'next
'next
'response.end
'

CAD = " SELECT * FROM SERVICAB WHERE NUMORD = '"&OS&"'"
RS.OPEN CAD, CNN

if rs.recordcount > 0 then%>
    <script type="text/jscript" language="jscript">
    top.window.alert("UPDATE")
    </script>
    <%
    'response.End

end if
rs.close

    CAD = "SET DATEFORMAT DMY; "


    if 	right(trim(os),4) = "AUTO" then
        pedo = "select correl from tipserv where codigo = '"&ser&"'  " 
        rs.open pedo, cnn
        if rs.recordcount > 0  then
            rs.movefirst
            cod = right("00000" + trim(cstr(cdbl(rs.fields.item(0))+1)),4)    
        end if  
        'RESPONSE.WRITE(COD)  
        CAD = CAD + " UPDATE  tipserv  SET CORREL = CORREL +1   where codigo = '"&ser&"';"
        numord = ser + "-" + cstr(Year(date())) + "-" + cod
	    CAD = CAD + " INSERT INTO SERVICAB select '"&numord&"', '"&ser&"', '"&ruc&"', '"&att&"', '"&fpa&"',   " & _
                    " '"&cli&"', '"&mon&"', '"&cla&"', "&cam&" , "&pun&", "&sol&", "&dol&", '1', '"&ent&"',   " & _
                    " "&tot&", '"&glo&"', '"&usr&"', '"&fed&"', '"&fen&"', "&fecha&", 'a' ;                   "
    ELSE
        NUMORD = OS
        CAD = CAD + " DELETE servidet where NUMORD = '"&NUMORD&"' ; "
        CAD = CAD + " UPDATE SERVICAB SET           " & _
                    " FECHA = "&FECHA&",            " & _
                    " fecent = '"&fen&"',           " & _
                    " ruc = '"&ruc&"',              " & _
                    " tippag = '"&fpa&"',           " & _
                    " att = '"&att&"',              " & _
                    " clase = '"&cla&"',            " & _
                    " impmn = "&sol&",              " & _
                    " impus =  "&dol&" ,            " & _
                    " entrega = '"&ent&"',          " & _
                    " glosa =   '"&glo&"'           " & _
                    " WHERE numord = '"&numord&"'   " 
    end if  
    ln = 1
    ' recorre todas las PO / color que selecciono y 
    ' graba una linea de detalle por cada una
    for i=0 to ubound(aPos)     
        ' solo si hay dato
       if len(trim(aPos(i))) > 0  then
            lin = right("00"+ trim(ln),2)
            'barre las tallas del array de tallas de 10 de 10
            
                cad = cad + " insert into servidet select '"&numord&"', '"&lin&"', '"&aPos(i)&"',                       " & _
                            " '"&aubi(i)&"', "&aQty((i*10))&" , "&aQty((i*10)+1)&" , "&aQty((i*10)+2)&",                " & _
                            "  "&aQty((i*10)+3)&",   "&aQty((i*10)+4)&",   "&aQty((i*10)+5)&",   "&aQty((i*10)+6)&",    " & _
                            "  "&aQty((i*10)+7)&",   "&aQty((i*10)+8)&",   "&aQty((i*10)+9)&",  '"&aTal((i*10))&"' ,    " & _
                            " '"&aTal((i*10)+1)&"', '"&aTal((i*10)+2)&"', '"&aTal((i*10)+3)&"', '"&aTal((i*10)+4)&"',   " & _
                            " '"&aTal((i*10)+5)&"', '"&aTal((i*10)+6)&"', '"&aTal((i*10)+7)&"', '"&aTal((i*10)+8)&"',   " & _
                            " '"&aTal((i*10)+9)&"' ;                                                                    "
                dad = " EXEC SP_DESPACHO_PARTIDAS_PO '"&cli&"', '"&est&"', '"&tem&"' , '"&aCom(i)&"' , '"&aPos(i)&"' "
                IF RS.STATE = 1 THEN
                 RS.CLOSE
                END IF

                rs.open dad, cnn
                if rs.recordcount > 0 then
                    rs.movefiRst
                    cnt = 1
                    do while not rs.eof
                        it = right("00"+trim(cstr(cnt)),2)
                        tel = rs("tela")
                        PAR = RS("PARTIDA")
                        KG = CDBL(RS("KGS"))
                        QT = CINT(RS("QTY"))
                        cad = cad + " insert into servitelas select  '"&numord&"',      " & _
                                    " '"&lin&"',  '"&aPos(i)&"',  '"&aubi(i)&"',        " & _
                                    " '"&it&"', '"&tel&"', '"&PAR&"', "&KG&", "&qt&" ;  "
                        cnt = cnt + 1
                        rs.movenext
                    loop
                end if
                rs.close


            ln = ln + 1
        end if
    next


' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'RESPONSE.END
Cnn.BeginTrans	
'Cnn.Execute(CAD)
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

cad = '../fichaos.asp?perfil=1&os='+ trim('<%=trim(NUMORD)%>')
//alert(cad)
//top.window.location.replace(cad)
</script>
</body>
</html>
