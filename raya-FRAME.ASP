<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LISTADOS</title>
</head>
<frameset rows="101 ,*" cols="*" framespacing="2" frameborder="yes" border="1" >
  <frame src="rayahead.asp?HLP=0&POS=<%=REQUEST.QUERYSTRING("COD")%>" name="topFrame" scrolling="No" id="topFrame" title="topFrame" />
  <frameset cols="*,35%" frameborder="yes" border="1" framespacing="2" >
		<frame src="rayados.asp?tel=<%=REQUEST.QUERYSTRING("COD")%>" name="mainFrame" id="mainFrame" title="mainFrame" scrolling="YES" />
		<frame src="rayasec.asp?TEL=<%=REQUEST.QUERYSTRING("COD")%>" name="rightFrame" scrolling="YES"  id="rightFrame" title="rightFrame" />
	</frameset>
</frameset>
<noframes><body>
</body></noframes>
</html>
