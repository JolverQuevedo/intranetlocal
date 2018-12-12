<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	marca = Request.QueryString("marca")
	pos = Request.QueryString("pos")
%>
<script>
marca = '<%=marca%>'
if (isNaN(marca))
marca = null
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function REDIR2()
{	var t = document.all.TABLA;

	ubi = parseInt(eval("window.opener.window.thisForm.MARCADOR.value"),10)
	tope =parseInt(eval("window.opener.window.thisForm.TOPE.value"),10)
for (pos=0; pos<t.rows.length-1; pos++)
{	if (eval("document.all.fila"+(pos+1)+".style.backgroundColor")=='#99cc99')
	{	var cad = t.rows(pos+1).cells(0).innerText;
		var a = trim(cad);
		var b = trim(t.rows(pos+1).cells(2).innerText);
		var kad = t.rows(pos+1).cells(1).innerText;
		kad = ltrim(kad);
		if (ubi<tope)
		{	eval('window.opener.window.thisForm.COL'+ubi+'.value = cad');
			eval('window.opener.window.thisForm.DESCOL'+ubi+'.value = kad');
			eval("window.opener.window.document.all.fila"+(ubi)+".style.display='block'");
			eval("window.opener.window.document.thisForm.pasacolor.value += (cad + ' ')")
		}
		else
		{	alert("sobrepasó el límite de colores por bloque")
			break;
		}
		ubi++
		eval("window.opener.window.thisForm.MARCADOR.value++")
	}	
}	
	window.close();
}

function REDIR(_val)
{	
	
	var t = document.all.TABLA;
	ubi = parseInt(eval("window.opener.window.thisForm.MARCADOR.value"),10)
	tope =parseInt(eval("window.opener.window.thisForm.TOPE.value"),10)
	var cad = t.rows(parseInt(_val)).cells(0).innerText;
	var a = trim(cad);
	var b = trim(t.rows(parseInt(_val)).cells(2).innerText);
	var kad = t.rows(parseInt(_val)).cells(1).innerText;
	kad = ltrim(kad);
	eval('window.opener.window.thisForm.COL'+ubi+'.value = cad');
	eval('window.opener.window.thisForm.DESCOL'+ubi+'.value = kad');
	eval("window.opener.window.document.all.fila"+(ubi)+".style.display='block'");
	eval("window.opener.window.document.thisForm.pasacolor.value += (cad + ' ')")
	ubi++
	eval("window.opener.window.thisForm.MARCADOR.value++")
	window.close();
}
</script>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNmulti.ASP"-->
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000" >
<%
CLI = Request.QueryString("CLI")
DCL = Request.QueryString("DCL")
tem = Request.QueryString("tem")
car = Request.QueryString("car")
marca = Request.QueryString("marca")%>
<%	CCC = trim(Request.querystring("CCC"))
CCC= REPLACE(CCC," ", "','")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  CODIGO, DESCRIPCION " & _
		" from COLORES" & _
		" where   " & _
		" CODIGO NOT IN (  '"&CCC&"' ) " & _
		" AND ESTADO = 'A' " & _ 
		" group by CODIGO, DESCRIPCION " & _
		" ORDER BY descripcion  " %>
<%	RS.Open CAD, Cnn
	CONT = 1%>
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			COLORES DE <%=DCL%>
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
		Lo siento... No tenemos COLORES registrados para este cliente
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
<%for I=0 to 2 %>
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

	<%FOR i=0 TO 2%>
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
<center>
<img src= "../imagenes/OK.JPG" ALT="JALA COLORES" onclick="REDIR()" STYLE="CURSOR:HAND"> 
<%end if%>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</BODY>
</HTML>