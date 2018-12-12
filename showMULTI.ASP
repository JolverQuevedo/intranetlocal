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
    cia = "0001"
%>
<html>
<head>
<title>Edicion de Documentos</title>
<link href="estilos1.css" rel="stylesheet" type="text/css">

<style type="text/css">
.conter { width: 100%; border: 1px solid #fff; }
.textareaContainer {
    display: block;
    border: 1px solid #fff;
    padding: 2px;
    width: 100%; 
}
textarea { width: 100%; margin: 1.5px; padding: 0; border-width: 1; vertical-align:top; }
</style>
<link href="estilos1.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNhlp.ASP"-->

<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<%'****************************************************
ALM = request.QueryString("ALM")	
CTD = request.QueryString("CTD")	
DOC = request.QueryString("DOC")
TIP = request.QueryString("TIP")
itm = request.QueryString("itm")
ART = request.QueryString("ART")	
glos = Request.QueryString("glos")
REF = Request.QueryString("REF")
pe1 = Request.QueryString("pe1")
pe2 = Request.QueryString("pe2")
ps1 = Request.QueryString("ps1")
RS.OPEN "SELECT ar_cdescri from RSFACCAR..al0001arti where ar_ccodigo = '"&art&"'", cnn
rs.movefirst
DES = rs("ar_cdescri")
rs.close
rs.open " EXEC multi..RS_MOV_S_ENT_SAL '"&alm&"', '"&doc&"', 'N', '', '', '', '', '','', '', '', '', '', " & _
        " 'multi..RS_ALMOVD0001', 'multi..RS_ALMOVD_TALLA0001' , 'multi..RS_ALMOV_UBICACION0001', 'multi..AL_TIPOSMOV0001' ", cnn
if rs.recordcount > 0  then
    rs.movefirst
        COL = rs("COLor")	
        LOT = rs("LOTe")	
        bul = rs("bultos")    
        con = rs("conos")              
        ser = ""
        ubi = rs("ubi")
        uni = rs("uni")
        OC  = rs("OC")
        REF = rs("doc_REF")
else
    COL = request.QueryString("COL")	
    LOT = request.QueryString("LOT")	
    bul = 0
    con = 0
    ser = ""
    ubi = ""
    uni = ""
    OC = request.QueryString("OC")
    REF = request.QueryString("REF")

end if
rs.close

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

tbl = "multi..RS_ALMOVD" + CIA
cad =    " select CALMA, CTD, CNUMDOC, CITEM,DFECDOC,CRFTDOC, " & _
         "  CRFNDOC, CTIPMOV, CCODMOV, CCODIGO,CDESCRI ,      " & _
         "  ISNULL(NCANTID,0) AS NCANTID,DETALLADO,VBCC,      " & _
         "  ISNULL(NCANTIDPROV,0) AS NCANTIDPROV ,            " & _
         "  CCODPROV, CNOMPROV,UNIMED,CNUMORD,COLOR,          " & _
         "  LOTE,ISNULL(BULTOS,0) AS BULTOS,                  " & _
         "  ISNULL(CONOS, 0) AS CONOS,ESTADO,                 " & _
         "  ISNULL(KGNETO,0) AS KGNETO,CodTipoMov,            " & _
         "  ISNULL(KGBRUTO,0) AS KGBRUTO,NumPurOrd,           " & _
         "  ISNULL(KGNETOPROV,0) AS KGNETOPROV,               " & _
         "  ISNULL(KGBRUTOPROV,0) AS KGBRUTOPROV,             " & _
         "  TIPSERVICIO,ISNULL(CUBICACION,'') AS CUBICACION,NumEstilo, " & _
         "  CAST(OBSERV AS VARCHAR(1000)) AS OBSERV            " & _
         "  from "&tbl&" WHERE CALMA='"&alm&"' AND CTD='"&ctd&"' " & _
         " AND CNUMDOC='"&doc&"' AND CITEM='"&itm&"'"
'response.write(cad)
RS2.Open cAD, Cnn
'RESPONSE.WRITE(tip)
'response.end
IF NOT RS2.EOF OR NOT RS2.BOF THEN	RS2.MOVEFIRST

ubi = rs2("cubicacion")
response.Write(ubi)
%>

<script language="jscript" type="text/jscript">
    oldrow = 1
    function llena(t, pos) {
        return true
    }

    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
</script>
 </head>

<body style="margin-top:0; margin-left:0; margin-right:0; background-color:#FFF" >
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="4" cellpadding="0" align="center" width="100%" style="background-color:#FFF" >
    <tr valign="middle">
        <td align="right" class="TEXTO" width="4%"> Documento :&nbsp;</td>
        <td colspan="6" class="DATOS"><%=CTD%>&nbsp;-&nbsp;<%=DOC%>
        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TEXTO" > Art&iacute;­culo :&nbsp;</td>
        <td colspan="6" class="DATOS"><%=ART%>&nbsp;-&nbsp;<%=DES%>
        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TEXTO" > Uni. Med. :&nbsp;</td>
        <td align="left" class="TEXTO" width="15%">
            <select  class="TEXTOblue100" id="uni" name="uni"  value="" style="text-align:center;width:100%">
                <option value="0"></option>
                <option value="1">UNID</option>
                <option value="2">CONO</option>
                <option value="3">KILOS</option>
                <option value="4">METROS</option>
            </select> 
        </td>
        <td width="15%">&nbsp;     </td>
        <td align="right" class="TEXTO" width="23%" > Servicio :&nbsp;</td>
        <td colspan="3">
        <%TBL1 = "multi..AL_TiposMov" + CIA
          TBL2 = "multi..AL_TipoMovxAlmacen" + CIA
        
        cad =   " select codtipomov, destipomov from "&TBL1&"          " & _
                " where CodClaseMov='"&TIP&"' AND codtipomov in(select " & _
                " distinct codtipomov from "&TBL2&" where codalmacen = " & _
                " '"&ALM&"')  order by 1                               " 
        RS.OPEN CAD, CNN     
        'response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="TEXTOblue100" id="ser" name="ser"  value="" style="text-align:ce>
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TEXTO" > Color :&nbsp;</td>
        <td colspan="3" ><input type="text" class="TEXTOblue100" id="col" name="col" style="text-align:left" value="<%=col%>" maxlength="20"/></td>
        
        <td align="right" class="TEXTO" > Lote :&nbsp;</td>
        <td colspan="2" ><input type="text" class="TEXTOblue100" id="lot" name="lot" style="text-align:left" value="<%=lot%>"/></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TEXTO" > Bultos :&nbsp;</td>
        <%if isNumeric(bul) = false then bul = 0%>
        <td  ><input type="text" class="TEXTOblue100" id="bul" name="bul" style="text-align:center" value="<%=formatnumber(bul,0,,,true)%>"  onblur="this.value=toInt(this.value)" /></td>
        
        <td align="right" class="TEXTO" id="contxt" name="contxt" style="display:none"> Conos :&nbsp;</td>
         <%if isNumeric(con) = false then con = 0%>
        <td  ><input type="text" class="TEXTOblue100" id="con" name="con" style="text-align:center; display:none" value="<%=formatnumber(con,0,,,true)%>" /></td>
        <td colspan="3" class="TEXTO" style="text-align:right" > Detalle Recibido por Talla:&nbsp;</td>
        <td width="2%"><input type="checkbox" id="chtal" name="chtal" onClick="tallas()"/></td>
    </tr>

    <tr valign="top">
    <td colspan="2">
    <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
            <!-----------------------------------------------------------------
                TABLA DE CANTIDADES ENVIADAS/RECIBIDAS POR LA EMPRESA
            ------------------------------------------------------------------->
                <table align="center"    cellpadding="0"  cellspacing="0"  border="0" width="100%">
	                <tr><td align="left" class="tituloGRANDEorange"><%if ctd = "PE" then%>Recibido<%else%>Entregado<%end if%></td></tr>
                </table>
                <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" style="background-color:#FFF" >
                    <tr valign="middle">
                        <td align="right" class="TEXTO" width="40%"> Cantidad :&nbsp;</td>
                        <td width="60%"><input type="text" class="TEXTOblue100" id="cnr" name="cnr" style="text-align:center" value="<%=formatnumber(rs2("ncantid"),3,,,true) %>"  onblur="this.value=toInt(this.value)" /></td>
                     
                    </tr>
                    <tr valign="middle">
                        <td align="right" class="TEXTO" > KG. Neto :&nbsp;</td><%if isnull(RS2("kgneto"))  then kneto = 0 else kneto = RS2("kgneto")   %>
                        <td class="container"><input type="text" class="TEXTOblue100" id="knr" name="knr" style="text-align:center" value="<%=FORMATNUMBER(kneto,3,,TRUE)%>"  onblur="this.value=toInt(this.value)" /></td>
                    </tr>
                       
                    <tr valign="middle">
                        <td align="right" class="TEXTO" > KG. Bruto :&nbsp;</td><%if isnull(RS2("kgBRUTO"))  then kbru = 0 else kbru = RS2("kgBRUTO")   %>
                        <td class="container"><input type="text" class="TEXTOblue100" id="kbr" name="kbr" style="text-align:center" value="<%=FORMATNUMBER(kbru,3,,TRUE) %>"  onblur="this.value=toInt(this.value)" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </td>
<!------------------------------------------------------------------------------------
Tablas de datos del PROVEEDOR
-------------------------------------------------------------------------------------->
    <td colspan="2">
    <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
                <table align="center"    cellpadding="0"  cellspacing="0"  border="0" width="100%">
	                <tr><td align="left" class="tituloGRANDEorange">Proveedor</td></tr>
                </table>
                <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" style="background-color:#FFF" >
                    <tr valign="middle">
                        <td align="right" class="TEXTO" width="40%"> Cantidad :&nbsp;</td>
                        <td width="60%"><input type="text" class="TEXTOblue100" id="cnp" name="cnp" style="text-align:center" value="<%=formatnumber(rs2("ncantidprov"),3,,,true) %>" onblur="this.value=toInt(this.value)" /></td>
                    </tr>
                    <tr valign="middle">
                        <td align="right" class="TEXTO" > KG. Neto :&nbsp;</td><%if isnull(RS2("kgnetoprov"))= true then knp = 0 else knp = RS2("kgnetoprov")   %>
                        <td class="container"><input type="text" class="TEXTOblue100" id="knp" name="knp" style="text-align:center" value="<%=FORMATNUMBER(knp,3,,TRUE) %>"  onblur="this.value=toInt(this.value)" /></td>
                    </tr>
                    <tr valign="middle">
                        <td align="right" class="TEXTO" > KG. Bruto :&nbsp;</td><%if isnull(RS2("kgBRUTOprov")) then kbp = 0 else kbp = RS2("kgBRUTOprov")   %>
                        <td class="container"><input type="text" class="TEXTOblue100" id="kbp" name="kbp" style="text-align:center" value="<%=FORMATNUMBER(kbp,3,,TRUE) %>"  onblur="this.value=toInt(this.value)" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </td>
    <td width="4%" rowspan="2">&nbsp;</td>
    <!----------------------------------------------------------------------------------
        TABLA QUE MUESTRA EL DETALLE POR TALLA
    ----------------------------------------------------------------------------------->
    <% TBL = "multi..RS_ALMOVD_TALLA" + CIA
        kad =   " Select Talla, Cantidad From "&TBL&" Where calma='"&alm&"' and CTD='"&ctd&"'  " & _
                " and CNUMDOC='"&doc&"' and CITEM='"&itm&"' ORDER BY orden                      "
        rs.open kad,cnn
        if rs.recordcount > 0 then rs.movefirst
        cont = 0
        'response.write(kad)
     %>
    <td id="detal" name="detal" colspan="3" align="right" style="display:none" rowspan="2"> 
        <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
                 <table align="center"    cellpadding="0"  cellspacing="0"  border="0" width="100%">
	                    <tr>
                            <td align="left" class="tituloGRANDEorange">Talla</td>
                            <td align="left" class="tituloGRANDEorange">Cantidad</td>
                            <td align="left" class="TEXTO" width="10%">&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <%do while not rs.eof %>
                            <tr valign="middle">
                                <td><input type="text" class="TEXTOblue100" id="t<%=cont %>" name="t<%=cont %>" value="<%=RS("talla")%>" style="text-align:left"/></td>
                                <td><input type="text" class="TEXTOblue100" id="c<%=cont%>" name="c<%=cont %>" value="<%=formatnumber(RS("cantidad"),0,,,true)%>" style="text-align:right"   onblur="this.value=toInt(this.value)"  /></td>
                            </tr>
                        <%rs.movenext %>
                        <%cont = cont + 1%>
                        <%loop%>
                        <%rs.close%>
                        <tr valign="middle" onkeydown ="linea('<%=cont%>')">
                            <td><input type="text" class="TEXTOblue100" id="t<%=cont %>" name="t<%=cont%>" value="" style="text-align:left"/></td>
                            <td><input type="text" class="TEXTOblue100" id="c<%=cont %>" name="c<%=cont%>" value="" style="text-align:right"  onblur="this.value=toInt(this.value)"   /></td>
                        </tr>
                        <%cont = cont + 1%>
                        <%for i= cont to cont +10%>
                             <tr valign="middle" id="lin<%=i%>" style="display:none" onkeydown="linea('<%=i%>')">
                                <td><input type="text" class="TEXTOblue100" id="t<%=i%>" name="t<%=i %>" value="" style="text-align:left"/></td>
                                <td><input type="text" class="TEXTOblue100" id="c<%=i%>" name="c<%=i %>" value="" style="text-align:right"  onblur="this.value=toInt(this.value)"   /></td>
                            </tr>
                        <%next%>
                        <%maxlin = i%>
                        <tr>
                            <td  align="right" class="TEXTO" colspan="2">
                             <input type="checkbox" id="chkCC" name="chkCC" value = '<%If Rs2.Fields("VBCC").Value = "S" Then response.write("1") else response.write("0")%>'  />   
                             &nbsp;Requiere CC
                            </td>
                        </tr>  
                 </table>
            </td>
        </tr>
        
        </table>
    </td>
    </tr>
    <tr valign="top">
        <td align="right" class="TEXTO" > Ubicaci&oacute;n:&nbsp;</td>
        <td align="left" class="TEXTO" width="25%">
        <%TBL1 = "multi..RS_ALMOV_UBICACION" + CIA
        cad =   " select cubicacion,  CESTANTE+ ' ['+FILA+CAST(COLUMNA AS VARCHAR(5))+']'   " & _
                " from "&tbl1&" where CALMA='"&alm&"'       " & _
                " UNION SELECT '', '' ORDER BY 1,2"

        'RESPONSE.Write(CAD)
        RS.OPEN CAD, CNN               
        
        IF RS.RECORDCOUNT > 0 AND CTD = "PE" THEN 
            RS.MOVEFIRST  
        ELSE  
            RS.MOVE RS.RECORDCOUNT+1
        END IF    %>
            <select  class="TEXTOblue100" id="ubi" name="ubi"  style="text-align:center;width:100%">
                <%DO WHILE NOT RS.EOF %>
                    <option value='<%=RS.FIELDS.ITEM(0)%>'><%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
        <td colspan="2">&nbsp;     </td>
    </tr>
    <tr>
        <td class="AMERICANnavy">Observaci&oacute;n: &nbsp; </td>
        <td colspan="7" class="conter">
            <textarea id="obs" name="obs" class="estilotextarea2"><%=trim(rs2("observ")) %></textarea>
        </td>
    </tr>
    <tr>
        <td colspan="4" align="right"><input type="button" value="Aceptar" id="ok" name="ok" onClick="envia(1)" /></td>
        <td colspan="4" align="left"><input type="button" value="Cancelar" id="no" name="no" onClick="envia(0)" /></td>
    </tr>
</table>

<script language="jscript" type="text/jscript">


    var subcadena = '<%=trim(ucase(uni))%>'
   //alert(subcadena)
    var elemento = document.all.uni;
    document.all.uni.selectedIndex = seleindice(subcadena, elemento);

    var subcadena = '<%=SER%>'
    var elemento = document.all.ser;
    document.all.ser.selectedIndex = ubicasele(subcadena, elemento);
    
    var subcadena = '<%=ubi%>'
    //alert(subcadena)
    var elemento = document.all.ubi;
    document.all.ubi.selectedIndex = seleindice(subcadena, elemento);

ctd = '<%=ctd%>'
if (ctd != 'PE')
{   document.all.ubi.disabled = true}

sCodAlmacen = '<%=ucase(trim(alm))%>'
hilado = sCodAlmacen.substring(2, 3);
DETA = '<%=TRIM(UCASE(RS2("DETALLADO")))%>'

if (hilado == 'H') {
    document.all.con.style.display = 'block'
    document.all.contxt.style.display = 'block'
}
//alert('<%=bul %>')
if (document.all.bul.value == '')
    document.all.bul.style.display = 'none'

if (document.all.uni.value == '3')
    document.all.cnr.disabled = false
else
    document.all.cnr.disabled = true
    
if (DETA == 'S')
   {    document.all.chtal.checked = true
        document.all.detal.style.display = 'block'
    }

function tallas() {
    if (document.all.chtal.checked == true) {
        document.all.detal.style.display = 'block'
    }
    else {
        document.all.detal.style.display = 'none'
    }
}
function linea(ln) {
    ln = parseInt(ln, 10) + 1
    tope = parseInt('<%=maxlin %>',10)
    if (ln < tope)
eval("document.all.lin"+ln+".style.display='block'")

}

function envia(op) {  
if (op == '0') {
    this.window.close()
    return false
}

if (document.all.ser.value == "")
    {   alert("Debe seleccionar el Servicio")
        document.all.ser.focus()
        return false
    }
/*
    if (ctd == 'PE' && document.all.ubi.value == '')
    {   alert("Debe seleccionar la Ubicacion")
        document.all.ubi.focus()
        return false;
    }
*/
    if (parseFloat(document.all.cnp.value)  == 0)
        {   alert("Debe ingresar la Cantidad Recibida del Proveedor")
            document.all.cnp.focus()
            return false;
        }

      if (parseFloat(document.all.knr.value)  == 0)
       {    alert("Debe ingresar los KG netos")
            document.all.knr.focus()
            return false;
        }
     if (parseFloat(document.all.kbr.value)  == 0)
       {    alert("Debe ingresar los KG Brutos")
            document.all.kbr.focus()
            return false;
        }
    var aTal = new Array(); 
    var aCan = new Array();
    po = 0
    if (document.all.chtal.checked == true) 
    {   cont = 0
        tope = parseInt('<%=maxlin%>',10) 
        
        for (io=0; io<tope; io++) {
            canti = trim(eval("document.all.c" + io + ".value"))
           canti = parseFloat(canti)
        if (isNaN(canti) == false)
            {  cont += parseInt(canti,10)
                aTal[po] = trim(eval("document.all.t"+io+".value"))
                aCan[po++] = parseInt(canti,10)
             
             }
        }
        tta = document.all.cnp.value
        tot = tta.replace(',', '')
        tota = parseInt(tot, 10)
       //  alert(cont)
        if (parseInt(cont,10)!= tota)
        {   alert("Las cantidades por talla, no coinciden.\n Verifique")
            return false;
        }
    }
    sCodCTD = '<%=ucase(trim(CTD))%>'
    sValor = parseFloat(document.all.knp.value) - parseFloat(document.all.knr.value) 
    if ((sCodCTD == 'PE') && (sValor > (parseFloat(document.all.knp.value) * 0.05) ))
    {   var si
	    {si = confirm("¿ La diferencia entre el Neto-Recibido con el el Neto-Proveedor mayor al 5%.\n ¿Desea continuar?");} 
	    if (si == false)
	    { return false;}
    }
       
    cad = 'COMUN/parteMULTI.ASP'
    cad += '?ALM=' + '<%=ALM%>'
	cad += '&CTD=' + '<%=CTD%>'
	cad += '&doc=' + '<%=DOC%>'
	cad += '&ITM=' + '<%=ITM%>'
	cad += '&UNI=' + document.all.uni.value
	cad += '&COL=' + document.all.col.value
	cad += '&REF=' + '<%=REF%>'
	cad += '&pe1=' + '<%=pe1%>'
	cad += '&pe2=' + '<%=pe2%>'
	cad += '&ps1=' + '<%=ps1%>'
	cad += '&glos=' + '<%=glos%>'
	cad += '&LOT=' + document.all.lot.value
	cad += '&BUL=' + document.all.bul.value
	cad += '&CON=' + document.all.con.value
	cad += '&KGN=' + document.all.knr.value
	cad += '&KGB=' + document.all.kbr.value
	cad += '&CNP=' + document.all.cnp.value
	cad += '&KNP=' + document.all.knp.value
	cad += '&KBP=' + document.all.kbp.value
	cad += '&SER=' + document.all.ser.value
	cad += '&UBI=' + document.all.ubi.value
	cad += '&OBS=' + document.all.obs.value
     if (document.all.chtal.checked == true) 
	    cad += '&TAL=S'
    else
        cad += '&TAL=N'
    cad += '&VBC=N'
	cad += '&oc=' + '<%=OC%>'
    cad += '&ata=' + aTal
    cad += '&aca=' + aCan

 // alert(cad)
window.location.replace(cad)

}


</script>
</form>

</body>
</HTML>
