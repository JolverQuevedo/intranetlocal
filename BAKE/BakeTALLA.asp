<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Session.LCID = 2058 'Mexico (comas y punto) %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%
    tal = trim(request.QueryString("tal"))
    op = trim(request.QueryString("op"))
	cad = " select talla from modelador..tallas where talla = '" & tal & " ' "
    Response.WRITE(CAD)
    Response.WRITE("<br>")
    Response.WRITE(op)
	RS.Open CAD,CNN
	if rs.RecordCount <= 0 then%>
    	<script type="text/jscript" language="jscript">
    	    alert("Código de Talla NO existe ")
            op = '<%=op%>'
            eval("window.parent.thisForm.t" + op + ".value = ''")
            eval("window.parent.thisForm.t" + op + ".focus()")
	    </script>		
	<%end if 
	rs.Close%>
