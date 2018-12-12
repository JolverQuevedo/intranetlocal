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
<table align="center" border="0">
<tr>
	<td align= left width="5%" >
		<img src="imagenes/ATRAS.gif" 
		style="cursor:hand;"
		onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=5');">
	</td>
	<td align= "center" width="90%" colspan="1">
		<font face=arial size= 3 color=DarkBlue><B>REPORTE DE MINIMOS
		</b></font>
	</td>
	<td ALIGN=right WIDTH=5% ><img src="imagenes/logo.GIF"></td>
</tr>     
<tr >
    <td colspan="3">
        <table align="center" border="0">
            <tr>
                <td class="AMERICANnavy" valign="middle" align="right">&nbsp;&nbsp;&nbsp;&nbsp;Almacen&nbsp;&nbsp;</td>
	            <td align="center" width="10%"><input id="GUI" name="GUI" value="" style="width:100%" class="datos" /></td>
                <td class="AMERICANnavy"  valign="middle" align="right">&nbsp;&nbsp;&nbsp;&nbsp;Meses&nbsp;&nbsp;</td>
                <td align="center" width="10%"><input id="MES" name="MES" value="" maxlength="1" onchange="this.value=toInt(this.value)" style="width:100%" class="datos" /></td>
                <td class="AMERICANnavy"  valign="middle" align="right"><label for="Radio2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo:&nbsp;</label></td> 
                <td align="left"  class="AMERICANnavy"><input type="Radio" name="Radio2" id="Radio1" value="P"  checked>Pantalla</td>
                <td align="left"  class="AMERICANnavy"><input type="Radio" name="Radio2" id="Radio2" value="E" >Excel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td width="30%" align="left"><input type="button" value="enviar" onclick="ENVIO()"</td>   
            </tr>
        </table>
    </td>

</tr>

</table><HR>
<SCRIPT>
function ENVIO() {
    if (document.all.Radio2[0].checked == true)
        tipo = "P"
    else 
        tipo ="E"
    if (trim(document.all.GUI.value) == '') 
    {   alert("Favor Informar el almacen")
        return false;
    }
    else 
    {   dd= trim(document.all.GUI.value)
        if (dd.length < 4) 
        {   alert("El almacen tiene 4 dígitos")
            return false;
        }
    }
    off = trim(thisForm.GUI.value)
    mm = trim(document.all.MES.value)
    if (trim(document.all.MES.value) == '') 
    {   alert("Favor Informar el NUMERO DE MESES")
        return false;
    }
    if (parseInt(mm,10) <= 0) {
        alert("El NUMERO DE MESES debe ser mayor a 0")
        return false;
    }




    cad = 'reportes/prnminimos.asp?ALM=' + off + '&xls=' + tipo + '&MES=' + document.all.MES.value
    //alert(top.window.frames.length)

 
    
top.window.frames[1].window.location.replace(cad)


//	window.frames[1].window.location.replace(cad)


}
</SCRIPT>
</BODY>
</HTML>
