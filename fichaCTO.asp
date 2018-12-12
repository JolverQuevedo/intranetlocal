<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>LIQUIDACION OC</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<%submenu = "SUBMENU.ASP?TIPO=13"
CIA = "0001"
%>
<script type="text/jscript" language="jscript">
    var aCod = Array()
    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('deta').contentWindow.
      document.body.scrollHeight +250;
        //change the height of the iframe
        document.getElementById('deta').height =
      the_height;
    }
</script>

<body style="margin-top:0; onload="document.getElementById('OC').focus();">
<%oc  =  request.querystring("oc")%>


<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="10%" align="center"><img src="imagenes/cerrar.gif" style="cursor:pointer;" onclick="javascript: window.close();" /></td>	
    
          <td align="center" class="TALASBLUE" width="80%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td class="talasblue" align="center" id ="tit">Calculo de Costeo  O/C </td></tr></table></td>
    <td width="10%" align="center"><img src="imagenes/logo.gif" /> </td>	
    </tr>
</table>    

<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Datos Generales : </td></tr>
</table> 

<iframe id="head" name="head"  style="display:none" src=""  width="100%" scrolling="no" frameborder="1" height="100"></iframe>
<table  border="0" cellspacing="2" cellpadding="2" align="center" width="100%" style="background-color:#DDEBC6" >
    <tr valign="middle">
       
        <td align="right" class="TEXTO7" width="10%"> O/C # :&nbsp;</td>
        <td width="15%"><input type="text" id="OC" name="OC"  class="DESCRIPTORES" value= '<%=oc%>' style="font-weight:800; FONT-SIZE: 15px;" readonly tabindex="-1"></td>
        <td align="right" colspan="2"><input type="text" id="PRO" name="PRO" value="" class="DESCRIPTORES" readonly tabindex="-1" style="text-align:left"></td>
        <td align="right" class="TEXTO7" >Situaci&oacute;n :&nbsp;</td>
        <td><input type="text" id="sit" name="sit" value="" class="DESCRIPTORES" readonly tabindex="-1" style="width:2%">
        <input type="text" id="Dsit" name="Dsit" value="" class="DESCRIPTORES" readonly tabindex="-1" style="width:96%">
        <input type="text" id="tip" name="tip" value="" class="DESCRIPTORES" readonly tabindex="-1" style="width:30px;display:none;"></td>
   
    </tr>
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Almacen :&nbsp;</td> 
        <td width="15%"><input type="text" id="COD" name="COD" value="" class="DESCRIPTORES" readonly tabindex="-1" ></td>
        <td COLSPAN="3"><input type="text" id="ALM" name="ALM" value=""   class="DESCRIPTORES"  readonly tabindex="-1" style="width:100%"></td>
         
    
         </tr>
    
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Fec. Doc. :&nbsp;</td> 
        <td><input type="text" id="FEC" name="FEC" value="" class="DESCRIPTORES" readonly tabindex="-1" /></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Tip. Cambio :&nbsp;</td> 
        <td><input type="text" id="CAM" name="CAM" value="" class="DESCRIPTORES" readonly tabindex="-1"/></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Moneda :&nbsp;</td> 
        <td><input type="text" id="MON" name="MON" value="" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    </tr>
   
</table>
   


<iframe src="BLANCO.HTM" frameborder="1" name="liq" id="liq" width="100%" scrolling="yes"  height="300px" style="display:none"></iframe>
<iframe src="BLANCO.HTM" frameborder="0" name="deta" id="deta" width="100%" scrolling="yes" onload="calcHeight()" style="display:block"></iframe>









</form>  
<script language="jscript" type="text/jscript">   
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";


ORDEN = strzero(trim(document.getElementById('OC').value), 10)
//document.all.head.style.display='block'
document.all.head.src= 'bake/bakeOCLIQcto.asp?oc='+ ORDEN 


</script>
</body>
</html>
