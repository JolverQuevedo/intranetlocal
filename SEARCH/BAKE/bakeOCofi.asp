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
op = Request.QueryString("op")
CAD =	"Select * From view_ofis Where ofi='"&pos&"'" 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then
            if len(trim(pos)) > 0 then
                rs.close
                rs.open "select top 1 codigo from ofis order by 1 desc"
                if rs.recordcount >0 then 
                    if cdbl(pos) < cdbl(rs("codigo")) then
                    ' colocar la validacion ok y decir que es antigua...
                    ' si es mayor que el el ultimo # de ofi NUEVA --> HORROR!!! 
                    ' sino colocar OFI_old
                    %>
                    <script type="text/jscript" language="jscript">
                        op = parseInt('<%=op%>', 10)
                        eval("window.parent.thisForm.OFI" + op + ".value = '<%=POS%>'");
                        eval("window.parent.thisForm.CLI" + op + ".value = 'OFI_OLD'");
                    </script>
                    <%ELSE%>
                        <script type="text/jscript" language="jscript">
                            alert("OFI INVALIDA")
                            op = parseInt('<%=op%>', 10)
                            eval("window.parent.thisForm.OFI" + op + ".value = ''");
                            eval("window.parent.thisForm.CLI" + op + ".value = ''");
                        </script>
                    <%end if
                end if
            end if %>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                op = parseInt('<%=op%>',10)
                eval("window.parent.thisForm.OFI"+op+".value = '<%=trim(rs("ofi"))%>'");
                eval("window.parent.thisForm.CLI"+op+".value = '<%=trim(rs("NOM"))%>'");
			</script>	
        <%end if%>	
</BODY>
</HTML>
