<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
var aCod = Array() 
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%	oc = Request.QueryString("Oc")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   
    cad = "exec FICHAOC_HEAD '"&oc&"' "  
	'   response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;" >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="10" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="left" class="talasblue">OFIS </td></tr>
            </table>
          </td>      
          <td align="center"><img src="imagenes/disk.gif" alt="GRABA" style="cursor:pointer" onclick="grabo()" /></td>
         <td width="15%" align="right"><img src="imagenes/LOGO.gif" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    </tr>
</table>  


<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<%rec=1 %>
<table cellpadding="0" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("color2") %>';border-color:'<%=APPLICATION("COLOR2") %>';" width="100%" align="center" >
    <tr align="left" class="AMERICANnavy" style="background-color:'<%=APPLICATION("FONDITO") %>'; padding-bottom:5; padding-left:5; padding-right:5; padding-top`:5">
        <td>Id</td></td><td>OFI</td></td><td>Cant</td></td><td>CLIENTE</td>
    </tr>
    <tr id="LIN<%=rec%>" >
        <td width="10%"><input id="LDET<%=rec%>" name="LDET<%=rec%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(rec))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=rec%>"  name="OFI<%=rec%>"  class="DATOSKHAKI"   style="width:100%;"/></td>
        <td width="20%"><input id="CAN<%=rec%>"  name="CAN<%=rec%>"  class="BARRA333"     style="width:100%;"/></td>
        <td width="50%"><input id="CLI<%=rec%>"  name="CLI<%=rec%>"  class="DESCRIPTORES" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%rec= rec+1 %>
    <%for i= rec to rec+20 %>
    <tr id="LIN<%=i %>" style="display:block    ;">
        <td width="10%"><input id="LDET<%=i%>" name="LDET<%=i%>" class="DESCRIPTORES" style="width:100%;text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(i))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=i%>"  name="OFI<%=i%>"  class="DATOSKHAKI"   style="width:100%;"/></td>
        <td width="20%"><input id="CAN<%=i%>"  name="CAN<%=i%>"  class="BARRA333"     style="width:100%;"/></td>
        <td width="50%"><input id="CLI<%=i%>"  name="CLI<%=i%>"  class="DESCRIPTORES" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%next %>





</table> 
<table cellpadding="0" cellspacing="0" border="1" style="border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
  
</table>

<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

<script type="text/jscript" language="jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";

/*
var subcadena = '<%=RS("OC_CRESCARG3")%>';
var elemento = document.all.RE3;
document.all.RE3.selectedIndex = seleindice(subcadena, elemento);

CkK = '<%=rs("OC_CUNIORD")%>'
if (trim(CkK) == '1' )
document.all.CHK.checked = true
*/
function BAKEPRO() {
    cad = 'bake/bakeREALpro.asp?pos=' + trim(thisForm.PRO.value)
/*  
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
  */ 
document.all.body10.src = cad
}

function helpPRO() {   
cad = 'help/HLPprovREAL.asp?hlp=1'
window.open(cad,'',opc)
}
function graba() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
    if (trim(document.all.PRO.value) == '') {
        alert("Antes de continuar, favor de informar el Proveedor");
        document.all.PRO.focus();
        return true;
    }
    if (document.all.MON.value == '') {
        alert("Favor ingresar codigo de moneda")
        document.all.MON.focus();
        return true;
    }
    if (document.all.TOC.value == '') {
        alert("Favor ingresar el tipo de Orden de compra")
        document.all.TOC.focus();
        return true;
    }
    cad = 'FICHAOCdeta.asp?OC=' + trim(thisForm.OC.value)
window.open(cad,'Deta_OC', opc)

}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>