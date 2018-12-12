<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("pos")
    tel		= Request.QueryString("tel")
	pag     = Request.QueryString("PAG")
	
CAD =	" SELECT top "&pag&" codigo		" & _
		" from view_rayados             " & _
		" where codigo <= '"&dato&"'    " & _
        " and tela = '"&tel&"'          " & _
		" order by codigo 	DESC        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN 
	    window.history.back()
	else 
	    RS.movelast
	    ss= rs.fields.item(0)	
	END IF    
	
%>
	<script>
	cad =  '../rayados.asp?pos=' + '<%=ss%>' + '&tel='+'<%=tel%>'
	//alert(cad)
	window.location.replace(cad)
	</script>
</BODY>
</HTML>
