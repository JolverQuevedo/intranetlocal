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
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form name="thisForm" METHOD="post"  >
<table width=100%>
<tr>
	<td align= left WIDTH=35% ROWSPAN=2>
		<img src="imagenes/ATRAS.gif" 
		style="cursor:hand;"
		onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=4');">
	</td>
	<td align= CENTER>
		<font face=arial size= 3 color=DarkBlue><B>CONSUMOS POR CLIENTE
		</b></font>
	</td>
	<TD ALIGN=right WIDTH=35% ROWSPAN=2><img src="imagenes/logo.GIF"></TD>
</TR>    
<%' recibe tabla, primary key, y descripcion
tbl = "modelador..cliente"
DS = "NOMBRE"

cad =	"select * from "&TBL&" WHERE ESTADO = 'A' order by "&DS&" "
rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
<table align="center" border="0" >
<tr>
    <td>Cliente</td>
	<td ALIGN="center">	
		<select id="CLI" name="CLI" class="Data" onclick="cambia()">
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("codigo"))%>'><%=trim(rs("nombre"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</TD>
    <td>Temporada</td>
    <td ALIGN="center">	
		<select id="TEM" name="TEM" class="Data" onchange="cambia2()">
			<option value=''></option>
		</select>
	</td>
    <td>Estilo</td>
    <td ALIGN="center">	
		<select id="EST" name="EST" class="Data" >
        		<option value=''></option>
		</select>
	</td>
    <td><input type="button" value="Mostrar" onclick="ENVIO()"/></td>
</tr>
</table>

<iframe  width="100%" src="BLANCO.HTM" id="body10" name="body10" scrolling="yes" frameborder="0" height="250" width="100%" align="middle" style="display:block"></iframe>
<hr>
<%rs.close
set rs = nothing
set cnn=nothing%>
<SCRIPT>
function ENVIO() {
    cad = 'DETAacatemp.asp?pos=' + trim(thisForm.CLI.value) + '&tem=' + ltrim(document.all.TEM.value)
    //alert(parent.window.frames.item(1).name)
    parent.window.frames.item(1).window.location.replace(cad)
}
function cambia() {

    document.all.body10.src = "BAKE/BAKEtemporada.asp?cli=" + trim(document.all.CLI.value) + '&sele=TEM';


}
function cambia2() {
//alert(trim(document.all.TEM.value))
    document.all.body10.src = "BAKE/BAKEtemporadaESTILO.asp?cli=" + trim(document.all.CLI.value) + '&sele=EST'+'&tem='+trim(document.all.TEM.value);
}


</SCRIPT>
</BODY>
</HTML>
