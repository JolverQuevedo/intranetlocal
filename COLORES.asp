<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
	<!--#include file="includes/Cnn.inc"-->
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<script type="text/jscript" language="jscript">

// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../COLORES.asp?'
var alias = 'VIEW_COLORES'
var TBL = 'COLORES'
var PK  = 'CODIGO'
var DS  = 'DESCRIPCION'
var largo = 8  // es el largo del PK (se usa en el dataentry)
var largo2 = 100  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=3"
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_COLORES"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "COLORES.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "MAESTRO DE COLORES"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERCOLORES.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<form name="thisForm" id="thisForm" method="post" action="COLORES.asp">
<table width="100%">
	<tr>
		<td align= "left" width="35%"><img src="imagenes/ATRAS.gif" style="cursor:hand;" alt="" onClick="javascript: window.location.replace('<%=submenu%>');" /></td>
		<td align="center">
	        <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center"	width="100%" bordercolorlight="#f7d975">
	            <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
	        </table>
		</td>
		<td align="right" width="35%"><img src="imagenes/logo.GIF" alt="" /></td>
	</tr>
	<%Set   RS3 = Server.CreateObject("ADODB.Recordset")
						RS3.ActiveConnection = Cnn
						RS3.CursorType       = 3 'CONST adOpenStatic = 3
						RS3.LockType         = 1 'CONST adReadOnly = 1 %>
			  <!--agregar consulta filtrada por cliente-->
			  <tr style="text-align:center">
					  
					  <td colspan="3">
							<select name="CLIEFILTRO" id="CLIEFILTRO" onchange="BUSCA('<%=urlBase%>','<%=alias%>')">
								<option></option>
								<%CAD = "select CODIGO, NOMBRE from CLIENTE WHERE ESTADO='A' ORDER BY NOMBRE"
									RS3.OPEN CAD, Cnn %>
									<%if RS3.recordcount <=0 then%>
										<option value=''>No Hay Clientes Registradoas </option>
									<%else%>
										<%RS3.movefirst%>
										<%do while not RS3.eof%>
												<option value="<%=RS3("CODIGO")%>"><%=(ucase(RS3("NOMBRE")))%> </option>
										<%RS3.movenext%>
										<%loop%>
								<%end if %>
								<%RS3.close%>
							</select>
					  </td>
			  </tr>
	<tr>
	    <td colspan="3"><hr /></td>
	</tr>
</table>
<%
POS = Request.QueryString("pos")

if pos = "" or isnull(pos)  or pos = " " then	pos = ""

clifil = Request.QueryString("clifil")
if clifil = "" or isnull(clifil)  or clifil = " " then	clifil = ""

des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then	des = ""

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pagesize&" * " & _
		" from "&ALIAS&"  WHERE " & _
        " EDO = 'A' and CODCLI = '"&clifil&"' and "
        if len(TRIM(DES))>0 then
            cad = cad + " (COLCLI LIKE '%"&DES&"%' OR DESCRIPCION LIKE '%"&DES&"%') " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " "&indice&" >= '"& POS &"'" & _
            " ORDER BY "& indice &"  " 
        end if
        response.write(cad)
%>

<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNCOLORES.ASP"-->
<%  RS.Open CAD, Cnn
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
<table id="TABLA" align="center"  width="100%" bordercolor="<%=application("color2")%>"
	  bgcolor="<%=application("borde")%>"  cellpadding="2"  cellspacing="1"  border="1">
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >       
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
		<td><img src="imagenes/primera.gif" style="cursor:hand;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR" onClick="atras(alias, '<%=indice%>')" style="CURSOR:HAND" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE"	onclick="pagina('<%=urlBase%>'+'?pos=')" style="CURSOR:HAND" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>', '<%=RS.Fields.Item(0).Name%>')" 
		    style="cursor:hand;" /></td>
	    <td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:hand;" /></td>
        <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:hand;" /></td>
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
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<%Set   RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.CursorType       = 3 'CONST adOpenStatic = 3
		RS2.LockType         = 1 'CONST adReadOnly = 1 %>

<table border="1" id="DATAENTRY" style="display:block;" width="100%" cellpadding="1" cellspacing="0" bgcolor="<%=application("color2")%>">
     <tr>            
	    <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">CODIGO :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
        	    <input type="text" id="COD" name="COD" style="width:100%" readonly="readonly" /></td>
        
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="DESCRIPTORnavy">TONO :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="5%" > 
           <select id="TON" style="width:100%" name="TON" class="datos">
               <option></option>
                <%CAD = "SELECT * FROM TONOS WHERE ESTADO = 'A' and tono < '99' ORDER BY destono"
                RS2.OPEN CAD, Cnn %>
                <%if rs2.recordcount <=0 then%>
                     <option value=''>No Hay TONOS Registradas</option>
                <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                         <option value="<%=rs2("TONO")%>"><%=rtrim(ltrim(ucase(rs2("desTONO"))))%></option>
                    <%rs2.movenext%>
                    <%loop%>
              <%end if %>
              <%rs2.close%>
            </select>
        </td>
     <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="DESCRIPTORnavy">TIPO TE&Ntilde;IDO :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="10%" colspan="1"> 
           <select id="TEN" style="width:100%" name="TEN" class="datos">
               <option></option>
                <%CAD = "select * from TENIDO WHERE ESTADO='A' ORDER BY DESTENIDO"
                RS2.OPEN CAD, Cnn %>
                <%if rs2.recordcount <=0 then%>
                     <option value=''>No Hay Tipos de Teñido Registrados </option>
                <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                            <option value="<%=rs2("TENIDO")%>"><%=(ucase(rs2("DESTENIDO")))%> </option>
                    <%rs2.movenext%>
                    <%loop%>
                <%end if %>
              <%rs2.close%>
            </select>
        </td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="DESCRIPTORnavy">CLIENTE :</td>
        <td bgcolor="<%=(Application("color2"))%>" width="10%" colspan="1"> 
           <select id="CLI" style="width:100%" name="CLI" class="datos">
               <option></option>
                <%CAD = "select CODIGO, NOMBRE from CLIENTE WHERE ESTADO='A' ORDER BY NOMBRE"
                RS2.OPEN CAD, Cnn %>
                <%if rs2.recordcount <=0 then%>
                     <option value=''>No Hay Clientes Registradoas </option>
                <%else%>
                    <%rs2.movefirst%>
                    <%do while not rs2.eof%>
                            <option value="<%=rs2("CODIGO")%>"><%=(ucase(rs2("NOMBRE")))%> </option>
                    <%rs2.movenext%>
                    <%loop%>
              <%end if %>
              <%rs2.close%>
            </select>
        </td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="right" class="DESCRIPTORnavy">COD CLI :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="5%"> 
        	    <input type="text" id="COL" name="COL" style="width:100%" /></td>
	</tr>
	
	
    <tr>
	     <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="DESCRIPTORnavy">DESCRIPCION :</td>
         <td width="5%" bgcolor="<%=(Application("color2"))%>" colspan="9"> 
              <input type="text" id="DES" name="DES" style="width:100%" /></td>
    </tr>
    <tr>
        <td colspan="10">
	        <table border="0" align="center" cellspacing="3">
                <tr>
                    <td><img src="imagenes/NEW.gif"    alt="REGISTRO EN BLANCO" onClick="NUEVO_onclick()" style="cursor:hand;" /></td>
                    <td><img src="imagenes/DISK.gif"   alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:hand;" /></td>		
                    <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:hand;" /></td>		
                </tr>
            </table>
        </td>
    </tr>
</table>
<script type="text/jscript" language="jscript">

rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
dd2('1');
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("DATAENTRY.style.display='block'");
		thisForm.COD.maxLength=largo
		thisForm.DES.maxLength=largo2
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {   thisForm.kod.maxLength=largo
		        //thisForm.ds.maxLength=largo2
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
