<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
	pag		= Request.QueryString("pag")
	teL		= Request.QueryString("tel")

CAD =	" SELECT top "&pag&" codigo		" & _
		" from view_rayados             " & _
		" where tela = '"&tel&"'        " & _
		" order by codigo 	DESC        "
'		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN 
	    errr = "XX" 
	else 
	    rs.movelast
	    errr= rs.fields.item(0)	
	end if
	
	'response.end
%>
	<script language="javascript" type="text/jscript">
	    cad = '../rayados.asp?pos=' + '<%=errr%>' + '&tel=' + '<%=tel%>'
	    //alert(cad)
	    window.location.replace(cad)
	</script>
</body>
</html>
