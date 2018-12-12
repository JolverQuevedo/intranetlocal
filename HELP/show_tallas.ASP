<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<html>
<head>
<title>DATOS Adicionales Real</title>
<link href="../ESTILOS1.CSS" rel="stylesheet" type="text/css">

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
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->

<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<%'****************************************************
ALM = request.QueryString("ALM")	
CTD = request.QueryString("CTD")	
DOC = request.QueryString("DOC")	
TIP = request.QueryString("TIP")
ART = request.QueryString("ART")	
DES = request.QueryString("DES")	
COL = request.QueryString("COL")	
LOT = request.QueryString("LOT")	
bul = request.QueryString("bul")
if trim(bul) = "" then bul = 0 
con = request.QueryString("con")
if trim(con) = "" then con = 0 
cnr = request.QueryString("cnr")
itm = request.QueryString("itm")
ser = request.QueryString("ser")

ubi = request.QueryString("ubi")
uni = request.QueryString("uni")
OC = request.QueryString("OC")
REF = request.QueryString("REF")
CIA = "0001"
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3
'response.write(request.querystring())
tbl = "multi..RS_ALMOVD" + CIA
cad =    " select CALMA, CTD, CNUMDOC, CITEM,DFECDOC,CRFTDOC, " & _
         " CRFNDOC, CTIPMOV, CCODMOV, CCODIGO,CDESCRI ,       " & _
         " ISNULL(NCANTID,0) AS NCANTID,DETALLADO,VBCC,       " & _
         " ISNULL(NCANTIDPROV,0) AS NCANTIDPROV ,             " & _
         " CCODPROV, CNOMPROV,UNIMED,CNUMORD,COLOR,           " & _
         " LOTE,ISNULL(BULTOS,0) AS BULTOS,                   " & _
         " ISNULL(CONOS, 0) AS CONOS,ESTADO,                  " & _
         " ISNULL(KGNETO,0) AS KGNETO,CodTipoMov,             " & _
         " ISNULL(KGBRUTO,0) AS KGBRUTO,NumPurOrd,            " & _
         " ISNULL(KGNETOPROV,0) AS KGNETOPROV,                " & _
         " ISNULL(KGBRUTOPROV,0) AS KGBRUTOPROV,              " & _
         " TIPSERVICIO,ISNULL(CUBICACION,'') AS CUBICACION,   " & _
         " NumEstilo, CAST(OBSERV AS VARCHAR(1000)) AS OBSERV " & _
         " from "&tbl&" WHERE CALMA = '"&alm&"' AND           " & _
         " CTD ='"&ctd&"' AND CNUMDOC='"&doc&"' AND           " & _
         " CITEM='"&itm&"'                                    "
'response.write(cad)
RS2.Open cAD, Cnn
'RESPONSE.WRITE(tip)
'response.end
IF NOT RS2.EOF OR NOT RS2.BOF THEN	RS2.MOVEFIRST
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

<body style="margin-top:0; margin-left:0; margin-right:0;" >
<form name="thisForm" method="post" >
<table  border="0" cellspacing="4" cellpadding="0" align="center" width="100%"  >
    <tr valign="middle">
        <td align="right" class="TALASGREENRIGHT" width="4%"> Documento :&nbsp;</td>
        <td colspan="6" class="DATOSgrande2"><%=CTD%>&nbsp;-&nbsp;<%=DOC%>
        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TALASGREENRIGHT" > Art&iacute;­culo :&nbsp;</td>
        <td colspan="6" class="DATOSgrande2"><%=ART%>&nbsp;-&nbsp;<%=DES%>
        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TALASGREENRIGHT" > Uni. Med. :&nbsp;</td>
        <td align="left" class="DATOSgrande2" width="15%">
            <%Select Case uni
                Case "1"
	                UN = "UNID"
                Case "2"
	                UN = "CONO"
                Case "3"
	                UN = "KILOS"
                Case "4"
	                UN = "METROS"
                Case "0"
	                UN = ""
              End Select%>
            <%=un%>
        </td>
        <td width="15%" colspan="2">&nbsp;     </td>
        <td align="right" class="TALASGREENRIGHT" width="23%" > Servicio :&nbsp;</td>
        <td colspan="2" class="DATOSgrande2">
        <%TBL1 = "multi..AL_TiposMov" + CIA
          TBL2 = "multi..AL_TipoMovxAlmacen" + CIA
        
        cad =   " select codtipomov, destipomov from "&TBL1&"          " & _
                " where CodClaseMov='"&TIP&"' AND codtipomov = '"&ser&"'      " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
           <%=RS.FIELDS.ITEM(1)%>
                <%rs.close%>

        </td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TALASGREENRIGHT" > Color :&nbsp;</td>
        <td colspan="3" class="DATOSgrande2" ><%=col%></td>
        
        <td align="right" class="TALASGREENRIGHT" > Lote :&nbsp;</td>
        <td colspan="2" class="DATOSgrande2"><%=lot%></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="TALASGREENRIGHT" > Bultos :&nbsp;</td>
        <td  class="DATOSgrande2" ><%=formatnumber(bul,0,,,true)%></td>
        
        <td align="right" class="talasgreenright" > Conos :&nbsp;</td>
        <td class="DATOSgrande2" ><%=formatnumber(con,0,,,true)%></td>
        <td colspan="2" class="TALASGREENRIGHT"  > Detalle Recibido por Talla:&nbsp;</td>
        <td width="2%" style="text-align:right; visibility:hidden;" ><input type="checkbox" id="chtal" name="chtal" onClick="tallas()"/></td>
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
                <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" >
                    <tr valign="middle">
                        <td align="right" class="TALASGREENRIGHT" width="40%"> Cantidad :&nbsp;</td>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;"><%=formatnumber(rs2("ncantid"),3,,,true) %></td>
                     
                    </tr>
                    <tr valign="middle">
                        <td class="TALASGREENRIGHT" > KG. Neto :&nbsp;</td><%if isnull(RS2("kgneto"))  then kneto = 0 else kneto = RS2("kgneto")   %>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;"><%=FORMATNUMBER(kneto,3,,TRUE)%></td>
                    </tr>
                       
                    <tr valign="middle">
                        <td align="right" class="TALASGREENRIGHT" > KG. Bruto :&nbsp;</td><%if isnull(RS2("kgBRUTO"))  then kbru = 0 else kbru = RS2("kgBRUTO")   %>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;"><%=FORMATNUMBER(kbru,3,,TRUE) %></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </td>
<!------------------------------------------------------------------------------------
Tablas de datos del PROVEEDOR
-------------------------------------------------------------------------------------->
    <td colspan="3">
    <table align="center"    cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
                <table align="center"    cellpadding="0"  cellspacing="0"  border="0" width="100%">
	                <tr><td class="tituloGRANDEorange">Proveedor</td></tr>
                </table>
                <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%">
                    <tr valign="middle">
                        <td align="right" class="TALASGREENRIGHT"> Cantidad :&nbsp;</td>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;" ><%=formatnumber(rs2("ncantidprov"),3,,,true) %></td>
                    </tr>
                    <tr valign="middle">
                        <td class="TALASGREENRIGHT" > KG. Neto :&nbsp;</td>
                        <%if isnull(RS2("kgnetoprov"))= true then knp = 0 else knp = RS2("kgnetoprov")  %>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;" ><%=FORMATNUMBER(knp,3,,TRUE) %></td>
                    </tr>
                    <tr valign="middle">
                        <td align="right" class="TALASGREENRIGHT" > KG. Bruto :&nbsp;</td>
                        <%if isnull(RS2("kgBRUTOprov")) then kbp = 0 else kbp = RS2("kgBRUTOprov")%>
                        <td class="datosgrande2" style="text-align:right;padding-right:10px;" ><%=FORMATNUMBER(kbp,3,,TRUE)%></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </td>
    
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
    <td id="detal" name="detal" colspan="2" align="right"  rowspan="2"> 
        <table align="center"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
        <tr>
            <td>
                 <table align="center"    cellpadding="4"  cellspacing="0"  border="1" width="100%">
	                    <tr>
                            <td class="tituloGRANDEorange" style="text-align:left; width:50%;">Talla</td>
                            <td class="tituloGRANDEorange" style="text-align:left; width:50%;">Cantidad</td>
                          
                        </tr>
                        <%do while not rs.eof %>
                            <tr valign="middle">
                                <td class="datosgrande2"><%=RS("talla")%></td>
                                <td class="datosgrande2"><%=formatnumber(RS("cantidad"),0,,,true)%></td>
                            </tr>
                            <%rs.movenext %>
                        <%loop%>
                        <%rs.close%>
                        
                        <%maxlin = i%>
                       
                 </table>
            </td>
        </tr>
        
        </table>
    </td>
    </tr>
    <tr valign="top">
        <td align="right" class="TALASGREENRIGHT" > Ubicaci&oacute;n:&nbsp;</td>
        <td align="left" class="datosgrande2" width="25%">
        <%=rs2("CUBICACION")%></td>
        <td colspan="3">&nbsp;     </td>
    </tr>
    <tr>
        <td class="TALASGREENRIGHT">Observaci&oacute;n: &nbsp; </td>
        <td colspan="7" class="datosgrande2"><%=trim(rs2("observ")) %></td>
    </tr>
   
</table>

<script language="jscript" type="text/jscript">
  






</script>
</form>

</body>
</HTML>
