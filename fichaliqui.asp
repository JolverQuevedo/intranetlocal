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
<%opc =  request.querystring("opc")%>
<%sit =  request.querystring("sit")%>
<%tip =  request.querystring("tip")%>

<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="10%" align="center"><img src="imagenes/cerrar.gif" style="cursor:pointer;" onclick="javascript: window.close();" /></td>	
    
          <td align="center" class="TALASBLUE" width="80%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td class="talasblue" align="center" id ="tit">Liquidaci&oacute;n  O/C </td></tr></table></td>
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
    <td colspan="2">
        <table id="adicional" style="display:block" class="DESCRIPTORES">
            <tr>
                <td id="txtCIF">CIF</td>
                <td><input type=text size="30px" id="cif"/></td>
                <td id="txtFOB">FOB</td>
                <td><input type=text size="30px" id="fob"/></td>
                <td id="txtFAC">Factor</td>
                <td><input type=text size="30px" id="fac"/></td>
            </tr>
        </table>
    </td>
    </tr>
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Almacen :&nbsp;</td> 
        <td width="15%"><input type="text" id="COD" name="COD" value="" class="DESCRIPTORES" readonly tabindex="-1" ></td>
        <td COLSPAN="4"><input type="text" id="ALM" name="ALM" value=""   class="DESCRIPTORES"  readonly tabindex="-1" style="width:100%"></td>
        <td ><input type="text" id="PE1" name="PE1" value=""   style="display:block" class="DESCRIPTORES"  readonly tabindex="-1" ><input type="text" id="PE2" name="PE2" value=""   style="display:block" class="DESCRIPTORES"  readonly tabindex="-1" ><input type="text" id="PS1" name="PS1" style="display:block" value="" class="DESCRIPTORES" readonly tabindex="-1" ></td>
    </tr>
    
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Fec. Doc. :&nbsp;</td> 
        <td><input type="text" id="FEC" name="FEC" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Tip. Cambio :&nbsp;</td> 
        <td><input type="text" id="CAM" name="CAM" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Moneda :&nbsp;</td> 
        <td><input type="text" id="MON" name="MON" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
    </tr>
    <tr><td colspan="3" style="text-align:center"></td>
    <td colspan="1" style="text-align:right"><input type="button" id = "OK" value="LIQUIDA" onclick="liqui()" /></td>
    <td><input type="text" id="tip" name="tip" value="<%=ucase(trim(tip))%>" class="DESCRIPTORES" readonly tabindex="-1" style="width:30px">
    <input type="text" id="sit" name="sit" value="<%=sit%>" class="DESCRIPTORES" readonly tabindex="-1" style="width:30px"></td></tr>
    
</table>
   <div class="isa_info" id="divi1" style="display:none">
      <table cellpadding="0" cellspacing="0" border="0" align="center" >
        <tr><td width="10%"><i class="fa fa-info-circle"></i></td>
        <td width="90%"><input id="MSG1"  readonly style="width:100%;padding:10px;border:none;background-color:#BDE5F8;color:#00529B"/></td>
        </tr>
    </table> 
    </div>
    <div class="isa_success" id="divi2" style="display:none">
        <table cellpadding="0" cellspacing="0" border="0" align="center" >
        <tr><td width="10%"> <i class="fa fa-check"></i></td>
        <td width="90%"><input id="MSG2"  readonly style="width:100%;padding:10px;border:none;background-color:#DFF2BF;color:#4F8A10"/></td>
        </tr>
    </table> 
    </div>
    <div class="isa_warning" id="divi3" style="display:none">
         <table cellpadding="0" cellspacing="0" border="0" align="center" >
        <tr><td width="10%">  <i class="fa fa-warning"></i></td>
        <td width="90%"><input id="MSG3"  readonly style="width:100%;padding:10px;border:none;background-color:#FEEFB3;color:#9F6000"/></td>
        </tr>
    </table> 
    </div>
    <div class="isa_error" id="divi4" style="display:none">
      <table cellpadding="0" cellspacing="0" border="0" align="center" >
        <tr><td width="10%"> <i class="fa fa-times-circle"></i></td>
        <td width="90%"><input id="MSG4" readonly style="width:100%;padding:10px;border:none;background-color:#FFD2D2;color:#D8000C"/></td>
        </tr>
    </table> 
      
      
      
    </div>


<iframe src="BLANCO.HTM" frameborder="1" name="liq" id="liq" width="100%" scrolling="yes"  height="300px" style="display:none"></iframe>
<iframe src="BLANCO.HTM" frameborder="0" name="deta" id="deta" width="100%" scrolling="yes" onload="calcHeight()" style="display:block"></iframe>









</form>  
<script language="jscript" type="text/jscript">   
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";

if (trim(document.all.tip.value) != 'I') {
    document.all.txtCIF.innerText = 'FAC'
    document.all.txtFOB.innerText = 'DOC'
}

ORDEN = strzero(trim(document.getElementById('OC').value), 10)   
 
document.all.head.src= 'bake/bakeOCLIQ.asp?oc='+ ORDEN + '&cia='+ '<%=cia%>'

function liqui() {

    if (trim(document.all.tip.value) == 'I') {

        alert("La OC se finalizará recalculando el CIF")
        document.all.liq.style.display = 'block'
        document.all.liq.src = 'comun/liquiOCimp.asp?oc=' + '<%=oc%>' + '&tip=' + trim(document.all.tip.value) + '&sit=' + trim(document.all.sit.value) + '&fob=' + document.all.fob.value + '&cif=' + document.all.cif.value + '&fac=' + document.all.fac.value

    }

    else if (trim(document.all.tip.value) != 'S') {
        alert("La OC se finaliza sin recalculo de Precios")
        document.all.liq.src = 'comun/liquiOC.asp?oc=' + '<%=oc%>' + '&tip=' + trim(document.all.tip.value) + '&sit=' + trim(document.all.sit.value)
    }
    else {
        alert("La OC se finalizará recalculando el costo total")
        document.all.liq.style.display = 'block'
        document.all.liq.src = 'comun/liquiOCSRV.asp?oc=' + '<%=oc%>' + '&tip=' + trim(document.all.tip.value) + '&sit=' + trim(document.all.sit.value) + '&fob=' + document.all.fob.value + '&cif=' + document.all.cif.value + '&fac=' + document.all.fac.value

    
    }
}





</script>
</body>
</html>
