<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	if txtPerfil = "" then 
	    txtPerfil = request.QueryString("perfil")	
	    Response.Cookies("usuario")("perfil") = txtperfil
	end if    %>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1

function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	// Rellena los valores en los textbox
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.COD.readOnly= true
	oldrow=pos
	return true;	
}
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%Dim pageSize 
if txtPerfil > 1 then 	pageSize = 16 else 	pageSize = 6
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
' recibe tabla, primary key, y descripcion
tbl = trim(application("owner"))+"."+Request.QueryString("tbl")
tabla = ucase(Request.QueryString("tbl"))
url = Request.QueryString()
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cad = " SP_TABLE_DEFINITION '"&TABLA&"'  "
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
cad = cad + " "&acols(i)&", "
next
cad = cad + " "&acols(ubound(acols))&"      " & _
		" from "&tbl&"					    " & _
		" WHERE "&acols(0)&" >= '"&pos&"'	" & _
		" ORDER BY "&acols(0)&"				" 
'Response.Write(CAD)
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

%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title>
<%=tabla%>
</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<html xmlns="http://www.w3.org/1999/xhtml">

<body>
<form name="thisForm" method="post" action="tablas.asp">
<table width="100%" border="0" align="center">
	<tr>
		<td align= "left" width="25%"><img src="imagenes/ATRAS.gif" style="cursor:hand;" alt=""
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=1');" /></td>
		<td align= "CENTER" width="50%">
		<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" 
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td><span  class="reportescenter">TABLA : <%=trim(tabla)%></span></td>
		    </tr>
		</table>
		 </td>
		<td align="right" width="25%"><img src="imagenes/logo.GIF" alt="logo" /></td>
    </tr>
	<tr><td colspan ="3"><hr/></td></tr>
</table>
<%'*********************************************************************%>
<table id="TABLA" align="CENTER"  width="100%" cellpadding="2"  cellspacing="1"
	  bordercolor="White" bgcolor="lightgrey" border="1">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="<%=application("head")%>" >
<%for I=0 to columnas-1 %>
	<td align="center"><span  class="titulitowhite"><%=RS.FIELDS(I).NAME%></span> </td>
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
	<//tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center" id="boton" cellspacing="5">
	<tr>
		<td><img  
			src="imagenes/primera.gif" style="cursor:hand;" onclick="primera()" 
			alt="PRIMERA PAGINA" /></td>
		<td ><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"
				onclick="anterior()" style="CURSOR:HAND" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR"
				onclick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE"
				onclick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE"
				onclick="siguiente()" style="CURSOR:HAND" /></td>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA"
			 onclick="ultima()"	style="cursor:hand;" /></td>
        <td><img src= "imagenes/print.gif" alt="IMPRIMIR"
			 onclick="fReporte()" style="cursor:hand;" /></td>
	</tr>
</table>
<%end if%>
   <table	align="center" width="60%" border="1" 
		cellpadding="1" cellspacing="0"  bgcolor="WHITE" bordercolorlight="GAINSBORO" bordercolordark="WHITE" 
		id="DATAENTRY" style="DISPLAY:none">
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="14%"> 
			<span  class="TITULITO">CODIGO</span> </td>
		<td width="10%"> 
		<input  id ="COD" type="TEXT"  tabindex ="-1" onchange="tempo()" maxlength='<%=alen(0)%>'
				readonly="readonly" class="DATOSGRANDE" />		</td>
    	<td width="14%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">DESCRIPCION</span> </td>
        <td colspan="1" ><input  type="text" name="DES" id="DES" class="DATOSGRANDE" maxlength='<%=alen(1)%>' /></td>
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
	<td><img 
	        src="imagenes/SEARCH.gif" alt="BUSCAR" 
	        onclick="document.getElementById('busq').style.display='block';document.getElementById('txtcodcli').focus()" 
	        style="cursor:hand;" /><div  
			id="busq" style="position:absolute; width:230px; z-index:1;display:none;">
		    <table width="81%"  cellpadding="1" cellspacing="0" 
		     bgcolor="WHITE" border="1" bordercolorlight="GAINSBORO" bordercolordark="WHITE" >
			  <tr>
			      <td width="25%"bgcolor='<%=(Application("barra"))%>' >
			      <font face="arial" size="1" color="MidnightBlue">
			      <b>CODIGO: </b></font></td>
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

<script type="text/jscript">
var pag
pag =  'tablas.asp?tbl='+'<%=tabla%>'+'&pk='+'<%=pk%>'+'&ds='+ '<%=ds%>'
pag += '&pos='

perf = '<%=trim(txtPerfil)%>' 
perf = parseInt(perf,10)
if (perf == 1)
	eval("DATAENTRY.style.display='block'");
if (parseInt(mm,10) <= 0)
	NUEVO()
else
	dd('1')	
		
function tempo()
{	cad =  'help/existe.asp?pos='+ltrim(thisForm.COD.value)
	cad += '&tbl='+ '<%=tbl%>'
	cad += '&pk='+ '<%=pk%>'
	cad += '&ds='+ '<%=ds%>'
	cad += '&col=COD'
	cad += '&url=../tablas.asp?'
	document.all.bake.src=cad
}
function NUEVO()
{	thisForm.COD.value = '';
	thisForm.COD.readOnly = false;
	thisForm.DES.value = '';
	thisForm.COD.disabled = false;
	thisForm.COD.tabIndex=0
	thisForm.COD.focus();
	return true;
}	
function primera()
{	window.location.replace(pag)
}	
function ultima()
{	cad =  'comun/last.asp?pos='+ltrim(thisForm.COD.value)
	cad += '&tbl='+ '<%=tbl%>'
	cad += '&pk='+ '<%=pk%>'
	cad += '&ds='+ '<%=ds%>'
	cad += '&url=../tablas.asp?'
	document.all.bake.src=cad
}
function siguiente()
{  var t = document.all.TABLA;
   window.location.replace(pag + (t.rows(t.rows.length-1).cells(0).innerText))
}
function anterior()
{   var t = document.all.TABLA;
    cad =  'comun/prev.asp?pos='+ltrim((t.rows(1).cells(0).innerText))
	cad += '&tbl='+ '<%=tbl%>'
	cad += '&pk='+ '<%=pk%>'
	cad += '&ds='+ '<%=ds%>'
	cad+= '&size='+'<%=pagesize%>'
	cad += '&url=../tablas.asp?'
    document.all.bake.src=cad
}    
function retrocede()
{   if (oldrow > 1)
        dd(oldrow-1)
}
function avanza()
{   var t = document.all.TABLA;
    if (oldrow < t.rows.length-1)
        dd(oldrow+1)
}
function GRABA()
{   cad =  'comun/insertbl.asp?pos='+ltrim(thisForm.COD.value)
	cad += '&tbl='+ '<%=tbl%>'
	cad += '&pk='+ '<%=pk%>'
	cad += '&ds='+ '<%=ds%>'
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&url=../tablas.asp?'
	document.all.bake.src=cad
}
function DELE()
{    cad =  'comun/insertbl.asp?pos='+ltrim(thisForm.COD.value)
	cad += '&tbl='+ '<%=tbl%>'
	cad += '&pk='+ '<%=pk%>'
	cad += '&ds='+ '<%=ds%>'
	cad += '&des=' + ltrim(thisForm.DES.value)
	cad += '&chk=1'
	cad += '&url=../tablas.asp?'
	
    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)    
    {   //alert(cad)
        document.all.bake.src=cad
    }
}

</script>
   
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<iframe src='' frameborder="1" id="bake" name="bake" style="display:block"></iframe>
</form>
</body>
</html>
