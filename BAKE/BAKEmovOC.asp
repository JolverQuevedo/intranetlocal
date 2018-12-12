<%@ Language=VBScript %>
<%session.LCID=2057 %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	
DATO =  Request.QueryString("pos")
CAD  =	" SELECT * from matriz_compra_tela   " & _
        " where codigo =  '"& dato &"'       " 
		RS.OPEN CAD, CNN
		'RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT > 0 then%>
		    <%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                parent.window.document.all.COD.value = '<%=trim(ucase(rs("codigo")))%>'
                parent.window.document.all.TIP.value = '<%=trim(ucase(rs("TIPO")))%>'
                parent.window.document.all.MOV.value = '<%=trim(ucase(rs("movim")))%>'
                parent.window.document.all.ORI.value = '<%=trim(ucase(rs("ALmori")))%>'
                parent.window.document.all.DES.value = '<%=trim(ucase(rs("almdes")))%>'
                parent.window.document.all.OLD.value = '<%=trim(ucase(rs("OLDALM")))%>'
                parent.window.document.all.SER.value = '<%=trim(ucase(rs("codSER")))%>'
                parent.window.document.all.ENT.value = '<%=trim(ucase(rs("ENTREGA")))%>'
                parent.window.document.all.REC.value = '<%=trim(ucase(rs("RECIBE")))%>'
                parent.window.document.all.LT1.value = '<%=trim(Lcase(rs("LET1")))%>'
                parent.window.document.all.LT2.value = '<%=trim(Lcase(rs("LET2")))%>'
		    </script>	
       <%end if%>
</BODY>
</HTML>
