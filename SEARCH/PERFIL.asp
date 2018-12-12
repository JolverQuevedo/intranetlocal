<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>

<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=1;
var url		= '../PERFIL.asp?pos='
var alias	= 'PERFILES'
var TBL		= 'PERFILES'
var PK		= 'ID'
var DS		= 'PERFIL'
var largo   = '1'
</script>

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
alias = "PERFILES"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "ID"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "PERFIL.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "PROBANDO PERFILES"
%>

<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERPERFIL.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
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
		" ID, PERFIL  " & _ 
		" from "&ALIAS&" " & _
		" where "&indice&" >= '"& POS &"'" & _
		" ORDER BY "& indice &"  " 
%>


<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtbl.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
	
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border="0" text="#000000">
<table WIDTH="100%">
	<tr>
		<td align= left WIDTH="35%">
			<IMG style="CURSOR: 
			hand"
			 onclick="javascript: window.history.back(1);" src="imagenes/ATRAS.gif" >
			
		</td>
		<td align= middle>
			<font face=arial size= 3 color=darkblue><B>
			<%=titulo%>
			</B></font>
		</td>
		<TD ALIGN=right WIDTH="35%"> 
		  	<IMG src="imagenes/logo.GIF"  >
		  </TD>
        </tr></TR>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="center" cols=2 width="100%"
	 cellpadding=2  cellspacing=1 bordercolor=white
	  bgcolor=navy border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
%>
<%for I=0 to LIMITE %>
	<TD align="middle">
		<FONT face=arial COLOR=ivory SIZE=1>
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
			<tr bgcolor=#f8fefb 
				  onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">
		<% else %>
			<tr bgcolor=#c5d6d9
				 onclick="dd('<%=(cont)%>')"  id="fila<%=Trim(Cstr(cont))%>">
	<%end IF%>

	<%FOR i=0 TO LIMITE%>
		<TD >
		<FONT face=arial COLOR=midnightblue SIZE=1>
		<B><%=RS.FIELDS.ITEM(I)%></B>
		</FONT>
	</TD>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </TD>
  </tr>
</TABLE>
<table border=0 align=center  cellspacing=5>
	<tr>
		<td > 
			<IMG style="CURSOR: hand"
			 
			onclick="primera(' <%=urlBase%>')" alt="PRIMERA PAGINA" src="imagenes/primera.gif" >
		</td>
		<td >
			<IMG style="CURSOR: hand" onclick="atras('id', '<%=indice%>', 'M')" 
				alt="PAGINA ANTERIOR" src="IMAGENES/PREV.GIF" > 
		</td>
		<td >
			<IMG style= "CURSOR: hand" onclick=retrocede() 
			alt="REGISTRO ANTERIOR" src="imagenes/arriba.gif" > 
		</td>
		<td >
			<IMG style="CURSOR: hand" onclick=avanza()  
			alt="REGISTRO SIGUIENTE" src="imagenes/abajo.gif" > 
			
		</td>
		<td>
				<IMG style="CURSOR: hand" onclick="pagina('<%=urlBase%>'+'?pos=')" 
				alt="PAGINA SIGUIENTE" src="imagenes/next.gif" > 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<IMG style= "CURSOR: hand" onclick ="ultima('<%=urlBase%>','<%=ALIAS%>',
			'<%=RS.Fields.Item(0).Name%>')" 
			alt="ULTIMA PAGINA" src="imagenes/ultima.gif" > 
		</td>
		
	</tr>
</table>
<%END IF %>
<TABLE	 WIDTH="100%" BORDER=0
		 
		ID=DATAENTRY NAME="DATAENTRY" STYLE="DISPLAY: none">
<TR><TD>
        <table	 align=center 
		 width="100%"  cellpadding=2 cellspacing=1 bgcolor=steelblue border=1>
          <tr valign="center"> 
            <td WIDTH="10%" BGCOLOR=#c5d6d9 align= right>
             <font face=arial size=1 color=midnightblue ><B> 
              PERFIL&nbsp;:</B></font> 
               
             </td>
            <td BGCOLOR=white WIDTH="20%" valign=center> 
              <input id="COD" name="COD" STYLE="WIDTH: 
				70%" valign="middle"
				 DISABLED READONLY maxlength=2 useMap="">&nbsp;
			  
            </td>
            <TD COLSPAN=4 BGCOLOR=white align=left ><b></b> 
             
            </TD>
          </tr>
          <tr > 
            <td WIDTH="10%" BGCOLOR=#c5d6d9 ALIGN=right> <font face=arial size=1 color=midnightblue ><B> 
              DESCRIPCION :</font></B> </td>
            <td BGCOLOR=white COLSPAN=5> 
              <input id="DES" name="DES" STYLE="WIDTH: 100%">
            </td>
          </tr>
          
        </table>
<table border=0 align=center  cellspacing=3>
<tr>
	<td > 
		<IMG style="CURSOR: hand"
			
			 onclick 
			="BUSCA(' <%=urlBase%>','<%=alias%>','id', 'perfil')" alt=BUSCAR src="imagenes/SEARCH.gif" > 
	</td>
	<td>
		<IMG style="CURSOR:  hand" onclick 
			=NUEVO_onclick() alt="REGISTRO EN BLANCO" src="imagenes/NEW.gif" >	
	</td>
	<td>		
		<IMG style="CURSOR: hand"
			 
			onclick=GRABAR_onclick() alt=GRABAR src="imagenes/DISK.gif" >	
	</td>		
			
	<td>		
		<IMG style="CURSOR: hand" onclick
			=elimina() alt="ELIMIAR REGISTRO" src="imagenes/DELETE.gif" >	
	</td>		
</tr>
</table></TD></TD>

</TR>
</TABLE>
<br>
<script>
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

</FORM>
</BODY>
</HTML>
