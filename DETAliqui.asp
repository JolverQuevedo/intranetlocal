<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script type="text/jscript" language="jscript">
    var aCod = Array()
    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('deta').contentWindow.
      document.body.scrollHeight +250;
        //change the height of the iframe
        document.getElementById('deta').height =
      the_height;
    }
</script>
<%oc = Request.QueryString("oc")
ruc = Request.QueryString("ruc")  %>
<body style="margin-top:0; onload="document.getElementById('OC').focus();">

<form id="thisForm" method="post" name="thisForm" action="">

<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">RESUMEN: </td></tr>
</table> 

<table cellpadding="5" cellspacing="0" border="1" align="center" >
    <tr valign="middle" align="center">
        <td class="DESCRIPTORnegro" style="text-align:center">Moneda</td>
        <td class="DESCRIPTORnegro" style="text-align:center">Total <br />OC </td>
        <td class="DESCRIPTORnegro" style="text-align:center">Total <br /> documentos</td>
        <td class="DESCRIPTORnegro" style="text-align:center" id="tit">Total <br /> SISPAG</td>
    </tr>
    <tr>
        <td class="DESCRIPTORnegro"><input id="mone" name="mone" class="isa_info" style="text-align:center;padding-right:10px;"/> </td>
        <td class="DESCRIPTORnegro"><input id="val0" name="val0" class="isa_info" style="text-align:right;padding-right:10px;"/> </td>
        <td class="DESCRIPTORnegro"><input id="val1" name="val1" class="isa_info" style="text-align:right;padding-right:10px;"/> </td>
        <td class="DESCRIPTORnegro"><input id="val2" name="val2" class="isa_info" style="text-align:right;padding-right:10px;"/> </td>
    </tr>
</table> 



<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Detalle de OC : </td></tr>
</table> 
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
        <%
        CAD =   " Select OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDENADO, " & _       
                " ISNULL((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A                              " & _
                " inner join RSFACCAR..al0001movd AS B                                                       " & _
	            "     on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                 " & _
	            "     where C5_CNUMord='"&OC&"'   AND C6_Ccodigo = CC.OC_Ccodigo and oc_citem = c6_citemoc   " & _
                " and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'E'),0) As ENTRA,                           " & _
                " ISNULL((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A                              " & _
                " inner join RSFACCAR..al0001movd AS B                                                       " & _
	            "     on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                 " & _
	            "     where C5_CNUMord='"&OC&"'   AND C6_Ccodigo = CC.OC_Ccodigo and oc_citem = c6_citemoc   " & _
                " and left(c6_ccodigo,1) <> 'S' AND C5_CTIPMOV = 'S'),0) As SALE ,OC_NPREUN2 as OC_NPREUNI                " & _
                " From RSFACCAR..CO0001MOVD  AS CC                                                           " & _
                " Where OC_CNUMORD='"&OC&"'  AND OC_CCODPRO='"&RUC&"' AND OC_NCANORD > 0                     " & _
                " ORDER BY OC_CITEM   ;                                                                      " 
     '    response.write(cad)

        RS.OPEN CAD, CNN
        IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST%>
        <%cnt = 0 %>
        <%tot0=0 %>
        <%do while not rs.eof %>
            <%atendido = CDBL(RS("ENTRA"))-CDBL(RS("sale"))%>
            <%pendiente  = (CDBL(RS("ORDENADO"))-CDBL(RS("ENTRA"))+CDBL(RS("sale"))) *-1%>
            <%ATEN = ROUND((PENDIENTE * 100 ) / CDBL(RS("ORDENADO")),0)
            att = (PENDIENTE * 100 ) / CDBL(RS("ORDENADO"))
                if att > 0 then
                    col =  "green"
                elseif cdbl(att) = 0 then 
                    col = "navy"
                else
                    col = "#f00"
                end if   %>
                    
            <tr  class="DESCRIPTORnegro" id="l<%=cnt%>" valign="top">
                        
	            <td align="center"><%=RS("COD") %></td>
                <td align="left"><%=UCASE(RS("DESCRI"))%></td>
                <td align="center"><%=UCASE(RS("UNI"))%></td>
                <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDENADO")),4,,,TRUE)%></td>
                <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(ATENDIDO,4,,,TRUE)%></td>
                <%tot0 = tot0 + (CDBL(RS("ORDENADO"))*cdbl(rs("oc_npreuni"))) %>
                <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(pendiente,4,,,TRUE)%></td>
                <td align="right" style="padding-right:10px;"><%=ATEN%> %</td>
                </tr>
                <script language="jscript" type="text/jscript">
                    document.getElementById('l' + '<%=trim(cnt)%>').style.color = '<%=col%>'
                </script>
                <%RS.MOVENEXT%>
                <%IF RS.EOF THEN EXIT DO %>
                <%cnt = cnt +1 %>
            <%loop%>
             <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("barra"))%>' style="padding-right:10px;">
                            <td colspan ="2" align="right" style="padding-right:10px;">Total segun OC</td>
                            <td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot0,2,,,TRUE)%></b></td><td colspan="4">&nbsp;</td>
                        </tr>
            </tr>
    </table>

    <table align="center" cellpadding="1" cellspacing="4" border="0" >
        <tr  class="DESCRIPTORnegro" ><td style="background-color:Red" width="20px">&nbsp;</td>
          <td>Atendido Parcial</td>
        <td style="background-color:green" width="20px">&nbsp;</td>
          <td>Atendido en Exceso</td>
        <td style="background-color:navy" width="20px">&nbsp;</td>
          <td>Atendido Exacto</td>
        </tr>
        
    </table>


    <%
     CAD =      " Select a.c5_calma as alm, OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDEN,                    " & _
                " OC_NPREUN2 AS UNI_OC, (OC_NCANORD*OC_NPREUN2) AS TOT_OC,  C5_CCODMOV,                                                         " & _
                " CANTI = case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END,                                      " & _
                " ltrim(rtrim(c6_ctd)) + ' - '+ ltrim(rtrim(c6_cnumdoc)) as DOC, (C6_NPREUNi) AS UNI_PE,                                        " & _
                " (C6_NPREUNi) * case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END AS TOT_PE,                     " & _
                " CONVERT(VARCHAR, C5_DFECDOC, 103) AS FECHA, a.C5_CCODMON,                                                                     " & _
                " (OC_NCANORD*OC_NPREUN2)-(C6_NPREUNI* case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID*-1 END) AS SALDO " & _
                " From RSFACCAR..CO0001MOVD AS CC                                                                                               " & _
                "  inner join  RSFACCAR..al0001movc AS A  on OC_CNUMORD = c5_cnumord                                                            " & _
                " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                   " & _
                " and OC_CITEM = C6_CITEMOC                                                                                                     " & _
                " Where OC_CNUMORD='"&OC&"' AND OC_CCODPRO='"&RUC&"' AND OC_NCANORD > 0                                                         " & _
                " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                                                                              " 
                rs.close
             '   response.write(cad)
                rs.open cad,cnn
    
     %>
<p></p>
<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Documentos de Almacen : </td></tr>
</table> 
<p></p>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
        <tr class="DESCRIPTORnegro" >
            <td width="8%" align="center">ALM</td>
            <td width="8%" align="center">CODIGO</td>
            <td width="30%" align="left">DESCRIPCION</td>
            <td width="1%"  align="center">UNI</td>
            <td width="8%"  align="center">ORDENADO</td>

            <td width="8%"  align="center">UNIT OC</td>
            <td width="10%"  align="center">TOT OC</td>
            <td width="10%" align="right">MOV</td>
            <td width="10%" align="right">DOC</td>
            <td width="8%" align="right">CANT</td>
            <td width="8%" align="right">UNIT DOC</td>
            <td width="8%"  align="center">TOT DOC</td>
            <td width="8%" align="center">FECHA</td>
            <td width="8%"  align="center">SALDO</td>
        </tr>
        <tr><td colspan="14"><hr /></td></tr>
        <% IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST%>
        <%cnt = 0 %>
        <%tot1=0 %>
        <%mone= rs("c5_ccodmon") %>
        <%do while not rs.eof%>
         <tr  class="DESCRIPTORnegro" id="Tr1" valign="top"  <% IF cnt mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>>
            <td align="center"><%=RS("alm") %></td>
            <td align="center"><%=RS("COD") %></td>
            <td align="left"><%=UCASE(RS("DESCRI"))%></td>
            <td align="center"><%=UCASE(RS("UNI"))%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN")),4,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_oc")),2,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_oc")),2,,,TRUE)%></td>
             <td align="center"><%=UCASE(RS("C5_CCODMOV"))%></td>
             <td align="center"><%=UCASE(RS("doc"))%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("canti")),4,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_pe")),2,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_pe")),2,,,TRUE)%></td>
            <%tot1 = tot1 + CDBL(RS("tot_pe") )%>
            <td align="right" style="padding-right:10px;"><%=FORMATdatetime((RS("fecha")),2)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("saldo")),2,,,TRUE)%></td>
            </tr>
            <%rs.movenext%>
            <%cnt = cnt + 1%>
        <%loop %>
        <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("barra"))%>' style="padding-right:10px;">
            <td colspan ="11"  align="right" style="padding-right:10px;">Total segun documentos</td><td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot1,2,,,TRUE)%></b></td><td colspan="2">&nbsp;</td>
        </tr>
        </table>
        <%CAD = " SELECT CP_CTIPDOC+ ' ' + CP_CNUMDOC AS doc,                                   " & _
                " RTRIM(A.CP_CCODIGO) + ' ' + ltrim(rtrim(B.AC_CNOMBRE)) AS PROVEE,             " & _
                " CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NIMPOMN - a.cp_nigvmn ELSE A.CP_NIMPOUS- a.cp_nigvus  END IMPORTE,  " & _
                " CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NSALDMN ELSE A.CP_NSALDUS END SALDO,    " & _ 
                " CP_CTIPDOC, CP_CNUMDOC, CP_DFECDOC, CP_DFECVEN, CP_CCODMON, CP_CSUBDIA,       " & _
                " CP_CCOMPRO,CP_CFECCOM, cp_cdebhab as topo                                     " & _
                " FROM RSCONCAR..CP0001CART AS A                                                " & _
                " LEFT JOIN RSCONCAR..CP0001MAES AS B ON A.CP_CVANEXO=B.AC_CVANEXO              " & _
                " AND A.CP_CCODIGO=B.AC_CCODIGO                                                 " & _
                " WHERE A.CP_CTDOCRE='OC'   AND A.CP_CNDOCRE='"&OC&"' ORDER BY PROVEE    "
             '    RESPONSE.WRITE(CAD)
               RS.CLOSE
               RS.OPEN CAD, CNN
                IF RS.RECORDCOUNT >0 THEN 
                RS.MOVEFIRST%>
                   <p></p>

    

<table cellpadding="5" cellspacing="0" border="1" style="width:100%;" align="center" id="pagcab">
    <tr><td class="tituloGRANDEorange" style="text-align:left">Detalle SISPAG : </td></tr>
</table> 
<p></p>
<table width="100%" cellpadding="1" cellspacing="1" border="0" id="pagdet" >
                 
                 <tr><td colspan="5">
        
                 <table width="100%" cellpadding="1" cellspacing="1" border="0" >
                        <tr class="DESCRIPTORnegro" >
                            <td width="40%" align="center">PROVEEDOR</td>
                            <td width="10%" align="left">TD DOCUMENTO</td>
                            <td width="9%"  align="right">EMISION</td>
                            <td width="8%" align="center">VMTO</td>
                            <td width="3%" align="center">MON</td>
                            <td width="9%" align="right">IMPORTE</td>
                            <td width="9%" align="right">SALDO</td>
                            <td width="4%" align="right">&nbsp;</td>
                        </tr>
                        <tr><td colspan="7"><hr /></td></tr>
                        <%tot2 = 0 %>
                        <%do while not rs.eof %>
                            <tr  class="DESCRIPTORnegro" valign="top">
                        
	                            <td align="center"><%=UCASE(RS("PROVEE"))%></td>
                                <td align="center"><%=UCASE(RS("DOC"))%></td>
                                <td align="right"><%=FORMATDATETIME(RS("CP_DFECDOC"),2)%></td>
                                <td align="right"><%=FORMATDATETIME(RS("CP_DFECVEN"),2)%></td>
                                <td align="center"><%=UCASE(RS("CP_CCODMON"))%></td>
                                <%if ucase(rs("topo")) = "D" then 
                                    importe = cdbl(rs("importe"))*(-1 )
                                  else 
                                    importe = cdbl(rs("importe"))
                                  end if%>

                                <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(IMPORTE,2,,,TRUE)%> </td>
                                <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("SALDO")),3,,,TRUE)%></td>
                                <td align="right">&nbsp;</td>
                                <%tot2 = tot2 + IMPORTE%>
                             </tr>
                                <%RS.MOVENEXT%>
                                <%IF RS.EOF THEN EXIT DO %>
                         <%loop%>
                         <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("barra"))%>' style="padding-right:10px;">
                            <td colspan ="5" align="right" style="padding-right:10px;">Total segun Facturas</td>
                            <td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot2,2,,,TRUE)%></b></td><td colspan="2">&nbsp;</td>
                        </tr>
                    </table>
                </td>   
            </tr>
           
            <%END IF%>

    <%cad = " Select LQ_CNUMLIQ, LQ_CNUMORD, LQ_CCODPRO, LQ_CTIPLIQ, LQ_CTIPDOC + ' ' + LQ_CNUMDOC AS DOCUM,    " & _
            " LQ_DFECDOC, OC_CCODMON AS LQ_CTIPMON , CASE OC_CCODMON WHEN 'MN' THEN  LQ_NIMPMN ELSE LQ_NIMPUS END AS IMPORTE,  " & _
            " LQ_CSUBDIA, LQ_CCOMPRO, AC_CNOMBRE                                                                " & _
            " From RSFACCAR..AL0001IMPD  Left Join RSCONCAR..CP0001MAES On LQ_CCODPRO=AC_CCODIGO                " & _
            "INNER JOIN RSFACCAR..CO0001MOVC ON OC_CNUMORD = LQ_CNUMORD                                         " & _
            " Where LQ_CNUMORD='"&oc&"' AND AC_CVANEXO = 'P'  Order By LQ_CNUMORD                               "
    'RESPONSE.WRITE(CAD)    
    RS.CLOSE
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT >0 THEN %>       
      <p></p>
<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Documentos IMPORTACION : </td></tr>
</table> 
<p></p>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
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
                    <%tot3 = 0 %>
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
                        <%tot3 = tot3 + cdbl(RS("IMPORTE"))%>
                        <%RS.MOVENEXT%>
                    <%LOOP%>
                     <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("barra"))%>' style="padding-right:10px;">
                            <td colspan ="5" align="right" style="padding-right:10px;">Total segun Documentos Importacion</td>
                            <td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot3,2,,,TRUE)%></b></td><td colspan="2">&nbsp;</td>
                        </tr>
            </table>
        </td>
    </tr>
    <%END IF%>


</table>

<%=msg %>
</form>  
<script language="jscript" type="text/jscript">
tot0 = parseFloat('<%=round(TOT0,2)%>')
tot1 = parseFloat('<%=round(TOT1,2)%>')
tot2 = parseFloat('<%=round(TOT2,2)%>')
tot3 = parseFloat('<%=round(TOT3,2)%>')
sit = trim(parent.window.document.all.sit.value)

if (sit == '5') {
    if (tot1 < tot2) {
        msg = "OJO : Se ha facturado MAS de lo Recibido"
        parent.window.document.all.divi4.style.display = 'block'
        parent.window.document.all.MSG4.style.display = 'block'
        parent.window.document.all.OK.style.display = 'none'
        parent.window.document.all.MSG4.value = msg
    }
    else if (tot1 = tot2) {
        msg = "Ingresos = Facturas"
        parent.window.document.all.divi2.style.display = 'block'
        parent.window.document.all.MSG2.style.display = 'block'
        parent.window.document.all.MSG2.value = msg
    }
    else if (trim(parent.window.document.all.tip.value) != 'I' && tot3 > 0) {
        /*






        */
        parent.window.document.all.OK.style.display = 'block'
    }




    else if (trim(parent.window.document.all.tip.value) == 'I' && tot3 > 0) {
        document.all.tit.innerHTML = 'Total' + '<br>' + 'Importacion'
        parent.window.document.all.OK.style.display = 'block'
    }
    else if (trim(parent.window.document.all.tip.value) == 'I' && tot3 <= 0) {
        document.all.tit.innerHTML = 'Total' + '<br>' + 'Importacion'
        msg = "Falta Liquidar la Importacion"
        parent.window.document.all.divi3.style.display = 'block'
        parent.window.document.all.MSG3.style.display = 'block'
        parent.window.document.all.OK.style.display = 'none'
        parent.window.document.all.MSG3.value = msg


    }
    else {
        msg = "Faltan recibir facturas"
        parent.window.document.all.divi3.style.display = 'block'
        parent.window.document.all.MSG3.style.display = 'block'
        parent.window.document.all.OK.style.display = 'none'
        parent.window.document.all.MSG3.value = msg
    }
}
else {

    parent.window.document.all.divi1.style.display = 'block'
    parent.window.document.all.MSG1.style.display = 'block'
    parent.window.document.all.OK.style.display = 'none'
    parent.window.document.all.MSG1.value = 'Situacion: RECEPCION PARCIAL'

}   

if (trim(parent.window.document.all.sit.value) == '6') {
    parent.window.document.all.divi1.style.display = 'none'
    parent.window.document.all.divi2.style.display = 'none'
    parent.window.document.all.divi3.style.display = 'none'
    parent.window.document.all.divi4.style.display = 'none'
    parent.window.document.all.OK.style.display = 'none'
    parent.window.document.all.tit.innerText = 'O/C LIQUIDADA'

}

if (trim(parent.window.document.all.sit.value) == '5')
    parent.window.document.all.tit.innerText = 'O/C FINALIZADA'
if (trim(parent.window.document.all.sit.value) == '4')
    parent.window.document.all.tit.innerText = 'O/C RECEPCION PARCIAL'

document.all.val0.value = '<%=formatnumber(tot0,2,,,true)%>'  // Orden de compra
document.all.val1.value = '<%=formatnumber(tot1,2,,,true)%>'  // documentos almacen
document.all.val2.value = '<%=formatnumber(tot2,2,,,true)%>'  // sispag
document.all.mone.value = '<%=mone%>'
if (trim(parent.window.document.all.tip.value) == 'I') {
    document.all.val2.value = '<%=formatnumber(tot3,2,,,true)%>'
    parent.document.all.fob.value = tot0
    parent.document.all.cif.value = tot3
    parent.document.all.fac.value = tot3/tot0
}
else if (trim(parent.window.document.all.tip.value) == 'S') {

    document.all.val2.value = '<%=formatnumber(tot2,2,,,true)%>'
    parent.document.all.fob.value = tot1
    parent.document.all.cif.value = tot2
    parent.document.all.fac.value = tot2 / tot1
}

function graba() {
    return true
  
}

</script>
</body>
</html>
