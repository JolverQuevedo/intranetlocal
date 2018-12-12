<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("pos")
    DATO2	= Request.QueryString("pos2")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= TRIM(application("owner"))+"."+trim(Request.QueryString("tbl"))
	url		= Request.QueryString("url")
	ppp     = Request.QueryString("size")
	errr = ""	
CAD =	" SELECT top "&ppp&" "&pk&"		" & _
		" from "&tbl&"			        " & _
		" where "&pk&" <= '"&dato&"'    " 
		IF TRIM(ds) <> "" THEN
            CAD = CAD + " and "&ds&" = '"&DATO2&"'  "
        end if	
cad = cad +	" order by "&pk&" 	DESC	        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN 
	    errr = "XX" 
	else 
	    RS.MOVELAST
	    errr= rs.fields.item(0)	
	END IF    
	
%>
	<script language="javascript" type="text/jscript">
		ss =trim('<%=errr%>') 
		if (ss!='XX')
		{	cad = '../'+ '<%=URL%>' 
			cad += '&pos='+ ss
			document.write(cad)
			window.parent.location.replace(cad)
		}		
	</script>
</BODY>
</HTML>
