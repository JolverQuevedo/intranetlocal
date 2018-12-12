<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	HLP= request.QueryString("HLP")
ubi = request.QueryString("ubi")

CAD =	" SELECT FAMTELA AS COD," & _
		"  DESCRIPCION 			" & _
		" FROM famtelas 		" & _
		" WHERE ESTADO = 'A' 	" & _ 
		" ORDER BY descripcion  " 
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF
'Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
<script>
HLP = parseInt('<%=HLP%>',10)
UBI = parseInt('<%=UBI%>',10)
function redir(pos)
{	var pos = parseInt(pos,10)
	var t = document.all.TABLA;
	fam = t.rows(pos).cells(0).innerText ;
	if (isNaN(HLP) == false )
		window.location.replace('hlpTELAS.asp?pos='+ trim(fam)+'&HLP='+HLP+'&UBI='+UBI);
	else
		window.location.replace('hlpDESTELAS.asp?pos='+ trim(fam));
}
function dd2(ff)
{
	dd(ff);
}
</script>
<script language="javascript" src="../INCLUDES/funcionescomunes.js"></script>
<form name="thisForm" METHOD="post" >

<table width="100%">
	<tr>
		<td align="left" width="35%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" alt="" 
            onclick="window.close();" /></td>
		<td align="center" class="talasblue">FAMILIAS DE TELA</td>
		<td align="right" width="35%"><img src="../imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center"  bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >

    <%'LINEA DE CABECERA STANDAR %>
    <%	lIMITE =  COLUMNAS-1%>
    <tr bgcolor='<%=Application("Titulo")%>' >
        <%for I=0 to LIMITE %>  
	        <td align="center" class="AMERICANwhite"><%=RS.FIELDS(I).NAME%></td>
        <%next%>	
    </tr>
    <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    <%for i=0 to LIMITE%>
		    <td class="texto"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
	      <%NEXT%>	
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
</table>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="javascript">
dd2('1');


</script>    
</form>
</BODY>
</HTML>