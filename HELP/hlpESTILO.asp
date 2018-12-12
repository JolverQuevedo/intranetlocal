<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
%>
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
</script>
<%
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "ESTILOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "ESTILO"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "ESTILOS"
	Dim largo
		largo = 5 'longitud del código
	Dim largo2 
		largo2 = 100 ' longitud de la descripcion
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'graba.asp?'
function ACTUALIZA(cod,des)
{	return true;
}
function VERIFICA() 
{	var t = document.all.TABLA;
	var ff = 0 ;
	for ( k = 1; k<TABLA.rows.length; k++ )
	{if( trim(TABLA.rows(k).cells(0).innerText)==trim(thisForm.CD.value).toUpperCase())
		{	alert("Código Duplicado");
			thisForm.CD.value = '';
			dd2(k);
			 return false;	
		}
	}
	ACTUALIZA(trim(thisForm.CD.value).toUpperCase(), ltrim(toAlpha(thisForm.DS.value)));
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	window.opener.window.thisForm.CODEST.value = ltrim(t.rows(pos).cells(0).innerText);
	window.opener.window.thisForm.DESEST.value = ltrim(t.rows(pos).cells(1).innerText)
	window.opener.window.thisForm.TIPPRE.value = ltrim(t.rows(pos).cells(2).innerText);
	window.opener.window.thisForm.DESTPREN.value = ltrim(t.rows(pos).cells(3).innerText);
	window.opener.window.thisForm.GEN.value = ltrim(t.rows(pos).cells(4).innerText);
	window.opener.window.thisForm.DESGEN.value = ltrim(t.rows(pos).cells(5).innerText)
	window.close();
}
</script>
<%
POS = Request.QueryString("pos")
CLI = Request.QueryString("CLI")
descli =Request.QueryString("desCLI")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  " & _
		" ESTILO, ESTILOS.DESCRIPCION, TIPOPRENDA AS TIP, " & _
		" TIPPRENDA.DESCRIPCION AS DESTIP, ESTILOS.GENERO, " & _ 
		" GENEROS.DESCRIPCION AS DESGEN, ESTILOS.ESTADO AS E , " & _
		" ESTILOS.USUARIO, ESTILOS.FECHA " & _
		" from "&ALIAS&" " & _
		" LEFT OUTER JOIN GENEROS ON ESTILOS.GENERO = GENEROS.GENERO " & _
		" LEFT OUTER JOIN TIPPRENDA ON ESTILOS.TIPOPRENDA = TIPPRENDA.TIPO " & _
		" where cliente = '"& cli &"'" & _
		" AND ESTILOS.ESTADO = 'A' " & _ 
		" ORDER BY ESTILO  " 
		'Response.Write(cad)
		'Response.end
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1%>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			<%=titulo%> - <%=descli%>
			</b></font>
		</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="../imagenes/logo.GIF"  >
		  </TD>
        </TR>
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<%IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST%>
		<%columnas = rs.Fields.Count%>
	<%ELSE%>
		<center>
		<font color = red size=4 face =arial>
		Lo siento... No tenemos registrados estilos para este cliente
		<%Response.End%>		
<%	END IF %>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%for I=0 to columnas-4 %>
	<TD align="center">
		<FONT face=arial COLOR=IVORY SIZE=1>
		<B><%=RS.FIELDS(I).NAME%></B>
		</FONT>
	</TD>
<%next%>	
</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB 
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ondblclick="REDIR('<%=(cont)%>')">
		<% else %>
			<tr bgcolor=#C5D6D9
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  
				ondblclick="REDIR('<%=(cont)%>')">
	<%end IF%>

	<%FOR i=0 TO columnas - 4%>
		<TD >
		<FONT face=arial COLOR=MidnightBlue SIZE=1>
		<B><%=RS.FIELDS.ITEM(I)%></B>&nbsp;
		</FONT>
	</TD>
	<%NEXT%>
	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<%end if%>
<TABLE width=100% id = DATAENTRY Style="display:none;">
	<TR>
		<td  bgcolor="#eef1ed" > 
			<font face="arial" size="1" color="#003399"> 
			COD</font> 
		</td>
		<td  bgcolor="#eef1ed" > 
			<font face="arial" size="1" color="#003399"> 
			DESCRIPCION</font> 
		</td>
	</TR>
	<TR>
		<td  bgcolor="#fff0e1" > 
			<input id =CD TYPE=TEXT MAXLENGTH='<%=LARGO%>'
			style="width:100%; text-align:CENTER">
		</td>
		<td  bgcolor="#fff0e1" > 
			<input id =DS TYPE=TEXT MAXLENGTH='<%=largo2%>'
			style="width:100%; text-align:LEFT">
		</td>
	</TR>
	<TR>
		<td  COLSPAN=2 ALIGN=CENTER> 
			<IMG SRC="..\IMAGENES\DISK.GIF"
				STYLE="CURSOR:HAND;"
				ONCLICK="VERIFICA()">
		</td>
	</TR>
</TABLE>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<%	IF CONT =1 THEN %>
	<SCRIPT>
		thisForm.CD.focus();
	</SCRIPT>		
<%	END IF 	%>
	
<script>
dd2('1');
</script>    
</form>
</BODY>
</HTML>
