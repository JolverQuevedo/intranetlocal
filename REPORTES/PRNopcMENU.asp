<%@ Language=VBScript %>
<%	NIVEL = Request.Cookies("Usuario")("Perfil")%>

<HTML>

<!--#include file="../includes/Cnn.inc"-->

<%CAD =	" SELECT MENU.DESMENU, MENU.MENU,  " & _
	    " SUBMENU.DESCRIPCION, SUBMENU.SUBMENU, " & _
	    " SUBMENU.PROGRAMA, SUBMENU.PARAMETROS " & _
		" FROM MENU RIGHT OUTER JOIN " & _
	    " SUBMENU ON MENU.MENU = SUBMENU.MENU " & _
		" ORDER BY MENU.MENU, CAST(SUBMENU AS NUMERIC) "
		RS.OPEN CAD ,Cnn
		LIMITE =  rs.fields.count - 1
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
			OPCINES DEL SISTEMA
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
<TABLE ID="TABLA" ALIGN="CENTER"  width=100%
	 cellpadding=1  cellspacing=1 bordercolor=NAVY
	 border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%cont = 0%>
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
<%do while not rs.eof%>
<tr>
	<%FOR i=0 TO LIMITE%>
		<TD <%IF I MOD(2) = 1 THEN%>ALIGN =CENTER<%END IF%>>
			<FONT face=arial 
			<%IF I MOD(2) = 1 THEN%>
				COLOR = RED 
			<%ELSE%>
				COLOR=DarkOliveGreen
			<%END IF%>			
			SIZE=1>
			<B>&nbsp;&nbsp;&nbsp;<%=RS.FIELDS.ITEM(I)%></B>&nbsp;
			</FONT>
		</TD>
	<%NEXT%>
</TR>
	 <%RS.MOVENEXT%>

<%loop%>
</TABLE>







</BODY>
</HTML>
