<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
owner = Application("owner")
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
alias = ""&OWNER&".MERMAS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = ""
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "MERMAS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "MERMAS DE PRODUCCION"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERMER.asp'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	
	dd(ff);
}
function GRABAR_onclick()
{	var cad = funcionalidad 
	cad = cad + '?SER=' + toInt(thisForm.SER.value);
	cad = cad + '&TEL=' + thisForm.TEL.value;
	cad = cad + '&AVI=' + thisForm.AVI.value;
	cad = cad + '&HIL=' + thisForm.HIL.value;
	cad = cad + '&TEJ=' + thisForm.TEJ.value;
	cad = cad + '&TEN=' + thisForm.TEN.value;
	cad = cad + '&COR=' + thisForm.COR.value;
	cad = cad + '&ACA=' + thisForm.ACA.value;
	cad = cad + '&COS=' + thisForm.COS.value;
	cad = cad + '&EMB=' + thisForm.EMB.value;
	cad = cad + '&SIN=' + thisForm.SIN.value;
	window.location.replace(cad)
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
		" from "&OWNER&".MERMAS " & _
		" WHERE ESTADO = 'A' " 
		'Response.Write(CAD)
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%	RS.Open CAD, Cnn
	IF RS.RECORDCOUNT > 0 THEN 	RS.MOVEFIRST%>
	
<%	CONT = 1
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="imagenes/ATRAS.gif" 
			style="cursor:hand;"
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=1');">
			
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			<%=titulo%>
			</b></font>
		</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="imagenes/logo.GIF"  >
		  </TD>
        </TR>
        <TR>
			<TD COLSPAN=3>
				<HR SIZE = 1 COLOR= DARKGREEN>
				<BR><BR>
			</TD>
        </TR>
	</tr>
</table>
<TABLE	BORDER=0 ID=DATAENTRY WIDTH=20%
		cellpadding=2 cellspacing=1  bgcolor=SteelBlue border=1
		NAME=DATAENTRY  ALIGN=CENTER>
<tr> 
	  <td WIDTH="10%" BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
	  	<font face=arial size=1 color=MidnightBlue ><B> 
	  	SERVICIOS :</font></b> 
	  </td>
	  <td BGCOLOR=WHITE WIDTH=5%> 
	    <input type="text" id="SER" name="SER" 
	    VALUE= <%=RS("SERVICIOS")%>
	    STYLE="WIDTH:100%" MAXLENGTH=6>
	  </td>
	  <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>'>
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
</tr>
<TR>
	<td  BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
	  <font face=arial size=1 color=MidnightBlue ><B> 
	    TELAS :</font></b> 
	</td>
	  <td BGCOLOR=WHITE ALIGN=RIGHT> 
	  	<input type="text" id="TEL" name="TEL" 
	  	VALUE='<%=RS("TELAS")%>'
	  	STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
	  </td>
	  <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
</tr>
<TR>
	<td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		AVIOS :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="AVI" name="AVI" 
		VALUE='<%=RS("AVIOS")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
</tr>
<TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		HILO :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="HIL" name="HIL"
		VALUE='<%=RS("HILO")%>' 
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
<TR>
    <td  BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		TEJIDO :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="TEJ" name="TEJ" 
		VALUE='<%=RS("TEJIDO")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
</tr>
<TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		TEÑIDO :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="TEN" name="TEN" 
		VALUE='<%=RS("TENIDO")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>

 <TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		CORTE :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="COR" name="COR" 
		VALUE='<%=RS("CORTE")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
 <TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		COSTURA :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="COS" name="COS" 
		VALUE='<%=RS("COSTURA")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
 <TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		ACABADO :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="ACA" name="ACA" 
		VALUE='<%=RS("ACABADO")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
 <TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		EMBALAJE :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="EMB" name="EMB" 
		VALUE='<%=RS("EMBALAJE")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
 <TR>
    <td BGCOLOR='<%=(Application("barra"))%>' ALIGN=RIGHT> 
		<font face=arial size=1 color=MidnightBlue ><B> 
		ENCONADO :</font></b> 
	</td>
    <td BGCOLOR=WHITE ALIGN=RIGHT> 
		<input type="text" id="SIN" name="SIN" 
		VALUE='<%=RS("ENCONADO")%>'
		STYLE="WIDTH:100%" ONCHANGE="toInt(this)">
    </td>
    <TD WIDTH = 1%  BGCOLOR='<%=(Application("barra"))%>' >
			<font face=arial size=1 color=MidnightBlue ><B> 
			%
	  </TD>
 </tr>
</table>
<table border=0 align=center  cellspacing=3>
<tr>
	
	<TD <%IF NIVEL > 1 THEN %>STYLE="DISPLAY:NONE"<%END IF%>>
		<IMG SRC="imagenes/DISK.gif" ALT="GRABAR"
			onclick="GRABAR_onclick()" style="cursor:hand;">	
	</td>		
	<td>		
		<IMG SRC="imagenes/PRINT.gif" ALT="IMPRESION"
			onclick="javascript: window.print()" 
			style="cursor:hand;">	
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
