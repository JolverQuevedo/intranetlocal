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

CAD =	" SELECT top "&pag&" par, tel	" & _
		" from ASIGNA_CCT			    " & _
		" where par <= '"&dato&"'       " & _
        " AND CLI = '"&CLI&"'           " & _
		" order by par	DESC            "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	    ss= trim(rs.fields.item(0)	)
        CC= rs.fields.item(1)	
	END IF    
	
%>
	<script>
	cad =  '../DETasigna.ASP?POS=' + '<%=ss%>' + '&cli=' + '<%=cli%>'
	
	window.location.replace(cad)
	</script>
</BODY>
</HTML>
