<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form name="thisForm" METHOD="post"  >
	
		
	
<%' recibe tabla, primary key, y descripcion
tbl = "modelador..cliente"
DS = "NOMBRE"

cad =	"select * from "&TBL&" WHERE ESTADO = 'A' order by "&DS&" "
rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
<table align="center" border="0" width="100%">
<tr>
    <td align= left width=35% rowspan="3">
	<img src="imagenes/ATRAS.gif" style="cursor:hand;"
	onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=2');">				
	    <td colspan="7" align="center" ><font face="arial" size="4" color='navy'><b>Colores por Cliente - Temporada - Estilo</b></font></td>	
        <td align="right" width="35%" rowspan="3"><img src="imagenes/logo.GIF"></td>
    </tr>
    <tr class="TITULITOcenterGREEN">
        
        <td>Cliente</td>
        <td>Temporada</td>
        <td>Estilos</td>
        <td>ETC</td>
    </tr>
	<tr>
    
	<td align="center">	
		<select id="CLI" name="CLI" class="Data" onchange="CAMBIA()">
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("codigo"))%>'><%=trim(rs("nombre"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</td>
     <td align="center">	
		<select id="TEM" name="TEM" class="Data" onchange="ESTILO()">
			<option value=''></option>           
		</select>
	</td>
    <td align="center">	
		<select id="ESTI" name="ESTI" class="Data" onchange="blanco()" >
			<option value=''></option>          
		</select>
	</td>
    <td align="center">	
		<select id="TIP" name="TIPO" class="Data" onchange="blanco()"  >
			<option value='T'>TELAS</option>          
            <option value='A'>AVIOS</option>          
		</select>
	</td>
    <td>
        <input type="button" value= "" onclick="ENVIO()" style="display:block" class="botonok" ></td>
    </tr>	   
</tr>
</table>
</form>
<iframe  width="100%" src="BLANCO.HTM" id="body10" name="body10" scrolling="yes" frameborder="0" height="250" width="100%" align="middle" style="display:block"></iframe>
<iframe  width="100%" src="BLANCO.HTM" id="tallas" name="tallas" scrolling="yes" frameborder="0" height="120" width="100%" align="middle" style="display:block"></iframe>
<%rs.close
set rs = nothing
set cnn=nothing%>

<script language="jscript" type="text/jscript">

function ESTILO() {
cad = "BAKE/BAKEtemporadaclienteestilo.asp?cli=" + trim(document.all.CLI.value) + '&TEM=' + trim(document.all.TEM.value);
//    alert(cad)
    document.all.body10.src =cad
}

function CAMBIA() {
    document.all.body10.src = "BAKE/BAKEtemporadacliente.asp?cli=" + trim(document.all.CLI.value) + '&sele=TEM';
}

function ENVIO() {
    cad  = 'ETC.asp?CLI=' + trim(document.all.CLI.value) + '&TEM=' + trim(document.all.TEM.value)
    cad += '&tip=' + trim(document.all.TIPO.value) + '&EST=' + trim(document.all.ESTI.value);
   // alert(cad)
    parent.window.frames.item(1).window.location.replace(cad)
}

function blanco() {
    cad = 'blanco.htm'
    parent.window.frames.item(1).window.location.replace(cad)

}

</script>
</BODY>
</HTML>
