<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("User")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	owner = Application("owner")
%>
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=1;
var url = '../TENIDO.asp?'
var alias = 'TENIDO'
var TBL = 'TENIDO'
var PK  = 'TENIDO'
var DS  = 'DESTENIDO'
var oldrow = 1
var largo=2
var largo2=50
</script>
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
Dim pageSize 
if nivel > 1 then 	pageSize = 16 else 	pageSize = 6
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "tENIDO"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "TENIDO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "TENIDO.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "TIPOS DE TE&Ntilde;IDO"
submenu = "SUBMENU.ASP?TIPO=1"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERTEN.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pageSize&"  " & _
		" TENIDO, DESTENIDO AS DESCRIPCION, MERMA, costoKG as COSTO, " & _		
		" FECHA, USUARIO, ESTADO " & _ 
		" from "&ALIAS&" " & _
		" where "&indice&" >= '"& POS &"'" & _
		" AND ESTADO = 'A' " & _ 
		" ORDER BY "& indice &"  " 
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtEN.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF RS.recordcount > 0 THEN	RS.MOVEFIRST%>
	
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form name="thisForm" method="post" ><html>
<table width="100%" border="0">
	<tr>
		<td align= "left" width="5%"><img src="imagenes/ATRAS.gif" style="cursor:hand;" alt="" onClick="javascript: window.location.replace('<%=submenu%>');" /></td>
		<td align="center" class="TALASBLUE"><%=titulo%></td>
		<td align="right" width="5%"><img src="imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<%'*********************************************************************%>
<table id="TABLA" align="center" width="100%" cellpadding="2"  cellspacing="1" bordercolor="<%=application("color2") %>"
	  bgcolor="<%=application("borde") %>" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<% LIMITE = RS.FIELDS.COUNT-1
for I=0 to LIMITE %>
	<td align="center" class="AMERICANwhite"><%=RS.FIELDS(I).NAME%></td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
<tr  bgcolor='<% IF CONT mod 2  = 0 THEN response.write((Application("color1"))) else response.write(Application("color2"))end IF%>'
		onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" name="fila<%=Trim(Cstr(cont))%>">
	<%FOR i=0 TO LIMITE%>
		<td class="DESCRIPTORnavy"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:hand;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras(alias, '<%=indice%>')" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/arriba.gif" alt="REGISTRO ANTERIOR"	onclick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=urlBase%>'+'?pos=')" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/ultima.gif" alt="ULTIMA PAGINA"  onclick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:hand;" /></td>
	<td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:hand;" /></td>
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:hand;" /> </td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"   bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
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
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:hand" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:hand" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<table	width="100%" border="0" id="DATAENTRY" name="DATAENTRY" style="DIsPLAY:none;">
<tr><td>
       <table align=center width="100%" cellpadding="1" cellspacing="0"  bgcolor="<%=application("color2") %>" border="1" 
       bordercolorlight="<%=application("borde") %>" bordercolordark="<%=application("color2") %>">
          <tr valign="middle">  
            <td width="5%" bgcolor='<%=(Application("barra"))%>' class="DESCRIPTORnavy">TIPO :</td>
            <td width="6%" bgcolor='<%=(Application("color2"))%>'><input type="text" id="COD" name="COD" readonly="readonly" class="datos"></td>
            <td width="5%" bgcolor='<%=(Application("barra"))%>' class="DESCRIPTORnavy">DESCRIPCION :</td>
            <td width="60%"bgcolor='<%=(Application("color2"))%>'><input type="text" id="DES" name="DES" class="datos"></td> 
            <td width="5%" bgcolor='<%=(Application("barra"))%>' class="descriptornavy">% Merma :</td>
            <td width="5%" bgcolor='<%=(Application("color2"))%>'><input type="text" id="MER" name="MER" class="datos"></td>
            <td width="7%" bgcolor='<%=(Application("barra"))%>' class="descriptornavy">US$/KG :</td>
            <td width="7%" bgcolor='<%=(Application("color2"))%>'><input type="text" id="CTO" name="CTO" class="datos"></td>
          </tr>          
        </table>
</td></tr>
<tr><td>        
<table border="0" align="center"  cellspacing="3">
<tr>
	<td><img src="imagenes/NEW.gif" alt="REGISTRO EN BLANCO" onClick="NUEVO_onclick()" style="cursor:hand;"></td>
	<td><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:hand;"></td>		
	<td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:hand;"></td>		
</tr>
</table>

</tr></td>
</table>
<br>
<script>
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0)
dd2('1');
</script>    
<%IF txtPerfil = 1 THEN%>
	<SCRIPT> 
		eval("DATAENTRY.style.display='block'");
	</SCRIPT>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>
