<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1
function fBuscar(pro)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+pro
        cad += '&tbl=proporciones'
        cad += '&col=proporcion'
        //cad += '&col2=prop'
        cad += '&msg=NO EXISTE PROPORCION'
        cad += '&pos2='
        cad += '&url=../proporciones.asp?POS=' + '<%=trim(request.QueryString("POS"))%>'
    document.all.bake.src=cad
}
function fReporte()
{	window.open('REPORTES/prnReporteCOLORES.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("POS"))%>')
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
tbl = trim(application("owner"))+".PROPORCIONES"
tabla = ucase("PROPORCIONES")
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
<body topmargin="0" text="#000000" >

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
<head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<style type="text/css">
<!--
.style2 {font-size: 1px}
-->
</style>
</head>

<form name="thisForm" method="post" action="DETACOLORES.asp">
<table width="100%">
	<tr>
		<td align= "left" width="35%">
			<img src="imagenes/ATRAS.gif" alt=""
			style="cursor:hand;" onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=1');" />
		</td>
		<td align= "center">
			<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" 
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td><span  class="reportescenter">TABLA : <%=trim(tabla)%></span></td>
		    </tr>
		</table>
		</td>
		<td align="right" width="35%"> <img src="imagenes/logo.GIF"  alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr/></td>
	</tr>
</table>

<%'*********************************************************************%>
<table id="TABLA" align="CENTER"  width="100%"
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
  <table	align="center" width="100%" border="1" 
		cellpadding="1" cellspacing="0"  bgcolor="WHITE" bordercolorlight="GAINSBORO" bordercolordark="WHITE" 
		id="DATAENTRY" style="DISPLAY:none">
    <tr valign="middle"> 
            <td width="10%" bgcolor='<%=(Application("barra"))%>' align= "right">
             <font face="arial" size="1" color="MidnightBlue" ><b>CODIGO :</b></font></td>
            <td bgcolor="WHITE" width="20%" valign="middle"> 
				<input type="text" id="COD" name="COD" class="texto" maxlength="3" tabindex="-1" readonly="readonly" />
			  
            </td>
            <td colspan="4" bgcolor="WHITE">&nbsp;</td>
          </tr>
          <tr > 
            <td width="10%" bgcolor='<%=(Application("barra"))%>' align="right"> 
				<font face="arial" size="1" color="MidnightBlue" ><b> ROPORCIONES :</b> </font>
			</td>
            <td bgcolor="WHITE" colspan="5"> 
            <table width="100%" align="center" cellpadding="0" cellspacing="1" border="0">
            <tr>
            <%FOR I =0 TO 9%>
			    <td width="10%"><input type="text" id="P<%=I%>" name="P<%=I%>" class="DATOSGRANDE"
				  maxlength="2" value='' onblur="codigo(this)" /></td>
			<%NEXT%>		  
			</tr>
			</table>
            </td>
          </tr>
  </table>	
<table align="center" border="0" cellpadding="0" cellspacing="2">
<tr>
	<td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onclick="NUEVO()" style="cursor:hand;" id="NUEVO REGISTRO"  /></td>
	<td><img src="imagenes/DISK.gif" alt="GRABAR" onclick="GRABA()" style="cursor:hand;"/></td>	
	<td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onclick="DELE()" style="cursor:hand;" /></td>	
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

<script type="text/jscript" >
	if (marca == 0)
		dd('1');				
		
function valida(opc,bad)
{	ccad  = 'help/existe10.asp?nn=33'
	ccad += param
	ccad += opc
	ccad += 'msg=PROPORCION YA EXISTE'
	ccad += '&url=' + URL
    document.all.bake.src=ccad	
}	
function GRABA()
{   cad  = thisForm.COD.value
	cad += '&P0=' + trim(thisForm.P0.value)
	cad += '&P1=' + trim(thisForm.P1.value)
	cad += '&P2=' + trim(thisForm.P2.value)
	cad += '&P3=' + trim(thisForm.P3.value)
	cad += '&P4=' + trim(thisForm.P4.value)
	cad += '&P5=' + trim(thisForm.P5.value)
	cad += '&P6=' + trim(thisForm.P6.value)
	cad += '&P7=' + trim(thisForm.P7.value)
	cad += '&P8=' + trim(thisForm.P8.value)
	cad += '&P9=' + trim(thisForm.P9.value)
	cad += '&c0=prop0&c1=prop1&c2=prop2&c3=prop3&c4=prop4'
	cad += '&c5=prop5&c6=prop6&c7=prop7&c8=prop8&c9=prop9'
	valida(cad)
	Bad =  'comun/INSER10.asp?pos='+cad+param
    Bad += '&chk=0' 
    Bad += URL
    document.all.bake.src=Bad    
}
function codigo(obj)
{   if (isInt(obj.value))
        return true;
    else
        obj.focus();
}
function DELE()
{   cad  =  'comun/INSER10.asp?pos='+(thisForm.COD.value)
	cad += '&chk=1' +param
	cad += URL
    document.all.bake.src=cad

    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)
    {   //alert(cad)
    document.all.bake.src=cad
    }
}	
function NUEVO()
{ thisForm.COD.readOnly = false;
  thisForm.COD.value = 'AUTO';
  thisForm.COD.readOnly = true;
  thisForm.P0.value = ''
  thisForm.P1.value = '';
  thisForm.P2.value = '';
  thisForm.P3.value = '';
  thisForm.P4.value = '';
  thisForm.P5.value = '';
  thisForm.P6.value = '';
  thisForm.P7.value = '';
  thisForm.P8.value = '';
  thisForm.P9.value = '';
  thisForm.P0.focus();
  marca = 1;
  return true;
}
function LLENA(pos,t)
{   thisForm.COD.value = trim(t.rows(pos).cells(0).innerText);
	thisForm.P0.value  = trim(t.rows(pos).cells(1).innerText) ;
	thisForm.P1.value  = trim(t.rows(pos).cells(2).innerText) ;
	thisForm.P2.value  = trim(t.rows(pos).cells(3).innerText) ;
	thisForm.P3.value  = trim(t.rows(pos).cells(4).innerText) ;
	thisForm.P4.value  = trim(t.rows(pos).cells(5).innerText) ;
	thisForm.P5.value  = trim(t.rows(pos).cells(6).innerText) ;
	thisForm.P6.value  = trim(t.rows(pos).cells(7).innerText) ;
	thisForm.P7.value  = trim(t.rows(pos).cells(8).innerText) ;
	thisForm.P8.value  = trim(t.rows(pos).cells(9).innerText) ;
	thisForm.P9.value  = trim(t.rows(pos).cells(10).innerText);
}
size = '<%=pagesize %>'	
tabla = '<%=trim(tabla)%>'
param  = '&tbl=proporciones'
param += '&pk=proporcion'
param += '&pos2='+ '<%=trim(request.QueryString("pos"))%>'
// url para re-direccionar con la barra de navegacion
// siempre debe ir al final de la cadena para que no se rayen los ??
URL   = '&url=../proporciones.asp?perfil=' + '<%=trim(nivel)%>'
//pagina de inicio
pag = 'proporciones.asp?perfil=' + '<%=trim(nivel)%>'
</script>    
<%IF txtPerfil = 1 THEN%>
<script type="text/jscript"> 
	eval("DATAENTRY.style.display='block'");
		if (marca == 1)
			NUEVO();
</script>
<%END IF%>

<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>

</body>

</html>

