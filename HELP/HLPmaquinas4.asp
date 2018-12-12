<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") 
	pos = Request.QueryString("pos")%>
	
<%	Dim	ALIAS
		alias = "TEJEDORAS"
	Dim indice
		indice = "CODIGO"
	Dim TITULO
		TITULO = "MAQUINAS DE TEJER"
	Dim largo
		largo = 5 'longitud del código
	Dim largo2 
		largo2 = 100 ' longitud de la descripcion %>
<script language="jscript" type="text/jscript">
var pos = '<%=pos%>';
function ACTUALIZA(cod,cad,TIT)
{	
	eval("window.opener.window.thisForm.M"+pos+".value = trim(cod)");
	eval("window.opener.window.document.all.D"+pos+".classname='textominibb'");
	eval("window.opener.window.document.all.D"+pos+".innerHTML = cad");
	eval("window.opener.window.document.all.T"+pos+".innerHTML = TIT");
	window.close();
}


function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad = t.rows(pos).cells(0).innerText;
	var a = trim(cad);
	var kad = t.rows(pos).cells(1).innerText;
	var TIT = t.rows(pos).cells(2).innerText;
	kad = ltrim(kad);
	ACTUALIZA(a,kad, TIT);
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;	
	dd(ff);
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  " & _
		" HILO,  DESCRIPCION, TITULO " & _		
		" from "&ALIAS&" " & _
		" where " & _
		" ESTADO = 'A' " & _ 
		" ORDER BY "& indice &"  " 
		'Response.Write(CAD)
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
		
<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" 
text="#000000" >
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align="center">
			<font face="arial" size="2" color="#000066"><b>
			<%=titulo%>
			</b></font>
		</td>
        </tr>
	</tr>
	<tr>
	<td colspan="3">
			<HR>
		</td>
	</tr>
</table>

<%'*********************************************************************%>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
	<%for I=0 to 2 %>
        <td align="center">
            <font face="arial" color="IVORY" size="1">
            <b><%=RS.FIELDS(I).NAME%></b></font>
        </td>
    <%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF%>
	
			<tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ondblclick="REDIR('<%=(cont)%>')">
		
	<%FOR i=0 TO 2%>
		<td >
		<font face="Arial, Helvetica, sans-serif" color="#000066" size="1">
		<b><%=RS.FIELDS.ITEM(I)%></b>
		</font>
	</td>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<%end if%>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script type="text/jscript" language="jscript">
dd2('1');
</script>    
</form>
</body>
</html>
