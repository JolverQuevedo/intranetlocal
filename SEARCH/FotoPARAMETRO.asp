<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<%cliente = request.QueryString("cli")%>
<%estilo  = request.querystring("est")%>
<head>
	<title>FICHA ESTILO</title>
</head>
<body>
<table WIDTH="100%" cellpadding="2" cellspacing="1" border="1" bordecolorlight="<%=application("color2")%>" bordercolordark="<%=application("color2")%>"
bgcolor="<%=application("color2")%>" bordercolor="<%=application("color2")%>">
<tr>
	<td align= left WIDTH=10% ><img src="imagenes/cerrar.gif" style="cursor:hand;" onClick="window.close();" alt=""/></td>
	<td align= CENTER valign="middle"  bgcolor="#ffcc66" bordercolordark="<%=application("borde")%>" bordercolorlight="<%=application("borde")%>" >
        FOTO DEFAULT DE PARAMETROS
	</td>
	<TD ALIGN=right WIDTH=10% ><img src="imagenes/logo.GIF"></TD>
</TR>    
</table>
<form method="POST" enctype="multipart/form-data" action="comun/InserFOTOdefault.asp" id="formato">
	
	<table align="center" width="100%" border="1" cellpadding="1" cellspacing="1"  >
        <tr>    
            <td class="DESCRIPTORnavyBOLD" bgcolor='<%=(Application("barra"))%>' width="100%">FOTO</td> 
        </tr>
        <tr>       
            <td><input type="file" class="default" id="file" name="file" accept="image/gif, image/jpeg, image/png" value="" style= "width:100%" /></td>
        </tr>
        <tr>
            <td colspan ="7" align="center"> <input type="submit" id="manda" onclick="VERI()" value="GRABAR" /></td>
	    </tr>
	   
    </table>	
</form>
<script type="text/jscript" language="jscript">

function VERI() {
alert("entro")
if (trim(document.getElementById('file').value) != '') {    
     document.all.formato.action = 'comun/InserFOTOdefault.asp'
     alert( document.all.formato.action)
 
     document.all.formato.submit()
 }

 

</script>
</body>
</html>
