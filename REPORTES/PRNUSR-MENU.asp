<%@ Language=VBScript %>
<%	NIVEL = Request.Cookies("Usuario")("Perfil")%>

<HTML>

<!--#include file="../includes/Cnn.inc"-->

<%CAD =	" SELECT USUARIOS.USUARIO, USUARIOS.NOMBRES, " & _
		" MENU.DESMENU, SUBMENU.DESCRIPCION,  " & _
		" (CASE [USR-OPC].PERFIL WHEN '1' THEN  " & _
		" 'REGISTRO' ELSE 'CONSULTA' " & _
		" END) AS PERFIL " & _
		" FROM SUBMENU INNER JOIN " & _
		" MENU ON SUBMENU.MENU = MENU.MENU INNER JOIN " & _
		" [USR-OPC] ON SUBMENU.MENU = [USR-OPC].MENU AND  " & _
		" SUBMENU.SUBMENU = [USR-OPC].SUBMENU INNER JOIN " & _
		" USUARIOS ON  " & _
		" [USR-OPC].USUARIO = USUARIOS.USUARIO " & _
		" ORDER BY USUARIOS.USUARIO, MENU.MENU,  " & _
		" CONVERT(INT,  SUBMENU.SUBMENU) " 
		RS.OPEN CAD ,Cnn
		Response.Write(CAD)
	'Response.end
If rs.eof or rs.bof then
	Response.Write("Usuarios sin opciones")		
	Response.End
end if	
rs.movefirst
titulo = "Opciones por Usuario"
%>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%do while not rs.eof%>
	<table WIDTH=100%>
		<tr>
			<td align= CENTER>
				<font face=arial size= 3 color=DarkBlue><B>
				<%=titulo%> - Usuario : <%=rs("NOMBRES")%>
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
	<%usr = rs("usuario")%>	 
	<%do while not rs.eof and trim(usr) = trim(rs("usuario"))%>
		<TABLE ID="TABLA" ALIGN="CENTER" cols= width=100%
			 cellpadding=1  cellspacing=1 bordercolor=navy
			 border=1>
		<TR >
			<TD WIDTH=15%>
				<FONT face=arial COLOR=NAVY SIZE=1><B>
				MENU : </B>
				</FONT>
			</TD>
			<TD bgcolor=navy WIDTH=85% colspan=2>
				<FONT face=arial COLOR=ivory SIZE=1><B>
				<%=UCASE(RS("desmenu"))%></B>
				</FONT>
			</TD>
		</tr>
		<tr bgcolor=#ccffcc>
			<td>
            <FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>Nº</B>
				</FONT>
			</td>
			<TD>
				<FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>OPCION</B>
				</FONT>
			</TD>
			<TD>
				<FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>NIVEL DE ACCESO</B>
				</FONT>
			</TD>
		</TR>
		<%MENU = RS("desMENU")%>
		<%CONT = 1%>
		
		<%do while not rs.eof and trim(rs("usuario"))= trim(usr) and trim(rs("desmenu"))=trim(menU)%>
		<tr>
			<td align=center>
				<%=cont%>
			</td>
			<TD>
				<FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>&nbsp;<%=RS("descripcion")%></B>
				</FONT>
			</TD>
			<TD>
				<FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>&nbsp;<%=RS("perfil")%></B>
				</FONT>
			</TD>
		</TR>
		 <%RS.MOVENEXT%>
		 <%'Response.end%>
		 <%CONT = CONT + 1%>
		  <%if rs.eof then%>
			<%exit do%>
		 <%end if %>		
		 <%loop%>
	
	 <%if rs.eof then%>
			<%exit do%>
		 <%end if %>		 

	<%loop%>
	
		 <%if rs.eof then%>
			<%exit do%>
		 <%end if %>

<p style="page-break-before:always">
<%loop%>	
</TABLE>






</BODY>
</HTML>
