<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">

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
<%	COD = Request.QueryString("cod")
    CLI = Request.QueryString("cli")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
    rs.open "select nombre  from modelador..cliente where codigo = '"&cli&"'  ", cnn
    rs.movefirst
    descli = rs("nombre")
    rs.close
    'response.write(descli)
    'response.end
	
    ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAposmovi '"&COD&"'" 
    
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO = ucase(trim(DESCLI))

	END IF
    'RESPONSE.END
    'response.write(rs("fecdoc"))
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="multisty.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="comun/inserposMOVI.asp">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
	    <td width="10%"><img src="images/logo_ch.png" border="0" alt="" id="GRABA"  /></td>	
        <td align = "center" class="Estilo2" width="50%"><%=titulo%></td>
        <td align = "center" class="Estilo2" width="15%">Ficha Nº</td>
        <td  width="8%" align="right"><input type="text" id="id" name="id" value="<%=rs("id")%>" class="data" maxlength="10" readonly tabindex="-1" disabled /></td>
       
        <td align="right"><img src="images/close.png" style="cursor:pointer;" onClick="window.close()" /></td>
    </tr>
</table>  

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" 
       bordercolorlight="<%=(Application("COLOR1"))%>" align="center">
   
  <tr>
     <td  class="Estilo8" width="8%">TipMov:</td>
     <td width="8%" colspan="2">
    	<select id="mov" name="mov" class="INPUTS">
            <option value=""></option>
            <option value="I">Ingresos</option>
            <option value="S">Salidas</option>
        </select></td>
    <td class="Estilo8" width="8%">Taller:</td>
    <td width="2%" align="center"><img src="images/lupa.png" border="0" id="Img2" onClick="helpPRO()" alt="" /></td>
    <td width="10%" ><input type="text" id="RUC" name="RUC" value="<%=rs("RUC") %>" class="BAKES"  onDblClick="helpPRO()" onChange="bakepro()"  /></td>
    <td colspan="7"><input type="text" id="NOM" name="NOM" value="<%=rs("NOMPRO") %>" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>
  <tr>
    <td class="Estilo8" >Estilo:</td>
     <td width="8%" align="center"><img src="images/lupa.png" border="0" id="estilocli" onClick="help()" alt="" /></td>
    <td><input type="text" id="ECL" name="ECL" value="<%=rs("ESTCLI") %>" class="BAKES" onDblClick="help()"  />
    	<input type="text" id="EST" name="EST" value="<%=rs("CODEST") %>" class="INPUTS" readonly tabindex="-1" style="display:none"/>
    </td>
    <td colspan="7"><input type="text" id="DES" name="DES" value="<%=rs("ESTILO") %>" class="DATA" readonly tabindex="-1"/></td>
    <td class="Estilo8" width="8%">PO #:</td>
         <td width="2%" align="center"><img src="images/lupa.png" border="0" id="Img3" onClick="bakepo()" alt="" /></td>
        <td width="10%"><input type="text" id="POS" name="POS" value="<%=rs("po")%>" class="BAKES"  onDblClick="bakepo()"/></td>
     
  </tr>
  <tr>
     <td class="Estilo8" >FecDoc:</td>
        <td  align="center"><A href="javascript:showCal('Calendar1')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
    <td><input type="text" id="FEC" name="FEC" value="<%=formatdatetime(rs("fecdoc"),2) %>" class="inputs" style="text-align:center" readonly tabindex="-1"/></td>
     <td class="Estilo8" width="8%">Servicio:</td>
    <td colspan="3"><select id="SER" name="SER" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from SERVICIOS where estado ='a' ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>

    <td class="Estilo8" width="8%">Condicion:</td>
    <td colspan="2"><select id="CON" name="CON" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from CONDICIONES where estado ='a'  ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>
    <td class="Estilo8" width="8%">Tipo Pza:</td>
    <td colspan="2"><select id="PZA" name="PZA" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from piezas where estado ='a'  ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>
  </tr>
  <tr>
     <td class="Estilo8" width="8%">Motivo:</td>
    <td colspan="2"><select id="MOT" name="MOT" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from MOTIVOS where estado ='a'  ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>
     <td class="Estilo8" width="8%">Observacion:</td>
    <td colspan="3"><select id="DEF" name="DEF" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from defectos where estado ='a'  ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>
     <td class="Estilo8" width="8%">Linea:</td>
    <td colspan="2"><select id="LIN" name="LIN" class="inputs"  />
                <% rs2.open "select * from LINEAS where estado ='a'  order BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select></td>
    <td class="Estilo8" width="8%">Bolsa #:</td>
    <td colspan="2"><input id="BOL" name="BOL" class="inputs" value="<%=RS("BOLSA") %>"  /></td>
  </tr>
  <tr>
    <td class="Estilo8" width="8%" >Guia Modelador:</td>
    <td width="10%" colspan="2"><input type="text" id="GUI" name="GUI" value="<%=rs("GUIA") %>" class="inputs" /></td>
    <td class="Estilo8" width="8%" >Guia Proveedor:</td>
    <td width="10%" colspan="3"><input type="text" id="GUI2" name="GUI2" value="<%=rs("GUIA2") %>" class="inputs" maxlength="11" /></td>
    <td class="Estilo8" width="8%" >Corte #:</td>
    <td width="20%" colspan="2"><input type="text" id="CORT" name="CORT" value="<%=rs("CORTE") %>" class="inputs" maxlength="12"/></td>
    
    <td></td>
  </tr>
</table>

<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%">
    <tr class="Estilo3" >
    
    <td style="width:39%"  class="texto" colspan="2">COLOR -- TALLAS </td>
        <%FOR I = 0 TO 9%>
            <td align="center" width="5%">
                <%TALLA = "T"&i %>
                <input id="T<%=i%>" name="T<%=i%>" value="<%=RS(TALLA)%>" class="DATA2" style="width:100%; color:White; text-align:center" tabindex=-1 readonly/>
            </td>    
        <%NEXT%>
        <td width="15%" class="texto" align="center">TOTAL</td>
    </tr>   
 <tr class="Estilo55">
    <td style="width:3%" ></td>
    <td style="width:39%" >Cantidades de la PO</td>
        <%tq=0%>
         <%FOR I = 0 TO 9%>
               <td align="center" width="5%">
               <%
               can = "q"&i 
               ccc = formatnumber(cdbl(rs(can)),0,,true)
               tq = tq + cdbl(ccc)
               if ccc = 0 then ccc = ""%>
                 <input id="Q<%=I%>" name="Q<%=I%>" value="<%=ccc %>" class="Estilo55" tabindex=-1 readonly style="width:100%; border-width:0px; text-align:center;" />
              </td>    
        <%NEXT%>
        <td style="width:15%"><input id="TOTPO" name="TOTPO" value="<%=tq%>" class="Estilo55" style="width:100%;text-align:right; border-width:0px; text-align:center;" tabindex=-1 readonly/></td>
  </tr>
  <tr>
    <td style="width:3%"  class="texto"><input id="UBI" name="UBI" value="<%=RS("ubi")%>" class="data2" style="width:100%" tabindex=-1 readonly/></td>
    <td style="width:39%"><input id="COL" name="COL" class="DATA2" style="text-align:left;width:100%"  value="<%=rs("color")%>" tabindex=-1 readonly /></td>
         <%FOR I = 0 TO 9%>
               <td align="center" width="5%">
               <%can = "c"&i 
               ccc = formatnumber(cdbl(replace(rs(can),",",""I)),0,,true)%>
                 <input id="C<%=I%>" name="C<%=I%>" value="<%=ccc %>" class="inputs" onFocus="seleccionar(this)" onBlur="total(this.value,'<%=i%>')" style="width:100%; text-align:center"  />
              </td>    
        <%NEXT%>
        <td style="width:15%"><input id="TOT" name="TOT" value="" class="data" style="width:100%;text-align:center;" tabindex=-1 readonly/></td>
  </tr>
  <tr>
    <td colspan="13" align="center" valign="middle" height="90px">
    <img id="Img1" name="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="images/ok.png" /></td>
  </tr>
</table>



<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>



<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">


addCalendar("Calendar1", "Elija una fecha", "FEC", "thisForm")

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

// si tiene numero de guia YA NO SE PUEDE MODIFICARRRRRRRRRRR
//if (trim(document.all.GUI.value) != '')
 //   document.all.Img1.style.display='none'

var subcadena = '<%=TRIM(RS("mov"))%>';
var elemento = document.all.mov;
document.all.mov.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("codser")%>';
if (trim(subcadena) == '')
    document.all.SER.selectedIndex =1
else {
    var elemento = document.all.SER;
    document.all.SER.selectedIndex = seleindice(subcadena, elemento);
}

var subcadena = '<%=RS("codcon")%>';
if (trim(subcadena) == '')
    document.all.CON.selectedIndex = 1
else {
    var elemento = document.all.CON;
    document.all.CON.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codPZA"))%>';
if (trim(subcadena) == '')
    document.all.PZA.selectedIndex = 1
else {
    var elemento = document.all.PZA;
    document.all.PZA.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codDEF"))%>';
if (trim(subcadena) == '')
    document.all.DEF.selectedIndex = 1
else {
    var elemento = document.all.DEF;
    document.all.DEF.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codLIN"))%>';
var elemento = document.all.LIN;
document.all.LIN.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=TRIM(RS("codMOT"))%>';
if (trim(subcadena) == '')
    document.all.MOT.selectedIndex = 1
else {
    var elemento = document.all.MOT;
    document.all.MOT.selectedIndex = seleindice(subcadena, elemento);
}
ttt = 0
qqq = 0
 for (d = 0; d < 10; d++) 
    {   // revisa si todas las lineas con color tienen cantidad
        if (trim(eval("document.all.C" + d + ".value")) == '0') 
           eval("document.all.C" + d + ".disabled='true'")
        else {  ttt = Math.floor(ttt)
                ttt += parseInt(eval("document.all.C"+d+".value"),10)
                qqq = Math.floor(qqq)
                qqq += parseInt(eval("document.all.Q"+d+".value"),10)
          }      
       
    }

document.all.TOT.value = parseInt(ttt,10)
document.all.TOTPO.value = parseInt(qqq,10)


function BAKE(ooo) {
    cad = 'hlp_pos_color.asp?po=' + trim(thisForm.POS.value)
if (trim(ooo) == '')
    cad = '../help/hlp_pos_color.asp?po=' + trim(thisForm.POS.value)+'&cli=' + '<%=cli%>'
else
    cad = 'hlp_pos_color.asp?po=' + trim(thisForm.POS.value)


opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=100,height=400,width=500";
window.open(cad, '', opc)
}

function help() {
    if (trim(document.all.mov.value) == '') {
        alert("Por favor informe el tipo de Movimiento")
        return false;
        }
        if (trim(document.all.mov.value) == 'I') {
            if (trim(document.all.RUC.value) == '') {
                alert("Por favor informe el Taller")
                return false;
            }
        }
    if (trim(document.all.ECL.value) == '') {
        alert("Por favor informe el Estilo del Cliente")
        return false;
        }
    cad = 'help/HLP_pos_cli.asp?est=' + trim(document.all.ECL.value) + '&CLI=' + '<%=TRIM(CLI)%>' + '&mov=' + trim(document.all.mov.value)
    cad += '&ruc=' + trim(document.all.RUC.value)
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=100,height=400,width=300";
    window.open(cad,'',opc)
}

function helpPRO() {
    if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
        alert("Por favor informe el RUC o Nombre del proveedor")
        return false;
    }
    cad = 'help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
    window.open(cad, '', opc)
}

function bakepro() {
  /*document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = "BAKE/jala_pro.asp?RUC=" + trim(document.all.RUC.value) ;
}


function valida(opp){
if (trim(document.all.ECL.value)=='')
    {   alert("Favor colocar el Estilo del Cliente")
        document.all.ECL.focus()
        return false;
    }
    if (trim(document.all.POS.value) == '') {
        alert("Favor colocar el Número de la PO")
        document.all.POS.value = '';
        document.all.POS.focus()
        return false;
    }
  
    if (trim(document.all.mov.value) == '')
    {   alert("Favor seleccionar el tipo de Movimiento para esta PO")
        document.all.mov.focus()
        return false;
    }

    if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
        alert("Por favor informe el RUC o Nombre del proveedor")
        return false;
    }
        
    if (trim(document.all.SER.value) == '')
    {   alert("Favor seleccionar el tipo de Servicio para esta PO")
        document.all.SER.focus()
        return false;
    }


    if (trim(document.all.FEC.value) == '') {
        alert("Favor colocar la fecha del Documento")
        document.all.FEC.focus()
        return false;
    }

    if (trim(document.all.CON.value) == '') {
        alert("Favor seleccionar la Condicion para esta PO")
        document.all.CON.focus()
        return false;
    }

    if (trim(document.all.PZA.value) == '') {
        alert("Favor seleccionar el tipo de Piezado para esta PO")
        document.all.PZA.focus()
        return false;
    }

    if (trim(document.all.DEF.value) == '') {
        alert("Favor seleccionar observacion")
        document.all.DEF.focus()
        return false;
    }

    if (trim(document.all.MOT.value) == '') {
        alert("Favor seleccionar el Motivo")
        document.all.MOT.focus()
        return false;
    }

    if (trim(document.all.LIN.value) == '') {
        alert("Favor seleccionar LINEA DE COSTURA")
        document.all.LIN.focus()
        return false;
    }

    if (opp != '1')
    {   ninguno = 0
        for (d = 0; d < 10; d++) 
        {   // revisa si todas las lineas con color tienen cantidad
            if (trim(eval("document.all.C" + d + ".value")) != '0') 
            {   subi = document.all.TOTPO.value
                if (subi.length == 0 || parseInt(subi, 10) <= 0) 
                {   alert("No ha colocado cantidades para el color ")
                    return false;
                }
                ninguno++
            }      
        }
        if (ninguno == 0) {
            alert("No ha colcoado cantidades para ninguna talla")
            document.all.C0.focus();
            return false;
        }
    }

return true;
}

function veriPO()
{   Math.floor(document.all.TOTPO.value)
    if (trim(document.all.TOTPO.value)=='')
        helpPRO()
}



function graba()
{    if (valida() == true) 
    {    CAD = '?id='   + trim(document.all.id.value)
         CAD += '&po='  + trim(document.all.POS.value)
         CAD += '&UBI=' + trim(document.all.UBI.value)
         CAD += '&EMP=' + '<%=cia%>'
         CAD += '&mov=' + trim(document.all.mov.value)
         CAD += '&GUI=' + trim(document.all.GUI.value)
         CAD += '&RUC=' + toInt(document.all.RUC.value)
         CAD += '&DEF=' + trim(document.all.DEF.value)
         CAD += '&pza=' + trim(document.all.PZA.value)
         CAD += '&SER=' + trim(document.all.SER.value)
         CAD += '&CON=' + trim(document.all.CON.value)
         CAD += '&C0='  + trim(document.all.C0.value)
         CAD += '&C1='  + trim(document.all.C1.value)
         CAD += '&C2='  + trim(document.all.C2.value)
         CAD += '&C3='  + trim(document.all.C3.value)
         CAD += '&C4='  + trim(document.all.C4.value)
         CAD += '&C5='  + trim(document.all.C5.value)
         CAD += '&C6='  + trim(document.all.C6.value)
         CAD += '&C7='  + trim(document.all.C7.value)
         CAD += '&C8='  + trim(document.all.C8.value)
         CAD += '&C9='  + trim(document.all.C9.value)
         CAD += '&FEC=' + trim(document.all.FEC.value)
         CAD += '&cli=' + '<%=cli%>'
         CAD += '&BOL=' + trim(document.all.BOL.value)
         CAD += '&LIN=' + trim(document.all.LIN.value)
         CAD += '&MOT=' + trim(document.all.MOT.value)
         CAD += '&GUI2=' + trim(document.all.GUI2.value)
         CAD += '&COR=' + trim(document.all.CORT.value)
     /*   document.all.body10.style.display = 'block'
         document.all.body10.height = "350"
         document.all.body10.width = "100%"    
         */
         document.all.body10.src = "comun/inserPOSmovi.asp" + CAD;
         //document.all.body10.style.display = 'none'
     } 
     return true;
 }

function bakepo() {
    cad = 'bake/bakePOSmovi.asp?pos=' + trim(document.all.POS.value) 
  document.all.body10.src= cad
}

function total(can, op){
can = toInt(can)
if (trim(can)=='')
{   alert("Favor ingresar un valor numerico")
    eval("document.all.C"+op+".style.backgroundColor='red'")
    eval("document.all.C"+op+".focus()")
    seleccionar(eval("document.all.C"+op))
    return true;
}
else
{   eval("document.all.C"+op+".style.backgroundColor='White'")
    eval("document.all.C"+op+".value=can")}

ttt = 0
for (o=0; o<10; o++)
  {  ttt = Math.floor(ttt)
        ttt += parseInt(eval("document.all.C"+o+".value"),10)
  }

    ppp = Math.floor(document.all.TOTPO.value)
    ppp = ppp * 1.05
    ttt = Math.floor(ttt)
    document.all.TOT.value = parseInt(ttt,10)
    if (ppp < ttt) {
        var si
        { si = confirm(" Esta registrando mas del 5 % permitido ¿ Confirma estas cantidades ? "); }
        if (si == false)
        { return false; }
    }

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