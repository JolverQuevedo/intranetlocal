<%@ Language=VBScript %>
<%	NIVEL = Request.Cookies("Usuario")("Perfil")%>

<HTML>

<!--#include file="../includes/Cnn.inc"-->
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%
CLI= REQUEST.QueryString("CLI")
CAD =	" SELECT  CLI+' - ' + NOM AS CLIENTE, PO, OFI,  " & _
        " COTI, NOMBRE AS DESTINO, EMB AS F_EMB,        " & _
        " TIP+' - ' + DESCRIPCION AS  T_EMB, CAN ,      " & _
        " FOT, CON, CODEST   FROM VIEW_POS              " & _
		" where CLI= '"&CLI&"' ORDER BY PO              " 
		RS.OPEN CAD ,Cnn
	'response.Write (cad	)
If rs.eof or rs.bof then
	Response.Write("NO HAY POS PARA ESTA CLIENTE")		
	Response.End
end if	
LIMITE =  rs.fields.count - 4
rs.movefirst
%>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<table WIDTH=100%>
	<tr>
		<td CLASS="talasblue">POS POR CLIENTE</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="../imagenes/logo.GIF"  >
		  </TD>
	</tr>
	<TR>
	<td COLSPAN=3><HR></td>
	</TR>
</table>
 <table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
          
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%cont = 0%>
<TR class="titulito">
	<%for I=0 to LIMITE %>
		<TD><%=RS.FIELDS(I).NAME%></TD>
	<%next%>	
    <TD>FOTO</TD>
</tr>
  <TR><TD COLSPAN = <%=LIMITE+2%>><HR></TD></TR>
<%do while not rs.eof%>
<tr class="DESCRIPTORES">
		<%FOR i=0 TO LIMITE-1%>
			<TD ><%=RS.FIELDS.ITEM(I)%>&nbsp;</TD>
		<%NEXT%>
        <TD ><%=FORMATNUMBER(RS.FIELDS.ITEM(I),0,,,TRUE)%>&nbsp;</TD>
        <td><img src="../BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=CLI%>" width="30" /></td> 
	</TR>
	<TR><TD COLSPAN = <%=LIMITE+2%>><HR></TD></TR>
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
		        <td CLASS="talasblue">POS POR CLIENTE</td>
		        <TD ALIGN=right WIDTH=35%><img src="../imagenes/logo.GIF"></TD>
	        </tr>
	        <TR><td COLSPAN=3><HR></td></TR>
        </table>
	</TD>
	</TR>
<TR class="titulito">
	<%for I=0 to LIMITE %>
		<TD><%=RS.FIELDS(I).NAME%></TD>
	<%next%>	
    <TD>FOTO</TD>
</tr>
<%end if %>
 
<%loop%>
</TABLE>


</BODY>
</HTML>
