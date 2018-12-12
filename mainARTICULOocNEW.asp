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
ofi =  request.QueryString("ofi") 
lt2 =  request.QueryString("lt2") 
lt1 =  request.QueryString("lt1") 
alm =  request.QueryString("alm") 
al2 =  request.QueryString("al2")
CLA =  request.QueryString("CLA")
cad = ""
cad = cad + request.QueryString("oc")
cad = cad + "&lin="+ request.QueryString("lin")
cad = cad + "&cod="+ request.QueryString("cod")
cad = cad + "&des="+ request.QueryString("des")
cad = cad + "&uni="+ request.QueryString("uni")
cad = cad + "&can="+ request.QueryString("can")
cad = cad + "&pre="+ request.QueryString("pre")
cad = cad + "&com="+ request.QueryString("com")
cad = cad + "&ofi="+ request.QueryString("ofi")
cad = cad + "&ser="+ request.QueryString("ser")
cad = cad + "&alm="+ request.QueryString("alm")
cad = cad + "&lt2="+ request.QueryString("lt2")
cad = cad + "&lt1="+ request.QueryString("lt1")
cad = cad + "&al2="+ request.QueryString("al2")
cad = cad + "&al1="+ request.QueryString("al1")
cad = cad + "&cla="+ request.QueryString("cla")
cad = cad + "&ki1="+ request.QueryString("ki1")
cad = cad + "&ki2="+ request.QueryString("ki2")
cad = cad + "&ki3="+ request.QueryString("ki3")
cad = cad + "&ki4="+ request.QueryString("ki4")
cad = cad + "&ki5="+ request.QueryString("ki5")
cad = cad + "&ki6="+ request.QueryString("ki6")
cad = cad + "&hi1="+ request.QueryString("hi1")
cad = cad + "&hi2="+ request.QueryString("hi2")
cad = cad + "&hi3="+ request.QueryString("hi3")
cad = cad + "&hi4="+ request.QueryString("hi4")
cad = cad + "&hi5="+ request.QueryString("hi5")
cad = cad + "&hi6="+ request.QueryString("hi6")

cad2 = "OFIlinOCnew.asp?oc=" + cad + "&opp=1"
'cad2 = "blanco.htm"
cad1 = "articuloOCnew.asp?oc=" +cad
%>
<frameset rows="*" cols="60%,*" framespacing="0" frameborder="no" border="0">
  <frame src="<%=cad1%>" name="izquierdo" scrolling="YES" noresize="noresize" id="izquierdo" title="leftFrame" border="0" />
  <frame src="<%=cad2%>" name="derecho" id="derecho" title="mainLinea" border="0" />
</frameset>
<noframes><body >
</body></noframes>

</html>
