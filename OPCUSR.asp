<%@ Language=VBScript %>
<%	NIVEL = Request.Cookies("Usuario")("Perfil")%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" >
<HTML>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<%POS = Request.QueryString("pos")
usr = Request.QueryString("usr")
if pos = "" or isnull(pos)  or pos = " " then 	pos = ""
if usr = "" or isnull(usr)  or usr = " " then 	usr = ""

CAD =	" SELECT DISTINCT T1.SUBMENU AS ID, T1.DESCRIPCION,	" & _ 
		" PERFIL = (SELECT PERFIL FROM [USR-OPC] T3	        " & _
		" WHERE USUARIO = '"&USR&"'AND T3.MENU=T1.MENU		" & _
		" AND T3.SUBMENU = T1.SUBMENU)					    " & _
		" FROM         SUBMENU T1, [USR-OPC] T2				" & _
		" WHERE   (T1.MENU = '"&POS&"')						" & _
		" ORDER BY T1.DESCRIPCION							" 
'Response.Write(CAD)	
'Response.END		
	RS.OPEN CAD ,Cnn
    CONT = 0
If rs.recordcount>0  then 
    rs.movefirst
ELSE
    RS.CLOSE
    CAD =   " SELECT DISTINCT T1.SUBMENU AS ID, " & _
            " T1.DESCRIPCION, '' AS PERFIL      " & _
            " FROM         SUBMENU T1			" & _
		    " WHERE   (T1.MENU = '"&POS&"')		" & _
		    " ORDER BY T1.DESCRIPCION			" 
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT > 0 THEN     RS.MOVEFIRST
END IF 


%>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY TOPMARGIN=0>

<TABLE ID="TABLA" ALIGN="center" cols=2 width="100%"
	 cellpadding=0  cellspacing=0 bordercolor=white
	  bgcolor=white border=1  bordercolordark=gainsboro>
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<TR bgcolor=#006699>
	<TD STYLE="DISPLAY:block" >&nbsp;</TD>
	<%for I=1 to RS.FIELDS.COUNT - 1 %>
		<TD  >
			<FONT face=arial COLOR=ivory SIZE=1>
			<B><%=trim(RS.FIELDS(I).NAME)%>&nbsp;</B>
			</FONT>
		</TD>
	<%next%>	

</tr>
<%do while not rs.eof%>
<tr align="LEFT"  <% IF CONT mod 2  = 0 THEN %> bgcolor=#f8fefb  <%ELSE%> bgcolor=#c5d6d9 <%end IF%> 	>
	<TD STYLE="DISPLAY:block" width=5% align="center">
	<INPUT  id='<%=RS("ID")%>' VALUE='<%=RS("ID")%>' class="BARRA33" readonly tabindex=-1 ></TD>
	<TD WIDTH=50% ><SPAN class="BARRA33"><%=RS("DESCRIPCION")%></SPAN></TD>
		
		
		<TD WIDTH=20%>
			<select  class = datos ID='PER<%=RS("ID")%>' onchange="actualiza(this.value, '<%=RS("ID")%>')" >
				<OPTION VALUE= 0></OPTION>
				<option value = 1 <%IF RS("PERFIL") = 1 THEN %>SELECTED <%END IF%>>UPDATER</option>
				<option value = 2 <%IF RS("PERFIL") = 2 THEN %>SELECTED <%END IF%>>READONLY</option>
				<option value = 3 <%IF RS("PERFIL") = 3 THEN %>SELECTED <%END IF%>>WEB</option>
			</select>
		</TD>	
	</TR>
	 <%RS.MOVENEXT%>
     <%CONT = CONT + 1 %>
<%loop%>
</TABLE>

<script>

function actualiza(opc,sub)
{	menu= trim('<%=pos%>')
	usr=  trim('<%=usr%>')
	cad  = 'comun/updateusropc.asp?menu='+menu
	cad += '&sub=' + trim(sub)
	cad += '&usr=' + usr
	cad += '&opc=' + opc
	top.window.frames[1].location.replace(cad)
}
</script>





</BODY>
</HTML>
