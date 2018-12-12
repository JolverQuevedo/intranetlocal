<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<%	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    POS = Request.QueryString("pos")
    COM = Request.QueryString("COM")
    
	CAD =	" EXEC LETRA_COLOR_COMBO '"&POS&"', '"&COM&"'  "
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RECORDCOUNT <=0 THEN RESPONSE.END
	%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="">

<iframe  width="100%" style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<table width="100%" border="1" bordercolordark="<%=application("barra")%>" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="<%=application("contraste")%>" class="AMERICANwhite">ESTRUCTURA DEL LISTADO :<%=POS%> - <%=trim(rs("descripcion"))%></td>	
	</tr>
</table>


<table border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" width="100%">
<%rs.movefirst%>
<tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
    <td width="2%" class="DESCRIPTORnavyBOLD">SEC</td>
	    <%for x=0 to 5 
        deta = "D"&(x+1)%>
        <%if not isnull(rs(deta)) then %>
            <td width="5%" class="DESCRIPTORnavyBOLD">Let<%=x+1%></td>
            <td width="5%" class="DESCRIPTORnavyBOLD">Col<%=x+1%></td>
            <td width="5%" class="DESCRIPTORnavyBOLD">Des<%=x+1%></td>
            <td width="5%" class="DESCRIPTORnavyBOLD">Fib<%=x+1%></td>
            <%end if %>
        <%next%> 
	</tr>
<%cn=0 %>	
<%do while not rs.eof %>
  <tr valign="middle" bgcolor="<%if cn mod 2 = 0 then response.write(Application("color1")) else response.write(Application("color2")) %>" align="center">
	    <td width="5%" class="DESCRIPTORnavyBOLD"><%=TRIM(RS("SEC")) %></td>
         <%for x=0 to 5 
            letra = "letra"&(x+1)
            fibra = "fibra"&(x+1)
            COLO = "C"&(x+1)
            deta = "D"&(x+1)%>
                <%if not isnull(rs(deta)) then %>
                    <td width="5%" class="DESCRIPTORnavyBOLD"><%=trim(rs(letra))%></td>
                    <td width="5%" class="DESCRIPTORnavyBOLD"><%=trim(rs(colo))%></td>
                    <td width="5%" class="DESCRIPTORnavyBOLD"><%=trim(rs(deta))%></td>
                    <td width="5%" class="DESCRIPTORnavyBOLD"><%=trim(rs(fibra))%></td>
                <%end if %>
        <%next %>
	</tr>
    <%cn = cn+1 %>
    <%rs.movenext%>
<%loop%>   

 </table>
	<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>