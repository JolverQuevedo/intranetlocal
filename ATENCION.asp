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
<title>PE SERVICIOS</title>
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

<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="10%" align="center"><img src="imagenes/atras.gif" style="cursor:pointer;" onclick="javascript: window.location.replace('<%=submenu%>');" /></td>	
    
          <td align="center" class="TALASBLUE" width="80%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td class="talasblue" align="center">Atenci&oacute;n  O/C SERVICIOS</td></tr></table></td>
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
        <td width="15%"><input type="text" id="OC" name="OC" autofocus value="" class="TALASBLUE" onchange="validaOC()"></td>
        <td align="right" colspan="2"><input type="text" id="PRO" name="PRO" value="" class="DESCRIPTORES" readonly tabindex="-1" style="text-align:left"></td>
        <td width="1%" align="right" STYEL="PADDING-RIGHT:10PX;"><A href="javascript:showCal('Calendar1')">
            <img height=16 src="imageNEs/cal.gif" width=16 border=0></A></td>
        <td width="5%"><input type="text" id="EMB" name="EMB"  class="TALASBLUE"  value="<%=FORMATDATETIME(DATE(),2) %>" ></td>
    </tr>
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Almacen :&nbsp;</td> 
        <td width="15%"><input type="text" id="COD" name="COD" value="" class="DESCRIPTORES" readonly tabindex="-1" ></td>
        <td ><input type="text" id="ALM" name="ALM" value=""   class="DESCRIPTORES"  readonly tabindex="-1" style="width:100%"></td>
        <td ><input type="text" id="PE1" name="PE1" value=""   style="display:block" class="DESCRIPTORES"  readonly tabindex="-1" ></td>
        <td ><input type="text" id="PE2" name="PE2" value=""   style="display:block" class="DESCRIPTORES"  readonly tabindex="-1" ></td>
        <td width="10%"><input type="text" id="PS1" name="PS1" style="display:block" value="" class="DESCRIPTORES" readonly tabindex="-1" ></td>
    </tr>
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Entrada :&nbsp;</td> 
        <td><input type="text" id="TIP" name="TIP" value="E" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Movimiento :&nbsp;</td> 
        <td><input type="text" id="MOV" name="MOV" value="CO" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Nro. Parte :&nbsp;</td> 
        <td><input type="text" id="PAR" name="PAR" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
    </tr>
    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Fec. Doc. :&nbsp;</td> 
        <td><input type="text" id="FEC" name="FEC" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Tip. Cambio :&nbsp;</td> 
        <td><input type="text" id="CAM" name="CAM" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
        <td align="right" class="TEXTO7" WIDTH="10%" > Moneda :&nbsp;</td> 
        <td><input type="text" id="MON" name="MON" value="" class="DESCRIPTORES" readonly tabindex="-1"></td>
    </tr>

    <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Tipo Doc. Prv. :&nbsp;</td> 
        <td colspan="2"><select id="DOC" name="DOC" onchange="cambia()">
        <%cad = "Select TG_CCLAVE,TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD = '04' Order by TG_CCLAVE" 
        rs.open cad, cnn
        if rs.recordcount > 0 then rs.movefirst%>
            <%do while not rs.eof%>
                <option value="<%=rs("TG_CCLAVE")%>" 
                <%if trim(rs("tg_cclave"))= "GS" then  %>selected<%end if%>><%=rs("TG_CDESCRI") %></option>
                <%rs.movenext %>
            <%loop%>
        </select></td> 
        <td align="right" class="TEXTO7" WIDTH="10%" > &nbsp;</td> 
        <td align="right" class="TEXTO7" WIDTH="15%" > Nro. Doc. Ref. :&nbsp;</td> 
        <td><input type="text" id="NUME" name="NUME" value="" class="texto4" maxlength="20"  onchange="cambia()" ></td>  
    </tr>
     <tr>
        <td align="right" class="TEXTO7" WIDTH="10%" > Glosa :&nbsp;</td> 
        <td colspan="5"><input type="text" id="GLO" name="GLO" value="GS" maxlength="50"  style="width:99%" /></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
      
        <td><img src="imagenes/book.png" style="cursor:pointer;" onclick="graba()" id="SAVE" name="SAVE" alt="Mostrar Detalle" title="MOSTRAR DETALLE"/></td>
        <td><img src="imagenes/exit.jpg" style="cursor:pointer;" alt="salir" onclick="javascript: window.location.replace('<%=submenu%>');" title="SALIR"/>  </td>
        <td><img src="imagenes/new.gif" style="cursor:pointer;display:block" onclick="window.location.replace('atencion.asp')" id="RELOAD" name="RELOAD" alt="NUEVA OC" title="NUEVA OC"/> </td>
    </tr>
</table>
<center>

 
</center>
<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Detalle de OC : </td></tr>
</table> 
<iframe src="BLANCO.HTM" frameborder="0" name="deta" id="deta" width="100%" scrolling="yes" onload="calcHeight()"></iframe>

</form>  
<script language="javascript" src="includes/cal.js"></script>
<script language="jscript" type="text/jscript">
    addCalendar("Calendar1", "Elija una fecha", "EMB", "thisForm")
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";

function validaOC() {
    ORDEN = strzero(trim(document.getElementById('OC').value),10)
    // alert(ORDEN)
 //   document.all.head.style.display='block'
document.all.head.src= 'bake/bakeOCcab.asp?oc='+ ORDEN + '&cia='+ '<%=cia%>'
}

function graba() {
    if (trim(document.all.OC.value) == '') {
        alert("Favor indicar el Nro. de la Orden de Compra")
        return false;
    }
    if (trim(document.all.NUME.value) == '') {
        alert("Favor indicar el Nro. del documento de Referencia")
        return false;
    }
    if (trim(document.all.GLO.value) == '') {
        alert("Favor indicar la Glosa")
        return false;
    }
    /* 
        cad  = 'comun/inserCABatencion.asp?oc=' + document.all.OC.value + '&doc=' + trim(document.all.DOC.value)
        cad += '&nume=' + trim(document.all.NUME.value) + '&glo=' + ltrim(document.all.GLO.value)
    */
    kaa  = 'detaAtencion.asp?co=' + strzero(document.all.OC.value,10)  + '&nume=' + trim(document.all.NUME.value)
    kaa += '&glo=' + ltrim(document.all.GLO.value) + '&ref=' + trim(document.all.DOC.value)
    kaa += '&pe1=' + trim(document.all.PE1.value) + '&pe2=' + trim(document.all.PE2.value)
    kaa += '&ps1=' + trim(document.all.PS1.value) + '&alm=' + trim(document.all.COD.value)
   // alert(kaa)
    document.all.deta.src = kaa
}

function cambia()
{
document.all.GLO.value = trim(document.all.DOC.value) + ' Nro.' + ltrim(document.all.NUME.value)
}

</script>
</body>
</html>
