<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>


<table border="0" align="center"  cellspacing="5">
	<tr valign="top" style="height:50px; vertical-align:top">
		
	<td ><img src="imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onclick="atras()" style="CURSOR:pointer" /> </td>
	<td ><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE"	onclick="avanza()"  style="CURSOR:pointer" /> </td>
	<td><img src="imagenes/new.gif" alt="NUEVA ORDEN DE COMPRA" onclick="crea()" style="cursor:pointer;" /></td>		
    <td><img src="imagenes/DELETE.gif" alt="ELIMIAR ORDEN DE COMPRA" onclick="anula()" style="cursor:pointer;" /></td>		
	<td><img src="imagenes/PRINT.gif" alt="IMPRESION"	onclick="printa()"style="cursor:pointer;" /></td>
    <td><img src="imagenes/ANALISIS.PNg" alt="IMPRESION ANALITICA"	onclick="ANALISIS()"style="cursor:pointer;" /></td>
    <td><img src="imagenes/SEARCH.gif" onclick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer; display:none;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	        <table align="center"  width="100%" bordercolor="#FFFFFF" bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	          <tr>  
	            <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		            <b><%=pk%></b></font></td>
		        <td><input id="kod" name="kod" value="" /> </td>    
	          </tr>
	          <tr>  
	            <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		            <b><%=DS%></b></font></td>
		        <td><input id="ds" name="ds" value="" /> </td>    
	          </tr>
	          <tr>  
	            <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onclick="document.all.seeker.style.display='none'">
	                <font face="arial" color="red" size="1">
		            <b><u>(X) Cerrar</u></b></font></td>
		        <td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onclick="BUSCA('')">
		        <font face="arial" color='<%=Application("Titulo")%>' size="1">
		            <b><U>FILTRAR</U></b></font></td>
	          </tr>
	         </table> 
	</td>	
    </tr>

</table>

<script type="text/jscript" language="jscript">
    function atras()    {  parent.mainFrame.atrasa()   }
    function avanza()   {  parent.mainFrame.avanza()   }
    function anula()    {  parent.mainFrame.elimina()  }
    function printa()   {  parent.mainFrame.imprime()  }
    function crea()     {  parent.mainFrame.NUEVO()    }
    function ANALISIS() {  parent.mainFrame.ANALI() }

</script>

</form>
</body>
</html>
