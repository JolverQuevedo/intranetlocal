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
	
	
CAD =	" SELECT top "&pag&" par,CLI	" & _
		" from asigna_cct    	" & _
        " WHERE CLI = '"&CLI&"' " & _
		" order by par   desc	    "
	'	Response.Write(cad)
		RS.Open  CAD

	IF rs.recordcount > 0 THEN 
	    rs.movelast
	    ss= trim(rs.fields.item(0))
        CC= trim(rs.fields.item(1))
	end if
	
	'response.end
%>
	<script>
	    cad = '../DETAsigna.ASP?POS=' + '<%=ss%>' + '&cli=' + '<%=cc%>'
	  //  alert(cad)
	    window.location.replace(cad)
	</script>
</body>
</html>
