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
        cad += '&tbl=EMPRESAS'
        cad += '&col=CLIENTE'
        cad += '&msg=NO EXISTE CLIENTE'
        cad += '&url=../CLIENTES.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
    document.all.bake.src=cad
}
function fReporte()
{	window.open('REPORTES/prnclientes.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
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
tbl = trim(application("owner"))+".EMPRESAS"
tabla = ucase("EMPRESAS")
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
<%	RS.CLOSE
RS.Open CAD, Cnn
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
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

function thisForm_onblur() {

}

//-->
</SCRIPT>
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="CLIENTES.asp" LANGUAGE=javascript onblur="return thisForm_onblur()">

<table WIDTH="100%">
	<tr>
		<td align= "left" WIDTH="35%">
			<img src="imagenes/ATRAS.gif"  alt="" style="cursor:hand;"
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=3');">
		</td>
		<td align= CENTER>
			<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" 
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td><span  class="reportescenter">TABLA : <%=trim(tabla)%></span></td>
		    </tr>
		</table>
		</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="imagenes/logo.GIF"  >
		  </TD>
        </TR>
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>

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
  <table	align="center" width="90%" border="1"  bordercolordark="WHITE" 
	cellpadding="1" cellspacing="0"  bgcolor="WHITE" bordercolorlight="GAINSBORO"
	id="DATAENTRY" style="DISPLAY:none">
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="14%"> 
			<span  class="TITULITO">CODIGO</span> </td>
		<td width="20%"> 
		<input  id ="COD" name="COD" type="TEXT"  tabindex ="-1" maxlength='<%=alen(0)%>'
				readonly="readonly" class="texto" />		</td>
    	<td  bgcolor='<%=(Application("barra"))%>' width="14%"> 
			<span  class="TITULITO">RUC</span> </td>
		<td width="20%"> 
		<input  id ="RUC" name="RUC" type="TEXT"  tabindex ="-1" maxlength=11
				class="DATOSGRANDE" />		</td>
    </tr>
    <tr>
    <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">NOMBRE</span> </td>
        <td colspan="3" ><input  type="text" name="DES" id="DES" class="DATOSGRANDE" maxlength='<%=alen(2)%>' /></td>
    </tr>
    <tr>
        <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">DIRECCION</span> </td>
        <td colspan="3" ><input  type="text" name="DIR" id="DIR" class="DATOSGRANDE" maxlength='<%=alen(3)%>' /></td>
    </tr>
    <tr>
        <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">CIUDAD</span> </td>
        <td colspan="1" ><input  type="text" name="CIU" id="CIU" class="DATOSGRANDE" maxlength='<%=alen(4)%>' /></td>
        <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">PAIS</span> </td>
        <td colspan="1" ><select id ="PAI" name="PAI" type="TEXT"  tabindex ="-1"  class="DATOSGRANDE" >
		<option value=''></option>
		<%  tbl1 = trim(application("owner"))+".PAISES"
            cad = "select * from "&tbl1&" order by DESCRIPCION" 
            rs.close
            rs.open cad,cnn
            if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof%>
                <option value='<%=rs("CODIGO")%>'><%=trim(rs("DESCRIPCION")) %></option>
                <%rs.movenext
           loop     %>
		</select></td>
    </tr>
    <tr>
        <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TELEFONO</span> </td>
        <td colspan="1" ><input  type="text" name="TEL" id="TEL" class="DATOSGRANDE" maxlength='<%=alen(9)%>' /></td>
        <td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">FAX</span> </td>
        <td colspan="1" ><INPUT id ="FAX" name="FAX" type="TEXT"  class="DATOSGRANDE" maxlength='<%=alen(8)%>' />
    </tr>
    <tr> 
		<td width="20%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">ZOMA</span> </td>
        <td colspan="1" ><select id ="ZON" name="ZON" type="TEXT"  tabindex ="-1"  class="DATOSGRANDE" >
		<option value=''></option>
		<%  tbl1 = trim(application("owner"))+".MERCADOS"
            cad = "select * from "&tbl1&" order by DESCRIPCION" 
            rs.close
            rs.open cad,cnn
            if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof%>
                <option value='<%=rs("CODIGO")%>'><%=trim(rs("DESCRIPCION")) %></option>
                <%rs.movenext
           loop     %>
		</select></td>
    	<td width="14%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TIPO DE CLIENTE</span> </td>
        <td colspan="1" ><select id ="TIP" name="TIP" type="TEXT"  tabindex ="-1" onchange="codigo()" 
        class="DATOSGRANDE" >
		<option value=''></option>
		<%  tbl1 = trim(application("owner"))+".TIPOCLI"
            cad = "select * from "&tbl1&" order by DESCRIPCION" 
            rs.close
            rs.open cad,cnn
            if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof%>
                <option value='<%=rs("TIPO")%>'><%=trim(rs("DESCRIPCION")) %></option>
                <%rs.movenext%>
            <%loop %>    
		</select>		</td>
    </tr>
  </table>	
<table align="center" border="0" cellpadding="0" cellspacing="2">
<tr>
	<td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO"
			onclick="NUEVO()" style="cursor:hand;" id="NUEVO REGISTRO"  name="NUEVO REGISTRO"/ oncellchange="return NUEVO REGISTRO_oncellchange()"></td>
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
{ return true
}	
function GRABA()
{   cad =  'comun/insercli.asp?pos='
    if (marca==1)
        cad +="auto"
	else 
	    cad += thisForm.COD.value
	//cad += param
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&ZON=' + ltrim(thisForm.ZON.value)
	cad += '&RUC=' + ltrim(thisForm.RUC.value)
	cad += '&PAI=' + ltrim(thisForm.PAI.value)
	cad += '&TIP=' + ltrim(thisForm.TIP.value)
	cad += '&FAX=' + ltrim(thisForm.FAX.value)
	cad += '&TEL=' + ltrim(thisForm.TEL.value)
	cad += '&DIR=' + ltrim(thisForm.DIR.value)
	cad += '&CIU=' + ltrim(thisForm.CIU.value)
	cad += '&cli=' + '<%=trim(cli)%>'
	cad += '&chk=0' 
	cad += '&url=../clientes.asp?'
    document.all.bake.src=cad
}
function DELE()
{   cad  =  'comun/insercli.asp?pos='+(thisForm.COD.value)
	cad += '&cli=' + '<%=trim(cli)%>'
	cad += '&chk=1' 
	cad += '&url=../clientes.asp?'
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
  thisForm.RUC.value = '';
  thisForm.COD.disabled = false;
  thisForm.COD.tabIndex=0
  thisForm.ZON.selectedIndex=-1;
  thisForm.TIP.selectedIndex=-1;
  thisForm.PAI.selectedIndex=-1;
  thisForm.DIR.value = '';
  thisForm.TEL.value = '';  
  thisForm.FAX.value = '';  
  thisForm.DES.focus();
  marca = 1;
  return true;
}
function LLENA(pos,t)
{   thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.RUC.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.DES.value = ltrim(t.rows(pos).cells(2).innerText) ;
	thisForm.DIR.value = ltrim(t.rows(pos).cells(3).innerText) ;
	thisForm.CIU.value = ltrim(t.rows(pos).cells(4).innerText) ;
	thisForm.TEL.value = ltrim(t.rows(pos).cells(9).innerText) ;
	thisForm.FAX.value = ltrim(t.rows(pos).cells(8).innerText) ;
	var subcadena =  trim(t.rows(pos).cells(6).innerText) ;
	var elemento = thisForm.PAI ;
	thisForm.PAI.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(5).innerText) ;
	elemento = thisForm.ZON ;
	thisForm.ZON.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(7).innerText) ;
	elemento = thisForm.TIP ;
	thisForm.TIP.selectedIndex = seleindice(subcadena,elemento);
	thisForm.COD.readOnly= true
}
size = '<%=pagesize %>'	
tabla = '<%=trim(tabla)%>'
param  = '&tbl=empresas'
param += '&pk=cliente'
param += '&pos2='+ '<%=trim(request.QueryString("CLI"))%>'
// url para re-direccionar con la barra de navegacion
// siempre debe ir al final de la cadena para que no se rayen los ??
URL   = '&url=../clientes.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
//pagina de inicio
pag = 'clientes.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
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


<script language="javascript">
function VerBusqueda(){
	document.getElementById('busq').style.display='block'
	activar_foco();
}

function activar_foco(){
	document.getElementById("txtDescripcion").focus();
}

function llamaBuscaTela()
	{
	if(window.event.keyCode==13)
		{
		Buscar();
		}	
	}

function Buscar(){
BUSCA('<%=urlBase%>','<%=alias%>',
			'CLIENTE', 'nombre')
}
</script>
</BODY>
</HTML>