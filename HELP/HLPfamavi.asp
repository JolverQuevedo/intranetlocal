<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	TIP			= Request.QueryString("TIP")
	op			= Request.QueryString("op")
		
	pos = ""
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT FAMAVIOS.CODIGO as COD,	  " & _
		" FAMAVIOS.DESCRIPCION, PORMER AS MER " & _		
		" from famavios				  " & _
		" where FAMAVIOS.ESTADO = 'A' " & _ 
		" ORDER BY DESCRIPCION  	  "	 

	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="../ESTILOS1.CSS" >
<script language="javascript">
function redir(fam)
{	var t = document.all.TABLA;
	ubi =parseInt('<%=request.QueryString("ubi")%>',10)
	cad ='hlpDESAVI.asp?pos='+ trim(t.rows(oldrow).cells(0).innerText) + '&tit='+ltrim(t.rows(oldrow).cells(1).innerText) 
	cad += '&ubi=' + ubi
	mer = t.rows(oldrow).cells(2).innerText 
	eval("window.opener.document.all.MRR"+ubi+".value=mer")
	window.location.replace(cad)	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function ACHICA()
{	window.resizeTo(400,600)
	}
</script>
</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 text="#000000" onLoad="ACHICA()" >
<form name="thisForm" METHOD="post" >
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=25%>
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align= CENTER>
			<font face=arial size= 2 color=DarkBlue><B>
			FAMILIAS DE AVIO
			</b></font>
		</td>
        </TR>
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>"   bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 2 %>
		<TD align="center" class="AMERICANwhite" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
</TR>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    <%for i=0 to 2%>
		    <td class="texto" align="center"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
	      <%NEXT%>	
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
    </table>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="javascript">
dd2('1');
</script>    
</form>
</BODY>
</HTML>