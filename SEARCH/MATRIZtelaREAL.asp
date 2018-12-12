<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057%>
<%txtUsuario = Request.Cookies("Usuario")("USUARIO")
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
var url = '../MATRIZTELAREAL.asp?'
var alias = 'MATRIZ_COMPRA_TELA'
var TBL = 'MATRIZ_COMPRA_TELA'
var PK  = 'CODIGO'
var DS  = 'TIPO'
var largo = 1  // es el largo del PK (se usa en el dataentry)
var largo2 = 1  // es el largo del TIPO DE OC
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=15"
'****************************************
' Definir el tama�o de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "MATRIZ_COMPRA_TELA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "MATRIZTELAREAL.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "TIPO"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "MATRIZ DE DISTRIBUCION DE MOVIMIENTOS REAL PARA ORDEN DE COMPRA"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la p�gina donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERMATRIZ.asp?'

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
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<body>

<form name="thisForm" id="thisForm" method="post" action="COMUN/INSERMATRIZ.asp">

<table width="100%">
	<tr>
		<td align= "left" width="35%">
			<img src="imagenes/ATRAS.gif" 
			style="cursor:hand;" alt=""
			onclick="javascript: window.location.replace('<%=submenu%>');" />
			
		</td>
		<td align="center">
			<font face="arial" size="3" color='<%=(Application("titulo"))%>' ><b>
			<%=titulo%>
			</b></font>
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
CAD =	" SELECT * FROM "&ALIAS&"  ORDER BY TIPO, CODIGO  " 
		'response.Write(cad)
%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNMAT.ASP"-->
<%	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("TABLA SIN DATOS")	
		SINDATOS =0
		'RESPONSE.End()
	END IF	
%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
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
<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<table	width="100%" border="0" id="DATAENTRY"  style="display:none;">
   <tr>
   		<td>
            <table	align="center" width="100%" 
            cellpadding="1" cellspacing="0"  bgcolor="WHITE" border="1" >
              <tr valign="middle"> 
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>CODIGO </b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>TIPO OC </b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>MOVIMIENTO</b></font> </td> 
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>ALM ORIGEN</b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>ALM DESTINO</b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>ALM OLD</b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>COD. SERVICIO</b></font> </td> 
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>ENTREGA</b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>RECIBE </b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>LET 1 </b></font> </td>
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b>LET 2 </b></font> </td>
            </tr>
            <tr>
               <td><input type="text" id="COD" name="COD" class="DATOS" tabindex="-1" readonly="readonly" /></td>
               <td><input type="text" id="TIP" name="TIP" class="DATOS" maxlength="1" /></td>
               <td><input type="text" id="MOV" name="MOV" class="DATOS" maxlength="100" /></td>
               <td><input type="text" id="ORI" name="ORI" class="DATOS" maxlength="4" /></td>
               <td><input type="text" id="DES" name="DES" class="DATOS" maxlength="4" /></td>
               <td><input type="text" id="OLD" name="OLD" class="DATOS" maxlength="4" /></td>
               <td><input type="text" id="SER" name="SER" class="DATOS" maxlength="10" /></td>
               <td><input type="text" id="ENT" name="ENT" class="DATOS" maxlength="100" /></td>
               <td><input type="text" id="REC" name="REC" class="DATOS" maxlength="100" /></td>
               <td><input type="text" id="LT1" name="LT1" class="DATOS" maxlength="100" /></td>
               <td><input type="text" id="LT2" name="LT2" class="DATOS" maxlength="100" /></td>
              </tr>
            </table>
         </td>   
        </tr>
        <tr>
        <td>
<table border="0" align="center"  cellspacing="3">
    <tr>
        <td><img src="imagenes/PRINT.gif" alt="IMPRESION"
			onclick="imprime()"
			style="cursor:hand;" />	
	    </td>
        <td>
            <img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO"
                onclick="NUEVO_onclick()" style="cursor:hand;" />	
        </td>
        <td>		
            <img src="imagenes/DISK.gif" alt="GRABAR"
                onclick="GRABAR_onclick()" 
                style="cursor:hand;" />	
        </td>		
        		
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
		
		if (rec <= 0)
		{  NUEVO_onclick()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {thisForm.kod.maxLength=largo
		   
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
