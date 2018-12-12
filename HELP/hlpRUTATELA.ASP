<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	'RESPONSE.Write(nivel)
%> 
<%'*********************************************
  ' Definir el TITULO de la PAGINA ASP 
  '*********************************************
Dim TITULO
TITULO = "RUTAS PARA TELA:"
%>
<script type="text/jscript" language="jscript">
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script> 
<%	TEL = Request.QueryString("pos")
    UBI = Request.QueryString("UBI")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************

CAD =	" SELECT  TELA, VERSION,		" & _
		" DESCRIPTOR, VOLTEADO, LAVAPANO" & _
		" FROM     TELARUTAHEAD			" & _
		" WHERE ESTADO = 'A' and		" & _
		" TELA = '"&TEL&"'				" & _
        " ORDER BY VERSION  		" 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>


<form name="thisForm" id="thisForm" method="post" action="TELARUTAHEAD.asp">
<input id="TEL" name="TEL" value = '<%=TEL%>'  type="hidden">
<table width="100%">
	<tr><td width="5%">
		<img src="../imagenes/CERRAR.gif" 	style="cursor:hand;" onClick="javascript: window.close();" />
		</td>
		<td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b><%=titulo%> <%=trim(TEL)%><br /></b></font>
		</td>
		<td align="right" width="5%">
		  	<img src="../imagenes/logo.GIF" alt="" />
		  </td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNHLP.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		response.Write("<font color=navy>")
		RESPONSE.Write("TELA SIN RUTAS DEFINIDAS")	
		SINDATOS =0
		'RESPONSE.End()%>
	<%END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%	LIMITE =  rs.fields.count - 1 %>
<%for I=1 to LIMITE %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr bgcolor="<% if CONT mod 2  = 0 THEN 
		response.write(Application("color1"))
		else
		response.write(Application("color2"))
		end IF%>"
		onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  onDblClick="follow('<%=CONT%>')">
	<%for i=1 to LIMITE%>
		<td width="5%">
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
<%END IF %>
<center>
<br />
    <input type="button" value="MUESTRA DETALLE" onclick="MUESTRA(oldrow)">
</center>
<iframe frameborder="0"   width="100%" id="ACTIV" name="ACTIV" onload="calcHeight()"></iframe>

<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
ubi = '<%=ubi%>'
if (rec > 0 )
{	ver = trim('<%=ver%>')
	if (ver != '')
		dd2(ver);
	else	
		dd2('1');
}
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('ACTIV').contentWindow.
    document.body.scrollHeight+25;

  //change the height of the iframe
  document.getElementById('ACTIV').height=
      the_height;
}
function MUESTRA(ff)
{   var t = document.all.TABLA;
    if (t.rows.length>0)
    {   var pos = parseInt(ff,10)
        document.all.ACTIV.style.visibility='visible'
        document.all.ACTIV.src='hlpdetarutatela.asp?pos='+'<%=tel%>'+'&rut='+ t.rows(pos).cells(0).innerText ;
    }
}
function follow(ff)
{   var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    eval("window.opener.document.all.RUT"+parseInt(ubi,10)+".value= t.rows(pos).cells(0).innerText") 
    window.close()
}
</script>    
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>
