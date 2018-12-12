<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID = 2057 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
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
Dim aCod  
aCod = Array()
Dim aDes 
aDes= Array()%>

<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHACCT.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:hand;" onClick="window.close()" /></td>		
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
	     <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
	     <input id="COD" name="COD" value="<%IF MARKA = 1 THEN RESPONSE.WRITE(rs("CCT")) %>" style="display:none;"/></td>
    </tr>
</table>  

<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>G E N E R A L E S :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
  <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%" colspan="2" class="TITULITO"># CCT:</td>
        <td align="left" colspan="2" width="2%"><input type="text" id="CCT" name="CCT" value=
	        "<%=rs("cct")%>" tabindex="-1" readonly="readonly" class="BARRA3" style="width:100%" />    </td>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO">Tela RS:</td>
        <td align="left" colspan="1" width="5%"><input type="text" id="RTEL" name="RTEL" value="<%=rs("RTEL")%>" 
	        tabindex="-1" readonly="readonly" class="BARRA3" style="width:100%" />    </td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="7">
            <input type="text" id="RDES" name="RDES" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=trim(rs("RDES"))%>" /></td>   
	</tr>
    <tr valign="middle">       
	    <td bgcolor="<%=(Application("BARRA"))%>" width="2%" colspan="2" class="TITULITO"> Partida:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%" colspan="2">
            <input type="text" id="PAR" name="PAR" maxlength="15" class="DATOS" onChange="llena()" value="<%=trim(rs("PAR"))%>"  /></td>
	    <td bgcolor="<%=(Application("BARRA"))%>" width="2%" class="TITULITO">Proveedor:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%">
            <input type="text" id="RUC" name="RUC" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=trim(rs("RUC"))%>" /></td>         
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" colspan="7">
        <input type="text" id="PROV" name="PROV" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=trim(rs("PROV"))%>" /></td>    
	</tr> 
    <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%"  class="TITULITO"> Tela TPFS:</td>
	    <td width="1%" colspan="1"  bgcolor="<%=(Application("BARRA"))%>"><%if TRIM(RS("TEL"))= "" then%><img src="imagenes/help.gif" border="0" onClick="help('help/hlpfamtelas.asp')" alt=""/><%else%>&nbsp;<%end if %></td>
        <td align="left" colspan="2" width="5%"><input type="text" id="TEL" name="TEL" 
            value="<%=TRIM(RS("TEL"))%>" class="BARRA3" style="width:100%" <%if TRIM(RS("TEL"))<> "" then%> 
            tabindex=-1 readonly <%end if %> maxlength="6" onchange="bake()"/>    </td>	
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" colspan="5">
            <input type="text" id="DES" name="DES" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=trim(rs("des"))%>" /></td> 
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">O/C #:</td>
        <td align="left"  width="5%" colspan="2"><input type="text" id="OC" name="OC" value="<%=rs("OC")%>" 
	        readonly="readonly"  tabindex=-1 class="BARRA3" style="width:100%" /></td>	       
    </tr>
    <tr>        
	   <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Cliente:</td>
       <td align="left" colspan="2" width="3%"><input type="text" id="CLI" name="CLI" value="<%=TRIM(rs("CLI"))%>" tabindex="-1" readonly="readonly" class="BARRA3"  />    </td>
	   <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="5">
             <select id="DESCLI" style="width:100%" name="DESCLI" class="datos" <%if TRIM(RS("CLI")) <> "" thEN %>DISABLED<%END IF %> onChange="colores()">
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
            <script type="text/jscript" language="jscript">
                var subcadena =  trim('<%=rs("CLI")%>') ;
			    var elemento = thisForm.DESCLI ;
			    thisForm.DESCLI.selectedIndex = seleindice(subcadena,elemento);
            </script>
        </td>          
        <td bgcolor="<%=(Application("BARRA"))%>" width="10%" class="TITULITO" colspan="2">OFI #:</td>
    	<td align="left"  bgcolor="<%=(Application("color2"))%>"  width="1%" colspan="2">
            <input type="text" id="OFI" name="OFI" maxlength="10" class="BARRA3" value="<%=trim(rs("OFI"))%>" /></td> 
    </tr>	
    <tr>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Color:</td>
        <td align="left" colspan="1" width="3%"><input type="text" id="COL" name="COL" value="<%=TRIM(Rs("COL"))%>" 
	       tabindex="-1" readonly="readonly" class="BARRA3" style="width:100%" /></td>	
	    <td align="left" colspan="1" width="1%"><input type="text" id="COM" name="COM" value="<%=TRIM(Rs("COM"))%>" 
	       tabindex="-1" readonly="readonly" class="BARRA3" style="width:100%" /></td>	      
	     <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="5">
            <select id="DESCOL" name="DESCOL" class="datos" value="<%if TRIM(RS("COL")) <> "" then%>disabled<%end if%>" onChange="cambiacol(this)" />
                <option><%=TRIM(RS("DESCOL")) %></option>
	        </select>
	     </td>                 
    	 <td bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO">Fecha:</td>
    	 <td width="1%" align="center"><A href="javascript:showCal('Calendar1')"><img height="16" src="imagenes/cal.gif" width="16" border="0"></A></td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="1%" colspan="2">
            <input type="text" id="FEC" name="FEC" maxlength="15" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=trim(rs("FEC"))%>" /></td> 
    </tr>  
    <tr>
	    <td bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO" colspan="2">Tipo Inspeccion:</td>
	     <td align="left" width="5%" colspan="2"><select id="TIP" name="TIP" class="barra3" onchange="ancho()">
	         <option></option>
	         <option value="A">ABIERTO</option>
	         <option value="T">TUBULAR</option>
	     </select>
	      <script type="text/jscript" language="jscript">
                var subcadena =  trim('<%=rs("TIP")%>') ;
			    var elemento = thisForm.TIP ;
			    thisForm.TIP.selectedIndex = seleindice(subcadena,elemento);
            </script>
	     </td>	  
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="4%" class="TITULITO">Peso (KGS):</td>
        <td align="left" width="1%"><input type="text" id="KGS" name="KGS" value="<%=FORMATNUMBER(rs("KGS"),3,,,-1)%>" readonly class="BARRA3"  /></td>	 	   
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" class="TITULITO">Rollos Total:</td>
        <td align="left" width="5%"><input type="text" id="RLL" name="RLL" value="<%=rs("RLL")%>" readonly class="BARRA3" style="width:100%" /></td>	 
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" class="TITULITO">Rollos a Inspeccionar:</td>
        <td align="left" width="2%"><input type="text" id="RLL2" name="RLL2" value="<%=rs("RLL2")%>" class="BARRA3" style="width:100%"  onchange="creatabla(this)"/></td>	     
	    <td bgcolor="<%=(Application("BARRA"))%>" width="1%" class="TITULITO">% Auditado:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%">
            <input type="text" id="AUD" name="AUD" maxlength="15" class="BARRA3" readonly="readonly" tabindex="-1" value="<%=formatnumber(trim(rs("AUD")),2,,,true)%>" /></td>         </tr>                   
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
<tr>
<td colspan="8">
    <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	    <tr valign="middle">
		    <td bgcolor="#f7d975"><font size="1" color="#000066" face="Arial"><b>E S T A B I L I D A D &nbsp;&nbsp;&nbsp;D E&nbsp;&nbsp;&nbsp;T E L A</b></font></td>
	    </tr>
    </table>
</td>
<td colspan="3">
     <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	    <tr valign="middle">
		    <td bgcolor="#f7d975" width="70%"><font size="1" color="#000066" face="Arial"><b>A N C H O</b></font></td>	
	    </tr>
    </table>
</td>
<td colspan="3">
     <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	    <tr valign="middle">
		    <td bgcolor="#f7d975" width="70%"><font size="1" color="#000066" face="Arial"><b>A P R O B A C I O N E S</b></font></td>	
	    </tr>
    </table>
</td>
</tr>
<tr>
	<td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito" colspan="2">REQUERIDO</td>   
	<td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito" colspan="1">&nbsp;</td> 
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">ANTES</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">DESPUES</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">% VAPOR</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">LAVADO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">% LAVADO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">REQUERIDA</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">OBTENIDA</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">VAPORIZADA</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">TONO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">DEGRADE</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">TACTO</td>
</tr>
<tr>
  <td bgcolor="<%=(Application("BARRA"))%>" class="titulito" rowspan="2">VAPOR</td>
   <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" width="1%">
   <input id="ELL1" value="<%=rs("ELL1") %>" class="DESCRIPTORCENTERnavy" readonly tabindex=-1/> </td>
    <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">L</td>
    <td align="center"><input  id="VLA" name="VLA" onBlur="NUMEROS(this); cal1(this,document.all.VLD,CAL1);" class="datos" value="<%=rs("VLA")%>"></td>
    <td align="center"><input id="VLD" name="VLD" class="datos" onBlur="NUMEROS(this); cal1(document.all.VLA,this,document.all.CAL1);"  value="<%=rs("VLD")%>"></td>
  <td align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL1"><%IF RS("VLA")> 0 AND RS("VLD") > 0 THEN  
    RESPONSE.WRITE(formatnumber(((rs("VLA")-rs("VLD"))/rs("VLA")*100),2,,true))
    end if%></td>
    <td align="center"><input  id="VLL" name="VLL" onBlur="NUMEROS(this); cal1(document.all.VLA,this,document.all.CAL2);" class="datos" 
        value="<%=rs("VLL")%>"></td>
    <td align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL2"><%If rs("vll") > 0 and rs("vla")>0 then 
    RESPONSE.WRITE(formatnumber(((rs("VLA")-rs("VLD"))/rs("VLA")*100),2,,true))
    end if%></td>
    
    <td align="center"  bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS">
    <input id="AT" value="<%=rs("at")%>" style="display:none" readonly class="DESCRIPTORCENTERnavy" tabindex=-1  />
    <input id="AA" value="<%=rs("AA")%>" style="display:none" readonly class="DESCRIPTORCENTERnavy" tabindex=-1  />
    </td>
    <td align="center"><input id="AO" name="AO" class="datos" onBlur="NUMEROS(this)" 
        value="<%=rs("AO")%>"></td>
    <td align="center" ><input id="AV" name="AV" class="datos" onBlur="NUMEROS(this)" 
        value="<%=rs("AV")%>"></td> 
         <td align="center"><input  id="TON" name="TON"class="datos" type="checkbox"  <%if rs("ton")= "1" then%> checked <%end if%>
        value="<%=rs("TON")%>"></td>
                 <td align="center"><input  id="DEG" name="DEG"  class="datos"  type="checkbox" <%if rs("deg")= "1" then%> checked <%end if%>
        value="<%=rs("DEG")%>"></td>
                 <td align="center"><input  id="TAC" name="TAC" class="datos"  type="checkbox" <%if rs("tac")= "1" then%> checked <%end if%>
        value="<%=rs("TAC")%>"></td>
</tr>
<tr>
     <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS">
     <input id="EAL1" value="<%=rs("eal1")%>" class="DESCRIPTORCENTERnavy" readonly tabindex=-1 /></td> 
     <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">A</td>
     <td align="center"><input  id="VAA" name="VAA" onBlur="NUMEROS(this); cal1(this,document.all.VAD,document.all.CAL3);" class="datos" 
        value="<%=rs("VAA")%>"></td>
    <td  align="center"><input id="VAD" name="VAD" class="datos" onBlur="NUMEROS(this); cal1(document.all.VAA,this,document.all.CAL3);" 
        value="<%=rs("VAD")%>"></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL3"><%If rs("vaa") > 0 and rs("vad")>0 then  RESPONSE.WRITE(formatnumber(((rs("VaA")-rs("Vad"))/rs("Vaa")*100),2,,true))%></td>
    <td align="center"><input  id="VAL" name="VAL" onBlur="NUMEROS(this); cal1(document.all.VAA,this,document.all.CAL4);" class="datos" 
        value="<%=rs("VAL")%>"></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL4"><%If rs("vaa") > 0 and rs("val")>0 then RESPONSE.WRITE(formatnumber(((rs("VaA")-rs("Val"))/rs("Vaa")*100),2,,true))%></td>
<td colspan="3">
     <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	    <tr valign="middle">
		    <td bgcolor="#f7d975" width="70%"><font size="1" color="#000066" face="Arial"><b>D E N S I D A D</b></font></td>	
	    </tr>
    </table>
</td>    <td>&nbsp;</td>
<td bgcolor="<%=(Application("BARRA"))%>" align="center" class="titulito">REPROCESO</td>
<td align="center"><input  id="REP" name="REP" class="datos"  type="checkbox" value="<%=rs("REP")%>" <%if rs("rep")= "1" then%> checked <%end if%>></td> 
</tr>
<tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="titulito" rowspan="2">LAVADO</td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS"><%="&nbsp;"%></td> 
    <td align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">F</td>
    <td align="center"><input  id="LFA" name="LFA" onBlur="NUMEROS(this); cal1(this,document.all.LFD,document.all.CAL5);" class="datos" 
        value="<%=rs("LFA")%>"></td>
    <td  align="center"><input id="LFD" name="LFD" class="datos" onBlur="NUMEROS(this); cal1(document.all.LFA,this,document.all.CAL5);" 
        value="<%=rs("LFD")%>"></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL5"><%If rs("lfa") > 0 and rs("lfd")>0 then RESPONSE.WRITE(formatnumber(((rs("lfa")-rs("lfd"))/rs("lfa")*100),2,,true))%></td>
    <td align="center"><input  id="LFL" name="LFL" onBlur="NUMEROS(this); cal1(document.all.LFA,this,document.all.CAL6);" class="datos" value="<%=rs("LFL")%>" /></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS" id="CAL6"><%If rs("lfa") > 0 and rs("lfl")>0 then RESPONSE.WRITE(formatnumber(((rs("lfa")-rs("lfl"))/rs("lfa")*100),2,,true))%></td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">REQUERIDO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MINIMO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MAXIMO</td>
     <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MACHING</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">CALIDAD</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">CONDICION</td>
</tr>
<tr> <td bgcolor="<%=(Application("BARRA"))%>"><input id="REV" value="<%=rs("REV")%>" class="DESCRIPTORCENTERnavy" readonly tabindex=-1/></td>  
    <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">R</td>
    <td align="center"><input  id="LRA" name="LRA" onBlur="NUMEROS(this); cal1(this,document.all.LRD,document.all.CAL7);" class="datos" 
            value="<%=rs("LRA")%>"></td>
    <td  align="center"><input id="LRD" name="LRD" class="datos" onBlur="NUMEROS(this); cal1(document.all.LRA,this,document.all.CAL7);" 
        value="<%=rs("LRD")%>"></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS"><INPUT id="CAL7" class="DATOS" value='<%=rs("lpv") %>'></td>
    <td align="center"><input  id="LRL" name="LRL" onBlur="NUMEROS(this); cal1(document.all.LRA,this,document.all.CAL8);" class="datos" 
        value="<%=rs("LRL")%>"></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS"><INPUT id="CAL8" class="DATOS" value='<%=RS("LPL") %>'/></td>    
<td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS">
<input id="DDL" value="<%=rs("DDL")%>" class="DESCRIPTORCENTERnavy" readonly tabindex=-1 /></td>   
        <td align="center"><input  id="DMIN" name="DMIN" onBlur="NUMEROS(this)" class="datos" 
        value="<%=rs("DMIN")%>"></td>
        <td align="center"><input  id="DMAX" name="DMAX" onBlur="NUMEROS(this)" class="datos" 
        value="<%=rs("DMAX")%>"></td>   
        <td align="center"><input  id="MAC" name="MAC" class="datos"  type="checkbox"
        value="<%=rs("MAC")%>" <%if rs("mac")="1" then%> checked <%end if%>></td> 
         <td align="center"><input  id="CAL" name="CAL"  class="datos"  type="checkbox"
        value="<%=rs("CAL")%>" <%if rs("cal")="1" then%> checked <%end if%>></td> 
 <td align="center"><select  id="CON" name="CON" class="datos" >
 	<option></option>
    <option value="A" <%if rs("con")="A" then%> SELECTED <%end if%>>ABIERTO</option>
    <option value="C" <%if rs("con")="C" then%> SELECTED <%end if%>>CERRADO</option>
 </select></td>                
</tr>
</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
    <tr valign="middle">
        <td bgcolor="#f7d975"><font size="1" color="#000066" face="Arial"><b>D E T A L L E &nbsp;&nbsp;&nbsp;D E F E C T O S</b></font></td>
    </tr>
</table>
<table border="1" cellpadding="2" align="center" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
  <tr>
      <% cad =	" SELECT tipodefectos.codigo, tipodefectos.descripcion from tipodefectos " & _
		 	    "  WHERE tipodefectos.estado= 'a' ORDER BY tipodefectos.codigo      "
	     rs2.Open cad,cnn
    	
	    'response.Write(cad)
	    IF rs2.recordcount> 0 THEN
		    rs2.movefirst
	    ELSE%>
	    <td class="talasrojo">NO TENEMOS TIPOS DE DEFECTOS DEFINIDOS<br />  
	        AVISAR A PLANEAMIENTO<br />
	        NO PUEDE CONTINUAR
	        <%Response.END%>
	    </td>	
    <%	END IF%>
    <%	ATIPO = ARRAY()
        numdefe = rs.recordcount
  	    CONT = 0%>
    <%	DO WHILE NOT RS2.EOF%>
    	<td bgcolor="<%=(Application("BARRA"))%>"  class="titulito"><%=RS2("DESCRIPCION")%>
		    <%REDIM PRESERVE ATIPO(CONT)
		    ATIPO(UBOUND(ATIPO))= RS2("CODIGO")
		    CONT = CONT +1%>	
		</td>
	<%	RS2.MOVENEXT
	LOOP%>		
<%RS2.CLOSE%>
</tr>
<tr>
    <%cad = " SELECT codigo, descripcion, defectostela.tipo," & _
            " defectostela.ABREVIA FROM DEFECTOSTELA        " & _
		    " WHERE DEFECTOSTELA.estado = 'A'               " & _
		    " ORDER BY tipo, codigo                         " 
    rs2.open cad,cnn
    'response.Write(cad)
    IF rs2.RecordCount > 0 THEN
	    rs2.MoveFirst
	    columnas = rs2.recordcount
    ELSE
	    %>
	    <span class="titulito">NO TENEMOS DE DEFECTOS DEFINIDOS<br />  
		    AVISAR A PLANEAMIENTO<br />
		    NO PUEDE CONTINUAR</span>
	    <%Response.END%>
    <%END IF
    A = 0
    FOR i=0 TO UBOUND(ATIPO)%>
	    <td valign="top" bgcolor="<%=application("color2")%>">
	        <%DO WHILE NOT rs2.eof AND trim(rs2("tipo")) = trim(atipo(i))%>
	        <table cellpadding="2"  cellspacing="1" bgcolor="<%=application("color2")%>" border="0" >
		      <tr>
			      <td bgcolor="<%=application("color2") %>" width="90%" class="TEXTOAZULPOS">
				     <%=trim(rs2("descripcion"))%>
			      </td>
			      <td bgcolor="<%=application("color2") %>" align="center" width="10%">
				    <input type=checkbox onclick="CHECKEADOS(this)" id="Dd<%=TRIM(rs2("CODIGO"))%>" name="Dd<%=TRIM(rs2("CODIGO"))%>" />
			      </td>
		      </tr>
	        </table>
	            <%redim Preserve Acod(a)
	            aCod(a) = rs2("codigo")
	            redim preserve aDEs(a)
	            aDes(a) = rs2("ABREVIA")
	            a = a + 1
	            rs2.movenext
	            IF rs2.EOF THEN
		            EXIT DO
	            END IF
	        LOOP%>
	    </td>
    <%NEXT%>	
</tr>
</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
    <tr valign="middle">
        <td bgcolor="#f7d975"><font size="1" color="#000066" face="Arial"><b>R O L L O S&nbsp;&nbsp;&nbsp;A &nbsp;&nbsp;&nbsp;
        I N S P E C C I O N A R</b></font></td>
    </tr>
</table>
<center>
<table border="1" cellpadding="2" cellspacing="0" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>" ALIGN="center">
<%rll=1%>
 <%if rs("cct")<> "AUTO" then 
            CAD =   " select d2.tipo, defecto from cctdefectos              " & _
                    " INNER JOIN  defectostela as d2 on d2.codigo = defecto " & _
                    " inner join TIPODEFECTOS as t1 ON t1.CODIGO = d2.tipo  " & _
                    " where cct = '"&cod&"' group by d2.tipo, defecto       " & _
                    " ORDER BY d2.tipo, DEFECTO                             "     
            rs2.close
            rs2.open cad,cnn
            rs2.movefirst
            addt = Array()
            cb =0
            do while not rs2.eof
                redim preserve addt(cb)
                addt(cb)= rs2("defecto")
                cb = cb + 1
                RS2.MOVENEXT
            loop
      ELSE
          redim preserve addt(cb)   
          addt(cb)=""
      end if              %>
      <tr bgcolor="<%=application("barra")%>"  style="display:block" id="LIN0">
        <td class="textominibb" width="2%">Rll #</td>
        <td class="textominibb"  align="center" >Ancho<br />Mt.</td>
            <%cb=0%>
              <%FOR I=0 TO COLUMNAS-1%>
                <%' las columnas se llaman C+el código del defecto %>
                <td class="textominibb" id="L0C<%=aCod(i)%>"  
                style="<%IF cb <= ubound(addt) and  rs("cct")<> "AUTO"  and aCod(i)=addt(cb)   then%>
                                display:block
                                <%cb = cb + 1
                                if cb > ubound(addt) then cb = 0%>
                       <%else%>
                            display:none
                        <%end if %>" ><%=trim(ades(i))%>
                <input type="text" id="D<%=aCod(i)%>" name="D<%=aCod(i)%>" value="<%=aCod(i)%>" style="display:none"/></td>
              <%NEXT%>
          <td  class="DATOSnormal" >TOT</td>
          <td  class="DATOSnormal" >Observaciones</td>
      </tr>
     
      <%for j=1 to 100%> 
          <tr style=<%if j<=rs("rll2") then%>"dispaly:block"<%else%>"display:none"<%end if %> id="LIN<%=J%>">
              <td class="textominibb"><%=RLL%></td>
              <td><input type="text" value="" class="datos" id="ANCHO<%=j%>" name="ANCHO<%=j%>"  onkeyup="baja('ANCHO<%=j+1%>','<%=j%>', 'LIN<%=J+1%>', 'ANCHO<%=j-1%>')"/></td>
              <%cb = 0 %>
              <%FOR I=0 TO COLUMNAS-1%>
                <td class="textominibb" id="L<%=J%>C<%=aCod(i)%>"  
                
                style="<%IF cb <= ubound(addt) and  rs("cct")<> "AUTO"  and aCod(i)=addt(cb)   then%>
                            display:block
                            <%cb = cb + 1
                            if cb > ubound(addt) then cb = 0%>
                   <%else%>
                        display:none
                    <%end if %>">
                <input type="text" id="R<%=J%>D<%=aCod(i)%>" name="R<%=J%>D<%=aCod(i)%>" class="DATOS" onchange="NUMEROS(this); SUMA('<%=j%>')" 
                onkeyup="baja('R<%=j+1%>D<%=aCod(i)%>','<%=j%>', 'L<%=J+1%>C<%=aCod(i)%>', 'R<%=j-1%>D<%=aCod(i)%>')"/></td>
              <%NEXT%>
              <td ><input type="text" value="" class="DATOS" id="TOT<%=j%>" name="TOT<%=j%>" readonly /></td>
              <td ><input type="text" value="" class="DATOS" id="R<%=j%>OBS" name="R<%=j%>OBS" /></td>
          </tr>
          <%RLL =rll+1 %>
     <%next%>  
</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
    <tr valign="middle">
        <td bgcolor="#f7d975"><font size="1" color="#000066" face="Arial"><b>C O M E N T A R I O S</b></font></td>
    </tr>
</table>
<center>
<table border="1" cellpadding="2" cellspacing="0" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>" width="100%">
<tr align="left">
    <td>
     <div class="box">
        <div class="box2">
        <%cad= "select * from cctobservaciones where cct = '"&cod&"' "
        rs2.close
        rs2.open cad,cnn%>
        <%if rs2.recordcount > 0 then       obb= rs2("OBSERVACIONES") else obb=""%>
          <textarea id="OBS" name="OBS" ><%=obb %></textarea> 
         </div>
    </div>
</td>
</tr>
</table>
<%cad  =    " select c1.rollo, c1.ancho, obs, numdef from cctrollos as c1 " & _
            " where c1.cct = '"&cod&"'  order by  c1.rollo        "
rs2.close
rs2.open cad,cnn
if rs2.recordcount > 0 then
    rs2.movefirst%>
    <%do while not rs2.eof %>
        <script type="text/jscript" language="jscript">
            lin = parseInt('<%=rs2("rollo") %>',10)
            bb = toDeci(parseFloat('<%=rs2("ancho") %>'),2)
            cc = parseInt('<%=rs2("numdef") %>',10)
            dd = '<%=trim(rs2("obs")) %>'
            eval("document.all.ANCHO"+lin+".value=bb")
            eval("document.all.TOT"+lin+".value=cc")
            eval("document.all.R"+lin+"OBS.value=dd")
        </script>    
        <%rs2.movenext%>
    <%loop%>
<%end if %>

<%cad  =    " select rollo, defecto, cant from cctdefectos " & _
            " where cct = '"&cod&"'  order by  rollo        "
rs2.close
rs2.open cad,cnn
if rs2.recordcount > 0 then
    rs2.movefirst%>
    <%do while not rs2.eof %>
        <script type="text/jscript" language="jscript">
            lin = parseInt('<%=rs2("rollo") %>',10)
            def = '<%=trim(rs2("defecto"))%>'
            canti = parseInt('<%=rs2("cant") %>', 10)
            if (canti > 0)
                cc = canti
            else
                cc = ''
            eval("document.all.R"+lin+"D"+def+".value=cc")
        </script>    
        <%rs2.movenext%>
    <%loop%>
<%end if %>



<input type="button" id="boton" value="" style="cursor:hand;" onclick="graba()" />
</center>

<%for q = 0 to ubound(aCod)%>
    <%xx=aCod(q)%>
    <script type="text/jscript" language="jscript">
        s = parseInt('<%=q%>',10)
        aCod[s]= '<%=trim(xx)%>'
    </script>
<%next %>
<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">
addCalendar("Calendar1", "Elija una fecha", "FEC", "thisForm")
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

var marka = parseInt('<%=MARKA%>',10)	
if (marka == 1)
{   var subcadena ='<%=RS("tip")%>' ;
    var elemento = document.all.TIP ;
    document.all.TIP.selectedIndex = seleindice(subcadena,elemento);	
    ancho();  
}

if ('<%=ucase(rs("con"))%>'=="C")
    document.all.boton.style.display='none'


function cal1(a,b,c)
{   if(trim(a.value) != '' && trim(b.value) != '' && a.value >'0' && b.value >'0')
        c.innerText = toDeci((a.value - b.value) / a.value *100,2) 
}
function ancho()
{   if (document.all.TIP.value == 'A')	
    {   document.all.AA.style.display='block';
        document.all.AT.style.display='none';
    }
    else
    {   document.all.AT.style.display='block';
        document.all.AA.style.display='none';
    }
}
function veri()
{ if(event.keyCode==13)
    llena()
}
function baja(op, jj, lin, op2) {

    ln = eval("document.all." + lin)
    obj = eval("document.all."+op)
    j = parseInt(jj, 10) + 1 

    if (j < 100 && ln.style.display=='block' && event.keyCode == 40  )
        // flecha abajo
        obj.focus()
    
   ob2 = eval("document.all."+op2)
   y = parseInt(jj, 10) - 1 

    if (y > 0  && event.keyCode == 38)
        // flecha arriba
        ob2.focus()
}
function llena()
{   cad = 'bake/bakepartida.asp?pos='+trim(thisForm.PAR.value)
    //document.all.body0.style.display = 'block'
    document.all.body0.src= cad
}
function bake() {
    cad = 'bake/baketela.asp?pos=' + trim(thisForm.TEL.value)
    
    document.all.body0.src = cad

}

function colores()
{   thisForm.CLI.value = thisForm.DESCLI.value;
    thisForm.COL.value = '';
    cad = 'bake/bakecolores.asp?pos='+trim(thisForm.CLI.value)+'&sele='+'DESCOL' 
    //document.all.body0.style.display='block'
    document.all.body0.src= cad
}
function cambiacol(obj)
{   document.all.COL.value = Left(trim(obj.value),8)
    document.all.COM.value = Right(trim(obj.value),2)

}
function help(cad)
{   window.open(cad,'',opc)
}
function GRABA()
{   KAD  = 'comun/inserFICHACCT.asp?cod='+thisForm.COD.value
    KAD += '&tal=' + talla
    KAD += '&col=' + cad
    //document.all.body0.style.display = 'block'
document.all.body0.src= KAD  
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
function CHECKEADOS(DATO)
{	if (DATO.checked == true)
	{	DATO.value='1'
		// muestra columna en tabla de rollo/defectos
		eval("document.all.L0C"+Right(DATO.id,3)+".style.display='block'")
		for (e=1; e<= parseInt(thisForm.RLL2.value,10); e++)
		    eval("document.all.L"+e+"C"+Right(DATO.id,3)+".style.display='block'")
	}	
	else
	{	DATO.value='0'
		// oculta columna en tabla de rollo/defectos
		eval("document.all.L0C"+Right(DATO.id,3)+".style.display='none'")
		for (e=1; e<= parseInt(thisForm.RLL2.value,10); e++)
		    eval("document.all.L"+e+"C"+Right(DATO.id,3)+".style.display='none'")
	}	
	for(x=1; x<100; x++ )
	    SUMA(x)
}
function creatabla()
{	var k=0
	var tope = parseInt(thisForm.RLL2.value,10)
	// primero blanqueo la tabla de detalle de defectos
    for (k=1; k <= 100; k++)
		eval("document.all.LIN"+k+".style.display='none'")
	
	// luego muestra los rollos	
	for (k=1; k <= tope; k++)
		eval("document.all.LIN"+k+".style.display='block'")
		
	// MUESTRA LAS COLUMNAS DE DEFECTOS QUE ESTEN CON EL CHK 
	for (p=0; p<aCod.length; p++)
	{   if ( eval("document.all.L0C"+aCod[p]+".style.display")== 'block')
	    {   for (ec=1; ec<= parseInt(thisForm.RLL2.value,10); ec++)
		    {    eval("document.all.L"+ec+"C"+aCod[p]+".style.display='block'")
		    }
	    }  
	}	
    return true;	
}	
function SUMA(opc)
{   tot=0
    for (u=0; u<aCod.length; u++)
    {   if (eval("document.all.L"+opc+"C"+aCod[u]+".style.display")=='block' )
            if (trim(eval("document.all.R"+opc+"D"+aCod[u]+".value"))!='')
                tot += parseInt(eval("document.all.R"+opc+"D"+aCod[u]+".value"),10)
    }
    eval("document.all.TOT"+opc+".value=tot")  
    if (tot > 10)
      eval("document.all.TOT"+opc+".style.backgroundColor='red'")   
    else
      eval("document.all.TOT"+opc+".style.backgroundColor='white'")   
}
function graba()
{   if(trim(thisForm.PAR.value)=='')
    {   alert("Debe informar el número de partida");
        thisForm.PAR.focus();
        return false;
    }
    if(trim(thisForm.TEL.value)=='')
    {   alert("Debe informar el código del Artículo");
        help('help/hlpfamtelas.asp')
        return false;
    }
    if(trim(thisForm.CLI.value)=='')
    {   alert("Debe informar el Cliente");
        thisForm.DESCLI.selectedIndex=0;
        thisForm.DESCLI.focus();
        return false;
    }
    if(trim(thisForm.COL.value)=='')
    {   alert("Debe informar el Color del Artículo");
        thisForm.DESCOL.selectedIndex=0;
        thisForm.DESCOL.focus();
        return false;
    }
    if(trim(thisForm.TIP.value)=='')
    {   alert("Debe informar el Tipo de Inspección");
        thisForm.TIP.selectedIndex=0;
        thisForm.TIP.focus();
        return false;
    }
    else
    {   a = eval(trim(thisForm.TIP.value)=='A' && (trim(thisForm.AA.value)=='' || parseFloat(trim(thisForm.AA.value))<=0))
        b = eval(trim(thisForm.TIP.value)=='T' && (trim(thisForm.AT.value)=='' || parseFloat(trim(thisForm.AT.value))<=0))
        if( a == true )
        {   alert("Revise los datos de la Tela\nNo hay medida de Ancho para este tipo de Inspección\n              ABIERTO")
            thisForm.TIP.selectedIndex=0;
            thisForm.TIP.focus();
            return false;
        }    
        else if( b == true )
        {   alert(parseInt(trim(thisForm.AT.value),10))
            alert("Revise los datos de la Tela\nNo hay medida de Ancho para este tipo de Inspección\n             TUBULAR")
            thisForm.TIP.selectedIndex=0;
            thisForm.TIP.focus();
            return false;
        }
    
    }
    // Revisa si hay rollos a inspeccionar   
    if(trim(thisForm.RLL2.value)=='' || parseInt(thisForm.RLL2.value,10)== 0)
    {   alert("Debe informar el # de Rollos a Inspeccionar");
        thisForm.RLL2.focus();
        return false;
    }
    // Revisa  que no sde inspeccioen mas rollos que los declarados en la partida
    if (parseInt(thisForm.RLL2.value,10) > parseInt(thisForm.RLL.value,10))
    {   alert("No puede inspeccionar mas rollos que los declarados en la partida")
        thisForm.RLL2.focus();
        return false;
    }
    
     if(trim(thisForm.CON.value)=='')
    {   alert("Debe informar en que condición está esta ficha");
        thisForm.CON.selectedIndex=0;
        thisForm.CON.focus();
        return false;
    }   
    thisForm.TON.value = (thisForm.TON.checked) ? '1' : '0';
    thisForm.DEG.value = (thisForm.DEG.checked) ? '1' : '0';
    thisForm.TAC.value = (thisForm.TAC.checked) ? '1' : '0';
    thisForm.REP.value = (thisForm.REP.checked) ? '1' : '0';
    thisForm.MAC.value = (thisForm.MAC.checked) ? '1' : '0';
    thisForm.CAL.value = (thisForm.CAL.checked) ? '1' : '0';
    aObs = Array()
    aRll = Array()
    aNum = Array()
    f=0
    aCan = Array()
    aDef = Array()      
    // Captura LAS COLUMNAS DE DEFECTOS QUE ESTEN CON EL CHK 
	    for (pw=0; pw<aCod.length; pw++)
	       if ( eval("document.all.L0C"+aCod[pw]+".style.display")== 'block')
	           aDef[f++] = aCod[pw]
	 cn=0          
    //Revisa si por lo menos ha ingresado el ancho 
    for (d=1; d<=parseInt(thisForm.RLL2.value,10); d++)
    {   if(trim(eval("document.all.ANCHO"+d+".value"))=='')
        {   alert("Debe Informar el ancho del Rollo");
            eval("document.all.ANCHO"+d+".focus()");
            return false;
        }
        else
            if (NUMEROS(eval("document.all.ANCHO"+d))== false)
                return false;    
            else
                aRll[d]= ltrim(eval("document.all.ANCHO"+d+".value"))
        if(trim(eval("document.all.TOT"+d+".value"))=='' || parseInt(eval("document.all.TOT"+d+".value"),10)==0 )
        {   alert("Debe Informar los defectos del Rollo");
            eval("document.all.TOT"+d+".focus()");
            return false; 
        } 
        else
        {   aObs[d]= ltrim(eval("document.all.R"+d+"OBS.value"))
            aNum[d]= ltrim(eval("document.all.TOT"+d+".value"))
        } 
           
        // MUESTRA LAS COLUMNAS DE DEFECTOS QUE ESTEN CON EL CHK 
	    for (pi=0; pi<aDef.length; pi++)
	    {   aCan[cn++]= eval("document.all.R"+d+"D"+aDef[pi]+".value")      
	    }	          
    }   
    cad  = '?cct='+trim(document.all.CCT.value)
    cad += '&par='+ltrim(document.all.PAR.value)
    cad += '&tel='+trim(document.all.TEL.value)
    cad += '&COL='+trim(document.all.COL.value)
    cad += '&COM='+trim(document.all.COM.value)
    cad += '&CLI='+trim(document.all.CLI.value)
    cad += '&FIN='+ltrim(document.all.FEC.value)
    cad += '&OFI='+trim(document.all.OFI.value)
    cad += '&KGS='+trim(document.all.KGS.value)
    cad += '&RLL='+trim(document.all.RLL.value)
    cad += '&RL2='+trim(document.all.RLL2.value)
    cad += '&OC='+trim(document.all.OC.value)
    cad += '&RUC='+trim(document.all.RUC.value)
    cad += '&TIP='+trim(document.all.TIP.value)
    cad += '&POR='+parseFloat((document.all.RLL2.value*100)/document.all.RLL.value)
    cad += '&VLA='+trim(document.all.VLA.value)
    cad += '&VAA='+trim(document.all.VAA.value)
    cad += '&VLD='+trim(document.all.VLD.value)
    cad += '&VAD='+trim(document.all.VAD.value)
    cad += '&LFA='+trim(document.all.LFA.value)
    cad += '&LFD='+trim(document.all.LFD.value)
    cad += '&LRA='+trim(document.all.LRA.value)
    cad += '&LRD='+trim(document.all.LRD.value)
    cad += '&VLL='+trim(document.all.VLL.value)
    cad += '&VAL='+trim(document.all.VAL.value)
    cad += '&LFL='+trim(document.all.LFL.value)
    cad += '&LRL=' + trim(document.all.LRL.value)
    cad += '&LPV=' + trim(document.all.CAL7.value)
    cad += '&LPL=' + trim(document.all.CAL8.value)
    cad += '&TON='+trim(document.all.TON.value)
    cad += '&DEG='+trim(document.all.DEG.value)
    cad += '&TAC='+trim(document.all.TAC.value)
    cad += '&AO='+trim(document.all.AO.value)
    cad += '&AV='+trim(document.all.AV.value)
    cad += '&REP='+trim(document.all.REP.value)
    cad += '&DMIN='+trim(document.all.DMIN.value)
    cad += '&DMAX='+trim(document.all.DMAX.value)
    cad += '&MAC='+trim(document.all.MAC.value)
    cad += '&CAL='+trim(document.all.CAL.value)
    cad += '&CON='+trim(document.all.CON.value)
    cad += '&OBS='+ltrim(document.all.OBS.value)
    cad += '&aRll='+aRll
    cad += '&aObs='+aObs
    cad += '&anum='+aNum
    cad += '&aDef='+aDef
    cad += '&aCan='+aCan

  document.all.body0.style.display = 'block'
  document.all.body0.height = "350"
  document.all.body0.width = "100%"



  document.all.body0.src = "comun/inserfichacct.asp" + cad;
    //document.all.body0.style.display = 'none'
}
</script>
<%if rs("cct")<>"AUTO" then
    for i = 0 to ubound(addt) 
        lin = addt(i)%>
        <script type="text/jscript" language="jscript">
             lin = '<%=trim(lin)%>'
             eval("document.all.Dd"+lin+".checked =true")
        </script> 
    <%next 
end if%>
	<%	RS.Close  
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>