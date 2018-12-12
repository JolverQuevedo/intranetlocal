<%@ Language=VBScript%>
<%Session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	
LIN = Request.QueryString("LIN")
cod = Request.QueryString("cod")
ofi = Request.QueryString("ofi")
po  = Request.QueryString("po")
ori = Request.QueryString("ori")
lt1 = Request.QueryString("lt1")
lt2 = Request.QueryString("lt2")
ser = Request.QueryString("ser")
des = Request.QueryString("des")
KOD = Request.QueryString("KOD")
if Len(trim(cod)) < 12 then cod = LEFT(trim(cod) + "0000000000000000",16)
if Len(trim(kod)) < 12 then kod = LEFT(trim(kod) + "0000000000000000",16)
'RESPONSE.WRITE(des)
'RESPONSE.WRITE("<br>")
'RESPONSE.WRITE(ORI)
'RESPONSE.WRITE("<br>")
'ANTES DE DEJARLO PONER CHECK PARA LA OC NECESITA HABER HECHO LA RESERVA!!!
cad = " select * from rsv_tela where ofi = '"&ofi&"'    " & _
      " and alm = '"&ori&"' and po = '"&po&"' and       " & _
      " tipo = '"&lt1&"' and clase = 'S' and estado ='R'" &_
      " and almdes = '"&des&"' and  coddes = '"&kod&"'  " 
rs.open cad, cnn
response.write(cad)
if RS.RECORDCOUNT <= 0 then%>
		<script type="text/jscript" language="jscript">
		  // obj = 'OC' + '<%=LIN%>'.toString()
		  // parent.document.getElementById(obj).checked = false
          // alert('No tenemos reserva de materia prima para poder emitir OC')
        </script>
<%else
        rs.close
        ' hay que ver si hay stock para hacer la reserva en automatico

        CAD =	" Select * From ORDENCOMPRA WHERE OFI = '"&ofi&"' AND codigo = '"&ser&"' " & _
                " AND ESTADO = 'A' and  CODORI = '"&COD&"' AND ALMORI='"&ORI&"' AND      " & _
                " ALMDES ='"&DES&"' AND CODDES = '"&KOD&"'"
                RESPONSE.WRITE(CAD)
		        RS.OPEN CAD, CNN

		if RS.RECORDCOUNT > 0 then%>
			<script type="text/jscript" language="jscript">
			    obj = '<%=LIN%>'
			    eval("window.parent.document.all.RS" + obj + ".style.display = 'none'")
			    eval("window.parent.document.all.OC" + obj + ".style.display = 'none'")
               alert('Esta OFI ya tiene OC emitida para este servicio')
            </script>
		
        <%end if%>
<%end if%>
<script language="jscript" type="text/jscript">
alert("bakersvhilo")
</script>		
</BODY>
</HTML>
