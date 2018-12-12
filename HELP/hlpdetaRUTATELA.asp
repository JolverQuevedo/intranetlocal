<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />
<head>
<title></title>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">

<table width="100%"  border="1" cellspacing="1" cellpadding="2" bgcolor="<%=application("titulo") %>">
<tr><td class="AMERICANwhite"> SECUENCIA DE PROCESOS:</td></tr>
</table>
<table width="100%"  border="1" cellspacing="1" cellpadding="2"	bordercolor="<%=application("color1") %>">
<tr bgcolor='<%=application("barra")%>'>
		<td width="3%" class="AMERICANnavy">ITEM</td>
		<td width="4%" class="AMERICANnavy">CODIGO</td>
		<td width="35%" class="AMERICANnavy">SERVICIO</td>
		<td width="7%" class="AMERICANnavy">% M</td>
		<td width="45%" class="AMERICANnavy">PROVEEDOR</td>
  </tr>
<%TEL = Request.QueryString("pos")
rut = Request.QueryString("rut")
  cad = " SELECT tela, servicio AS codigo,	merma, 	        " & _
		" opc, DESCRIPCION FROM TELARUTADETA	            " & _
		" INNER JOIN SERVICIOS ON SERVICIO = CODIGO	        " & _
		" WHERE TELA = '"&TEL&"' and version = '"&RUT&"'	" & _
		" ORDER BY TELA DESC, opc, CODIGO			        "
		
'Response.Write(CAD)
'REsponse.end
rs.Open cad,cnn
if rs.RecordCount > 0 then
rs.MoveFirst
CONT =1
%>  
<%do while not rs.eof%> 
  <tr <%if CONT mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	>
			<td align="center" class="DESCRIPTORnegro"><%=rs("opc")%></td>
    <td align="center" class="DESCRIPTORnegro"><%=rs("codigo")%></td>
    <td align="center" class="DESCRIPTORnegroIZQ"><%=ucase(rs("descripcion"))%></td>
    <td align="center" class="DESCRIPTORnegro"><%=rs("merma")%>&nbsp;</td>
    <td align="center" class="DESCRIPTORnegro"><%'=TRIM(rs("merma"))%>&nbsp;</td>
  </tr>
  <%rs.MoveNext%>
  <%CONT = CONT +1 %>
<%loop%> 
  
<%end if
rs.Close
%>  
</table>

</body>
</html>
