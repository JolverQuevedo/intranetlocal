<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
    <link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../detadestin.asp?'
var alias = 'destinos'
var TBL = 'DESTINOS'
var PK  = 'CODIGO'
var DS  = 'NOMBRE'
var largo = 4  // es el largo del PK (se usa en el dataentry)
var largo2 = 100  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado

Dim ALIAS					' Define el NOMBRE de la Tabla base
alias = "DESTINOS"
Dim indice  				' Define el NOMBRE de la columna del ORDER BY
indice = "CODIGO"
Dim urlBase   				' Define el NOMBRE de la PAGINA ASP de inicio
urlBase = "DETADESTIN.asp"
Dim pk						' Define el nombre del Primary Key
pk = "CODIGO"
Dim ds						' Define nombre de la columna descriptor
ds = "NOMBRE"

Dim pagesize 				' Define el tamaño de la pagina
pagesize = 10 
%>
<script type="text/jscript" language="jscript">
var funcionalidad = 'comun/INSERDESTIN.asp?'	//  Indica el nombre de la página donde se realizan los cambios 
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNDEST.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title><%=titulo%></title>

</head>

<body>
<form name="thisForm" id="thisForm" method="post" action="INSERDEESTIN.asp">

<%CLI = Request.QueryString("CLI")
POS = Request.QueryString("POS")
if POS = "" or isnull(POS)  or POS = " " then
	POS = ""
end if
des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then
	des = ""
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pagesize&"  " & _
		" "&pk&","&ds&",DIRECCION, ZIPCODE, PAIS, " & _ 
		" USUARIO, FECHA, ESTADO AS EDO " & _
		" from "&ALIAS&"  WHERE " & _
        " ESTADO = 'A' and CLIENTE = '"&CLI&"' AND "
        if len(TRIM(DES))>0 then
            cad = cad + " "&DS&" >= '"&DES&"' " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " "&indice&" >= '"& POS &"'" & _
            " ORDER BY "& indice &"  " 
        end if
		'response.Write(CLI)

	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("TABLA SIN DATOS")	
		SINDATOS =0
		'RESPONSE.End()
	END IF	
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count %>
<%'*********************************************************************%>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%	IF NIVEL > 1 THEN LIMITE =  rs.fields.count - 3 ELSE  LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>

    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
	<%for i=0 to LIMITE%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=RS.FIELDS.ITEM(I)%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:hand;" onClick="primera('<%=cli%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR" onClick="atras(alias, '<%=indice%>')" style="CURSOR:HAND" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=urlBase%>'+'?pos=')" style="CURSOR:HAND" /></td>
	  <% 'PARA LA FUNCION ULTIMA : enviar el nombre de la página de retorno, el nombre de la tabla , el nombre de la columna de primary key %>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:hand;" /></td>
	<td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:hand;" /></td>
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:hand;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF" bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=pk%></b></font></td>
		<td><input id="kod" name="kod" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor="<%=Application("COLOR2")%>"><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=DS%></b></font></td>
		<td><input id="ds" name="ds" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor="<%=Application("COLOR2")%>" align="center" style="cursor:hand" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:hand" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1"><b><u>FILTRAR</u></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%END IF %>
<iframe frameborder="1" style="display:none" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>

<table width="100%" border="1" id="ENTRY" cellpadding="0" cellspacing="1" bgcolor="<%=application("color2") %>" style="border-bottom-color:'<%=(Application("color1"))%>';display:none" >
   <tr style="height:25px; vertical-align:middle">
   	    <td width="5%" bgcolor="<%=(Application("barra"))%>" class="DESCRIPTORnavyBOLD">ID :</td>
        <td width="5%" ><input type="text" id="COD" name="COD" class="DATOS" style="width:100%" tabindex="-1" readonly="readonly" maxlength="3"  /></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" class="DESCRIPTORnavyBOLD">DESTINO : </td>
        <td bgcolor="#FFFFFF" colspan="3" WIDTH="60%"> <input type="text" id="DES" name="DES" class="DATOS"  style="width:100%"  /></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>"  class="DESCRIPTORnavyBOLD">PAIS :</td>
        <td bgcolor="WHITE" width="10%" valign="middle"> 
        <%Set   RS2 = Server.CreateObject("ADODB.Recordset")
	    RS2.ActiveConnection = Cnn
	    RS2.CursorType       = 3 'CONST adOpenStatic = 3
	    RS2.LockType         = 1 'CONST adReadOnly = 1 %>
            <select type="text" id="PAIS" name="PAIS" class="DATOS">
            <option></option>
            <% cad = "SELECT * FROM PAISES order by 2   " 
			    rs2.open cad, cnn%>
                <%RS2.MOVEFIRST %>
                <%DO WHILE NOT RS2.EOF %>
                <option value="<%=rs2("CODIGO")%>"><%=(ucase(rs2("NOMBRE")))%> </option>
                <%rs2.movenext%>
                <%loop%>

            <%rs2.close%>
            </select>
        </td>
    </tr>
   <tr style="height:25px; vertical-align:middle">
        <td width="3%" bgcolor="<%=(Application("barra"))%>"  class="DESCRIPTORnavyBOLD">DIRECCION :</td>
        <td bgcolor="WHITE" width="5%" valign="middle" colspan="5"><input type="text" id="DIR" name="DIR" class="DATOS" style="width:100%" /></td>                
            <td width="5%" bgcolor="<%=(Application("barra"))%>"  class="DESCRIPTORnavyBOLD">ZIPCODE :</td>
            <td bgcolor="WHITE" width="5%" valign="middle"> <input type="text" id="ZIPC" name="ZIPC" class="DATOS" style="width:100%"  /></td>      
    </tr>
</table>
         
<table border="0" align="center"  cellspacing="3">
    <tr><td><input id="CLI" value="<%=cli%>" style="display:none"/></td>
        <td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onClick="NUEVO_onclick()" style="cursor:hand;" /></td>
        <td><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:hand;" /></td>		
        <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:hand;" /></td>		
    </tr>
</table>
<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
dd2('1');
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("ENTRY.style.display='block'");
    if (rec <= 0)
         NUEVO_onclick()
		  
	</script>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
