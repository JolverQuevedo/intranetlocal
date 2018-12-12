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
alm = Request.QueryString("alm")
num = Request.QueryString("num")  
TIP = Request.QueryString("TIP")  
' DATOS DE CABECERA DEL MODELADOR
cia =   "Select * From RSFACCAR..ALCIAS Where AC_CCIA='0001' ; "
' CABECERA DE LA ORDEN DE COMPRA
cab =	"Select A1_CDESCRI,TM_CDESCRI, *    " & _
        " From RSFACCAR..AL0001MOVC         " & _
        " inner join RSFACCAR..AL0001ALMA   " & _
        " on A1_CALMA = c5_calma            " & _
        " inner join RSFACCAR..AL0001TABM   " & _
        " on TM_CTIPMOV=c5_ctipmov          " & _
        " AND TM_CCODMOV=c5_ccodmov         " & _
        " Where C5_CALMA='"&alm&"'          " & _
        " AND C5_CTD='"&tip&"'              " & _
        " AND C5_CNUMDOC='"&NUM&"';         "
                
' LINEAS DE DETALLE
det =   " Select AR_CUNIDAD, AR_CFSERIE , * " & _
        " From RSFACCAR..AL0001MOVD         " & _
        " inner join RSFACCAR..AL0001ARTI   " & _
        " on C6_CCODIGO= AR_CCODIGO         " & _
        " Where C6_CALMA='"&ALM&"'          " & _
        " AND C6_CTD='"&TIP&"'              " & _
        " AND C6_CNUMDOC='"&num&"'          " & _
        " ORDER BY C6_CITEM " 
		
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
<title>PRINT_doc</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" class="page">

<table width="100%">
	<tr>
	    <td width="20%" class="AMERICAN2"><%=UCASE(RS("AC_CNOMCIA")) %></td>
		<td width="60%" align="center" class="AMERICAN22"> NOTA DE INGRESO # <%=num%></td>
		<td width="20%" class="DESCRIPTORnegroder" align="right"><%=formatdatetime(NOW(),2) %></td>
    </tr>
</table>
<p></p>
<%
nomcia = rs("ac_cnomcia")
RS.CLOSE
RS.OPEN CAB,CNN
IF RS.RECORDCOUNT <=0 THEN
RESPONSE.WRITE("SIN DATOS de empresa....")
RESPONSE.End
END IF
RS.MOVEFIRST%>
<table width="100%">
	<tr>
        <td>
        <table width="100%" border="0" cellpadding="2" cellspacing="0">
	        <tr align="left">
	            <td class="reportBWbold" width="20%">Almac&eacute;n : </td>
                <td class="reportBW" width="5%"><%=UCASE(RS("c5_calma")) %></td>
                <td class="reportBW" width="40%"><%=UCASE(RS("A1_CDESCRI")) %></td>
                <td class="reportBWbold" align="right" width="10%">Fecha Documento : </td>
                <td align="left" class="reportBW" width="25%"><%=formatdatetime(RS("C5_dfecdoc"),2)%></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">N&deg; Doc. Referencia : </td>
                <td align="left" class="reportBW" colspan="3"><%=UCASE(trim(RS("C5_CRFTDOC")))%> - <%=UCASE(trim(RS("C5_CRFNDOC")))%></td>
                <td></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">N&deg; Doc. Referencia 2 : </td>
                <td align="left" class="reportBW" colspan="3"><%=UCASE(trim(RS("C5_CRFTDO2")))%> - <%=UCASE(trim(RS("C5_CRFNDO2")))%></td>
                <td ></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">N&deg; Orden de Compra : </td>
                <td align="center" class="reportBW"><%=UCASE(trim(RS("C5_Cnumord")))%></td>
                <td class="reportBWbold" align="right" colspan="2">Moneda de Compra : </td>
                <td align="left" class="reportBW"><%=UCASE(trim(RS("C5_Ccodmon")))%></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">Proveedor : </td>
                <td align="left" class="reportBW" colspan="3"><%=UCASE(trim(RS("C5_Ccodpro")))%> - 
                <%=UCASE(trim(RS("C5_Cnompro")))%></td>
                <td width="40%"></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">N&deg; RUC : </td>
                <td align="center" class="reportBW"><%=UCASE(trim(RS("C5_Ccodpro")))%></td>
                <td align="left" class="reportBW">&nbsp;</td>
                <td width="40%"></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">Codigo Movimiento : </td>
                <td align="left" class="reportBW" colspan="3"><%=UCASE(trim(RS("C5_Ccodmov")))%> - <%=UCASE(trim(RS("tm_cdescri")))%></td>
                <td width="40%"></td>
            </tr>
            <tr align="left">
                <td class="reportBWbold">Glosa : </td>              
                <td align="left" colspan="3" class="reportBW"><%=UCASE(trim(RS("C5_Cglosa1")))%></td>
                
                
            </tr>
        </table>
    </td>
    </tr> 
</table>

<hr />


<table width="100%" cellpadding="1" cellspacing="1" border="0" >
    <tr class="reportBWbold" align="center">
	    <td WIDTH="2%">ITM</td>
        <td WIDTH="8%">CODIGO</td>
        <td width="43%">DESCRIPCION</td>
        <td width="2%">UNID</td>
        <td width="5%">CANTIDAD <br />RECIBIDA</td>
        <td wodth="10%">PRECIO<br />UNITARIO</td>
        <td width="10%">PRECIO<br />COSTO</td>
        <td width="10%">IMPORTE<br />TOTAL</td>
    </tr>
    <tr><td colspan="8"><hr />  </td></tr>
<%
codmon = rs("c5_ccodmon")
rs.close

RS.OPEN det,CNN
'response.write(det)
if rs.recordcount <=0 then
    response.Write("SIN DATOS")
    RESPONSE.End
END IF
RS.MOVEFIRST
can = 0
tot = 0
do while not rs.eof%>
<tr  class="DESCRIPTORnegro" valign="top">
	<td align="center"><%=RS("c6_CITEM") %></td>
    <td align="center"><%=RS("c6_Ccodigo") %></td>
    <td align="left"><%=ucase(RS("AR_cdescri"))%></td>
    <td align="center"><%=ucase(RS("ar_cunidad"))%></td>
    <td align="right"><%=formatnumber(cdbl(RS("c6_ncantid")),3,,,true) %></td>
    <%can = can + cdbl(rs("c6_ncantid"))
     if can = "MN" then unit = RS("c6_nmnprun") else unit = rs("c6_nusprun")
        tot = tot + (CDBL(unit) * CDBL(RS("c6_ncantid")))%>
    <td align="center"><%=formatnumber(unit,5,,,true) %></td>
    <td align="center"><%=formatnumber(unit,5,,,true) %></td>
    <td align="right"><%=formatnumber(CDBL(unit)*CDBL(RS("c6_ncantid")),2,,,true) %></td>
    
</tr>
    <%RS.MOVENEXT%>
<%loop%>
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="4">&nbsp;</td>
    <td><hr></td>
</tr>
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="5"><%=formatnumber(can,3,,,true) %></td>
</tr>
<tr><td colspan="8"><HR></td></tr>
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="7">TOTAL</td>
    
    <td align="right"><%=formatnumber(tot,2,,,true) %></td>
</tr>


</table>

</body>
</html>
