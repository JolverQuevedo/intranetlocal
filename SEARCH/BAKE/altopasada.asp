<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Session.LCID = 2058 'Mexico (comas y punto) %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<%hlp = (request.QueryString("hlp"))
pas = (request.QueryString("pas"))
pos = (request.QueryString("pos"))
alt = (request.QueryString("alt"))


	strSql = " select alto, pasada from altopasada where pasada = '"& pas &"' "
	rs.Open strSql,cnn,3,1
	if rs.recordcount > 0 then
        rs.movefirst%>
		<SCRIPT>
		    pos = parseInt(trim('<%=trim(pos)%>'), 10)
            xx = parseFloat('<%=rs("alto") %>')
            eval("window.parent.window.document.all.ALT"+pos+".value=xx")
		</SCRIPT>
    <%else
        if cint(hlp) = 2 then
            cad = "insert into altopasada (alto, pasada, usuario) values ("&alt&", "&pas&", 'AUTO')"
            cnn.execute cad	
        end if 
	    rs.Close	
    end if%>
