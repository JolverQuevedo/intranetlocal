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
<script type="text/jscript" language="jscript">
var NUMTAL=0
var aHil = new Array()
var aDes = new Array()
var aKgs = new Array()
var aVal = new Array()
var aRut = new Array()
var aMat = new Array()
</SCRIPT>
    <%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
    Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.CursorLocation   = 3
	RS3.CursorType       = 3    
	RS3.LockType         = 1 
	rs.open "select * from tb_ctrl"
	rs.movefirst
	mermatela = rs("mermatela")
    air = rs("air")
    sea = rs("sea")
    dhl = rs("dhl")
	rs.close

    CAD = "EXEC ventas..SP_TIPODECAMBIO"
    RS.Open CAD, Cnn
    bajo = rs("bajo")
    rs.close

    PRO	= Request.QueryString("PRO")
	VER = Request.QueryString("VER")

	CAD =	" exec FICHACOTI_HEAD '"&PRO&"' , '"&VER&"'  " 
	
	'response.Write(cAD)
	rs.open cad , cnn
	
		RS.MOVEFIRST
	OBS= RS("OBS")	

    dim gKgs, gmerruta, gctorut

	IF RS("COTI")= "AUTO" THEN
	    marka = 0	       
		titulo = "HOJA DE CONSUMO #"
	else
	    marka = 1
		titulo = "HOJA DE CONSUMO # " + PRO + " - " + VER
	END IF%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA COTIZADOR</title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="15%"><img src="../imagenes/modela.jpg" style="cursor:hand;" onClick="window.close()" /></td>		
          <td width="15%">
          <table cellpadding="0" cellspacing="0" border="0" align="center" width="100%">
		        <tr height="25px"><td align="center" class="texto ">Fecha:  </td></tr>
                <tr><td align="center" class="texto "><input id="FECCOT" name="FECCOT" value='<%=left(RS("FECOT"),10)%>' class="cambio" readonly tabindex="-1" ></td></tr>
		    </table> 
          </td>		
          <td align = "center" class="TALASBLUE" width="40%">
            <table cellpadding="22" cellspacing="0" border="0" align="center" width="100%">
		        <tr><td align="center" class="talasblue"><%=titulo%>&nbsp;</td></tr>
		    </table> 
         </td>
         <td width="15%"><table cellpadding="0" cellspacing="0" border="0" align="center" width="100%">
		        <tr height="25px"><td align="center" class="texto ">Tipo de Cambio:  </td></tr><%if cdbl(rs("tcam")) > 0 then cambio = cdbl(rs("tcam")) else cambio = bajo%>
                <tr><td align="center" class="texto "><input id="TCAM" name="TCAM" value='<%=formatnumber(cambio,3,,true)%>' class="cambio" readonly tabindex=-1 ></td></tr>
		    </table> </td>		
	     <td  width="15%" align="right"><img src="../imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
    </tr>
</table>  

<table width="100%" border="0" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">G E N E R A L E S :</td>	
	</tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
        <td width="5%"  class="american2">PROTO :</td>
        <td width="15%"  class="TEXTO"><%=rs("PRO")%>-<%=rs("ver")%></td>
        <td width="5%"  class="american2">CLIENTE : </td>
        <td width="15%" class="TEXTO"><%=rs("cli")%>-<%=RS("NOM")%></td>
        <td width="5%"  class="american2">ESTILO:</td>
        <td width="50%" class="TEXTO" COLSPAN="3"><%=rs("est")%>-<%=rs("ecl")%> - <%=rs("des")%></td>
    </td>
    <td width="10%" rowspan="7"><img src="../BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("EST")%>&CLI=<%=RS("CLI")%>" height="200" ID="FOT" /></td>
  </tr>
    <tr>
        <td width="5%"  class="american2">GENERO : </td>
        <td width="15%"  class="TEXTO"><%=rs("gen")%>-<%=trim(rs("dgen"))%></td>
        <td width="5%"  class="american2" >TIPO PRENDA : </td>
        <td width="15%" class="TEXTO" ><%=trim(rs("tip"))%>-<%=trim(rs("tpre"))%></td>
        <td width="5%"  class="american2" >TEMPORADA : </td>
        <td width="25%" class="TEXTO"><%=trim(rs("tem"))%> - <%=trim(rs("dtem"))%></td>
        <td width="5%"  class="american2">MOTIVO :</td>
        <td width="30%" class="TEXTO" ><%=trim(rs("mot"))%></td>
    </tr>
  <tr>
    <td width="5%"  class="american2">TELA</td>
    <td width="90%" class="TEXTO" colspan="7">
    <%=rs("tel")%> - <%=trim(rs("dtel"))%> &nbsp;DEN:&nbsp; <%=trim(rs("PA"))%> gr/mt2 - REN <%if rs("aa")> 0 then response.write(rs("ra")) else response.write(rs("rt"))%></td>    
   </tr>
  

   <script language="jscript" type="text/jscript">
       pro = '<%=rs("pro") %>'
       ver = '<%=rs("ver") %>'
       cli = '<%=rs("cli") %>'
       est = '<%=rs("est") %>'
       tel = '<%=rs("tel") %>'
       mot = '<%=rs("mot") %>'
       tem = '<%=rs("tem") %>'
   </script>
  <tr>
   <%DAD = "SELECT TALLA,PROP, cant, orden FROM [PROTO-TALLAS] WHERE PROTO = '"&PRO&"' AND VERSION = '"&VER&"' ORDER BY ORDEN"
  ' RESPONSE.WRITE(DAD)
   RS2.OPEN DAD, CNN 
              IF RS2.RECORDCOUNT > 0 THEN 
                dim atal , ACAN
                atal = array()
                ACAN = ARRAY()
                RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                        <%redim preserve ATAL(ubound(atal)+1)
                        redim preserve acan(ubound(acan )+1)
                        atal(ubound(atal))= rs2("talla")
                        ACAN(ubound(ACAN))= rs2("prop")
                       RS2.MOVENEXT%>
                   <%LOOP%>    
              <%END IF%>     

    <td rowspan="4" colspan="8" class="american2" >
    <table  border="1" cellspacing="1" cellpadding="0" align="left">
        <tr>
            <td width="10%" >
                <input id="Text3" name="T<%=i%>" readonly tabindex="-1" class="american2" style="width:50px;text-align:left" value ="TALLAS :">   </td>
            <%FOR I = 0 TO 9%>
               <td width="8%">
                <%if i <= UBOUND(ATAL) then  %>
               <input id="x<%=i%>" name="x<%=i%>" value="<%=trim(atal(i))%>" class="american2" style="text-align:center" tabindex=-1 readonly/>
               <%else %>
                <input id="Text2" name="T<%=i%>" readonly tabindex="-1" class="TEXTOblue" style="width:50px;text-align:center">   
               <%end if %>
               </td>    
            <%NEXT%>
            <td width="10%"><input id="Text5" name="T<%=i%>" readonly tabindex="-1" class="american2" style="text-align:left" value ="TOTAL PRENDAS">   </td>
        
        </tr>   
        <tr>
            <td width="10%" ><input id="Text4" name="T<%=i%>" readonly tabindex="-1" class="american2" style="text-align:left" value ="PROPORCION:" /></td>
            <%FOR I = 0 TO 9%>
               <td width="8%">
                <%if i <= UBOUND(ATAL) then  %>
                    <input id="T<%=i%>" name="T<%=i%>" value="<%=formatnumber(TRIM(acan(i)),0,,true)%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:center; vertical-align:middle ">   
                <%else %>
                <input id="Text1" name="T<%=i%>" readonly tabindex="-1" class="TEXTOblue" style="width:50px;text-align:center">   
                <%end if%>
            </td> 
           <%NEXT%>
           <td width="10%"><input id="CAN" name="CAN" readonly class="TEXTOblue" value= 0 style="text-align:center; padding-right:10px;" tabindex="-1"></td>   
        </tr> 
        
    </table>
</td>
    </tr> 
</table>
<%rs2.close%>  

<table width="100%" border="0" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">T E L A S :</td>	
	</tr>
</table>
<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("BORDE"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" id="TELAS">
    <tr valign="middle" bgcolor="<%=(Application("color2"))%>"  class="american2">
        <td width="1%">Id</td>
        <td width="5%">&nbsp;&nbsp;COD</td>
        <td width="71%">TELA</td>
        <td width="4%">Ancho</td>
        <td width="4%">Mt/Pda.</td>
        <td width="5%" align="center"   >Unit (Kg.)</td>
        <td width="3%">% MER.</td>
        <td width="3%" align="right" >Tot Kg&nbsp;</td>
        <td width="4%" align="right">Tot Mt&nbsp;</td>
    </tr>    
    
    <%CAD =	" exec FICHAcoti_TELA '"&PRO&"' , '"&VER&"'  "   
    'RESPONSE.Write(CAD)
    'RS.CLOSE
    RS2.OPEN CAD,CNN
    MAXIM = RS2.RECORDCOUNT%>
    <% RS2.MOVEFIRST%>
    <% I=1 ' contador de los consumos por tela
       j=1 ' contador de los hilos de cada tela
       k=1 ' contador de servicios de cada ruta de tela  
       HILOS = 0    %>
	<%DO WHILE NOT RS2.EOF%>
		<tr valign="top"  bgcolor="<%=(Application("color1"))%>" > 
         <td width="1%"><input  type="text"  id="ID1<%=i%>" name="ID1<%=i%>" value="<%=trim(rs2("id"))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>      
            <td width="4%"  align="center"><input id="TEL1<%=i%>" name="TEL1<%=i%>" value="<%=trim(rs2("TEL"))%>"   type="text"  class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>
            <td width="50%" ><input type="text" value="<%=trim(rs2("DTE")) %> - <%=trim(rs2("com")) %>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:left; vertical-align:top"/>
            <td width="3%"><input type="text" id="ANC<%=i%>" name="ANC<%=i%>" value="<%=formatnumber(rs2("ANC"),2,,,true)%>"class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:left; vertical-align:top" /></td>
            <td width="3%" ><input type="text" id="LAR<%=i%>" name="LAR<%=i%>" value="<%=formatnumber(rs2("LAR"),2,,,true)%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:left; vertical-align:top" /></td>
            <td width="5%"><input type="text" id="CUN<%=i%>" name="CUN<%=i%>" value="<%=formatnumber(rs2("CUN"),3,,,true)%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:left; vertical-align:top" /></td>
            <td width="3%"><input type="text" id="MERI<%=i%>" name="MERI<%=i%>" value="<%=trim(rs2("MER"))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="width:100%;text-align:center; vertical-align:top" /></td>
            <td width="3%"><input type="text" id="TT<%=i%>" name="TT<%=i%>" value="<%=formatnumber(rs2("TOT"),3,,,true)%>" class="barrasder" readonly tabindex="-1"/></td>
            <td width="3%"><input type="text" id="MM<%=i%>" name="MM<%=i%>" value="<%=formatnumber(rs2("mts"),3,,,true)%>" class="barrasder" readonly tabindex="-1"/></td>
    </tr> 
    <tr><%TEL = RS2("tel") 
        RUT = RS2("RUT")
        id = rs2("id")%>
        <td colspan="9" width="100%"> 
            <table border="1" width="100%" cellpadding="0" cellspacing="0" >
                <tr valign="top">
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr bgcolor="<%=application("barra")%>">
                                <td colspan="5" align="center" class="TITULITO">DETALLE HILADO</td>
                            </tr>
                            <tr BGCOLOR="<%=APPLICATION("color1")%>">
                               <td class="TITULITO">COD</td>
                               <td class="TITULITO">DESCRIPCION</td>
                               <td class="TITULITO">%</td>
                               <td class="TITULITO">TIT</td>
                               <td class="TITULITO">KGS</td>
                               
                            </tr>
                            <%ID = RS2("ID")
                            CAD = " EXEC FICHACOTI_hilo '"&TEL&"', '"&ID&"', '"&COTI&"',  '"&j&"' " 
                           ' response.write(cad)
                            RS3.OPEN CAD, CNN
                            IF RS3.RECORDCOUNT > 0 THEN
                                RS3.MOVEFIRST%>
                                 <script type="text/jscript" language="jscript">
                                     ru = parseInt('<%=j%>', 10)
                                     aMat[ru] = parseInt('<%=rs3.recordcount%>', 10)

                                </script>


                                <%DO WHILE NOT RS3.EOF%>
                                    <tr>
                                       <td class="TEXTO"><input type="text" id="HH<%=j%>" name="HH<%=j%>" value="<%=UCASE(TRIM(RS3("HIL")))%>" class="BARRAS" readonly tabindex="-1" /> 
                                       </td>
                                       <td class="TEXTO"><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                                       <td class="TEXTO"><input type="text" id="POR<%=j%>" name="POR<%=j%>" value="<%=rs3("POR") %>" class="BARRAS" readonly tabindex="-1" /></td>
                                       <td class="TEXTO"><%=UCASE(TRIM(RS3("TIT")))%></td>
                                       <td class="TEXTO"><input type="text" id="KH<%=j%>" name="KH<%=j%>" value="" class="BARRAS" readonly tabindex="-1" /></td>
                                      
                                        </td>
                                          
                                    </tr>
                                     <script language="jscript" type="text/jscript">
                                           por = parseInt('<%=replace(rs3("por"),",",".")%>', 10)
                                           kgs = parseFloat('<%=Replace(rs2("tot"),",",".")%>')
                                           
                                           tt = (parseFloat(por) / 100) * kgs
                                           x = parseInt('<%=j%>', 10)
                                           kk = eval("document.all.KH" + x + ".value=deci(tt,3)")
                                           cc = parseFloat('<%=cdbl(rs3("cto"))%>')
                                           if (parseFloat(cc) <= 0)
                                                cc = 0.01
                                           pda = tt * cc
                                           eval("document.all.TH" + x + ".value=deci(pda,3)")
                                           aHil[x] = '<%=UCASE(TRIM(RS3("hil")))%>'
                                           aDes[x] = '<%=UCASE(TRIM(RS3("DESCRIPCION")))%>'
                                           aKgs[x] = deci(tt, 3)
                                           aVal[x] = deci(pda, 3)
                                       </script>
                                    <%j = j+1%>
                                    <%RS3.MOVENEXT%>
                                <%LOOP%>
                            <%END IF%>
                            <%RS3.CLOSE%>
                         </table>
                    </td>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr bgcolor="<%=application("barra")%>">
                                <td colspan="4 align="center" class="TITULITO">RUTA DE TELA</td>
                            </tr>
                            <%cad = "EXEC FICHACOTI_RUTA '"&COT&"' , '"&TEL&"' , '"&RUT&"', "&ID&" , '"&PRO&"',  '"&VER&"' "    
                                   'RESPONSE.Write(CAD)
                            RS3.OPEN CAD,CNN%>

                             <script type="text/jscript" language="jscript">    
                                ru = parseInt('<%=i%>',10)
                                aRut[ru] = parseInt('<%=rs3.recordcount%>',10)
                             </script>

                            <tr BGCOLOR="<%=APPLICATION("color1")%>">
                                <td class="TITULITO" align="right">&nbsp;COD&nbsp;</td>
                                <td class="TITULITO">SERVICIO</td>
                                <td class="TITULITO">UNID</td>
                                <td class="TITULITO">Mer</td>
                                
                            </tr>
                            <%IF RS3.RECORDCOUNT>0 THEN
                                RS3.MOVEFIRST%>
                                <%DO WHILE NOT RS3.EOF%>
                                <tr>
                                
                                    <td width="7%"><input id="SER<%=k%>" name="SER<%=k%>" value="<%=UCASE(TRIM(RS3("codigo")))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>
                                    <td class="TEXTO" width="65%"><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                                    <td><input id="UNT<%=K%>" name="UNT<%=K%>" type="text" value="<%=UCASE(TRIM(RS3("UNIDAD")))%>" class="BARRAS" readonly tabindex="-1" /></td>
                                    <td><input type="text" id="M<%=k%>" name="M<%=k%>" value="<%=TRIM(RS3("MERMA"))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:center" /></td>
                                    <%if isnull(rs3("costo")) or cdbl(rs3("costo")) <=0 then cct = 0.01 else cct = rs3("costo")%>
                                   
                                    <%
                                    if isnull(RS2("TOT")) = true then gkgs= 0 else gkgs = cdbl(rs2("tot"))
                                    if isnull(RS3("merma")) = true then gmerruta= 0 else gmerruta = 1 + (cdbl(rs3("merma"))/100)
                                    if isnull(RS3("costo")) = true then gctorut= 0.01 else gctorut = cdbl(rs3("costo")) * gmerruta
                                    PPDA = gkgs * gctorut%>
                                  
                                </tr>  
                                <%k = k+1%>
                                <%RS3.MOVENEXT%>   
                                <%LOOP%>
                            <%END IF%>
                            <%RS3.CLOSE%>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>  
    
		<%RS2.MOVENEXT%>
        <%I = I+1%>
	<%LOOP%>
    <tr>
        <td width="47%" colspan="9"      style="text-align:right">
            
        </td>
        
    </tr>
</table>



<table width="100%" border="1" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">A V I O S :</td>	  
	</tr>
</table>
<table border="0" cellpadding="0" width="100%" cellspacing="4" bordercolordark="<%=(Application("BORDE"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" id="Table1">
    <tr valign="middle" bgcolor="<%=(Application("color1"))%>"  class="american2" align="center">
        <td>Id</td>
        <td>COD</td>
        <td>AVIO</td>
        <td>COMENTARIO</td>
        <td colspan="2">Area</td>       
        <td>Unid.</td>
        <td>CONS<br />Uni</td>
        <td>% <BR />MER.</td>
        <td>CONS <bR />Tot</td>
       
    </tr>    
    <%CAD =	" exec FICHAPROTO_Avio '"&PRO&"' , '"&VER&"'  "  
   ' response.Write(cad)
    XON = 0
    torpe=0
    RS2.CLOSE
    RS2.OPEN CAD,CNN%>
    <% RS2.MOVEFIRST%>
	<%DO WHILE NOT RS2.EOF%>
        <tr valign="top"> 
         <td><input id="AID<%=XON%>" name="AID<%=XON%>" value="<%=RS2("ORD")%>" readonly tabindex="-1" class="TEXTONAVYREADONLY" /></td>       
           <td class="TEXTO" "><input type="text" id="COD<%=xon%>" name="COD<%=xon%>" value="<%=rs2("AVI")%>" class="TEXTOblue" readonly tabindex="-1" style="width:50px; size="5px;"/>
           
           </td>
           <td class="TEXTO" style="width:350px;"><%=rs2("DES")%></td>
           <td class="TEXTO"><input type="text" id="OBS<%=xon%>" name="OBS<%=xon%>" value="<%=rs2("OBS")%>" class="TEXTOblue"  readonly tabindex="-1" size="30"/></td>
           <td class="TEXTO"><%=rs2("TPP")%>-</td>
           <td class="TEXTO"><%=rs2("DTP")%><input id="EXX<%=XON%>" name="EXX<%=XON%>" value="<%=rs2("exx")%>" style="display:none"></td>
           <td><input type="text" id="UNI<%=XON%>" name="UNI<%=XON%>" value="<%=rs2("UNI")%>" style="text-align:center; font-weight:400"  class="TEXTOblue"  readonly tabindex="-1" size="5px"/></td>
           <td><input type="text" id="CON<%=xon%>" name="CON<%=xon%>" value="<%=formatnumber(rs2("CON"),3,,,true)%>" class="TEXTOblue" style="text-align:right; padding-right:10px; size:20px" readonly tabindex="-1" size="5" /></td>
           <td class="TEXTO"><input type="text" id="MRR<%=xon%>" name="MRR<%=xon%>" value="<%=rs2("MRR")%>" class="TEXTOblue" style="border-right-width:thick; width:30px; text-align:center" readonly tabindex="-1" /></td>
           
           <td><input type="text" id="TTO<%=xon%>" name="TTO<%=xon%>" value="<%=formatnumber(rs2("TTO"),3,,,true)%>" class="TEXTOblue" style="border-right-width:thick; width:50px; text-align:right; padding-right:5px;" readonly tabindex="-1" /></td>

           <%if cdbl(rs2("cto")) > 0 then costo = cdbl(rs2("cto")) else if cdbl(rs2("cto1")) > 0 then costo = cdbl(rs2("cto1")) else costo = cdbl(rs2("cto2")) %>
           
                
           </td>
        </tr>    
		<%RS2.MOVENEXT%>
        <%I = I+1%>
        <%xon = xon + 1%>
	<%LOOP%>
    <%maxi = I%>
    <%mai = I%>
 
</table>
<table width="100%" border="1" cellpadding="3" cellspacing="0">   
	<tr valign="middle">
		<td width="50%" class="TALASORANGE">T I E M P O S :</td>	
		<td class="TALASORANGE">C O M E N T A R I O S :</td>	
	</tr>
    <tr>
        <td width="50%" colspan="1" valign="top">
            <table border="1" cellpadding="3" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
            <tr bgcolor="<%=application("COLOR1") %>" align="center">
                <td class="titulito" width="10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td class="titulito" width="10%">CORTE</td>
                <td class="titulito" width="10%">COSTURA</td>
                <td class="titulito" width="10%">ACABADOS</td>
                <td class="titulito" width="10%">ADICIONALES</td>
            </tr>
            <tr>    
                <td class="titulito" bgcolor="<%=application("COLOR1") %>">Minutos</td>
                <td class="titulito"><input id="MINCOR" name="MINCOR" value="<%=rs("mcor")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
                <td class="titulito"><input id="MINCOS" name="MINCOS" value="<%=rs("mcos")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/> </td>
                <td class="titulito"><input id="MINACA" name="MINACA" value="<%=rs("maca")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
                <td class="titulito"><input id="MINADI" name="MINADI" value="<%=rs("madi")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
            </tr>
            <tr>    
                <td class="titulito" bgcolor="<%=application("COLOR1") %>">% Eficiencia</td>
                <td class="titulito"><input id="EFICOR" name="EFICOR" value="<%=rs("ecor")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;" /></td>
                <td class="titulito"><input id="EFICOS" name="EFICOS" value="<%=rs("ecos")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
                <td class="titulito"><input id="EFIACA" name="EFIACA" value="<%=rs("eaca")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
                <td class="titulito"><input id="EFIADI" name="EFIADI" value="<%=rs("eadi")%>"  class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:right;padding-right:5px;"/></td>
                
            </tr>
            <tr bgcolor="<%=application("COLOR1") %>">    
                <td class="titulito" >Minutos Totales</td>
                <td class="titulito"><input id="TOTCOR" name="TOTCOR" class="DESCnegroder" readonly tabindex="-1" /></td>
                <td class="titulito"><input id="TOTCOS" name="TOTCOS" class="DESCnegroder" readonly tabindex="-1" /></td>
                <td class="titulito"><input id="TOTACA" name="TOTACA" class="DESCnegroder" readonly tabindex="-1" /></td>
                <td class="titulito"><input id="TOTADI" name="TOTADI" class="DESCnegroder" readonly tabindex="-1" /></td>
            </tr>
            <tr bgcolor="<%=application("COLOR1") %>">    
                <td class="titulito">Desc. Adicionales:</td>
                <td class="titulito" colspan="4" bgcolor="<%=application("color2") %>"><input id="DESADI" name="DESADI" value="<%=rs("desadi")%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" style="text-align:left;padding-right:5px;"/></td>
            </tr>    
            </table>
        </td>
        <td valign="top">
            <table border="0" cellpadding="3" width="100%" cellspacing="3" >
            <tr bgcolor="<%=application("color1") %>" align="center">
              <td class="titulito" width="50%"  style="text-align:left;  vertical-align:text-top">D.D.P.</td>
              <td width="50%" class="TITULITO"  style="text-align:left;  vertical-align:text-top" bgcolor="<%=application("color1") %>">Comercial</td>
            </tr>
              <tr>
              <td style="height:1px; background-color:'<%=application("borde")%>';"></td>
              <td style="height:1px; background-color:'<%=application("borde")%>';"></td>
            </tr>
            <tr bgcolor="<%=application("color1") %>" align="center">
              <td class="TEXTOblue" width="50%" style="text-align:left; vertical-align:text-top; background-color:White; border-bottom-color:White;"><%=OBS%></td>
              <td class="TEXTOblue" width="50%" style="text-align:left; vertical-align:text-top; background-color:White;"><%=rs("obscot")%></td>
            </tr>
        </table>
        </td>
    </tr>
</table>


<script type="text/jscript" language="jscript">
    TOTALIZA()

    function minutos() {
        document.all.MINCOR.value = (document.all.MINCOR.value)
        document.all.MINCOS.value = (document.all.MINCOS.value)
        document.all.MINACA.value = (document.all.MINACA.value)
        document.all.MINADI.value = (document.all.MINADI.value)
        document.all.EFICOR.value = document.all.EFICOR.value
        document.all.EFICOS.value = document.all.EFICOS.value
        document.all.EFIACA.value = document.all.EFIACA.value
        document.all.EFIADI.value = document.all.EFIADI.value
        document.all.TOTCOR.value = toInt((document.all.MINCOR.value * 100 / document.all.EFICOR.value))
        document.all.TOTCOS.value = toInt((document.all.MINCOS.value * 100 / document.all.EFICOS.value))
        document.all.TOTACA.value = toInt((document.all.MINACA.value * 100 / document.all.EFIACA.value))
        document.all.TOTADI.value = toInt((document.all.MINADI.value * 100 / document.all.EFIADI.value))
       
    }

    function RUTCTO(op, oep) {
        op = parseInt(op, 10)
        opp = parseInt(oep, 10)
        // total de kilos por prenda
        lkgs = eval("document.all.TT" + opp + ".value")
        // total de metros por prenda
        lmts = eval("document.all.MM" + opp + ".value")
        lunidad = trim(eval("document.all.UNT" + op + ".value"))
        lmerma = parseFloat(eval("document.all.M" + op + ".value")) / 100
        lcosto = parseFloat(eval("document.all.CTO" + op + ".value"))
        eval("document.all.CTO" + op + ".value=redondea(lcosto,2)")
        lcosto = (1 + lmerma) * lcosto
        if (lunidad == 'MTS')
            lcosto = lcosto * lmts
        else
            lcosto = lcosto * lkgs
        eval("document.all.PDA" + op + ".value=deci(lcosto,3)")
        SERTOT()
    }


    function AVICTO(op) {
        op = parseInt(op, 10)
        yy = parseFloat(eval("document.all.TTO" + op + ".value"))
        xx = parseFloat(eval("document.all.ACTO" + op + ".value"))
        if (isNaN(eval("document.all.ACTO" + op + ".value")))
            xx = 0
        //alert(yy)
        aa = xx * yy
        eval("document.all.TA" + op + ".innerHTML=deci(aa,2)")
        eval("document.all.ACTO" + op + ".value=deci(xx,4)")

        AVITOT()
    }


    function SERTOT() {
        tope = parseInt('<%=k%>')
        tota = 0
        for (l = 1; l < tope; l++) {
            tota += parseFloat(eval("document.all.PDA" + l + ".value"))
        }
        document.all.totalservicio.value = redondea(tota, 2)
       

    }


    function AVITOT() {
        tope = parseInt('<%=XON%>', 10)
        tota = 0
        for (b = 0; b < tope; b++) {
            tota += parseFloat(eval("document.all.TA" + b + ".innerHTML"))
        }
        document.all.AVITOT.value = deci(tota, 3)

    }

    function suma() {
        m = parseInt('<%=ubound(atal)%>', 10)
        xxx = 0
        for (u = 0; u <= m; u++) {
            cc = parseFloat(toInt(eval("document.all.T" + u + ".value")))
            xxx += (isNaN(cc) == false) ? parseInt(cc, 10) : 0;
        }
        document.all.CAN.value = FormatNumber(Math.floor(xxx), 0, true, false, true, false)

  
        minutos();

    }

    function valmin() {
        minutos()
        return true;
    }


    function kacum(op, opp) {
        op = parseInt(op, 10)
        opp = parseInt(opp, 10)
        por = eval("document.all.POR" + op + ".value")
        gkgs = eval("document.all.TT" + opp + ".value")
        tt = (por / 100) * gkgs
        kk = eval("document.all.KH" + op + ".value=deci(tt,3)")
        cc = parseFloat(eval("document.all.CH" + op + ".value"))

        eval("document.all.CH" + op + ".value=redondea(cc,2)")
        pda = tt * cc
        eval("document.all.TH" + op + ".value=deci(pda,3)")

        x = parseInt('<%=j%>', 10)
        kk = 0
        for (p = 1; p < x; p++) {
            kk += parseFloat(eval("document.all.TH" + p + ".value"))
            // actualizar el valor de COSTO US$ con la variacion del precio
            de = parseFloat(eval("document.all.TH" + p + ".value"))
        //    eval("document.all.V" + p + ".value=deci(de,3)")
            ee = eval("document.all.KH" + p + ".value")
       //     eval("document.all.Q" + p + ".value=deci(ee,3)")
        }
        document.all.totalhilo.value = redondea(kk, 3)
       
    
    }

    function KKkgs(ff, jj) {
        var pos = parseInt(ff, 10)
        var jos = parseInt(jj, 10)
        var t = document.all.TELAS;
        lar = parseFloat(eval("document.all.LAR" + pos + ".value"))
        cun = parseFloat(eval("document.all.CUN" + pos + ".value"))
        mer = parseFloat(eval("document.all.MERI" + pos + ".value"))
        ss = (cun * (1 + (mer / 100)))
        eval("document.all.TT" + pos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")
        eval("document.all.KH" + jos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")
        ss = (lar * (1 + (mer / 100)))
        eval("document.all.MM" + pos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")

    }
    


    function TOTALIZA() {

        AVITOT()
        SERTOT()
        kacum(1, 1)

        minutos()
        suma()
   

        // CANTIDAD AL 100%
        CIEN = toInt(document.all.CAN.value)
        if (parseInt(CIEN, 10) == 0)
            CIEN = 0

   

   

    }


 

</script>
</body>

<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</html>