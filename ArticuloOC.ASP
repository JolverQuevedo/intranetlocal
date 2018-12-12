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
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/jscript" language="jscript">
var aCod = Array() 
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the heiht of the iframe
  document.getElementById('body0').height=
      the_height;
}

</script>
<%	oc =  request.QueryString("oc") 
lin =  request.QueryString("lin") 
cod =  request.QueryString("cod") 
des =  request.QueryString("des") 
uni =  request.QueryString("uni") 
igv =  request.QueryString("igv") 
isc =  request.QueryString("isc") 
IF  LEN(TRIM(request.QueryString("can"))) = 0 THEN CAN= 0 ELSE can =  request.QueryString("can") 
if trim(request.QueryString("pre")) = "" then pre = 0 else pre =  request.QueryString("pre") 
com =  request.QueryString("com") 

    if trim(oc)= "" then 
        oc = "AUTO"
    end if
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    rs2.open "select oc_ctipord from rsfaccar..CO0001MOVC WHERE OC_CNUMORD = '"&OC&"'" ,CNN
    RS2.MOVEFIRST
    TIPO = ucase(RS2("OC_CTIPORD"))
    'response.write(tipo)
    RS2.CLOSE
    cad = "exec OC_LIN_COD '"&oc&"', '"&lin&"' , '"&cod&"' "  
	'   response.Write(cAD)
	rs.open cad, cnn                                                                    
	IF RS.RecordCount > 0 THEN 		RS.MOVEFIRST
	
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>


</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;" >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="15%" align="right"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    <td width="15%" align="right">&nbsp;</td>	
          <td align = "center" class="TALASBLUE" width="60%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td style="text-align:right" class="talasblue">ARTICULO O/C</td></tr></table>
    </tr>
</table>  
<iframe  width="100%" style="display:none;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table width="100%" border="1" border="<%=APPLICATION("COLOR2") %>" cellpadding="0" cellspacing="0" >   
	<tr valign="middle"><td bgcolor="#f7d975" style="height:1px;"></td></tr>
</table>
<table cellpadding="5" cellspacing="0" border="0" bgcolor='<%=APPLICATION("FONDITO") %>' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="AMERICANnavy" ><td style="width:100%">DATOS DEL ARTICULO</td></tr></table>
    <table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" 
        bordercolorlight="<%=(Application("COLOR1"))%>">
        <tr valign="top">
            <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch"  width="20%">C&oacute;digo Art&iacute;culo </td>
            <td width="20%" colspan="2"><input type="text" id="COD" name="COD" value="<%=ucase(COD)%>"  class="DATOSKHAKI" 
            onChange="BAKECOD('');this.value=this.value.toUpperCase();" 
            onDblClick="helpCOD('')" maxlength="25"/></td>
            <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" width="15%">Num Lin</td>
            <td width="20%"><input type="text" id="LIN" name="LIN" value="<%=LIN %>" style="width:100%; 
            text-align:center"class="descriptores"  tabindex="-1" readonly/></td>
      </tr>
      <tr>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">Descripcip&oacute;n</td>
        <td colspan="4"><input type="text" id="DES" name="DES" value="<%=rs("OC_CDESREF")%>" class="barra333" maxlength= "60" 
        style="width:100%;text-align:left;" /></td>
      </tr>
      <tr>  
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">Cod. REFERENCIA</td>
        <td colspan="2"><input type="text" id="KOD" name="KOD" value="<%=trim(RS("OC_CCODREF"))%>" class="DATOSKHAKI" onchange="BAKECOD('X')" 
         ondblclick="helpCOD('K')" maxlength="25"/></td>
        <%solo = RS("OC_CCODREF")
        pop = "select AR_CDESCRI from rsfaccar..al0001arti where ar_ccodigo = '"&solo&"'" 
        rs2.open pop,cnn
        if rs2.recordcount > 0 then 
            rs2.movefirst
            relacion = rs2("ar_cdescri")
        else
            relacion = ""
        end if
        rs2.close
        %>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch"  width="20%" colspan="2">
        <input type="text" id="DKOD" name="DKOD" value="<%=relacion%>" style="width:100%; text-align:left"class="descriptores"  tabindex="-1" readonly/></td>      
        </tr>
    <!------------------------------------------------------------------>
    <!-- INICIO fila de tallas -->
    <!------------------------------------------------------------------>

    <tr id='FICHA' name='FICHA' style='display:none'  bgcolor="<%=(Application("BARRA"))%>" >
        <td bgcolor="<%=(Application("color2"))%>" colspan="5"> 
            <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
                 <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%"  bgcolor="<%=(Application("BARRA"))%>" >
	                <tr>
                       <td style="width:100%; background-color:#f7d975" colspan="6" class="AMERICANnavy">RECTILINEOS:</td>
                    </tr> 
                    <tr>
                       <td class="AMERICANnavy" colspan="1"></td>
                       <td class="AMERICANnavy" colspan="1">TALLA</td>
                       <td class="AMERICANnavy" colspan="1">CANT</td>
                       <td class="AMERICANnavy" colspan="3"></td>
                    </tr>
                    <% mas ="exec SP_OC_LIN_TALLA '"&oc&"', '"&lin&"' "
                    'response.write(mas)  
                     rs2.open mas,cnn
                    rs2.movefirst
                    for i=0 to 9 
                    tal = "t"&i
                    qty = "Q"&i
                    if cint(rs2(qty)) =  0 then qty = "" else qty = cint(rs2(qty))%>
                        <tr>
                        <td width="30%"  class="AMERICANnavy" colspan="1"></td>
                            <td width="10%" ><input type="text" class="BARRA3" id="t<%=i%>" name="t<%=i%>" onchange="valida('<%=i%>');this.value= this.value.toUpperCase();completa()" maxlength="5" value='<%=rs2(tal)%>'/></td>
                            <td width="10%" ><input type="text" class="BARRA3" id="c<%=i%>" name="c<%=i%>" onchange="suma();completa()"  maxlength="5" value='<%=qty%>' /></td>
                            <td width="50%"  class="AMERICANnavy" colspan="2"></td>
                        </tr>
                     <%next %>                  
                    <tr>
                       <td class="AMERICANnavy" colspan="2" style="text-align:right; padding-right:10px">TOTAL</td>

                       <%tou = cint(rs2("q0"))+cint(rs2("q1"))+cint(rs2("q2")) +cint(rs2("q3")) +cint(rs2("q4")) +cint(rs2("q5")) +cint(rs2("q6")) +cint(rs2("q7")) +cint(rs2("q8")) +cint(rs2("q9"))  %>
                       <td ><input style="background-color:White" type="text" class="descriptores" id="TOUN" name="TOUN" value="<%=tou%>" readonly tabindex="-1"/></td>
                       <td  width="10%" class="AMERICANnavy" colspan="1">Unds.</td>
                       <td  width="10%" ><input style="background-color:White" type="text" class="descriptores" id="TOKI" name="TOKI" 
                       value="<%=formatnumber(rs2("kguni"),3,,,true) %>" readonly tabindex="-1"/></td>
                       <td  width="10%" class="AMERICANnavy" colspan="1">Kgs.</td>
                    </tr>
                 </table>
                 <%RS2.CLOSE %>
            </td>
        </tr>    
        </table>
        </td>
    </tr>
    <!------------------------------------------------------------------>
    <!-- FIN fila de tallas -->
    <!------------------------------------------------------------------>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" width="20%">Comentario </td>
    <td colspan="4"><textarea id="COME" name="COME" class="estilotextarea4" maxlength="250" ><%=trim(rs("COME"))%></textarea></td>
    </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">Unidad </td>
    <td WIDTH="10%"><input type="text" id="UNI" name="UNI" value="<%=rs("uni")%>" class="DESCRIPTORES" style="text-align:center" readonly tabindex="-1" /></td>
    <td bgcolor="<%=(Application("BARRA"))%>">&nbsp;</td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">F. Entrega </td>
    <td WIDTH="10%"><input type="text" id="ENT" name="ENT" value="<%=date()%>" class="BARRA333" style="text-align:center; width:100%"  /></td>
    </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Part Arancelaria </td>
    <td><input id="PAR" name="PAR" class="descriptores" readonly tabindex="-1" /></td>
        <td colspan="3"><input id="ARA" name="ARA" class="DESCRIPTORES" readonly tabindex="-1" style="width:100%" /></td>
    </tr> 
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch"  width="20%">Cantidad Pedida</td>
        <td  colspan="2" width="30%"><input type="text" id="PED" name="PED" value="<%=formatnumber(rs("ped"),5,,true)%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px" maxlength="10" tabindex="-1" readonly/></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2" width="50%">&nbsp;</td>
  </tr>
  <tr valign="middle">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Precio Original </td>
      <td  colspan="2"><input type="text" id="PRE" name="PRE" value="<%=formatnumber(rs("PRE"),5,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px" maxlength="10" onkeyup="this.value=toInt(this.value)" /></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2">&nbsp;</td>
</tr>
<tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Solicitante</td>
  <td width="10%" ><input type="text" id="SOLI" name="SOLI" value="<%%>" class="BARRA333" style="width:100%; text-align:left" maxlength="3" value="<%=trim(rs("soli"))%>"/></td>
  <td colspan="3"  bgcolor="<%=(Application("BARRA"))%>">&nbsp;</td>
</tr>
<tr valign="middle">
     <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch"  width="20%">C. Costo</td>
     <td colspan="4"><select id="CCTO" name="CCTO" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
     </td>
 </tr>
 <tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2">Dsct. Financiero</td>
  <td width="10%" ><input type="text" id="FINA" name="FINA" value="<%=formatnumber(rs("fina"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="3" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Dsct. Item</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK1" name="CHK1" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DITE" name="DITE" value="<%=formatnumber(rs("DITE"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Dsct. Adic</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK2" name="CHK2" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DADI" name="DADI" value="<%=formatnumber(rs("DADI"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Incluye IGV</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK3" name="CHK3" value="0" class="BARRA333" style="width:100%; text-align:center;" onkeyup="this.value=toInt(this.value)" /></td>
  <td width="10%" ><input type="text" id="IIGV" name="IIGV" value="<%=forMATNUMBER(rs("Iigv"),2,,TRUE)%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Incluye ISC</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK4" name="CHK4" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="IISC" name="IISC" value="<%=forMATNUMBER(rs("IiSC"),2,,TRUE)%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1"/></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>

<script type="text/jscript" language="jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";
var subcadena = '<%=RS("CCTO")%>';
var elemento = document.all.CCTO;
document.all.CCTO.selectedIndex = seleindice(subcadena, elemento);
if (Left(trim(document.all.COD.value), 1) == '9'|| Left(trim(document.all.KOD.value), 1) == '9' )
    document.all.FICHA.style.display='block'
if (trim('<%=tipo%>') != 'S') {
    document.all.KOD.style.backgroundColor = '#c4c4c4'
    document.all.KOD.disabled = true
}

function helpCOD(OP) {
    if (trim(OP) == '')
        cad = 'help/HLPartREAL2.asp?pos=' + trim(document.all.COD.value) + '&opp=' + OP + '&tip=' + '<%=TIPO%>'
    else
        cad = 'help/HLPartREAL2.asp?pos=' + trim(document.all.KOD.value) + '&opp=' + OP + '&tip=' + '<%=TIPO%>'
    //alert(cad)
    window.open(cad, '', opc)
}
function BAKECOD(cop) {
    //alert(cop)
// mando cop para saber si va por codigo principal o por codigo de referencia
if (trim(cop) == '')
        cad = 'bake/bakeREALcodCTO.asp?pos=' + trim(thisForm.COD.value) + '&opp=' + cop + '&TIP=' + '<%=TIPO%>' + '&cop='
    else
        cad = 'bake/bakeREALcodCTO.asp?pos=' + trim(thisForm.KOD.value) + '&opp=' + cop + '&TIP=' + '<%=TIPO%>' + '&cop=K'

document.all.body10.height = "350"
document.all.body10.width = "100%"
//document.all.body10.style.display = 'block'
document.all.body10.src = cad
//document.all.body10.style.display = 'none'
}

function valida(cop) 
{   talla = trim(eval("thisForm.t"+cop+".value"))

    cad = 'bake/baketalla.asp?tal=' + talla + '&op=' + cop
/*   
    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
*/
    document.all.body10.src = cad
    //document.all.body10.style.display = 'none'
}

function suma() {
    tota = 0
    for (p = 0; p <= 9; p++) 
    {   ss = toInt(trim(eval("document.all.c"+p+".value")))
        if(ss.length!=0 )
            tota += parseInt(ss,10)    
    }
    top.window.derecho.document.all.LDET1.value = '01'
    top.window.derecho.document.all.OFI1.value = '00000000'
    top.window.derecho.document.all.CAN1.value = tota
    top.window.derecho.document.all.TOTAL.value = tota
    document.all.PED.value = tota
    document.all.TOUN.value = tota
}

function grabar() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
    if (trim(document.all.COD.value) == '') {
        alert("Favor ingresar el codigo del articulo")
        document.all.COD.focus();
        return false;
    }
    if (parseFloat((toInt(document.all.PRE.value))) <= 0) {
        alert("Favor ingresar el precio del articulo")
        document.all.PRE.focus();
        return false;
    }
    if (parseInt(trim(document.all.PED.value),10)== 0) {
        alert("No ha registrado cantidades para ninguna OFI")
        top.window.derecho.document.all.OFI1.focus();
        return false;
    }
    if (fecha(document.all.ENT.value) == false) {
        alert("Formato de Fecha incorrecto")
        return false;
    }
    return true;
}
function veri() {
    if (Left(trim(document.all.COD.value), 2) == 'SR') {
       /* if (trim(document.all.KOD.value) == '') {
            alert("Ingrese el codigo de Rectilineo")
            return false;
        }
        */
        if (Left(trim(document.all.KOD.value), 1) != '9') {
            alert("Solo se Aceptan Rectilineos")
            document.all.KOD.value = ''
            document.all.DKOD.value = ''
            return false;
        }
        else 
        document.all.FICHA.style.display='block'
    }
    if (Left(trim(document.all.COD.value), 2) == 'ST') {
      /*  if (trim(document.all.KOD.value) == '') {
            alert("Ingrese el codigo de Rectilineo")
            return false;
        }
       
        if (Left(trim(document.all.KOD.value), 1) == '9') {
            alert("Solo se Aceptan tejidos Circulares")
            document.all.KOD.value = ''
            document.all.DKOD.value= ''
            return false;
        } */
    }
    return true;
}
function completa() { 
document.all.COME.value = ''
for (p = 0; p < 10; p++) {
    if (trim(eval("document.all.t" + p + ".value")) != '')
    document.all.COME.value += trim(eval("document.all.t" + p + ".value")) + '/' + trim(eval("document.all.c" + p + ".value")) + ' '
}



}



</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
<script type="text/javascript">
$(document).ready(function(){
    // Función a lanzar cada vez que se presiona una tecla en un textarea
    // en el que se encuentra el atributo maxlength
    $("textarea[maxlength]").keyup(function() {
        var limit   = $(this).attr("maxlength"); // Límite del textarea
        var value   = $(this).val();             // Valor actual del textarea
        var current = value.length;              // Número de caracteres actual
        if (limit < current) {                   // Más del límite de caracteres?
             // Establece el valor del textarea al límite
             $(this).val(value.substring(0, limit));
         }
     });
 });
 </script>
</body>
</html>