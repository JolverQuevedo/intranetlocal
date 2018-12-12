<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
ofi = LEFT(Request.QueryString("ofi"),10)

'RESPONSE.Write(VVV)
cad = "select  * from ofis WHERE CODIGO = '"&ofi&"' "
response.write(cad)
response.write("<br>")
rs.open cad, cnn
if rs.recordcount > 0 then %>    
    <script type="text/jscript" language="jscript">
        top.window.document.all.EST.value = '<%=rs("codest")%>'
    </script>
    <%rs.close
    cad = "select * from pos WHERE ofi = (select codigo from ofis where codigo = '"&ofi&"')"
    
    response.write("<br>")
    response.write(cad)
    rs.open cad, cnn
    if rs.recordcount > 0 then %> 
    <script type="text/jscript" language="jscript">
       top.window.document.all.POS.value = '<%=rs("po") %>'
    </script>
    <%end if
    rs.close
    cad = "SELECT * FROM PROTOS WHERE cotizacion = (select cotizacion from pos where ofi = '"&ofi&"' )"
    response.write("<br>")
    response.write(cad)
    rs.open cad,cnn
    if rs.recordcount > 0 then
    pro =  trim(rs("proto"))+"-"+trim(rs("version"))
    %> 
    <script type="text/jscript" language="jscript">
        top.window.document.all.PRO.value = '<%=pro %>'
    </script>
    <%end if
    rs.close
    cad = "SELECT * FROM estilos WHERE CODEST = (select CODEST from ofis WHERE CODIGO = '"&OFI&"' )  AND CLIENTE = (select CLIENTE from ofis WHERE CODIGO = '"&OFI&"')"
    response.write("<br>")
    response.write(cad)
    response.write("<br>")
    rs.open cad, cnn
    if rs.recordcount > 0 then 
    estilo = rs("CODEST")
    cliente = rs("cliente")
    screen = "recuperaFOTOESTILO.asp?ID=" + estilo + "&CLI=" + cliente
    %>
    <script type="text/jscript" language="jscript">
        top.window.document.all.EST.value = '<%=estilo %>'
        top.window.document.all.ECL.value = '<%=trim(rs("estcli"))%>'
        top.window.document.all.des.value = '<%=trim(rs("descripcion"))%>'
        top.window.document.all.CLI.value = '<%=cliente%>'
        top.window.foton()
    //    alert()
                  
    </script>
    <%end if
else
   top.window.document.all.EST.value = "OFI No Existe..."
end if


%>




<HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

</BODY>
</HTML>
