<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%pos = request.QueryString("pos")
op = request.QueryString("op")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" EXEC BAKEAVIOS '"&POS&"' "

	RS.Open CAD, Cnn
	CONT = 1
	IF rs.recordcount > 0 THEN
    response.write("<br>")
    response.write(cad)
    response.write("<br>")
    response.write(cint(op))
    %>
<script>
    op = parseInt('<%=cint(op)%>',10)
    eval("parent.window.document.all.thisForm.AVI"+op+".value = '<%=trim(rs("COD")) %>'");
    eval("parent.window.document.all.thisForm.DES"+op+".value = '<%=ucase(rs("DES"))%>' ");
    eval("parent.window.document.all.thisForm.UNI"+op+".value =  '<%=ucase(rs("UNI"))%>'");
    eval("parent.window.document.all.thisForm.EXX"+op+".value = '<%=ucase(rs("CODEXP"))%>'");
    eval("parent.window.document.all.thisForm.DEX"+op+".value = '<%=ucase(rs("DEXPLOSION"))%>'");
    eval("parent.window.document.all.thisForm.TPP"+op+".value = '<%=ucase(rs("AREA"))%>'");
    eval("parent.window.document.all.thisForm.DTP"+op+".value = '<%=ucase(rs("Darea"))%>'");
    eval("parent.window.document.all.thisForm.MRR"+op+".value = '<%=ucase(rs("PORMER"))%>'");
   
</script>
<%else%>
<script language="jscript" type="text/jscript">
    alert("Artículo digitado no existe")
    op = parseInt('<%=cint(op)%>', 10)
    eval("parent.window.document.all.thisForm.AVI"+op+".value = ''");
    eval("parent.window.document.all.thisForm.DES"+op+".value = ''");
    eval("parent.window.document.all.thisForm.UNI"+op+".value = ''");
    eval("parent.window.document.all.thisForm.EXX"+op+".value = ''");
    eval("parent.window.document.all.thisForm.DEX"+op+".value = ''");
    eval("parent.window.document.all.thisForm.TPP"+op+".value = ''");
    eval("parent.window.document.all.thisForm.DTP"+op+".value = ''");
    eval("parent.window.document.all.thisForm.MRR"+op+".value = ''");
</script>
<%end if %>

</HTML>