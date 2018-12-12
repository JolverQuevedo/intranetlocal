<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	pos = request.QueryString("pos")
CAD =	" SELECT TELA, DESCRIPCION, GG,PA, 	" & _
		" RT = cast(RT as numeric(6,2)), RA = cast(RA as numeric(6,2)), " & _
        " AT= cast(aa as numeric(6,2)),AA= cast(aa as numeric(6,2))" & _
        "  from VIEW_TELAS  	" & _
		" WHERE ESTADO = 'A'     		    " & _ 
		" AND TELA = '"&POS&"'    	    "
		
		response.Write(cad)
	RS.Open CAD, Cnn
    conta = rs.recordcount
    if rs.recordcount > 0 then
%>
<script>
    parent.window.document.all.thisForm.TELA.value = '<%=rs("TELa") %>';
    parent.window.document.all.thisForm.DTEL.value = '<%=ucase(rs("DESCRIPCION"))%>';
    parent.window.document.all.thisForm.GG.value = '<%=rs("GG") %>';
    parent.window.document.all.thisForm.PA.value = '<%=rs("pa") %>';
    parent.window.document.all.thisForm.RT.value = '<%=rs("rt") %>';
    parent.window.document.all.thisForm.RA.value = '<%=rs("rA") %>';
    parent.window.document.all.thisForm.AT.value = '<%=rs("aT") %>';
    parent.window.document.all.thisForm.AA.value = '<%=rs("AA") %>';
    parent.window.document.all.thisForm.TEL0.value = '<%=rs("TELa") %>';
    parent.window.document.all.thisForm.DTE0.value = '<%=ucase(rs("DESCRIPCION"))%>';
    parent.window.document.all.thisForm.RUT0.value = '';
    parent.window.document.all.thisForm.COM0.value = '';
    parent.window.document.all.thisForm.LAR0.value = '';
    A1 = parseFloat('<%=formatnumber(rs("aT"),2,,true) %>')
    A2 = parseFloat('<%=cdbl(rs("aa")) %>')
    if (A1 > 0)
        parent.window.document.all.thisForm.ANC0.value = '<%=formatnumber(rs("aT"),2,,true) %>';
    else
        parent.window.document.all.thisForm.ANC0.value = '<%=formatnumber(rs("aa"),2,,true) %>';
    parent.window.document.all.thisForm.PM20.value = '<%=rs("pa") %>';
    parent.window.document.all.thisForm.TIP0.value = '';
    parent.window.document.all.thisForm.PZA0.value = '';
    parent.window.document.all.thisForm.FAC0.value = '';
    parent.window.document.all.thisForm.CUN0.value = '';
    parent.window.document.all.thisForm.MER0.value = '';
    parent.window.document.all.thisForm.TOT0.value = '';
</script>
<%else%>
<script language="jscript" type="text/jscript">
    alert("Artículo digitado no existe")
    parent.window.document.all.thisForm.TELA.value = '';
    parent.window.document.all.thisForm.DTEL.value = '';
    parent.window.document.all.thisForm.GG.value = '';
    parent.window.document.all.thisForm.PA.value = '';
    parent.window.document.all.thisForm.RT.value = '';
    parent.window.document.all.thisForm.RA.value = '';
    parent.window.document.all.thisForm.AT.value = '';
    parent.window.document.all.thisForm.AA.value = '';

    parent.window.document.all.thisForm.TEL0.value = '';
    parent.window.document.all.thisForm.DTE0.value = '';
    parent.window.document.all.thisForm.RUT0.value = '';
    parent.window.document.all.thisForm.COM0.value = '';
    parent.window.document.all.thisForm.LAR0.value = '';
    parent.window.document.all.thisForm.ANC0.value = '';
    parent.window.document.all.thisForm.PM20.value = '';
    parent.window.document.all.thisForm.TIP0.value = '';
    parent.window.document.all.thisForm.PZA0.value = '';
    parent.window.document.all.thisForm.FAC0.value = '';
    parent.window.document.all.thisForm.CUN0.value = '';
    parent.window.document.all.thisForm.MER0.value = '';
    parent.window.document.all.thisForm.TOT0.value = '';
</script>
<%end if %>
</HTML>