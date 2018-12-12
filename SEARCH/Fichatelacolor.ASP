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
    submenu = "SUBMENU.ASP?TIPO=3"
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
		        <tr><td align="center" class="talasblue">Genera Tela Color en Real Soft</td></tr>
		    </table> 
         </td>
	     <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  /></td>
    </tr>
</table>  

<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>


<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
   
    <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%"  class="style1">Tela :</td>
	    <td width="1%" colspan="1"  bgcolor="<%=(Application("BARRA"))%>" class="style2"><%if TRIM(RS("TEL"))= "" then%><img
             src="imagenes/help.gif" border="0" onClick="help('help/hlpfamtelas.asp')" alt=""/><%else%>&nbsp;<%end if %></td>
        <td align="left" class="style2" colspan="2"> <input type="text" id="TEL" name="TEL"  
            class="BARRA3" style="width:100%" maxlength="6" onChange="bake()" onkeyup="veri()"/></td>	
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" class="style2" colspan="2" >
            <input type="text" id="DES" name="DES" class="BARRA3"   /></td>    
    </tr>
    <tr>
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%" colspan="2"  class="style1">Modelo :</td>
        <td colspan="2" width="10%">
         <select id="MODELO" style="width:100%" name="MODELO" class="datos" >
            <option></option>
            <%cad  = "SELECT tg_cclave, tg_cdescri FROM RSFACCAR..AL0001TABL WHERE TG_CCOD='39' AND LEFT(tg_cDESCRI,4) = 'TELA' order by tg_cdescri" 
            RS.CLOSE
            rs.open cad,cnn
            if rs.recordcount > 0 then
                rs.movefirst%>
                <%DO WHILE NOT RS.EOF %>
                    <option value='<%=RS("TG_CCLAVE")%>'><%=RS("TG_CDESCRI")%></option>
                    <%RS.MOVENEXT %>
                <%LOOP %>
            <%end if%>
        </select>
        </td>
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%"  class="style1">Unidad :</td>
        <td>
        <select id="UNI" style="width:100%" name="UNI" class="datos" >
            <option></option>
            <%cad  = "Select tg_cclave, tg_cdescri From RSFACCAR..AL0001TABL Where TG_CCOD='05' Order by TG_CCLAVE" 
            RS.CLOSE
            rs.open cad,cnn
            if rs.recordcount > 0 then
                rs.movefirst%>
                <%DO WHILE NOT RS.EOF %>
                    <option value='<%=RS("TG_CCLAVE")%>'><%=RS("TG_CDESCRI")%></option>
                    <%RS.MOVENEXT %>
                <%LOOP %>
            <%end if%>
        </select>
        </td>
    </tr>
    <tr>
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%" colspan="2"  class="style1">Tipo :</td>
        <td colspan="2" width="10%">
        <select id="TIP" style="width:100%" name="TIP" class="datos" >
            <option></option>
            <%cad  = "Select tg_cclave, tg_cdescri From RSFACCAR..AL0001TABL Where TG_CCOD='08' Order by TG_CCLAVE" 
            RS.CLOSE
            rs.open cad,cnn
            if rs.recordcount > 0 then
                rs.movefirst%>
                <%DO WHILE NOT RS.EOF %>
                    <option value='<%=RS("TG_CCLAVE")%>'><%=RS("TG_CDESCRI")%></option>
                    <%RS.MOVENEXT %>
                <%LOOP %>
            <%end if%>
        </select>
        </td>
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%"  class="style1">Grupo :</td>
        <td>TL - Telas</td>
    </tr>
    <tr>        
	   <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Cliente:</td>
       <td align="left"  colspan="2" width="10%"><input type="text" id="CLI" name="CLI" value="" tabindex="-1" readonly class="BARRA3"  />    </td>
	   <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" id="xxx" style="display:none" colspan="2"  >
             <select id="DESCLI" style="width:100%" name="DESCLI" class="datos"  onChange="colores()">
               <option></option>
                <%CAD = "SELECT * FROM CLIENTE WHERE ESTADO = 'A' ORDER BY NOMBRE"
                RS2.OPEN CAD, Cnn %>
                <%if rs2.recordcount <=0 then%>
                     <option value=''>No Hay Clientes Registrados</option>
                <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                         <option value="<%=rs2("CODIGO")%>"><%=rtrim(ltrim(ucase(rs2("NOMBRE"))))%></option>
                    <%rs2.movenext%>
                    <%loop%>
              <%end if %>
              <%rs2.close%>
            </select>
           
        </td>               
    </tr>	
    <tr>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Colores:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" colspan="3" >
             <select id="DESCOL" name="DESCOL" class="datos"  multiple size="20" />
                <option></option>
	        </select>
	        </td>
        <td align="center" valign="middle"><img src="imagenes/rea1.jpg" border=""0" width="50%" style="cursor:pointer"
         onmouseover="this.src='imagenes/rea2.jpg'" onmouseout="this.src='imagenes/rea1.jpg'" onclick="return graba()" /></td>
	    
</tr>

                  
</table>
<input id="ELL1" style="display:none" />
<input id="EAL1" style="display:none" />
<input id="REV" style="display:none" />
<input id="DDL" style="display:none" />
<input id="AT" style="display:none" />
<input id="AA" style="display:none" />


<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">
addCalendar("Calendar1", "Elija una fecha", "FEC", "thisForm")
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

function veri()
{ if(event.keyCode==13)
    bake()
}

function bake() {
    cad = 'bake/baketela.asp?pos=' + trim(thisForm.TEL.value)
    document.all.body0.src = cad
    document.all.xxx.style.display = 'block';
    document.all.xxx.focus();
}

function colores()
{   thisForm.CLI.value = thisForm.DESCLI.value;
    //thisForm.COL.value = '';
    cad = 'bake/bakecoloresTELA.asp?pos=' + trim(thisForm.CLI.value) + '&sele=' + 'DESCOL' + '&TELA=' + +trim(thisForm.TEL.value)
    //document.all.body0.style.display='block'
   // alert(cad)
    document.all.body0.src= cad
}

function help(cad) {
    window.open(cad, '', opc)
    document.all.xxx.style.display = 'block'
    document.all.xxx.focus();
}

function NUMEROS(dato)
{	if (isNaN(dato.value)== true)
	{	alert("Sólo se aceptan números, REVISAR!")
		dato.focus();
		dato.value='';		
		return false;
	}
	return true;
}

function graba()
{   
    if(trim(thisForm.TEL.value)=='')
    {   alert("Debe informar el código del Artículo");
        help('help/hlpfamtelas.asp')
        return false;
    }
    if (thisForm.MODELO.selectedIndex <=0) {
        alert("Debe informar el Modelo del Artículo");
       thisForm.MODELO.focus()
        return false;
    }
    if (thisForm.TIP.selectedIndex <= 0) {
        alert("Debe informar el Tipo del Artículo");
        thisForm.TIP.focus()
        return false;
    }
    if (thisForm.UNI.selectedIndex <= 0) {
        alert("Debe informar Unidad de Medida del Artículo");
        thisForm.UNI.focus()
        return false;
    }
    if (thisForm.CLI.valueselectedIndex <=0) {
        alert("Debe informar el Cliente para poder mostrar colores");
        thisForm.CLI.focus()
        return false;
    }
    b=0
    for (j = 0; j < document.all.DESCOL.options.length; j++) 
    {   if (document.all.DESCOL.options[j].selected) 
        {   desco = document.all.DESCOL.options[j].text
            aCol[b] = trim(thisForm.TEL.value) + rtrim(ltrim(desco.substring(0, 8))) + Right(rtrim(ltrim(document.all.DESCOL.options[j].value)),2)
            aDes[b++] = Left(rtrim(ltrim(thisForm.DES.value)) + ' ' + rtrim(ltrim(desco.substring(14, 100))), 60)
        }
    }
    if (b == 0) {
        alert("Debe informar por lo menos un Color para el Artículo");
        thisForm.DESCOL.focus()
        return false;
    }
   
    cad  = 'comun/insertelacolor.asp?colo=' + aCol
    cad += '&desc=' + aDes
    cad += '&uni='  + trim(thisForm.UNI.value)
    cad += '&tip='  + trim(thisForm.TIP.value)
    cad += '&mode=' + trim(thisForm.MODELO.value)
    //alert(cad)
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