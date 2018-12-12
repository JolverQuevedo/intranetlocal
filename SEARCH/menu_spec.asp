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
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNleftgrupo.ASP"-->

<%
'response.write(request.Cookies("spe"))

sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)
cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")
'response.write(request.Cookies("spe"))

if ucasE(trim(sp)) = "AUTO" THEN
    sp = request.QueryString("spe")
    vr = request.QueryString("ver")
END IF
 %>
<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight ;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<body>

<table align="center" border="0"  cellpadding="2" cellspacing="3">
    <tr><td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(2)"  value="Construcci&oacute;n"          /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(1)"  value="Define Grupos/Medidas"        /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(11)" value="M&aacute;quinas de Costura"   /></td>    </tr>                     
    <tr><td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(3)"  value="Pos's del Spec"               /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(4)"  value="Ruta de confecci&oacute;n"    /></td>   
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(12)" value="Ojales/Bot&oacute;n"          /></td>    </tr>  
    <tr><td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(5)"  value="Hoja Etiquetas"               /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(6)"  value="Medidas en Prenda"            /></td>   
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(13)" value=""                             /></td>    </tr>                   
    <tr><td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(7)"  value="Hoja Bordado"                 /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(8)"  value="Avios"                        /></td>   
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(14)" value=""                             /></td>    </tr>
    <tr><td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(9)"  value="Hojas de Como Medir"          /></td>
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(10)" value="Datos Adicionales"            /></td>   
        <td><input type="button" style="width:100%; padding-left:30px; padding-right:30px;" onclick="show(15)" value=""                             /></td> </tr>
</table>


<iframe id="head" name="head" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
<iframe id="cuerpo" name="cuerpo" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
</body>
<script language="jscript" type="text/jscript">

   /* cli = getCookie('cli')
    tem = getCookie('tem')
    est = getCookie('est')
    spe = getCookie('spe')
    med = getCookie('med')
    mmd = getCookie('mmd')
    ver = getCookie('ver')
    */

function show(op) {
op = parseInt(op,10)
    

    switch (op) {
        case 1:
            cad = 'medidasxgrupo.asp';
            break;
        case 2:
            cad = 'CONSTRUCCION.ASP'
            break;
        case 3:
            cad = "help/pos_estilo_tempo.asp";
            break;
        case 4:
            cad = 'rutaspec.asp'
            break;
        case 5:
            break;
        case 6:
        cad = 'fichamedidas.asp'
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            cad = 'reportes/prn_grupoSPEC.asp'
            window.open(cad)
            cad = 'menu_spec.asp'
            break;
        case 10:
            cad ="ADICIONALESspec.asp"
            break;
        case 11:
            cad = "MAQUINASspec.asp"
            break;
        case 12:
        //    cad = "ADICIONALESspec.asp"
            break;
        case 13:
        //    cad = "ADICIONALESspec.asp"
            break;
        case 14:
        //    cad = "ADICIONALESspec.asp"
            break;
        case 15:
        //    cad = "ADICIONALESspec.asp"
            break;
        case 16:
         //   cad = "ADICIONALESspec.asp"
            break;
        case 17:
         //   cad = "ADICIONALESspec.asp"
            break;
        case 18:
         //   cad = "ADICIONALESspec.asp"
            break;
        case 19:
         //   cad = "ADICIONALESspec.asp"
            break;
        case 20:
         //   cad = "ADICIONALESspec.asp"
            break; 

    }
    window.location.replace(cad)
}











 /*   cad = "spec_head.asp?sp=" + "<%=sp%>" + "&vr=" + "<%=vr%>"
document.all.head.src= cad
  cad = "prn_fichamedidas.asp?sp=" + "<%=sp%>" + "&vr=" + "<%=vr%>"
document.all.cuerpo.src= cad
*/
</script>

</html>
