<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<%pos=request.QueryString("pos")
des = request.QueryString("des") %>
<frameset rows="101 ,*" cols="*" framespacing="0" frameborder="yes" border="0">
  <frame src="ficharayahead.asp?pos=<%=pos%>&amp;des=<%=des%>" name="topFrame" scrolling="No"id="topFrame" title="topFrame" />
  <frameset cols="*,35%" frameborder="yes" border="0" framespacing="2">
		<frame src="rayacombo.asp?pos=<%=pos%>" name="mainFrame" id="mainFrame" title="mainFrame" scrolling="yes" />
		<frameset rows="*,280" frameborder="yes" border="0" framespacing="2" >
		  <frame src="rayacol.asp?pos=<%=pos%>"  name="rightFrame" scrolling="yes"  id="rightFrame" title="rightFrame" />
		  <frame src="rayasec2.asp?pos=<%=pos%>&COM=01" name="bottomFrame" scrolling="yes" id="bottomFrame" title="bottomFrame" />
    </frameset>
  </frameset>
</frameset><noframes></noframes>
<noframes></noframes>
<body>
</body>
</html>
