<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2057%>
<%	usr = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
oc  = Request.QueryString("oc")
pe  = Request.QueryString("pe")
alm = Request.QueryString("alm")
itm = Request.QueryString("itm")
qty = Request.QueryString("qty")
pwd = Request.QueryString("pwd")
fec =  "{ fn NOW() }"
CAD =	" Select *                  " & _
        " From modelador..clavepe   " & _
        " Where numord='"&oc&"'     " & _
        " And alm='"&alm&"'         " & _
        " and pe = '"&pe&"'         " & _
        " and item = '"&itm&"'      " & _
        " and clave = '"&pwd&"'     " & _
        " and qty  = '"&qty&"'      "
		RS.OPEN CAD, CNN
		
		if RS.RECORDCOUNT > 0 then 
            RS.MoveFirst   
            ppp = rs("clave")
        %>
			<script type="text/jscript" language="jscript">
			  parent.window.document.all.PWD.value = '<%=ppp%>'
            //    alert("Clave Generada " + '<%=pwd%>')  
            </script>
		<%else%>
		
            <script type="text/jscript" language="jscript">
                alert("Clave errada")
                parent.window.document.all.PWD.value= 'NO'
			</script>	
        <%end if%>
		
</BODY>
</HTML>
