<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
DATO= Request.QueryString("pos")

CAD =	"SELECT HILO, DESCRIPCION, TITULO, FECHA, USUARIO, ESTADO from HILAdO where hilo ='"&dato&"' and ESTADO = 'A' ORDER BY DESCRIPCION " 


        RS.OPEN CAD, CNN
        
		RESPONSE.Write(RS.RECORDCOUNT)
        if RS.RECORDCOUNT > 0 then%>
        
		    <% RS.MoveFirst%>
			
            <script type="text/jscript" language="jscript">
				
                top.window.thisForm.DES.value = '<%=trim(rs("dESCRIPCION"))%>';
                
		    </script>	
        <%ELSE %>
            <script type="text/jscript" language="jscript">
                top.window.thisForm.TEL.value = '';
                top.window.thisForm.DES.value = '';
		    </script>	
        <%end if%>
	FIN
</BODY>
</HTML>
