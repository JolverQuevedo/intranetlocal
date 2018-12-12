<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1
function fBuscar(color)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+color
        cad += '&tbl=TEMPORADAS'
        cad += '&col=descripcion'
        cad += '&col2=cliente'
        cad += '&msg=NO EXISTE TEMPORADA PARA ESTE CLIENTE'
        cad += '&pos2=' + '<%=trim(request.QueryString("CLI"))%>'
        cad += '&url=../detaTEMPORADAS.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
    document.all.bake.src=cad
}
function fReporte()
{	window.open('REPORTES/prnReporteESTILOS.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
}
var oldrow=1
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/navegaciontempo.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%Dim pageSize 
if txtPerfil > 1 then 	pageSize = 16 else 	pageSize = 6
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
' recibe tabla, primary key, y descripcion
tbl = "TEMPORADAS"
tabla = ucase("TEMPORADAS")
cli = request.QueryString("POS")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************

CAD =	" SELECT                        " & _
		" CODIGO AS COD_TEMP,           " & _
		" DESCRIPCION AS DES_TEMP       " & _ 
		" from temporadas WHERE         " & _
        " ESTADO        = 'A' and       " & _
        " cliente    = '"&CLI&"'        " & _
        " ORDER BY codigo               " 
		'response.Write(cad)
        'RESPONSE.End
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
%>
<script type="text/jscript">
mm= '<%=rs.recordcount%>'
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title><%=tabla%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">

<%IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="DETAESTILO.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" 
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" >
<%for I=0 to columnas-1 %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
		<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
	<%FOR i=0 TO columnas-1%>
		<td><span  class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></span> </td>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>

<%end if%>
  <table	align="center"  border="1" 
		cellpadding="1" cellspacing="1"  bgcolor="<%=application("color2") %>" bordercolorlight="<%=application("borde") %>" bordercolordark="<%=application("color2") %>" id="DATAENTRY" style="DISPLAY:none">
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="50"> 
			<span  class="DESCRIPTORCENTERnavy">CODIGO</span> </td>
		<td width="36"> 
		<input  id ="COD" name="COD" type="TEXT"  tabindex ="-1" maxlength=3
				readonly="readonly" class="DATOSGRANDE" onchange="tempo()"/>		</td>
    	<td width="123" bgcolor='<%=(Application("barra"))%>'><span  class="DESCRIPTORCENTERnavy">DESCRIPCION</span> </td>
        <td colspan="1" width="300"><input  type="text" name="DES" id="DES" class="DATOS" maxlength=50 /></td>
    </tr>
    
  </table>	
<table align="center" border="0" cellpadding="0" cellspacing="2">
<tr>
	<td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO"
			onclick="NUEVO()" style="cursor:hand;" id="NUEVO REGISTRO"  /></td>
	<td><img src="imagenes/DISK.gif" alt="GRABAR"
			onclick="GRABA()" style="cursor:hand;"/></td>	
	<td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO"
			onclick="DELE()" style="cursor:hand;" /></td>	
				
</tr>
</table>
<iframe src='' frameborder="1" id="bake" name="bake" style="display:none"></iframe>

<%rs.close%>

<script>
	if (marca == 0)
		dd('1');				

function GRABA()
{   cad =  'comun/inserTEM.asp?pos='
    cad += thisForm.COD.value
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&cli=' + '<%=trim(pos)%>'
	cad += '&chk=0' 
	//alert(cad)
	/*document.all.bake.style.display='block'
	document.all.bake.height="150"
	document.all.bake.width="100%"
    */
    document.all.bake.src=cad
}
function DELE()
{   cad  =  'comun/inserTEM.asp?pos='+(thisForm.COD.value)
    cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&cli=' + '<%=trim(pos)%>'
	cad += '&chk=1' 
	
    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)
    {  // alert(cad)
    document.all.bake.src=cad
    }
}	
function NUEVO()
{ thisForm.COD.value = 'AUT';
  thisForm.DES.value = '';
  thisForm.COD.disabled = false;
  thisForm.COD.tabIndex=0
  thisForm.COD.focus();
  marca = 1;
  return true;
}
function LLENA(pos,t)
{   thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.COD.readOnly= true
}
size = '<%=pagesize %>'	
tabla = '<%=trim(tabla)%>'
param  = '&tbl=TEMPORADAS'
param += '&pk=CODIGO'
param += '&ds=descripcion'
param += '&col2=cliente'
param += '&msg1=CODIGO EXISTE PARA OTRO CLIENTE'
param += '&msg2=CODIGO DUPLICADO'
param += '&pos2='+ '<%=trim(request.QueryString("CLI"))%>'
// url para re-direccionar con la barra de navegacion
// siempre debe ir al final de la cadena para que no se rayen los ??
URL   = '&url=../detaTEMPORADAS.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
//pagina de inicio
pag = 'detaTEMPORADAS.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
</script>    
<%IF txtPerfil = 1 THEN%>
<SCRIPT> 
	eval("DATAENTRY.style.display='block'");
		if (marca == 1)
			NUEVO();
</SCRIPT>
<%END IF%>

<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
