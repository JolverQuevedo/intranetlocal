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
    .style2
    {
        width: 268435776px;
    }
</style>
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title></title>
</head>

<body onload="document.all.ANO.focus()">
<form name="thisForm" id="thisForm" method="post" action="" onsubmit="veri()">
<%'*********************************************************************%>
<table align="center" width="100%" bgcolor="<%=application("color2") %>">
	<tr>
		<td align= left WIDTH=10% rowspan="3">
			<img src="../imagenes/ATRAS.gif" style="cursor:hand;" 
			onclick="javascript: top.window.location.replace('../SUBMENU.ASP?TIPO=12');">
		<td align= CENTER colspan="6">
			<font face=arial size= 2 color=DarkBlue><B>BUSQUEDA POR GLOSA DE MOVIMIENTOS ALMACEN</b></font>
		</td>
        <td width="8%" align="right"><input type="submit" class="botonimagen" value="&nbsp;&nbsp;&nbsp;&nbsp;" onClick="return veri()"/></td>
	</tr>
    <tr><td colspan="8">&nbsp;</td></tr>

    <tr valign="middle">
    <td align="right" class="titulito" bgcolor="<%=(Application("barra"))%>">A&Ntilde;O :</td>
    <td  width="40px" ><input type="text" id="ANO" name="ANO" onkeyup="this.value = toInt(this.value)" class="barra333" style="width:100%; vertical-align:middle" maxlenght="4"/>
    </td>
    <td bgcolor="<%=(Application("barra"))%>" class="titulito" style="vertical-align:middle">
        Criterio 1 :</td>
    <td bgcolor="#FFFFFF"  width="100px"> 
        <input type="text" id="D1" name="D1"  style="width:100%" />
    </td>
    <td bgcolor="<%=(Application("barra"))%>" class="titulito" style="vertical-align:middle">
        Criterio 2 :</td>
    <td bgcolor="#FFFFFF"  width="100px"> 
        <input type="text" id="D2" name="D2"  style="width:100%"  />
    </td>
    <td bgcolor="<%=(Application("barra"))%>" class="titulito" style="vertical-align:middle">
        Criterio 3 :</td>
    <td bgcolor="#FFFFFF"  width="100px" > 
        <input type="text" id="D3" name="D3"  style="width:100%" />
    </td>
</tr>
       
</table>
</form>

<script language="jscript" type="text/jscript">
function veri() {

    if (trim(thisForm.ANO.value) == '' ) {
        alert("Favor de Informar el año")
        thisForm.ANO.focus()
        return false;
    }
    aa = trim(thisForm.ANO.value) 
    if (aa.length < 4 ) {
        alert("Favor de Informar el año con 4 dígitos")
        thisForm.ANO.value = ''
        thisForm.ANO.focus()
        return false;
    }
    if (trim(thisForm.D1.value) == '') {
        alert("Favor de Informar por lo menos un criterio de Búsqueda")
        thisForm.D1.focus()
        return false;
    }

    cad = 'BUSCAGLOSAPO.asp?ANO=' + trim(thisForm.ANO.value) + '&d1=' + ltrim(thisForm.D1.value)
    cad += '&d2=' + ltrim(thisForm.D2.value)
    cad += '&d3=' + ltrim(thisForm.D3.value)
    parent.window.location.replace(cad)

}
</script>
</body>
</html>
