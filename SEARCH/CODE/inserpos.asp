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
po = ucase(TRIM(Request.QueryString("PO")))
cot = ucase(TRIM(Request.QueryString("COT")))
cli = ucase(TRIM(Request.QueryString("CLI")))
EMB = ucase(TRIM(Request.QueryString("fec")))
tip = ucase(TRIM(Request.QueryString("TIP")))
pro = ucase(TRIM(Request.QueryString("pro")))
des = ucase(TRIM(Request.QueryString("des")))
emb = day(emb)&"/"& month(emb)&"/"&year(emb)
fob = ucase(TRIM(Request.QueryString("fob")))
col = ucase(TRIM(Request.QueryString("col")))
cn0 = ucase(TRIM(Request.QueryString("cn0")))
cn1 = ucase(TRIM(Request.QueryString("cn1")))
cn2 = ucase(TRIM(Request.QueryString("cn2")))
cn3 = ucase(TRIM(Request.QueryString("cn3")))
cn4 = ucase(TRIM(Request.QueryString("cn4")))
cn5 = ucase(TRIM(Request.QueryString("cn5")))
cn6 = ucase(TRIM(Request.QueryString("cn6")))
cn7 = ucase(TRIM(Request.QueryString("cn7")))
cn8 = ucase(TRIM(Request.QueryString("cn8")))
cn9 = ucase(TRIM(Request.QueryString("cn9")))
TAL = ucase(TRIM(Request.QueryString("TAL")))
TTT = ucase(TRIM(Request.QueryString("TTT")))
acol = split(col,",")
aTal = split(tal,",")
afob = split(fob,",")
aCn0 = split(cn0,",")
aCn1 = split(cn1,",")
aCn2 = split(cn2,",")
aCn3 = split(cn3,",")
aCn4 = split(cn4,",")
aCn5 = split(cn5,",")
aCn6 = split(cn6,",")
aCn7 = split(cn7,",")
aCn8 = split(cn8,",")
aCn9 = split(cn9,",")
response.write("<br>")
'for i=lbound(acol) to ubound(acol)
'response.write(acol(i))
'response.write("<br>")
'next

'for i=lbound(acn0) to ubound(acn0)
'if len(trim(acn0(i))) > 0 then
'    response.write(i & "-"& (acn0(i)))
'    response.write("<br>")
'end if
'next
'response.write("<br>")
'for i=lbound(acn1) to ubound(acn1)
'response.write(i & "-"&(acn1(i)))
'response.write("<br>")
'next
'response.write("<br>")
'for i=lbound(acn2) to ubound(acn2)
'response.write(i & "-"&(acn2(i)))
'response.write("<br>")
'next



FECHA ="{ fn NOW() }"



cad = "select po from pos where po = '"&po&"'"
rs.open cad,cnn
CAD = " set dateformat dmy; "
if rs.recordcount > 0 and chk <> "0" then
    ' es UPDATE ....
    if chk = "1" then
		CAD =cad +	" UPDATE  pos set           " & _
				" COTIZACION = '"&COt&"',       " & _
				" TIPOEMB   = '"&TIP&"',        " & _
				" FECEMB = '"&EMB&"',           " & _
                " destino = '"&des&"',          " & _
                " CANTIDAD = "&TTT&",           " & _
                " ESTADO = 'A',                 " & _
				" USUARIO = '"&USUARIO&"',      " & _
				" FECHA = "&fecha&"             " & _
				" WHERE  PO = '"&PO&"';         "
	else
		CAD = cad + " UPDATE POS                    " & _
				    " SET  USUARIO = '"&USUARIO&"', " & _
				    " FECHA = "&fecha&" ,           " & _
				    " ESTADO = 'E'	                " & _ 
				    " WHERE  PO = '"&PO&"';         "
				
	end if	
ELSE

	CAD = cad +	" insert into POS              	    " & _
			    " (PO, COTIZACION,CLIENTE,          " & _
                " FECEMB, TIPOEMB, destino,ESTADO,  " & _
                " usuario, fecha, CANTIDAD) values( " & _
                " '"&PO&"', '"&COT&"',	'"&CLI&"',  " & _
			    " '"&EMB&"', '"&tip&"', '"&des&"',  " & _
                " 'A','"&USUARIO&"', "&fecha&", "&TTT&");    " 
	
END IF
' BORRO TODO EL DETALLE Y LO VUELVO A CREAR (SI EXISTE...)
' PARA QUE TODOS LOS DATOS QUEDEN EXACTOS
CAD = CAD + "DELETE [PO-DETA] WHERE PO  = '"&PO&"' ; "

FOR I = 1 TO UBOUND(aCol) 
if trim(acol(i)) <> "" then
    cad = cad + " INSERT INTO [PO-DETA] (PO, COLOR, UBI,        " & _
                " FOB, CAN0, CAN1, CAN2,CAN3, CAN4, CAN5,       " &_
                " CAN6,CAN7,CAN8,CAN9, T0, T1, T2, T3,T4,       " & _
                " T5,T6,T7,T8,T9, USUARIO,FECHA, ESTADO)        " & _
                " VALUES ('"&PO&"', '"&AcOL(I)&"', '"&I&"',     " & _
                " "&aFob(I)&",   '"&aCn0(I)&"', '"&aCn1(I)&"',  " & _ 
                " '"&aCn2(I)&"', '"&aCn3(I)&"', '"&aCn4(I)&"',  " & _
                " '"&aCn5(I)&"', '"&aCn6(I)&"',                 " & _
                " '"&aCn7(I)&"', '"&aCn8(I)&"', '"&aCn9(I)&"',  " & _
                " '"&aTal(0)&"', '"&aTal(1)&"', '"&aTal(2)&"',  " & _
                " '"&aTal(3)&"', '"&aTal(4)&"', '"&aTal(5)&"',  " & _
                " '"&aTal(6)&"', '"&aTal(7)&"', '"&aTal(8)&"',  " & _
                " '"&aTal(9)&"', '"&usuario&"', "&fecha&",'A'); "

end if

next

' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
' RESPONSE.END
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
%>
<script language="javascript" type="text/jscript">
    top.window.opener.location.replace('../detapos.asp?pos=' + '<%=cli%>')
    top.window.location.replace("../fichapos.asp?po=" + '<%=po%>' + '&cli=' + '<%=cli%>')
   
   // alert(top.window.document.all.body0.src)

</script>

<%
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>

</BODY>
</HTML>
