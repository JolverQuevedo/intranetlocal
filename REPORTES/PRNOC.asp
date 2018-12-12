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
		
  '   response.Write(det)   
        
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
<title>OC_PRINT</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" class="page">

<table width="100%">
	<tr>
	    <td width="20%" class="AMERICAN2"><%=UCASE(RS("AC_CNOMCIA")) %></td>
		<td width="60%" align="center" class="AMERICAN22"> ORDEN DE COMPRA # <%=OC%></td>
		<td width="20%" class="DESCRIPTORnegroder" align="right"><%=NOW() %></td>
    </tr>
</table>

<table width="100%">
	<tr>
        <table width="100%">
	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Direccion: </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("AC_CDIRCIA")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Telefax: </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("AC_Cfax")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Telefono: </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("AC_Ctelef1")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">RUC : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("AC_Cruc")) %></td>
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
RS.MOVEFIRST%>
<p></p>
<table width="100%">
	<tr>
        <table width="100%">
	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Se&ntilde;ores: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(RS("AC_Cnombre")) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Telefax: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(RS("AC_Cfaxacr")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Ruc: </td>
        <%if rs("ac_ctipoac")= "EX" then xx = "" else xx = rs("ac_ccodigo") %>
        <td class="DESCRIPTORnegroizq"><%=UCASE(xx) %></td>
        <td></td>
        <td></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Atencion: </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("ac_crepres")) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Doc. Referencia: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(RS("oC_Ccotiza")) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Direccion : </td>
        <td class="DESCRIPTORnegroizq"><%=UCASE(RS("AC_Cdirecc")) %></td>
    </tr> 
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Entregar  : </td>
        <td class="DESCRIPTORnegroizq"><b><%=UCASE(nomcia) %></b>&nbsp;-&nbsp;<%=UCASE(RS("oC_Clugent")) %></td>
    </tr> 
</table>

<hr />

<%IF RS("OC_CCODMON") = "US" THEN DESMON = "US $" ELSE DESMON = "S/" %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
<tr class="DESCRIPTORnegro" align="center">
	<td WIDTH="2%">ITEM</td>
    <td WIDTH="8%">CODIGO</td>
    <td width="5%">CANT</td>
    <td width="2%">UNID</td>
    <td width="43%">DESCRIPCION</td>
    <td wodth="10%">PRECIO<br /><%=DESMON%></td>
    <td width="10%">TOTAL<br /><%=DESMON%></td>
    <td width="10%">DCTO<br /><%=DESMON%></td>
    <td width="10%">NETO<br /><%=DESMON%></td>
</tr>
<tr><td colspan="9"><hr />  </td></tr>
<%forpag = rs("oc_cforpa1")
fecent=rs("oc_dfecent")
tipenv = rs("oc_ctipenv")
obs = rs("oc_cdetent")
soli= rs("oc_csolict")
lent = rs("oc_clugent")
lfac=rs("oc_clugfac")







rs.close

RS.OPEN "Select SUM(OC_NIGV) AS IIGV From RSFACCAR..CO0001MOVD Where OC_CNUMORD='"&OC&"' ",CNN
if rs.recordcount <=0 then
    response.Write("SIN DATOS")
    RESPONSE.End
END IF
RS.MOVEFIRST
IGVTOT = RS("IIGV")

RS.CLOSE


rs.open det,cnn
if rs.recordcount <=0 then
    response.Write("SIN DATOS")
    RESPONSE.End
END IF
RS.MOVEFIRST
importe = 0
do while not rs.eof%>
<tr  class="DESCRIPTORnegro" valign="top">
	<td align="center"><%=RS("OC_CITEM") %></td>
    <td align="center"><%=RS("OC_Ccodigo") %></td>
    <td align="center"><%=formatnumber(RS("OC_ncanord"),2,,,true) %></td>
    <td align="center"><%=RS("OC_Cunidad") %></td>
    <td align="left"><%=trim(RS("OC_Cdesref")) %>&nbsp;<br />&nbsp;<%=UCASE(RS("OC_COMENTA")) %></td>
    <td align="center"><%=formatnumber(RS("OC_nPREUN2"),5,,,true) %></td>
    <td align="right"><%=formatnumber(CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")),2,,,true) %></td>
    <%importe = importe + (CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")))-CDBL(RS("OC_nDESCTO")) %>
    <td align="right"><%=formatnumber(RS("OC_nDESCTO"),2,,,true) %></td>
    <td align="right"><%=formatnumber((CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")))-CDBL(RS("OC_nDESCTO")),2,,,true) %></td>
</tr>
    <%RS.MOVENEXT%>
<%loop%>
<tr><td colspan="10"><hr /></td>
</tr>
<tr  class="DESCRIPTORnegro">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left"></td>
    <td align="left" colspan="2">Importe</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber(importe,2,,,true) %></td>
</tr>
<tr  class="DESCRIPTORnegro">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left" ></td>
    <td align="left" colspan="2">IGV</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber(igvtot,2,,,true) %></td>
</tr>
<tr  class="DESCRIPTORnegro">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left"></td>
    <td align="left" colspan="2">Precio de Venta</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber((cdbl(importe) + cdbl(igvtot)),2,,,true) %></td>
</tr>
</table>
<hr /><center>
<span class="american22" >Solo se acepta hasta el 3% adicional, todo excedente ser&aacute; devuelto, considerar esto para no afectar  el curso regular de sus facturas.<br />
“Cada guía de remisión y factura debe hacer referencia a una sola OC, no se aceptan varias OC en una misma guía y factura.”</span>
<hr /></center>
<table width="100%">
	<tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Forma de Pago: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(forpag) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Solicitante: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(soli) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Plazo de Entrega : </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=fecent %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Lugar de Entrega: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(lent) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Tipo de Envio : </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(tipenv) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Lugar de Factura: </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(lfac) %></td>
    </tr>
    <tr align="left">
	    <td class="DESCRIPTORnegroizq" width="10%">Observaci&oacute;n : </td>
        <td class="DESCRIPTORnegroizq" width="40%"><%=UCASE(obs) %></td>
        <td class="DESCRIPTORnegroizq" width="10%">Pais de Origen: </td>
        <td class="DESCRIPTORnegroizq" width="40%"></td>
    </tr>
</table>

<hr />

<table width="100%">
<tr><td colspan="5" style="height:30">&nbsp;</td></tr>
	<tr>
	    <td width="20%" class="AMERICAN2">&nbsp;</td>
        <td width="10%" class="AMERICAN2"><hr /></td>
        <td width="40%" class="AMERICAN2">&nbsp;</td>
        <td width="10%" class="AMERICAN2"><hr /></td>
        <td width="20%" class="AMERICAN2">&nbsp;</td>
    </tr>
    <tr style="text-align:center">
	    <td width="20%" class="AMERICAN2">&nbsp;</td>
        <td width="10%" class="AMERICAN2">GERENTE</td>
        <td width="40%" class="AMERICAN2">&nbsp;</td>
        <td width="10%" class="AMERICAN2">SOLICITANTE</td>
        <td width="20%" class="AMERICAN2">&nbsp;</td>
    </tr>
</table>
</body>
</html>
