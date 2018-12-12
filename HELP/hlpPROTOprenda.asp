<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
	CLI = Request.QueryString("CLI")
%>
<SCRIPT>
	var aCod = Array()
	var aDat = Array()
</SCRIPT>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->


<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
function ACTUALIZA(cod,des)
{	
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
	window.opener.window.thisForm.PROTO.value	=  trim(t.rows(pos).cells(0).innerText);
	window.opener.window.thisForm.VERSION.value	=  trim(t.rows(pos).cells(1).innerText);
	window.opener.window.thisForm.PRO.value		=  trim(t.rows(pos).cells(0).innerText);
	window.opener.window.thisForm.VER.value		=  trim(t.rows(pos).cells(1).innerText);
	window.close();
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD = " SELECT ZONA FROM EMPRESAS WHERE CLIENTE = '"&CLI&"' "
RS.OPEN CAD,CNN
ZONA = RS("ZONA")
'RESPONSE.WRITE(ZONA)
'RESPONSE.END
RS.CLOSE
CAD =	" SELECT PP.PROTO, "
IF TRIM(ZONA)="PER" THEN 
CAD = CAD & "  PP.VERSION AS VER, EM.NOMBRE AS CLIENTE, PP.DESCRIPCION AS DESCRIPCION "&_
" FROM PROTOS PP " &_
" INNER JOIN EMPRESAS EM ON PP.CLIENTE = EM.CLIENTE WHERE (PP.ESTADO = 'A') AND (PP.CLIENTE = '"&CLI&"') "&_
"ORDER BY PP.PROTO "
ELSE
CAD = CAD & " MAX(PP.VERSION) AS VER,					" & _
	    " EM.NOMBRE AS CLIENTE,										" & _ 
	    " PP.DESCRIPCION AS DESCRIPCION								" & _
		" FROM PROTOS PP											" & _
		" INNER JOIN EMPRESAS EM ON PP.CLIENTE = EM.CLIENTE			" & _
		" WHERE (PP.ESTADO = 'A') AND (PP.CLIENTE = '"&CLI&"')		" & _
		" GROUP BY PP.PROTO, EM.NOMBRE, PP.DESCRIPCION				" & _
		" ORDER BY PP.PROTO " 
END IF

		'Response.Write(cad)
		'RESPONSE.END
%>
<%	RS.Open CAD, Cnn
	CONT = 1%>
	
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">
<%IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST%>
		<%columnas = rs.Fields.Count%>
	<%ELSE%>
		<center>
		<font color = red size=4 face =arial>
		Lo siento... No tenemos registrados PROTOS para este cliente
		<%Response.End%>		
<%	END IF %>



<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
			
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			Protos de <%=rs("cliente")%>
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

<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%for I=0 to columnas-1 %>
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

	<%FOR i=0 TO columnas -1%>
		<TD valign=top>
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
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
	
</form>
<script>
dd2('1')
</script>

</BODY>
</HTML>
