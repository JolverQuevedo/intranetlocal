<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil")
	owner = Application("owner") %>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1
function fBuscar(color)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+color
        cad += '&tbl=brow_prendas'
        cad += '&col=codigo'
        cad += '&msg=NO EXISTE ESTA PRENDA'
        cad += '&url=../prendas.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
    document.all.bake.src=cad
}
function fReporte()
{	window.open('REPORTES/prnReporteESTILOS.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
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
tbl = trim(application("owner"))+".brow_prendas"
tabla = ucase("brow_prendas")
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

tip = request.QueryString("tip")
if pos = "" or isnull(pos)  or pos = " " then 	pos = "1"

if tip = 3 then
    busq = " descripcion like '%" & pos & "%'"
elseif tip = 2 then
    busq = " generico like '%" & pos & "%' "
elseif tip = 1 then
    busq = " codigo like '%" & pos & "%' "
else
    busq = " codigo >= '" & pos &"'"
end if
cad = cad + " "&acols(ubound(acols))&"      " & _
		" from "&tbl&"					    " & _
		" WHERE  "&BUSQ&"  " & _
		" ORDER BY "&acols(0)&"				" 
		'RESPONSE.Write(CAD)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST %>
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

<style type="text/css">
<!--
.style2 {font-size: 1px}
-->
</style>

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

<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="prendas.asp">
<%'*********************************************************************************************%>
<table width="100%" border="0" align="center">
	<tr>
		<td align= "left" width="25%"><img src="imagenes/ATRAS.gif" style="cursor:hand;" alt=""
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=3');" /></td>
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
			onclick="dd('<%=(cont)%>')" id="fila<%=cont%>" >
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
		<td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">CODIGO</span> </td>
		<td width="10%"> 
		<input  id ="COD" name="COD" type="TEXT"  tabindex ="-1" maxlength='<%=alen(0)%>'
				readonly="readonly" class="TEXTo" />		
            <select id="LIN" style="WIDTH:100%" style="display:none" onchange="thisForm.COD.value=this.value" class="DATOS">
            <%RS.CLOSE
	        CAD = "SELECT * FROM "&OWNER&".lineaprendas WHERE  ESTADO = 'A' ORDER BY CODlinea "
	        RS.OPEN CAD, Cnn
	        if rs.eof or rs.bof then%>
            <option value=''>No Hay Líneas Registradas </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
            <option value=<%=rs("codlinea")%>><%=rs("descripcion")%> </option>
            <%rs.movenext%>
            <%loop%>
            <%end if %>	</select> 				
				
		</td>
    	<td width="5%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">DESCRIPCION</span> </td>
        <td colspan="3" ><input  type="text" name="DES" id="DES" class="datosgrande" 
         maxlength='<%=alen(3)%>' /></td>
    </tr>
    <tr>
    	<td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">PROTO</span> </td>
        <td colspan="1" ><input  type="text" name="PRO" id="PRO" class="datosgrande" 
         maxlength='<%=alen(1)%>' onchange="numero(this);this.value= strzero(this.value,'<%=alen(1)%>')" /></td>
         <td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">VERSION</span> </td>
        <td colspan="1" ><input  type="text" name="VER" id="VER" class="datosgrande" 
         onchange="numero(this);this.value= strzero(this.value,'<%=alen(2)%>')"
         maxlength='<%=alen(2)%>'   /></td>
          <td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">CLIENTE</span> </td>
        <td colspan="1" ><select id="CLI" style="WIDTH:100%" class="DATOS">
        <%RS.CLOSE
        TBL1 = APPLICATION("OWNER")+".EMPRESAS"
	    CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A'  ORDER BY NOMBRE "
	    RS.OPEN CAD, Cnn
	    if rs.eof or rs.bof then%>
            <option value=''>No Hay Clientes Registrados </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
                <option value=<%=rs("cliente")%>><%=rs("nombre")%> </option>
                <%rs.movenext%>
            <%loop%>
          </select>
          <%end if %>
		</tr>
		<tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">GENERO</span> </td>
		<td width="15%"> 
		    <select id="GEN" style="WIDTH:100%" class="DATOS">
        <%RS.CLOSE
        TBL1 = APPLICATION("OWNER")+".GENEROS"
	        CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A' ORDER BY DESCRIPCION "
	        RS.OPEN CAD, Cnn
	        if rs.eof or rs.bof then%>
            <option value=''>No Hay Géneros Registradas </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
            <option value=<%=rs("genero")%>><%=rs("descripcion")%> </option>
            <%rs.movenext%>
            <%loop%>
            <%end if %>	</select>  
		</td>
    	<td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TIPO</span> </td>
        <td colspan="1" width="20%" ><select id="TIP" style="WIDTH:100%" class="DATOS">
        <%RS.CLOSE
        TBL1 = APPLICATION("OWNER")+".TIPPRENDA"
	        CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A' ORDER BY DESCRIPCION "
	        RS.OPEN CAD, Cnn
	        if rs.eof or rs.bof then%>
            <option value=''>No Hay Tipos de Prenda Registrados </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
            <option value=<%=rs("TIPO")%>><%=rs("descripcion")%> </option>
            <%rs.movenext%>
            <%loop%>
            <%end if %>	</select>   </td>
            <td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">GRUPO</span> </td>
		<td > 
		<select id="GRU" style="WIDTH:100%" class="DATOS">
        <%RS.CLOSE
        TBL1 = APPLICATION("OWNER")+".grupoprenda"
	        CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A' ORDER BY CODIGO "
	        RS.OPEN CAD, Cnn
	        if rs.eof or rs.bof then%>
            <option value=''>No Hay Grupos de Prenda Registradas </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
            <option value=<%=rs("CODIGO")%>><%=rs("descripcion")%> </option>
            <%rs.movenext%>
            <%loop%>
            <%end if %>	</select> 	</td>
    </tr>
    <tr valign="middle"><td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TALLAS
    &nbsp;&nbsp;<IMG SRC="IMAGENES\HELP.GIF" width=20	STYLE="CURSOR:HAND;"
		    onclick="window.open('help/tallas.asp')"><input id="TAL" type="hidden" /></span></td>
        <td colspan="5">
            <table border="0" cellspacing="1" cellpading="0" width="100%">
            <tr>
            <%for i=0 to 9 %>
                <td WIDTH=10%><input id='T<%=i%>' class="texto" readonly="readonly"</td>
            <%next %>
            </tr>
            </table>
        </td>
    </tr>
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">UNIDAD</span> </td>
		<td width="15%"> 
		    <select id="UNI" style="WIDTH:100%" class="DATOS">
              <option value='UN'>UNIDADES</option>
              <option value='DD'>DOCENAS</option>     
            </select>
		</td>
    	<td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">MONEDA</span> </td>
        <td colspan="1" width="20%" ><select id="MON" name="MON" style="WIDTH:100%" class="datos">
        <%RS.CLOSE
        TBL1 = APPLICATION("OWNER")+".MONEDAS"
	        CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A' ORDER BY CODIGO "
	        RS.OPEN CAD, Cnn
	        if rs.eof or rs.bof then%>
            <option value=''>No Hay Monedas Registradas </option>
            <%else%>
            <%rs.movefirst%>
            <option value=''></option>
            <%do while not rs.eof%>
            <option value=<%=rs("CODIGO")%>><%=rs("descripcion")%> </option>
            <%rs.movenext%>
            <%loop%>
            <%end if %>	</select>   </td>
            <td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">COSTO</span> </td>
		<td WIDTH=25%>
		     <table border="0" cellspacing="1" cellpading="0" width="100%">
            <tr>
            <td WIDTH="5%"><input id ="CTO" name="CTO" type="TEXT" class="datosgrande" onchange="numero(this)"/></TD>
            <td bgcolor='<%=(Application("barra"))%>' WIDTH="5%"><span class="TITULITO">MINUTAJE</span> </td>	
            <td WIDTH="5%"><input id ="MIN" name="MIN" type="TEXT" class="datosgrande" onchange="numero(this)"/></TD>
            </TR>
           </TABLE> 
		</td>
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
<iframe src='' frameborder="1" id="bake" name="bake" style="display:NONE"></iframe>

<%rs.close%>

<script>
function numero(obj)
{  if ( isDec(obj.value) != true)
        obj.value=''
   else
        return true; 
}
function GRABA()
{if (valida() == true)
    {   cad =  'comun/inserPRE.asp?pos='
        cad += thisForm.COD.value
        cad += param
        cad += '&des=' + thisForm.DES.value
        cad += '&UNI=' + thisForm.UNI.value
        cad += '&CTO=' + thisForm.CTO.value
        cad += '&MON=' + thisForm.MON.value
        cad += '&tal=' + thisForm.TAL.value
        cad += '&cli=' + thisForm.CLI.value
        cad += '&pro=' + thisForm.PRO.value
        cad += '&ver=' + thisForm.VER.value
        cad += '&GEN=' + thisForm.GEN.value
        cad += '&TIP=' + thisForm.TIP.value
        cad += '&GRU=' + thisForm.GRU.value	
        cad += '&MIN=' + thisForm.MIN.value	
	    cad += '&chk=0' 
	    cad += URL
	    
        document.all.bake.src=cad
    }
    return true;    
}
function valida()
{   if (marca == 1 && thisForm.LIN.selectedIndex <1)
    {   alert("Favor Indicar LINEA DE PRENDA")
        thisForm.LIN.focus();
        return false;
    }
    if (trim(thisForm.DES.value)=='')
    {   alert("Ingrese la descripción\nREVISE")
        thisForm.DES.focus();
        return false;
    }
    if (thisForm.CLI.value=='')
    {   alert("Favor Indicar CLIENTE")
        thisForm.CLI.focus();
        return false;
    }
    if (thisForm.GEN.value=='')
    {   alert("Favor Indicar GENERO")
        thisForm.GEN.focus();
        return false;
    }
    if (thisForm.TIP.value == '')
    {   alert("Favor Indicar TIPO DE PRENDA")
        thisForm.TIP.focus();
        return false;
    }
    if (thisForm.GRU.value =='')
    {   alert("Favor Indicar GRUPO DE PRENDA")
        thisForm.GRU.focus();
        return false;
    }
     if (trim(thisForm.TAL.value)=='')
    {   alert("Ingrese la estructura de Tallas\nREVISE")
        window.open('help/tallas.asp')
        return false;
    }
    
    if (thisForm.UNI.value =='')
    {   alert("Favor Indicar Unidad de Medida")
        thisForm.UNI.focus();
        return false;
    }
    if (thisForm.MON.value == '')
    {   alert("Favor Indicar moneda")
        thisForm.MON.focus();
        return false;
     }  
     if(trim(thisForm.CTO.value)=='')
     {  alert("Ingrese el costo")
        thisForm.CTO.focus();
        return false;
     }
     if (isDec(trim(thisForm.CTO.value))== true)
        return true; 
     else
        return true;   
}
function isProto(obj)
{    if (isDec(trim(thisForm.PRO.value))== true)
        return false; 
     else   
        obj.value= strzero(this.value,'<%=alen(1)%>')
}
function DELE()
{   cad  =  'comun/inserPRE.asp?pos='+(thisForm.COD.value)
	cad += '&cli=' + '<%=trim(cli)%>'
	cad += param
	cad += '&chk=1' 
	cad += '&url=../prendas.asp?'
    xx =confirm("¿Está seguro de ELIMINAR este REGISTRO?")
    if (xx == true)
    {   //alert(cad)
    document.all.bake.src=cad
    }
}	
function NUEVO()
{ thisForm.COD.value = '';
  thisForm.COD.style.display='none'
  thisForm.DES.value = '';
  thisForm.UNI.selectedIndex=-1;
  thisForm.LIN.style.display='block'
  thisForm.LIN.selectedIndex=-1;
  thisForm.MON.selectedIndex=-1;
  thisForm.TIP.selectedIndex=-1;
  thisForm.GRU.selectedIndex=-1;
  thisForm.CLI.selectedIndex=-1;
  thisForm.GEN.selectedIndex=-1;
  thisForm.CTO.value='';
  thisForm.TAL.value='';
  thisForm.MIN.value='';
  thisForm.PRO.value='';
  thisForm.VER.value='';
  for (h=0;h<10; h++)
	    eval("thisForm.T"+h+".value=''")
  marca = 1;
  return true;
}
function LLENA(pos,t)
{   thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(3).innerText) ;
	thisForm.PRO.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.VER.value = ltrim(t.rows(pos).cells(2).innerText) ;
	thisForm.MIN.value = ltrim(t.rows(pos).cells(11).innerText) ;
	thisForm.CTO.value = FormatNumber(ltrim(t.rows(pos).cells(13).innerText),2,false, false, true, true) ;
	subcadena =  trim(t.rows(pos).cells(12).innerText) ;
	elemento = thisForm.UNI ;
	thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(14).innerText) ;
	elemento = thisForm.MON ;
	thisForm.MON.selectedIndex = seleindice(subcadena,elemento);
	thisForm.TAL.value =  trim(t.rows(pos).cells(15).innerText) ;
	for (h=0;h<10; h++)
	    eval("thisForm.T"+h+".value=trim(t.rows(pos).cells(h+16).innerText)")
	subcadena =  trim(t.rows(pos).cells(6).innerText) ;
	elemento = thisForm.GEN ;
	thisForm.GEN.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(8).innerText) ;
	elemento = thisForm.TIP ;
	thisForm.TIP.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(26).innerText) ;
	elemento = thisForm.GRU ;
	thisForm.GRU.selectedIndex = seleindice(subcadena,elemento);
	subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	elemento = thisForm.CLI ;
	thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);
	thisForm.COD.readOnly= true
}
size = '<%=pagesize %>'	
tabla = '<%=trim(tabla)%>'
param  = '&tbl=<%=tabla%>'
param += '&pk=codigo'

param += '&tabla=<%=trim(tbl)%>'
param += '&pos2='+ '<%=trim(request.QueryString("CLI"))%>'
// url para re-direccionar con la barra de navegacion
// siempre debe ir al final de la cadena para que no se rayen los ??

URL   = '&url=../prendas.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
//pagina de inicio
pag = 'prendas.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
</script>    
<%IF txtPerfil = 1 THEN%>
    <script type="text/jscript" > 
    eval("DATAENTRY.style.display='block'");
    if (marca == 1)
	    NUEVO();
    </script>
<%END IF%>
<script type="text/jscript" >
if (marca == 0)
		dd('1');				
		
</script>
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>	
</form>
</body>
</html>
