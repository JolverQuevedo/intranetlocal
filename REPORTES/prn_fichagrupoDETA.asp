<%@ Language=VBScript %>
<%  Response.Buffer = false %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	TITULO = "DETALLE DE MEDIDAS DEL GRUPO: "
%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body style="margin-top:0px">
<script ID=clientEventHandlersJS LANGUAGE=javascript>


</script>
<%CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

cad = "select * from specs_head WHERE SPEC= '"&SP&"' AND VER = '"&VR&"'; " 
'response.write(cad)
rs.open cad,cnn
if rs.recordcount > 0 then

    CLI = Rs("CLI")
    TEM = Rs("codtem")
    EST = Rs("ESTilo")

end if
rs.close
CAD = "SELECT * FROM CLIENTE_TEMP_EST_TALLA WHERE CLI= '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"' "
'response.write(cad)
'response.write("<BR>")
RS.OPEN CAD,CNN
IF RS.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY tallas REGISTRADAS para su seleccion.... 
        <%response.end%>
</center>

<%rs.movefirst%>
<%end if%>
<TABLE width="100%" border="1" id="SERV" name="SERV" cellpadding="0" cellspacing="0">
<%cont = 0%>
	<tr bgcolor='<%=application("barra")%>'>
        <td width="4%" class="titulito" align="center" colspan="2">Medida</td>	
        <td width="1%" class="titulito" align="center" colspan="1">TOL +/-</td>	
		<%for i = 0 to 29 %>
        <%if len(trim(rs.fields.item(i+3)))> 0 then %>
            <td class="TITULITO" align="center" colspan="4"><%=trim(rs.fields.item(i+3))%></td>
        <%else%>
            <% maxi= i
            exit for%>
        <%end if%>
		<%next%>
	</tr>		
    <% oor= request.QueryString("orden")
       gru = request.QueryString("gru") 
    cad = "select * from view_spec_medidas where spec= '"&sp&"' and ver = '"&vr&"' and orden = '"&oor&"' and grupo ='"&gru&"' order by orden, lin "
       ' response.Write(cad)
        rs.close
        rs.open cad, cnn
        if rs.recordcount > 0 then rs.movefirst
    %>
    
    <%do while not rs.eof %>
        <%GRUPO = RS("GRUPO") %>
        <tr>
            <td colspan='<%=(i+3)*4%>' class="TEXTOred"><%=trim(rs("desgru"))%></td> 
        </tr>
        <%DO WHILE NOT RS.EOF AND RS("GRUPO") = GRUPO %>
            <tr>
               <input id="gru<%=cont%>" name="gru<%=cont%>" value='<%=trim(rs("grupo"))%>'  style="display:none">
                   <input id="med<%=cont%>" name="med<%=cont%>" value='<%=trim(rs("medida"))%>' style="display:none">
                   <input id="ord<%=cont%>" name="ord<%=cont%>" value='<%=trim(rs("orden"))%>'  style="display:none">
                   <input id="lin<%=cont%>" name="lin<%=cont%>" value='<%=trim(rs("LIN"))%>'    style="display:none">
                
               <td><span  class="TEXTONAVYREADONLY"><%=trim(rs("grupo"))%>-<%=trim(rs("medida"))%>&nbsp;</span></td> 
               <td><span  class="TEXTONAVYREADONLY"><%=trim(rs("desmed"))%>&nbsp;</span></td> 
               <td class="TEXTOblue100" align="center"><%=trim(rs("tolera"))%>&nbsp;</td> 

		        <%for j=0 to i-1%>
                    <td width="2%" align="center" class="TEXTOblue100"> <%=trim(rs.fields.item(j+9))%>&nbsp;</td>
                     <td width="2%" align="center" >&nbsp;</td>
                      <td width="2%" align="center" >&nbsp;</td>
                       <td width="2%" align="center" >&nbsp;</td>
                <%next %>
	        </tr>
            <%cont = cont + 1%>
            <%rs.movenext%>
             <%IF RS.EOF THEN EXIT DO %>
        <%LOOP%>
        <%IF RS.EOF THEN EXIT DO %>
    <%loop%>
</table>	

<%
set rs= nothing
set cnn=nothing
%>

<script>
</script>
</BODY>
</HTML>
