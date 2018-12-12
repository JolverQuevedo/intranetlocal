<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
    <link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<style>
.botonimagen{
  background-image:url('../imagenes/search.gif');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
}
</style>
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title></title>
</head>

<body>
<form name="thisForm" id="thisForm" method="post" action="">
<%
opx = request.querystring("opp")
'*********************************************************************%>
<table align="center" width="100%" bgcolor="<%=application("color2") %>">
	<tr>
		<td align= left WIDTH=10% rowspan="3">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: parent.window.close();">
		</td>
		<td align= CENTER width="85%" colspan="4">
			<font face=arial size= 2 color=DarkBlue><B>Artículos</b></font>
		</td>
        <td width="5%" align="left"><input type="button" class="botonimagen" value="&nbsp;&nbsp;&nbsp;&nbsp;" onclick="veri()"/></td>
	</tr>
    <tr><td colspan="6">&nbsp;</td></tr>
    <tr valign="middle">
    <td width="5%" align="right" class="titulito" bgcolor="<%=(Application("barra"))%>">
        CODIGO :        </td>
    <td width="5%" > 
        <input type="text" id="COD" name="COD" class="barra333" />
    </td>
    <td width="10%" bgcolor="<%=(Application("barra"))%>" class="titulito">
        DESCRIPCION :</td>
    <td bgcolor="#FFFFFF" colspan="3" WIDTH="70%"> 
        <input type="text" id="DES" name="DES"  style="width:100%"  />
    </td>
</tr>
       
</table>
</form>

<script language="jscript" type="text/jscript">
  
function veri() {
    if (trim(thisForm.COD.value) == '' && trim(thisForm.DES.value) == '') 
    {   alert("No hay nada que buscar")
        return true;
    }
    else {


        cad = 'HLPartREAL.asp?cod=' + trim(thisForm.COD.value) + '&des=' + ltrim(thisForm.DES.value) + '&opp=' + '<%=opx%>'
       // alert(cad)
        parent.window.location.replace(cad)
        
    }

 //   alert()
return true
}


//alert('<%=opx%>')

</script>
</body>
</html>
