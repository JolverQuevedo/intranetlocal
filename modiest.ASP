<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
    ' indicar el submenu desde donde es llamado
    submenu = "SUBMENU.ASP?TIPO=12"
        %>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<style type="text/css" media="all">
#boton { background:url('imagenes/disk.gif') no-repeat; border:3; width:25px; height:25px; }
body{
   margin: 0px;
}
.box{
   border: 0px solid #000000;
   margin-left: 0;
   padding: 0px;
   text-align: left;
}
.box2{
   width: 100%;
   margin: 0;
   padding: 0;
   text-align: left;
}
textarea{
   height: 10em;
   width: 100%;
}
    .style1
    {
        FONT-WEIGHT: 900;
        FONT-SIZE: 11px;
        color: #000;
        FONT-FAMILY: "Arial";
        height: 22px;
    }
    .style2
    {
        height: 22px;
    }
</style>
<script type="text/jscript" language="jscript">
var aCod = Array()
var aCol = Array()
var aDes = Array()

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
<%	COD = Request.QueryString("pos")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
	CAD =	" exec SP_FICHACALIDADTELAS '"&COD&"'   " 
	'response.Write(cAD)

	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		IF RS("CON") = "C" THEN     
		    cct= trim(rs("cct"))
		    response.Redirect("reportes/prnfichacct.asp?pos="+cct)
		    response.End
		end if    
		marka = 1
		titulo = "FICHA # " + trim(rs("CCT"))+ " -> " + trim(rs("DES"))
	else
		marka = 0	
		titulo = "NUEVA FICHA CCT"
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/ATRAS.gif" style="cursor:hand;" onclick="javascript: window.location.replace('<%=submenu%>');"" /></td>		
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue">Modifica Estilo en Po, OFI, Proto - Version</td></tr>
		    </table> 
         </td>
	     <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  /></td>
    </tr>
</table>  

<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="1" height="200" align="middle"></iframe>

<table border="0" cellpadding="2" cellspacing="2" align="center" width="100%" >   
  
   <tr>
        <td width="50%">
            <table border="0" cellpadding="2" cellspacing="2" align="center" width="100%"> 
               <tr><td width="100%" class="TITULITOcenterRED" colspan="3">ANTES <font color='red'>(usar TAB)</td></tr>
               <tr>
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>" width="10%"  class="style1">OFI : &nbsp;&nbsp;</td>
                    <td><input id="OFI" name="OFI" class="DATOS" onchange="data1()"/></td>
                    <td width="20%" rowspan="5"><img  ID="FOT"  name="FOT" border="1" src="" width="150px"/></td>
                </tr>  
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">PROTO-VER : &nbsp;&nbsp; </td>
	                <td width="1%" class="style2"><input id="PRO" name="PRO" class="TEXTOBLUE" readonly tabindex="-1"/></td>
                </tr>   
                <tr>
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"  class="style1">PO :  &nbsp;&nbsp;</td>
                    <td width="10%"><input id="POS" name="POS" class="TEXTOBLUE"  readonly tabindex="-1" /></td> 
                </tr>
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Estilo MOD: &nbsp;&nbsp; </td>
	                <td width="1%" class="style2"><input id="EST" name="EST" class="TEXTOBLUE"  readonly tabindex="-1"/></td>
                </tr>   
                
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Estilo Cliente : &nbsp;&nbsp;</td>
	                <td width="1%" class="style2"><input id="ECL" name="ECL" class="TEXTOBLUE" readonly tabindex="-1"/>
                        <input id="CLI" name="CLI" type="hidden"/></td>
                </tr>   
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Descripcion: &nbsp;&nbsp; </td>
	                <td class="style2" colspan="2"><input id="des" name="des" class="TEXTOBLUE"  readonly tabindex="-1" style="width:100%"/></td>
                </tr>  
                 

            </table>
        </td>
        <td width="50%">
            <table border="0" cellpadding="2" cellspacing="2" align="center" width="100%">   
               <tr><td width="100%" class="TITULITOcenterRED" colspan="3">DESPUES <font color='red'>(hacer DOBLE CLICK)</td>  </tr>
               <tr>
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>" width="10%"  class="style1">OFI : &nbsp;&nbsp;</td>
                    <td><input id="OFI2" name="OFI2" class="TEXTOBLUE" readonly tabindex="-1"/></td>
                    <td width="20%" rowspan="5"><img id="foto2" name="foto2" border="1" src="" width="150px"/></td>
                </tr>  
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">PROTO-VER : &nbsp;&nbsp; </td>
	                <td class="style2"><input id="PRO2" name="PRO2" class="TEXTOBLUE" readonly tabindex="-1"/></td>
                </tr>   
                <tr>
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"  class="style1">PO :  &nbsp;&nbsp;</td>
                    <td width="10%"><input id="POS2" name="POS2" class="TEXTOBLUE"  readonly tabindex="-1" /></td> 
                </tr>
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Estilo MOD: &nbsp;&nbsp; </td>
	                <td class="style2"><input id="EST2" name="EST2" class="TEXTOBLUE"  readonly tabindex="-1"/></td>
                </tr>   
                <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Estilo Cliente : &nbsp;&nbsp;</td>
	                <td class="style2"><input id="ECL2" name="ECL2" class="datoskhaki" ondblclick="NUEVO()" />
                             <input id="CLI2" name="CLI2" type="hidden"/></td>
                </tr> 
                
                    <tr valign="middle">
                    <td align="right" bgcolor="<%=(Application("BARRA"))%>"   class="style1">Descripcion: &nbsp;&nbsp; </td>
	                <td  class="style2" colspan="2"><input id="des2" name="des2" class="TEXTOBLUE"  readonly tabindex="-1"  style="width:100%"/></td>
                </tr>   
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center" ><input type="button" value= " GRABAR" onclick="graba()" /></td>
    </tr>
</table>



<script type="text/jscript" language="jscript">

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=500" ;
/*
document.all.OFI.focus()

function veri()
{ if(event.keyCode==13)
   // bake()
}
*/
    function data1() {
        
    cad = 'bake/bakemodiest.asp?ofi=' + strzero(trim(document.all.OFI.value), 8)
    //document.all.body0.style.display = 'block';
    //alert(cad)
    document.all.body0.src = cad


}
function foton() {
    img = document.all.EST.value
    cad = 'BAKE/RECUPERAFOTOESTILO.ASP?ID=' + img + '&cli=' + document.all.CLI.value
   // alert(cad)
    document.getElementById('FOT').src = cad
}

function foton2() {

    document.all.POS2.value = document.all.POS.value;
   // alert()
    document.all.OFI2.value = document.all.OFI.value;
    document.all.CLI2.value = document.all.CLI.value;
    document.all.PRO2.value = document.all.PRO.value;
    img = document.all.EST2.value
    cad = 'BAKE/RECUPERAFOTOESTILO.ASP?ID=' + img + '&cli=' + document.all.CLI.value
    // alert(cad)
    document.getElementById('foto2').src = cad
}



function NUEVO() {
    cad = 'help/HLPNEWestilo.asp?est=' + trim(document.all.ECL2.value) + '&cli=' + document.all.CLI.value
   window.open(cad,'Estilos',opc)
 }





function graba()
{   
   
    cad  = 'comun/inserNEWestilo.asp?ofi=' + strzero(document.all.OFI.value,8) + '&est=' + document.all.EST2.value
   
  alert(cad)
 document.all.body0.style.display = 'block'
  document.all.body0.height = "350"
  document.all.body0.width = "100%"
  document.all.body0.src = cad;
  
    //document.all.body0.style.display = 'none'
}
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>