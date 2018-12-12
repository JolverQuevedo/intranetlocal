<!--#include file="../includes/cnn.inc"-->
<%
  Response.Buffer = True
%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<html>
<head>
  <title></title>
</head>
<body>

 <table  border="1" align="center">
  
  <% fcli= request.QueryString("cli")
  fest = request.QueryString("cod")
  response.Write("dddddd")
  cad = "select * from estilos where cliente = '"&fCli&"' and codest= '"&fest&"' " 
      rs.open cad,cnn,2,2
      if rs.recordcount>0 then 
        rs.movefirst
         rs("estado") = "E"
         rs("USUMOD") = txtusuario
         rs("FECMOD") = date()
         rs.update
         rs.close
        set rs= Nothing
      end if  %>

    <script language="jscript" type="text/jscript">
    window.location.replace('../detaestilo.asp?pos='+'<%=fCli%>')
    </script>

  
  
  
  
  
  

</body>
</html>
