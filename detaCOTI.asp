<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
 <!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/COMUNcotideta.asp"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->  
<script type="text/jscript">
    var chk = ''
    var marca = 0
    var oldrow = 1
    var url = '../detacoti.asp?'
    var alias = 'VIEW_cotizacion'
    var TBL = 'cotizacion'
    var PK = 'cotizacion'
    var DS = 'cliente'
    var largo = 10  // es el largo del PK (se usa en el dataentry)
    var largo2 = 5  // es el largo del descriptor
 
    var oldrow = 1
    var olddata = ''
    var chk = ''
    var ficha = 'fichacotizacion.asp?po='
    mm = -1
/*function fBuscar(color)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+color
        cad += '&tbl=COTIZACION'
        cad += '&col=COTIZACION'
        cad += '&col2=cliente'
        cad += '&msg=NO EXISTEN PROTOS PARA ESTE CLIENTE'
        cad += '&pos2=' + '<%=trim(request.QueryString("CLI"))%>'
        cad += '&url=../detaCOTI.asp?cli=' + '<%=trim(request.QueryString("CLI"))%>'
    document.all.bake.src=cad
}
*/
function fReporte()
{	window.open('REPORTES/prnReporteESTILOS.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
}

function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
    // LOS DEL COMUN SON CODIGO Y DESCRIPCION
    var t = document.all.TABLA;
    var pos = parseInt(ff);
    dd(ff);
}

var oldrow = 1
var pagesize = 35
</script>
<%Dim pageSize 
pageSize = 35
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if

cot = Request.QueryString("cot")
if cot = "" or isnull(cot)  or cot = " " then
	cot = ""
end if


'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top "&pagesize&" * " & _
        " FROM VIEW_COTIZACION      " & _
		" WHERE EDO = 'A'          	" & _
        " and CLI   = '"&POS&"'  and " 

if len(trim(request.QueryString("FILTROcot"))) > 0 then
filtrocot = trim(request.QueryString("FILTROcot"))
    CAD = CAD + " ltrim(rtrim(cotizacion)) >= '"&FILTROcot&"' "                    
    cad = cad +  " order by cotizacion "
elseif len(trim(request.QueryString("FILTROest"))) > 0 then
    filtroest = trim(request.QueryString("FILTROest"))
    CAD = CAD + " ltrim(rtrim(ecli)) >= '"&FILTROest&"' "                    
    cad = cad +  " order by ecli "
elseif len(trim(request.QueryString("FILTROpro"))) > 0 then
    filtropro = trim(request.QueryString("FILTROpro"))
    CAD = CAD +     " pro+'-'+ver >= '"&filtroPRO&"'" 
    CAD = CAD +     " order by pro, ver " 
else
    CAD = CAD +     " pro+'-'+ver >= '"&cot&"'" 
    CAD = CAD +     " order by pro, ver " 
end if

		'response.Write(cad)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
     <script type="text/jscript">
         marca = 0
    </script>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
mm= '<%=rs.recordcount%>'
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count -1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title><%=tabla%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="DETAcoti.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" valign="top">
    <%for I=0 to columnas-4 %>
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
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')">
	    <%FOR i=0 TO columnas-4%>
		    <td class="texto"><%=UCASE(TRIM(RS.FIELDS.ITEM(I))) %></td>
	    <%NEXT%>
	   
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera('<%=pos%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras('<%=pos%>')" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede('<%=pos%>')" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=pos%>')" style="cursor:pointer" /></td>

		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=pos%>')" style="cursor:pointer;" /></td>
        
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Cotizacion :</b></font></td>
		<td><input id="kod" name="kod" value="" /> </td>    
	  </tr>
	   <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Proto :</b></font></td>
		<td><input id="proto" name="proto" value="" /> </td>    
	  </tr>
       <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Estilo :</b></font></td>
		<td><input id="estilo" name="estilo" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="BUSCA()">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>

<%end if%>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<table border="0" align="center"  cellspacing="3">
    <tr><td><img src="imagenes/xls.png" alt="IMPRIMIR COSTO CONSUMO" onClick="IMPRIMEC()" style="cursor:pointer;" /></td>
        <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:pointer;" /></td>		
         <td><img src="imagenes/ruta.jpg" alt="IMPRIMIR CONSUMO" onClick="IMPRIME()" style="cursor:pointer;" /></td>		
    </tr>
</table>

<%rs.close%>

<script>

//alert()
if (marca == 0)
    dd2('1');


function LLENA(ff)
{return true;  
}
function EDITA(ff)
{ var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    COT = ltrim(t.rows(pos).cells(0).innerText);
    PRO = ltrim(t.rows(pos).cells(1).innerText);
	VER = ltrim(t.rows(pos).cells(2).innerText) ;



	datos = '&PRO=' + PRO + '&VER=' + VER + '&cot=' + COT
    //alert(datos)
	window.open('fichacotiZACION.asp?cli='+'<%=pos%>'+ datos)
    return true;
}
function IMPRIME() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    PRO = trim(t.rows(pos).cells(1).innerText);
    VER = trim(t.rows(pos).cells(2).innerText);
    CAD = 'REPORTES/PRNCONSUMO.ASP?PRO=' + PRO + '&VER=' + VER

    //alert(CAD)
    window.open(CAD);
    return true;
}

function elimina() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    var si
    { si = confirm("¿ Confirma la Eliminación de este Registro ? "); }
    if (si == false)
    { return false; }
    PRO = trim(t.rows(pos).cells(0).innerText);
    VER = trim(t.rows(pos).cells(1).innerText);
    CAD = 'COMUN/DELEtbl2.ASP?cod=' + PRO
    CAD += '&pk1=PROTO&PK2=VERSION&tbl=protos'
    CAD += '&des=' + VER
    CAD += '&URL=../DETAcoti.ASP?POS=' + '<%=Request.QueryString("pos")%>'
    //alert(CAD)
    window.location.replace(CAD);
    return true;
}

function IMPRIMEC() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    PRO = trim(t.rows(pos).cells(1).innerText);
    VER = trim(t.rows(pos).cells(2).innerText);
    CAD = 'REPORTES/PRN_fichacotizacion.ASP?PRO=' + PRO + '&VER=' + VER

    //alert(CAD)
    window.open(CAD);
    return true;
}

//pagina de inicio
pag = 'detaCOTI.asp?cli=' + '<%=trim(request.QueryString("pos"))%>'
</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
