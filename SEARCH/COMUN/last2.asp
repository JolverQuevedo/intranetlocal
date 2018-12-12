<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
    DATO2	= Request.QueryString("pos2")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(application("owner"))+"."+trim(Request.QueryString("tbl"))
	url		= Request.QueryString("url")
	errr = ""	
    CAD =	" SELECT top 1 "&pk&"		" & _
		    " from "&tbl&"				" 
	IF TRIM(ds) <> "" THEN
        CAD = CAD + " where "&ds&" = '"&DATO2&"'  "
    end if		 	
CAD = CAD + " order by "&pk&" desc		"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN errr = "XX" else errr= rs.fields.item(0)	
	Response.Write(errr)
	
%>
	<script language="javascript" type="text/jscript">
		ss =trim('<%=errr%>') 
		if (ss!='XX')
		{	cad =  '<%=URL%>' 
			cad += '&pos='+ ss
			//alert(cad)
			window.parent.location.replace(cad)
		}		
	</script>
</body>
</html>
