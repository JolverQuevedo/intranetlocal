<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body onload="javascript:document.all.EST.focus()">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<table width="100%">
	<tr>
		<td align= "left" width="15%">
			<img src="imagenes/ATRAS.gif" 
			style="cursor:hand;" alt=""
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=12');" />
		</td>
		<td align="center">
		<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center"
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b>
			BORRA ESTILOS DEL DBPROD
			</b></font></td>
		    </tr>
		</table>
			
		</td>
		<td align="right" width="15%">
		  	<img src="imagenes/logo.GIF" alt="" />
		  </td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>


<table border="0" id="DATAENTRY" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" width="50%">
     <tr>            
	
        <td bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy" width="20%">CODIGO DE ESTILO :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="80%"><input type="text" id="EST" name="EST" maxlength="20" class="datos" size="100"/></td>
    </tr>
  
    <tr bgcolor="<%=application("color2") %>" align="center">
        <td colspan="6"><img src="imagenes/DISK.gif"   alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:pointer;" /></td>		               
    </tr>
</table>
<script language="jscript" type="text/jscript">

function GRABAR_onclick() {
    if (ltrim(rtrim(document.all.EST.value)) == '') {
        alert("Favor informar el código de del Estilo")
        document.all.EST.focus()
        return true;
    }
  
    cad = 'comun/del_est.asp?est=' + ltrim(rtrim(document.all.EST.value))
   
    var si
    { si = confirm("¿ Confirma la ELIMINACION de este Estilo ? "); }
    if (si == false)
    { return false; }


    window.location.replace(cad)
}

</script>
</body>
</html>
