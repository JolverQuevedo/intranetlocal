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
<body>
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
			ARREGLA CANTIDADES DE PARTES DEL REAL SOFT
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


<table border="0" id="DATAENTRY" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>">
     <tr>            
	    <td bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">ALMACEN :</td>
       	<td bgcolor="<%=(Application("color2"))%>" WIDTH="70px"><input type="text" id="ALM" name="ALM" maxlength="4" class="datos"  size="500"/></td>
        <td bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">TIP DOC :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="39px"><input type="text" id="TIP" name="TIP" maxlength="2" class="datos" size="40PX" onblur="this.value=strzero(this.value,2)"/></td>
        <td bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">NUM DOC :</td>
        <td bgcolor="<%=(Application("color2"))%>"><input type="text" id="DOC" name="DOC" maxlength="11" class="datos" size="100" onblur="this.value=strzero(toInt(this.value),11)"/></td>
    </tr>
    <tr>             
        <td bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">ITEM :</td>
       	<td bgcolor="<%=(Application("color2"))%>"  > 
            <input type="text" id="ITM" name="ITM" class="datos" maxlength="4" onblur="this.value=strzero(toInt(this.value),4)"/></td>  
        <td  bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy" colspan="2" >&nbsp;</td>
        <td  bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">CANT :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="150px"><input type="text" id="CAN" name="CAN" class="datos" onkeyup="this.value=(toInt(this.value))"/></td>              
       
    </tr>
    <tr bgcolor="<%=application("color2") %>" align="center">
        <td colspan="6"><img src="imagenes/DISK.gif"   alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:pointer;" /></td>		               
    </tr>
</table>
<script language="jscript" type="text/jscript">
function GRABAR_onclick() {
    if (ltrim(rtrim(document.all.ALM.value)) == '') {
        alert("Favor informar el código de almacén")
        document.all.ALM.focus()
        return true;
    }
    bb = ltrim(rtrim(document.all.ALM.value))
    if (bb.length < 4) {
        alert("el código de almacén lleva 4 dígitos")
        document.all.ALM.focus()
        return true;
    }
    if (ltrim(rtrim(document.all.TIP.value)) == '') {
        alert("Favor informar TIPO de Docuemnto")
        document.all.TIP.focus()
        return true;
    }
    bb = ltrim(rtrim(document.all.TIP.value))
    if (bb.length < 2) {
        alert("el numero de Documentno lleva 2 dígitos")
        document.all.TIP.focus()
        return true;
    }
    if (ltrim(rtrim(document.all.DOC.value)) == '') {
        alert("Favor informar numero de Docuemnto")
        document.all.DOC.focus()
        return true;
    }
    bb = ltrim(rtrim(document.all.DOC.value))
    if (bb.length < 11) {
        alert("el numero de Documento lleva 11 dígitos")
        document.all.DOC.focus()
        return true;
    }
    if (ltrim(rtrim(document.all.ITM.value)) == '') {
        alert("Favor informar numero de LINEA - ITEM ")
        document.all.ITM.focus()
        return true;
    }
    if (ltrim(rtrim(document.all.CAN.value)) == '') {
        alert("Favor informar la Cantidad a modificar ")
        document.all.CAN.focus()
        return true;
    }

    cad = 'comun/updatearregla.asp?alm=' + ltrim(rtrim(document.all.ALM.value))
    cad += '&NUM=' + ltrim(rtrim(document.all.DOC.value))
    cad += '&lin=' + ltrim(rtrim(document.all.ITM.value))
    cad += '&can=' + ltrim(rtrim(document.all.CAN.value))
    cad += '&CTD=' + ltrim(rtrim(document.all.TIP.value))


    var si
    { si = confirm("¿ Confirma la ACTUALIZACION de este Registro ? "); }
    if (si == false)
    { return false; }


    window.location.replace(cad)
}

</script>
</body>
</html>
