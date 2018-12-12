<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID = 2057 %>
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
</style>

<script type="text/jscript" language="jscript">
var NUMTAL=0
var aHil = new Array()
var aDes = new Array()
var aKgs = new Array()
var aVal = new Array()
var aRut = new Array()
var aMat = new Array()
var totalhilados = 0

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

//    window.resizeTo(1100, 700)
//  window.moveTo(0,0)
return true
}

</script>
<%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
    Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.CursorLocation   = 3
	RS3.CursorType       = 3    
	RS3.LockType         = 1 
    Set RS4 = Server.CreateObject("ADODB.Recordset")
	RS4.CursorLocation   = 3
	RS4.CursorType       = 3    
	RS4.LockType         = 1 
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
	CLI	= Request.QueryString("CLI")
    cot	= Request.QueryString("cot")
	CAD =	" exec FICHACOTI_HEAD '"&PRO&"' , '"&VER&"' " 
	
	'response.Write(cAD)
	rs.open cad , cnn
	
		RS.MOVEFIRST
	OBS= RS("OBS")	
    coti = RS("COTI")
    OREDEN = rs("OREDEN")
    dim gKgs, gmerruta, gctorut

	IF RS("COTI")= "AUTO" THEN
	    marka = 0	       
		titulo = "COTIZACION #"
	else
	    marka = 1
		titulo = "COTIZACION # " + trim(rs("COTI"))
	END IF
    
dim dolkil
 dolkil = 0
    
    
    %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FICHA COTIZADOR</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<script language="javascript" type="text/javascript">
RENTAS = parseFloat('<%=CDBL(RS("IMPU")) %>')/100


</script>
</head>
<body onLoad="document.all.thisForm.pack.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAcoti.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="15%"><img src="imagenes/CERRAR.gif" style="cursor:hand;" onClick="window.close()" /></td>		
         <td width="15%">
            <table cellpadding="0" cellspacing="0" border="0" align="center" width="100%">
		        <tr height="25px">
                    <td align="center" class="texto ">Tipo de Cambio:  </td>
                </tr><%if cdbl(rs("tcam")) > 0 then cambio = cdbl(rs("tcam")) else cambio = bajo%>
                <tr>
                    <td align="center" class="texto ">
                        <input id="TCAM" name="TCAM" value='<%=formatnumber(cambio,3,,true)%>' class="cambio" readonly tabindex=-1 >
                    </td>
                </tr>
		    </table> 
         </td>	
         <td align = "center" class="TALASBLUE" width="40%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%>&nbsp;</td></tr>
		    </table> 
         </td>
         <td width="30%" align="right"><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("EST")%>&CLI=<%=RS("CLI")%>" width="150" ID="Img1" /></td>
    </tr>
</table>  
<iframe  width="100%" onload="calcHeight();" style="display:none" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="200" align="middle"></iframe>
  <script language="jscript" type="text/jscript">
      pro = '<%=rs("pro") %>'
      ver = '<%=rs("ver") %>'
      cli = '<%=rs("cli") %>'
      est = '<%=rs("est") %>'
      tel = '<%=rs("tel") %>'
      mot = '<%=rs("mot") %>'
      tem = '<%=rs("tem") %>'
   </script>
    <%PRO = RS("PRO") 
        VER = RS("VER")
        TOTPPDA = 0%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">   
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">G E N E R A L E S :</td>	
	</tr>
</table>
<table width="80%" border="0" cellspacing="1" cellpadding="1" align="left">

  <tr>
    <td width="5%"  class="american2">PROTO :</td>
    <td width="15%"  class="TEXTO"><%=rs("PRO")%>-<%=rs("ver")%></td>
    <td width="5%"  class="american2">CLIENTE : </td>
    <td width="15%" class="TEXTO"><%=rs("cli")%>-<%=RS("NOM")%></td>
    <td width="5%"  class="american2">ESTILO:</td>
    <td width="50%" class="TEXTO" ><%=rs("est")%>-<%=rs("ecl")%> - <%=rs("des")%></td>
    
  </tr>

  <tr>
    <td width="5%"  class="american2">TELA</td>
    <td colspan="5">
        <%destela =  trim(rs("tel")) & " - " & trim(rs("dtel")) & " DEN " & trim(rs("PA")) & "  gr/mt2 - REN  "%>
        <%if rs("aa")> 0 then destela = destela & (rs("ra")) else destela = destela & (rs("rt"))%>    
        <input class="TEXTO" value="<%=destela%>" style="width:100%" /></td>
   </tr>


   <tr>
    <td class="american2">GRUPO TELA :</td>
    <td class="TEXTO" colspan="5" ><%=trim(rs("mot"))%></td>
   </tr>

   <tr>
        <td colspan="6" class="american2">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">   
	            <tr valign="middle">
		            <td width="10%"  class="american2">Pack : </td>
                    <td width="10%"  class="TEXTO"><input id="pack" name="pack" value="<%=rs("pkc")%>" class="DATOSyellow" 
                    onchange="packs();TOTALIZA()" style="width:50px"></td>
                    <td width="10%"  class="american2" >Packs x Caja: </td>
                    <td width="10%" class="TEXTO"><input id="boxpack" name="boxpack" value="<%=rs("pkcj")%>" class="DATOSyellow" 
                    onchange="packs();TOTALIZA()"  style="width: 50px"></td>
                    <td width="10%"  class="american2" >Cajas de : </td>
                    <%if isnull(rs("pkc")) = true or isnull(rs("pkcj")) = true then  to1 = 0 else to1 =  cint(rs("pkc")) * cint(rs("pkcj")) %>
                    <td width="5%" class="TEXTO"><input id="Totpk" name ="Totpk"value="<%=to1%>" class="texto" readonly tabindex=-1 ></td>
                    <td width="45%" class="american2" >&nbsp;prendas</td>
	            </tr>
            </table>
        </td>
    </tr>

  <tr>
   <%DAD = "SELECT TALLA,PROP, cant, orden FROM [PROTO-TALLAS] WHERE PROTO = '"&PRO&"' AND VERSION = '"&VER&"' ORDER BY ORDEN"
  ' RESPONSE.WRITE(DAD)
   RS2.OPEN DAD, CNN 
              IF RS2.RECORDCOUNT > 0 THEN 
                dim atal , ACAN, cantidPREND
                cantidPREND = 0
                atal = array()
                ACAN = ARRAY()
                RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                        <%redim preserve ATAL(ubound(atal)+1)
                        redim preserve acan(ubound(acan )+1)
                        atal(ubound(atal))= rs2("talla")
                        ACAN(ubound(ACAN))= rs2("CANT")
                        cantidPREND =   cantidPREND + RS2("Cant")
                       RS2.MOVENEXT%>
                   <%LOOP%>    
              <%END IF%>     

    <td rowspan="3" colspan="6" class="american2" >
    <table  border="0" cellspacing="0" cellpadding="0" align="left">
        <tr>
            <td width="9%" class="american2" align="right">TALLAS :&nbsp;&nbsp; </td>
            <%FOR I = 0 TO 9%>
               <td align="center" class="texto" width="8%">
                <%if i <= UBOUND(ATAL) then  %>
               <input id="x<%=i%>" name="x<%=i%>" value="<%=trim(atal(i))%>" class="texto" style="text-align:center" tabindex=-1 readonly/>
               <%end if %>
               </td>    
            <%NEXT%>
            <td width="10%" class="american2" align="center">&nbsp;TOTAL PRENDAS&nbsp;</td>
        </tr>   

        <tr>
            <td width="9%" class="american2" align="right">CANTIDADES :&nbsp;&nbsp; </td>
            <%FOR I = 0 TO 9%>
               <td align="center" class="TEXTOblue" width="8%">
                <%if i <= UBOUND(ATAL) then  %>
                    <input id="T<%=i%>" name="T<%=i%>" value="<%=formatnumber(TRIM(acan(i)),0,,true)%>" class="DATOSyellow"  onchange="suma();TOTALIZA()"  style="width:50px">   
                <%end if%>
            </td> 
           <%NEXT%>
           <td width="10%"><input id="CAN" name="CAN" readonly class="TEXTOblue" style="text-align:center; padding-right:10px;" tabindex="-1" 
           value="<%=formatnumber(cantidPREND,0,,true) %>"></td>   
        </tr> 

        <tr>
           <td width="10%" class="american2"  align="right">COBERTURA :&nbsp;&nbsp; </td>
           <td align="center" class="TEXTOblue" width="8%"><input id="COBE" name="COBE" value="<%=TRIM(RS("COBE"))%>" class="DATOSyellow" onchange="suma();TOTALIZA()"  style="width:50px"></td>    
           <td  class="american2"  align="right">Valor Minuto :&nbsp;&nbsp; </td>
           <td align="center" class="TEXTOblue" width="8%"><input id="VALMIN" name="VALMIN" value="<%=TRIM(RS("MINU"))%>" class="DATOSyellow" onchange="valmin();TOTALIZA()"  style="width:50px"></td>    
           <td colspan="7" width="64%">&nbsp;</TD>
           <td width="10%"><input id="TOTA" name="TOTA" readonly class="textoblue" style="color:Red; text-align:center; padding-right:10px;" tabindex="-1" value="<%=formatnumber(cantidPREND*(1+(rs("cobe")/100)),0,,true) %>"></td>   
        </tr> 
    </table>
    
</td>
    </tr> 
</table>
<%rs2.close%>  
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">T E L A S :</td>	
	</tr>
</table>

<table border="0" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("BORDE"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" id="TELAS">
    <tr valign="middle" bgcolor="<%=(Application("color1"))%>"  class="american2">
        <td width="1%">Id</td>
        <td width="5%">&nbsp;&nbsp;COD</td>
        <td width="71%">TELA</td>
        <td width="4%" align="center">Anc. Mt.</td>
        <td width="4%" align="center">Tot Mt.</td>
        <td width="5%" align="center">Un. Kg.</td>
        <td width="3%" align="center">% MER.</td>
        <td width="3%" align="center">Tot Kg&nbsp;</td>
        <td width="3%" align="center">$ Kg</td>
        <td width="3%" align="center">$ Pda.</td>      
    </tr>    
    <tr>
        <td colspan="10">
            <hr noshade style="width: 100%; color: darkgreen; height:3 px;  border: double darkgreen;" />
        </td>
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
       HILOS = 0  
       cuenta = 0
       dim aTelas(30)
       for rest=0 to 30
        aTelas(rest) = 0
       next
        %>
	<%DO WHILE NOT RS2.EOF%>
		<tr valign="top" > 
         <td width="1%"><input  type="text"  id="ID1<%=i%>" name="ID1<%=i%>" value="<%=trim(rs2("id"))%>"    class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>      
            <td width="4%"  align="center"><input id="TEL1<%=i%>" name="TEL1<%=i%>" value="<%=trim(rs2("TEL"))%>"  
            type="text"  class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>
            <td width="50%" class="TEXTO" align="left"><%=rs2("DTE")%> <br /><font color="black"><%=rs2("com") %></font></td>
            <td width="3%"  class="texto" align="right"><input type="text" id="ANC<%=i%>" name="ANC<%=i%>" value="<%=formatnumber(rs2("ANC"),2,,,true)%>" class="BARRASDER" readonly tabindex="-1" /></td>
            <td width="3%"  class="texto" align="right"><input type="text" id="LAR<%=i%>" name="LAR<%=i%>" value="<%=formatnumber(rs2("LAR"),2,,,true)%>" class="BARRASDER" readonly tabindex="-1" /></td>
            <td width="5%" class="TEXTO" align="right"><input type="text" id="CUN<%=i%>" name="CUN<%=i%>" value="<%=formatnumber(rs2("CUN"),3,,,true)%>"  class="BARRASDER" readonly tabindex="-1" /></td>
         <td width="3%"><input type="text" id="MERI<%=i%>" name="MERI<%=i%>" value="<%=trim(rs2("MER"))%>" class="DATOSyellow" maxlength="2" onchange="this.value=toInt(this.value);KKkgs('<%=i%>','<%=j%>');TOTALIZA();"  style="width:50px" /></td>   
          <td width="3%"><input type="text" id="TT<%=i%>" name="TT<%=i%>" value="<%=formatnumber(rs2("TOT"),3,,,true)%>" class="barrasder" readonly tabindex="-1"/></td>
           
      
       <td width="3%"><input type="text" id="USD<%=i%>" name="USD<%=i%>" value="<%=formatnumber(RS2("CTO"),3,,,true)%>" class="DATOSYELLOW" onchange="this.value=toInt(this.value)" style="width:50px"  /></td>
       <td width="3%"><input type="text" id="UST<%=i%>" name="UST<%=i%>" value="<%=formatnumber(rs2("TOT")*RS2("CTO"),3,,,true)%>" class="barrasder" readonly tabindex="-1" style="width:50px" /></td>  
     <%aTelas(i)= rs2("TOT")*RS2("CTO")%>     
    </tr> 
    <tr><%TEL = RS2("tel") 
        RUT = RS2("RUT")
        id = rs2("id")
        %>
        <td colspan="10" width="100%"> 
            <table border="0" width="100%" cellpadding="0" cellspacing="0" >
                <tr valign="top">
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr bgcolor="<%=application("barra")%>">
                                <td colspan="8" align="center" class="TITULITO">DETALLE HILADO</td>
                            </tr>
                            <tr BGCOLOR="<%=APPLICATION("color1")%>">
                             <td class="TITULITO">i</td>
                               <td class="TITULITO">COD</td>
                               <td class="TITULITO">DESCRIPCION</td>
                               <td class="TITULITO">%</td>
                               <td class="TITULITO">TIT</td>
                               <td class="TITULITO">KGS</td>
                               <td class="TITULITO">CTO Kg</td> 
                               <td class="TITULITO">CTO Pda.</td> 
                            </tr>
                            <%ID = RS2("ID")           
                            CAD = " EXEC FICHACOTI_hilo '"&TEL&"', '"&ID&"', '"&COTI&"',  '"&j&"' " 
                           'response.write(cad)
                            RS3.OPEN CAD, CNN
                            IF RS3.RECORDCOUNT > 0 THEN
                                RS3.MOVEFIRST%>
                                 <%cuenta = cuenta + 1 %>
                                 <script type="text/jscript" language="jscript">
                                     ru = parseInt('<%=cuenta%>', 10)
                                     aMat[ru] = parseInt('<%=rs3.recordcount%>', 10)
                                </script>
                                
                                <%DO WHILE NOT RS3.EOF%>
                                 <%codtel = rs2("tel")
                                 idi = rs2("id")
                                 cotizacion = rs("coti")
                                 dadi = "select replace(isnull(costo,0.1),',','.') as costo from cotihilado where cotizacion = '"&cotizacion&"'  " & _ 
                                        " and tela = '"&codtel&"' and id = '"&idi&"' and orden = '"&j&"' "
                                 '   response.write(dadi)
                                rs4.open dadi, cnn
                                if rs4.recordcount  > 0 then PKOS = REPLACE(cdbl(rs4("CosTO")),",",".") else pkos = 0
                                PPTO = REPLACE(cdbl(rs3("por")),",",".")/100 
                                PTOT = REPLACE(cdbl(rs2("TOT")),",",".") 
                                dd =  cdbl(PPTO)*cdbl(PTOT) * CDBL(PKOS)
                                dolkil = cdbl(dolkil) + cdbl(dd)  
                                rs4.close
                                %>
                                    <tr>
                                    <td class="texto"><%=j%></td>
                                       <td class="TEXTO"><input type="text" id="HH<%=j%>" name="HH<%=j%>" value="<%=UCASE(TRIM(RS3("HIL")))%>" class="BARRAS" readonly tabindex="-1" /> 
                                       </td>
                                       <td class="TEXTO"><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                                       <td class="TEXTO"><input type="text" id="POR<%=j%>" name="POR<%=j%>" value="<%=rs3("POR") %>" class="BARRAS" readonly tabindex="-1" /></td>
                                       <td class="TEXTO"><%=UCASE(TRIM(RS3("TIT")))%></td>
                                       <td class="TEXTO"><input type="text" id="KH<%=j%>" name="KH<%=j%>" value="" class="BARRAS" readonly tabindex="-1" /></td>
                                      
                                       
                                       <td class="TEXTO"><input type="text" id="CH<%=j%>" name="CH<%=j%>" value="<%=formatnumber(pkos,2,,true)%>" class="DATOSyellow" onchange="kacum('<%=j%>','<%=i%>');" style="width:50px"  />
                                        </td>
                                        <td class="TEXTO"><input type="text" id="TH<%=j%>" value="<%=FORMATNUMBER(DD,3,,TRUE) %>" class="barrasder" readonly tabindex="-1"/></td>  
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
                                           totalhilados +=  parseFloat(deci(pda,3))
                                        //   eval("document.all.TH" + x + ".value=deci(pda,3)")
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
                                <td colspan="6" align="center" class="TITULITO">RUTA DE TELA</td>
                            </tr>
                            <%cad = "EXEC FICHACOTI_RUTA '"&COT&"' , '"&TEL&"' , '"&RUT&"', "&ID&", '"&PRO&"',  '"&VER&"' "  
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
                                <td class="TITULITO">CTO US$</td>
                                <td class="TITULITO">US$ Pda</td>
                            </tr>
                            <%IF RS3.RECORDCOUNT>0 THEN
                                RS3.MOVEFIRST%>
                                <%DO WHILE NOT RS3.EOF%>
                                <tr>
                                    <td><input id="SER<%=k%>" name="SER<%=k%>" value="<%=UCASE(TRIM(RS3("codigo")))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1" /></td>
                                    <td class="TEXTO"><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                                    <td><input id="UNT<%=K%>" name="UNT<%=K%>" type="text" value="<%=UCASE(TRIM(RS3("UNIDAD")))%>" class="BARRAS" readonly tabindex="-1" /></td>
                                    <td><input type="text" id="M<%=k%>" name="M<%=k%>" value="<%=TRIM(RS3("MERMA"))%>" class="DATOSyellow" style="width:40px;" /></td>
                                    <%if isnull(rs3("costo")) or cdbl(rs3("costo")) <=0 then cct = 0.01 else cct = rs3("costo")%>
                                    <td><input type="text" id="CTO<%=k%>" name="CTO<%=k%>" value="<%=(formatnumber(cct,2,,,true))
                                    %>" class="DATOSyellow" onchange="RUTCTO('<%=k%>','<%=i%>');" style="width:60px" /></td>  
                                    <%
                                    if isnull(RS2("TOT")) = true then gkgs= 0 else gkgs = cdbl(rs2("tot"))
                                    if isnull(RS3("merma")) = true then gmerruta= 0 else gmerruta = 1 + (cdbl(rs3("merma"))/100)
                                    if isnull(RS3("costo")) = true then gctorut= 0.01 else gctorut = cdbl(rs3("costo")) * gmerruta
                                    PPDA = gkgs * gctorut
                                    TOTPPDA = TOTPPDA + PPDA
                                    %>
                                    <td><input type="text" id="PDA<%=K%>" name="PDA<%=K%>" value="<%=formatnumber(PPDA,3,,,true)%>" class="barrasDER" readonly tabindex="-1" />
                                    </td>
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
    <tr><td colspan="10"><hr noshade style="width: 100%; color:darkgreen; height:3 px;  border: double darkgreen;" /></td></tr> 
		<%RS2.MOVENEXT%>
        <%I = I+1%>
	<%LOOP%>
    <%cuentatela = I %>
    <tr>
        <td width="47%" colspan="11"      style="text-align:right">
            <table border="0" cellpadding="0" width="100%" cellspacing="0" >
                <tr>
                    <td  class="TITULITORIGHT"><b>&nbsp;&nbsp;&nbsp;&nbsp;HILADO US$/Pda.</b></td>
                    <td width="3%"><input id="totalhilo" name="totalhilo" value="<%=FORMATNUMBER(DOLKIL,3,,TRUE) %>" readonly class="TEXTOredder" tabindex="-1" style="width:50" tabindex=-1></td>
                    <td width="47%" class="TITULITORIGHT"><b>&nbsp;&nbsp;&nbsp;&nbsp;SERVICIOS US$/Pda.</b></td>
        <td width="3%"><input id="totalservicio" name="totalservicio"  value="<%=FORMATNUMBER(TOTPPDA,2,,TRUE) %>"  readonly class="TEXTOredder" tabindex="-1"  style="width:50" tabindex=-1></td>
                </tr>
            </table>     
        </td>
        
    </tr>
</table>
</td>
</tr>
</table>









<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle" bgcolor="#f7d975" >
		<td  ><font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>R E Q U E R I M I E N T O &nbsp;&nbsp;&nbsp;&nbsp;D E &nbsp;&nbsp;&nbsp;&nbsp; C O M P R A :</td>	  
	</tr>
</table>
<!--(j - 1) es el número de fibras total   j inicia en 1 y solo pueden haber 6 fibras por tela según tabla 
        cn = numero de fibras que puede tener una tela y va de 1 a 6
        H = para la codificacion del hilado
        D = descripcion del hilado
        V = PRECIO POR KILO
        Q = consumo del hilado EN KGS
        rs3 está cerrado después de haber mostrado la ruta
        -->
<table border="0" cellpadding="0" width="100%" cellspacing="0" bordercolordark="<%=(Application("BORDE"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" id="Table2">
    <tr valign="top" >
        <td width="73%" >
            <table width="100%" border="0" cellpadding="0" cellspacing="0">   
            <tr class="titulito">
                <td width="10%">COD. Hilado</td>  
                <td width="60%">Descripción</td>  
                <td width="10%">Consumo Kgs. Unit.</td>    
                <td width="10%">Costo US$ Uni.</td>  
            </tr>
	          <%for cn=1 to j-1 %>
                <tr>
                    <td width="10%"><input id="H<%=cn%>" name="H<%=cn%>" readonly class="textoblue1000" tabindex="-1" value="<%=cn%>"></td>  
                    <td width="60%"><input id="D<%=CN%>" name="D<%=CN%>" readonly class="textoblue1000" tabindex="-1" value="<%=cn%>" style="text-align:left;width:100% "></td>  
                    <td width="10%"><input id="Q<%=cn%>" name="Q<%=cn%> " readonly class="textoblue1000" tabindex="-1" value="<%=cn%>"></td>    
                    <td width="10%"><input id="V<%=cn%>" name="V<%=cn%>" readonly class="textoblue1000" tabindex="-1" value="<%=cn%>"></td>  
                </tr>
              <%next %>
              <tr class="textored" align="right">
                <td colspan="3">Costo Materia Prima US$ / Prenda: &nbsp; &nbsp; &nbsp;  </td>    
                <td><input id="comprahilo" name="comprahilo" readonly class="textored" style="text-align:right; padding-right:10px" tabindex="-1" value=""></td>  
            </tr>
            </table>
        </td>
        <td width="1%" >&nbsp;</td>
        <td width="20%" >
            <table width="100%" border="0" cellpadding="0" cellspacing="0">   
	            <tr  class="american2">
                    <td width="90%">Ancho Tendido :</td>  
                    <td><input id="ANCHOT" name="ANCHOT"  class="datosyellow"  value="<%=formatnumber(cdbl(RS("ANCHOT")),3,,true)%>"  onchange="consumo();TOTALIZA()" style="width:100%" ></td> 
                </tr>
                <tr  class="american2">
                    <td width="90%">Largo Tendido :</td>  
                    <td><input id="LARGOT" name="LARGOT" class="datosyellow"  value="<%=formatnumber(cdbl(RS("LARGOT")),3,,true)%>" onchange="consumo();TOTALIZA()" style="width:100%"  ></td> 
                </tr>
                <tr  class="american2">
                    <td width="90%">Eficiencia Tizado % :</td>  
                    <%IF (CDBL(RS("EFIC"))) = 0 THEN EFICIENCIA = 80 ELSE EFICIENCIA = RS("EFIC")%>
                    <td><input id="EFICI" name="EFICI" class="datosyellow"  value="<%=EFICIENCIA%>" style="width:100%" onchange="TOTALIZA()"></td> 
                </tr>
                 <tr  class="american2">
                    <td width="90%">Densidad PM2 :</td>  
                    <td><input id="PM2" name="PM2"  class="textoblue1000" readonly tabindex="-1" value="<%=RS("PM2")%>"></td> 
                </tr>
                <tr  class="american2">
                    <td width="90%">Rendimiento Mts :</td>  
                    <td><input id="RENDM" name="RENDM" readonly class="textoblue1000" tabindex="-1" value="<%=formatnumber(RS("REND"),3,,true)%>"></td> 
                </tr>
                <tr class="american2">
                    <td width="90%">Consumo Grs :</td>  
                    <td><input id="CONKI" name="CONKI" readonly class="textoblue1000" tabindex="-1" value="<%=FORMATNUMBER(RS("CONSU"),2,,TRUE) %>"></td> 
                </tr>
            </table>
        </td>
        
    </tr>
         
</table>


<table width="100%" border="0" cellpadding="0" cellspacing="0">   
	<tr valign="middle">
		<td  CLASS="TALASORANGE">A V I O S :</td>	  
	</tr>
</table>
<table border="0" cellpadding="2" width="100%" cellspacing="0" bordercolordark="<%=(Application("BORDE"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" id="Table1">
    <tr valign="middle" bgcolor="<%=(Application("color1"))%>"  class="american2" align="center">
        <td width="1%">Id</td>
        <td width="3%">COD</td>
        <td width="20%">AVIO</td>
        <td width="25%">COMENTARIO</td>
        <td colspan="2" width="1%">A.</td>       
        <td  width="1%">Uni</td>
        <td width="2%">CONS<br />Uni</td>
        <td width="2%">% <BR />MER.</td>
        <td width="5%">CONS <bR />Tot</td>
        <td width="5%">$ <BR />UNI</td>
        <td width="5%">$ <BR />Tot</td>
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
           <td class="TEXTO" "><input type="text" id="COD<%=xon%>" name="COD<%=xon%>" value="<%=trim(rs2("AVI"))%>" class="textoblue1000" readonly tabindex="-1" />
           </td>
           <td class="textoblue1000"><%=rs2("DES")%></td>
           <td align="left"><input type="text" id="OBS<%=xon%>" name="OBS<%=xon%>" value="<%=rs2("OBS")%>" class="textoblue1000" style="text-align:left;" readonly tabindex="-1" /></td>
           <td class="TEXTO"><%=rs2("TPP")%></td>
           <td class="TEXTO"><input id="EXX<%=XON%>" name="EXX<%=XON%>" value="<%=rs2("exx")%>" style="display:none"></td>
           <td><input type="text" id="UNI<%=XON%>" name="UNI<%=XON%>" value="<%=rs2("UNI")%>" style="text-align:center; font-weight:400"  class="textoblue1000"  readonly tabindex="-1" size="5px"/></td>
           <td><input type="text" id="CON<%=xon%>" name="CON<%=xon%>" value="<%=formatnumber(rs2("CON"),3,,,true)%>" class="TEXTOblue" style="text-align:right; padding-right:10px; size:20px" readonly tabindex="-1" size="5" /></td><%IF RS2("MRR")=0 THEN MRR = 10 ELSE MRR = RS2("MRR") %>
           <td class="TEXTO"><input type="text" id="MRR<%=xon%>" name="MRR<%=xon%>" value="<%=MRR%>" class="DATOSYELLOW" style="border-right-width:thick; width:30px; text-align:center"  /></td>
           
           <td><input type="text" id="TTO<%=xon%>" name="TTO<%=xon%>" value="<%=formatnumber(rs2("TTO"),3,,,true)%>" class="TEXTOblue" style="border-right-width:thick; width:50px; text-align:right; padding-right:5px;" readonly tabindex="-1" /></td>

           <%if cdbl(rs2("cto")) > 0 then costo = cdbl(rs2("cto")) else if cdbl(rs2("cto1")) > 0 then costo = cdbl(rs2("cto1")) else costo = cdbl(rs2("cto2")) %>
           
           <td class="TEXTO" align="right"><input type="text" id="ACTO<%=XON%>" name="ACTO<%=XON%>" value="<%=FORMATNUMBER(COSTO,5,,,TRUE)%>" class="DATOSyellow" onchange="AVICTO('<%=XON%>','<%=i%>');TOTALIZA()" style="border-right-width:thick; width:50px; text-align:right; padding-right:5px;"  /></td>
           <%torpe = torpe + costo*cdbl(rs2("tto"))%>
         
           <td class="TEXTO" align="right" id="TA<%=XON%>"><%=formatnumber(costo*cdbl(rs2("tto")),2,,,true)%>&nbsp;&nbsp;        
           </td>
        </tr>    
		<%RS2.MOVENEXT%>
        <%I = I+1%>
        <%xon = xon + 1%>
	<%LOOP%>
    <%maxi = I%>
    <%mai = I%>
    <tr><td colspan="11" class="DESCnegroder"><b>Avios US$/Pda.</b></td>
    <td><input id="AVITOT" name="AVITOT" readonly class="TEXTOredder" tabindex="-1" value="<%=formatnumber(torpe,2,,,true)%>" style="width:50"></td>
    </tr>
</table>
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>">   
	<tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" width="50%">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>T I E M P O S :</b></font>
		</td>	
		<td bgcolor="#f7d975">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O M E N T A R I O S :</b></font>
		</td>	
	</tr>
    <tr>
        <td width="50%" colspan="1" valign="top">
            <table border="1" cellpadding="3" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
            <tr bgcolor="<%=application("barra") %>" align="center">
                <td class="titulito" width="10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td class="titulito" width="10%">CORTE</td>
                <td class="titulito" width="10%">COSTURA</td>
                <td class="titulito" width="10%">ACABADOS</td>
                <td class="titulito" width="10%">ADICIONALES</td>
            </tr>
            <tr>    
                <td class="titulito" bgcolor="<%=application("barra") %>">Minutos</td>
                <td class="titulito"><input id="MINCOR" name="MINCOR" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("mcor")%>" /></td>
                <td class="titulito"><input id="MINCOS" name="MINCOS" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("mcos")%>" /> </td>
                <td class="titulito"><input id="MINACA" name="MINACA" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("maca")%>" /></td>
                <td class="titulito"><input id="MINADI" name="MINADI" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("madi")%>" /></td>
            </tr>
            <tr>    
                <td class="titulito" bgcolor="<%=application("barra") %>">% Eficiencia</td>
                <td class="titulito"><input id="EFICOR" name="EFICOR" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("ecor")%>" /></td>
                <td class="titulito"><input id="EFICOS" name="EFICOS" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("ecos")%>" /></td>
                <td class="titulito"><input id="EFIACA" name="EFIACA" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("eaca")%>" /></td>
                <td class="titulito"><input id="EFIADI" name="EFIADI" class="DATOSyellow" onChange="this.value=toInt(this.value);TOTALIZA()" value="<%=rs("eadi")%>" /></td>
                
            </tr>
            <tr bgcolor="<%=application("barra") %>">    
                <td class="titulito" bgcolor="<%=application("barra") %>">Minutos Totales</td>
                <td class="titulito"><input id="TOTCOR" name="TOTCOR" class="DESCnegroder" readonly tabindex="-1" value="<%=formatnumber(rs("tcor"),2,,true) %>"/></td>
                <td class="titulito"><input id="TOTCOS" name="TOTCOS" class="DESCnegroder" readonly tabindex="-1" value="<%=formatnumber(rs("tcos"),2,,true) %>" /></td>
                <td class="titulito"><input id="TOTACA" name="TOTACA" class="DESCnegroder" readonly tabindex="-1" value="<%=formatnumber(rs("taca"),2,,true) %>"/></td>
                <td class="titulito"><input id="TOTADI" name="TOTADI" class="DESCnegroder" readonly tabindex="-1" value="<%=formatnumber(rs("tadi"),2,,true) %>" /></td>
            </tr>
            <tr bgcolor="<%=application("barra") %>">    
                <td class="titulito" bgcolor="<%=application("barra") %>">Desc. Adicionales:</td>
                <td class="titulito" colspan="4" bgcolor="<%=application("color2") %>"><input id="DESADI" name="DESADI" class="DATOSyellow" value="<%=rs("desadi")%>" maxlength="200" style="text-align:left;width:100%" /></td>
            </tr>    
            </table>
        </td>
        <td valign="top">
            <table border="1" cellpadding="3" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>" style="height:100%">
            <tr bgcolor="<%=application("barra") %>" align="center">
              <td class="titulito" width="50%"  style="text-align:left;  vertical-align:text-top">D.D.P.</td>
              <td width="50%" class="TITULITO"  style="text-align:left;  vertical-align:text-top" bgcolor="<%=application("barra") %>">Comercial</td>

            </tr>
            <tr bgcolor="<%=application("barra") %>" align="center">
               <td class="TEXTOblue" width="50%" style="text-align:left;  vertical-align:text-top; background-color:White"><%=OBS%></td>
               <td width="50%" class="titulito"  ><textarea id="OBSERVA" name="OBSERVA" rows="7" class="DATOSyellow" style="text-align:left; width=100%; vertical-align:text-top" ><%=rs("obscot")%></textarea></td>
            </tr>
        </table>
        </td>
    </tr>
</table>


<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" width="50%">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O S T O S &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D I R E C T O S :</b></font>
		</td>	
        <td bgcolor="#f7d975" width="50%">
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>G A S T O S :</b></font>
		</td>
	</tr>
    <tr>
		<td width="50%" valign="top">
			<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
                <tr bgcolor="<%=application("barra") %>" align="center" class="TITULITO">
                    <td colspan="2">Concepto</td><td width="25%">US $ Unit.</td><td width="25%">US $ ORDEN</td>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="2" style=" background-color:#F0F0F0">Tela</td>
                    <%telast = 0
                    for resum=0 to 30
                        TELAST = TELAST + atelas(resum)
                    next
                    if  CDBL(RS("CANT"))  = 0 then cantprendas = 1 else cantprendas =  CDBL(RS("CANT")) %>
                    <td><input id="UNITEL" name="UNITEL" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(TELAST,2,,true) %>"></td>
                    <td><input id="TOTTEL" name="TOTTEL" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(TELAST*CANTPRENDAS,2,,true) %>"></td>

                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Hilado</td>
                    <%IF TELAST > 0 THEN 
                        DOLKIL = 0
                        TOTPPDA =0 
                      END IF  %>
                    <td><input id="UNIHILO" name="UNIHILO"  readonly class="textored" value="<%=formatnumber(dolkil,2,,true) %>" style="text-align:right; padding-right:10px; color:navy" tabindex="-1"></td>
                    <td><input id="TOTHILO" name="TOTHILO" readonly class="textored" value="<%=formatnumber(dolkil*CDBL(RS("CANT")),2,,true) %>"style="text-align:right; padding-right:10px; color:navy" tabindex="-1"></td>
                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Servicios </td>
                    <td><input id="UNISERV" name="UNISERV" readonly class="textored" value="<%=FORMATNUMBER(TOTPPDA,2,,TRUE) %>" style="text-align:right; padding-right:10px; color:navy" tabindex="-1"></td>
                    <td><input id="TOTSERV" name="TOTSERV" readonly class="textored"  value="<%=FORMATNUMBER(TOTPPDA*CDBL(RS("CANT")),2,,TRUE) %>" style="text-align:right; padding-right:10px; color:navy" tabindex="-1"></td>
                    <%totserv = TOTPPDA %>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="2" style="background-color:#F0F0F0">Avios </td>
                    <%
                    
                    if  CDBL(RS("CANT"))  = 0 then cantprendas = 1 else cantprendas =  CDBL(RS("CANT")) 
                    if  CDBL(RS("AVITOT"))  = 0 then aviostotal = 1 else aviostotal =  CDBL(RS("AVITOT")) 
                    AVIT = aviostotal * cantprendas
                    %>
                    <td><input id="UNIAVI" name="UNIAVI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(avit/cantprendas,2,,true) %>"></td>
                    <td><input id="TOTAVI" name="TOTAVI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(avit,2,,true) %>"></td>
                
                </tr>
                <tr  class="TITULITO">
                    <td colspan="4" style=" background-color:#F0F0F0">Minutos</td>
                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Corte </td>
                    <td><input id="CORUNI" name="CORUNI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(cdbl(rs("mincOR")),2,,true) %>"></td>
                    <td><input id="CORTOT" name="CORTOT" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1"  value="<%=formatnumber(cdbl(rs("mincoR"))*cantprendas,2,,true) %>"></td>
                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Costura </td>
               
                    <td><input id="COSUNI" name="COSUNI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1" value="<%=formatnumber(cdbl(rs("mincos")),2,,true) %>"></td>
                    <td><input id="COSTOT" name="COSTOT" readonly class="textored" style="text-align:right; padding-right:10px; color:navy"  tabindex="-1" value="<%=formatnumber(cdbl(rs("mincos"))*cantprendas,2,,true) %>"></td>
                
                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Acabados </td>
                    <td><input id="ACAUNI" name="ACAUNI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy"  tabindex="-1"  value="<%=formatnumber(cdbl(rs("minACA")),2,,true) %>"></td>
                    <td><input id="ACATOT" name="ACATOT" readonly class="textored" style="text-align:right; padding-right:10px; color:navy"  tabindex="-1"  value="<%=formatnumber(cdbl(rs("minACA"))*cantprendas,2,,true) %>"></td>
                </tr>
                <tr  class="TITULITO">
                    <td>&nbsp;</td><td>Otros </td>
                    <td><input id="ADIUNI" name="ADIUNI" readonly class="textored" style="text-align:right; padding-right:10px; color:navy"  tabindex="-1"  value="<%=formatnumber(cdbl(rs("minADI")),2,,true) %>"></td>
                    <td><input id="ADITOT" name="ADITOT" readonly class="textored" style="text-align:right; padding-right:10px; color:navy" tabindex="-1"  value="<%=formatnumber(cdbl(rs("minADI"))*cantprendas,2,,true) %>"></td>
                </tr>
                    <%totmin = ((rs("mincoR")*cantprendas) + (rs("mincos")*cantprendas) + (rs("minACA")*cantprendas) + (rs("minADI")*cantprendas) )%>
               
               
               
                <tr  class="TITULITO" bgcolor="<%=application("barra") %>">
                    <td>&nbsp;</td><td>Sub Total Costo Directo</td>
                 
                 
                    <%STCD =  cdbl(telast)+ cdbl(TOTPPDA)+ CDBL(RS("AVITOT"))+ CDBL(RS("MINCOR"))+ CDBL(RS("MINCOS"))+CDBL(RS("MINACA"))+ CDBL(RS("MINADI"))  + cdbl(dolkil) 
                    
                    
                    %>   

                    <td><input id="COSTOUNI" name="COSTOUNI" readonly value="<%=FORMATNUMBER(STCD,2,,TRUE) %>" class="textored" style="text-align:right; padding-right:10px; color:navy"  tabindex="-1"></td>
                    <td><input id="COSTOTOT" name="COSTOTOT" readonly class="textored" value="<%=FORMATNUMBER(STCD*CDBL(RS("CANT")),2,,TRUE) %>"  style="text-align:right; padding-right:10px; color:navy" tabindex="-1"></td>
                </tr>
                <tr  class="TITULITO" bgcolor="<%=application("barra") %>">
                    <td>&nbsp;</td><td>Valor de la Prenda FOB</td>
                    <td align="right"><input id="FOBUNI" name="FOBUNI"  class="datosyellow" style="text-align:right; padding-right:10px"  value="<%=formatnumber(cdbl(rs("fob")),2,,,true)%>"  onblur="this.value=toInt(this.value)" onchange="TOTALIZA()" ></td>
                    <td><input id="FOBTOT" name="FOBTOT" readonly class="textored" value='<%=formatnumber(OREDEN,2,,rue) %>' style="text-align:right; padding-right:10px" tabindex="-1"></td>
                </tr>
            </table>
		</td>	
        <td width="50%" style="vertical-align:top">
			<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
                <tr bgcolor="<%=application("barra") %>" align="center" class="TITULITO">
                    <td colspan="4">Concepto</td>
                    <td width="15%">US $ ORDEN</td>
                    <td width="15%">US $ UNIT</td>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="2">Comisión Agente</td>
                     <td colspan="2" ><input id="COMI" name="COMI"  value = '<%=formatnumber(rs("comi"),2,,true)%>' class="datosyellow" style="text-align:right; padding-right:5px; width:100%" onchange="TOTALIZA()" onblur="this.value=toInt(this.value)"  ></td>
                     <%rgs = 0 %>
                    <td><input id="RGSTOT" name="RGSTOT" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px"  tabindex="-1"></td>
                    <td><input id="RGSUNI" name="RGSUNI" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px"  tabindex="-1"></td>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="2">Aduanas y Despacho</td>
                    <td colspan="2">
                        <select id="TIPEMB" name="TIPEMB" class="datosyellow" style="width:100%" onchange="TOTALIZA();">
                            <option></option>
                            <option value="S">Sea</option>
                            <option value="A">Air</option>
                            <option value="D">DHL</option>
                        </select>
                    </td><%IF len(trim(RS("EMB"))) = 0  then adua = 0 else IF RS("EMB") = "A" THEN ADUA = CDBL(RS("AIR")) ELSE IF RS("EMB") = "S" THEN ADUA = CDBL(RS("SEA")) ELSE IF RS("EMB") = "D" THEN ADUA = CDBL(RS("DHL")) ELSE ADUA = ""%>
                    <td ><input id="ADUTOT" name="ADUTOT" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px" tabindex="-1" value="<%=formatnumber(ADUA,2,,trUe) %>" ></td><%if cdbl(rs("cant")) > 0 then canped = cdbl(rs("cant")) else canped = 1%>
                    <td ><input id="ADUUNI" name="ADUUNI" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px" value="<%=formatnumber(adua/canped,2,,true) %>" tabindex="-1"></td>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="6">Financiamiento </td>
                </tr>
                <tr  class="TITULITO" align="center">
                    <td >% - F1 - F2 </td>
                    <td><input id="PORFIN" name="PORFIN" class="datosyellow" style="text-align:right; width:100%" value="<%=formatnumber(rs("FINPOR"),2,,true)%>" onblur="this.value=toInt(this.value);TOTALIZA()" ></td>
                    <td><input id="FAC1" name="FAC1" class="datosyellow" style="text-align:right; width:100%" value="<%=formatnumber(rs("factor1"),2,,true)%>" onblur="this.value=toInt(this.value);TOTALIZA()"  ></td>
                    <td><input id="FAC2" name="FAC2" class="datosyellow" style="text-align:right; width:100%" value="<%=formatnumber(rs("factor2"),0)%>" onblur="this.value=toInt(this.value);TOTALIZA()"></td><%if len(trim(rs("finord"))) > 0 then finord = rs("FINORD") else finord = 0%>
                    <td ><input id="FINTOT" name="FINTOT" readonly class="TEXTONAVYREADONLY"  style="text-align:right; padding-right:5px" tabindex="-1" value="<%=formatnumber(finord   ,2,,true) %>"></td><%if len(trim(rs("finuni"))) > 0 then finuni = rs("FINuni") else finuni = 0%>
                    <td ><input id="FINUNI" name="FINUNI" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px" tabindex="-1" value="<%=formatnumber(finuni,2,,true) %>"></td>
                </tr>
                <tr  class="TITULITO">
                    <td colspan="2">Certintex</td><%if  rs("certi") > 0 then ceru = formatnumber(100 *  cdbl(rs("certi")),2,,true) else ceru = 0 
                    if  rs("certi") > 0 then cermon = 100 else cermon = 0 %>
                    <td colspan="2"><input id="CERCOM" name="CERCOM" class="datosyellow" style="text-align:right; padding-right:5px; width:100%" onblur="this.value=toInt(this.value);TOTALIZA()" value="<%=formatnumber(rs("certi"),2,,true) %>"></td>
                    <td ><input id="CERTOT" name="CERTOT" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px"  tabindex="-1" value ="<%=formatnumber(ceru,2,,true)%>"></td>
                    <td ><input id="CERUNI" name="CERUNI" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px"  tabindex="-1" value="<%=formatnumber(cermon,2,,true)%>"></td>
                </tr>
                
                <tr  class="TITULITO">
                    <td colspan="4">Otros</td>
                    <td ><input id="OTRTOT" name="OTRTOT" class="datosyellow" style="text-align:right; padding-right:5px; width:100%;" onblur="this.value=toInt(this.value);TOTALIZA()" value="<%=formatnumber(rs("otros"),2,,true) %>"></td>
                    <td ><input id="OTRUNI" name="OTRUNI" readonly class="TEXTONAVYREADONLY" style="text-align:right; padding-right:5px"  
                        value="<%=formatnumber(rs("otros")/canped,2,,true) %>" tabindex="-1"></td>
                </tr>
                <tr  class="TITULITO" bgcolor="<%=application("barra") %>">
                    <td colspan="4">Sub Total Costos Indirectos</td>
                    <%tgast = rgs + adua + finord + ceru + cdbl(rs("otros")) %>
                    
                    <td><input id="INDITOT" name="INDITOT" readonly class="textored" style="text-align:right; padding-right:5px" value="<%=formatnumber(tgast,2,,true) %>" tabindex="-1"></td>
                    <td><input id="INDIUNI" name="INDIUNI" readonly class="textored" style="text-align:right; padding-right:5px" value="<%=formatnumber(tgast/canped,2,,true) %>"  tabindex="-1"></td>
                </tr>
               
           </table>
		</td>
	</tr>
</table>


<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle" bgcolor="#f7d975" >
		<td bgcolor="#f7d975" width="50%" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>B A L A N C E :</b></font>
		</td>	
	</tr>
</table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr bgcolor="<%=application("barra") %>" align="center" class="american2">
        <td width="33%" class="TITULITO" align="left" valign="middle" style="height:20px">INGRESOS</td>
        <td width="34%" class="TITULITO" align="left" valign="middle" style="height:20px">EGRESOS</td>
        <td width="33%" class="TITULITO" align="left" valign="middle" style="height:20px">UTILIDAD</td>
    </tr>
    <tr>
        <td valign="top">
            <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO">
                    <td width="50%" colspan="3">Carta de Crédito:</td>
                    <td width="50%"><input id="CARTA" name="CARTA" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(rs("oreden"),2,,true)%>"></td>
                </tr>
                <tr class="TITULITO">
                    <td width="45%">Draw Back:</td>
                    <td width="4%"><input id="DRAW" name="DRAW" class="datosyellow" style="width:100%"  value="<%=cdbl(rs("draw"))%>" onblur="this.value=toInt(this.value);TOTALIZA()" ></td>
                    <td width="1%">%</td>
                    <td width="50%"><input id="DBACK" name="DBACK" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(rs("drawtot"),2,,true)%>"></td>
                </tr>
                
            </table>
        </td>
        <td valig="top">
             <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO">
                    <td width="50%">Materia Prima:</td>
                    <% if telast > 0 then
                        TILO = TELAST * CANPED
                        ELSE
                     tilo =  (dolkil*canped)+ (totppda*canped)
                     END IF%>
                    <td width="50%"><input id="THILO" name="THILO" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(tilo,2,,true)%>"></td>
                </tr>
                <tr class="TITULITO">
                    <td width="50%">Avios:</td>
                    <td width="50%"><input id="TAVIO" name="TAVIO" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=FORMATNUMBER(AVIT,2,,TRUE) %>"></td>
                </tr>
                <tr class="TITULITO">
                    <td width="50%">Servicios Confección:</td>
                    <td width="50%"><input id="TSER" name="TSER" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=FORMATNUMBER(TOTMIN,2,,TRUE) %>"></td>
                </tr>
                <tr class="TITULITO">
                    <td width="50%">Gastos:</td>
                    <td width="50%"><input id="TGAS" name="TGAS" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(tgast,2,,true) %>"></td>
                </tr>
                <%DRATO = CDBL(rs("drawtot"))+CDBL(RS("OREDEN")) %>
                <%toteg = tgast + totmin + avit+ tilo %>
            </table>
        </td>
        <td valign="top">
            <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO">
                    <td width="50%" colspan="3">Utilidad Bruta:</td>
                    <%brutas = drato-toteg %>
                    <td width="50%"><input id="UBRU" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(brutas,2,,true) %>"></td>
                </tr>
                <tr class="TITULITO" >
                    <td width="45%" >Impuesto a la Renta:</td>
                    <td width="4%"><input id="RENTA" name="RENTA" class="datosyellow" style="width:100%" onblur="this.value=toInt(this.value);TOTALIZA();" value="<%=cdbl(rs("impu"))%>" ></td>
                    <td width="1%">%</td>
                    <%rentas = cdbl(rs("impu"))/100 * (drato - toteg) %>
                    <td width="50%"><input id="UIMP" name="UIMP" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(rentas,2,,true) %>"></td>
                </tr>
                
            </table>
        </td>
    </tr>
    <tr class="TITULITO" style="background-color:'<%=(application("barra"))%>'">
        <td>
            <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO" style="background-color:'<%=(application("barra"))%>'">
                    <td width="50%">TOTAL US$ INGRESOS:</td>
                    
                    <td width="50%"><input id="TOTING" name="TOTING" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(DRATO,2,,true)%>"></td>
                </tr>
            </table>
        </td>
        <td>
            <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO" style="background-color:'<%=(application("barra"))%>'">
                    <td width="50%">TOTAL US$ EGRESOS:</td>
                   
                    <td width="50%" align="right"><input id="TEGR" name="TEGR" class="TEXTOred" tabindex="-1" readonly style="text-align:right;padding-right:5px;   " value="<%=formatnumber(toteg,2,,true) %>"></td>
                </tr>
            </table>
            <%netas = brutas - rentas %>
        </td>
        <td>
            <table border="0" cellpadding="1" width="100%" cellspacing="0">
                <tr class="TITULITO">
                    <td width="45%">Utilidad Neta:</td>
                    <%if oreden  = 0 then oreden= 1%>
                    <%poruti =(netas * 100 )/oreden  %>
                    <td width="4%"><input id="PORCEN" name="PORCEN" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(poruti,2,,true)%>"></td>
                    <td width="1%">%</td>
                    <td width="50%"><input id="UNET" name="UNET" class="TEXTONAVYREADONLY" tabindex="-1" readonly value="<%=formatnumber(netas,2,,true) %>"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<input id="NUMTALLAS" name ="NUMTALLAS" style="display:none"/>
<table align="center" border="0" cellpadding="10"> 
<tr><td><input type="button" id="boton" value="" style="cursor:hand;" onClick="graba()" /></td>
<td><img src="imagenes/xl2.png" style="cursor:hand;" onClick="IMPRIMEC()" /></td></tr>
</table>

<script type="text/jscript" language="jscript">
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;
	//document.all.ADUTOT.value = '<%=formatnumber(rs("adua"),2,,true) %>'
	nn = '<%=trim(rs("emb")) %>'
    //alert(nn)
	if (nn == 'S')
	    document.all.TIPEMB.selectedIndex = 1
	if (nn == 'A')
	    document.all.TIPEMB.selectedIndex = 2
	if (nn == 'D')
	    document.all.TIPEMB.selectedIndex = 3   

function consumo(){
    a1 = parseFloat(document.all.LARGOT.value)
    a2 = parseFloat(document.all.PM2.value)
    a3 = parseFloat(document.all.ANCHOT.value)
    document.all.CONKI.value = cerea(parseFloat(a1 * a2 * a3), 3)
    DIO = 1000 / (a3 * a2)
    document.all.RENDM.value = cerea(parseFloat(DIO), 3)
}

function minutos()
{   document.all.MINCOR.value = document.all.MINCOR.value
    document.all.MINCOS.value = document.all.MINCOS.value
    document.all.MINACA.value = document.all.MINACA.value
    document.all.MINADI.value = document.all.MINADI.value
    document.all.EFICOR.value = document.all.EFICOR.value
    document.all.EFICOS.value = document.all.EFICOS.value   
    document.all.EFIACA.value = document.all.EFIACA.value
    document.all.EFIADI.value = document.all.EFIADI.value
    document.all.TOTCOR.value = toInt(document.all.MINCOR.value*100/document.all.EFICOR.value)
    document.all.TOTCOS.value = toInt(document.all.MINCOS.value*100/document.all.EFICOS.value)
    document.all.TOTACA.value = toInt(document.all.MINACA.value*100/document.all.EFIACA.value)
    document.all.TOTADI.value = toInt(document.all.MINADI.value*100/document.all.EFIADI.value)
    // TOTAL DE PRENDAS CON COBERTURA
    gg = parseInt(toInt(document.all.TOTA.value), 10)
    if (gg == 0)
        gg = 1  
}


function finan() {
    cdatos = parseFloat(toInt(document.all.CAN.value))
    if (isNaN(cdatos) == true)
        cdatos = 1

    datos = parseFloat(toInt(document.all.FOBUNI.value))
    finpor = parseFloat('<%=cdbl(rs("finpor"))%>')
    fact1 = parseFloat('<%=cdbl(rs("factor1"))%>')
    fact2 = parseFloat('<%=cdbl(rs("factor2"))%>')

    //alert('<%=rs("FINORD") %>')
    finan1 = ((datos * cdatos) * finpor)
    finan1 = finan1 * fact1 / fact2
    finan2 = (finan1 / cdatos)
    if (isNaN(finan2) == true) finan2 = '0.00'
    //
  document.all.FINTOT.value = '<%=FORMATNUMBER(FINORD,2,,TRUE)%>'
  document.all.FINUNI.value = '<%=FORMATNUMBER(FINUNI,2,,TRUE)%>'
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
    eval("document.all.CTO" + op + ".value=deci(lcosto,2)")
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


function SERTOT()
{
tope = parseInt('<%=k%>')
tota = 0
for (l=1; l<tope; l++)
    {   tota += parseFloat(eval("document.all.PDA" + l + ".value"))
    }
document.all.totalservicio.value = tota
document.all.UNISERV.value = tota
gg = parseInt(toInt(document.all.TOTA.value),10)
//alert(parseInt(document.all.TOTA.value,10))
if (gg ==0)
    gg = 1
gto = tota * gg

document.all.TOTSERV.value = deci((gto  ),3)

}


function AVITOT() {
    tope = parseInt('<%=XON%>', 10)
    tota = 0
    for (b = 0; b < tope; b++) {
        tota += parseFloat(eval("document.all.TA" + b + ".innerHTML"))
    }
    document.all.AVITOT.value = deci(tota,3)
    document.all.UNIAVI.value = deci(tota, 3)
    gg = parseInt(toInt(document.all.TOTA.value) ,10)
    if (gg ==0)
        gg = 1
    gto = tota * gg
    //alert(gg)
    document.all.TOTAVI.value = deci((gto),3)
 
}

function suma() {
    m = parseInt('<%=ubound(atal)%>', 10) 
    xxx = 0

    for (u = 0; u < m; u++) {
        cc = parseFloat(toInt(eval("document.all.T" + u + ".value")))
        xxx += (isNaN(cc)== false ) ? parseInt(cc, 10) : 0;
    }
    document.all.CAN.value = FormatNumber(Math.floor(xxx), 0, true, false, true, false)
    pero = document.all.COBE.value
    if (isNaN(pero) == true) { 
        pero = 100}
    grantot = (1 + (pero / 100)) * xxx
    document.all.TOTA.value = FormatNumber(Math.floor(grantot), 0, false, false, true, false);
    //alert(document.all.TOTA.value )
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
    if (parseInt(cc, 10) == 0 || isNaN(cc) == true)
    { cc = 0 }
    parseFloat(eval("document.all.CH" + op + ".value=cc"))
    eval("document.all.CH" + op + ".value=deci(cc,2)")
    pda = tt * cc
    eval("document.all.TH" + op + ".value=deci(pda,3)")

    x = parseInt('<%=j%>', 10)
    kk = 0
    for (p = 1; p < x; p++) {
        kk += parseFloat(eval("document.all.TH" + p + ".value"))
        // actualizar el valor de COSTO US$ con la variacion del precio
        de = parseFloat(eval("document.all.TH" + p + ".value"))
        eval("document.all.V" + p + ".value=deci(de,3)")
        ee = eval("document.all.KH" + p + ".value")
        eval("document.all.Q" + p + ".value=deci(ee,3)")
    }
    document.all.totalhilo.value = kk
    document.all.UNIHILO.value = document.all.totalhilo.value
    document.all.comprahilo.value = document.all.UNIHILO.value
    // TOTA.value = total de prendas con cobertura incluida
    pase = toInt(document.all.TOTA.value)
    if (parseInt(pase,10)==0 || isNaN(pase)== true)
    {   pase = 0    }
    pase = parseInt(pase,10)* parseFloat(document.all.totalhilo.value)
    document.all.TOTHILO.value = pase
 }

function KKkgs(ff, jj) {
    var pos = parseInt(ff, 10)
    var jos = parseInt(jj, 10)
var t = document.all.TELAS;
    lar = parseFloat(eval("document.all.LAR" + pos + ".value"))
    cun = parseFloat(eval("document.all.CUN" + pos + ".value"))
    mer = parseFloat(eval("document.all.MERI" + pos + ".value"))
	ss = (cun * (1+(mer / 100)) )
	eval("document.all.TT" + pos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")
	eval("document.all.KH" + jos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")
    ss = (lar * (1+( mer/100)))
    eval("document.all.MM" + pos + ".value=toDeci(FormatNumber(ss, 3, true, false, true, false),3)")
   
}

function graba()
{   ok= veri()

if (ok == true) {
    //alert( parseInt('<%=UBOUND(ATAL) %>',10))
    //return true;
        cad = 'comun/inserFichacoti.asp?telm=' + '<%=CINT(MAXIM)%>' + '&avim=' + '<%=xon-1%>' + '&PRO=' + pro
        cad += '&VER=' + ver + '&CLI=' + cli 
        cad += '&cot='  +'<%=cot%>' + '&NUMTAL=' + parseInt('<%=UBOUND(ATAL) %>',10)
        cad += '&rutas=' + aRut + '&mate=' + aMat+ '&est=' + est + '&tem=' + tem + '&tel=' + tel + '&mot=' + mot 
        document.all.thisForm.NUMTALLAS.value = parseInt('<%=UBOUND(ATAL) %>', 10)
       // alert(cad)
        //window.open (cad)
         thisForm.action = cad
         thisForm.submit()
       
    }
}

function veri() {
    XXi = parseInt('<%=cuentatela%>', 10) -1
    
    ji = parseInt('<%=j%>', 10)
    ki = parseInt('<%=k%>', 10)-1
    xoni = parseInt('<%=xon%>', 10)
    //  COSTO DE TELAS
    // si tiene valor el costo de tela, no debe validar el hilado ni la ruta
    // para tener un contador dinámico el inicio debe ser en 0 y aMat tiene la cantidad
    // de fibras a partir del indice 1, o sea que puedo poner el 0 en 1 y funka
    aMat[0] = 1
    for (XXX = 1; XXX <= XXi; XXX++) {
        dolar = isNaN(parseFloat(eval("document.all.USD" + XXX + ".value")))
        if ( dolar == true)
            eval("document.all.USD" + XXX + ".value=0")
        if (parseFloat(eval("document.all.USD" + XXX + ".value")) <= 0) {   // costo de hilado
            for (x = aMat[0]; x < aMat[XXX]; x++) 
            {   if (parseFloat(eval("document.all.CH" + x + ".value")) <= 0) 
                {   alert("Favor Revisar que todo el Hilado tenga costo  "+ x);
                    return false;
                }
            }
            // costo de servicio de ruta de tela
            for (y = 1; y < ki; y++) 
            {   if (parseFloat(eval("document.all.CTO" + y + ".value")) <= 0) 
                {   alert("Favor revisar que todos los Servicios de la Ruta de Telas tengan precio");
                    return false;
                }
            }
        }
        // TERMINANDO EL FOR... LE SUMAMOS LO RECORRIDO AL INDICE 0 PARA QUE SIGA LA SIGUIENTE FIBRA/TELA
        aMat[0] += aMat[XXX] 
       // alert(aMat[0]) 
    }
// costo unitario de avios
    for (z=1; z<xoni; z++ ){
        if(parseFloat(eval("document.all.ACTO" + z + ".value")) <=0)
        {   alert("Favor revisar que todos los avios tengan costo")
            return false;
        }
    }
    // Precio FOB
    ffoo = parseFloat(toInt(document.all.FOBUNI.value))
    
    if (ffoo <=0) {
        alert("No ha colocado el valor FOB")
        document.all.FOBUNI.focus()
        return false;
    }

    // VALOR MINUTO
    ffoo = parseFloat(toInt(document.all.VALMIN.value))
    
    if (isNaN(ffoo)) {
        alert("No ha colocado el valor Minuto")
        document.all.VALMIN.focus()
        return false;
    }


    // CANTIDAD TOTAL A COTIZAR
    doo = parseFloat(toInt(document.all.CAN.value))
    if (doo <= 0) {
        alert("No tenemos una cantidad aprox. para cotizar?")
        document.all.T0.focus()
        return false;  
    }
     // LARGO DEL TENDIDO
    ffoo = parseFloat(toInt(document.all.ANCHOT.value))
    
    if (ffoo <=0) {
        alert("No ha colocado el Ancho del Tendido")
        document.all.ANCHOT.focus()
        return false;
    }
    // LARGO DEL TENDIDO
    ffoo = parseFloat(toInt(document.all.LARGOT.value))
    
    if (ffoo <=0) {
        alert("No ha colocado el Largo del Tendido")
        document.all.LARGOT.focus()
        return false;
    }
    // MINUTOS
    ff1 = parseFloat(toInt(document.all.MINCOR.value))
    if (ff1 <=0) {
        alert("No ha colocado los Minutos de corte")
        document.all.MINCOR.focus()
        return false;     }
    ff1 = parseFloat(toInt(document.all.MINCOS.value))
    if (ff1 <=0) {
        alert("No ha colocado los Minutos de Costura")
        document.all.MINCOS.focus()
        return false;     }
        ff1 = parseFloat(toInt(document.all.MINACA.value))
    if (ff1 <=0) {
        alert("No ha colocado los Minutos de Acabados")
        document.all.MINACA.focus()
        return false;     }
    // EFICIENCIAS
    ff1 = parseFloat(toInt(document.all.EFICOR.value))
    if (ff1 <=0) {
        alert("No ha colocado las Eficiencias de Corte")
        document.all.EFICOR.focus()
        return false;     }
    ff1 = parseFloat(toInt(document.all.EFICOS.value))
    if (ff1 <=0) {
        alert("No ha colocado las Eficiencias de Costura")
        document.all.EFICOS.focus()
        return false;     }
        ff1 = parseFloat(toInt(document.all.EFIACA.value))
    if (ff1 <=0) {
        alert("No ha colocado las Eficiencias de Acabados")
        document.all.EFIACA.focus()
        return false;     }
    document.all.CONKI.value = toInt(document.all.CONKI.value)
    return true;
}





function packs() { 
uno = parseInt(document.all.pack.value,10)
dos = parseInt(document.all.boxpack.value,10)
if (isNaN(uno) != true && isNaN(dos) != true)
    document.all.Totpk.value = uno * dos
}
function aduanas() {
    emb = '<%=formatnumber(emb,2,,true)%>'
    //document.all.ADUTOT.value = emb
    nn = document.all.TIPEMB.value
    if (nn == 'S')
        document.all.TIPEMB.selectedIndex = 1
    if (nn == 'A')
        document.all.TIPEMB.selectedIndex = 2
    if (nn == 'D')
        document.all.TIPEMB.selectedIndex = 3         
}
function Emba() {
  n = parseInt(document.all.TIPEMB.selectedIndex,10)
  //  var subcadena = trim(t.rows(pos).cells(6).innerText);
  //  var elemento = thisForm.TON;
  //  thisForm.TON.selectedIndex = seleindice(subcadena, elemento);
  //  alert(n)
switch(n)
 {
 case 1:
   document.all.ADUTOT.value = '<%=formatnumber(sea,2,,true)%>'
   break;
 case 2:
   document.all.ADUTOT.value = '<%=formatnumber(air,2,,true)%>'
   break;
  case 3:
    document.all.ADUTOT.value = '<%=formatnumber(dhl,2,,true)%>'
 default:
     document.all.ADUTOT.value = 0
 }
}


function TOTALIZA() {
return true;
    AVITOT()
    SERTOT()
    kacum(1, 1)
    finan()
    packs()
    aduanas() 
    Emba()
    minutos()
    suma()
    consumo()
    
    // CANTIDAD AL 100%
    CIEN = toInt(document.all.CAN.value)
    if (parseInt(CIEN, 10) == 0)
        CIEN = 0

    corte = toInt(document.all.TOTCOR.value) * document.all.VALMIN.value
    document.all.CORUNI.value = toInt(corte)
    document.all.CORTOT.value = toInt(corte * CIEN)

    datos1 = toInt(document.all.TOTCOS.value) * document.all.VALMIN.value
    document.all.COSUNI.value = toInt(datos1)
    document.all.COSTOT.value = toInt(datos1 * CIEN)

    datos2 = toInt(document.all.TOTACA.value) * document.all.VALMIN.value
    document.all.ACAUNI.value = toInt(datos2)
    document.all.ACATOT.value = toInt(datos2 * CIEN)

    datos3 = toInt(document.all.TOTADI.value) * document.all.VALMIN.value
    document.all.ADIUNI.value = toInt(datos3)
    document.all.ADITOT.value = toInt(datos3 * CIEN)

    document.all.TOTHILO.value = parseFloat(document.all.UNIHILO.value) * CIEN
    document.all.TOTSERV.value = parseFloat(document.all.UNISERV.value) * CIEN
    document.all.TOTAVI.value  = parseFloat(document.all.UNIAVI.value) * CIEN

// grantotal de la orden
    gt1 = 0
// grantotal unitario
    gt2 = 0
uno = (parseFloat(document.all.UNIHILO.value) + parseFloat(document.all.UNISERV.value) + parseFloat(document.all.UNIAVI.value) +  parseFloat(document.all.CORUNI.value) + parseFloat(document.all.COSUNI.value) +  parseFloat(document.all.ACAUNI.value) +  parseFloat(document.all.ADIUNI.value) )

document.all.COSTOUNI.value = (uno);


uno =  (parseFloat(toInt(document.all.TOTHILO.value)) + parseFloat(toInt(document.all.TOTSERV.value)) + parseFloat(toInt(document.all.TOTAVI.value)) +  parseFloat(toInt(document.all.CORTOT.value)) + parseFloat(toInt(document.all.COSTOT.value)) +  parseFloat(toInt(document.all.ACATOT.value)) +  parseFloat(toInt(document.all.ADITOT.value)))

document.all.COSTOTOT.value = ((toInt((uno, 3)) ))
document.all.TOTHILO.value = ((toInt((document.all.TOTHILO.value))))
document.all.TOTSERV.value = ((toInt((document.all.TOTSERV.value))))
document.all.TOTAVI.value = ((toInt((document.all.TOTAVI.value))))
document.all.CORTOT.value = ((toInt((document.all.CORTOT.value))))
document.all.COSTOT.value = ((toInt((document.all.COSTOT.value))))
document.all.ACATOT.value = ((toInt((document.all.ACATOT.value))))
document.all.ADITOT.value = ((toInt((document.all.ADITOT.value))))

datos0 = toInt(document.all.FOBUNI.value)

// FOB
fob = toInt(document.all.FOBUNI.value)
document.all.FOBUNI.value = cerea(document.all.FOBUNI.value, 3)
document.all.FOBTOT.value = cerea(FormatNumber(toInt((datos0 * CIEN, 3)), 3, false, false, true, true))

// RGS

    PORCEN = toInt(document.all.COMI.value)/100
    rgs = datos0 * CIEN * PORCEN
    CANTID = datos0 * PORCEN

    document.all.RGSTOT.value = cerea(FormatNumber(toInt(rgs), 2, true, true, true, true), 2)
    document.all.RGSUNI.value = cerea(FormatNumber(toInt(CANTID), 2, true, true, true, true), 2)

// costos de aduanas y despacho
    adua = parseFloat(toInt(document.all.ADUTOT.value))
    CIEN = parseInt(CIEN,10)   
    aduaU = adua / CIEN

    if (aduaU > 0) {
        document.all.ADUUNI.value = cerea(FormatNumber(toInt((aduaU)), 2, true, true, true, true),2)
    }
    else
        document.all.ADUUNI.value = '0.00'
    document.all.ADUTOT.value = cerea(FormatNumber(Math.floor(adua), 2, false, false, true, true), 2)

// financiamiento
    po = parseFloat(toInt(document.all.PORFIN.value))
    f1 = parseFloat(toInt(document.all.FAC1.value))
    f2 = parseFloat(toInt(document.all.FAC2.value))

    fin = fob * CIEN
    fin = fin * po
    fin = fin * f1
    fin = fin / f2
    document.all.FINTOT.value = toInt((fin))
    funi = 0
    if (parseFloat(CIEN)> 0 )
        funi = fin / CIEN
    
//    document.all.FINUNI.value = cerea(FormatNumber(toInt((funi)), 2, true, true, true, true), 2)
    

// CERTINTEX
// # de muestras por US$ 100

    cer = toInt(document.all.CERCOM.value)

    if (parseFloat(cer) > 0) {
    document.all.CERUNI.value = "100.00"
    document.all.CERTOT.value = cerea(FormatNumber(toInt((cer*100)), 2, true, true, true, true), 2)
    }
    else {
        document.all.CERUNI.value = "0.00"
        document.all.CERTOT.value = "0.00"
    }
// otros gastos
    otr = toInt(document.all.OTRTOT.value)


    if (parseFloat(otr) > 0) {
        document.all.OTRUNI.value = cerea(FormatNumber(toInt((otr/CIEN)), 2, true, true, true, true), 2)
        document.all.OTRTOT.value = cerea(FormatNumber(toInt((otr)), 2, true, true, true, true), 2)
    }
    else {
        document.all.OTRUNI.value = "0.00"
        document.all.OTRTOT.value = "0.00"
    }

//totaliza gastos indirectos...
    gt1  = parseFloat(toInt(document.all.RGSTOT.value)) + parseFloat(toInt(document.all.ADUTOT.value)) + parseFloat(toInt(document.all.FINTOT.value))
    gt1 += parseFloat(toInt(document.all.CERTOT.value)) + parseFloat(toInt(document.all.OTRTOT.value))

    gt2  = parseFloat(toInt(document.all.RGSUNI.value)) + parseFloat(toInt(document.all.ADUUNI.value)) + parseFloat(toInt(document.all.FINUNI.value))
    gt2 += parseFloat(toInt(document.all.CERUNI.value)) + parseFloat(toInt(document.all.OTRUNI.value))


    document.all.INDITOT.value = cerea(FormatNumber(toInt((gt1)), 2, true, true, true, true), 2)
    document.all.INDIUNI.value = cerea(FormatNumber(toInt((gt2)), 2, true, true, true, true), 2)

// BALANCE

    document.all.CARTA.value = cerea(FormatNumber(toInt((fob * CIEN)), 2, true, true, true, true), 2)
    DBK = parseFloat(document.all.DRAW.value) / 100

    DBK = DBK * fob * CIEN

    document.all.DBACK.value = cerea(FormatNumber(DBK, 2, true, true, true, true), 2)
    DBK = DBK + (fob * CIEN)
    document.all.TOTING.value = cerea(FormatNumber(toInt((DBK)), 2, true, true, true, true), 2)

    tilo= parseFloat(toInt(document.all.TOTHILO.value)) + parseFloat(toInt(document.all.TOTSERV.value))
    document.all.THILO.value = cerea(FormatNumber(toInt((tilo)), 2, true, true, true, true), 2)
    tavi = parseFloat(toInt(document.all.TOTAVI.value))
    document.all.TAVIO.value = cerea(FormatNumber(toInt((tavi)), 2, true, true, true, true), 2)
    tese = parseFloat(toInt(document.all.CORTOT.value)) + parseFloat(toInt(document.all.COSTOT.value)) + parseFloat(toInt(document.all.ACATOT.value)) + parseFloat(toInt(document.all.ADITOT.value))
    document.all.TSER.value = cerea(FormatNumber(toInt((tese)), 2, true, true, true, true), 2)
    document.all.TGAS.value = cerea(FormatNumber(toInt((gt1)), 2, true, true, true, true), 2)

    teg = tilo + tavi + tese + gt1
    document.all.TEGR.value = cerea(FormatNumber(toInt((teg)), 2, true, true, true, true), 2)

// UTILIDAD
    BRU = DBK - teg
    document.all.UBRU.value = cerea(FormatNumber(BRU, 2, true, false, true, true), 2)

    rrt = parseFloat(toInt(document.all.RENTA.value))/100
    IMPU = BRU * rrt
    
    document.all.UIMP.value = cerea(FormatNumber(IMPU, 2, true, false, true, true), 2)
    
    NETO = BRU - IMPU

    document.all.UNET.value = cerea(FormatNumber(NETO, 2, true, false, true, true), 2)
    sds = (NETO / teg ) * 100
document.all.PORCEN.value = cerea(sds,2)


    // requerimiento de compra
gogo = parseFloat(document.all.totalhilo.value)
    document.all.comprahilo.value = cerea(FormatNumber(gogo, 3, true, false, true, true), 3)
    consumo()

    
}


xx = parseInt('<%=j%>',10)
kilos = 0
for (mm = 1; mm < xx; mm++) {
	eval("document.all.H" + mm + ".value=aHil[mm]")
	eval("document.all.D" + mm + ".value=aDes[mm]")
	eval("document.all.Q" + mm + ".value=aKgs[mm]")
	eval("document.all.V" + mm + ".value=(aVal[mm])")
}


function IMPRIMEC() {
   
    PRO = '<%=trim(pro) %>'
    VER = '<%=trim(ver) %>'
    CAD = 'REPORTES/PRN_fichacotizacion.ASP?PRO=' + PRO + '&VER=' + VER

    //alert(CAD)
    window.open(CAD);
    return true;
}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>