<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
    <%session.LCID=2057 %>
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
<%	oc = Request.QueryString("Oc")
    LIN = Request.QueryString("LIN")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   
    cad = " EXEC OC_LIN_OFI '"&OC&"', '"&LIN&"' "  
	'   response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
    else
        oc =   request.QueryString("oc") 
        lin =  request.QueryString("lin")  
        ofi =  ""       
        IF  LEN(TRIM(request.QueryString("can"))) = 0 THEN CAN= 0 ELSE can =  request.QueryString("can") 
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;">
<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
        <td align = "left" class="TALASBLUE" width="60%">
        <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" width="100%">
		    <tr><td align="left" class="talasblue" width="100%">OFIS</td></tr>
        </table>
        </td>      
        <td align="center"><img src="imagenes/disk.gif" alt="GRABA" style="cursor:pointer" onclick="graba()" /></td>
        <td width="15%" align="right"><img src="imagenes/LOGO.gif" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    </tr>
</table>  

<table align="center" bordercolor="<%=application("color1")%>" bgcolor="<%=application("color2")%>" cellpadding="1" style="border-style:hidden; width:100%" cellspacing="0" border="1">
   <tr>
       <td colspan="4"> 
        <table cellpadding="5" cellspacing="0" border="0" bgcolor='<%=APPLICATION("FONDITO") %>' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="AMERICANnavy" > <td width="10%">Id</td>
    <td width="20%">OFI</td><td width="20%">Cant</td><td width="50%">CLIENTE</td></tr></table>
       </td>
   </tr>
   <%rec=1%>
   <%DO  WHILE NOT RS.EOF %>
        <tr id="LIN<%=rec%>" style="display:block   ">
            <td width="10%">
                <input id="LDET<%=rec%>" name="LDET<%=rec%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(rec))),2) %>'/>
            </td>
            <td width="20%">
                <input id="OFI<%=rec%>" name="OFI<%=rec%>" class="DATOSKHAKI" style="width:100%;" value="<%=rs("ofi")%>" onchange="BAKEOFI('<%=rec%>')"/>
            </td>
            <td width="20%">
                <input id="CAN<%=rec%>" name="CAN<%=rec%>" class="BARRA333" onchange="suma()" style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber(rs("can"),3,,true)%>"/>
            </td>
            <td width="50%">
                <input id="CLI<%=rec%>" name="CLI<%=rec%>" class="DESCRIPTORES" value="<%=rs("nom") %>" style="width:100%;" readonly tabindex="-1"/>
            </td>
        </tr> 
        <%RS.MOVENEXT%>
        <%rec= rec+1%>
    <%LOOP %>
    <tr id="LIN<%=REC%>" style="display:BLOCK ;">
        <td width="10%"><input id="LDET<%=REC%>" name="LDET<%=REC%>" class="DESCRIPTORES" style="width:100%;text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(REC))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=REC%>" name="OFI<%=REC%>" class="DATOSKHAKI" onchange="BAKEOFI('<%=rec%>')" style="width:100%;"/></td>
        <td width="20%"><input id="CAN<%=REC%>" name="CAN<%=REC%>" class="BARRA333" onchange="suma()" value="0.000" style="width:100%;  text-align:right; padding-right:5px;"/></td>
        <td width="50%"><input id="CLI<%=REC%>" name="CLI<%=REC%>" value='<%=rec%>' class="DESCRIPTORES" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%for i= rec+1 to rec+20%>
    <tr id="LIN<%=i%>" style="display:none    ;">
        <td width="10%"><input id="LDET<%=i%>" name="LDET<%=i%>" class="DESCRIPTORES" style="width:100%;text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(i))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=i%>" name="OFI<%=i%>" class="DATOSKHAKI"   style="width:100%;" onchange="BAKEOFI('<%=i%>')" /></td>
        <td width="20%"><input id="CAN<%=i%>" name="CAN<%=i%>" class="BARRA333" onchange="suma()" value="0.000" style="width:100%; text-align:right; padding-right:5px;" /></td>
        <td width="50%"><input id="CLI<%=i%>" name="CLI<%=i%>" value='<%=i%>' class="DESCRIPTORES" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%next%>
<tr>
    <td width="30%" colspan="2" class="TITULITOCH" align="right">CANTIDAD TOTAL : &nbsp;&nbsp;</td>
        
        <td width="20%"><input id="TOTAL" name="TOTAL" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" value="0.000" readonly tabindex="-1" /></td>
        <td width="50%">&nbsp;</td>
    </tr> 
</table> 
<table cellpadding="0" cellspacing="0" border="1" style="border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
  
</table>

<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>
<iframe  width="100%" style="display:block; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="verif" name="verif" value="0" />
<script type="text/jscript" language="jscript">
 // suma()
function BAKEOFI(op) {
op = parseInt(op,10)
ofi = strzero(toInt(eval("document.all.OFI"+op+".value")),8)
eval("document.all.OFI"+op+".value=ofi")
cad = 'bake/bakeOCofi.asp?pos=' + ofi +'&op='+ op
/*
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
*/
document.all.body10.src = cad
OP = op+1
eval("document.all.LIN" + OP + ".style.display='block'")
}
function suma() 
{   maxi = parseInt('<%=i-1%>',10)

    tot = 0
    for (pi = 1; pi <= maxi; pi++) {
        if (eval("document.all.LIN" + pi + ".style.display") == 'block') {
            tt = parseFloat(toInt(eval("document.all.CAN" + pi + ".value")));

            FF = addCommas(cerea(FormatNumber(toInt(redondea(tt, 3)), 3, false, false, true, true), 3))
            eval("document.all.CAN" + pi + ".value=FF")
            //alert(tt);
            tot += tt;
        }
    }
    dd = addCommas(redondea(tot, 3))
    document.all.TOTAL.value = dd
    kko = trim(top.window.izquierdo.document.all.COD.value)
    ddo = trim(top.window.izquierdo.document.all.DES.value)
    lnn = trim(top.window.izquierdo.document.all.LIN.value)
    top.window.opener.window.updates(dd, kko, ddo, lnn)
    top.window.izquierdo.document.all.PED.value = dd

}

function graba() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
    
    df = top.window.izquierdo.grabar()
    if (df == false)
    { return false; }
    kad  = '&cod=' + trim(top.window.izquierdo.document.all.COD.value)
    kad += '&lin=' + trim(top.window.izquierdo.document.all.LIN.value)
    kad += '&DES=' + ltrim(top.window.izquierdo.document.all.DES.value)
    kad += '&kOM=' + Left(toAlpha(top.window.izquierdo.document.all.COME.value,250))
    kad += '&UNI=' + trim(top.window.izquierdo.document.all.UNI.value)
    kad += '&PAR=' + trim(top.window.izquierdo.document.all.PAR.value)
    kad += '&ARA=' + trim(top.window.izquierdo.document.all.ARA.value)
    kad += '&ENT=' + trim(top.window.izquierdo.document.all.ENT.value)
    kad += '&PED=' + trim(toInt(top.window.izquierdo.document.all.PED.value))
    kad += '&PRE=' + trim(toInt(top.window.izquierdo.document.all.PRE.value))
    kad += '&sol=' + trim(top.window.izquierdo.document.all.SOLI.value)
    kad += '&cto=' + trim(top.window.izquierdo.document.all.CCTO.value)
    kad += '&FIN=' + trim(toInt(top.window.izquierdo.document.all.FINA.value))
    kad += '&DCT=' + trim(toInt(top.window.izquierdo.document.all.DITE.value))
    kad += '&ADI=' + trim(toInt(top.window.izquierdo.document.all.DADI.value))
    kad += '&IGV=' + trim(toInt(top.window.izquierdo.document.all.IIGV.value))
    kad += '&ISC=' + trim(toInt(top.window.izquierdo.document.all.IISC.value))
    kad += '&ch1=' + trim(top.window.izquierdo.document.all.CHK1.value)
    kad += '&ch2=' + trim(top.window.izquierdo.document.all.CHK2.value)
    kad += '&ch3=' + trim(top.window.izquierdo.document.all.CHK3.value)
    kad += '&ch4=' + trim(top.window.izquierdo.document.all.CHK4.value)
    kad += '&ref=' + trim(top.window.izquierdo.document.all.KOD.value)
    var aOfi = new Array()
    var aCan = new Array()
    var aTal = new Array()
    var aQty = new Array()
    maxix = parseInt('<%=i-1%>',10)
    bidi = 0
    for (pix = 1; pix < maxix; pix++) 
    {
        if (eval("document.all.LIN" + pix + ".style.display") == 'block' &&  parseFloat(eval("document.all.CAN" + pix + ".value")) > 0 ) 
            {   aCan[bidi] = parseFloat(toInt(eval("document.all.CAN" + pix + ".value")));
                aOfi[bidi++] = trim(eval("document.all.OFI" + pix + ".value"));
            }
    }
        for (p = 0; p < 10; p++) {
            aTal[p] = trim(eval("top.window.izquierdo.document.all.t" + p + ".value"))
            if (trim(eval("top.window.izquierdo.document.all.c" + p + ".value")) == 0)
                eval("top.window.izquierdo.document.all.c" + p + ".value=0")
            aQty[p] = trim(eval("top.window.izquierdo.document.all.c" + p + ".value")) 
        }

    //alert(acan)

    kad += '&acan=' + aCan
    kad += '&aofi=' + aOfi
    kad += '&atal=' + aTal
    kad += '&aQty=' + aQty
    kad += '&kgs=' + top.window.izquierdo.document.all.TOKI.value
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"

cad = 'comun/inserOCLIN.asp?OC=' + trim('<%=trim(oc)%>')
document.all.body10.src = cad + kad
//alert(cad+kad)

  document.all.verif.value = '1'
//  thisForm.action = top.window.close()
/*  thisForm.submit()
*/
}

window.onbeforeunload = confirmExit;




function confirmExit() {

    if (document.all.verif.value == '1')
    return window.close()
else
    return "Si sale sin grabar perderá todos los cambios...";
}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>