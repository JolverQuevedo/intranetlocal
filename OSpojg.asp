<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="includes/Cnn.inc"-->
<%	pos			= Request.QueryString("pos")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" exec FICHAposdeta '"&pos&"'	"
   ' RESPONSE.WRITE(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST
	
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count %>

<form name="thisForm" METHOD="post" >

<table id="TABLA" class="colores" align="center"  bordercolor="<%=application("color2")%>"   bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
    <td align="center" class="AMERICANwhite" width="1%">Chk</td>
	<td align="center" class="AMERICANwhite" width="1%">PO</td>
	<td align="center" class="AMERICANwhite" width="1%">COLOR</td>
    <td align="center" class="AMERICANwhite" width="1%" style="display:none">UBI</td>
    <td align="center" class="AMERICANwhite" width="1%">TOT</td>
    <td align="center" class="AMERICANwhite" width="1%">QTY</td>
    
</TR>  
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%total=0 %>
    <%DO WHILE NOT RS.EOF%>
    <tr  id="fila<%=Trim(Cstr(cont))%>" class="descriptores">
        <td class="texto" align="center"><input class="chk" type="checkbox" id="chk<%=cont%>"></td>
        <td class="texto po" align="center"><%=RS("PO")%></td>
        <td class="texto color" align="left"><%=RS("COLOR")%></td>
        <td class="texto ubi" align="center" style="display:none"><%=RS("UBI")%></td>
        
        <%tot = cdbl(rs("can0"))+ cdbl(rs("can1"))+ cdbl(rs("can2"))+ cdbl(rs("can3")) + cdbl(rs("can4"))+ cdbl(rs("can5"))+ cdbl(rs("can6"))+ cdbl(rs("can7"))+ cdbl(rs("can8"))+ cdbl(rs("can9"))%>
	    <td class="texto" align="right"><%=tot%></td>
        <td class="texto" align="right">
            <input id="qt<%=cont%>"  value="<%=tot%>" class="tot" onchange="cambia()"/>
        </td>
        <%total = total + tot %>
        <%RS.MOVENEXT%>
    </tr>
	<%cont=cont+1%>
	<%loop%>
    <tr>
        <td colspan="3">Cantidad</td>
        <td class="texto" align="right"><input id="total" value="<%=total%>" /></td>
        <td style="display:none"><input id="maxi" value ='<%=cont-1%>' /></td>
    </tr>
    </table>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
