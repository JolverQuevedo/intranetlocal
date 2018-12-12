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
cct = Request.QueryString("cct")

' LINEAS DE DETALLE
cad =   " EXEC SP_PRN_ASIGNA '"&cct&"'                                              " 
		
  '  response.Write(caD)   
        
        RS.OPEN CAD,Cnn
		
If rs.eof or rs.bof then
    Response.Write("<center>")
    Response.Write("<font color=red size=12>")
	Response.Write("No tenemos OFI's asignadas a esta partida")		
	Response.End
end if	
rs.movefirst
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PRINT_ASIGNACION_DE_PARTIDA</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" class="page">

<table width="100%">
	<tr>
	    <td width="20%" class="AMERICAN2">EL MODELADOR S.A.</td>
		<td width="60%" align="center" class="AMERICAN22"> ASIGNACION DE PARTIDA # <%=RS("PAR")%></td>
		<td width="20%" class="DESCRIPTORnegroder" align="right"><%=formatdatetime(NOW(),2) %></td>
    </tr>
    <tr>
	    <td width="20%" class="AMERICAN2"></td>
		<td width="60%" align="center" class="AMERICAN22"> Ficha CCT# <%=RS("CCT")%></td>
		<td width="20%" class="DESCRIPTORnegroder" align="right"></td>
    </tr>
</table>
<p></p>

<table width="100%">
	<tr>
        <td>
        <table width="100%" border="0" cellpadding="2" cellspacing="0">
	        <tr align="left">
	            <td class="reportBWbold" width="20%">Cliente : </td>
                <td class="reportBW" width="5%"><%=UCASE(RS("cli")) %></td>
                <td class="reportBW" width="30%"><%=UCASE(RS("descli")) %></td>
                <td class="reportBWbold" align="right" width="10%">Proveedor : </td>
                <td align="left" class="reportBW" width="35%"><%=rs("ruc")%>-<%=ucase(RS("provee"))%></td>
            </tr>
            <tr align="left">
	            <td class="reportBWbold">Art&iacute;culo : </td>
                <td align="left" class="reportBW" colspan="4"><%=UCASE(trim(RS("TEL")))%> - <%=UCASE(trim(RS("destela")))%></td>
            </tr>
             <tr align="left">
	            <td class="reportBWbold">Total Partida : </td>
                <td align="left" class="reportBW" colspan="4"><%=formatnumber(CDBL(RS("KGPARTI")),3,,,true) %>&nbsp; kgs.</td>
            </tr>
        </table>
    </td>
    </tr> 
</table>

<hr />


<table width="100%" cellpadding="2" cellspacing="2" border="0" >
    <tr class="reportBWbold" align="center">
	    <td width="5%">&nbsp; </td>
        <td width="5%">OFI</td>
        <td width="10%">PO</td>
        <td width="40%" colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;COMBO</td>
        <td width="10%" align="right">KGS</td>
        <td width="10%"  align="right">PDS</td>
        <td width="10%"  align="right">SALDO<br />PARTIDA</td>
        <td width="5%">&nbsp; </td>
    </tr>
    <tr><td colspan="9"><hr />  </td></tr>
    
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="7">&nbsp;</td>
    <td align="right"><%=formatnumber(CDBL(RS("kgparti")),3,,,true) %></td>
</tr>
<%
can = 0
tot = 0
saldo = cdbl(rs("kgparti"))'+cdbl(RS("KGOFI"))

do while not rs.eof%>
<tr  class="DESCRIPTORnegro" valign="top">
<td width="5%"> </td>
	<td align="center"><%=RS("OFI") %></td>
    <td align="center"><%=RS("PO") %></td>
    <td align="center"><%=RS("UBI") %></td>
    <td align="left"><%=RS("COLOR") %></td>
    <td align="right"><%=formatnumber(cdbl(RS("KGOFI")),3,,,true) %></td>
    <td align="right"><%=formatnumber(CDBL(RS("PRENDAS")),0,,,true) %></td>
    <td align="right"><%=formatnumber(saldo - CDBL(RS("kgofi")),3,,,true) %></td>
    <td width="5%"> </td>
    <%saldo = saldo - CDBL(RS("kgofi")) 
    tot = tot + cdbl(RS("KGOFI"))%>
</tr>
    <%RS.MOVENEXT%>
<%loop%>
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="5">&nbsp;</td>
    <td><hr /></td>
</tr>
  
<tr  class="DESCRIPTORnegro">
    <td align="right" colspan="5">Asignado</td>
    <td align="right"><%=formatnumber(CDBL(tot),3,,,true) %></td>
     <td align="left" colspan="4">&nbsp; Kgs.</td>
</tr>
</table>

</body>
</html>
