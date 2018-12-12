<%@ Language=VBScript%>
<% Response.Buffer = true%>
<%Session.LCID=2057%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/navegacion2.inc"-->
<!--#include file="COMUN/COMUNdetaRSV.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->  
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow = 1
var url = '../detaRESERVA.asp?'
var alias = 'VIEW_RESERVAS'
var TBL = 'RSV_TELA'
var PK = 'CODIGO'
var DS = 'estilo'
var largo = 10  // es el largo del PK (se usa en el dataentry)
var largo2 = 50  // es el largo del descriptor

var oldrow = 1
var olddata = ''
var chk = ''
var ficha = 'ficharsv.asp?po='
mm = -1
// necesito la misma variable en jscript y vbscript para la navegacion
var pagesize = 50
</script>
<%Dim pageSize 
pageSize = 50

'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_RESERVAS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "OFI"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "detaRESERVA.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "OFI"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "ESTCLI"

' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
OFI = Request.QueryString("OFI")
if OFI = "" or isnull(OFI)  or OFI = " " then
	OFI = ""
end if
COD = Request.QueryString("COD")
if COD = "" or isnull(COD)  or COD = " " then
	COD = ""
end if

pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if
EST = Request.QueryString("EST")
if EST = "" or isnull(EST)  or EST = " " then
	EST = ""
end if
'****************************************************
' si viene del buscador hay que ver si existe la PO
' sino, se manda mensaje y se pone en la primera PO
'****************************************************
cad = "select CODIGO from OFIS where CODIGO = '"&oFI&"' and cliente = '"&pos&"'"
rs.open cad, cnn
if rs.recordcount <=0 then ofi = ""
rs.close

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top "&pagesize&" CODIGO, OFI, COTI, AJUSTE, VER, RIGHT(LTRIM(RTRIM(cart)),5) AS PRENDA, ESTCLI,   " & _
        " PEDIDO, TIPO, PO, ALM , KG AS RSV_K, QT AS RSV_Q , CODEST, CLI, FOT,  CON FROM VIEW_RESERVAS AS T1" & _
        " WHERE CLI   = '"&POS&"'  AND estado = 'R' and "

IF   LEN(pro) > 0  THEN
    cad = cad + " AJUSTE >= '"&pro&"'	ORDER BY AJUSTE, ver, ofi" 
ELSEIF LEN(EST)> 0 THEN
    cad = cad + " estcli >= '"&EST&"'	ORDER BY estcli, ofi    " 
ELSE
    cad = cad + " CODIGO >= '"&COD&"'	ORDER BY CODIGO     " 
END IF
  

	   '	response.Write(cad)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
    mm = '<%=rs.recordcount%>'
    var funcionalidad = ''


</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title></title>
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
    <%for I=0 to columnas-3 %>
	    <td align="center">
		    <font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font>
	    </td>
    <%next%>
	<td><font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font></td> 
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')" align="center">
	    <%FOR i=0 TO columnas-3%>
		    <td class="texto"><%=UCASE(TRIM(RS.FIELDS.ITEM(I))) %></td>
	    <%NEXT%>
	   <td><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=POS%>" width="30" /></td> 
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras(alias, '<%=indice%>')" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=urlBase%>'+'?pos=')" style="cursor:pointer" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:pointer;" /></td>

       
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=pk%></b></font></td>
		<td><input id="kod" name="kod" value=""/> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Estilo</b></font></td>
		<td><input id="est" name="est" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Proto</b></font></td>
		<td><input id="pro" name="pro" value=""/> </td>    
	  </tr>
	  
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%end if%>


<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<%rs.close%>

<script language="jscript" type="text/jscript">
if (marca == 0)
    dd('1');

function NUEVO() {
  //  window.open('fichaofi.asp?PO=AUTO&cli=' + '<%=pos%>' )
    return true;
}

function elimina(ff) 
{   return true;    }

function LLENA(ff)
{   return true;    }

function EDITA(ff)
{ var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    COD = ltrim(t.rows(pos).cells(0).innerText);
    OFI = ltrim(t.rows(pos).cells(1).innerText);
    TIP = ltrim(t.rows(pos).cells(8).innerText);
    POS = ltrim(t.rows(pos).cells(9).innerText);
    ALM = ltrim(t.rows(pos).cells(10).innerText);
    CLI = ltrim(t.rows(pos).cells(14).innerText);

    CAD = 'fichaRSV.asp?POS=' + POS + '&cli=' + CLI + '&COD=' + COD + '&OFI=' + OFI + '&TIP=' + TIP + '&ALM=' + ALM
    //alert(CAD)
    window.open(CAD)
    return true;
}
//pagina de inicio
pag = 'detaRESERVA.asp?cli=' + '<%=trim(request.QueryString("pos"))%>'
</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
