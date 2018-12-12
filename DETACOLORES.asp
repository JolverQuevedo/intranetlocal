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
        cad += '&tbl=colores'
        cad += '&col=descripcion'
        cad += '&col2=cliente'
        cad += '&msg=NO EXISTE COLOR PARA ESTE CLIENTE'
        cad += '&pos2=' + '<%=trim(request.QueryString("CLI"))%>'
        cad += '&url=../detacolores.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
    document.all.bake.src=cad
}
function fReporte()
{	window.open('REPORTES/prnReporteCOLORES.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
}
var oldrow=1
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/navegacion2.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%Dim pageSize 
if txtPerfil > 1 then 	pageSize = 16 else 	pageSize = 6
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
' recibe tabla, primary key, y descripcion
tbl = trim(application("owner"))+".COLORES"
tabla = ucase("COLORES")
cli = request.QueryString("CLI")
url = Request.QueryString()
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cad = " SP_TABLE_DEFINITION "&TABLA&"  "
'response.Write(cad)
rs.open cad,cnn
RS.MOVEFIRST
dim acols()
dim aLen()
redim acols(-1)
redim alen(-1)
DO WHILE NOT RS.EOF
    redim preserve acols(ubound(acols)+1)
    redim preserve alen(ubound(alen)+1)
    ACOLS(ubound(acols)) = rs("column")
    alen(ubound(alen)) = rs("length")
    RS.MOVENEXT
LOOP
pk = acols(0)
ds = aCols(1)
rs.close
CAD =	" SELECT  TOP "&pageSize&" "
for i=lbound(acols) to ubound(acols)-1
cad = cad + " "&tbl&"."&acols(i)&", "
next
cad = cad + " "&acols(ubound(acols))&"      " & _
		" from "&tbl&"					    " & _
		" WHERE "&acols(0)&" >= '"&pos&"'	" & _
		" and cliente = '"&cli&"'           " & _
		" ORDER BY "&acols(0)&"				" 
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST%>
<script type="text/jscript">
mm= '<%=rs.recordcount%>'
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
PKLEN = RS.FIELDS.ITEM(0).DefinedSize 
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title><%=tabla%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%	RS.Open CAD, Cnn
CONT = 1
IF NOT RS.EOF OR NOT RS.BOF THEN
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
<style type="text/css">
<!--
.style2 {font-size: 1px}
-->
</style>
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="DETACOLORES.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
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
<table border="0" align="center" id="boton" cellspacing="5">
	<tr style="cursor:hand;" >
		<td><img  src="imagenes/primera.gif" onclick="primera()" alt="INICIO" /></td>
		<td ><img src="IMAGENES/PREV.GIF"  alt="ANTERIOR" onclick="anterior()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/arriba.gif" alt="RETROCEDE" onclick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif"  alt="AVANZA" onclick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif"   alt="SIGUIENTE" onclick="siguiente()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/ultima.gif" alt="ULTIMA" onclick="ultima()"	style="cursor:hand;" /></td>
        <td><img src="imagenes/print.gif"  alt="IMPRIMIR" onclick="fReporte()" style="cursor:hand;" /></td>
	</tr>
</table>
<%end if%>
  <table	align="center" width="90%" border="1" 
		cellpadding="1" cellspacing="0"  bgcolor="WHITE" bordercolorlight="GAINSBORO" bordercolordark="WHITE" 
		id="DATAENTRY" style="DISPLAY:none">
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="14%"> 
			<span  class="TITULITO">CODIGO</span> </td>
		<td width="20%"> 
		<input  id ="COD" name="COD" type="TEXT"  tabindex ="-1" maxlength='<%=alen(0)%>'
				readonly="readonly" class="texto" />		</td>
    	<td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">DESCRIPCION</span> </td>
        <td colspan="1" ><input  type="text" name="DES" id="DES" class="DATOSGRANDE" maxlength='<%=alen(1)%>' /></td>
    </tr>
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="14%"> 
			<span  class="TITULITO">TONO</span> </td>
		<td width="25%"> 
		<select id ="TON" name="TON" type="TEXT"  tabindex ="-1" onchange="codigo()" class="DATOSGRANDE" >
		<option value=''></option>
		<%  tbl1 = trim(application("owner"))+".tonos"
            cad = "select * from "&tbl1&" order by destono" 
            rs.close
            rs.open cad,cnn
            if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof%>
                <option value='<%=rs("tono")%>'><%=trim(rs("destono")) %></option>
                <%rs.movenext
           loop     %>
		</select>		
		</td>
    	<td width="14%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TIPO DE TEÑIDO</span> </td>
        <td colspan="1" ><select id ="TEN" name="TEN" type="TEXT"  tabindex ="-1" onchange="codigo()" 
        class="DATOSGRANDE" >
		<option value=''></option>
		<%  tbl1 = trim(application("owner"))+".TENIDO"
            cad = "select * from "&tbl1&" order by desTENIDO" 
            rs.close
            rs.open cad,cnn
            if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof%>
                <option value='<%=rs("TENIDO")%>'><%=trim(rs("destENIDO")) %></option>
                <%rs.movenext%>
            <%loop %>    
		</select>		</td>
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
	<td><img src="imagenes/SEARCH.gif" alt="BUSCAR" 
	        onclick="document.getElementById('busq').style.display='block';document.getElementById('txtcodcli').focus()" 
	        style="cursor:hand;" /><div id="busq" style="position:absolute; width:230px; z-index:1;display:none;">
		    <table width="81%"  cellpadding="1" cellspacing="0" 
		     bgcolor="WHITE" border="1" bordercolorlight="GAINSBORO" bordercolordark="WHITE" >
			  <tr>
			      <td width="25%"bgcolor='<%=(Application("barra"))%>' >
			      <font face="arial" size="1" color="MidnightBlue">
			      <b>COLOR: </b></font></td>
			      <td width="75%"  bgcolor="#FFFFFF">
	   		      <input  name="txtcodcli" type="text" id="txtcodcli" 
	   		      size="15" maxlength="10" tabindex="1" /></td>
			 </tr>
			 <tr >
			 <td colspan="2" align="right" bgcolor="#FFFFFF"> 
                <input  type="button" name="btnB" id="btnB" value=" Ir " 
                onclick="javascript:fBuscar(document.getElementById('txtcodcli').value)" 
                title="Buscar" /><a  onclick="javascript:document.getElementById('busq').style.display='none'" 
                style="cursor:pointer; font:Arial; font-size:11px; color:#FF0000">
		                 <u>[X]Cerrar</u></a></td>
			 </tr>
  		  </table>
  	  </div>
	</td>			
</tr>
</table>
<iframe src='' frameborder="1" id="bake" name="bake" style="display:none"></iframe>

<%rs.close%>

<script type="text/jscript">
	if (marca == 0)
		dd('1');				
		
function codigo()
{ thisForm.COD.value = thisForm.elements.item("TON").value + thisForm.elements.item("TEN").value
}	
function GRABA()
{   cad =  'comun/insercol.asp?pos='
    if (marca==1)
        cad +=thisForm.elements.item("TON").value + thisForm.elements.item("TEN").value
	else 
	    cad += thisForm.COD.value
	//cad += param
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&ton=' + ltrim(thisForm.TON.value)
	cad += '&ten=' + ltrim(thisForm.TEN.value)
	cad += '&cli=' + '<%=trim(cli)%>'
	cad += '&chk=0' 
	cad += '&url=../detacolores.asp?'
    document.all.bake.src=cad
}
function DELE()
{   cad  =  'comun/insercol.asp?pos='+(thisForm.COD.value)
    cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&ton=' + ltrim(thisForm.TON.value)
	cad += '&ten=' + ltrim(thisForm.TEN.value)
	cad += '&cli=' + '<%=trim(cli)%>'
	cad += '&chk=1' 
	cad += '&url=../detacolores.asp?'
    document.all.bake.src=cad

    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)
    {   //alert(cad)
    document.all.bake.src=cad
    }
}	
function NUEVO()
{ thisForm.COD.value = '';
  thisForm.COD.readOnly = false;
  thisForm.DES.value = '';
  thisForm.COD.disabled = false;
  thisForm.COD.tabIndex=0
  thisForm.TON.selectedIndex=-1;
  thisForm.TEN.selectedIndex=-1;
  thisForm.DES.focus();
  marca = 1;
  return true;
}
function LLENA(pos,t)
{   thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.TON ;
	thisForm.TON.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(3).innerText) ;
	elemento = thisForm.TEN ;
	thisForm.TEN.selectedIndex = seleindice(subcadena,elemento);
	thisForm.COD.readOnly= true
}
size = '<%=pagesize %>'	
tabla = '<%=trim(tabla)%>'
param  = '&tbl=colores'
param += '&pk=codigo'
param += '&ds=cliente'
param += '&pos2='+ '<%=trim(request.QueryString("CLI"))%>'
// url para re-direccionar con la barra de navegacion
// siempre debe ir al final de la cadena para que no se rayen los ??
URL   = '&url=../detacolores.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
//pagina de inicio
pag = 'detacolores.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
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
