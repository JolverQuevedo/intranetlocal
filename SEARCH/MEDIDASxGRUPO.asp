<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<%
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
spe = REQUEST.cookies("spe")
ver = REQUEST.cookies("ver")
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")
CAB = "CABECERA.ASP?CLI="   +CLI +"&TEM=" + TEM + "&EST=" + EST + "&spe=" + spe + "&med=" + med + "&MMD=" + MMD
LEF = "LEFTGRUPO.ASP?CLI="  +CLI +"&TEM=" + TEM + "&EST=" + EST + "&spe=" + spe + "&med=" + med + "&MMD=" + MMD
RIG = "RIGHTMEDIDA.ASP?CLI="+CLI +"&TEM=" + TEM + "&EST=" + EST + "&spe=" + spe + "&med=" + med + "&MMD=" + MMD
%>
<frameset rows="1,*" cols="*" frameborder="no" border="1" framespacing="0">
  <frame src="<%=CAB%>" name="cabeza" scrolling="no" noresize="noresize" id="cabeza" title="cabeza" />
  <frameset rows="*" cols="50%,*" framespacing="0" frameborder="yes" border="1">
    <frame src="<%=LEF%>" name="leftFrame" scrolling="yes" noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="<%=RIG%>" name="rightFrame" id="rightFrame" title="rightFrame" />
  </frameset>
</frameset>


<noframes><body>
</body></noframes>
</html>
