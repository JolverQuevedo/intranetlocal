<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	pos = request.QueryString("pos")
CAD =	" SELECT tela AS COD,		        " & _
		" DESCRIPCION, ENCABI1 as EAL1,     " & _
		" ENCLAR1 as ELL1, REVIRADO as      " & _
		" REV, PESOACA as DDL, ANCHTUB as   " & _
		" AT, ANCHABI as AA                 " & _
		" FROM TELAS	    			    " & _
		" WHERE ESTADO = 'A'     		    " & _ 
		" AND FAMILIA = '"&POS&"'    	    " & _
		" ORDER BY descripcion  	        " 
		'response.Write(cad)
	RS.Open CAD, Cnn
	
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
function redir(pos)
{	var pos = parseInt(pos,10)
	var t = document.all.TABLA;
	window.opener.window.document.all.thisForm.TEL.value  = ltrim(t.rows(pos).cells(0).innerText) ;
	window.opener.window.document.all.thisForm.DES.value  = ltrim(t.rows(pos).cells(1).innerText) ;
	window.opener.window.document.all.thisForm.ELL1.value = ltrim(t.rows(pos).cells(3).innerText) ;
	window.opener.window.document.all.thisForm.EAL1.value = ltrim(t.rows(pos).cells(2).innerText) ;
	window.opener.window.document.all.thisForm.REV.value  = ltrim(t.rows(pos).cells(4).innerText) ;
	window.opener.window.document.all.thisForm.DDL.value  = ltrim(t.rows(pos).cells(5).innerText) ;
	window.opener.window.document.all.thisForm.AT.value   = ltrim(t.rows(pos).cells(6).innerText) ;
	window.opener.window.document.all.thisForm.AA.value   = ltrim(t.rows(pos).cells(7).innerText) ;
	window.close();	
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
			<img src="../imagenes/atras.gif" style="cursor:hand;" alt="" 
            onclick="javascript: window.location.replace('hlpfamtelas.asp');" /></td>
		<td align="center" class="talasblue">TELAS</td>
		<td align="right" width="35%"><img src="../imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
    <%	IF NOT RS.EOF OR NOT RS.BOF THEN
			RS.MOVEFIRST
		else
			response.write("Tabla sin Datos")	
			response.end
		END IF
	CONT = 1
	'LINEA DE CABECERA STANDAR %>
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
	            end IF%>" onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
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