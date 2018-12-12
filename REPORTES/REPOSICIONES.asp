<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2058%>
<% tienda = Request.Cookies("tienda")("pos") %>
<% destda = Request.Cookies("tienda")("tda") %>
<!--#include file="../includes/Cnn.inc"-->
<%
CAD =	" select CODIGO, DESCRI, (MINIMO-STOCK) AS CANT " & _
        " from  view_ARTICULOS_tienda                   " & _
        " where stock <  minimo and planilla ='1'       " & _
        " and tienda = '"&TIENDA&"'                     " 
		
RS.OPEN CAD ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Stock OK, no se requiere Reposición")		
	Response.End
end if	
rs.movefirst
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ventas.CSS" />

</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0">

<table width="100%">
	<tr><td  align="center" class="estilo6">Lista de Artículos que requieren reposición tienda: <%=ucase(destda) %></td></tr>
	<tr><td><hr /></td></tr>
</table>

<table id="TABLA" align="center"  cellpadding="0" cellspacing="2" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%cont = 1%>
<tr>
    <td align="center" class="Estilo8">IT</td>
	<td align="center" class="Estilo8">Codigo</td>
    <td align="center" class="Estilo8">Descripcion</td>
    <td align="center" class="Estilo8">Cant.</td>

</tr>
<%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"
	             id="fila<%=Trim(Cstr(cont))%>">
            <td class="Estilo5" align="center"><%=Cont%></td>
	        <td class="Estilo5" align="center"><%=rs("codigo") %></td>
            <td class="Estilo5" align="center"><%=ucase(rs("descri")) %></td>
            <td class="Estilo5" align="center"><%=rs("cant") %></td>
            <%cont =cont +1 %>
        </tr>
        <%rs.movenext %>
    <%loop%>
<%end if %>
</table>
<center>
<form id="reponete" name="reponete" action="../comun/enviarepone.asp" method="post">
    <%if rs.recordcount >0 then %>
        <input type="submit" id="ENV" name="ENV" value="ENVIAR" />
    <%end if %>
</form>
</center>


</body>

</html>
