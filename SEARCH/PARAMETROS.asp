<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil	
	owner = Application("owner")%>
<link rel="Stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
Dim pageSize 
if nivel > 1 then
	pageSize = 16
else
	pageSize = 6
end if
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = ""&OWNER&".TB_CTRL"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = ""
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "PARAMETROS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "PARAMETROS GENERALES"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERparam.asp'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	
	dd(ff);
}
function GRABAR_onclick()
{	var cad = funcionalidad 
	cad = cad + '?IGV=' + thisForm.IGV.value;
	cad = cad + '&CAL1=' + thisForm.CAL1.value;
	cad = cad + '&CAL2=' + thisForm.CAL2.value;
	cad = cad + '&minor=' + thisForm.minor.value;
	cad = cad + '&EMP=' + thisForm.EMP.value;
	cad = cad + '&UTIL=' + thisForm.UTIL.value;
	cad = cad + '&TIPCAM=' + thisForm.TIPCAM.value;
	cad = cad + '&VISA=' + thisForm.VISA.value;
	window.open(cad)
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
CAD =	" SELECT * " & _
		" from "&OWNER&".TB_CTRL " 	
		'Response.Write(CAD)
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%	RS.Open CAD, Cnn
	IF RS.RECORDCOUNT>0 THEN RS.MOVEFIRST%>

<%	CONT = 1
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
Titulo = "PARAMETROS COTIZADOR"
%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ACTION='comun/INSERparam.asp'>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<body topmargin=0 leftmargin=20 rightmargin=20 subtotr=0 text="#000000" onload="document.all.IGV.focus();">
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="imagenes/ATRAS.gif" style="cursor:hand;" alt="" onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=4');" /></td>
		<td align="center"><table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center"	width="100%" bordercolorlight="#f7d975">
		    <tr><td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b><%=titulo%></b></font></td></tr>
		    </table>
		</td>
		<td align="right" width="25%"><img src="imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>

<table id="dataentry" name="dataentry" cellpadding="2" cellspacing="1"  subtotr="1" style="width:30%;" align="center"  >
<tr> 
	  <td style="width:60%; background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">I.G.V. :	</td>
	  <td style="width:20%;"><input type="text" id="IGV" name="IGV" value= <%=RS("PORIGV")%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="width:20%; background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;%&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("barra"))%>'" class="AMERICAN22">% de Valoración de Prenda:</td>
	  <td><input type="text" id="POR" name="POR" value= '<%=formatnumber(RS("PorcValPre"),2,,true)%>' style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("BARRA"))%>'"  class="AMERICAN22">&nbsp;%&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">Valor Minuto. :	</td>
	  <td ><input type="text" id="VMIN" name="VMIN" value= <%=formatnumber(RS("valormin"),2,,true)%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;Us $&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("barra"))%>'" class="AMERICAN22">Draw Back:</td>
	  <td><input type="text" id="DBK" name="DBK" value= '<%=RS("dback")%>' style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("barra"))%>'"  class="AMERICAN22">&nbsp;%&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">Cobertura :	</td>
	  <td style="width:5%;"><input type="text" id="COB" name="COB" value= <%=RS("cobertura")%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;%&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("barra"))%>'" class="AMERICAN22">Impuesto a la Renta:</td>
	  <td><input type="text" id="IMPU" name="IMPU" value= '<%=RS("renta")%>' style="width:100%" class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("barra"))%>'"  class="AMERICAN22">&nbsp;%&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">Factor Financiamiento 1 :	</td>
	  <td style="width:5%;"><input type="text" id="FC1" name="FC1" value= <%=formatnumber(RS("FACTOR1"),2,,true)%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("barra"))%>'" class="AMERICAN22">Meses a Financiar:</td>
	  <td><input type="text" id="FC2" name="FC2" value= '<%=RS("FACTOR2")%>' style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("barra"))%>'"  class="AMERICAN22">&nbsp; &nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">Enbarque Aereo :	</td>
	  <td style="width:5%;"><input type="text" id="AIR" name="AIR" value= <%=RS("AIR")%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;US $&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("barra"))%>'" class="AMERICAN22">Embarque Marítimo:</td>
	  <td><input type="text" id="SEA" name="SEA" value= '<%=RS("SEA")%>' style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("barra"))%>'"  class="AMERICAN22">&nbsp;US $&nbsp;</td>
</tr>
<tr> 
	  <td style="background-color:'<%=(Application("subtot"))%>'" class="AMERICAN22">Enbarque DHL :	</td>
	  <td style="width:5%;"><input type="text" id="DHL" name="DHL" value= <%=RS("DHL")%>  style="width:100%"  class="DATOgrandeDER"></td>
	  <td style="background-color:'<%=(Application("subtot"))%>'"  class="AMERICAN22">&nbsp;US $&nbsp;</td>
</tr>
</table>
<table subtotr=0 align=center  cellspacing=3>
<tr>
	
	<TD <%IF NIVEL > 1 THEN %>STYLE="DISPLAY:NONE"<%END IF%>>
		<IMG SRC="imagenes/DISK.gif" ALT="GRABAR"
			onclick="thisForm.submit()" style="cursor:hand;">	
	</td>					
</tr>
</table>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</BODY>
</HTML>
