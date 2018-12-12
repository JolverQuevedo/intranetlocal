<%@ Language=VBScript %>
<% Response.Buffer = true %>

<LINK REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >


<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtbl.ASP"-->

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
alias = ""&OWNER&".GENEROS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "GENERO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "GENEROS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "GENEROS DE PRENDAS"

POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pageSize&"  " & _
		" * " & _ 
		" from "&ALIAS&" " & _
		" where "&indice&" >= '"& POS &"'" & _
		" AND ESTADO = 'A' " & _ 
		" ORDER BY "& indice &"  " 
%>

<%	RS.Open CAD, Cnn
	CONT = 1
IF  RS.RECORDCOUNT > 0 THEN 	RS.MOVEFIRST else Response.end%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">

<%'*********************************************************************%>
<table	align=center width="100%" id="TABLA"
		cellpadding=1 cellspacing=0 
		 bgcolor=WHITE border=1 bordercolorlight=GAINSBORO bordercolordark=WHITE>
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor="#0087d1" >
<% LIMITE = RS.FIELDS.COUNT-1
for I=0 to LIMITE %>
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
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' 
	<%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
		 id="fila<%=Trim(Cstr(cont))%>" >
	<%FOR i=0 TO LIMITE%>
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


</TR></TD>
</TABLE>
<br>
<script>
rec = parseInt('<%=rs.recordcount%>',10)


</script>  

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>
