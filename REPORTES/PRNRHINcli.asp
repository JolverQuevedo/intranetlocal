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
<%
CAD =	" SELECT  " & _
		" * " & _
		" from cliente where  estado ='a' " & _
		" ORDER BY nombre" 
		RS.OPEN CAD ,Cnn
		'response.write(cad)
If rs.eof or rs.bof then
	Response.Write("No hay Clientes Creados")		
	Response.End
end if	
	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
rs.movefirst
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" border="0">

<table width="100%">
	<tr>
	   
		<td  align="center" class="TALASBLUE">CLIENTES RHIN</td>
		
        </tr>
	<tr><td  colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center"  cellpadding="0" cellspacing="0" bordercolor='<%=application("color1") %>' border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<tr bgcolor="<%=application("titulo") %>">
	<%for I=0 to LIMITE %>
		<td class="tituloRESUMEN"><%=trim(RS.FIELDS(I).name)%>&nbsp;</td>
	<%next%>	
</tr>

<%cont= 1
do while not rs.eof%>
    <tr bgcolor="<%IF CONT MOD 2 = 0 THEN RESPONSE.WRITE(application("color1")) ELSE RESPONSE.WRITE(application("color2"))%>">
	    <%FOR i=0 TO limite%>
		    <td   style="padding-left:5px; font-family:Calibri ">
		        <%if UCASE(rs.fields(i).name) = "FECCREA" OR UCASE(rs.fields(i).name) = "FECMOD" THEN
		            RESPONSE.Write(SPACE(1) +LEFT(trim(RS.FIELDS.ITEM(I)),10) + space(1))
		          ELSE
		            RESponse.Write(SPACE(1) +trim(rs.fields.item(i)) + space(1))
		          end if%>
		    </td>
	    <%NEXT%>
    </tr>
    <%RS.MOVENEXT%>
	<%if rs.eof then exit do%>
    <%CONT = CONT + 1%>
   
<%loop%>
</table>
</body>
</html>
