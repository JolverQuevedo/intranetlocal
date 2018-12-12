<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057 %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../RAYADOS.asp?'
var alias = 'VIEW_RAYADOS'
var TBL = 'COLORES'
var PK  = 'CODIGO'
var DS  = 'DESCRIPCION'
var largo = 8  // es el largo del PK (se usa en el dataentry)
var largo2 = 100  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_RAYADOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "RAYADOS.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "TELA+CODIGO"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERRAYAS1.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

function ficha(cod, des) {
   // alert(document.all.marka.value)
    if (trim(document.all.marka.value) == '1') {
        cad = 'ficharayados.asp?pos=' + cod + ' &des=' + des
        window.open(cad)
    }
    else {
        alert("No puede ingresar combinaciones hasta que haya registrado la secuencia de colores y alturas...")
        return false;
    }
}

</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

</head>
<body>
<html xmlns="http://www.w3.org/1999/xhtml">
<form name="thisForm" id="thisForm" method="post" action="RAYADOS.asp">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNRAYAS.ASP"-->
<%
POS = Request.QueryString("POS")
tel = Request.QueryString("tel")
des = Request.QueryString("des")

if pos = "" or isnull(pos)  or pos = " " then	pos = ""
if des = "" or isnull(des)  or des = " " then	des = ""

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT * from VIEW_RAYADOS WHERE TELA = '"&tel&"' " & _
        "  ORDER BY  CODIGO           "
'response.write(cad)
 RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST

	ELSE
		RESPONSE.Write("<font color=Application('titulo')>")
		RESPONSE.Write("TABLA VACIA")	
		RESPONSE.Write("</font>")
		SINDATOS =0
		'RESPONSE.End()
	END IF	
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
'*********************************************************************%>
<table id="TABLA" align="center" bgcolor="<%=application("borde")%>"  cellpadding="2"  cellspacing="1"  border="0">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center" ><font face="arial" color="<%=APPLICATION("COLOR2")%>" size="1"><b><%=TRIM(RS.FIELDS(I).NAME)%></b></font></td>
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
	                onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
	                ondblclick="ficha('<%=rs("codigo")%>','<%=rs("descripcion")%>')">       
		    <%for i=0 to LIMITE%>
			    <td class="DESCRIPTORnavy" ><%=TRIM(RS.FIELDS.ITEM(I))%></b>&nbsp;</td>
	  	    <%NEXT%>	
		    <%RS.MOVENEXT%>
		    <%CONT = CONT + 1%>
        </tr>
	<%loop%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
	  <td><img src="imagenes/primera.gif" alt="PRIMERA PAGINA"     style="cursor:pointer;" onClick="primera('<%=urlBase%>')" /></td>
	  <td><img src="IMAGENES/PREV.GIF"    alt="PAGINA ANTERIOR"    style="CURSOR:pointer;" onClick="atras(alias, '<%=indice%>')" /></td>
	  <td><img src="imagenes/arriba.gif"  alt="REGISTRO ANTERIOR"  style="CURSOR:pointer;" onClick="retrocede()" /></td>
	  <td><img src="imagenes/abajo.gif"   alt="REGISTRO SIGUIENTE" style="CURSOR:pointer;" onClick="avanza()" /></td>
	  <td><img src="imagenes/next.gif"    alt="PAGINA SIGUIENTE"   style="CURSOR:pointer;" onclick="pagina('<%=urlBase%>'+'?pos=')" /></td>
	  <td><img src="imagenes/ultima.gif"  alt="ULTIMA PAGINA"      style="cursor:pointer;" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" /></td>
	  <td><img src="imagenes/PRINT.gif"   alt="IMPRESION"          style="cursor:pointer;" onClick="imprime()"  /></td>
      <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	  <td id="seeker" name="seeker" style="display:none">
	        <table align="center" width="100%" bordercolor="#<%=application("color2")%>" bgcolor="<%=application("color1")%>" 
	         cellpadding="0"  cellspacing="1"  border="1">
	          <tr>  
	                <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		                <b><%=pk%></b></font></td>
		            <td><input id="kod" name="kod" value="" /></td>    
	          </tr>
	          <tr>  
	                <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		                <b><%=DS%></b></font></td>
		            <td><input id="ds" name="ds" value="" /></td>    
	          </tr>
	          <tr>  
	                <td align="center" style="cursor:hand" onClick="document.all.seeker.style.display='none'"><font face="arial" color="red" size="1">
		                <b><u>(X) Cerrar</u></b></font></td>
		            <td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:hand" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		                <font face="arial" color='<%=Application("Titulo")%>' size="1"><b><U>FILTRAR</U></b></font></td>
	          </tr>
	         </table> 
	    </td>	
	</tr>
	</table>
<%END IF %>
<iframe frameborder="0" style="visibility:visible" height="1" width="1" id="ACTIV" name="ACTIV"></iframe>
<%Set   RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.CursorType       = 3 'CONST adOpenStatic = 3
		RS2.LockType         = 1 'CONST adReadOnly = 1 %>
 <input id="marka"       name="marka" style="display:none" />
<table border="0" id="DATAENTRY" style="display:block;" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>">
     <tr>            
	    <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">CODIGO :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
            <input type="text" id="COD" name="COD" style="width:100%" readonly="readonly" class="datos" /></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="DESCRIPTORnavy">DESCRIPCION :</td>
        <td width="55%" bgcolor="<%=(Application("color2"))%>" colspan="3"> 
            <input type="text" id="DES" name="DES" class="datos"/></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="DESCRIPTORnavy">CLIENTE :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%"> 
           <select id="CLI"  name="CLI" class="datos">
               <option></option>
                <%CAD = "select CODIGO, NOMBRE from CLIENTE WHERE ESTADO='A' ORDER BY NOMBRE"
                RS2.OPEN CAD, Cnn %>
                <%if rs2.recordcount <=0 then%>
                     <option value=''>No Hay Clientes Registradoas </option>
                <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                            <option value="<%=rs2("CODIGO")%>"><%=trim(ucase(rs2("NOMBRE")))%> </option>
                    <%rs2.movenext%>
                    <%loop%>
              <%end if %>
              <%rs2.close%>
            </select>
        </td>      
    </tr>
    <tr>             
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">COD CLI :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
            <input type="text" id="COL" name="COL" class="datos" /></td>  
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy"># COLORES :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
       	    <input type="text" id="NUME" name="NUME" class="datos" onchange="isInt(toInt(this.value))"/></td>        
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">RAPPORT CMS :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
       	    <input type="text" id="RAP" name="RAP" class="datos" /></td> 
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy"># FRANJAS :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"><input type="text" id="FRA" name="FRA" class="datos" /></td> 
    </tr>
    <tr>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">OBSERVACION :</td>
        <td bgcolor="<%=(Application("color2"))%>"  colspan="7"><input type="text" id="OBS" name="OBS" class="datos" maxlength="100"/></td> 
    </tr>
    <tr bgcolor="<%=application("color2") %>">
        <td colspan="8">
	        <table border="0" align="center" cellspacing="3">
                <tr>
                    <td><img src="imagenes/NEW.gif"    alt="REGISTRO EN BLANCO" onClick="NUEVO_onclick()" style="cursor:pointer;" /></td>
                    <td><img src="imagenes/DISK.gif"   alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:pointer;" /></td>		
                    <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:pointer;" /></td>		
                </tr>
            </table>
        </td>
    </tr>
</table>
<input type="text" value="<%=TEL %>" id="TEL" name="TEL" style="visibility:hidden"/>
<script type="text/jscript" language="jscript">

rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
    dd2('1');

chk='4'
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("DATAENTRY.style.display='block'");
		thisForm.COD.maxLength = largo;
		thisForm.DES.maxLength = largo2;
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {thisForm.kod.maxLength = largo;
		    }
}


</script>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>
