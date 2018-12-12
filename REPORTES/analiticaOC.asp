<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!--#include file="../includes/Cnn.inc"-->
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />
<%
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

OC	=	Request.QueryString("OC") 
' DATOS DE CABECERA DEL MODELADOR
cia =   "Select * From RSFACCAR..ALCIAS Where AC_CCIA='0001' ; "
' CABECERA DE LA ORDEN DE COMPRA
cab =	" Select * From RSFACCAR..CO0001MOVC            " & _
        " LEFT OUTER JOIN RSCONCAR..CP0001MAES          " & _
        " on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO   " & _
        " Where OC_CNUMORD='"&OC&"';                    "

' LINEAS DE DETALLE
det =   "Select * From RSFACCAR..CO0001MOVD Where OC_CNUMORD='"&oc&"' and  OC_CITEM <> ''" 
		
    ' response.Write(cab)   
        
        RS.OPEN Cia ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Tabla  Vacía")		
	Response.End
end if	
rs.movefirst
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style type="text/css" media="print">
    .page
    { -webkit-transform: rotate(-90deg); -moz-transform:rotate(-90deg);
      filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
    }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PRN OC_ANALITICA</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" class="page">

<table width="100%">
	<tr>
	    <td width="20%" class="AMERICAN2"><%=UCASE(RS("AC_CNOMCIA")) %></td>
		<td width="60%" align="center" class="AMERICAN22"> CONSULTA ORDEN DE COMPRA # <%=OC%> ANALITICA</td>
		<td width="20%" class="DESCRIPTORnegroder" align="right"><%=NOW() %></td>
 <tr><td colspan="3" style="height:30px;">&nbsp;</td></tr>
    </tr>
    <tr>
        <td colspan="3"  class="AMERICAN2">1. DATOS PRINCIPALES:</td>
    </tr>
    <tr>
        <td colspan="3"><hr /></td>
    </tr>
</table>
<%
nomcia = rs("ac_cnomcia")

RS.CLOSE
RS.OPEN CAB,CNN
IF RS.RECORDCOUNT <=0 THEN
RESPONSE.WRITE("SIN DATOS....")
RESPONSE.End
END IF
RS.MOVEFIRST


EDO = RS("OC_CSITORD")
if len(trim(EDO)) > 0 then
    vvv = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='31' and tg_cclave = '"&EDO&"'"
    '  response.write(vvv)
    rs2.open vvv,cnn
    rs2.movefirst
    ESTADO = EDO + " - " + rs2("tg_cdescri")
    rs2.close       
else
    ESTADO = ""
end if
mon = RS("oc_ccodmon")
        vvv = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='03' and tg_cclave = '"&mon&"'"
        'response.write(vvv)
        rs2.open vvv,cnn
        rs2.movefirst
        desmon = rs2("tg_cdescri")
        MONEDAS = MON + " " + DESMON
        CODMON = MON
        rs2.close%>
<table width="100%">
	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Orden de Compra : </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(RS("OC_CNUMORD")) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Fecha Emision : </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=FORMATDATETIME(RS("OC_DFECDOC"),2) %></td>
    </tr>
	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Proveedor : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_ccodpro")) %></td>    
	    <td class="DESCRIPTORnegroizq" width="10%">RUC : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_ccodpro")) %></td>
        <%RUC = UCASE(RS("oc_ccodpro")) %>
    </tr>
    <tr align="left">
    <%PROVEE=UCASE(RS("oc_crazsoc")) %>
	    <td class="DESCRIPTORnegroizq" width="10%">Telefono : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_crazsoc")) %></td>
	    <td class="DESCRIPTORnegroizq" width="10%">Fax : </td>
        <td class="DESCRIPTORnegroizq">&nbsp;</td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Direccion : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cdirpro")) %></td>
	    <td class="DESCRIPTORnegroizq" width="10%">Tipo Despacho : </td>
        <td class="DESCRIPTORnegroizq"><%=ucase(rs("oc_ctipdsp")) %></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Doc Ref : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_ctipdoc"))%> - <%=UCASE(RS("oc_cnumref"))%></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Moneda : </td>
        <%mon = RS("oc_ccodmon")
        vvv = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='03' and tg_cclave = '"&mon&"'"
        'response.write(vvv)
       
        rs2.open vvv,cnn
        rs2.movefirst
        desmon = rs2("tg_cdescri")
        MONEDAS = MON + " " + DESMON
        rs2.close%>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_ccodmon"))%> - <%=UCASE(desmon)%></td>
	    <td class="DESCRIPTORnegroizq" width="10%">Tipo Orden : </td>
        <%tip = RS("oc_ctipord")
        rs2.open "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='63' and tg_cclave = '"&tip&"'",cnn
        rs2.movefirst
        destip = rs2("tg_cdescri")
        rs2.close%>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_ctipord"))%> - <%=UCASE(destip)%></td>
        <%TIPORDEN=UCASE(RS("oc_ctipord"))+ "-  " +UCASE(destip)%>  
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Forma de Pago : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cforpa1")) %></td>
	    <td class="DESCRIPTORnegroizq" width="10%">Tipo de Cambio : </td>
        <td class="DESCRIPTORnegroizq"><%=formatnumber(rs("oc_ntipcam"),4,,, true) %></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Fecha Entrega : </td>
        <td class="DESCRIPTORnegroizq"><%=FORMATDATETIME(RS("OC_DFECent"),2) %></td>
	    <td class="DESCRIPTORnegroizq" width="10%">% Desc Financiero : </td>
        <td class="DESCRIPTORnegroizq"><%=formatnumber(rs("oc_npordes"),0,,, true) %></td>
    </tr> 
    <tr><td colspan="4"><hr /></td></tr>

	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Solicitante : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_csolict")) %></td>
    </tr>
    
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Centro Costo: </td>
      <%mon = RS("oc_ccostoc")
        if len(trim(mon)) > 0 then
            vvv = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' and tg_cclave = '"&mon&"'"
          '  response.write(vvv)
            rs2.open vvv,cnn
            rs2.movefirst
            desmon = rs2("tg_cdescri")
            rs2.close
        else
            desmon = ""
        end if
        %>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_ccostoc")) %> - <%=ucase(desmon) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Tipo envio: </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_ctipenv")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Alm. Entrega : </td>
         <%mon = RS("oc_calmdes")
        vvv = "Select A1_CALMA,A1_CDESCRI From RSFACCAR..AL0001ALMA where A1_CALMA= '"&mon&"'"
        'response.write(vvv)
        rs2.open vvv,cnn
        rs2.movefirst
        desmon = rs2("a1_cdescri")
        rs2.close%>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_calmdes")) %> - <%=UCASE(desmon)%></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Lugar Entrega  : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oC_Clugent")) %></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Distrito : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_cdistoc")) %></td>
    </tr>
     <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Lugar Factura : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_clugfac")) %></td>
    </tr>
     <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Observaciones : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_cdetent")) %></td>
    </tr>
     <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Remitente : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_cremite")) %></td>
    </tr>
     <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Contactos : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cconta1")) %></td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cconta2")) %></td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cconta3")) %></td>
    </tr>
    <tr><td colspan="4"><hr /></td></tr>
      <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Fecha Pago : </td>
        <td class="DESCRIPTORnegroizq"><%=(RS("oc_dfecpag")) %></td>
        <td class="DESCRIPTORnegroizq">Estado</td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("oc_cestpag")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Importe : </td>
        <td class="DESCRIPTORnegroizq"><%if rs("oc_ccodmon")= "US" then response.write(formatnumber(rs("oc_nimpus"),2,,, true)) else response.write(formatnumber(rs("oc_nimpmn"),2,,, true)) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Glosa : </td>
        <td class="DESCRIPTORnegroizq" colspan="3"><%=UCASE(RS("oc_cglopag")) %></td>
    </tr>
    <tr><td colspan="4" style="height:5px;" ><hr /></td></tr>
    <tr><td colspan="4"  class="AMERICAN2" style="vertical-align:bottom">2. MOVIMIENTOS DE LA ORDEN DE COMPRA :</td></tr>
    <tr><td colspan="4"  class="DESCRIPTORnegro" style="vertical-align:bottom">PARTES DE ENTRADA :</td></tr>
    <tr><td colspan="4"  style="height:5px;" ><hr /></td></tr>
</table>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
    <tr class="DESCRIPTORnegro" >
        <td width="5%" align="CENTER">ALMACEN</td>
        <td width="5%" align="CENTER">MOV</td>
        <td width="15%" align="CENTER">PARTE DE ENTRADA</td>
        <td width="10%" align="CENTER">FECHA</td>
        <td width="65%" align="LEFT">REFERENCIA</td>
    </tr>
    <tr><td colspan="6"><hr /></td></tr>
    <%RS.CLOSE
    CAD =   " Select DISTINCT  C5_CTD AS MOV,C5_CNUMDOC AS DOC, C5_CCODMOV, " & _
            " C5_CRFTDOC + ' ' + C5_CRFNDOC AS REF, C5_CTIPMOV,C5_DFECDOC,  " & _
            " c5_calma From RSFACCAR..AL0001MOVC as MOVC                    " & _
            " INNER JOIN RSFACCAR..al0001movd AS B                          " & _
            " on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd                " & _
            " and c5_calma = c6_calma                                       " & _
            " INNER JOIN RSFACCAR..CO0001MOVD AS C                          " & _
            " ON C.OC_CNUMORD = MOVC.C5_CNUMORD                             " & _
            " WHERE MOVC.C5_CNUMORD = '"&oc&"'                              " & _
            " AND (OC_CCODIGO = C6_CCODIGO OR OC_CCODREF = C6_CCODIGO)      " & _
            " ORDER BY C5_CTIPMOV,C5_CTD, C5_CNUMDOC;                       "
  '  RESPONSE.WRITE(CAD)
    RS.OPEN CAD,CNN

    if rs.recordcount <=0 then
        response.Write("SIN DATOS")
        RESPONSE.End
    END IF
    RS.MOVEFIRST
    do while not rs.eof AND UCASE(TRIM(RS("C5_CTIPMOV"))) = "E"%>
    <tr  class="DESCRIPTORnegro" valign="top">
	    <td align="center"><%=RS("C5_CALMA") %></td>
        <td align="center"><%=RS("C5_CCODMOV") %></td>
        <td align="center"><%=UCASE(RS("MOV"))%>&nbsp;<%=UCASE(RS("DOC")) %></td>
        <td align="center"><%=FORMATDATETIME(RS("C5_DFECDOC"),2)%></td>
        <td align="left"><%=trim(RS("REF")) %></td>
     </tr>
        <%RS.MOVENEXT%>
        <%IF RS.EOF THEN EXIT DO %>
    <%loop%>

    <tr><td colspan="5"><hr /></td></tr>
    <tr><td colspan="5"  class="DESCRIPTORnegro" style="vertical-align:bottom">PARTES DE SALIDA :</td></tr>
    <tr><td colspan="5"><hr /></td></tr>
    <tr class="DESCRIPTORnegro" >
        <td width="5%" align="CENTER">ALMACEN</td>
        <td width="5%" align="CENTER">MOV</td>
        <td width="15%" align="CENTER">PARTE DE SALIDA</td>
        <td width="10%" align="CENTER">FECHA</td>
        <td width="65%" align="LEFT">REFERENCIA</td>
    </tr>
    <tr><td colspan="6"><hr /></td></tr>

    <%IF not RS.EOF THEN  %>
        <%do while not rs.eof AND UCASE(TRIM(RS("C5_CTIPMOV"))) = "S"%>
        <tr  class="DESCRIPTORnegro" valign="top">
	        <td align="center"><%=RS("C5_CALMA") %></td>
            <td align="center"><%=RS("C5_CCODMOV") %></td>
            <td align="center"><%=UCASE(RS("MOV"))%>&nbsp;<%=UCASE(RS("DOC")) %></td>
            <td align="center"><%=FORMATDATETIME(RS("C5_DFECDOC"),2)%></td>
            <td align="left"><%=trim(RS("REF")) %></td>
  
         </tr>
            <%RS.MOVENEXT%>
            <%IF RS.EOF THEN EXIT DO %>
        <%loop%>
    <%end if %>
    <tr><td colspan="5"><hr /></td></tr>
    <tr><td colspan="5"  class="DESCRIPTORnegro" style="height:35px; vertical-align:bottom">ATENCION DE LA OC :</td></tr>
    <tr><td colspan="5"><hr /></td></tr>
    <tr>
        <td colspan="5">
            <table width="100%" cellpadding="1" cellspacing="1" border="0" >
                <tr class="DESCRIPTORnegro" >
                    <td width="10%" align="center">CODIGO</td>
                    <td width="50%" align="left">DESCRIPCION</td>
                    <td width="5%"  align="center">UND</td>
                    <td width="10%" align="right">ORDENADO</td>
                    <td width="10%" align="right">ATENDIDO</td>
                    <td width="10%" align="right">PENDIENTE</td>
                    <td width="5%" align="center">%</td>
                </tr>
                <tr><td colspan="7"><hr /></td></tr>
                <%RS.CLOSE
                CAD = " Select OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDENADO, " & _       
                      " ISNULL((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A                              " & _
                      " inner join RSFACCAR..al0001movd AS B                                                       " & _
	                  "     on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                 " & _
	                  "     where C5_CNUMord='"&OC&"'   AND C6_Ccodigo = CC.OC_Ccodigo and oc_citem = c6_citemoc   " & _
                      " and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'E'),0) As ENTRA,                           " & _
                      " ISNULL((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A                              " & _
                      " inner join RSFACCAR..al0001movd AS B                                                       " & _
	                  "     on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                 " & _
	                  "     where C5_CNUMord='"&OC&"'   AND C6_Ccodigo = CC.OC_Ccodigo and oc_citem = c6_citemoc   " & _
                      " and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'S'),0) As SALE                             " & _
                      " From RSFACCAR..CO0001MOVD  AS CC                                                           " & _
                      " Where OC_CNUMORD='"&OC&"'  AND OC_CCODPRO='"&RUC&"' AND OC_NCANORD > 0                     " & _
                      " ORDER BY OC_CITEM   ;                                                                      " 
                'response.write(cad)

                RS.OPEN CAD, CNN
                IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST%>
                <%do while not rs.eof %>
                    <%atendido = CDBL(RS("ENTRA"))+CDBL(RS("sale"))%>
                    <%pendiente  = (CDBL(RS("ORDENADO"))-CDBL(RS("ENTRA"))+CDBL(RS("sale"))) *-1%>
                    <%ATEN = ROUND((PENDIENTE * 100 ) / CDBL(RS("ORDENADO")),0)
                        if aten > 0 then
                            col =  "green"
                        elseif aten = 0 then 
                            col = "navy"
                        else
                            col = "red"
                        end if   %>
                    <tr  class="DESCRIPTORnegro" style="color:'<%=col%>';" valign="top">
                        
	                    <td align="center"><%=RS("COD") %></td>
                        <td align="left"><%=UCASE(RS("DESCRI"))%></td>
                        <td align="center"><%=UCASE(RS("UNI"))%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDENADO")),3,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(ATENDIDO,3,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(pendiente,3,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=ATEN%> %</td>
                     </tr>
                        <%RS.MOVENEXT%>
                        <%IF RS.EOF THEN EXIT DO %>
                 <%loop%>
            </table>
        </td>
    </tr>
    
    <tr><td colspan="5"><hr /></td></tr>
    <tr><td colspan="5"  class="DESCRIPTORnegro" style="height:35px; vertical-align:bottom">DOCUMENTOS EN SISPAG :</td></tr>
    <tr><td colspan="5"><hr /></td></tr>
    <tr>
        <td colspan="5">
        <%CAD = " SELECT CP_CTIPDOC+ ' ' + CP_CNUMDOC AS doc,                                    " & _
                " RTRIM(A.CP_CCODIGO) + ' ' + ltrim(rtrim(B.AC_CNOMBRE)) AS PROVEE,             " & _
                " CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NIMPOMN ELSE A.CP_NIMPOUS END IMPORTE,  " & _
                " CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NSALDMN ELSE A.CP_NSALDUS END SALDO,    " & _ 
                " CP_CTIPDOC, CP_CNUMDOC, CP_DFECDOC, CP_DFECVEN, CP_CCODMON, CP_CSUBDIA,       " & _
                " CP_CCOMPRO,CP_CFECCOM                                                         " & _
                " FROM RSCONCAR..CP0001CART AS A                                                " & _
                " LEFT JOIN RSCONCAR..CP0001MAES AS B ON A.CP_CVANEXO=B.AC_CVANEXO              " & _
                " AND A.CP_CCODIGO=B.AC_CCODIGO                                                 " & _
                " WHERE A.CP_CTDOCRE='OC'   AND A.CP_CNDOCRE='"&OC&"' ORDER BY PROVEE    "
           '     RESPONSE.WRITE(CAD)
                %>
         <table width="100%" cellpadding="1" cellspacing="1" border="0" >
                <tr class="DESCRIPTORnegro" >
                    <td width="40%" align="center">PROVEEDOR</td>
                    <td width="10%" align="left">TD DOCUMENTO</td>
                    <td width="10%"  align="right">EMISION</td>
                    <td width="10%" align="right">VMTO</td>
                    <td width="5%" align="center">MON</td>
                    <td width="15%" align="right">IMPORTE</td>
                    <td width="10%" align="right">SALDO</td>
                </tr>
                <tr><td colspan="7"><hr /></td></tr>
               <% RS.CLOSE
               RS.OPEN CAD, CNN
                IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST%>
                <%do while not rs.eof %>
                    <tr  class="DESCRIPTORnegro" valign="top">
                        
	                    <td align="center"><%=UCASE(RS("PROVEE"))%></td>
                        <td align="left"><%=UCASE(RS("DOC"))%></td>
                        <td align="right"><%=FORMATDATETIME(RS("CP_DFECDOC"),2)%></td>
                        <td align="right"><%=FORMATDATETIME(RS("CP_DFECVEN"),2)%></td>
                        <td align="center"><%=UCASE(RS("CP_CCODMON"))%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("IMPORTE")),3,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALDO")),3,,,TRUE)%></td>
                        
                     </tr>
                        <%RS.MOVENEXT%>
                        <%IF RS.EOF THEN EXIT DO %>
                 <%loop%>
            </table>
        </td>   
    </tr>
    <tr><td colspan="5" style="height:5px;" ><hr /></td></tr>
    <tr><td colspan="5"  class="AMERICAN2" style="vertical-align:bottom">3. DOCUMENTOS DE IMPORTACION :</td></tr>
    <tr><td colspan="5"  style="height:5px;" ><hr /></td></tr>
    <%cad = " Select LQ_CNUMLIQ, LQ_CNUMORD, LQ_CCODPRO, LQ_CTIPLIQ, LQ_CTIPDOC + ' ' + LQ_CNUMDOC AS DOCUM,    " & _
            " LQ_DFECDOC, LQ_CTIPMON, CASE LQ_CTIPMON WHEN 'MN' THEN  LQ_NIMPMN ELSE LQ_NIMPUS END AS IMPORTE,  " & _
            " LQ_CSUBDIA, LQ_CCOMPRO, AC_CNOMBRE                                                                " & _
            " From RSFACCAR..AL0001IMPD  Left Join RSCONCAR..CP0001MAES On LQ_CCODPRO=AC_CCODIGO                " & _
            " Where LQ_CNUMORD='"&oc&"' Order By LQ_CNUMORD                                                     "
        
    RS.CLOSE
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT >0 THEN %>       
    <tr>
        <td colspan="5">
            <table width="100%" cellpadding="1" cellspacing="1" border="0" >
                <tr class="DESCRIPTORnegro" >
                    <td width="10%" align="center">IMPORTACION</td>
                    <td width="30%" align="left">PROVEEDOR</td>
                    <td width="10%"  align="center">DOCUMENTO</td>
                    <td width="10%" align="right">FECHA</td>
                    <td width="1%" align="right">MON</td>
                    <td width="10%" align="right">IMPORTE</td>
                    <td width="10%" align="right">TIPO</td>
                    <td width="5%" align="center">SUBDIA</td>
                    <td width="10%" align="right">COMPRO</td>
                </tr>
                <tr><td colspan="9"><hr /></td></tr>
                    <%RS.MOVEFIRST%>
                    <% DO WHILE NOT RS.EOF%>
                    <tr  class="DESCRIPTORnegro" valign="top">
                        
	                    <td align="center"><%=RS("LQ_CNUMLIQ") %></td>
                        <td align="left"><%=TRIM(UCASE(RS("LQ_CCODPRO")))%>&nbsp;-&nbsp; <%=RS("AC_CNOMBRE") %></td>
                        <td align="left"><%=UCASE(RS("DOCUM"))%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATDATETIME(RS("LQ_DFECDOC"),2)%></td>
                        <td align="center"><%=UCASE(RS("LQ_CTIPMON"))%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(RS("IMPORTE"),3,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=RS("LQ_CTIPLIQ")%></td>
                        <td align="right" style="padding-right:10px;"><%=RS("LQ_CSUBDIA")%></td>
                        <td align="right" style="padding-right:10px;"><%=RS("LQ_CCOMPRO")%></td>
                     </tr>
                        <%RS.MOVENEXT%>
                    <%LOOP%>
            </table>
        </td>
    </tr>
    <%END IF%>

    <tr><td colspan="5" style="height:5px;" ><hr /></td></tr>
    <tr><td colspan="5"  class="AMERICAN2" style="vertical-align:bottom">4. SITUACION FINANCIERA :</td></tr>
    <tr><td colspan="5"  style="height:5px;" ><hr /></td></tr>
    <tr>
        <td colspan="5">
            <table width="100%" cellpadding="1" cellspacing="1" border="0" >  
                <tr>
                    <td class="DESCRIPTORnegroizq" width="10%">ORDEN DE COMPRA : </td>       
                    <td class="DESCRIPTORnegroizq" width="60%"><%=OC%> -  <%=PROVEE %></td>       
                    <td class="DESCRIPTORnegroizq" width="10%" style="text-align:right">TIPO : </td>       
                    <td class="DESCRIPTORnegroizq" width="20%" style="text-align:left"><%=TIPORDEN%> </td>       
                </tr> 
                <tr>
                
                    <td class="DESCRIPTORnegroizq" width="10%">ESTADO : </td>       
                    <td class="DESCRIPTORnegroizq" width="60%"><%=ESTADO %></td>       
                    <td class="DESCRIPTORnegroizq" width="10%" style="text-align:right">MONEDA : </td>       
                    <td class="DESCRIPTORnegroizq" width="20%" style="text-align:left"><%=MONEDAS%> </td>       
                </tr> 
            </table>
        </td>
    </tr>
    <tr><td colspan="5" style="height:5px;" ><hr /></td></tr>
    <tr>
        <td colspan="5">
            <table width="100%" cellpadding="1" cellspacing="1" border="0" >
                <tr class="DESCRIPTORnegro" >
                    <td width="20%" align="center">&nbsp;</td>
                    <td width="20%" align="left">VALOR VENTA</td>
                    <td width="20%" align="left">IGV</td>
                    <td width="20%" align="left">TOTAL</td>
                    <td width="20%"  align="center">OBSERVACIONES</td>
                </tr>
                 <tr><td colspan="5" class="DESCRIPTORnegro" style="height:30px; vertical-align:middle"><U>ORDEN DE COMPRA</U></td></tr>
                 <%cad = " Select SUM((OC_NCANORD)*OC_NPREUN2) As ORDEN_VALOR_VENTA,                                                    " & _                                    
                         " SUM((OC_NCANORD)*OC_NPREUNI) As ORDEN_TOTAL,                                                                 " & _
                         " SUM(Case  When OC_NIGV>0 Then (OC_NCANORD)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As ORDEN_IGV,           " & _
                         " SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUN2) As ATEND_VALOR_VENTA,                                                " & _
                         " SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUNI) As ATEND_TOTAL,                                                      " & _
                         " SUM(Case  When OC_NIGV>0 Then (OC_NCANORD-OC_NCANSAL)*OC_NPREUN2*(OC_NIGVPOR/100) Else 0 End) As ATEND_IGV,  " & _     
                         " SUM((OC_NCANSAL)*OC_NPREUN2) As XATEND_VALOR_VENTA,                                                          " & _
                         " SUM((OC_NCANSAL)*OC_NPREUNI) As XATEND_TOTAL,                                                                " & _
                         " SUM(Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As XATEND_IGV           " & _
                         " From RSFACCAR..CO0001MOVD                                                                                    " & _
                         " Where OC_CNUMORD='"&oc&"'                                                                                    " & _
                         " GROUP BY OC_CNUMORD                                                                                          "
        
                RS.CLOSE
                RS.OPEN CAD,CNN
                IF RS.RECORDCOUNT >0 THEN %>       
                
                    <%RS.MOVEFIRST%>
                    
                    <tr  class="DESCRIPTORnegro" valign="top">
                        <td class="DESCRIPTORnegro">ORDENADO</td>   
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_VALOR_VENTA")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_igv")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_total")),2,,,TRUE)%></td>
                        <td class="DESCRIPTORnegro">&nbsp;</td>
                    </tr>
                    <tr  class="DESCRIPTORnegro" valign="top">
                        <td class="DESCRIPTORnegro">ATENDIDO</td>   
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ATEND_VALOR_VENTA")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ATEND_IGV")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ATEND_TOTAL")),2,,,TRUE)%></td>
                        <td class="DESCRIPTORnegro">&nbsp;</td>
                    </tr>
                    <tr  class="DESCRIPTORnegro" valign="top">
                        <td class="DESCRIPTORnegro">POR ATENDER</td>   
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("XATEND_VALOR_VENTA")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("XATEND_IGV")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("XATEND_TOTAL")),2,,,TRUE)%></td>
                        <td class="DESCRIPTORnegro">&nbsp;</td>
                    </tr>

                    
                <%END IF %>
                 <tr><td colspan="5" class="DESCRIPTORnegro" style="height:30px; vertical-align:middle"><U>FACTURADO</U></td></tr>


                 <tr  class="DESCRIPTORnegro" valign="top">
                        <td class="DESCRIPTORnegro">ORDENADO</td>   
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_VALOR_VENTA")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_igv")),2,,,TRUE)%></td>
                        <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN_total")),2,,,TRUE)%></td>
                        <td class="DESCRIPTORnegro">&nbsp;</td>
                 </tr>
                <%  valven  = cdbl(RS("ORDEN_VALOR_VENTA"))
                    igv     = cdbl(RS("ORDEN_igv"))
                    total   = cdbl(RS("ORDEN_total"))
                CAD = " Select Sum(CP_NIMPOMN) As Fact_MN_Total,                          " & _
                      " Sum(CP_NIMPOUS) As Fact_US_Total,Sum (CP_NIGVMN) As Fact_MN_Igv,  " & _
                      " Sum(CP_NIGVUS) As Fact_US_Igv                                     " & _
                      " From RSCONCAR..CP0001CART                                         " & _
                      " Where CP_CTDOCRE='OC' AND CP_CNDOCRE='"&oc&"'                     " & _
                      " Group by CP_CTDOCRE,CP_CNDOCRE                                    "
                RS.CLOSE
                RS.OPEN CAD,CNN
                IF RS.RECORDCOUNT >0 THEN %>       
                    <%RS.MOVEFIRST%>
                    <%IF  UCASE(TRIM(CODMON)) = "US" THEN%>
                        <tr class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">FACTURADO</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_US_Total"))-CDBL(RS("Fact_US_Igv")),2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_US_Igv")),2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_US_Total")),2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                          <% DIF1 = CDBL(RS("Fact_US_Total"))-CDBL(RS("Fact_US_Igv"))
                             DIF2 = CDBL(RS("Fact_US_Igv"))
                             DIF3 = CDBL(RS("Fact_US_Total"))
                          %>
                         </tr>
                    <%ELSE%>
                        <tr  class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">FACTURADO</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_MN_Total"))-CDBL(RS("Fact_MN_Igv")),2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_MN_Igv")),2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("Fact_MN_Total")),2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                        <% DIF1 = CDBL(RS("Fact_MN_Total"))-CDBL(RS("Fact_MN_Igv"))
                           DIF2 = CDBL(RS("Fact_MN_Igv"))
                           DIF3 = CDBL(RS("Fact_MN_Total"))
                          %>
                    <%END IF %>
                <%ELSE
                    DIF1 = 0
                    DIF2 = 0
                    DIF3 = 0%>
                <%end if%>
                <%ATEN = total  - DIF3
                        if aten > 0 then
                            col =  "green"
                        elseif aten = 0 then 
                            col = "navy"
                        else
                            col = "red"
                        end if   %>
                    <tr  class="DESCRIPTORnegro" style="color:'<%=col%>';" valign="top">
                            <td >POR FACTURAR</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(valven - DIF1,2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(igv    - DIF2,2,,,TRUE)%></td>
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(ATEN,2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>

                     <tr><td colspan="5" class="DESCRIPTORnegro" style="height:30px; vertical-align:middle"><U>CUENTA CORRIENTE</U></td></tr>
                        <%CAD = " Select CP_CTIPDOC, SUM(CP_NSALDMN) as SALD_MN,SUM(CP_NSALDUS) as SALD_US  " & _
                                " From RSCONCAR..CP0001CART  Where CP_CTDOCRE='OC' AND CP_CNDOCRE='"&OC&"'  " & _
                                " Group by CP_CTIPDOC                                                       "
                RS.CLOSE
               ' RESPONSE.WRITE(CAD)
                RS.OPEN CAD,CNN
                IF RS.RECORDCOUNT >0 THEN %>       
                    <%RS.MOVEFIRST%>
                    <%IF  UCASE(TRIM(CODMON)) = "US" THEN%>
                        <tr  class="DESCRIPTORnegro" valign="top">
                               <td class="DESCRIPTORnegro">SALDOS DE FATURAS</td>   
                               <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALD_US")),2,,,TRUE)%></td>
                               <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                        <tr class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">ANTICIPOS/NA POR APLICAR</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(0,2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                        <tr class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">SALDO</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALD_US")),2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                    <%ELSE%>
                        <tr  class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">SALDO DE FACTURAS</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALD_MN")),2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                        <tr class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">ANTICIPOS/NA POR APLICAR</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(0,2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                        <tr class="DESCRIPTORnegro" valign="top">
                            <td class="DESCRIPTORnegro">SALDO</td>   
                            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALD_MN")),2,,,TRUE)%></td>
                            <td class="DESCRIPTORnegro">&nbsp;</td>
                        </tr>
                       
                    <%END IF %>
               <%END IF%> 
                <tr><td colspan="5" class="DESCRIPTORnegro" style="height:30px; vertical-align:middle"><U>OTROS</U></td></tr>
                <tr><td colspan ="1"  class="DESCRIPTORnegro" >GIRO ANTICIPOS PENDIENTES</td>
                 <td align="right" class="DESCRIPTORnegro" style="padding-right:10px;"><%=FORMATNUMBER(0,2,,,TRUE)%></td>
                </tr>
            </table>
        </td>
    </tr>
    

    


</table>

</body>
</html>
