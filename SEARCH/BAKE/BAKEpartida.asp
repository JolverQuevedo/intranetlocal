<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>


<%	
DATO	= Request.QueryString("pos")

CAD =	"exec AL_TL_S_BUSCA_TELTEN_PARA_CC  '"& dato &"' " 
		RS.OPEN CAD, CNN
		' RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT > 1 then%>
			<script type="text/jscript" language="jscript">


			    alert("Partida tiene mas de un registro")
                cad = '../help/showpartidas.asp?pos=' + '<%=dato%>'
                window.open(cad)

            </script>
<%		elseif RS.RECORDCOUNT = 0 then			%>
            <script type="text/jscript" language="jscript">
			    alert("Partida NO REGISTRADA")
		    </script>
            <%RESPONSE.END%>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                top.window.thisForm.RTEL.value = '<%=trim(rs("codtel"))%>';
                top.window.thisForm.RDES.value = '<%=trim(rs("dEStel"))%>';
                top.window.thisForm.RUC.value = '<%=trim(rs("RUC"))%>';
                top.window.thisForm.PROV.value = '<%=trim(rs("PROVEEDOR"))%>';
                top.window.thisForm.KGS.value = '<%=formatnumber(trim(rs("KILOS")),3,,,true)%>';
                top.window.thisForm.RLL.value = '<%=trim(rs("ROLLOS"))%>';
                top.window.thisForm.OC.value = '<%=trim(rs("OC"))%>';
		    </script>	
<%end if%>
			
	FIN
</BODY>
</HTML>
