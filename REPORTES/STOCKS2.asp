<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2058%>
<% tienda = Request.Cookies("tienda")("pos") %>
<% destda = Request.Cookies("tienda")("tda") %>
<!--#include file="../includes/Cnn.inc"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ventas.CSS" />
<%TDA= REQUEST.QueryString("TDA") %>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0">

<%IF LEN(LTRIM(RTRIM(TDA)))=0 THEN %>

        <table id="Table1" align="center"  bordercolor="#FFFFFF"  bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="4"  border="0">
	        <% CAD =   " SELECT * FROM TIENDAS WHERE ESTADO ='A' order by descripcion "
                  '  response.write(cad)
                  '  response.write("<br>")
            RS.OPEN CAD,CNN
            IF rs.recordcount > 0 THEN rs.movefirst%>
    
            <tr valign="middle" >
    	        <td class="Estilo11" valign="middle" align="right" rowspan="2">
                    <label for="Radio">Tiendas:&nbsp;</label></td> 
                <td  class="Estilo12" align="left"  rowspan="2">
                    <select  name="TT" id="TT" onchange="window.location.replace('stocks.asp?tda='+this.value)">
                        <option value = "" selected></option>
                        <%do while not rs.eof %>
                            <option value="<%=TRIM(RS("CODIGO"))%>"><%=TRIM(RS("DESCRIPCION")) %></option>
                            <%rs.movenext %>
                        <%loop %>
                    </select>
                </td>
        </tr>
        </table>
        <%RS.CLOSE %>

<% END IF%>



<%IF LEN(LTRIM(RTRIM(TDA)))>0 THEN %>
<% rs.open "select *  from tiendas where codigo = '"&tda&"'  " , cnn
destda = rs("descripcion")
rs.close%>

<table width="100%">
	<tr><td  align="center" class="estilo6">Listado de Stock Artículos --> tienda: <%=ucase(destda) %></td></tr>
	<tr><td><hr /></td></tr>
</table>


<%
CAD =	" select DISTINCT CODIGO, DESCRI, STOCK, MINIMO  " & _
        " from  view_ARTICULOS_tienda           " & _
        " where tienda = '"&TIENDA&"'           " & _
        " and stock > 0                         " & _
		" order by codigo "	'Fac 20121229
'RESPONSE.WRITE(CAD)
RS.OPEN CAD ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Stock OK, no se requiere Reposición")		
	Response.End
end if	
rs.movefirst
%>
<table id="TABLA" align="center"  cellpadding="2" cellspacing="2" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%cont = 1%>
<tr>
    <td align="center" class="Estilo8">IT</td>
	<td align="center" class="Estilo8">Codigo</td>
    <td align="center" class="Estilo8">Descripcion</td>
    <td align="center" class="Estilo8">Cant.</td>
    <td align="center" class="Estilo8">Min.</td>
</tr>
<%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>" id="fila<%=Trim(Cstr(cont))%>" 
            class="<%if cdbl(rs("stock")) < cdbl(rs("minimo")) then 
                    response.write("Estilo23") 
                 else 
                    response.write("estilo5") 
                 end if %>">
            <td  align="center"><%=Cont%></td>
	        <td  align="center"><%=rs("codigo") %></td>
            <td align="left"><%=ucase(rs("descri")) %></td>
            <td align="center"><%=rs("stock") %></td>
            <td  align="center"><%=rs("minimo") %></td>
            <%cont =cont +1 %>
        </tr>
        <%rs.movenext %>
    <%loop%>
<%end if %>
</table>
<%end if %>
</body>

</html>
