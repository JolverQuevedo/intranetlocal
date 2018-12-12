<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow = 1
var url = '../DETAatencionIMP.asp?'
var alias = 'VIEW_POS_movi'
var TBL = 'VIEW_POS_movi'
var PK = 'ID'
var DS = 'PO'
var pagesize = 20
var oldrow = 1
var olddata = ''
var chk = ''
var ficha = 'detaatencionIMP.asp?po='
var oldframe = 0
mm=-1
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/comunhlp.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
POS = Request.QueryString("co")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
nume = Request.QueryString("nume")
glos = Request.QueryString("glos")
REF = Request.QueryString("REF")
pe1 = Request.QueryString("pe1")
pe2 = Request.QueryString("pe2")
ps1 = Request.QueryString("ps1")
ALM = Request.QueryString("ALM")

' HAY QUE JALAR DE LA TABLA DE PARAMETROS EL PORCENTAJE DE TOLERANCIA PARA LA ATENCION DE LAS COMPRAS
RS.OPEN "Select TG_CDESCRI From RSFACCAR..AL0001TABL WHERE TG_CCOD='93' And TG_CCLAVE='EXCECOM' ",CNN

IF RS.RECORDCOUNT > 0 THEN TOLE=(CDBL(RS("TG_CDESCRI"))/100) ELSE TOLE = 1
RS.CLOSE
'****************************************************
cad =   " Select OC_CITEM as ITEM, OC_CCODIGO AS CODIGO, OC_CDESREF AS DESCRIPCION,                         " & _
        " OC_CUNIDAD AS UNI,  isnull(CONVERT(NUMERIC(13,3),OC_NCANORD),0) AS ORDENADO,                      " & _
        " isnull(CONVERT(NUMERIC(13,3),(select sum(c6_ncantid)                                              " & _
        " from RSFACCAR..al0001movc                                                                         " & _
        " inner join RSFACCAR..al0001movd on c5_cnumdoc = c6_cnumdoc and                                    " & _
        " c5_ctd = c6_ctd and c5_calma = c6_calma                                                           " & _
        " where  C6_CALMA='"&ALM&"' AND right(C6_CTD,1)='E' AND C5_CNUMord='"&pos&"'                        " & _
        " and oc_citem = c6_citem and LTRIM(RTRIM(c6_ccodigo)) =LTRIM(RTRIM(oc_ccodIGO))) ),0) AS ATENDIDO, " & _
        " oc_ccodref as ARTICULO,CONVERT(NUMERIC(13,3),(OC_NCANORD*"&tole&")) AS TOLERA,                    " & _
           " isnull(CONVERT(NUMERIC(13,3),(select sum(c6_ncantid)                                           " & _
        " from RSFACCAR..al0001movc                                                                         " & _
        " inner join RSFACCAR..al0001movd on c5_cnumdoc = c6_cnumdoc and                                    " & _
        " c5_ctd = c6_ctd and c5_calma = c6_calma                                                           " & _
        " where  C6_CALMA='"&ALM&"' AND right(C6_CTD,1)='S' AND C5_CNUMord='"&pos&"'                        " & _
        " and oc_citem = c6_citem and LTRIM(RTRIM(c6_ccodigo)) =LTRIM(RTRIM(oc_ccodIGO))) ),0) AS DEVOL     " & _
        " From RSFACCAR..CO0001MOVD                                                                         " & _
        " Where OC_CNUMORD= '"&pos&"' and len(oc_ccodigo) > 0  ;                                            "
                                                                                    
     '   response.write(cad)
     '    response.write("<br>")
rs.open cad, cnn
if rs.recordcount <=0 then po = ""
rs.close
	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
    mm = '<%=rs.recordcount%>'
    var funcionalidad = ''
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
LIMITE = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<style>
div.parte{
border: 0px solid #000000;
float: left;
width: 50%;
height: 100%;
}
</style>
<link rel="stylesheet" type="text/css" href="estilos1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >

<div class="parte">
<form name="thisForm" method="post" action="">
<table id="TABLA" align="center"  bordercolor="#FFFFFF" 
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr class="DATOSceleste">
<%for I=0 to LIMITE -3%>
	<td align="center" class="TITULITOcenterWhite"><%=trim(RS.FIELDS(I).NAME)%></td>
<%next%>	
	<td align="center" class="TITULITOcenterWhite">POR ATENDER</td>
    <td align="center" class="TITULITOcenterWhite" style="display:none"><%=trim(RS.FIELDS(I).NAME)%></td>
    <td align="center" class="TITULITOcenterWhite">TOLERANCIA +-</td>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>');ficha('<%=cont%>')" id="fila<%=Trim(Cstr(cont))%>" >  
        <td class="DESCRIPTORES" style="width:5%"><%=trim(RS.FIELDS.ITEM(0))%></td>  
	    <td class="DESCRIPTORES" style="width:10%"><%=ucase(trim(RS.FIELDS.ITEM(1)))%></td>
	    <td class="DESCRIPTORES" style="width:60%"><%=ucase(trim(RS.FIELDS.ITEM(2)))%></td>
        <td class="DESCRIPTORES" style="width:5%" ><%=ucase(trim(RS.FIELDS.ITEM(3)))%></td>
	    <td class="DESCRIPTORES" width="5%" style="text-align:right; padding-right:10px;"><%=FORMATNUMBER(CDBL(trim(RS.FIELDS.ITEM(4))),3,,,TRUE)%></td>
	    <td class="DESCRIPTORES" width="15%" style="text-align:right; padding-right:10px;"><%=FORMATNUMBER(CDBL(trim(RS.FIELDS.ITEM(5))),3,,,TRUE)%></td>
        <td class="DESCRIPTORES" width="15%" style="text-align:right; padding-right:10px;"><%=FORMATNUMBER(CDBL(trim(RS.FIELDS.ITEM(4)))-CDBL(trim(RS.FIELDS.ITEM(5)))+CDBL(trim(RS.FIELDS.ITEM(7))),3,,,TRUE)%></td>
        <td class="DESCRIPTORES" width="15%" style="text-align:right; padding-right:10px;display:none"><%=(RS.FIELDS.ITEM(6))%></td>
        <td class="DESCRIPTORES" width="15%" style="text-align:right; padding-right:10px;"><%=FORMATNUMBER(CDBL(trim(RS.FIELDS.ITEM(7))),3,,,TRUE)%></td>
  </tr>
  <tr class="DATOSceleste" id="frame<%=cont%>" name="frame<%=cont%>" style="display:none">
    <td align="center" class="" colspan="9">
    <% itm = trim(RS.FIELDS.ITEM(0)) 
    cas =   " select  B.* from RSFACCAR..al0001movc AS A inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and " & _
            " c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&POS&"' AND c6_citemoc ='"&itm&"'  "
   ' RESPONSE.WRITE(CAS)
   ' response.write("<br>")
    RS2.OPEN CAS, CNN
    IF RS2.RECORDCOUNT <=0 THEN
        RS2.CLOSE
        CAS = " select  B.* from RSFACCAR..al0001movc AS A inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and   " & _
              " c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&POS&"' AND C6_CITEM ='"&itm&"'  "
       
        RS2.OPEN CAS, CNN
        ' response.write(cas)
        '  response.write("<br>")
        IF RS2.RECORDCOUNT <=0 THEN
         '   RS2.CLOSE
            VIENE = ""
        ELSE    
            VIENE = "INTRANET"
            RS2.MOVEFIRST
        END IF
     ELSE
        VIENE = "REAL"
        RS2.MOVEFIRST
     END IF       
       IF RS2.RECORDCOUNT > 0 THEN%>
        <table align="center" cellspacing="3" cellpadding="3" id="DETA<%=cont%>">
        <tr  class="TITULITOcenterROJO" >
                <td width="5%">CTD</td>
                <td width="5%">MOV</td>
                <td width="5%">Doc Nro. </td>
                <td width="5%">CODIGO </td>
                <td width="5%">CANT </td>
                <td width="5%">P. UNI </td>
                <td width="5%">P. TOT </td>
                <td width="5%">MON </td>
                <td style="display:none">b</td>
            </tr>
           <%det= 1
           do while noT rs2.eof %>
            <tr ondblclick="ficha22('<%=det%>')" id="fila22<%=Trim(Cstr(det))%>" onmouseover= "this.style.backgroundColor='#7094D6'" onmouseout="this.style.backgroundColor='#C1D3FF'">
                <td class="DESCRIPTORnegroizq" style="text-align:center"><%=RS2("C6_CTD")%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:center"><%=RS2("C6_Ccodmov")%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:center"><%=RS2("C6_CNUMDOC")%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:center"><%=RS2("C6_CCODIGO")%> </td>
                <%if right(rs2("c6_ctd"),1) = "E" then cant =  cdbl(RS2("C6_NCANTID")) else cant =  cdbl(RS2("C6_NCANTID")) * -1%>
                <td class="DESCRIPTORnegroizq" style="text-align:right;padding-right:5px"><%=formatnumber(cant,3,,,true)%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:right;padding-right:5px"><%=formatnumber(RS2("C6_NPREUNi"),2,,,true)%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:right;padding-right:5px"><%=formatnumber(RS2("C6_NVALTOT"),2,,,true)%> </td>
                <td class="DESCRIPTORnegroizq" style="text-align:center"><%=RS2("C6_CCODMON")%> </td>
                <td style="display:none"><%=trim(RS.FIELDS.ITEM(0))%></td>
                <%det= det + 1 %>
            </tr>
            <% rs2.movenext%>
            <%loop%>
        </table>  
        <%end if%>  
        <%rs2.close %>  
    </td>
  </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%loop%>
</table>
<%end if%>
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="200" align="middle" style="display:block" ></iframe>
<%rs.close%>
</div>
<div class="parte">
    <table id="TABLA2" align="center"  bordercolor="#FFFFFF" 
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="0" >
    <%'**************************%>
    <%'LINEA DE CABECERA STANDAR %>
    <%'**************************%>
        <tr class="DATOSceleste">
            <td align="center" class="TITULITOcenterWhite" colspan="10">Detalle de Cantidad</td>
        </tr>
        <tr bgcolor='<%=Application("color1")%>'>
            <td class="TALASBLUE22" style="width:5%">Producto</td>
            <td colspan="3" Width="10%"><input id="codi" name="codi" value="" class="TALASBLUE22"  readonly tabindex="-1"/></td>
            <td colspan="6"><input id="dscr" name="dscr" value="" class="TALASBLUE22" style="width:100%"  readonly tabindex="-1"/></td>
        </tr>

        <tr bgcolor='<%=Application("color1")%>'>
            <td colspan="4"  class="TALASBLUE22" align="right">Unidad de Medida</td>
            <td width="5%"><input id="unid" name="unid" value="" class="TALASBLUE22" readonly tabindex="-1"  style="width:100%" /></td>
            <td colspan="5"><input id="dsun" name="dsun" value="" class="TALASBLUE22" style="width:100%"  readonly tabindex="-1" /></td>
            
        </tr>
        <tr bgcolor='<%=Application("color1")%>'>
            <td class="TALASBLUE22">Ordenado</td>
            <td width="10%"><input id="orde" name="orde" value="" class="datos"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
            <td colspan="2"  class="TALASBLUE22" style="width:35%; text-align:right;">Precio_Unit</td>
            <td width="5%"><input id="puni" name="puni" value="" class="TALASBLUE22" style="text-align:right;padding-right:5px;"  readonly tabindex="-1"/></td>
            <td><input id="dmon" name="dmon" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
            <td  class="TALASBLUE22" width="5%">Total</td>
            <td><input id="tota" name="tota" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
        </tr>
         <tr bgcolor='<%=Application("color1")%>'>
            <td class="TALASBLUE22">Recibido</td>
            <td width="10%"><input id="reci" name="reci" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;"readonly tabindex="-1"/></td>
            <td  class="TALASBLUE22" width="5%" colspan="2" style="text-align:right;">Tip. Cam.</td>
            <td><input id="tipc" name="tipc" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
            <td><input id="chks" name="chks" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
            <td colspan="2"  class="TALASBLUE22">&nbsp;</td>
        </tr>
         <tr id="tallasR" name="tallasR" style="display:none">
            <td colspan="8">
                <table align="left" width="100%" cellpadding="2" cellspacing="2" bgcolor="#BECDC0" >
                    <tr>
                        <td class="TALASBLUE22" style="text-align:right; padding-right:10px">TALLAS</td>
                        <%for i= 0 to 9 %>
                            <td width="6%" class="TALASrojoch" id = 'tt<%=i%>'></td>
                        <%next %>
                        <td width="6%"  class="TALASrojoch" >TOT</td>
                    </tr>
                    <tr>
                        <td class="TALASBLUE22" style="text-align:right; padding-right:10px;background-color:#D0E1DC">QTY OC</td>
                         <%for i= 0 to 9 %>
                            <td width="6%" style="background-color:#D0E1DC"><input  id='qq<%=i%>' class="TALASBLUE33" disabled style="text-align:right;padding-right:10px"/></td>
                          
                        <%next %> 
                         <td width="6%" style="background-color:#D0E1DC"  class="TALASrojoch"><input  id='QTOC' class="TALASBLUE33" disabled style="text-align:right;padding-right:10px" /></td>
                    </tr>
                    <tr>
                        <td class="TALASBLUE22" style="text-align:right; padding-right:10px;background-color:#DEE2C9">QTY PE</td>
                         <%for i= 0 to 9 %>
                            <td width="6%" style="background-color:#DEE2C9"><input  id='rr<%=i%>' class="TALASBLUE33" disabled  style="text-align:right;padding-right:10px" /></td>
                           
                        <%next %> <td width="6%" style="background-color:#D0E1DC"  class="TALASrojoch"><input  id='QTPE' class="TALASBLUE33" disabled style="text-align:right;padding-right:10px" /></td>
                    </tr>
                </table>
            </td>        
        </tr>   
        <tr bgcolor='<%=Application("color1")%>'>
            <td class="TALASBLUE22">Por Recibir</td>
            <td width="10%"><input id="xrec" name="xrec" value="" class="TALASBLUE22" style="text-align:right;padding-right:5px;"  readonly tabindex="-1"/></td>
            <td colspan="3"  class="TALASBLUE22" style="text-align:left"> Incluida la tolerancia definida como parámetro</td>
            <td colspan="2"  class="TALASBLUE22" style="width:10%; text-align:right;">Mov Real</td>
            <td><input id="rea" name="rea" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
        </tr>
        <tr bgcolor='<%=Application("color1")%>'>
            <td class="TALASBLUE22">Recibiendo</td>
            <td width="10%"><input id="aten" name="aten" value="" class="TALASBLUE22" onkeyup="this.value = toInt(this.value)" onchange="vale()"  /></td>
            <td colspan="2"  class="TALASBLUE22" style="width:20%; text-align:right;">Precio_Unit 2</td>
            <td><input id="pund" name="pund" value="" class="TALASBLUE22" style="text-align:right;padding-right:5px;" onkeyup="this.value = toInt(this.value)"/></td>
            <td><input id="mone" name="mone" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
            <td  class="TALASBLUE22">Total</td>
            <td><input id="gtot" name="gtot" value="" class="TALASBLUE22"  style="text-align:right;padding-right:5px;" readonly tabindex="-1"/></td>
        </tr>
        <tr id="tallas" name="tallas" style="display:none">
            <td colspan="8">
                <table align="left" width="100%" cellpadding="2" cellspacing="2" >
                    <tr>
                        <td class="TALASBLUE22" style="text-align:right; padding-right:10px">TALLAS</td>
                        <%for i= 0 to 9 %>
                            <td width="6%" class="TALASrojoch" id = 't<%=i%>' onclick="alert(this.id)"></td>
                        <%next %>
                    </tr>
                    <tr>
                        <td class="TALASBLUE22" style="text-align:right; padding-right:10px">QTY</td>
                         <%for i= 0 to 9 %>
                            <td width="6%"><input  id='q<%=i%>' class="TALASBLUE33" onchange="this.value=toInt(this.value);" onblur="RECTI()"  style="text-align:right;padding-right:10px"  /></td>
                        <%next %>
                    </tr>
                </table>
            </td>        
        </tr>

    </table>
    <center>
        <img src="imagenes/do.png" onclick="graba('0')" style="cursor:pointer" title="Graba la linea activa"/>            &nbsp;&nbsp;
        <img src="imagenes/print.gif" onclick="prn()" style="cursor:pointer"   title="Preview del PE"/>                     &nbsp;&nbsp;
        <img src="imagenes/fin.png" onclick="fin('1')" style="cursor:pointer"  title = "Coloca Check de FINALIZADA la OC"/>
    </center>
     <input type="text" value="" name="PWD" id="PWD" disabled/>
</div>


<script language="jscript" type="text/jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";
    function prn() {
        cad = 'reportes/prnpe.asp?alm=' + trim('<%=alm%>')
        cad += '&tip=PE'
        cad += '&num=' + strzero(trim(parent.window.document.all.PE1.value),11)
       // alert(cad)
        window.open(cad)   
    }
function ficha(r) {
    var t = document.all.TABLA;
    ff = (parseInt(r,10)*2) - 1
    document.all.codi.value = ''
    document.all.dscr.value = ''
    document.all.unid.value = ''
    document.all.dsun.value = ''
    document.all.orde.value = ''
    document.all.puni.value = ''
    document.all.dmon.value = ''
    document.all.tota.value = ''
    document.all.reci.value = ''
    document.all.xrec.value = ''
    document.all.aten.value = ''
    document.all.pund.value = ''
    document.all.mone.value = ''
    document.all.gtot.value = ''
    document.all.chks.value = ''
  //  alert(ff)
    if (trim(t.rows(ff).cells(6).innerText) == '')
        can = 0
    else
        can = parseFloat(t.rows(ff).cells(6).innerText)
    
    srv = trim(t.rows(ff).cells(1).innerText)

 /*   if (can == 0)
    {   //alert("Nada por atender")
        return true;
    }
*/
    itm = trim(t.rows(ff).cells(0).innerText)
//    window.document.all.body0.style.display = 'none'
    window.document.all.body0.src = 'bake/bakeATENCIONIMP.asp?pos=' + '<%=POS%>' + '&ITM=' + itm + '&srv=' + srv + '&alm=' + parent.document.getElementById("COD").value + '&pe2=' + strzero(parent.document.getElementById("PE1").value, 11)
   // alert(oldframe)
   // si es la primera vez que entra ala linea, no oculta nada
    if (parseInt(oldframe, 10) > 0) 
      eval("window.document.all.frame" + oldframe + ".style.display='none'")
    // siempre muestra el frame de la linea activa
    // aqui se tienen el detalle de los partes de entrada por linea de la OC
    eval("window.document.all.frame" + r + ".style.display='block'")
    oldframe = r
    recibido = trim(t.rows(ff).cells(5).innerText)
    saldo = trim(t.rows(ff).cells(6).innerText)
    //   document.all.reci.value = recibido
    document.all.xrec.value = saldo

}
function ficha22(r) {

    var t = eval("document.all.DETA" + oldrow)
    //  alert(t.id)
    ff = parseInt(r, 10)
   // alert(trim(t.rows(ff).cells(2).innerText));   

    pte = trim(t.rows(ff).cells(2).innerText)

    itm = trim(t.rows(ff).cells(8).innerText)
    ctd = trim(t.rows(ff).cells(0).innerText)
    art = trim(t.rows(ff).cells(3).innerText)
  //  window.document.all.body0.style.display = 'block'

    cad = "showMULTIocc.asp?alm=" + parent.document.getElementById("COD").value + '&doc=' + pte
    cad += '&ctd='  + ctd + '&tip=' + Right(trim(ctd), 1)
    cad += '&art='  + art + '&itm=' + itm
    cad += '&DES='  + ltrim(document.all.dscr.value)
    cad += '&nro='  + '<%=nume%>'
    cad += '&glos=' + parent.document.getElementById("GLO").value
    cad += '&REF='  + '<%=REF%>'
    cad += '&pe1='  + '<%=pe1%>'
    cad += '&pe2='  + '<%=pe2%>'
    cad += '&ps1='  + '<%=ps1%>'
    cad += '&oc='   + '<%=pos%>'
  //  alert(cad)
    window.open(cad)
}

function vale() {

    if (trim(document.all.chks.value) != '1') {
        alert("El almacen de la compra no corresponde al de la OC")
        return false;
    }

   orde = parseFloat(removecommas(trim(document.all.orde.value)))
   aten = parseFloat(removecommas(trim(document.all.aten.value)))
   xrec = parseFloat(removecommas(trim(document.all.xrec.value)))
   
   if (isNaN(aten)) {
       alert("favor informar una cantidad valida")
       return false;
   }

    if (parseFloat(aten) > parseFloat(xrec)) {
        alert("No puede recibir más de lo pendiente")
        document.all.aten.value = 0
        return false;
    }
   
    if (trim(document.all.xrec.value) != '') {
          tota = parseFloat(aten) * parseFloat(removecommas(trim(document.all.pund.value)))
         // alert(tota)
          document.all.gtot.value = tota
    }
  
  document.all.aten.value =  FormatNumber(parseFloat(aten), 3, true, true, true,true)
  document.all.aten.style.textAlign='right'
    return true;
}

function graba(opc) {
    if (vale() == false)
        return false;
       aten = parseFloat(removecommas(trim(document.all.aten.value)))
        if (trim(document.all.aten.value) == '' || aten <= 0) {
            alert("Nada que atender")
            return false;
        }

    if (trim(document.all.pund.value) == '') {
        alert("No tenemos a que precio valorizar")
        return false;
    }

      
    var si
    { si = confirm("¿ Confirma que desea Grabar de este Registro ? "); }
    if (si == false)
    { return false; }
    if (vale() == true) {
        orde = parseFloat(removecommas(trim(document.all.orde.value)))
        xrec = parseFloat(removecommas(trim(document.all.xrec.value)))
       // alert("Todo ok")
    }
    
    var t = document.all.TABLA;
    itm  = trim(t.rows(ff).cells(0).innerText)
    cad = '?oc=' + '<%=pos%>'
    cad += '&opc=' + opc
    cad += '&srv=' + trim(document.all.codi.value)
    cad += '&lin=' + itm
    cad += '&CAN=' + aten
    cad += '&nro=' + '<%=nume%>'
    cad += '&glo=' + parent.document.getElementById("GLO").value
    cad += '&REF=' + parent.document.getElementById("DOC").value
    cad += '&pe1=' + '<%=pe1%>'
    cad += '&fec=' + trim(parent.document.getElementById("EMB").value)
    cad += '&des=' + parent.document.getElementById("COD").value
    cad += '&bet=' + toAlpha(ltrim(document.all.dscr.value))
    cad += '&pu2=' + parseFloat(removecommas(trim(document.all.pund.value)))
    cad += '&cam=' + parseFloat(removecommas(trim(document.all.tipc.value)))
    cad += '&fin=' + trim(opc)
    cad += '&rea=' + trim(document.all.rea.value)
    cad += '&LIQ=' + trim(parent.document.getElementById("LIQ").value)
    cad += '&DUA=' + trim(parent.document.getElementById("DUA").value)
  //   alert(cad)

    if (Left(trim(document.all.codi.value), 1) == '9') {
        var aCan = new Array()
        var aTal = new Array()
        for (y = 0; y <= 9; y++) {
            aTal[y] = trim(eval("document.all.t" + y + ".innerText"))
            aCan[y] = trim(eval("document.all.q" + y + ".value"))

        }
        cad += '&ata=' + aTal
        cad += '&aca=' + aCan

    }

    window.document.all.body0.src = 'comun/inseratenIMP.asp' + cad
 }

 function fin(opc) {
     
     var si
     { si = confirm("¿ Confirma que desea Finalizar estsa ORDEN DE COMPRA? "); }
     if (si == false)
     { return false; }
     else {

         cad = '?oc=' + '<%=pos%>'
         window.document.all.body0.src = 'comun/FINoc.asp' + cad
     
      }


 }

 function RECTI() {

     tot = 0
     if (trim(document.all.q0.value) != '')
         tot += parseInt(document.all.q0.value, 10)
     if (trim(document.all.q1.value) != '')
         tot += parseInt(document.all.q1.value, 10)
     if (trim(document.all.q2.value) != '')
         tot += parseInt(document.all.q2.value, 10)
     if (trim(document.all.q3.value) != '')
         tot += parseInt(document.all.q3.value, 10)
     if (trim(document.all.q4.value) != '')
         tot += parseInt(document.all.q4.value, 10)
     if (trim(document.all.q5.value) != '')
         tot += parseInt(document.all.q5.value, 10)
     if (trim(document.all.q6.value) != '')
         tot += parseInt(document.all.q6.value, 10)
     if (trim(document.all.q7.value) != '')
         tot += parseInt(document.all.q7.value, 10)
     if (trim(document.all.q8.value) != '')
         tot += parseInt(document.all.q8.value, 10)
     if (trim(document.all.q9.value) != '')
         tot += parseInt(document.all.q9.value, 10)


     // alert(tot)
     document.getElementById("aten").value = tot
     if (!vale())
         return false
 }


 function prn() {
     cad = 'reportes/prnpe.asp?alm=' + parent.document.getElementById("COD").value
     cad += '&num=' + strzero(trim(parent.document.getElementById("PE1").value), 11)
     cad += '&tip=PE'
     window.open(cad)
 }


</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
