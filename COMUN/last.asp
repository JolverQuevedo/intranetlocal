<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(Request.QueryString("alias"))
	url		= Request.QueryString("url")
	errr = ""	
	tt = len(trim(application("owner")))
    tt = tt+1
    tabla = tbl
CAD =	" SELECT top 1 "&pk&"		" & _
		" from "&tbl&"				" & _
		" order by "&pk&" desc		"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN errr = "XX" else errr= rs.fields.item(0)	
	
%>
	<script language="javascript" type="text/jscript">
		ss =trim('<%=errr%>') 
		if (ss!='XX')
		{	//alert("CODIGO YA EXISTE")
			cad =  '../usuarios.asp?pos=' + ss
			cad += '&tbl='+ '<%=tabla%>'
			cad += '&col=COD'
			top.window.location.replace(cad)
		}		
	</script>
</body>
</html>
