<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	
Response.CodePage = 65001
Response.CharSet = "utf-8"
txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	
	dim fts
	fts=""
	fts=request.querystring("fts")
	dim ano
	ano=request.querystring("ano")
	dim mes
	mes=request.querystring("mes")
	cad = "SELECT CP_CCODIGO  as 'RUC',"& _
       "AC_CNOMBRE as 'RAZON SOCIAL',  "& _
       "CP_CTIPDOC as 'TIPO DOC',  "& _
       "CP_CNUMDOC as 'NUM DOC',  "& _
       "CP_CCODMON as 'MONEDA',  "& _
       "CP_NTIPCAM as 'TIPO CAMBIO',  "& _
       "IMPORTE = CASE "& _
                     "WHEN CP_CCODMON = 'MN' "& _
                     "THEN CP_NIMPOMN "& _
                     "ELSE CP_NIMPOUS "& _
                 "END "& _
"FROM RSCONCAR..CP0001CART INER "& _
     "JOIN RSCONCAR..CP0001MAES ON AC_CCODIGO = CP_CCODIGO "& _
"WHERE CP_CVANEXO = 'P' "& _
      "AND CP_CCODIGO IN("&fts&") "& _
     "AND YEAR(CP_DFECDOC) = "&ano&" "& _
     "AND MONTH(CP_DFECDOC) = "&mes&" "& _
"ORDER BY ac_cnombre;" 
'RESPONSE.write(cad)
rs.open cad,cnn
	if request.querystring("excel") = "true" then
		archivo = "c:\temp\fts_excel.xls"
		Response.Charset = "UTF-8"
		Response.ContentType = "application/vnd.ms-excel" 
		Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
		
	end if
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<style>
	.des{
	background:#fff;color:#333;
		transition: all 0.13s ease-in;
	}
	.des:hover{
		background:#888;
		color:#fff;
	}
	td{
		padding:6px 8px;
	}
	*{font-family:sans-serif}
	</style>
</head>
<body>
	<table align="center" bgcolor="#777">
	<TR class="titulito" bgcolor="#0087d1" style="color:#fff">
	<%for I=0 to rs.fields.count - 1 %>
		<TD><%=RS.FIELDS(I).NAME%></TD>
		<%next%>	
	</tr>
	<%do while not rs.eof%>
	<tr  valign="top" class="des">
		<td align="center"><%=RS(0) %></td>
		<td align="LEFT"><%=RS(1) %></td>
		<td align="center"><%=ucase(RS(2))%></td>
		<td align="center"><%=ucase(RS(3))%></td>
		<td align="center"><%=ucase(RS(4))%></td>
		<td align="center"><%=ucase(RS(5))%></td>
		<td align="center"><%=ucase(RS(6))%></td>
	</tr>
    <%RS.MOVENEXT%>
<%loop%>
	</table>
</body>
</html>
