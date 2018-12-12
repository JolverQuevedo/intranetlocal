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
<%	COD = Request.QueryString("PO")
    CLI = Request.QueryString("cli")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
    rs.open "select nombre  from cliente where codigo = '"&cli&"' ", cnn
    rs.movefirst
    descli = rs("nombre")
    rs.close
    'response.write(descli)
    'response.end
	' valor por defecto del house packing y porcentaje de tallas big
    rs.open "select house, big, XBIG from tb_ctrl"
    rs.movefirst
    house= rs("house")
    big = rs("big")
    Xbig = rs("Xbig")
    rs.close
    ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHApos '"&COD&"' , '"&cli&"'  " 
    
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO ="PO -> " + ucase(trim(DESCLI))

	END IF
    'RESPONSE.END
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body onunload="cerrar('0')" onload="document.all.PO.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAPO.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="cerrar('1')" /></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
         <td id="grab" align="RIGHT" width="10%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="imagenes/disk.gif" />
	     &nbsp;<img id="Img2" alt="COPIA DATOS EN NUEVA PO" style="cursor:pointer;" onClick="graba(2)" src="imagenes/PROTOVER.JPG" /></td>
         <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
	     <input id="COD" name="COD" value="<%=rs("PO")%>" style="display:none;"/></td>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<p></p>
<table width="100%" cellspacing="0" border="1" cellpadding="2">
<tr><td>
            <table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
              <tr valign="middle">
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">PO #:</td>
                    <td width="8%"><input type="text" id="PO" name="PO" value="<%=rs("PO")%>" class="BARRA3" maxlength="20" /></td>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">PROTO-VER:</td>
                     <td width="1%"  bgcolor="<%=(Application("BARRA"))%>"><img src="imagenes/help.gif" border="0" id="estilocli" onClick="help()" alt="" /></td>
                     <%if trim(rs("pro")) <> "" then prov= rs("pro")&"-"&rs("ver") else prov = ""%>
                    <td width="10%"><input type="text" id="PRO" name="PRO" value="<%=prov%>" class="DATOSKHAKI" onblur="bakepro()"/></td>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Destino:</td>
                    <td width="12%"><SELECT id="DESTINO" name="DESTINO" class="DESCRIPTORES">
                    <option value=""></option>
                    <%CAD = "select codigo, nombre from destinos where cliente = '"&cli&"' order by 1"
                    rs2.open CAD , cnn
                    if rs2.recordcount >0 then
                    rS2.movefirst %>
                    <%DO WHILE NOT RS2.EOF%>
                    <option value="<%=rs2("codigo")%>" ><%=rs2("nombre")%></option>
                    <%RS2.MOVENEXT%>
                    <%LOOP %>
                    <%END IF %>
                    <%RS2.CLOSE %>
                    </SELECT>
                    </td>
                    <td width="5%" bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Estilo:</td>
                    <td style="display:none"><input type="text" id="CODEST" name="CODEST" value="<%=rs("CODEST") %>" class="AMERICANnavy" readonly tabindex="-1"/></td>
                    <td width="8%"><input type="text" id="ESTCLI" name="ESTCLI" value="<%=trim(rs("ESTCLI")) %>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                    <td width="20%" style="text-align:left"><input type="text" id="DESEST" name="DESEST" value="<%=rs("DESEST") %>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">OFI:</td>
                    <td width="8%"><input type="text" id="OFI" name="OFI" value="<%=rs("Ofi")%>" class="BARRA3" maxlength="20" readonly tabindex="-1" /></td>
	            </tr>
                </table>
        </td>
        <td rowspan="2" ><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("codest")%>&CLI=<%=RS("CLI")%>" width="50" ID="FOT" readonly tabindex="-1" /></td>
    </tr>
    <tr>
        <td>
            <table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
                <tr>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Cotización:</td>
                    <td width="5%"><input type="text" id="COTI" name="COTI" value="<%=trim(rs("COTI"))%>" class="DESCRIPTORES" readonly tabindex="-1" /></td>
                    <td  width="5%"bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">FOB US$:</td>
                    <td width="5%"><input type="text" id="FOB" name="FOB" value="<%=formatnumber(rs("FOB"),2,,true)%>" class="DESCRIPTORES" readonly tabindex="-1" /></td>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Tip Emb:</td>
                    <td width="5%"><select id="TIP" style="width:100%" name="TIP" class="DESCRIPTORES" >
                           <option></option>
                            <%CAD = "SELECT * FROM tipoembarque WHERE ESTADO = 'A' ORDER BY descripcion"
                            RS2.OPEN CAD, Cnn %>
                            <%if rs2.recordcount <=0 then%>
                                 <option value=''>No Hay tipo de embarques Registrados</option>
                            <%else%>
                                <%rs2.movefirst%>
                                <%do while not rs2.eof%>
                                     <option value="<%=rs2("CODIGO")%>"><%=rtrim(ltrim(ucase(rs2("descripcion"))))%></option>
                                <%rs2.movenext%>
                                <%loop%>
                          <%end if %>
                          <%rs2.close%>
                        </select>
                    </td>
                    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" WIDTH="5%">Fec. Emb:</td>
                    <td width="1%"><A href="javascript:showCal('Calendar1')"><img height=16 
					    src="imageNEs/cal.gif" width=16 border=0></A></td>
                    <td WIDTH="5%"><input type="text" id="EMB" name="EMB" value="<%=rs("emb")%>" 
                    readonly tabindex="-1" class="BARRA3" /></td>  
                    <td  width="2%"bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Gen:</td>
                    <td width="2%"><input type="text" id="CGEN" name="CGEN" value="<%=trim(rs("CGEN"))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>        
                    <td width="5%"><input type="text" id="DGEN" name="DGEN" value="<%=trim(rs("DGEN"))%>" class="DESCRIPTORES" readonly tabindex="-1" /></td>        
                    <td  width="2%"bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">GRUPO TELA:</td>
                    <td width="10%"><input type="text" id="GRUPO" name="GRUPO" value="<%=trim(rs("GTEX"))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>        
                </tr>
            </table>
</td>
</tr>
</table>                  
 <%aLET = ARRAY("0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0")
 dad = " exec FICHAposdeta '"&COD&"'  " 
'RESPONSE.WRITE(DAD)
RS2.OPEN DAD, CNN 
if rs2.recordcount <=0 then 
ff = rs("fob")
dad =   " SELECT '' AS COLOR, 1 AS UBI, '"&ff&"' AS FOB, '' AS T0, '' AS T1, '' AS T2, '' AS T3,   " & _
	    " '' AS T4, '' AS T5, '' AS T6, '' AS T7, '' AS T8, '' AS T9, 0 AS CAN0,           " & _
		" 0 AS CAN1, 0 AS CAN2, 0 AS CAN3, 0 AS CAN4, 0 AS CAN5, 0 AS CAN6,           " & _
		" 0 AS CAN7, 0 AS CAN8, 0 AS CAN9                                                "                       
rs2.close
RS2.OPEN DAD, CNN 
end if      
RS2.MOVEFIRST%>
<%u=1%>
<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%" style="background-color:white">
    <tr style="background-color:'<%=application("barra")%>';"  >
    <td style="width:39%" colspan="2" class="texto">COLORES -- TALLAS </td>
    <td style="width:5%; text-align:center" class="texto">FOB $</td>
        <%FOR I = 0 TO 9%>
            <td align="center" width="5%">
                <%TALLA = "T"&i %>
                <input id="x<%=i%>" name="x<%=i%>" value="<%=RS2(TALLA)%>" class="talas" style="width:100%" tabindex=-1 readonly/>
            </td>    
        <%NEXT%>
        <td width="15%" class="texto" align="center">TOTAL COLOR</td>
    </tr>   
<%DO WHILE NOT RS2.EOF %>   
  <tr  id="LIN<%=U%>" name="LIN<%=U%>">
    <td class="AMERICANNAVY" style="width:1%" id="IT<%=u%>" name="IT<%=u%>"><%=u%></td>
    <td style="width:39%"><input id="COL<%=u%>" name="COL<%=u%>" class="DATOSyellow" style="text-align:left;width:100%" maxlength="30" onfocus="lineas('<%=u%>');" value="<%=rs2("color")%>" /></td>
     <td style="width:4%" ><input id="FOB<%=u %>" name="FOB<%=u%>" class="DATOSyellow" style="text-align:right;width:100%" onblur="precio(this)" value="<%=formatnumber(rs2("fob"),2,,true)%>"/></td>   
            <%FOR I = 0 TO 9%>
               <td align="center" width="5%">
               <%can = "can"&i 
               if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "" %>
                 <input id="C<%=I%><%=aLET(U)%>" name="C<%=I%><%=aLET(U)%>" value="<%=ccc %>" class="DATOSyellow" 
                 onfocus="seleccionar(this)"  style="width:100%" onchange="total('<%=u%>','<%=aLET(U)%>')"/>
              </td>    
            <%NEXT%>
            <td style="width:15%"><input id="TOT<%=u%>" name="TOT<%=u%>" value="" class="texto" style="width:100%;text-align:right;" tabindex=-1 readonly/></td>
  </tr>
<%U = U + 1 %>
<%RS2.MOVENEXT%>
<%LOOP%>
<%' solo tengo 26 letras del alfabetooo
if 36 > u+19 then maximus = u+19 else maximus = 36%>
<%for k=u to maximus %>
<tr id="LIN<%=k%>" name="LIN<%=K%>" style="display:none">
    <td class="AMERICANNAVY" style="width:1%" id="IT<%=k%>" name="IT<%=k%>"><%=k%></td>
    <td style="width:39%"><input id="COL<%=k%>" name="COL<%=k%>" maxlength="30" class="DATOSyellow" style="text-align:left;width:100%" onfocus="lineas('<%=k%>');" /></td>
     <td style="width:4%" ><input id="FOB<%=k%>" name="FOB<%=k%>" class="DATOSyellow" style="text-align:right;width:100%" onblur="precio(this)" value="<%=formatnumber(rs("fob"),2,,true) %>   "/></td>      
            <%FOR I = 0 TO 9%>
               <td align="center" width="5%">
                 <input id="C<%=I%><%=aLET(k)%>" name="C<%=I%><%=aLET(k)%>" value="" class="DATOSyellow" style="width:100%" 
                 onfocus="seleccionar(this)" onchange="total('<%=k%>','<%=aLET(k)%>')" />
              </td>    
            <%NEXT%>
            <td><input id="TOT<%=k%>" name="TOT<%=k%>" value="" class="texto" style="width:100%;text-align:right" tabindex=-1 readonly/></td>
  </tr>
<%next %>
<tr id="FIN<%=K%>" name="FIN<%=K%>" >
    <td class="AMERICANNAVY" style="width:1%" id="IT<%=k%>" name="IT<%=k%>">&nbsp;</td>
    <td style="width:39%"><input id="COL<%=k%>" name="COL<%=k%>" class="TEXTO" style="text-align:right;width:100%" value="SUB-TOTALES POR TALLA : " tabindex=-1 readonly /></td>
     <td style="width:4%" ><input id="FOB<%=k%>" name="FOB<%=k%>" class="TEXTO" style="text-align:right;width:100%" tabindex=-1 readonly  value =""/></td>      
            <%FOR I = 0 TO 9%>
               <td align="center" width="5%">
                 <input id="SUBT<%=I%>" name="SUBT<%=I%>" value="" class="TEXTO" style="width:100%;text-align:right" tabindex=-1 readonly />
              </td>    
            <%NEXT%>
            <td><input id="GRANTOT" name="GRANTOT" value="" class="texto" style="width:100%;text-align:right" tabindex=-1 readonly/></td>
  </tr>
  <tr valign="middle" ><td colspan="14" align="center"  >
    <img id="btnofi" name="btnofi" src="imagenes/ofi.jpg"  onclick="ofis()" style="cursor:pointer; display:block"/>
    <br /></td>
  </tr>
   <tr valign="middle" >
    <td colspan="14" align="left">
            <table  border="0" cellspacing="2" cellpadding="1" align="left" width="100%" style="background-color:white">
                <tr style="background-color:#f7d975"  >
                    <td style="width:39%" colspan="2" class="texto">DATOS ADICIONALES --> O P C I O N A L E S :</td>
                </tr>
                <tr>
                    <td width="20%">
                        <table  border="1" cellspacing="2" cellpadding="1" align="left" width="100%" style="background-color:white">
                            <tr style="background-color:'<%=application("barra")%>';"  >
                                <td class="TITULITO" >House Packing :</td>
                                <td><input id="HOU" name="HOU" type="checkbox" value="<%=rs("house")%>" onclick="house()"/></td>
                                <td width="40%"><input  id="h2" name ="h2" value="<%=formatnumber(rs("house"),2,,,true)%>" class="BARRA3" /></td>
                            </tr>
                            <tr>
                                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Fec. Llegada PO:</td>
                                <td width="1%"><A href="javascript:showCal('Calendar2')"><img height=16 
					                src="imageNEs/cal.gif" width=16 border=0></A></td>
                                <td width="50%"><input type="text" id="LLE" name="LLE" value="<%=rs("lle")%>"  tabindex="-1" class="BARRA3" /></td>  
                            </tr>
                            <tr style="background-color:'<%=application("barra")%>';"  >
                                <td class="TITULITO">Talla BIG :</td>
                                <td><input id="BIG" name="BIG" type="checkbox" value="<%=rs("big")%>" onclick="bbi()" /></td>
                                <td width="40%"><input id="b2" name ="b2" value="<%=formatnumber(rs("big"),2,,,true)%>" class="BARRA3"></td>
                            </tr>
                             <tr style="background-color:'<%=application("barra")%>';"  >
                                <td class="TITULITO">Talla XBIG :</td>
                                <td><input id="XBIG" name="XBIG" type="checkbox" value="<%=rs("Xbig")%>" onclick="Xbbi()" /></td>
                                <td width="40%"><input id="b3" name ="b3" value="<%=formatnumber(rs("Xbig"),2,,,true)%>" class="BARRA3"></td>
                            </tr>
                        </table>
                    </td>
                    <td  width="70% " valign="top">
                        <table  border="1" cellspacing="2" cellpadding="1" align="left" width="100%" style="background-color:white">
                            <tr style="background-color:'<%=application("barra")%>';"  >
                                <td class="TITULITO" >Observaciones :</td>
                            </tr>
                            <tr>
                                <td width="100%"><textarea id="OBSERVA" name="OBSERVA" rows="2" class="estilotextarea3" onkeyup="limita()"><%=rs("obs")%></textarea></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
  </tr>
   <tr valign="middle" ><td colspan="14" align="center"  >
   <iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
   </td></tr>




</table>



<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">
    addCalendar("Calendar1", "Elija una fecha", "EMB", "thisForm")
    addCalendar("Calendar2", "Elija una fecha", "LLE", "thisForm")
    if (trim(document.all.PO.value) == 'AUTO')
        document.all.PO.value = ''

var TOPE= parseInt('<%=k%>',10)

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

	document.all.Img2.style.display = 'none'

var hous = parseFloat('<%=formatnumber(cdbl(RS("house")),2,,,true)%>')
if (hous >  0) {
    document.all.HOU.checked = true
    document.all.h2.value = hous
}
else
    document.all.h2.value = ' '

var bbn = parseFloat('<%=formatnumber(cdbl(RS("big")),2,,,true)%>')
if (bbn > 0) {
    document.all.BIG.checked = true
    document.all.b2.value = bbn
}
else
    document.all.b2.value = ' '

var bbnX = parseFloat('<%=formatnumber(cdbl(RS("Xbig")),2,,,true)%>')
if (bbnX > 0) {
    document.all.XBIG.checked = true
    document.all.b3.value = bbnX
}
else
    document.all.b3.value = ' '

var subcadena ='<%=RS("tip")%>' ;
var elemento = document.all.TIP ;
document.all.TIP.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("CDES")%>' ;
var elemento = document.all.DESTINO ;
document.all.DESTINO.selectedIndex = seleindice(subcadena,elemento);	
document.all.veri.value = TOPE
tto = parseInt('<%=u%>',10)
tto = tto
var lets ="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
lineas('<%=u-1%>')
for (b=1; b<=tto; b++)
    total(b,lets.substring(b-1, (b))  )

if (trim(document.all.OFI.value) != '')
    document.all.btnofi.style.display='none'

llega = '<%=rs("lle") %>'
if (llega == '01/01/1900')
document.all.LLE.value = ''

function ofis() {
    cad = 'comun/newOFIpos.asp?pos=' + trim(document.all.PO.value) + '&ofi=AUTO&codest=' + ltrim(document.all.CODEST.value) + '&cli=' + '<%=Request.QueryString("cli") %>'
   // alert(cad)
  //  document.all.body0.style.display = 'block'
    document.all.body0.src=cad
}
function house() {
    if (document.all.HOU.checked == true) {
        document.all.h2.value = '<%=formatnumber(cdbl(house),2,,,true)%>'
        document.all.HOU.value = '<%=cdbl(house)%>'
    }
    else {
        document.all.h2.value = ' '
        document.all.HOU.value = 0
    }
}

function bbi() {
    if (document.all.BIG.checked == true) {
        document.all.b2.value = '<%=formatnumber(cdbl(big)*cdbl(rs("fob")),2,,,true)%>'
        document.all.BIG.value = '<%=cdbl(big)%>'
        document.all.XBIG.checked = false
        document.all.b3.value = ' '
        document.all.XBIG.value = 0
    }
    else {
        document.all.b2.value = ' '
        document.all.BIG.value = 0
    }
}

function Xbbi() {
    if (document.all.XBIG.checked == true) {
        document.all.b3.value = '<%=formatnumber(cdbl(Xbig)*cdbl(rs("fob")),2,,,true)%>'
        document.all.XBIG.value = '<%=cdbl(Xbig)%>'
        document.all.BIG.checked = false
        document.all.b2.value = ' '
        document.all.BIG.value = 0
    }
    else {
        document.all.b3.value = ' '
        document.all.XBIG.value = 0
    }
}

function limita() {

    dato = document.all.OBSERVA.value
    if (dato.length > 150) {
        alert("Excedio el numero maximo de caracteres = 150")
        document.all.OBSERVA.value = Left(document.all.OBSERVA.value,150)
    }

}

function bake() {
    cad = 'bake/baketela.asp?pos=' + trim(thisForm.TEL.value)
    document.all.body10.src = cad
}

function help() {   
cad = 'help/HLPprotopos.asp?pro=' + trim(document.all.PRO.value) + '&CLI='+ '<%=TRIM(CLI)%>'
window.open(cad,'',opc)
}
function valida(){
if (trim(document.all.PO.value)=='')
    {   alert("Favor colocar el Número de la PO")
        document.all.PO.focus()
        return false;
    }
    if (trim(document.all.PO.value) == 'AUTO') {
        alert("Favor colocar el Número de la PO")
        document.all.PO.value = '';
        document.all.PO.focus()
        return false;
    }
    if (trim(document.all.PRO.value)=='-')
    {   alert("Favor colocar el Número del PROTO")
        document.all.PRO.focus()
        return false;
    }
    if (trim(document.all.EMB.value)=='')
    {   alert("Favor colocar la fecha de embarque")
        document.all.EMB.focus()
        return false;
    }
    if (trim(document.all.DESTINO.selectedIndex) == -1)
    {   alert("Favor seleccionar el Destino de esta PO")
        document.all.DESTINO.focus()
        return false;
    }
    if (trim(document.all.TIP.selectedIndex) == -1) {
        alert("Favor seleccionar la forma de embarque")
        document.all.TIP.focus()
        return false;
    }
    ninguno = 0
    for (d = 1; d < TOPE - 2; d++) 
    {   // revisa si todas las lineas con color tienen cantidad
        if (trim(eval("document.all.COL" + d + ".value")) != '') 
        {   subi = trim(toInt(eval("document.all.TOT" + d + ".value")))
            if (subi.length == 0 || parseInt(subi, 10) <= 0) 
            {   alert("No ha colocado cantidad para el color " + d)
                return false;
            }
            ninguno++
        }
            
    }
    if (ninguno == 0) {
        alert("No ha creado ningún color")
        document.all.COL1.focus();
        return false;
    }

return true;
}


function graba()
{    if (valida() == true) 
    {    var lets = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
         var aSub = Array()
         var aCol = Array()
         var aFob = Array()
         var aCn0 = Array()
         var aCn1 = Array()
         var aCn2 = Array()
         var aCn3 = Array()
         var aCn4 = Array()
         var aCn5 = Array()
         var aCn6 = Array()
         var aCn7 = Array()
         var aCn8 = Array()
         var aCn9 = Array()
         var aTal = Array()
         aTal[0] = document.all.x0.value
         aTal[1] = document.all.x1.value
         aTal[2] = document.all.x2.value
         aTal[3] = document.all.x3.value
         aTal[4] = document.all.x4.value
         aTal[5] = document.all.x5.value
         aTal[6] = document.all.x6.value
         aTal[7] = document.all.x7.value
         aTal[8] = document.all.x8.value
         aTal[9] = document.all.x9.value
         for (mum = 1; mum < TOPE - 1; mum++) 
         {   FOOy = lets.substring(mum, (mum + 1))
             aCol[mum] = eval("document.all.COL" + mum + ".value")
             aFob[mum] = eval("document.all.FOB" + mum + ".value")
             aCn0[mum] = toInt(trim(eval("document.all.C0" + FOOy + ".value")))
             aCn1[mum] = toInt(trim(eval("document.all.C1" + FOOy + ".value")))
             aCn2[mum] = toInt(trim(eval("document.all.C2" + FOOy + ".value")))
             aCn3[mum] = toInt(trim(eval("document.all.C3" + FOOy + ".value")))
             aCn4[mum] = toInt(trim(eval("document.all.C4" + FOOy + ".value")))
             aCn5[mum] = toInt(trim(eval("document.all.C5" + FOOy + ".value")))
             aCn6[mum] = toInt(trim(eval("document.all.C6" + FOOy + ".value")))
             aCn7[mum] = toInt(trim(eval("document.all.C7" + FOOy + ".value")))
             aCn8[mum] = toInt(trim(eval("document.all.C8" + FOOy + ".value")))
             aCn9[mum] = toInt(trim(eval("document.all.C9" + FOOy + ".value")))
         }
         CAD = '?PO=' + trim(document.all.PO.value)
         CAD += '&cot=' + trim(document.all.COTI.value)
         CAD += '&cli=' + '<%=cli%>' + '&tip=' + trim(document.all.TIP.value)
         CAD += '&fec=' + trim(document.all.EMB.value) + '&chk=1'
         CAD += '&pro=' + trim(document.all.PRO.value)
         CAD += '&des=' + trim(document.all.DESTINO.value)
         CAD += '&TTT=' + toInt(document.all.GRANTOT.value)
         CAD += '&est=' + toInt(document.all.CODEST.value)
         CAD += '&col=' + aCol
         CAD += '&fob=' + aFob
         CAD += '&tal=' + aTal
         CAD += '&cn0=' + aCn0
         CAD += '&cn1=' + aCn1
         CAD += '&cn2=' + aCn2
         CAD += '&cn3=' + aCn3
         CAD += '&cn4=' + aCn4
         CAD += '&cn5=' + aCn5
         CAD += '&cn6=' + aCn6
         CAD += '&cn7=' + aCn7
         CAD += '&cn8=' + aCn8
         CAD += '&cn9=' + aCn9
         CAD += '&ofi=' + toInt(document.all.OFI.value)
         CAD += '&HOU=' + (document.all.HOU.value)
	
         CAD += '&lle=' + ltrim(document.all.LLE.value)
         if (trim(document.all.b2.value) != '')
             CAD += '&BIG=' + document.all.b2.value
         else
             CAD += '&BIG=0'
         if (trim(document.all.b3.value) != '')
             CAD += '&XBIG=' + document.all.b3.value
         else
             CAD += '&XBIG=0' 
         CAD += '&OBS=' + ltrim(document.all.OBSERVA.value)
        
  /*   document.all.body10.style.display = 'block'
         document.all.body10.height = "350"
         document.all.body10.width = "100%"
  */
         document.all.body10.src = "comun/inserPOS.asp" + CAD;
         //document.all.body10.style.display = 'none'
     } 
     return true;
 }





function bakepro() {
    cad = 'bake/bkprotopos.asp?pro=' + trim(document.all.PRO.value) 
    cad += '&cli=' + '<%=cli%>'

  /*  document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
 */
    document.all.body10.src = cad;
  
  //document.all.body10.style.display = 'none'

}
function lineas(op)
{   op = parseInt(op,10)

if (op < TOPE-1)
{   op++
    eval("document.all.LIN"+op+".style.display='block'")
    }
}
function precio(obj){

dato = obj.value 
dato = toInt(dato)
obj.value = dato

}

function total(op, tetra){
op = parseInt(op,10)
// alert(tetra)
parcial = 0

for (j = 0; j <= 9; j++) 
    {    talla = trim(eval("document.all.x" + j + ".value"))
         aa = trim(eval("document.all.C" + j + tetra + ".value"))
        // si hay talla en la columna y cantidad en la linea --> OK
        // se formatea el valor numérico de la celda
         if (talla.length > 0 &&  aa.length > 0) 
             {   aa = toInt(aa)
                 eval("document.all.C" + j + tetra + ".value=addCommas(aa)")
             }

        // si se coloca cantidad y no hay talla de cabecera en la columna se 
        // pone en blanco la celda y se emite el warning
        if (talla.length == 0 && aa.length > 0) 
        {   alert("No se acepta Cantidad si no hay talla")
            eval("document.all.C" + j + tetra + ".value=''")
            aa = 0;
        }
        //***************************************************************************
        //
        //  CALCULA LOS TOTALES POR LINEA.....
        //
        //***************************************************************************
        if (EsNro(aa)) 
        {   //  ACUMULA TOTALES POR LINEA ....
            parcial += parseInt(aa, 10) 
        }
        else
        { parcial += 0 }
        //  TOTALIZA LA LINEA ....
        eval("document.all.TOT" + op + ".value=addCommas(parcial)")
    }
    //***************************************************************************
    //
    //  CALCULA LOS TOTALES POR COLUMNA .....
    //
    //***************************************************************************
    GTOT = 0
    
    var aSub = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    for (mm = 0; mm < TOPE - 2; mm++) {
        FOO = lets.substring(mm, (mm+1))  
        for (s = 0; s <= 9; s++)     
        {   CC = trim(eval("document.all.C" + s + FOO + ".value"))
            if (CC.length > 0)
                aSub[s] += parseInt(toInt(CC), 10)
            if (parseInt(aSub[s],10) > 0 )
            eval("document.all.SUBT" + s + ".value=addCommas(aSub[s])")
        }
        
    }
    GTOT = aSub[0] + aSub[1] + aSub[2] + aSub[3] + aSub[4] + aSub[5] + aSub[6] + aSub[7] + aSub[8] + aSub[9]
    document.all.GRANTOT.value = addCommas(GTOT)
}

function cerrar(op) {
    cad = "detapos.asp?pos=" +  '<%=Request.QueryString("cli")%>'  + '&po=' + '<%=cod%>'
   // alert(window.opener.id)

    window.opener.window.location.replace(cad)
    //parent.window.opener.window.opener.window.location.replace('../detaofi.asp?ofi=' + '<%=ofi%>' + '&pos=' + '<%=Request.QueryString("cli")%>')
    if (trim(op)== '1')
        this.window.close() 

}
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>