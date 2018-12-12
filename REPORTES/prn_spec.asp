<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>


<%sp= request.QueryString("sp")
vr = request.QueryString("vr")
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

 %>
<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight ;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<body><iframe id="head" name="head" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
<iframe id="cuerpo" name="cuerpo" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
</body>
<script language="jscript" type="text/jscript">
    cad = "spec_head.asp?sp=" + "<%=sp%>" + "&vr=" + "<%=vr%>"
document.all.head.src= cad
  cad = "prn_fichamedidas.asp?sp=" + "<%=sp%>" + "&vr=" + "<%=vr%>"
document.all.cuerpo.src= cad

</script>
</html>
