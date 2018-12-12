<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057 %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>

<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm = -1
var TBL = 'asigna_cct'
var alias = 'asigna_cct'
var url = 'detasigna.asp'
var PK = 'PAR'
var DS = 'TEL'
var chk = '0'
var largo = 10
var pagesize = 20
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/funcionescomunes.ASP"-->
<!--#include file="COMUN/COMUNtblCCT.ASP"-->
<%Dim pageSize 
	pageSize = 20
' Captura la posición inicial del browse

' recibe tabla, primary key, y descripcion
tbl = "ASIGNA_CCT"
tabla = ucase("ASIGNA_CCT")
cli = request.QueryString("cli")
pos = request.QueryString("pos")
tel = request.QueryString("tel")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
if tel = "" or isnull(tel)  or tel = " " then
	tel = ""
end if


'CAD =	" SELECT    *   " & _
CAD =	" SELECT  top "&pagesize&"  *   " & _
		" from ASIGNA_CCT WHERE         " & _
        " cli    = '"&CLI&"'            "
if len(trim(tel)) > 0 then 
    cad = cad + " and tel >= '"&tel&"'  ORDER BY tel " 
else
    cad = cad + " and par >= '"&pos&"'  ORDER BY par " 
end if
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
<%for I=0 to columnas-5 %>
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
        <%IF CDBL(RS("SALDO")) <= 2 then
            col = "red"
        elseif cdbl(rs("kgs")) > CDBL(RS("SALDO")) then
            col = "green"
        else
            col="navy"
        end if%>

		    <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			    onclick="dd('<%=(cont)%>')" ondblclick="ficha2()" id="fila<%=Trim(Cstr(cont))%>" >
             
	    <%FOR i=0 TO columnas-5%>
		    <td><span  class="texto" style ="color:'<%=COL%>'"><%=TRIM(RS.FIELDS.ITEM(I))%></span> </td>
	    <%NEXT%>
	    </tr>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
    <%LOOP%>
<%end if%>
</table>  
<iframe src='' frameborder="1" id="bake" name="bake" style="display:none"></iframe>
<input id="COD" style="display:none" type="text" />
<input id="DES" style="display:none" type="text" />
<input id="CCT" style="display:none" type="text" />
<input id="CLI" style="display:none" type="text" value='<%=cli%>'/>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera()" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras()" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina()" style="cursor:pointer" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:pointer;" /></td>
      <td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:pointer;" /></td> 
	   
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>PAR</b></font></td>
		<td><input id="kod" name="kod" value=""/> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Tela</b></font></td>
		<td><input id="tel" name="tel" value="" /> </td>    
	  </tr>
	  
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align='center' style="cursor:pointer" onClick="BUSCA()">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>

  <table align="center" cellpadding="1" cellspacing="4" border="0" >
        <tr  class="DESCRIPTORnegro" ><td style="background-color:Red" width="20px">&nbsp;</td>
          <td>Asignado TOTAL</td>
        <td style="background-color:green" width="20px">&nbsp;</td>
          <td>Asignado PARCIAL</td>
        
        <td style="background-color:navy" width="20px">&nbsp;</td>
          <td>SIN Asignar</td>
        </tr>
    </table>




<%rs.close%>

<script>
	if (marca == 0)
		dd('1');
function LLENA(pos,t)
{   thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText);
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.COD.readOnly= true
}

</script>    
<%IF txtPerfil = 1 THEN%>
<script language="jscript" type="text/jscript"> 
	
</script>
<%END IF%>

<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
