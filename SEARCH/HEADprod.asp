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
<link rel="stylesheet" type="text/css" href="estilos1.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form name="thisForm" METHOD="post"  >
<table WIDTH=100%>
<tr>
	<td align= left WIDTH=35% ROWSPAN=2>
		<img src="imagenes/ATRAS.gif" 
		style="cursor:hand;"
		onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=12');">
	</td>
	<td align= CENTER>
		<font face=arial size= 3 color=DarkBlue><B>Reportes de Produccion anual
		</b></font>
	</td>
	<TD ALIGN=right WIDTH=35% ROWSPAN=2><img src="imagenes/logo.GIF"></TD>
</TR>    

<TR>
	<TD ALIGN=CENTER>	
		<SELECT ID=ANO NAME=ANO CLASS=DATOSGRANDE ONCHANGE="ENVIO()">
			<option value=''></option>
            <%for x = year(date())-5 to year(date())+10 %>
			<option value='<%=x %>'><%=x%></option>
            <%next %>
		</SELECT>
	</TD>
</TR>
<TR><td COLSPAN=3><HR></td></TR>
</table>
<SCRIPT>
function ENVIO()
{	cad = 'reportes/prnprod_real.asp?anio='+trim(thisForm.ANO.value)
	//alert(cad)
	top.window.frames.item(1).window.location.replace(cad)
}
</SCRIPT>
</BODY>
</HTML>
