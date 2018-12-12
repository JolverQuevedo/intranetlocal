<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%pos = request.QueryString("pos")
op = request.QueryString("op")
CAD =	" SELECT TELA, DESCRIPCION, GG,PA, 	                            " & _
		" RT = cast(RT as numeric(6,2)), RA = cast(RA as numeric(6,2)), " & _
        " AT= cast(aa as numeric(6,2)),AA= cast(aa as numeric(6,2))     " & _
        "  from VIEW_TELAS  WHERE ESTADO = 'A' AND TELA = '"&POS&"'    	"
		
		response.Write(cad)
	RS.Open CAD, Cnn
    conta = rs.recordcount
    if rs.recordcount > 0 then%>
<script>
    op = parseInt('<%=cint(op)%>',10)
    eval("parent.window.document.all.thisForm.TEL"+op+".value = '<%=trim(rs("TELa"))%>'");
    eval("parent.window.document.all.thisForm.DTE"+op+".value = '<%=ucase(rs("DESCRIPCION"))%>'");
    eval("parent.window.document.all.thisForm.RUT"+op+".value = ''");
    eval("parent.window.document.all.thisForm.COM"+op+".value = ''");
    eval("parent.window.document.all.thisForm.LAR"+op+".value = ''");
    A1 = parseFloat('<%=formatnumber(rs("aT"),2,,true) %>')
    A2 = parseFloat('<%=cdbl(rs("aa")) %>')
    if (A1 > 0)
        eval("parent.window.document.all.thisForm.ANC"+op+".value = '<%=formatnumber(rs("aT"),2,,true) %>'");
    else
        eval("parent.window.document.all.thisForm.ANC"+op+".value = '<%=formatnumber(rs("aa"),2,,true) %>'");
    eval("parent.window.document.all.thisForm.PM2"+op+".value = '<%=rs("pa") %>'");
    eval("parent.window.document.all.thisForm.TIP"+op+".value = ''");
    eval("parent.window.document.all.thisForm.PZA"+op+".value = ''");
    eval("parent.window.document.all.thisForm.FAC"+op+".value = ''");
    eval("parent.window.document.all.thisForm.CUN"+op+".value = ''");
    eval("parent.window.document.all.thisForm.MER"+op+".value = ''");
    eval("parent.window.document.all.thisForm.TOT"+op+".value = ''");
</script>
<%else%>
<script language="jscript" type="text/jscript">
    alert("Artículo digitado no existe")
    op = parseInt('<%=cint(op)%>', 10)
    eval("parent.window.document.all.thisForm.TEL"+op+".value=''");
    eval("parent.window.document.all.thisForm.DTE"+op+".value=''");
    eval("parent.window.document.all.thisForm.RUT"+op+".value=''");
    eval("parent.window.document.all.thisForm.COM"+op+".value=''");
    eval("parent.window.document.all.thisForm.LAR"+op+".value=''");
    eval("parent.window.document.all.thisForm.ANC"+op+".value=''");
    eval("parent.window.document.all.thisForm.PM2"+op+".value=''");
    eval("parent.window.document.all.thisForm.TIP"+op+".value=''");
    eval("parent.window.document.all.thisForm.PZA"+op+".value=''");
    eval("parent.window.document.all.thisForm.FAC"+op+".value=''");
    eval("parent.window.document.all.thisForm.CUN"+op+".value=''");
    eval("parent.window.document.all.thisForm.MER"+op+".value=''");
    eval("parent.window.document.all.thisForm.TOT"+op+".value=''");
</script>
<%end if %>
</HTML>