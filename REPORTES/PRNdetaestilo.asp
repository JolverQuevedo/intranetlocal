<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
   
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1
var oldrow = 1
</script>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%Dim pageSize 
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
est = Request.QueryString("est")
if est = "" or isnull(est)  or est = " " then
	est = ""
end if

' necesito saber si LA PAGINA fue llamado desde el PROTO y devolver los resultados a LA 
' FICHA-PROTO O ES PARA EDITAR EL ESTILO
' EN CUYO CASO NO EXISTE EL PARAMETRO...
HLP = Request.QueryString("HLP")
if len(trim(HLP)) = 0 then HLP = 0
ESTCLI = REQUEST.QueryString("ESTCLI")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  top 10              			" & _
		" CODEST, ESTCLI, estilos.DESCRIPCION,  " & _
		" OBSERVACION, CODARTICULO,DESMODELADOR," & _
		" ESTILOS.GENERO AS CGEN, T3.DESCRIPCION" & _
		" AS DESGEN, ESTILOS.tipoprenda as TPRE," & _
		" T2.DESCRIPCION AS  TIPOPRENDA, 	    " & _
		"  CONTENIDO, FOTO			            " & _
		" from ESTILOS INNER JOIN				" & _
		" TIPPRENDA AS T2 ON TIPOPRENDA 		" & _
		" = T2.TIPO INNER JOIN GENEROS			" & _
		" AS T3 ON ESTILOS.GENERO = T3.GENERO	" & _
		" WHERE ESTILOS.ESTADO = 'A'    		" & _
        " and cliente   = '"&POS&"'     		"
IF LEN(TRIM(ESTCLI)) > 0 THEN  
    CAD = CAD +   " and ltrim(rtrim(ESTCLI)) >= '"&ESTCLI&"' order by estcli" 
else   
 CAD = CAD +   " and codest >= '"&est&"'   order by codest " 
 end if
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
    clien = '<%=pos%>'
    pos = '<%=pos%>'
//alert(clien)
mm= '<%=rs.recordcount%>'
// lo necesito para saber si fue llamado desde el PROTO y devolver los resultados a LA FICHA
HLP = parseInt('<%=HLP%>',10)
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title><%=tabla%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<iframe  width="100%" src="" id="bake" name="bake" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<form name="thisForm" method="post" action="" onsubmit="manda()">
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST
cont= 1 %>


<table border="0" align="center"  cellspacing="5">
	<tr valign="middle">
        <td  bgcolor="#0087d1"> <font face="arial" color="IVORY" size="2">
		    <b>&nbsp;Ingrese el estilo a buscar&nbsp;:&nbsp;</b></font> </td>
		<td><input id="kod" name="kod" value="" /> </td>    
		<td>
		<input type="submit" value="BUSCAR" /> </td>
    </tr>
</table> 


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
	<td align="center" style="display:none"><%=RS.FIELDS(i).NAME%></td>
	<td align="center" style="display:block"><font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(i+1).NAME%></b></font></td>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>

    <%DO WHILE NOT RS.EOF %>
	    <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')">
	        <%FOR i=0 TO columnas-3%>
		        <td class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></td>
	        <%NEXT%>
	        <td align="center" style="display:none"><%=RS.FIELDS(i).NAME%></td>
            <td><img src="../BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=POS%>" HEIGHT="40" /></td> 
        </tr>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
    <%LOOP%>
</table>


<%end if%>
<%rs.close%>
<script>

    if (marca == 0 || HLP == 1)
        dd('1');		
			
function BUSCA(url, alias) {
    if (trim(window.thisForm.kod.value) == '' ) {
        alert("Debe informar el Código o la descripción");
        window.thisForm.kod.focus();
    }
    cad = 'PRNdetaestilo.asp?pos=' +'<%=trim(request.QueryString("pos"))%>' + '&estCLI='+ trim(window.thisForm.kod.value)+ '&hlp=' + '<%=hlp%>'
    window.location.replace(cad);
    return true;
}
function manda() {
    cad = 'PRNdetaestilo.asp?pos=' + '<%=trim(request.QueryString("pos"))%>' + '&estCLI=' + trim(window.thisForm.kod.value) + '&hlp=' + '<%=hlp%>'
    //alert(cad)
    thisForm.action = cad
    thisForm.submit()
    return true;
}
function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
/*	thisForm.COD.value = t.rows(pos).cells(0).innerText ;
	thisForm.DES.value = t.rows(pos).cells(1).innerText ;
*/	oldrow=pos
	return true;
}
function EDITA() {
var pos = parseInt(oldrow,10)
var t = document.all.TABLA;

cad = 'prnfichaest.asp?cli=' +'<%=trim(request.QueryString("pos"))%>' + '&cod='+ t.rows(pos).cells(0).innerText
cad += '&ecl=' + t.rows(pos).cells(1).innerText + '&des=' + t.rows(pos).cells(2).innerText
cad += '&art=' + t.rows(pos).cells(4).innerText + '&gen=' + t.rows(pos).cells(6).innerText
cad += '&tip=' + t.rows(pos).cells(8).innerText

window.open (cad)

}

</script>
<%SET RS  = NOTHING 
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
