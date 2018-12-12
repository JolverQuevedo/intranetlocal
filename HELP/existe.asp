<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	DATO	= Request.QueryString("pos")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(Request.QueryString("tbl"))
	url		= Request.QueryString("url")
	errr = ""	
CAD =	" SELECT  "&pk&"			" & _
		" from "&tbl&"				" & _
		" where "&pk&" = '"&dato&"'	"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN errr = "XX" 	
	
%>
	<script>
		ss =trim('<%=errr%>') 
		if (ss=='')
		{	alert("CODIGO YA EXISTE")
			cad =  '../tablas.asp?pos=' + '<%=dato%>'
			cad += '&tbl='+ '<%=trim(right(tbl,len(tbl)-len(application("owner"))-1))%>'
			cad += '&pk='+ '<%=pk%>'
			cad += '&ds='+ '<%=ds%>'
			cad += '&col=COD'
			top.window.location.replace(cad)
		}		
	</script>
</BODY>
</HTML>
