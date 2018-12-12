<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.Buffer = true %>
<%Session.LCID=2057%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<LINK REL="stylesheet" TYPE="text/css" HREF="../estilos1.CSS">
<!--#include file="../comun/funcionescomunes.asp"-->
<!--#include file="../includes/funcionesVBscript.asp"-->
<!--#include file="../includes/cnn.inc"-->



<%cli = trim(request.QueryString("cli")  )
fec   = trim(request.QueryString("fec") )
gtex  = trim(request.QueryString("gte") )
est   = trim(request.QueryString("est")  )
poo   = trim(request.QueryString("poo")  )
tem   = trim(request.QueryString("tem")  )


cad =   " SET DATEFORMAT DMY;                   " & _
        " select * FROM VIEW_PROGRAMA_DESPACHOS "
if len(cli+fec+GTEX+est+poo+tem)=0 then cad = cad + " where estcli= ''" else cad = cad + " where estado = 'a' "
if len(cli) > 0 then cad = cad + " and cli = '"&cli&"' "
if len(est) > 0 then cad = cad + " and estcli = '"&est&"' "
if len(poo) > 0 then cad = cad + " and po = '"&poo&"' "
if len(tem) > 0 then cad = cad + " and codtem = '"&tem&"' "
if len(gtex) > 0 then cad = cad + " and replace(faBRIC, ' ' , '') like '%"&GTEX&"%' "
if len(FEC) > 0 then cad = cad + " and CONVERT(SMALLDATETIME, LLEGAPO, 103)  = CONVERT(SMALLDATETIME,'"&FEC&"',103) "

'RESPONSE.WRITE (CAD)
'RESPONSE.END


rs.open cad,cnn
if rs.recordcount <=0 then RESPONSE.End
COLUMNAS= RS.FIELDS.COUNT - 6

IF  request.QueryString("EXCEL") = "1" THEN
  archivo = "c:\temp\despacho.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
END IF

%>

<body >

<center>
<table id="TABLA" align="CENTER" cols="2" width="100%"	 cellpadding="2"  cellspacing="1" bordercolor="White"	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" valign="top">
    <%for I=0 to columnas%>
	    <td align="center">
		    <font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font>
	    </td>
    <%next%>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
	<tr <% IF CONT mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("barra"))%>' <%end IF%>	valign="top" >
	    <td class="DATOSnormal" align="right"><%=formatnumber(rs("house_packing"),2,,,true)%></td>
	    <td class="DATOSnormal" align="center"><%=ucase(rs("estcli"))%></td>
        <td class="DATOSnormal" align="left"><%=ucase(rs("desestilo"))%></td>
        <td class="DATOSnormal" align="center"><%=ucase(rs("po"))%></td>
        <td class="DATOSnormal" align="center"><%=ucase(rs("ofi"))%></td>
        <td class="DATOSnormal" align="right"><%=formatnumber(rs("can"),0,,,true)%></td>
        <td class="DATOSnormal" align="right"><%=formatnumber(rs("fob"),2,,,true)%></td>
        <td class="DATOSnormal" align="right"><%=formatnumber(rs("big"),2,,,true)%></td>
        <td class="DATOSnormal" align="right"><%=formatnumber(rs("xbig"),2,,,true)%></td>
        <td class="DATOSnormal" align="right"><%=formatnumber(rs("total"),2,,,true)%></td>
        <td class="DATOSnormal" align="left"><%=ucase(rs("fabric"))%></td>
        <td class="DATOSnormal" align="center"><%=formatdatetime(rs("llegapo"),2)%></td>
        <td class="DATOSnormal" align="center"><%=formatdatetime(rs("emb"),2)%></td>
        <td class="DATOSnormal" align="center"><%=ucase(rs("tipemb"))%></td>
        <td class="DATOSnormal" align="center"><%=ucase(rs("tienda"))%></td>
        <td class="DATOSnormal" align="left"><%=ucase(rs("obs"))%></td>
        <td class="DATOSnormal" align="center"><%=ucase(rs("cli"))%></td>
        <td class="DATOSnormal" align="left"><%=ucase(rs("nom"))%></td>
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<p>&nbsp;</p>

</html>
