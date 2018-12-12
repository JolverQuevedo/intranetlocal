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
<LINK REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNMEN.ASP"-->
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=1;
var url = '../mantmenu.asp'
var alias = 'MENU'
var TBL = 'MENU'
var PK  = 'MENU'
var DS  = 'DESMENU'
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
	pageSize = 15 
end if
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "MENU"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "MENU"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "mantmenu.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "MANTENIMIENTO DE MENU"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERMANTENIMIENTO.asp'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<% POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pageSize&" MENU,	" & _
		" upper(DESMENU) AS DESMENU,		" & _
		" upper(PROGRAMA) AS PROGRAMA		" & _
		" FROM "&ALIAS&"  WHERE				" & _
		" MENU >= '"&POS&"' AND ESTADO='A'	" & _
		" ORDER BY CONVERT(INTEGER, MENU)	" 

'Response.Write (CAD)
%>
<%	RS.Open CAD, Cnn
	CONT = 1
IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ACTION="COMUN/INSERMENU.ASP"><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border="0" text="black">
<table WIDTH="100%">
	<tr>
		<td align= left WIDTH="35%">
			<IMG style="CURSOR: hand"
			 onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=9');" 
			 src="imagenes/ATRAS.gif" >
			
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
<%	LIMITE =  rs.fields.count - 1
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
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ONDBLCLICK="FICHA('<%=(cont)%>')">
		<% else %>
			<tr bgcolor=#c5d6d9
				 onclick="dd('<%=(cont)%>')"  
				id="fila<%=Trim(Cstr(cont))%>" ONDBLCLICK="FICHA('<%=(cont)%>')" >
	<%end IF%>

	<%FOR i=0 TO LIMITE%>
		<TD >
		<FONT face=arial COLOR=midnightblue SIZE=1>
		<B><%=RS.FIELDS.ITEM(I)%></B>
		<%IF ISNULL(RS.FIELDS.ITEM(I)) OR TRIM(RS.FIELDS(I))="" THEN %>
			&nbsp;
		<%END IF%>
		</FONT>
	</TD>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </TD>
  </tr>
</TABLE>


<table border=0 align=center  cellspacing=5>
	<tr>
		<td> 
			<IMG style="CURSOR: hand" 
			onclick="primera(' <%=urlBase%>')" alt="PRIMERA PAGINA" src="imagenes/primera.gif" >
		</td>
		<td >
			<IMG style="CURSOR: hand" 
			onclick ="atras('<%=ALIAS%>', '<%=indice%>')" 
				alt="PAGINA ANTERIOR" src="IMAGENES/PREV.GIF" > 
		</td>
		<td>
			<IMG style= "CURSOR: hand" 
			onclick =retrocede() alt="REGISTRO ANTERIOR" src="imagenes/arriba.gif" > 
		</td>
		<td >
			<IMG style="CURSOR: hand" 
			onclick =avanza()  alt="REGISTRO SIGUIENTE" src="imagenes/abajo.gif" > 
		</td>
		<td>
			<IMG style="CURSOR: hand" 
			onclick ="pagina('<%=urlBase%>'+'?pos=')" 
				alt="PAGINA SIGUIENTE" src="imagenes/next.gif" > 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<IMG id= IMG1 style ="CURSOR: hand" 
			onclick ="ultima(' <%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" 
			alt="ULTIMA PAGINA" src="imagenes/ultima.gif" > 
		</td>
		<td > 
		<IMG style="CURSOR: hand"
			 
			onclick=BUSCAR() alt=BUSCAR src="imagenes/SEARCH.gif" > 
	</td>		
	<td>		
		<IMG style="CURSOR: hand"
			 onclick ="javascript: window.open('REPORTES/prnMENU.ASP')" 
			 alt=IMPRESION src="imagenes/PRINT.gif" >	
	</td>		
		
			
	</tr>
</table>
<%END IF %>

<TABLE	 WIDTH="100%" BORDER=0
		 
		ID=DATAENTRY NAME="DATAENTRY" STYLE="DISPLAY: none">
<TR>
          
            <td WIDTH="10%" BGCOLOR=#c5d6d9 align= right>
             <font face=arial size=1 color=midnightblue ><B> 
              CODIGO:</B></font> 
            </td>
            <td BGCOLOR=white WIDTH="5%" valign=center colspan=3 >
            <INPUT class=DATOSGRANDE id=COD NAME = COD	DISABLED valign ="middle"> 
            </td>
            <td WIDTH="10%" BGCOLOR=#c5d6d9 align= right>
             <font face=arial size=1 color=midnightblue ><B> 
              TITULO:</B></font> 
            </td>
            <td BGCOLOR=white WIDTH="15%" valign=center colspan=3 >
            <INPUT class=DATOSGRANDE id=MEN NAME = MEN	 
            valign  ="middle" MAXLENGTH=100> 
            </td>
            
            <td WIDTH="10%" BGCOLOR=#c5d6d9 align= right>
             <font face=arial size=1 color=midnightblue ><B> 
              PROGRAMA:</B></font> 
            </td>
            
            <td BGCOLOR=white WIDTH="15%" valign=center colspan=3 >
            <INPUT class=DATOSGRANDE id=PRG NAME = PRG	DISABLED 
            valign  ="middle"> 
            <INPUT class=DATOSGRANDE id=CHK NAME = CHK
            VALUE = 0 TYPE = HIDDEN> 
            </td>
  	  </TR></TABLE>
           


<table border=0 align=center  cellspacing=3>
<tr>
	
	<td>
		<IMG style="CURSOR:  hand" onclick =NUEVO_onclick() 
		alt="REGISTRO EN BLANCO" src="imagenes/NEW.gif" >	
	</td>
	<td>		
		<IMG style="CURSOR: hand" onclick=GRABAR() 
		alt=GRABAR src="imagenes/DISK.gif" >	
	</td>	
	<td>		
		<IMG style="CURSOR: hand" onclick =elimina() 
		alt="ELIMIAR REGISTRO" src="imagenes/DELETE.gif" >	
	</td>		
</tr>
</table></TR></TD></TABLE>
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
	
	
	

<script>


function BUSCAR() 
	//	&& operador "AND"
	//  || operador "OR"
{	niv =('<%=nivel%>')
	if (niv == 1)
	{	pagesize = '15'; }
	else 
	{pagesize = 16 ;}
	var cad = 'comun/buscacodigo.asp?pagesize='+ pagesize ;
	cad = cad + '&tbl=MENU'
	cad = cad + '&pk=MENU'
	cad =  cad +'&url=../MANTMENU.asp?pos='
	var opc = "directories=no,height=100," ;
	opc =  opc +"hotkeys=no,location=no," ;
	opc =  opc +"menubar=no,resizable=no," ;
	opc =   opc+"left=200,top=200,scrollbars=yes," ;
	opc =   opc+"status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=200";
	
	
	//ealert(cad)
	window.open(cad,'BUSCA_CODIGO',opc)
}
</script>
</FORM>
</BODY>
</HTML>
