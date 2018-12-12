<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	UBI	= Request.QueryString("UBI")
	tit	= Request.QueryString("tit")
		
	pos = Request.QueryString("pos")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT codigo as COD,	" & _ 
		" DESCRIPCION AS DES,  	" & _
		" CODUNI AS UNI, DESUNI " & _
		" AS DUNI, CODMON AS 	" & _
		" MON, DESMON AS DMON,	" & _
		" CODEXP AS CODEXP, DESEXP " & _
		" AS DEXPLOSION, CODTIP AS 	" & _
		" AREA,destip as Darea	" & _
		" from VIEW_AVIOS		" & _
		" where EDO = 'A' 		" & _ 
		" and codfam= '"&pos&"' " & _
		" ORDER BY DESCRIPCION  "	 

	RS.Open CAD, Cnn
	CONT = 1
	IF rs.recordcount > 0 THEN
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
ubi = parseInt('<%=ubi%>',10)
function redir(fam)
{	var t = document.all.TABLA;
	ubi =parseInt('<%=request.QueryString("ubi")%>',10)
	mer = t.rows(oldrow).cells(2).innerText 
	eval("window.opener.document.all.AVI"+ubi+".value=t.rows(oldrow).cells(0).innerText")
	eval("window.opener.document.all.DES"+ubi+".value=t.rows(oldrow).cells(1).innerText")
	eval("window.opener.document.all.TPP"+ubi+".value=t.rows(oldrow).cells(8).innerText")
	eval("window.opener.document.all.DTP"+ubi+".value=t.rows(oldrow).cells(9).innerText")
	eval("window.opener.document.all.EXX"+ubi+".value=t.rows(oldrow).cells(6).innerText")
	eval("window.opener.document.all.DEX"+ubi+".value=t.rows(oldrow).cells(7).innerText")
	eval("window.opener.document.all.UNI"+ubi+".value=t.rows(oldrow).cells(2).innerText")
	
	window.close()	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function ACHICA()
{	window.resizeTo(800,600)
	}
</script>
</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 text="#000000" onLoad="ACHICA()" >
<form name="thisForm" METHOD="post" >
<table WIDTH=100%>
	<tr>
		<td align= "left" WIDTH="25%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align= "CENTER">
			<font face=arial size= 2 color=DarkBlue><B>
			FAMILIAS DE AVIO
			</b></font>
		</td>
        <td align="right" WIDTH=25%>
			<img src="../imagenes/ATRAS.gif" style="cursor:hand;" 
			onclick="javascript: window.location.replace('HLPFAMAVI.asp?ubi='+ubi);">
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
	'**************************%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO rs.fields.count-1 %>
		<TD align="center" class="AMERICANwhite" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
</TR>
<%	
'*****************************
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')">       
	    <%for i=0 to rs.fields.count-1%>
		    <td class="texto" align="center"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
	      <%NEXT%>	
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>

    <%end if%>
    </table>

<script language="javascript">
rr = parseInt('<%=rs.recordcount%>',10)
if (rr > 0)
dd2('1');
else
{	document.writeln("<font color=red>NO HAY AVIOS PARA ESTA FAMILIA")
}
</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>