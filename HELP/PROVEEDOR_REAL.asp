<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
pos = Request.QueryString("pos")
CAD =	"Select AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='"&pos&"'" 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
			    alert("Proveedor no registrado")
			    window.parent.thisForm.DPRO.value = ''
			    window.parent.thisForm.PRO.value = ''
            </script>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
			    window.parent.thisForm.DPRO.value = '<%=trim(rs("ac_cnombre"))%>';
			</script>	
        <%end if%>
		
</BODY>
</HTML>
