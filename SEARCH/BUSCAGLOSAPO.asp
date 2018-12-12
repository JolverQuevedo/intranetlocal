<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	ano			= Request.QueryString("ano") 
	d1			= Request.QueryString("d1")
    d2			= Request.QueryString("d2") 
    d3			= Request.QueryString("d3") 
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
     cad = "exec [BUSCA_GLOSA_PO] '"&ano&"', '"&d1&"', '"&d2&"', '"&d3&"'" 
    '   RESPONSE.Write(CAD)
       ' RESPONSE.END
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
<script language="javascript" type="text/jscript">
oldrow=1

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

</script>
</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 text="#000000">

<iframe  width="100%" style="display:block;" src="DATOSGLOSA.asp" id="body10" name="body10" scrolling="no" frameborder="0" height="100px"></iframe>
<form name="thisForm" METHOD="post" >

<hr />
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 4 %>
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >       
	    
		 <td class="texto" align="left" width="25%"><%=trim(RS.FIELDS.ITEM(0))%>&nbsp;</td>
         <td class="texto" align="left" width="8%"><%=trim(RS.FIELDS.ITEM(1))%>&nbsp;</td>
	     <td class="texto" align="left" width="20%"><%=trim(RS.FIELDS.ITEM(2))%>&nbsp;</td>
         <td class="texto" align="left" width="45%"><%=trim(RS.FIELDS.ITEM(3))%>&nbsp;</td>
         <td class="texto" align="left" width="2%"><%=trim(RS.FIELDS.ITEM(4))%>&nbsp;</td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
    </table>

<script language="javascript">
red ='<%=rs.recordcount %>'
if (parseInt(red,10) > 0)
dd2('1');
</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>