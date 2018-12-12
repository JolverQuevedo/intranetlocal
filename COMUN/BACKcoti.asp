<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	cot 	= Request.QueryString("cot")
	CLI		= Request.QueryString("CLI")
    pag = request.QueryString("pag")

CAD =	" SELECT top "&pag&" pro, ver	    " & _
		" from VIEW_cotizacion			    " & _
		" where pro<= '"&cot&"'          " & _
        " AND CLI = '"&CLI&"'               " & _
		" order by  pro+ver DESC            "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETAcoti.ASP?POS=' + '<%=CLI%>' + '&cot=' + '<%=ss%>' 
	//alert(cad)
	window.parent.location.replace(cad)
	</script>
</BODY>
</HTML>
