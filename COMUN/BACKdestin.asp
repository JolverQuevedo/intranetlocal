<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("pos")
	CLI		= Request.QueryString("CLI")
    PAG		= Request.QueryString("PAG")

CAD =	" SELECT top "&pag&" codigo	" & _
		" from destinos			    " & _
		" where codigo <= '"&dato&"'    " & _
        " AND CLIente = '"&CLI&"'    " & _
		" order by codigo	DESC        "
		'Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= rs.fields.item(0)	
      
	END IF    
	
%>
	<script>
	cad =  '../DETAdestin.ASP?POS=' + '<%=CC%>' + '&cli=' + '<%=cli%>'
	//alert(cad)
	window.location.replace(cad)
	</script>
</BODY>
</HTML>
