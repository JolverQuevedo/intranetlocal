<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ORDENES DE COMPRA</title>
</head>
<frameset rows="120,*,40" cols="*" framespacing="0" frameborder="no" border="0">
  <frame src="HEADOC.ASP" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
  <frame src="detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>" name="mainFrame" id="mainFrame" title="mainFrame" />
  <frame src="bottomoc.asp" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset>
<noframes><body>
</body></noframes>
</html>
