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

CAD =	"Select * From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='"&pos&"'" 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
			    alert("Proveedor no registrado")
			    window.parent.thisForm.PRO.value = ''
			    window.parent.thisForm.RUC.value = ''
			    window.parent.thisForm.NOM.value = ''
			    window.parent.thisForm.FAX.value = ''
			    window.parent.thisForm.DPRO.value = ''

            </script>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                window.parent.thisForm.PRO.value = '<%=trim(rs("ac_cCODIGO"))%>';
                window.parent.thisForm.RUC.value = '<%=trim(rs("ac_cRUC"))%>'
                window.parent.thisForm.NOM.value = '<%=trim(rs("ac_cNOMBRE"))%>'
                window.parent.thisForm.FAX.value = '<%=trim(rs("AC_CTELEF1"))%>'
                window.parent.thisForm.DPRO.value = '<%=trim(rs("ac_cDIRECC"))%>'
			</script>	
        <%end if%>
		
</BODY>
</HTML>
