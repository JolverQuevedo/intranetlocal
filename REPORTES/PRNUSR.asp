<%@ Language=VBScript %>
<%	NIVEL = Request.Cookies("Usuario")("Perfil")%>

<HTML>
<!--#include file="../../_ScriptLibrary/pm.asp"-->
<!--#include file="../includes/Cnn.inc"-->

<%CAD =	" SELECT  " & _
		" * " & _
		" from USUARIOS " & _
		" ORDER BY [usuario] " 
		RS.OPEN CAD ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Tabla de Usuarios Vacía")		
	Response.End
end if	
	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
rs.movefirst
%>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<table WIDTH=100%>
	<tr>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			Tabla de Usuarios
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
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=0  cellspacing=0 bordercolor=WHITE
	 border=0 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<TR bgcolor=navy>

	<%for I=0 to LIMITE %>
		<TD  >
			<FONT face=arial COLOR=ivory SIZE=1>
			<B><%=trim(RS.FIELDS(I).NAME)%>&nbsp;</B>
			</FONT>
		</TD>
	<%next%>	

</tr>
<%do while not rs.eof%>
<tr>
		<%FOR i=0 TO limite%>
			<TD >
				<FONT face=arial COLOR=MidnightBlue SIZE=1>
				<B>&nbsp;<%=RS.FIELDS.ITEM(I)%></B>&nbsp;
				</FONT>
			</TD>
		<%NEXT%>

	</TR>
	<TR>
		<TD COLSPAN = <%=LIMITE+1%> HEIGHT=1>
			<HR color=DarkBlue size=1>
		</TD>
	</TR>
	 <%RS.MOVENEXT%>
	 <%if rs.eof then%>
		<%exit do%>
	 <%end if %>
   <%CONT = CONT + 1%>
   <%if  cont mod 30 = 0 then%>	
	<TR>
	<TD COLSPAN = <%=LIMITE+1%>>
	<p style="page-break-before:always">
	<table WIDTH=100%>
	<tr>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			Tabla de Usuarios
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
	
	
	</TD>
	</TR>
	<TR bgcolor=navy>

	<%for I=0 to LIMITE %>
		<TD align="center" >
			<FONT face=arial COLOR=ivory SIZE=1>
			<B>
			<%=RS.FIELDS(I).NAME%></B>
			</FONT>
		</TD>
	<%next%>	

</tr>
<%end if %>
 
<%loop%>
</TABLE>







</BODY>
</HTML>
