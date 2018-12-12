<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	
	CLI		= Request.QueryString("CLI")
	pag		= Request.QueryString("pag")
	
	
CAD =	" SELECT top "&pag&" ofi	,CLI	" & _
		" from VIEW_ofis    	" & _
        " WHERE CLI = '"&CLI&"' " & _
		" order by ofi   desc	    "
		Response.Write(cad)
		RS.Open  CAD

	IF rs.recordcount > 0 THEN 
	    rs.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	end if
	
	'response.end
%>
	<script>
	    cad = '../explosionofisdeta.ASP?POS=' + '<%=CC%>' + '&Ofi=' + '<%=SS%>'
	    //alert(cad)
	    window.location.replace(cad)
	</script>
</body>
</html>
