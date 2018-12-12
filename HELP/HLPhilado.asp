<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") 
	pos = Request.QueryString("pos")%>
	
<%	Dim	ALIAS
		alias = "HILAdO"
	Dim indice
		indice = "HILO"
	Dim TITULO
		TITULO = "MAESTRO DE HILOS"
%>
<script language="jscript" type="text/jscript">
var pos = '<%=pos%>';
function ACTUALIZA(cod,cad,TIT, op)
{	eval("window.opener.window.thisForm.TEL.value = cod");
	eval("window.opener.window.document.all.DES.value = cad");
	window.close();
}
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad = t.rows(pos).cells(0).innerText;
	var a = trim(cad);
	var kad = t.rows(pos).cells(1).innerText;
	var TIT = trim(t.rows(pos).cells(2).innerText);
	kad = ltrim(kad);
	ACTUALIZA(a,kad,TIT,pos);
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
		" HILO,  DESCRIPCION, TITULO," & _		
		" FECHA, USUARIO, ESTADO " & _ 
		" from "&ALIAS&" " & _
		" where " & _
		" ESTADO = 'A' " & _ 
		" ORDER BY DESCRIPCION  " 
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
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" onclick="javascript: window.close();">
		</td>
		<td align="center"><font face="arial" size="2" color="DarkBlue"><b><%=titulo%></b></font></td>
        </tr>
	</tr>
	<tr><td colspan="3"><HR></td></tr>
</table>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%for I=0 to 2 %>
	<td align="center" >
		<font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(I).NAME%></b></font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd2('<%=(cont)%>')"  id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="REDIR('<%=(cont)%>')">       
	
</tr>	  
<%cont =  cont  +1 %>
<%DO WHILE NOT RS.EOF%>

    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd2('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="REDIR('<%=(cont)%>')">       
	<%for i=0 to 2%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=RS.FIELDS.ITEM(I)%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>
<%end if%>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script>
dd2('2');
</script>    
</form>
</BODY>
</HTML>
