<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("ofi")
	CLI		= Request.QueryString("CLI")
    PAG		= Request.QueryString("PAG")

CAD =	" SELECT top "&pag&" OFI, CLI	" & _
		" from VIEW_OFIS			    " & _
		" where OFI <= '"&dato&"'       " & _
        " AND CLI = '"&CLI&"'           " & _
		" order by OFI	DESC            "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETAOFI.ASP?POS=' + '<%=CC%>' + '&OFI=' + '<%=SS%>'
	//alert(cad)
	window.location.replace(cad)
	</script>
</BODY>
</HTML>
