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
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=0;
var url = '../TELAS.asp?'
var alias = 'VIEW_TELAS'
var TBL = 'TELAS'
var PK  = 'TELA'
var DS  = 'DESCRIPCION'
var largo = 6  // es el largo del PK (se usa en el dataentry)
var largo2 = 150  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
var ficha = 'fichatelas.asp?tel='
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
alias = "VIEW_TELAS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "TELA"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "TELAS.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "TELA"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "MAESTRO DE TELAS CRUDAS"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/deleTBL.asp?'
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<form name="thisForm" id="thisForm" method="post" action=funcionalidad>
<table width="100%">
	<tr>
		<td align= "left" width="35%">
			<img src="imagenes/ATRAS.gif" 
			style="cursor:hand;" alt=""
			onclick="javascript: window.location.replace('<%=submenu%>');" />
		</td>
		<td align="center">
		<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center"
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b>
			<%=titulo%>
			</b></font></td>
		    </tr>
		</table>
			
		</td>
		<td align="right" width="35%">
		  	<img src="imagenes/logo.GIF" alt="" />
		  </td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then
	des = ""
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pagesize&"  " & _
        " TELA, DESCRIPCION,        " & _
        " STDES AS STAT             " &_
		" from "&ALIAS&"  WHERE     " & _
        " ESTADO = 'A' and          "
        
        if len(TRIM(DES))>0 then
            cad = cad + " "&DS&" >= '"&DES&"' " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " "&indice&" >= '"& POS &"'" & _
            " ORDER BY "& indice &"  " 
        end if
        'response.write(cad)
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNmaestros.ASP"-->
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
columnas = rs.Fields.Count - 1
'*********************************************************************%>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >

    <%'LINEA DE CABECERA STANDAR %>
    <%	lIMITE =  COLUMNAS%>
    <tr bgcolor='<%=Application("Titulo")%>' >
        <%for I=0 to LIMITE %>  
	        <td align="center"><font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(I).NAME%></b></font></td>
        <%next%>	
    </tr>

    <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="fichas()" >       
	    <%for i=0 to LIMITE%>
		    <td >
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
		<td><img src="imagenes/primera.gif" style="cursor:hand;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras(alias, '<%=indice%>')" style="CURSOR:HAND" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="CURSOR:HAND" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="CURSOR:HAND" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=urlBase%>'+'?pos=')" style="CURSOR:HAND" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:hand;" /></td>
        <td><img src="imagenes/RUTA.jpg" alt="Ficha Técnica" onClick="RUTAS()" style="cursor:hand;" /></td>	
	    <td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:hand;" /></td>
         <td><img src="imagenes/rayas.jpg" alt="Ficha Listados" onClick="rayas()" style="cursor:hand;" /></td>
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:hand;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=pk%></b></font></td>
		<td><input id="kod" name="kod" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=DS%></b></font></td>
		<td><input id="ds" name="ds" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:hand" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:hand" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="100%" id="ACTIV" name="ACTIV"></iframe>
<table	width="100%" border="0" id="DATAENTRY"  style="display:none;">
  <tr>
        <td>
            <table border="0" align="center"  cellspacing="3">
                <tr>
                    <td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onclick="NUEVO_onclick()" style="cursor:hand;" /></td>
                    <td><img src="imagenes/protover.jpg"  alt="DUPLICA ARTICULO" onclick="DUPLICA()" style="cursor:hand;" /></td>
                    <td><img src="imagenes/RUTA.jpg" alt="Ficha Técnica" onClick="RUTAS()" style="cursor:hand;" /></td>	
					<td><img src="imagenes/ligaduras.jpg" alt="Ficha Ligaduras" onClick="ligadura()" style="cursor:hand;" /></td>
					<td><img src="imagenes/RECTIL.jpg" alt="Ficha Rectilineos" onClick="rectos()" style="cursor:hand;" /></td>
                    <td><img src="imagenes/rayas.jpg" alt="Ficha Listados" onClick="rayas()" style="cursor:hand;" /></td>
                    <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onclick="elimina()" style="cursor:hand;" /></td> 
                    <td style="display:'NONE'"><input name="COD" id="COD" value="" /><input name="DES" id="DES" value="" /></td>		
                </tr>
            </table>
        </td>
    </tr>
</table>
<script type="text/jscript" language="jscript">
var opc = "directories=yes,status=yes,titlebar=yes,toolbar=YES,hotkeys=no,location=yes,";
opc += "menubar=YES,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
    dd2('1');
function DUPLICA() {
    USR = '<%=usuario %>'
    COD = trim(thisForm.COD.value)
  /*  document.all.ACTIV.style.visibility='visible' */
  document.all.ACTIV.src='comun/duplicatela.asp?cod='+COD+'&usr='+USR

}

function rayas() {
CAD = "raya-FRAME.ASP?COD="+ trim(thisForm.COD.value)
    window.open(CAD, "Listados", opc)
}

function rectos()
{ if(Left(trim(thisForm.COD.value),1) < '7')
    {   alert("Este artículo no es un Rectilineo");
        return false;
    }
    
    cad  = "rectilineos.asp?COD="+ trim(thisForm.COD.value)
    cad += "&DEK=" + rtrim(ltrim(thisForm.DES.value))
    window.open(cad,"Rectilineos",opc)
}

function RUTAS()
{   cad  = "TELArutaHEAD.asp?COD="+ trim(thisForm.COD.value)
    cad += "&DEK=" + rtrim(ltrim(thisForm.DES.value))
window.open(cad)
}
function ligadura()
{   cad  = "fichaligadura.asp?tel="+ trim(thisForm.COD.value)
    cad += "&DEK=" + rtrim(ltrim(thisForm.DES.value))
window.open(cad)
}


</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("DATAENTRY.style.display='block'");
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {   thisForm.kod.maxLength=largo
		        thisForm.ds.maxLength=largo2
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
