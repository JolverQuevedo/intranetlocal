<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID = 2057 %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
     Session.LCID=2057
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


</style>

<script type="text/jscript" language="jscript">
var NUMTAL=0
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
function ACHICA() {
    /*window.resizeTo(1100, 700)
    window.moveTo(0,0)*/
    return true;
	}
</script>
<%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
	rs.open "select mermatela from tb_ctrl"
	rs.movefirst
	mermatela = rs("mermatela")
	rs.close
    AJU	= Request.QueryString("AJU")
	VER = Request.QueryString("VER")
	CLI	= Request.QueryString("CLI")
	CAD =	" exec FICHAAJUSTE '"&AJU&"' , '"&VER&"', '"&CLI&"'  " 
	
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RECORDCOUNT > 0 THEN 
        RS.MOVEFIRST
    	OBS= RS("OBS")	
	    titulo = "HOJA DE AJUSTE # " + trim(rs("AJU"))+ " -> " + trim(rs("VER"))
    end if
	%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es-pe" >

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<script language="javascript" type="text/javascript">

</script>
</head>
<body onkeypress="cotiza()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAajuste.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:hand;" onClick="window.close()" /></td>		
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
	     <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
    </tr>
</table>  
<iframe  width="100%" onload="calcHeight();" style="display:none; width:100%;" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>G E N E R A L E S :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" colspan="2" class="TITULITO"># AJUSTE:</td>
        <td align="left" ><input type="text" id="AJU" name="AJU" value=
	        "<%=rs("aju")%>" tabindex="-1" readonly="readonly" class="BARRAS" style="width:100%" />    </td>
	    <td align="left" colspan="1" width="1%"><input type="text" id="VER" name="VER" value="<%=rs("VER")%>" 
	        tabindex="-1" readonly="readonly" class="BARRAS" style="width:100%" /></td>
        <td width="10%" align="left" bgcolor="<%=(Application("BARRA"))%>" class="TITULITORIGHT">CLIENTE:&nbsp;&nbsp;</td>
        <td align="left" colspan="1"><input type="text" id="CLI" name="CLI" value=
	        "<%=rs("CLI")%>" tabindex="-1" readonly="readonly" class="BARRAS" style="width:100%" />    </td>
	    <td align="left"  width="15%" colspan="3" bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="NOM" name="NOM" value="<%=rs("NOM")%>" 
	        tabindex="-1" readonly class="barras"/></td>  
	    <td align="left"  width="10%" rowspan="8" valign="top"><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("EST")%>&CLI=<%=RS("CLI")%>" width="150" ID="FOT" /></td>   
    </tr>
    <tr valign="middle">
        <td colspan="2" align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO">ESTILO</td>
        
        <td align="left"><input type="text" id="EST" name="EST" value=
	        "<%=rs("EST")%>" tabindex="-1" readonly="readonly" class="BARRAS" style="width:100%" />    </td>
	    <td align="left" colspan="2" bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="ECL" name="ECL" value="<%=rs("ECL")%>"    tabindex="-1" readonly="readonly" class="barras"/></td>
	    <td align="left" colspan="4" bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="DESE" name="DESE" value="<%=rs("DES")%>" 
	         class="barras" maxlength="200"  tabindex="-1" readonly="readonly"/></td>  
    </tr>
    <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>"  class="TITULITO" colspan="2">GENERO:</td>
        <td width="1%" align="left"><input type="text" id="GEN" name="GEN" value="<%=rs("GEN")%>" tabindex="-1" readonly="readonly" class="BARRAS"  /></td>  
	    <td align="left" colspan="2" bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="DGEN" name="DGEN" value="<%=rs("DGEN")%>" tabindex="-1" readonly="readonly" class="barras"  /></td>   
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO" >TIPO PRENDA:</td>   
	    <td width="1%" align="left"><input type="text" id="TIP" name="TIP" value="<%=rs("TIP")%>" tabindex="-1" readonly="readonly" class="BARRA2" /></td>  
	    <td width="15%" colspan="2" align="left"  bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="TPRE" name="TPRE" value="<%=rs("TPRE")%>" tabindex="-1" readonly="readonly" class="barras"  /></td>          
    </tr>
     
     <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO" colspan="2">Observaciones:</td>
         <td align="left" colspan="6"><input type="text" id="OBSE" name="OBSE" value="<%=rs("ADIC")%>"   tabindex="-1" readonly="readonly" class="BARRAs"  />  
         </tr>

     <tr valign="middle">
        <td colspan="2" align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO">TEMPORADA :</td>
        <td align="left"><input type="text" id="TEM" name="TEM" value=
	        "<%=rs("TEM")%>" tabindex="-1" readonly="readonly" class="BARRAS"/>    </td>
	    <td align="left" colspan="2"  bgcolor="<%=(Application("BARRA"))%>"><input type="text" id="DTEM" name="DTEM" value="<%=rs("DTEM")%>" tabindex="-1" readonly="readonly" class="barras"  /></td>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO">&nbsp;GRUPO TELA :</td>     
	    <td align="left" colspan="3"><input type="text" id="MOT" name="MOT" value="<%=rs("MOT")%>"  tabindex="-1" readonly="readonly"
	        maxlength="100" class="BARRAs" /></td>  
    </tr>
   <tr valign="middle">
     <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">TELA :</td>
     <td align="left"><input type="text" id="TELA" name="TELA" value="<%=rs("TEL")%>"  class="barras"  tabindex="-1" readonly="readonly"/>    </td>
	 <td align="left" colspan="6"  bgcolor="<%=(Application("BARRA"))%>"><textarea id="DTEL" name="DTEL" readonly rows="2" tabindex="-1" class="estilotextarea4"><%=rs("DTEL")%></TEXTAREA></td>
   </tr> 
   <tr valign="middle">
    <td colspan="9" bgcolor="<%=(Application("BARRA"))%>" width="90%">
        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="left" class="TITULITO" width="8%">GALGA :</td>
            <td align="left"  width="12%"><input type="text" id="GG" name="GG" value="<%=rs("GG")%>" tabindex="-1" readonly class="barras" /></td>
            <td align="left" class="TITULITORIGHT"  width="8%">ANCHO :&nbsp;&nbsp; </td>
            <td align="left"  width="12%">
            <input type="text" id="AA" name="AA" value="<%=rs("AA")%>" tabindex="-1" readonly class="barras"  style="display:none"  />
            <input type="text" id="AT" name="AT" value="<%=rs("AT")%>" tabindex="-1" readonly class="barras"  /></td>
            <td align="left"class="TITULITORIGHT"  width="12%">DENSIDAD :&nbsp;&nbsp; </td>
            <td align="left"><input type="text" id="PA" name="PA" value="<%=rs("PA")%>" tabindex="-1" readonly class="barras" /></td>
            <td align="left" class="TITULITORIGHT"  width="13%">RENDIMIENTO : &nbsp;&nbsp;</td>
            <td align="left" width="12%">
            <input type="text" id="RT" name="RT" value="<%=formatnumber(rs("RT"),2,,true)%>" tabindex="-1" readonly class="barras" style="display:none" />
            <input type="text" id="RA" name="RA" value="<%=formatnumber(rs("RA"),2,,true)%>" tabindex="-1" readonly class="barras"  /></td>
            </tr>  
         </table>   
     </td>
   </tr>     
    <tr valign="middle" >
         <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%"  class="TITULITO" colspan="2">TALLAS :</td>
       
    <td colspan="7" WIDTH="90%" bgcolor="<%=(Application("BARRA"))%>">
        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  >
          <tr id="TALLAS">
            <%FOR I=0 TO 14 %>
                <td align="left" width="5%"><input type="text" id="T<%=I%>" name="T<%=I%>" tabindex="-1" readonly class="BARRAAZUL" style="display:none"/></td>
            <%NEXT%>
              <%RS2.OPEN "SELECT TALLA,PROP, orden FROM [ajuste-TALLAS] WHERE ajuste = '"&aju&"' AND VERSION = '"&VER&"' ORDER BY ORDEN", CNN 
              IF RS2.RECORDCOUNT > 0 THEN 
                RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                        <script language="jscript" type="text/jscript">
                            eval("document.all.T"+parseInt('<%=rs2("orden")%>',10)+".style.display='block'")
                            eval("document.all.T"+parseInt('<%=rs2("orden")%>',10)+".value='<%=rs2("talla")%>'")
                        </script>
                       <%RS2.MOVENEXT%>
                   <%LOOP%>
              <%END IF%>     
          </tr>  
         </table>   
     </td>
   </tr>   
   <tr valign="middle" >
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">PROPORCION :</td>
        <td colspan="7" WIDTH="90%">
            <table width="100%" align="center" border="1" cellpadding="0" cellspacing="0">
                <tr id="RATIO">
                 <%FOR I=0 TO 14 %>
                    <td align="left"  width="5%">
                        <input type="text" id="R<%=I%>" name="R<%=I%>" style="display:none" class="BARRAw3" maxlength=2 style="background-color:#fff5d7; text-align:center"/></td>
                <%NEXT %>
                  <%IF RS2.RECORDCOUNT > 0 THEN 
                    RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                       <script language="jscript" type="text/jscript">
                            eval("document.all.R"+parseInt('<%=rs2("orden")%>',10)+".style.display='block'")
                            eval("document.all.R"+parseInt('<%=rs2("orden")%>',10)+".value='<%=rs2("prop")%>'")
                        </script>
                        <%RS2.MOVENEXT %>
                    <%LOOP%>
                  <%END IF %>     
                </tr>  
            </table>   
     </td>
   </tr>    
   <%rs2.close%>
</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>T E L A S :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>">
        <td align="left" class="TEXTOmicro" width="1%">&nbsp;</td>
        <td align="left" class="TEXTOmicro" width="6%">COD</td>
        <td align="left" class="TEXTOmicro" width="30%">TELA</td>
        <td align="left" class="TEXTOmicro" width="3%">RUTA</td>
        
        <td align="left" class="TEXTOmicro" width="3%">Largo Mt</td>
        <td align="left" class="TEXTOmicro" width="3%">Anch Mt</td>        
        <td align="left" class="TEXTOmicro" width="3%">Den. PM2</td>
        <td align="left" class="TEXTOmicro" width="1%">&nbsp;T&nbsp;</td>
        <td align="left" class="TEXTOmicro" width="2%"># PZAS</td>
        <td align="left" class="TEXTOmicro" width="3%">FAC TOR</td>
        <td align="left" class="TEXTOmicro" width="5%">CONS Uni (gr.)</td>
        <td align="left" class="TEXTOmicro" width="3%">% MER.</td>
        <td align="left" class="TEXTOmicro" width="6%">CONS Tot(grs.)</td>
        <td align="left" class="TEXTOmicro" width="30%">COMENTARIO</td>
    </tr>    
    <%CAD =	" exec FICHAajuste_TELA '"&AJU&"' , '"&VER&"'  "  
    'RS.CLOSE
    'response.write(cad)
    RS2.OPEN CAD,CNN%>
    <% RS2.MOVEFIRST%>
    <%I=0%>
	<%DO WHILE NOT RS2.EOF%>
		<tr valign="middle" bgcolor="<%=(Application("color2"))%>" style="display:block" id="FILA<%=i%>" >
             <td width="1%"><input type="checkbox" id="Checkbox1" name="DELE<%=I%>" value="1"  onclick="dele('<%=i%>')" /></td>
            <td width="6%"><input type="text" id="Text1" name="TEL<%=i%>" value="<%=rs2("tel")%>"  class="DATOSKHAKI" onDblClick="help('help/hlpfamtelas.asp?HLP=2','<%=i%>','tela')" onchange="bake(2,this.value,'<%=i %>')" /></td>
            <td width="30%"><textarea id="DTE<%=i%>" name="DTE<%=i%>" tabindex="-1"  readonly rows="2" class="estilotextarea4" ><%=rs2("DTE")%></TEXTAREA></td>
            <td width="3%"><input type="text" id="RUT<%=i%>" name="RUT<%=i%>" value="<%=rs2("RUT")%>"  class="DATOSKHAKI" 
                ondblclick="help('HELP/HLPrutatela.asp?POS=', '<%=i%>', 'ruta')"/></td>
           
            <td width="3%"><input type="text" id="LAR<%=i%>" name="LAR<%=i%>" value="<%=formatnumber(rs2("LAR"),2,,true)%>" class="DATOSKHAKI" maxlength="5" onblur="this.value=toInt(this.value);rend('<%=i%>');TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;"/></td>
            <td width="3%"><input type="text" id="ANC<%=i%>" name="ANC<%=i%>" value="<%=formatnumber(cdbl(rs2("ANC")),2,,true)%>" class="DATOSKHAKI" style="text-align:right; padding-right:5px;" onblur="this.value=toInt(this.value);rend('<%=i%>');TOTA('<%=i%>')"/></td>
            <td width="3%"><input type="text" id="PM2<%=i%>" name="PM2<%=i%>" value="<%=formatnumber(rs2("PM2"),0,,true)%>" class="barras" readonly tabindex="-1" /></td>
            <td width="1%"><input type="text" id="TIP<%=i%>" name="TIP<%=i%>" value="<%=rs2("TIP")%>" class="barras" readonly tabindex="-1" /> </td>
            <td width="2%"><input type="text" id="PZA<%=i%>" name="PZA<%=i%>" value="<%=rs2("PZA")%>" class="DATOSKHAKI" maxlength="3" onblur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;" /></td>
            <td width="3%"><input type="text" id="FAC<%=i%>" name="FAC<%=i%>" value="<%=formatnumber(rs2("FAC"),1,,,true)%>" class="DATOSKHAKI" maxlength="3" onblur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;" /></td>
            <td width="5%"><input type="text" id="CUN<%=i%>" name="CUN<%=i%>" value="<%=formatnumber(rs2("CUN"),3,,,true)%>" class="barras" readonly tabindex="-1"  style="text-align:right; padding-right:5px;"/></td>
            <td width="3%"><input type="text" id="MER<%=i%>" name="MER<%=i%>" value="<%=rs2("MER")%>" class="DATOSKHAKI" maxlength="2" onBlur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;"/></td>
            <td width="6%"><input type="text" id="TOT<%=i%>" name="TOT<%=i%>" value="<%=formatnumber(rs2("TOT"),3,,,true)%>" class="barras" readonly tabindex="-1"  style="text-align:right; padding-right:5px;"/></td>
             <td width="30%"><textarea id="Textarea1" name="COM<%=i%>" rows="2" class="ADICIONALFIJO" onKeyPress="return imposeMaxLength(this, longi);" style="background-color:#fff5d7;"><%=rs2("COM")%></TEXTAREA></td>
    </tr>    
		<%
        RS2.MOVENEXT%>
        <%I = I+1%>
	<%LOOP%>
    <%TOPE = I%>
    <%TpP = I%>
    <%for i=TOPE to TOPE+3%>   
    <tr valign="middle" bgcolor="<%=(Application("color2"))%>" style="display:none" id="FILA<%=i%>" >
        <td width="1%"><input type="checkbox" id="DELE<%=I%>" name="DELE<%=I%>" value="1" onClick="dele('<%=i%>')"  /></td>
        <td width="6%"><input type="text" id="TEL<%=i%>" name="TEL<%=i%>"  class="DATOSKHAKI"  ondblclick="help('help/hlpfamtelas.asp?HLP=2','<%=i%>','tela')" onchange="bake(2,this.value,'<%=i %>')"  onFocus="SIGUIENTE('<%=I%>')" /></td>
        <td width="30%"><textarea id="DTE<%=i%>" name="DTE<%=i%>" tabindex="-1"  readonly rows="2" class="estilotextarea4"></TEXTAREA></td>
        <td width="3%"><input type="text" id="RUT<%=i%>" name="RUT<%=i%>" class="DATOSKHAKI" onDblClick="help('HELP/HLPrutatela.asp?POS=','<%=i%>','ruta')"/></td>

        <td width="3%"><input type="text" id="LAR<%=i%>" name="LAR<%=i%>" class="DATOSKHAKI" maxlength="5" onblur="this.value=toInt(this.value);rend('<%=i%>');TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;" /></td>
        <td width="3%"><input type="text" id="ANC<%=i%>" name="ANC<%=i%>" class="DATOSKHAKI"  onblur="this.value=toInt(this.value);rend('<%=i%>');TOTA('<%=i%>')"  /></td>
        <td width="3%"><input type="text" id="PM2<%=i%>" name="PM2<%=i%>" class="barras" readonly tabindex="-1" /></td>
        <td width="1%"><input type="text" id="TIP<%=i%>" name="TIP<%=i%>" class="barras" readonly tabindex="-1" /> </td>
        <td width="2%"><input type="text" id="PZA<%=i%>" name="PZA<%=i%>" class="DATOSKHAKI" maxlength="3" onblur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;"  /></td>
        <td width="3%"><input type="text" id="FAC<%=i%>" name="FAC<%=i%>" class="DATOSKHAKI" maxlength="3" onblur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;" /></td>
        <td width="5%"><input type="text" id="CUN<%=i%>" name="CUN<%=i%>" class="barras"  readonly tabindex="-1" /></td>
        <td width="3%"><input type="text" id="MER<%=i%>" name="MER<%=i%>" class="DATOSKHAKI" maxlength="2" onBlur="this.value=toInt(this.value);TOTA('<%=i%>')"  style="text-align:right; padding-right:5px;" /></td>
        <td width="6%"><input type="text" id="TOT<%=i%>" name="TOT<%=i%>" class="barras" readonly tabindex="-1" /></td>
                <td width="30%"><textarea id="COM<%=i%>" name="COM<%=i%>" rows="2" class="ADICIONALFIJO" onKeyPress="return imposeMaxLength(this, longi);" style="background-color:#fff5d7;"></TEXTAREA></td>
    </tr>    
    <%next%>
</table>
<%TOPE = I%>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>A V I O S :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>">
        <td align="left" class="TEXTOmicro" width="1%">&nbsp;</td>
        <td align="left" class="TEXTOmicro" width="6%">COD</td>
        <td align="left" class="TEXTOmicro" width="25%">AVIO</td>
        
        <td align="left" class="TEXTOmicro" width="3%">Unid. </td>
        <td align="left" class="TEXTOmicro" width="3%" colspan="2">Area</td>
        <td align="left" class="TEXTOmicro" width="3%"colspan="2">Tipo</td>
        <td align="left" class="TEXTOmicro" width="5%">CONS Uni </td>
        <td align="left" class="TEXTOmicro" width="3%">% MER.</td>
        <td align="left" class="TEXTOmicro" width="6%">CONS Tot</td>
        <td align="left" class="TEXTOmicro" width="30%">COMENTARIO</td>
        <td style="display:none">costo</td>
    </tr>    
    <%CAD =	" exec FICHAajuste_Avio '"&aju&"' , '"&VER&"'  "  
    'RESPONSE.WRITE(CAD)
    RS2.CLOSE
    RS2.OPEN CAD,CNN%>
    <% RS2.MOVEFIRST%>
	<%DO WHILE NOT RS2.EOF%>
		<tr valign="middle" bgcolor="<%=(Application("color2"))%>" style="display:block" id="FIL<%=i%>" >
            <td width="1%">
                <input type="checkbox" id="DEL<%=I%>" name="DEL<%=I%>" value="1"  style="display:none" /></td>
            <td width="6%"> 
                <input type="text" id="AVI<%=i%>" name="AVI<%=i%>" value="<%=rs2("AVI")%>"  class="DATOSKHAKI" 
                onDblClick="hlp('help/hlpfamAVI.asp?ubi=<%=i%>')" onchange="bake(3,this.value,'<%=i %>')"  /></td>
            <td width="25%">
                <textarea id="DES<%=i%>" name="DES<%=i%>" readonly rows="2" class="estilotextarea4" ><%=rs2("DES")%></TEXTAREA></td>
            
            <td width="3%"> 
                <input type="text" id="UNI<%=i%>" name="UNI<%=i%>" value="<%=TRIM(rs2("UNI"))%>" class="DATOSKHAKI" ondblclick="hlp('help/hlpuni.asp?ubi=<%=i%>')" /></td>
            <td width="3%">
                <input type="text" id="TPP<%=i%>" name="TPP<%=i%>" value="<%=TRIM(rs2("TPP"))%>" class="DATOSKHAKI" ondblclick="hlp('help/hlptipAVI.asp?ubi=<%=i%>')" /></td>
            <td width="5%">
                <input type="text" id="DTP<%=i%>" name="DTP<%=i%>" value="<%=TRIM(rs2("DTP"))%>" class="barras" readonly tabindex="-1"  /></td>
            <td width="3%">
                <input type="text" id="EXX<%=i%>" name="EXX<%=i%>" value="<%=TRIM(rs2("EXX"))%>" class="DATOSKHAKI" ondblclick="hlp('help/hlptipexp.asp?ubi=<%=i%>')"/></td>
            <td width="8%">
                <input type="text" id="DEX<%=i%>" name="DEX<%=i%>" value="<%=TRIM(rs2("DEX"))%>" class="barras" readonly tabindex="-1" /></td>
            <td width="1%">
                <input type="text" id="CON<%=i%>" name="CON<%=i%>" value="<%=formatnumber(TRIM(rs2("CON")),3,,tue)%>" class="TEXTOminibb"  
                        onBlur="this.value=toInt(this.value);TOTAL('<%=i%>')"  style="text-align:right; padding-right:5px;" style="background-color:#fff5d7;"/> </td>
            <td width="3%">
                <input type="text" id="MRR<%=i%>" name="MRR<%=i%>" value="<%=TRIM(rs2("MRR"))%>" class="TEXTOminibb" maxlength="2" 
                    onBlur="this.value=toInt(this.value);TOTAL('<%=i%>')"  style="text-align:right; padding-right:5px;" style="background-color:#fff5d7;"/></td>
            <td width="6%">
                <input type="text" id="TTO<%=i%>" name="TTO<%=i%>" value="<%=formatnumber(TRIM(rs2("TTo")),3,,true)%>" class="barras" 
                    readonly tabindex="-1" style="text-align:right; padding-right:5px;" /></td>
<td width="30%">
                <textarea id="Textarea2" name="OBS<%=i%>" rows="2" class="ADICIONALFIJO"
                 onKeyPress="return imposeMaxLength(this, longi);" style="background-color:#fff5d7;"><%=rs2("obs")%></TEXTAREA></td>
                 <td style="display:none;"><input type="text" id="costo<%=i%>" name ="costo<%=i%>" value ="<%=rs2("cto")%>" /></td>
    </tr>    
		<%RS2.MOVENEXT%>
        <%I = I+1%>
	<%LOOP%>
    <%maxi = I%>
    <%mai = I%>

    <%for i=maxi to maxi+15%>   
    <tr valign="middle" bgcolor="<%=(Application("color2"))%>" style="display:none" id="FIL<%=i%>" >
            <td width="1%">
                <input type="checkbox" id="DEL<%=I%>" name="DEL<%=I%>" value="1"  onclick="dell('<%=i%>')" /></td>
            <td width="6%">
                <input type="text" id="AVI<%=i%>" name="AVI<%=i%>"  class="DATOSKHAKI" ondblclick="hlp('help/hlpfamAVI.asp?ubi=<%=i%>')" 
                onFocus="next('<%=I%>')"  onchange="bake(3,this.value,'<%=i %>')"  /></td>
            <td width="25%">
                <textarea id="DES<%=i%>" name="DES<%=i%>" readonly rows="2" class="estilotextarea4"></TEXTAREA></td>
           
            <td width="3%">
                <input type="text" id="UNI<%=i%>" name="UNI<%=i%>" class="DATOSKHAKI" ondblclick="hlp('help/hlpuni.asp?ubi=<%=i%>')" /></td>
            <td width="3%">
                <input type="text" id="TPP<%=i%>" name="TPP<%=i%>" class="DATOSKHAKI"  ondblclick="hlp('help/hlptipAVI.asp?ubi=<%=i%>')" /></td>
            <td width="3%">
                <input type="text" id="DTP<%=i%>" name="DTP<%=i%>" class="barras" readonly tabindex="-1"  /></td>
            <td width="3%">
                <input type="text" id="EXX<%=i%>" name="EXX<%=i%>" class="DATOSKHAKI" ondblclick="hlp('help/hlptipexp.asp?ubi=<%=i%>')" /></td>
            <td width="3%">
                <input type="text" id="DEX<%=i%>" name="DEX<%=i%>" class="barras" readonly tabindex="-1" /></td>
            <td width="1%">
                <input type="text" id="CON<%=i%>" name="CON<%=i%>" class="TEXTOminibb"  onBlur="this.value=toInt(this.value);TOTAL('<%=i%>')" 
                style="background-color:#fff5d7;text-align:right;padding-right:5px;"/> </td>
            <td width="3%">
                <input type="text" id="MRR<%=i%>" name="MRR<%=i%>" class="TEXTOminibb" maxlength="2" onBlur="this.value=toInt(this.value); TOTAL('<%=i%>')" 
                style="background-color:#fff5d7;text-align:right;padding-right:5px;" /></td>
            <td width="6%"><input type="text" id="TTO<%=i%>" name="TTO<%=i%>"  class="barras" readonly tabindex="-1" /></td>
             <td width="30%">
                <textarea id="OBS<%=i%>" name="OBS<%=i%>" rows="2" class="ADICIONALFIJO" onKeyPress="return imposeMaxLength(this, longi);" 
                style="background-color:#fff5d7;"></TEXTAREA></td>
<td style="display:none;"><input type="text" id="costo<%=i%>" name ="costo<%=i%>" value ="0" onclick="return costo<%=i%>_onclick()" /></td>
    </tr>    
    <%next%>
    <%maxi = I%>
    
</table>

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle" bgcolor="#f7d975" >
		<td bgcolor="#f7d975" width="50%" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>T I E M P O S :</b></font>
		</td>	
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O M E N T A R I O S :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
<tr bgcolor="<%=application("barra") %>" align="center">
    <td class="titulito" width="10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td class="titulito" width="10%">CORTE</td>
    <td class="titulito" width="10%">COSTURA</td>
    <td class="titulito" width="10%">ACABADOS</td>
    <td class="titulito" width="10%">ADICIONALES</td>
    <td width="50%" rowspan="5" bgcolor="<%=application("color2") %>"><textarea id="OBSERVA" name="OBSERVA" rows="2" class="TIT" ><%=OBS%></textarea></td>
</tr>
<tr>    
    <td class="titulito" bgcolor="<%=application("barra") %>">Minutos</td>
    <td class="titulito"><input id="MINCOR" name="MINCOR" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("mcor")%>" style="background-color:#fff5d7;"/></td>
    <td class="titulito"><input id="MINCOS" name="MINCOS" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("mcos")%>" style="background-color:#fff5d7;"/> </td>
    <td class="titulito"><input id="MINACA" name="MINACA" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("maca")%>" style="background-color:#fff5d7;"/></td>
    <td class="titulito"><input id="MINADI" name="MINADI" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("madi")%>" style="background-color:#fff5d7;" /></td>
</tr>
<tr>    
    <td class="titulito" bgcolor="<%=application("barra") %>">% Eficiencia</td>
    <td class="titulito"><input id="EFICOR" name="EFICOR" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("ecor")%>" style="background-color:#fff5d7;"/></td>
    <td class="titulito"><input id="EFICOS" name="EFICOS" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("ecos")%>" style="background-color:#fff5d7;"/></td>
    <td class="titulito"><input id="EFIACA" name="EFIACA" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("eaca")%>" style="background-color:#fff5d7;"/></td>
    <td class="titulito"><input id="EFIADI" name="EFIADI" class="TEXTOminibbDER" onchange="this.value=toInt(this.value); minutos()" value="<%=rs("eadi")%>" style="background-color:#fff5d7;"/></td>
</tr>
<tr bgcolor="<%=application("barra") %>">    
    <td class="titulito" bgcolor="<%=application("barra") %>">Minutos Totales</td>
    <td class="titulito"><input id="TOTCOR" name="TOTCOR" class="DESCnegroder" readonly tabindex="-1" /></td>
    <td class="titulito"><input id="TOTCOS" name="TOTCOS" class="DESCnegroder" readonly tabindex="-1" /></td>
    <td class="titulito"><input id="TOTACA" name="TOTACA" class="DESCnegroder" readonly tabindex="-1" /></td>
    <td class="titulito"><input id="TOTADI" name="TOTADI" class="DESCnegroder" readonly tabindex="-1" /></td>
</tr>
<tr bgcolor="<%=application("barra") %>">    
    <td class="titulito" bgcolor="<%=application("barra") %>">Desc. Adicionales:</td>
    <td class="titulito" colspan="4"><input id="DESADI" name="DESADI" class="TEXTOminibb" value="<%=rs("desadi")%>" maxlength="200" style="background-color:#fff5d7; width:100%;"/></td>
</tr>    
</table>
<table align="center" border="0" cellpadding="10" id="botones"> 
    <tr>
        <td id="grab"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba()" src="imagenes/disk.gif" /></td>

    </tr>
</table>

<script type="text/jscript" language="jscript">

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;
var longi = 200	
minutos()	

//tope es el maximo de lineas a mostrar para telas (5 en blanco adicionales a las ya grabadas)
tope = parseInt('<%=tope%>',10)-1

// maxi - tope es el número de líneas de avios
maxi = parseInt('<%=maxi%>',10)-1
// debe ser 1 y es de la primera linea de telas a ingresar TELA0 es la tela principal del proto y NO
// se puede editar
tpp = parseInt('<%=tpp%>',10)
// mai es el número en donde inician los avios....
mai = parseInt('<%=mai%>',10)
document.all.DELE0.disabled = true
document.all.TEL0.readonly = true
document.all.TEL0.className='barras'
document.all.TEL0.tabIndex=-1

// siempre se debe mostrar un linea en blanco adicional a la primera que es INVIOLABLE
// y pertenece a la tela principal seleccionada en la cabecera del proto
eval("document.all.FILA"+tpp+".style.display='block'")
eval("document.all.FIL"+mai+".style.display='block'")


function next(op)
{   op = parseInt(op,10)
if (op<maxi)
  eval("document.all.FIL"+(op+1)+".style.display='block'")
}
function SIGUIENTE(op)
{ op = parseInt(op,10)
    // revisa que los datos de la fila anterior estén completos para calcular el valor final
    kko = parseFloat(eval("document.all.LAR"+parseInt(op,10)+".value"))+ parseFloat(eval("document.all.PM2"+parseInt(op,10)+".value"))+ parseFloat(eval("document.all.ANC"+parseInt(op,10)+".value"))
    if (isNaN(kko) == false)
     rend(op)
  kko = parseFloat(eval("document.all.CUN"+parseInt(op,10)+".value"))+ parseFloat(eval("document.all.MER"+parseInt(op,10)+".value"))+ parseFloat(eval("document.all.PZA"+parseInt(op,10)+".value"))+  parseFloat(eval("document.all.FAC"+parseInt(op,10)+".value"))
    if (isNaN(kko) == false)   
        TOTA(op)
  // muestra la SIGUIENTE LINEA EN BLANCO
  if (op<tope)
  eval("document.all.FILA"+(op+1)+".style.display='block'")
}

function minutos()
{   document.all.MINCOR.value = (document.all.MINCOR.value)
    document.all.MINCOS.value = (document.all.MINCOS.value)
    document.all.MINACA.value = (document.all.MINACA.value)
    document.all.MINADI.value = (document.all.MINADI.value)
    document.all.EFICOR.value = (document.all.EFICOR.value)
    document.all.EFICOS.value = (document.all.EFICOS.value)
    document.all.EFIACA.value = (document.all.EFIACA.value)
    document.all.EFIADI.value = (document.all.EFIADI.value)
    
    document.all.TOTCOR.value = toInt((document.all.MINCOR.value*100/document.all.EFICOR.value))
    document.all.TOTCOS.value = toInt((document.all.MINCOS.value*100/document.all.EFICOS.value))
    document.all.TOTACA.value = toInt((document.all.MINACA.value*100/document.all.EFIACA.value))
    document.all.TOTADI.value = toInt((document.all.MINADI.value*100/document.all.EFIADI.value))
}

function TOTA(op) { 
op = parseInt(op,10)
AAA = trim(eval("document.all.TEL"+op+".value"))
    if (AAA.length == 0)
    {   alert("Datos de INCOMPLETOS.... \nFavor ingresar por lo menos el código")
        return false;
    }

    kko = parseFloat(eval("document.all.CUN" + op + ".value")) + parseFloat(eval("document.all.MER" + op + ".value")) + parseFloat(eval("document.all.PZA" + op + ".value")) + parseFloat(eval("document.all.FAC" + op + ".value"))

    if (isNaN(kko) == false) {
        kgs = parseFloat(eval("document.all.CUN" + op + ".value"))
        lar = parseFloat(eval("document.all.LAR" + op + ".value"))
        anc = parseFloat(eval("document.all.ANC" + op + ".value"))
        pm2 = parseFloat(eval("document.all.PM2" + op + ".value"))
        mer = parseFloat(eval("document.all.MER"+op+".value"))
        pza = parseInt(eval("document.all.PZA"+op+".value"),10)
        fac = parseFloat(eval("document.all.FAC" + op + ".value"))
        cun = lar * anc * pm2
        cun = cun/pza
        cun = cun * fac
        cal = (cun*100)/(100-mer)
        eval("document.all.TOT" + op + ".value=(cal)")
        eval("document.all.CUN" + op + ".value=(cun)")
     }
     else
        eval("document.all.TOT"+op+".value=''")
return true;        
}
function veri()
{ if(event.keyCode==13)
    llena()
}
function hlp(cad)
{  window.open(cad,'',opc)
}	
function help(cad, pos, hh)
{   if(isNaN(pos)== false)
    {   tel = eval("document.all.TEL"+parseInt(pos)+".value")
        if (trim(hh)== 'ruta')
            cad += trim(tel) + '&ubi='+pos
        else
            cad += '&pos='+trim(tel) + '&ubi='+pos
    }  
  //  alert(cad)  
        window.open(cad,'',opc)
}
function imposeMaxLength(obj, MaxLen)
{
  return (obj.value.length < MaxLen);
}
function rend(op)
{   mts = parseFloat(eval("document.all.LAR"+parseInt(op,10)+".value"))
    pm2 = parseFloat(eval("document.all.PM2"+parseInt(op,10)+".value"))
    anc = parseFloat(eval("document.all.ANC" + parseInt(op, 10) + ".value"))
    if (isNaN(anc) && trim(eval("document.all.TEL" + parseInt(op, 10) + ".value"))!=''  ) {
        alert("No se puede calcular el rendimiento sin tener el dato del ancho")
        return false;
        }
    if (eval("document.all.TIP"+parseInt(op,10)+".value")== 'T')
    {   kgs = mts / (500/(anc*pm2))
    }
    else
    {   kgs = mts / (1000/(anc*pm2))
    }
    if (isNaN(kgs)== true)
        eval("window.document.all.CUN"+parseInt(op,10)+".value=''")
    else
        eval("window.document.all.CUN"+parseInt(op,10)+".value=toInt(deci(kgs,3))")

}
function dele(op)
{   op =parseInt(op,10)
   if(op > 0)

    eval("document.all.DELE"+op+".value=0")
    eval("document.all.TEL"+op+".value=''")
    eval("document.all.DTE"+op+".value=''")
    eval("document.all.RUT"+op+".value=''")
    eval("document.all.COM"+op+".value=''")
    eval("document.all.LAR"+op+".value=''")
    eval("document.all.ANC"+op+".value=''")
    eval("document.all.PM2"+op+".value=''")
    eval("document.all.TIP"+op+".value=''")
    eval("document.all.PZA"+op+".value=''")
    eval("document.all.FAC"+op+".value=''")
    eval("document.all.CUN"+op+".value=''")
    eval("document.all.MER"+op+".value=''")
    eval("document.all.TOT"+op+".value=''")    
    eval("document.all.FILA"+op+".style.display='none'")
    if (op<tope)
        SIGUIENTE(op+1)
}
function TOTAL(op) {	
    op = parseInt(op,10)
    AAA = trim(eval("document.all.AVI"+op+".value"))
    if (AAA.length == 0)
    {   alert("Datos de INCOMPLETOS.... \nFavor ingresar por lo menos el código")
        return false;
    }
    eval("document.all.TTO"+op+".value=''")  
    con = parseFloat(eval("document.all.CON"+op+".value"))
    mer = parseFloat(eval("document.all.MRR"+op+".value"))
if (isNaN(con) == false && isNaN(mer) == false)   
    {   cal = ((con*100)/(100-mer))
        eval("document.all.TTO"+op+".value=deci(cal,3)")
     }
     else
        eval("document.all.TTO"+parseInt(op,10)+".value=''")

return true
	}
function dell(op)	
{	 op =parseInt(op,10)
   if(op > 0)
    eval("document.all.DEL"+op+".value=0")
    eval("document.all.AVI"+op+".value=''")
    eval("document.all.DES"+op+".value=''")
    eval("document.all.OBS"+op+".value=''")
    eval("document.all.UNI"+op+".value=''")
    eval("document.all.TPP"+op+".value=''")
    eval("document.all.DTP"+op+".value=''")
    eval("document.all.EXX"+op+".value=''")
    eval("document.all.DEX"+op+".value=''")
    eval("document.all.CON"+op+".value=''")
    eval("document.all.MRR"+op+".value=''")
    eval("document.all.TTO"+op+".value=''")
    eval("document.all.FIL"+op+".style.display='none'")
    if (op<tope)
        next(op+1)
 return true
	}
function graba()
{ dat = document.all.CLI.value;
// datos MINIMOS de cabecera
if (trim(document.all.EST.value)=='')
    {   alert("Por favor seleccionar el estilo");
        help('DETAESTILO.asp?POS='+dat+'&HLP=1');
        return false;
    }
if (trim(document.all.TEM.value)=='')
    {   alert("Por favor seleccionar la Temporada");
        help('HELP/HLPTEMPO.asp?POS='+dat);
        return false;
    }
if (trim(document.all.TELA.value)=='')
    {   alert("Por favor seleccionar la Tela Principal");
        help('help/hlpfamtelas.asp?HLP=1');
        return false;
    }    
if (trim(document.all.T0.value)=='')
    {   alert("Por favor seleccionar por lo menos una Talla") ;     
        help('HELP/HLPTALLAS.asp?POS='+dat+'&maxi=14'); 
        return false;
    }
    
for (t=0;t<=tope;t++)
{   // REVISA TELAS
    if (eval("document.all.FILA"+t+".style.display")=='block')
    {   if (trim(eval("document.all.TOT"+t+".value"))!='' && trim(eval("document.all.TEL"+t+".value"))== '')
        {   alert("Ingrese los datos completos de TELA");
            eval("document.all.TEL"+t+".focus()");
            return false;
        }
        if (trim(eval("document.all.CUN" + t + ".value")) != '' && trim(eval("document.all.MER" + t + ".value")) == '') {
            eval("document.all.MER" + t + ".value='0'")
        }
    }
    ww = toInt(eval("document.all.TOT" + t + ".value"))
    ss = toInt(eval("document.all.CUN" + t + ".value"))
    eval("document.all.TOT" + t + ".value=ww")
    eval("document.all.CUN" + t + ".value=ss")
    
}

for (tt=t;tt<maxi;tt++)
{   // REVISA AVIOS
    if (eval("document.all.FIL"+tt+".style.display")=='block')
    {   if ( (trim(eval("document.all.TTO"+tt+".value"))!='' && trim(eval("document.all.AVI"+tt+".value"))== ''))
        {   alert("Ingrese los datos completos de AVIO");
            eval("document.all.AVI"+tt+".focus()");
            return false;
        }
        if (trim(eval("document.all.AVI" + tt + ".value")) != '' && trim(eval("document.all.MRR" + tt + ".value")) == '') {
            eval("document.all.MRR" + tt + ".value='0'")
            TOTAL(tt)
            graba()
        }
        if (trim(eval("document.all.AVI" + tt + ".value")) != '' && trim(eval("document.all.CON" + tt + ".value")) == '') {
            eval("document.all.CON" + tt + ".value='1'")
            TOTAL(tt)
            graba()
        }
    }
}

thisForm.action='comun/inserFichaajuste.asp?telm='+tope+'&avim='+maxi
//alert()
thisForm.submit()


}

function cotiza() {
/*    EDITA = trim('<%=RS("COTI")%>')
    if (EDITA.length > 0)
     window.location.replace('fichaproto.asp?cli=<%=cli%>&pro=<%=pro%>&ver=<%=ver%>')
     */
}
function bake(opc, cod, op) {
    // opc = opcion de pagina a llamar
    // cod = codigo a buscar
    // op  = numero de linea donde se muestran los datos
    opc = parseInt(opc, 10)
    op = parseInt(op, 10)

    //alert(opc)
    if (opc == 1) 
        cad = 'bake/proto_telas.asp?pos=' + trim(cod)
    if (opc == 2)
        cad = 'bake/proto_telas_lista.asp?pos=' + trim(cod) + '&op=' + op
    if (opc == 3)
        cad = 'bake/proto_avios_lista.asp?pos=' + trim(cod) + '&op=' + op
   // document.all.body0.style.display = 'block'
    document.all.body0.src = cad

}

</script>

	<%	RS.Close  
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>