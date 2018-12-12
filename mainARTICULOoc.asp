<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Detalle de Artículo</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<%oc =  request.QueryString("oc") 
lin =  request.QueryString("lin") 
cod =  request.QueryString("cod") 
des =  request.QueryString("des") 
uni =  request.QueryString("uni") 
can =  request.QueryString("can") 
pre =  request.QueryString("pre") 
com =  request.QueryString("com") 

cad = ""
cad = cad + request.QueryString("oc")
cad = cad + "&lin="+  + request.QueryString("lin")
cad = cad + "&cod="+  + request.QueryString("cod")
cad = cad + "&des="+  + request.QueryString("des")
cad = cad + "&uni="+  + request.QueryString("uni")
cad = cad + "&can="+  + request.QueryString("can")
cad = cad + "&pre="+  + request.QueryString("pre")
cad = cad + "&com="+  + request.QueryString("com")
cad2 = "OFIlinOC.asp?oc=" + cad
cad1 = "articuloOc.asp?oc=" +cad
%>
<frameset rows="*" cols="50%,*" framespacing="0" frameborder="no" border="0">
  <frame src="<%=cad1%>" name="izquierdo" scrolling="yes" noresize="noresize" id="izquierdo" title="leftFrame" border="0" />
  <frame src="<%=cad2%>" name="derecho" id="derecho" title="mainLinea" border="0" />
</frameset>
<noframes><body>
</body></noframes>

</html>
