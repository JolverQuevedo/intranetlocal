<%@ Language=VBScript %>
<% Response.Buffer = true %>
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
	    <td colspan="7" align="center" ><font face="arial" size="4" color='navy'><b>SPEC's por Cliente - Temporada - Estilo</b></font></td>	
        <td align="right" width="35%" rowspan="3"><img src="imagenes/logo.GIF"></td>
    </tr>
    <tr class="TITULITOcenterGREEN">
        
        <td>Cliente</td>
        <td>Temporada</td>
        <td>Estilos</td>
        <td>Specs</td>
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
		<select id="ESTI" name="ESTI" class="Data" onchange="SPEC()">
			<option value=''></option>          
		</select>
	</td>
    <td align="center">	
		<select id="SPE" name="SPE" class="Data" onchange="ENVIO()">
			<option value=''></option>        
		</select>
	</td>
    <td>
        <input type="button" value= "" onclick="pos()" style="display:block" class="botonok" ></td>
    </tr>	   
</tr>
</table>
</form>
<iframe  width="100%" src="BLANCO.HTM" id="body10" name="body10" scrolling="yes" frameborder="0" height="250" width="100%" align="middle" style="display:none"></iframe>
<iframe  width="100%" src="BLANCO.HTM" id="tallas" name="tallas" scrolling="yes" frameborder="0" height="120" width="100%" align="middle" style="display:block"></iframe>
<%rs.close
set rs = nothing
set cnn=nothing%>

<SCRIPT>

function ESTILO() {

    cad = "BAKE/BAKEtemporadaclienteestilo.asp?cli=" + trim(document.all.CLI.value) + '&TEM=' + trim(document.all.TEM.value);
//    alert(cad)
    document.all.body10.src =cad
}

function CAMBIA() {
    document.all.body10.src = "BAKE/BAKEtemporadacliente.asp?cli=" + trim(document.all.CLI.value) + '&sele=TEM';
}
function SPEC() {
    document.all.body10.src = "BAKE/BAKEtemporadaclienteESTILOSPEC.asp?cli=" + trim(document.all.CLI.value) + '&tem=' + ltrim(document.all.TEM.value) + '&est=' + ltrim(document.all.ESTI.value)
}

function ENVIO() {

    cad  = 'MEDIDASxGRUPO.asp?CLI=' + trim(thisForm.CLI.value)
    cad += '&tem=' + ltrim(document.all.TEM.value)
    cad += '&est=' + ltrim(document.all.ESTI.value)
    cad += '&spe=' + ltrim(document.all.SPE.value)
  /*  cad += '&med=' + ltrim(document.all.MED.value)
    cad += '&MMD=' + ltrim(document.all.MMD.value)
    */
    //alert(parent.window.frames.item(1).name)

    setCookie('cli', trim(thisForm.CLI.value))
    setCookie('tem', ltrim(document.all.TEM.value))
    setCookie('est', ltrim(document.all.ESTI.value))
/*  setCookie('med', ltrim(document.all.MED.value))
    setCookie('mmd', ltrim(document.all.MMD.value))
    */
    setCookie('spe', Left(trim(document.all.SPE.value),10))
    setCookie('ver', Right(trim(document.all.SPE.value), 3))
    kam = "comun/creaSPEC.asp"
  //  document.all.body10.style.display='block'
    document.all.body10.src = kam
    document.all.tallas.src = "CLIENTE_TEMP_EST_TALLA.asp?CLI=" + trim(thisForm.CLI.value) + '&tem=' + ltrim(document.all.TEM.value) + '&est=' + ltrim(document.all.ESTI.value) + '&spe=' + ltrim(document.all.SPE.value)
    //  parent.window.frames.item(1).window.location.replace(cad)

    if (ltrim(document.all.SPE.value) != 'AUTO') {
        parent.window.frames.item(1).window.location.replace('menu_spec.asp')
    }
}
function pos() {
    if (trim(document.all.SPE.value) == '') {
        alert("Por favor seleccione un spec o Genere uno nuevo")
        return false;
    }
  // 
    // por si acaso, primero las borro 
    delCookie('cli')
    delCookie('tem')
    delCookie('est')
    delCookie('spe')
 /* delCookie('med')
    delCookie('mmd')
    */
    delCookie('ver')
    // y las vuelvo a crear 
    setCookie('cli', trim(thisForm.CLI.value))
    setCookie('tem', ltrim(document.all.TEM.value))
    setCookie('est', ltrim(document.all.ESTI.value))
/*  setCookie('med', ltrim(document.all.MED.value))
    setCookie('mmd', ltrim(document.all.MMD.value))
*/
    setCookie('spe', Left(trim(document.all.SPE.value), 10))
    setCookie('ver', Right(trim(document.all.SPE.value), 3))

    cad = "help/pos_estilo_tempo.asp?cli=" + trim(thisForm.CLI.value) + '&tem=' + ltrim(document.all.TEM.value) + '&est=' + ltrim(document.all.ESTI.value)
    var opc = "directories=no, height=600, hotkeys=no, location=no,";
    opc += "menubar=no, resizable=YES, left=0, top=0,scrollbars=yes,";
    opc += "status=no, titlebar=no, toolbar=no, width=200";	
//window.open(cad,"POs",opc)
 ENVIO()
}
</SCRIPT>
</BODY>
</HTML>
