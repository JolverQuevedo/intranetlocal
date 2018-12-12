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
var url = '../GRUPOMEDIDA.asp?pos='
var alias = 'dbo.GRUPOMEDIDA'
var TBL = 'dbo.GRUPOMEDIDA'
var PK  = 'CODIGO'
var DS  = 'desCRIPCION'
var largo = 3
var largo2 = 200
var oldrow=1

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
alias = ""&OWNER&".GRUPOMEDIDA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "GRUPOMEDIDA.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "TIPOS DE MEDIDA"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERtbl.asp?'

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
CAD =	" SELECT top  "&pageSize&"      " & _
		" CODIGO,  DESCRIPCION,         " & _		
		" FECHA, USUARIO, ESTADO        " & _ 
		" from "&ALIAS&"                " & _
		" where "&indice&" >= '"&POS&"' " & _
		" AND ESTADO = 'A'              " & _ 
		" ORDER BY "& indice &";        " 
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtbl.ASP"-->
<%
RS.Open CAD, Cnn

	response.write(RS.RECORDCOUNT)
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
	<%ELSE%>
<SCRIPT>
	//window.location.replace('MONEDAS.ASP')
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
			style="cursor:hand;"
	onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=2');">
				
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
	<TR><td COLSPAN=3><HR></td></TR>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor="lightgrey" border=1 >
	  
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
<tr <% IF CONT mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>' 
	<%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
		onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
		NAME="fila<%=Trim(Cstr(cont))%>">
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
			<img src="imagenes/primera.gif" style="cursor:hand;"
			onclick="primera('<%=urlBase%>')" 
			ALT="PRIMERA PAGINA">
		</td>
		<td >
			<IMG SRC="IMAGENES/PREV.GIF" ALT="PAGINA ANTERIOR"
				onclick="atras('GRUPOMEDIDA', '<%=indice%>')" 
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
		cellpadding=1 cellspacing=0  bgcolor=WHITE border=1 bordercolorlight=GAINSBORO bordercolordark=WHITE>
          <tr valign="middle">  
            <td WIDTH="10%"  BGCOLOR='<%=(Application("barra"))%>' align= right>
             <font face=arial size=1 color=MidnightBlue ><B> 
              CODIGO :
             </td>
            <td BGCOLOR=WHITE WIDTH=20% valign=middle> 
              <input type="text" id="COD" name="COD" 
				STYLE="WIDTH:70%" valign=middle MAXLENGTH=2
				tabindex=-1 READONLY>&nbsp;
			  
            </TD>
            <TD COLSPAN=4 BGCOLOR=WHITE align=left ><b> 
             
            </td>
          </tr>
          <tr > 
            <td WIDTH="10%"  BGCOLOR='<%=(Application("barra"))%>'  ALIGN=RIGHT> <font face=arial size=1 color=MidnightBlue ><B> 
              DESCRIPCION :</font></b> </td>
            <td BGCOLOR=WHITE COLSPAN=5> 
              <input type="text" id="DES" name="DES" STYLE="WIDTH:100%">
            </td>
          </tr>
          
        </table>
        
<iframe frameborder="1" style="display:NONE;" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>
<table border=0 align=center  cellspacing=3>
<tr>
	<td > 
		<IMG SRC="imagenes/SEARCH.gif" ALT="BUSCAR"
			onclick="BUSCA('<%=urlBase%>','<%=alias%>',
			'TIPO', 'desCRIPCION')" 
			ALT="BUSCA" style="cursor:hand;"> 
	</td>
	<td>
		<IMG SRC="imagenes/NEW.gif"  ALT="REGISTRO EN BLANCO"
			onclick="NUEVO_onclick()" style="cursor:hand;">	
	</td>
	<td>		
		<IMG SRC="imagenes/DISK.gif" ALT="GRABAR"
			onclick="GRABAR_onclick()" 
			style="cursor:hand;">	
	</td>		
	<td>		
		<IMG SRC="imagenes/PRINT.gif" ALT="IMPRESION"
			onclick="javascript: window.open('REPORTES/prnTBL.asp?pk=codigo&ds=desCRIPCION&tbl=GRUPOMEDIDA&tit=GRUPOS DE MEDIDAS')"
			style="cursor:hand;">	
	</td>				
	<td>		
		<IMG SRC="imagenes/DELETE.gif" ALT="ELIMIAR REGISTRO"
			onclick="elimina()" style="cursor:hand;">	
	</td>		
</tr>
</table>

</TR></TD>
</TABLE>
<br>
<script>
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
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
