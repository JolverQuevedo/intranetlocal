<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	aju 	= Request.QueryString("aju")
	CLI		= Request.QueryString("CLI")
    ver		= Request.QueryString("ver")
    DATO    = aju&VER
    RESPONSE.WRITE(DATO)
CAD =	" SELECT top 16 aju, ver	    " & _
		" from VIEW_ajusteS			    " & _
		" where aju+VER <= '"&dato&"'   " & _
        " AND CLI = '"&CLI&"'           " & _
		" order by aju + VER DESC       "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETAajuste.ASP?POS=' + '<%=CLI%>' + '&aju=' + '<%=SS%>' + '&VER='+ '<%=cc%>'
	//alert(cad)
	window.parent.location.replace(cad)
	</script>
</BODY>
</HTML>
