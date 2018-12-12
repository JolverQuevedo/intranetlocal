<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2058%>
<% tienda = Request.Cookies("tienda")("pos") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>


<frameset rows="125,*" frameborder="YES" border="0" framespacing="0" >
  <frame src="JUANITOHEAD.asp" name="topFrame" scrolling="no"  id="topFrame" title="topFrame"  />
  <frame src="..\BLANCO.HTM" name="mainFrame" id="mainFrame" title="mainFrame" />
</frameset>
<noframes>
<body>
    </body>
</noframes>
</html>
