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
var auto=0;
var url = '../USUARIOS.asp?pos='
var alias = 'USUARIOS'
var TBL = 'USUARIOS'
var PK  = 'USUARIO'
var DS  = 'NOMBRES'
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
alias = "USUARIOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "USUARIO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "USUARIOS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "USUARIOS HITEPIMA"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERUSU.asp?'

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
		" * " & _ 
		" from "&ALIAS&" " & _
		" where "&indice&" >= '"& POS &"'" & _
		" ORDER BY "& indice &"  " 
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNusu.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
	<%ELSE%>
<SCRIPT>
</SCRIPT>		
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
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
			style="cursor:pointer;"
			onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=9');">
			
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
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%		LIMITE =  rs.fields.count - 1	
%>
<%for I=0 to LIMITE %>
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
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
		<% else %>
			<tr bgcolor=#C5D6D9
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  >
	<%end IF%>
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
<table border=0 align=center  cellspacing=5>
	<tr>
		<td > 
			<img src="imagenes/primera.gif" style="cursor:pointer;"
			onclick="primera('<%=urlBase%>')" 
			ALT="PRIMERA PAGINA">
		</td>
		<td >
			<IMG SRC="IMAGENES/PREV.GIF" ALT="PAGINA ANTERIOR"
				onclick="atras('tonos', '<%=indice%>', 'M')" 
				STYLE="CURSOR:pointer"> 
		</td>
		<td >
			<img src= "imagenes/arriba.gif" ALT="REGISTRO ANTERIOR"
				onclick="retrocede()" STYLE="CURSOR:pointer"> 
		</td>
		<td >
			<img src="imagenes/abajo.gif" ALT="REGISTRO SIGUIENTE"
				onclick="avanza()"  STYLE="CURSOR:pointer"> 
			
		</td>
		<td>
			<img src="imagenes/next.gif" ALT="PAGINA SIGUIENTE"
				onclick="pagina('<%=urlBase%>'+'?pos=')" 
				STYLE="CURSOR:pointer"> 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<img src= "imagenes/ultima.gif" ALT="ULTIMA PAGINA"
			 onclick="ultima('<%=urlBase%>','<%=ALIAS%>',
			'<%=RS.Fields.Item(0).Name%>')" 
			style="cursor:pointer;"> 
		</td>
		
	</tr>
</table>
<%END IF %>
<TABLE	WIDTH=100% BORDER=0 ID=DATAENTRY
		NAME=DATAENTRY 
		STYLE="DIsPLAY:none;">
<TR><TD>
        <table	align=center width="100%" 
		cellpadding=2 cellspacing=1  bgcolor=SteelBlue border=1>
          <tr valign="middle"> 
            <td WIDTH="10%" BGCOLOR=#C5D6D9 align= right>
             <font face=arial size=1 color=MidnightBlue ><B> 
              USUARIO :
             </td>
            <td BGCOLOR=WHITE WIDTH=20% valign=middle> 
              <input type="text" id="COD" name="COD" 
				STYLE="WIDTH:70%" valign=middle MAXLENGTH=10
				DISABLED READONLY maxlength=2>&nbsp;
			  
            </TD>
            
          
            <td WIDTH="10%" BGCOLOR=#C5D6D9 ALIGN=RIGHT> <font face=arial size=1 color=MidnightBlue ><B> 
              PASSWORD :</font></b> </td>
            <td BGCOLOR=WHITE > 
              <input type="text" id="DES" name="DES" STYLE="WIDTH:100%"
              MAXLENGTH=10>
            </td>
          </tr>
           <tr > 
            <td WIDTH="10%" BGCOLOR=#C5D6D9 ALIGN=RIGHT> <font face=arial size=1 color=MidnightBlue ><B> 
              NOMBRES :</font></b> </td>
            <td BGCOLOR=WHITE COLSPAN=5> 
              <input type="text" id="NOM" name="NOM" STYLE="WIDTH:100%"
              MAXLENGTH=50>
            </td>
          </tr>
        </table>
<table border=0 align=center  cellspacing=3>
<tr>
		<td>
		<IMG SRC="imagenes/NEW.gif"  ALT="REGISTRO EN BLANCO"
			onclick="NUEVO_onclick()" style="cursor:pointer;">	
	</td>
	<td>		
		<IMG SRC="imagenes/DISK.gif" ALT="GRABAR"
			onclick="GRABAR_onclick()" 
			style="cursor:pointer;">	
	</td>		
	<td>		
		<IMG SRC="imagenes/PRINT.gif" ALT="IMPRESION"
			onclick="javascript: window.open('REPORTES/prntbl.asp?pk=USUARIO&ds=NOMBREs&tbl=USUARIOS&tit=USUARIOS MODELADOR')"
			style="cursor:pointer;">	
	</td>				
	<td>		
		<IMG SRC="imagenes/DELETE.gif" ALT="ELIMIAR REGISTRO"
			onclick="elimina()" style="cursor:pointer;">	
	</td>		
</tr>
</table>

</TR></TD>
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

</form>
</BODY>
</HTML>
