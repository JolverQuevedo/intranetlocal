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
CHK = Request.QueryString("chk")
os = ucase(TRIM(Request.QueryString("os")))
ser = ucase(TRIM(Request.QueryString("TOC")))
RUC = TRIM(Request.QueryString("RUC"))
ATT  = TRIM(Request.QueryString("ATT"))
fpa  = TRIM(Request.QueryString("fpag"))
clI  = TRIM(Request.queryString("clI"))
cla  = TRIM(Request.queryString("cla"))
CAM  = TRIM(Request.QueryString("CAM"))
MON  = TRIM(Request.QueryString("MON"))
fed  = TRIM(Request.queryString("fedo"))
fpa  = TRIM(Request.queryString("fpag"))
pun  = TRIM(Request.queryString("pun"))
usr  = TRIM(Request.queryString("usr"))
GLO  = left(TRIM(Request.queryString("GLO")),200)
ENT  = TRIM(Request.queryString("DIR"))
fen  = TRIM(Request.queryString("fENT"))
sol  = TRIM(Request.queryString("sol"))
dol  = TRIM(Request.queryString("dol"))
ubi  = TRIM(Request.queryString("ubi"))
aUbi =  split(ubi,",")
pos  = TRIM(Request.queryString("pos"))
aPos = split(pos, ",")
Can  = TRIM(Request.queryString("can"))
aCan = split (can, ",")
FECHA ="{ fn NOW() }"
'response.write(ser)

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
            cod = right("00000" + trim(cstr(rs.fields.item(0)+1)),4)    
        end if  
        'RESPONSE.WRITE(COD)  
        CAD = CAD + " UPDATE  tipserv  SET CORREL = CORREL +1   where codigo = '"&ser&"';"
        numord = ser + "-" + cstr(Year(date())) + "-" + cod
	    CAD = CAD + " INSERT INTO SERVICAB select '"&numord&"', '"&ser&"', '"&ruc&"', '"&att&"', '"&fpa&"',   " & _
                    " '"&cli&"', '"&mon&"', '"&cla&"', '"&cam&"' , "&pun&", "&sol&", "&dol&", '1', '"&ent&"', " & _
                    "  '"&glo&"', '"&usr&"', '"&fed&"', '"&fen&"', "&fecha&", 'a' ;                           "
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
    for i=0 to ubound(aPos)     
        'response.write(acan(i))
 '       if cInt(trim(aCan(i))) > 0 then
            lin = right("00"+ trim(ln),2)
            cad = cad + " insert into servidet select '"&numord&"', '"&lin&"', '"&aPos(i)&"',   " & _
                        " '"&aubi(i)&"', "&aCan(i)&" ;                                          "
            ln = ln + 1
  '      end if
    next


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

cad = '../fichaos.asp?perfil=1&os='+ trim('<%=trim(NUMORD)%>')
//alert(cad)
top.window.location.replace(cad)
</script>
</BODY>
</HTML>
