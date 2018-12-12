<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Session.LCID = 2058 'Mexico (comas y punto) %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<%pas = (request.QueryString("pas"))
op = (request.QueryString("pas"))
COL = Trim(COL)
	strSql = " select alto from altopasada where pasada = '"& pas &"' "
	rs.Open strSql,cnn,3,1
	if rs.recordcount > 0 and isnull(rs("alto")) = false then%>
		<SCRIPT>
            op = '<%=trim(op)%>'
            eval("window.opener.window.document.all.ALT"+op+".value=xx")
		</SCRIPT>
	<%else%>
		<script language="jscript" type="text/jscript">
            alert("No puede ingresar combinaciones hasta que haya registrado la secuencia de colores y alturas...")
        </script>
        <% response.end()		
	end if 
	rs.Close	
	
%>
