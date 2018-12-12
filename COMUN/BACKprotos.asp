<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	pro 	= Request.QueryString("pro")
	CLI		= Request.QueryString("CLI")
    ver		= Request.QueryString("ver")
    DATO    = PRO&VER
    RESPONSE.WRITE(DATO)
CAD =	" SELECT top 16 pro, ver	    " & _
		" from VIEW_PROTOS			    " & _
		" where PRO+VER <= '"&dato&"'   " & _
        " AND CLI = '"&CLI&"'           " & _
		" order by PRO + VER DESC       "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETAPROTO.ASP?POS=' + '<%=CLI%>' + '&PRO=' + '<%=SS%>' + '&VER='+ '<%=cc%>'
	//alert(cad)
	window.parent.location.replace(cad)
	</script>
</BODY>
</HTML>
