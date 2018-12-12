<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
DATO	= Request.QueryString("pos")

CAD =	" SELECT tela AS COD,		        " & _
		" DESCRIPCION, ENCABI1 as EAL1,     " & _
		" ENCLAR1 as ELL1, REVIRADO as      " & _
		" REV, PESOACA as DDL, ANCHTUB as   " & _
		" AT, ANCHABI as AA                 " & _
		" FROM TELAS	    			    " & _
        " where tela =  '"& dato &"' " 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT > 0 then%>
		    <%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                top.window.thisForm.DES.value = '<%=trim(rs("dESCRIPCION"))%>';
                top.window.thisForm.ELL1.value = '<%=trim(rs("EAL1"))%>';
                top.window.thisForm.EAL1.value = '<%=trim(rs("ELL1"))%>';
                top.window.thisForm.REV.value = '<%=trim(rs("rev"))%>';
                top.window.thisForm.DDL.value = '<%=trim(rs("ddl"))%>';
                top.window.thisForm.AT.value = '<%=trim(rs("at"))%>';
                top.window.thisForm.AA.value = '<%=trim(rs("aa"))%>';
                
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
