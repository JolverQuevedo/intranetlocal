<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
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
		marka = 1
		titulo = "FICHA # " + trim(rs("CCT"))+ " -> " + trim(rs("DES"))
	else
		marka = 0	
		titulo = "NUEVA FICHA CCT"
	END IF
Dim aCod  
aCod = Array()
Dim aDes 
aDes= Array()	
	
	%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="../imagenes/CERRAR.gif" style="cursor:hand;" onClick="window.close()" /></td>		
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
	     <td width="20%" align="center"><img src="../imagenes/print.gif" border="0" alt="" id="prn" onclick="pprn()" style="display:block; cursor:hand "/></td>
    </tr>
</table>  

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
        <td align="left" colspan="2" width="2%" class="barra3"><%=rs("cct")%></td>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO">Tela RS:</td>
        <td align="left" colspan="1" width="5%" class="barra22"><%=rs("RTEL")%></td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="7" class="barra33"><%=trim(rs("RDES"))%></td>   
	</tr>
    <tr valign="middle">       
	    <td bgcolor="<%=(Application("BARRA"))%>" width="2%" colspan="2" class="TITULITO"> Partida:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%" colspan="2"  class="barra3"><%=trim(rs("PAR"))%></td>
	    <td bgcolor="<%=(Application("BARRA"))%>" width="2%" class="TITULITO">Proveedor:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%" class="barra22"><%=trim(rs("RUC"))%></td>         
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" colspan="7"  class="barra33"><%=trim(rs("PROV"))%></td>    
	</tr> 
    <tr valign="middle">
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="2%"  class="TITULITO" colspan="2"> Tela TPFS:</td>
        <td align="left" colspan="2" width="5%" class="barra22"><%=TRIM(RS("TEL"))%></td>	
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="10%" colspan="5" class="barra33"><%=trim(rs("des"))%></td> 
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">O/C #:</td>
        <td align="left"  width="5%" colspan="2" class="barra22"><%=rs("OC")%></td>	       
    </tr>
    <tr>        
	   <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Cliente:</td>
       <td align="left" colspan="2" width="3%" class="barra22"><%=TRIM(rs("CLI"))%></td>
	   <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="5" class="barra33"><%=TRIM(RS("descli"))%></td>          
        <td bgcolor="<%=(Application("BARRA"))%>" width="10%" class="TITULITO" colspan="2">OFI #:</td>
    	<td align="left"  bgcolor="<%=(Application("color2"))%>"  width="1%" colspan="2" class="barra22"><%=trim(rs("OFI"))%>&nbsp;</td> 
    </tr>	
    <tr>
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" colspan="2" class="TITULITO">Color:</td>
        <td align="left" colspan="1" width="3%" class="barra22"><%=TRIM(Rs("COL"))%></td>	
	    <td align="left" colspan="1" width="1%" class="barra22"><%=TRIM(Rs("COM"))%></td>	      
	    <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="20%" colspan="5" class="barra33"><%=TRIM(RS("DESCOL"))%></td>        
   	    <td bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO" colspan="2">Fecha:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="1%" colspan="2" class="barra22"><%=trim(rs("FEC"))%></td> 
    </tr>  
    <tr>
	    <td bgcolor="<%=(Application("BARRA"))%>" width="3%" class="TITULITO" colspan="2">Tipo Inspeccion:</td>
	    <td align="left" width="5%" colspan="2" class="barra22"><%IF rs("TIP")="A" THEN %>ABIERTO<%ELSE%>TUBULAR<%END IF %></td>	
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="4%" class="TITULITO">Peso (KGS):</td>
        <td align="left" width="1%" class="barra22"><%=FORMATNUMBER(rs("KGS"),3,,,TRUE)%></td>	 	    
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" class="TITULITO">Rollos Total:</td>
        <td align="left" width="5%" class="barra22"><%=rs("RLL")%></td>	 
	    <td align="left" bgcolor="<%=(Application("BARRA"))%>" width="5%" class="TITULITO">Rollos a Inspeccionar:</td>
        <td align="left" width="2%" class="barra22"><%=rs("RLL2")%></td>	     
	    <td bgcolor="<%=(Application("BARRA"))%>" width="1%" class="TITULITO" align="center">% Auditado:</td>
        <td align="left"  bgcolor="<%=(Application("color2"))%>"  width="3%" class="barra22"><%=formatnumber(trim(rs("AUD")),2,,,true)%></td>
    </tr>                   
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
   <td bgcolor="<%=(Application("BARRA"))%>"  class="barra222" width="1%"><%=rs("ELL1") %></td>
    <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">L</td>
    <td align="center"  class="barra222"><%=rs("VLA")%></td>
    <td align="center" class="barra222"><%=rs("VLD")%></td>
    <%NUMERO = ((rs("VLA")-rs("VLD"))/rs("VLA")*100) %>
    <td align="center" bgcolor="<%=(Application("BARRA"))%>"  class="barra222" id="CAL1"><%=formatnumber(NUMERO,2,,true)%></td>
    <td align="center" class="barra222"><%=rs("VLL")%></td>
    <td align="center" bgcolor="<%=(Application("BARRA"))%>"  class="barra222" id="CAL2"><%=formatnumber(((rs("VLA")-rs("VLD"))/rs("VLA")*100),2,,true)%></td>
    <td align="center"  bgcolor="<%=(Application("BARRA"))%>"  class="barra222" ><%IF RS("TIP")="T" THEN RESPONSE.Write(rs("at")) else response.Write(rs("aa"))%>
    </td>
    <td align="center"  class="barra222" ><%=formatnumber(rs("AO"),2,,,true)%></td>
    <td align="center"   class="barra222"><%=formatnumber(rs("AV"),2,,,true)%></td> 
         <td align="center"   class="barra222" ><%if rs("ton")= "1" then%>SI<%else %>NO <%end if%></td>
                 <td align="center"  class="barra222" ><%if rs("deg")= "1" then%>SI<%else%>NO <%end if%></td>
                 <td align="center"  class="barra222" ><%if rs("tac")= "1" then%>SI<%else %>NO <%end if%></td>
</tr>
<tr>
     <td bgcolor="<%=(Application("BARRA"))%>"   class="barra222" ><%=rs("eal1")%></td> 
     <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">A</td>
     <td align="center"  class="barra222" ><%=rs("VAA")%></td>
    <td  align="center"  class="barra222" ><%=rs("VAD")%></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>" class="barra222" id="CAL3"><%If rs("vaa") > 0 and rs("vad")>0 then  RESPONSE.WRITE(formatnumber(((rs("VaA")-rs("Vad"))/rs("Vaa")*100),2,,true))%></td>
    <td align="center"  class="barra222" ><%=rs("VAL")%></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>"   class="barra222"  id="CAL4"><%If rs("vaa") > 0 and rs("val")>0 then RESPONSE.WRITE(formatnumber(((rs("VaA")-rs("Val"))/rs("Vaa")*100),2,,true))%></td>
<td colspan="3">
     <table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	    <tr valign="middle">
		    <td bgcolor="#f7d975" width="70%"><font size="1" color="#000066" face="Arial"><b>D E N S I D A D</b></font></td>	
	    </tr>
    </table>
</td>    <td>&nbsp;</td>
<td bgcolor="<%=(Application("BARRA"))%>" align="center" class="titulito">REPROCESO</td>
<td align="center"  class="barra222" ><%if rs("rep")= "1" then%>SI<%else %>NO<%end if%></td> 
</tr>
<tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="titulito" rowspan="2">LAVADO</td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTOAZULPOS"><%="&nbsp;"%></td> 
    <td align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">F</td>
    <td align="center" class="barra222" ><%=rs("LFA")%></td>
    <td align="center" class="barra222" ><%=rs("LFD")%></td>
    <td align="center" bgcolor="<%=(Application("BARRA"))%>"   class="barra222" id="CAL5"><%If rs("lfa") > 0 and rs("lfd")>0 then RESPONSE.WRITE(formatnumber(((rs("lfa")-rs("lfd"))/rs("lfa")*100),2,,true))%></td>
    <td align="center"  class="barra222" ><%=rs("LFL")%></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>"   class="barra222" id="CAL6"><%If rs("lfa") > 0 and rs("lfl")>0 then RESPONSE.WRITE(formatnumber(((rs("lfa")-rs("lfl"))/rs("lfa")*100),2,,true))%></td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">REQUERIDO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MINIMO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MAXIMO</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">MACHING</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">CALIDAD</td>
    <td width="5%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">CONDICION</td>
</tr>
<tr> <td bgcolor="<%=(Application("BARRA"))%>"  class="barra222" ><%=rs("REV")%></td>  
    <td width="1%" align="center" bgcolor="<%=(Application("BARRA"))%>" class="titulito">R</td>
    <td align="center"  class="barra222" ><%=rs("LRA")%></td>
    <td  align="center"  class="barra222" ><%=rs("LRD")%></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>"   class="barra222" id="CAL7"><%=formatnumber(rs("lpv"),2,,true)%></td>
    <td align="center"  class="barra222" ><%=rs("LRL")%></td>
    <td  align="center" bgcolor="<%=(Application("BARRA"))%>"  class="barra222"  id="CAL8"><%=formatnumber(rs("lpl"),2,,,true)%></td>    
<td  align="center" bgcolor="<%=(Application("BARRA"))%>"   class="barra222" ><%=rs("DDL")%> gr/mt2</td>   
        <td align="center"  class="barra222" ><%=rs("DMIN")%> gr/mt2</td>
        <td align="center"  class="barra222" ><%=rs("DMAX")%> gr/mt2</td>   
        <td align="center"  class="barra222" ><%if rs("mac")="1" then%>SI<%else%>NO<%end if%></td> 
        <td align="center"  class="barra222" ><%if rs("cal")="1" then%>SI<%else%>NO<%end if%></td> 
 <td align="center"  class="barra222" ><%if rs("con")="A" then%>ABIERTO<%else%>CERRADO<%end if%></td>                
</tr>
</table>

<table border="1" cellpadding="2" align="center" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
  <tr>
      <%
        cad =	" SELECT tipodefectos.codigo, tipodefectos.descripcion from tipodefectos " & _
			    "  WHERE tipodefectos.estado= 'a' ORDER BY tipodefectos.codigo           "
	    rs2.Open cad,cnn
	    'response.Write(cad)
	    IF rs2.recordcount> 0 THEN rs2.movefirst  %>
    <%	ATIPO = ARRAY()
        numdefe = rs.recordcount
  	    CONT = 0%>
    <%	DO WHILE NOT RS2.EOF%>
    	
		    <%REDIM PRESERVE ATIPO(CONT)
		    ATIPO(UBOUND(ATIPO))= RS2("CODIGO")
		    CONT = CONT +1%>	
	<%	RS2.MOVENEXT
	LOOP%>		
<%RS2.CLOSE%>
</tr>
    <%cad = " SELECT codigo, descripcion, defectostela.tipo," & _
            " defectostela.ABREVIA FROM DEFECTOSTELA        " & _
		    " WHERE DEFECTOSTELA.estado = 'A'               " & _
		    " ORDER BY tipo, codigo                         " 
    rs2.open cad,cnn
    'response.Write(cad)
    IF rs2.RecordCount > 0 THEN
	    rs2.MoveFirst
	    columnas = rs2.recordcount
   END IF
    A = 0
    FOR i=0 TO UBOUND(ATIPO)%>
	        <%DO WHILE NOT rs2.eof AND trim(rs2("tipo")) = trim(atipo(i))%>
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
    <%NEXT%>	

</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="5" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
    <tr valign="middle">
        <td bgcolor="#f7d975"><font size="1" color="#000066" face="Arial"><b>R O L L O S&nbsp;&nbsp;&nbsp;
        I N S P E C C I O N A D O S</b></font></td>
    </tr>
</table>
<center>
<table border="1" cellpadding="2" cellspacing="0" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
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
        end if              %>
      <tr bgcolor="<%=application("barra")%>"  style="display:block" id="LIN0">
        <td class="textominibb">Rll #</td>
        <td class="textominibb"  align="center" >Ancho<br />Mt.</td>
        <%cb=0%>
          <%FOR I=0 TO COLUMNAS-1%>
            <%' las columnas se llaman C+el código del defecto %>
            <td  class="barra333" id="L0C<%=aCod(i)%>"  
            style="<%IF cb <= ubound(addt) and  rs("cct")<> "AUTO"  and aCod(i)=addt(cb)   then%>
                            display:block
                            <%cb = cb + 1
                            if cb > ubound(addt) then cb = 0%>
                   <%else%>
                        display:none
                    <%end if %>" ><%=trim(ades(i))%>
            <input type="text" id="D<%=aCod(i)%>" name="D<%=aCod(i)%>" value="<%=aCod(i)%>" style="display:none" readonly/></td>
          <%NEXT%>
          <td  class="barra333" >TOT</td>
          <td  class="barra333" >Observaciones</td>
      </tr>
     
      <%for j=1 to rs("rll2")%> 
          <tr id="LIN<%=J%>">
              <td class="barra333"><%=RLL%></td>
              <td ><input type="text" value=""  class="barra2" id="ANCHO<%=j%>" name="ANCHO<%=j%>" readonly /></td>
              <%cb = 0 %>
              <%FOR I=0 TO COLUMNAS-1%>
                <td class="textominibb" id="L<%=J%>C<%=aCod(i)%>"  style="<%IF cb <= ubound(addt) and  rs("cct")<> "AUTO"  and aCod(i)=addt(cb)   then%>
                            display:block
                            <%cb = cb + 1
                            if cb > ubound(addt) then cb = 0%>
                   <%else%>
                        display:none
                    <%end if %>">
                <input type="text" id="R<%=J%>D<%=aCod(i)%>" name="R<%=J%>D<%=aCod(i)%>"  class="barra2" readonly /></td>
              <%NEXT%>
              <td ><input type="text" value=""  class="barra2" id="TOT<%=trim(j)%>" name="TOT<%=j%>" readonly /></td>
              <td ><input type="text" value=""  class="textarea1" id="R<%=trim(j)%>OBS" name="R<%=j%>OBS" /></td>
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
         <span class="textarea1"><%=obb %></span> 
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
            cc = parseInt('<%=rs2("cant") %>',10)
            eval("document.all.R"+lin+"D"+def+".value=cc")
        </script>    
        <%rs2.movenext%>
    <%loop%>
<%end if %>



</center>

<%for q = 0 to ubound(aCod)%>
    <%xx=aCod(q)%>
    <script type="text/jscript" language="jscript">
        s = parseInt('<%=q%>',10)
        aCod[s]= '<%=trim(xx)%>'
    </script>
<%next %>
<script type="text/jscript" language="jscript">
function pprn()
{ document.all.prn.style.display='none'
    window.print()
  document.all.prn.style.display='block'  
}

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


function llena()
{   cad = 'bake/bakepartida.asp?pos='+trim(thisForm.PAR.value)
    document.all.body0.src= cad
}

function help(cad)
{   window.open(cad,'',opc)
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


</script>
	<%	RS.Close  
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>