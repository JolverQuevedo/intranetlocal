<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") %>
	<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />

<script language="jscript" type="text/jscript">
function ACTUALIZA(cod,cad)
{	
	return true
}
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad = trim(t.rows(pos).cells(2).innerText);
    //alert(cad)
	window.parent.window.opener.top.window.thisForm.RTEL.value = cad
	cad = trim(t.rows(pos).cells(3).innerText);
	window.parent.window.opener.top.window.thisForm.RDES.value = cad
	cad = trim(t.rows(pos).cells(0).innerText);
	window.parent.window.opener.top.window.thisForm.RUC.value = cad
	cad = trim(t.rows(pos).cells(1).innerText);
	window.parent.window.opener.top.window.thisForm.PROV.value = cad
	cad = trim(t.rows(pos).cells(7).innerText);
	window.parent.window.opener.top.window.thisForm.KGS.value = cad
	cad = trim(t.rows(pos).cells(6).innerText);
	window.parent.window.opener.top.window.thisForm.RLL.value = cad
	cad = trim(t.rows(pos).cells(4).innerText);
	window.parent.window.opener.top.window.thisForm.OC.value = cad
	cad = trim(t.rows(pos).cells(2).innerText);
	window.parent.window.opener.top.window.thisForm.TEL.value = Left(cad,6)
this.window.close()
	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;	
	dd(ff);
}
</script>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
dato = REQUEST.QueryString("pos")
 
CAD =	"exec AL_TL_S_BUSCA_TELTEN_PARA_CC  '"& dato &"' " 
		RS.OPEN CAD, CNN
		'Response.Write(CAD)
	CONT = 1
	nohay =0
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST
	else
	nohay=1
	response.write("<font color='red' size='4'><b><center>")
	response.write("No hay datos que concuerden con su selección")
	response.end
	END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="4" cellspacing="1" bordercolorlight="DarkOrange">   
	<tr valign="middle" align="center">
		<td bgcolor="#f7d975" class="TALASBLUE" width="40%">Articulos con partida : <%=dato%></td >     
	</tr >
</table>
<p></p>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%for I=0 to rs.Fields.Count-1 %>
	<td align="center" <%IF i > 8 THEN%> style="display:'none'" <%end if %>>
		<font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(I).NAME%></b></font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>

    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd2('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="REDIR('<%=(cont)%>')">       
	<%for i=0 to rs.Fields.Count-1%>
		<td <%IF i > 8 THEN%> style="display:'none'" <%end if %>>
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
<script language="jscript" type="text/jscript">
nop=parseInt('<%=nohay %>',10)
if (nop==0)
dd2('1');
</script>    
</form>
</BODY>
</HTML>
