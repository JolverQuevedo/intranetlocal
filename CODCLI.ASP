<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=1"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "CLIENTE : "
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<title><%=titulo%></title>
</head>
<body>
<table width="100%" >
	<tr><td align= "left" width="20%" >
            <img src="imagenes/cerrar.gif" style="cursor:pointer; display::none" alt="" onClick="top.window.close();" id="RR"/>
	        <img src="imagenes/ATRAS.gif" style="cursor:pointer; display:none" alt="" onClick="javascript: top.window.location.replace('<%=submenu%>');" id="CC"/>
        </td>
		<td align="center" class="talasblue"><%=titulo%></td>
		<td>
    	    <select id="CLI" name="CLI"  onChange="DETALLE()">
        	    <option value=""></option>
                <%CAD = "SELECT CODIGO, NOMBRE FROM CLIENTE WHERE ESTADO ='A' " & _
	    		        " ORDER BY NOMBRE "
    	        RS.OPEN CAD,CNN 
		        IF RS.RECORDCOUNT >0 THEN
		            RS.MOVEFIRST%>		
		            <%DO WHILE NOT RS.EOF%>
        	            <option value="<%=TRIM(RS("CODIGO"))%>"><%=TRIM(RS("NOMBRE"))%></option>
    		            <%RS.MOVENEXT%>
    	            <%LOOP%>
                <%END IF%>   
            </select> 
        </td>
		<td align="right" width="20%" ><img src="imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	    <td colspan="4"><hr /></td>
	</tr>
</table>
<script type="text/jscript" language="jscript">
PAG= trim('<%=REQUEST.QueryString("ID")%>')
if (PAG == "RECTO")
{	document.all.RR.style.display='block'
	document.all.CC.style.display='none'
}
else
{	document.all.CC.style.display='block'
	document.all.RR.style.display='none'
}

function DETALLE()
{	
	switch(PAG)
 {
 case "RECTO":
  	cad = "RECTILcli.asp?pos=&cli=" + trim(document.all.CLI.value)
	cad += '&tel='+ '<%=REQUEST.QueryString("tel")%>'
	cad += '&dek='+ '<%=REQUEST.QueryString("dek")%>'
   	break;
 case "TALLA":
  	cad = "tallacli.asp?pos=" +trim(document.all.CLI.value)
   	break;
 default:
   return true;
 }
	
	cad += '&DES='+ltrim(document.all.CLI.options(document.all.CLI.selectedIndex).innerText)
    cad += '&perfil=1'
	top.window.frames.item(1).location.replace(cad)
}
</script>
</body>

</html>
