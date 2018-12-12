<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID = 2057 %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>


<script type="text/jscript" language="jscript">
    var chk = ''
    var marca = 0
    var oldrow = 1
    var url = 'pwdPE.asp?'
    var alias = 'clavePE'
    var TBL = 'clavePE'
    var PK = 'NUMORD'
    var DS = 'ALM'
    var largo = 10  // es el largo del PK (se usa en el dataentry)
    var largo2 = 4  // es el largo del descriptor
    var pagesize = 20
    var oldrow = 1
    var olddata = ''
    var chk = ''
    var ficha = 'PWDpE.asp?poS='
    mm = -1
    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);

        dd(ff);
    }
var oldrow=1
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNQRY2.asp"-->


<%Dim pageSize 
pageSize = 20 
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
urlBase = "PWDPE.ASP"
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************


oc = TRIM(REQUEST.QUERYSTRING("oc")) 
pe = TRIM(REQUEST.QUERYSTRING("pe")) 
CAD =	" SELECT top "&PAGESIZE&" *     " & _
        " FROM clavePE                  " & _
		" WHERE ESTADO = 'A'            " 
IF pos <> "" then cad = cad + " and  NUMORD >= '"&POS&"' " 
IF oc  <> "" then cad = cad + " and  NUMORD = '"&oc&"'   " 
IF pe  <> "" then cad = cad + " and  pe >= '"&pe&"'      " 
CAD = CAD + " ORDER BY NUMORD, ALM, PE,ITEM "

  
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
rec= '<%=rs.recordcount%>'
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
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="imagenes/ATRAS.gif" 
			style="cursor:hand;"
	onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=13');">
				
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			CLAVES SOBREATENCION PE
			</b></font>
		</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="imagenes/logo.GIF"  >
		  </TD>
        </TR>
	</tr>
	<TR><td COLSPAN=3><HR></td></TR>
</table>





<form name="thisForm" method="post" action="pwdPE.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" valign="top">
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
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top">
	    <%FOR i=0 TO columnas-1%>
		    <td class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></td>
	    <%NEXT%>
	    
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr>
		<td > 
			<img src="imagenes/primera.gif" style="cursor:hand;"
			onclick="primera('<%=urlBase%>')" 
			ALT="PRIMERA PAGINA">
		</td>
		<td >
			<IMG SRC="IMAGENES/PREV.GIF" ALT="PAGINA ANTERIOR"
				onclick="atras('TIPOMEDIDA', '<%=indice%>')" 
				STYLE="CURSOR:pointer"> 
		</td>
		<td >
			<img src= "imagenes/arriba.gif" ALT="REGISTRO ANTERIOR"
				onclick="retrocede()" STYLE="CURSOR:pointer"> 
		</td>
		<td >
			<img src="imagenes/abajo.gif" ALT="REGISTRO SIGUIENTE"
				onclick="avanza()"  STYLE="CURSOR:pointer"> 
			
		</td>
		<td>
			<img src="imagenes/next.gif" ALT="PAGINA SIGUIENTE"
				onclick="pagina('<%=urlBase%>'+'?pos=')" 
				STYLE="CURSOR:pointer"> 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<img src= "imagenes/ultima.gif" ALT="ULTIMA PAGINA"
			 onclick="ultima('<%=urlBase%>','<%=ALIAS%>',
			'<%=RS.Fields.Item(0).Name%>')" 
			style="cursor:pointer;"> 
		</td>

        
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>PO</b></font></td>
		<td><input id="kd" name="kd" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>PE</b></font></td>
		<td><input id="st" name="st" value="" /> </td>    
	  </tr>
      <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="return BUSQUE()">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%end if%>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

 


<script type="text/jscript" language="jscript">
   
    if (rec > 0)
        dd2('1');

    function BUSQUE() {

        if (trim(document.all.thisForm.kd.value) == '' && trim(document.all.thisForm.st.value) == '' ) {
            alert("Debe informar algun dato");
            window.thisForm.kd.focus();
        }
        ppo = strzero(trim(document.all.thisForm.kd.value), 10)
        pee = strzero(trim(document.all.thisForm.st.value), 11)
        //alert(ppr.indexOf('-'))
        
        cad = 'PWDPE.asp?pos=' + '<%=trim(pos) %>'
        cad += '&oc=' + ppo;
        cad += '&pe=' + pee;
       
        // alert(cad)
        window.location.replace(cad);

        return true
    }

</script>  

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>