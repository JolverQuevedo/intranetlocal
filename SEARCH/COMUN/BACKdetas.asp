<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("po")
	CLI		= Request.QueryString("CLI")
    PAG		= Request.QueryString("PAG")

CAD =	" SELECT top "&pag&" PO, CLI		" & _
		" from VIEW_POS			    " & _
		" where po <= '"&dato&"'    " & _
        " AND CLI = '"&CLI&"'    " & _
		" order by PO	DESC        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETAPOS.ASP?POS=' + '<%=CC%>' + '&PO=' + '<%=SS%>'
	//alert(cad)
	window.location.replace(cad)
	</script>
</BODY>
</HTML>
