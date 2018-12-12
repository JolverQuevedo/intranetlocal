<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.QueryString("PERFIL")
	if nivel = "" or isnull(nivel) then
		nivel = txtPerfil
	else
		response.Cookies("Usuario")("Perfil")=nivel
	end if 
	MARCA = 0 
%>
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=0;
var niv = '<%=nivel%>'
</script>
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
Dim pageSize 
if nivel > "1" then
	pageSize = 16
else
	pageSize = 6
end if
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "ESPECIFICACIONES"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "ESPECIFICACION"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "ESPECIFICACIONES.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "HOJAS DE CONSUMO - PROTOTIPOS"
%>
<script>
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

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT	top  "&pageSize&" EE.ESPECIFICACION AS SPEC, " & _
		" PP.PROTO,  " & _
		" PP.VERSION,  " & _
		" EM.NOMBRE 		AS CLIENTE,  " & _
		" PP.DESCRIPCION  	AS DESCRIPCION,  " & _
		" TT.DESCRIPCION  	AS TELA,  " & _
		" GG.DESCRIPCION 	AS GENERO,  " & _
		" TM.DESCRIPCION 	AS TEMPORADA,  " & _
		" TP.DESCRIPCION 	AS TIPOPRENDA,  " & _
		" ES.DESCRIPCION 	AS ESTILO, " & _
		" EE.MINCORTE	    AS STCOR, " & _
		" EE.MINCOSTURA 	AS STCOS, " & _
		" EE.MINACABADO 	AS STACA, " & _
		" EE.EFICORTE       AS EFICOR, " & _
		" EE.EFICOSTURA  	AS EFICOS, " & _
		" EE.EFIACABADO  	AS EFIACA , PP.TIEMPOS AS T, PP.CONSUMO AS C, " & _
		" 'RATIO' = CASE WHEN TALLA0 IS NULL THEN '' ELSE   LTRIM(RTRIM(TALLA0))  END  +  " & _
		" 	   CASE WHEN TALLA1 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA1))  END  +  " & _
		" 	   CASE WHEN TALLA2 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA2))  END  +  " & _
 		" 	   CASE WHEN TALLA3 IS NULL THEN '' ELSE '-'  + LTRIM(RTRIM(TALLA3))  END  +  " & _
		" 	   CASE WHEN TALLA4 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA4))  END  +  " & _
		" 	   CASE WHEN TALLA5 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA5))  END  +  " & _
		" 	   CASE WHEN TALLA6 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA6))  END  +  " & _
		" 	   CASE WHEN TALLA7 IS NULL THEN '' ELSE  '-' + LTRIM(RTRIM(TALLA7))  END  +  " & _
		" 	   CASE WHEN TALLA8 IS NULL THEN '' ELSE '-'  + LTRIM(RTRIM(TALLA8))  END  +  " & _
		" 	   CASE WHEN TALLA9 IS NULL THEN '' ELSE '-'  + LTRIM(RTRIM(TALLA9))  END, " & _
		" 'PROP' =  CASE WHEN PROP0 IS NULL THEN '' ELSE         LTRIM(RTRIM(PROP0)) END  +  " & _
		" 	   CASE WHEN PROP1 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP1))  END +  " & _
	 	" 	   CASE WHEN PROP2 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP2))  END +  " & _
		" 	   CASE WHEN PROP3 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP3))  END +  " & _
		" 	   CASE WHEN PROP4 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP4))  END +  " & _
		" 	   CASE WHEN PROP5 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP5))  END +  " & _
		" 	   CASE WHEN PROP6 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP6))  END +  " & _
		" 	   CASE WHEN PROP7 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP7))  END +  " & _
		" 	   CASE WHEN PROP8 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP8))  END +  " & _
		" 	   CASE WHEN PROP9 IS NULL THEN '' ELSE  '-'  +LTRIM(RTRIM(PROP9))  END    " & _
		" FROM  PROTOS PP " & _
		" 	full OUTER JOIN ESPECIFICACIONES EE	ON EE.PROTO = PP.PROTO AND EE.VERSION = PP.VERSION AND EE.ESPECIFICACION = PP.ESPECIFICACION  " & _
		" 	INNER  JOIN EMPRESAS 		EM 	ON PP.CLIENTE = EM.CLIENTE  " & _
		" 	full outer  JOIN TIPpRENDA 		TP	ON PP.TIPPRENDA = TP.TIPO  " & _
		" 	full outer  JOIN TEMPORADAS 		TM	ON PP.TEMPORADA = TM.CODIGO  AND PP.CLIENTE=TM.CLIENTE " & _
		" 	left outer  JOIN TALLAS 			TL 	ON PP.TALLAS = TL.TALLAS  " & _
		" 	left outer  JOIN PROPORCIONES 	PR 	ON PP.PROPORCION = PR.PROPORCION " & _
 		" 	full outer  JOIN GENEROS 		GG 	ON PP.GENERO = GG.GENERO  " & _
		" 	FULL OUTER  JOIN TELAS 			TT 	ON PP.TELA = TT.TELA  " & _
		" 	FULL OUTER  JOIN ESTILOS 		ES 	ON PP.ESTILO = ES.ESTILO " & _ 
		" WHERE  PP.ESTADO = 'A'  AND " & _
		" (  PP.proto >= '"&POS&"')" & _
		" ORDER BY PP.PROTO, PP.VERSION "
		'Response.Write(CAD)
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/FUNCIONESP.ASP"-->
<%	RS.Open CAD, Cnn
	IF RS.EOF OR RS.BOF THEN%>
		<% MARCA = 1%>
	<%ELSE%>
		<%RS.MOVEFIRST%>
	<%END IF%>
<%	
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<script>
var nume = '<%=columnas-1%>'
</scripT>
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
<%	LIMITE =  rs.fields.count -1
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
<%CONT = 1%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB id="fila<%=Trim(Cstr(cont))%>"
				onclick="dd('<%=(cont)%>')"  
				ondblclick = "ficha('<%=NIVEL%>')">
		<% else %>
			<tr bgcolor=#C5D6D9 id="fila<%=Trim(Cstr(cont))%>"
				onclick="dd('<%=(cont)%>')"  
				ondblclick = "ficha('<%=NIVEL%>')" >
	<%end IF%>
	<TD >
		<FONT face=arial COLOR=MidnightBlue SIZE=1>
		<%if ISNULL(RS.FIELDS.ITEM(0))  or Trim(RS.FIELDS.ITEM(0))="" then%>
			&nbsp;
		<%else%>
			
			<%=RS.FIELDS.ITEM(0)%>
			
		<%END IF%>	
		</FONT>
	</TD>
	<%FOR i=1 TO LIMITE%>
		<TD >
		<FONT face=arial COLOR=MidnightBlue SIZE=1>
		<%if ISNULL(RS.FIELDS.ITEM(I))  or Trim(RS.FIELDS.ITEM(I))="" then%>
			&nbsp;
		<%else%>
			<B>	
			<%=RS.FIELDS.ITEM(I)%>
			</B>
		<%END IF%>	
		</FONT>
	</TD>
	<%NEXT%>

	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </td>
  </tr>
</table>
<%END IF %>

<table border=0 align=center  cellspacing=5>
	<tr>
		<td > 
			<img src="imagenes/primera.gif" style="cursor:hand;"
			onclick="primera('<%=urlBase%>')" 
			ALT="PRIMERA PAGINA">
		</td>
		<td >
			<IMG SRC="IMAGENES/PREV.GIF" ALT="PAGINA ANTERIOR"
				onclick="atras('<%=urlBase%>'+'?pos=')" 
				STYLE="CURSOR:HAND"> 
		</td>
		<td >
			<img src= "imagenes/arriba.gif" ALT="REGISTRO ANTERIOR"
				onclick="retrocede()" STYLE="CURSOR:HAND"> 
		</td>
		<td >
			<img src="imagenes/abajo.gif" ALT="REGISTRO SIGUIENTE"
				onclick="avanza()"  STYLE="CURSOR:HAND"> 
			
		</td>
		<td>
			<img src="imagenes/next.gif" ALT="PAGINA SIGUIENTE"
				onclick="pagina('<%=urlBase%>'+'?pos=')" 
				STYLE="CURSOR:HAND"> 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<img src= "imagenes/ultima.gif" ALT="ULTIMA PAGINA"
			 onclick="ultima('<%=urlBase%>','<%=ALIAS%>','PROTO')" 
			style="cursor:hand;"> 
		</td>
		<td > 
		<IMG SRC="imagenes/SEARCH.gif" ALT="BUSCAR"
			onclick="BUSCA('<%=urlBase%>','PROTOS','PROTO', 'PROTO')" 
			 style="cursor:hand;"> 
	</td>
	<td>		
		<IMG SRC="imagenes/PRINT.gif" ALT="IMPRESION"
			onclick="window.open('fichaproto.asp')" 
			style="cursor:hand;">	
	</td>
	<td>		
		<IMG SRC="imagenes/NEW.gif" ALT="IMPRESION"
			onclick="window.open('fichaPROTO.asp')" 
			style="cursor:hand;">	
	</td>
	</tr>
</table>	
<table border=0 align=center  cellspacing=5>
	<tr>
		<td >
		<font face = arial color=navy size=1>
		Proto a buscar</font>
		</td>
		<td width= 100 STYLE=DISPLAY:NONE>
		<INPUT ID = ESP TYPE =TEXT style="width:100%" maxlength=10>
		</td>
		<td >
		<INPUT ID = "PRO" TYPE ="TEXT" style="width:100%" maxlength=10>
		<INPUT ID = "VER" TYPE ="hidden" style="width:100%" maxlength=10>
		<INPUT ID = "TIME" type="hidden" style="width:100%" maxlength="1">
		</td>
	</tr>
</table>

<br>
<script>
var MARCA 
MARCA = '<%=MARCA%>'
if (MARCA == 0)
dd2('1');
</script>    

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>
