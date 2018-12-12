<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	DATO	= Request.QueryString("pos")
    msg	    = Request.QueryString("msg")
	pk		= Request.QueryString("pk")
	tbL		= trim(application("owner"))+"."+trim(Request.QueryString("tbl"))
	p0		= trim(Request.QueryString("p0"))
	p1		= trim(Request.QueryString("p1"))
	p2		= trim(Request.QueryString("p2"))
	p3		= trim(Request.QueryString("p3"))
	p4		= trim(Request.QueryString("p4"))
	p5		= trim(Request.QueryString("p5"))
	p6		= trim(Request.QueryString("p6"))
	p7		= trim(Request.QueryString("p7"))
	p8		= trim(Request.QueryString("p8"))
	p9		= trim(Request.QueryString("p9"))
	c0		= trim(Request.QueryString("c0"))
	c1		= trim(Request.QueryString("c1"))
	c2		= trim(Request.QueryString("c2"))
	c3		= trim(Request.QueryString("c3"))
	c4		= trim(Request.QueryString("c4"))
	c5		= trim(Request.QueryString("c5"))
	c6		= trim(Request.QueryString("c6"))
	c7		= trim(Request.QueryString("c7"))
	c8		= trim(Request.QueryString("c8"))
	c9		= trim(Request.QueryString("c9"))
	url		= Request.QueryString("url")
	errr = ""	
		
CAD =	" SELECT  "&pk&"			" & _
		" from "&tbl&"				" & _
		" where "&c0&" = '"&p0&"'	" & _
		" and   "&c1&" = '"&p1&"'	" & _
		" and   "&c2&" = '"&p2&"'	" & _
		" and   "&c3&" = '"&p3&"'	" & _
		" and   "&c4&" = '"&p4&"'	" & _
		" and   "&c5&" = '"&p5&"'	" & _
		" and   "&c6&" = '"&p6&"'	" & _
		" and   "&c7&" = '"&p7&"'	" & _
		" and   "&c8&" = '"&p8&"'	" & _
		" and   "&c9&" = '"&p9&"'	" 

		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    errr=rs.fields.item(0)
	    if trim(dato) <> trim(errr) then errr = "xx"
	end if    
%>
	<script>
		ss =trim('<%=errr%>') 
		vv = trim('<%=msg%>') 
		if (ss=='xx')
		{	alert(vv)
			cad = '../' + '<%=trim(url)%>' + '&pos=' + '<%=dato%>'
			window.parent.location.replace(cad)
		}	
	</script>
</BODY>
</HTML>
