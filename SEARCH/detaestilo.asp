<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
   
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow=1
mm=-1
function fBuscar(color)
{  // cad "detaESTILO.asp?pos=' + pos + '&est=' + document.all.
    //document.all.bake.src=cad
    return true



}
function fReporte()
{	window.open('REPORTES/prnReporteESTILOS.asp?CLI=<%=TRIM(REQUEST.QUERYSTRING("CLI"))%>')
}
var oldrow = 1
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
<!--#include file="includes/navegacion22.inc"-->
<%Dim pageSize 
if txtPerfil > 1 then 	pageSize = 16 else 	pageSize = 6
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
est = Request.QueryString("est")
if est = "" or isnull(est)  or est = " " then
	est = ""
end if
'*********************************************************
' TENGO UN PARAMETRO ADICIONAL DE LA OPCION DE GRABAR
' PARA HACER QUE SE GENEREN LOS DATOS EN EL DBPROD Y
' SI TUVIERA CODIGO DE ARTICULO, ACTUALIZAR EL REGISTRO
'*********************************************************
gen = Request.QueryString("gen")
'RESPONSE.Write(GEN)
'RESPONSE.Write("<BR>")

if gen = "" or isnull(gen)  or gen = " " then
	gen = 0
end if
'RESPONSE.Write(GEN)
'RESPONSE.Write("<BR>")
if cint(gen) = 1 then
    ' SI geN = 1 ES QUE VIENE DE GRABAR ESTILO...
    cad = "select * from estilos where cliente = '"&pos&"' and codest = '"&est&"'"
   ' RESPONSE.Write(CAD)
'    RESPONSE.Write("<BR>")
'RESPONSE.Write("<BR>")
    rs.open cad, cnn
 '    RESPONSE.Write(trim(pos) + right(trim(rs("tipoprenda")) ,2))
    if rs.recordcount >0 then
        rs.movefirst
        ' el articulo no tiene codigo generado
        if len(trim(rs("codarticulo"))) = 0 then
            estcli = rs("estcli")
            codigo = trim(pos) + right(trim(rs("tipoprenda")) ,2)
            ' busca si tiene codigo en el DBPROD
              cad = "SELECT st_ccodart FROM dbprod..COMSTYOP WHERE ST_CCODIGO  = '"&ESTCLI&"'" 
 '            RESPONSE.Write(CAD)         
  '           RESPONSE.Write("<BR>")
              rs.close
              rs.open cad,cnn
              if rs.recordcount > 0 then 
              ' TIENE CODIGO DEL DBPROD, ENTONCES SOLO ACTUALIZO EN EL MODELADOR
                rs.movefirst
                codigo =  rs("st_ccodart")
                
              else              
                ' NO TIENE CODIGO EN EL DBPROD, ENTONCES CREO UN NUEVO CÓDIGO 
                rs.close
                rs.open "select corr_pda from tb_ctrl", cnn
                nume = cdbl(rs("corr_pda"))+1
                cad = "update tb_ctrl set corr_pda = "&nume&" "
  '              RESPONSE.Write(CAD)
  '              RESPONSE.Write("<BR>")
                ' ACTUALIZA CORRELATIVO DE CODIGOS
                cnn.execute cad
                codigo = trim(codigo) + trim(cstr(nume))
                ' CREA ESTILO Y ARTICULO EN ESTILOS-DBPROD
                CAD =	" SELECT DESCRIPCION AS  TIPOPRENDA 	" & _
		                " from TIPPRENDA 		" & _
		                " WHERE TIPO = (SELECT TIPO FROM ESTILOS WHERE CLIENTE = '"&POS&"' AND CODEST = '"&EST&"')     		"
                RS.CLOSE
                RS.OPEN CAD, CNN
   '              RESPONSE.Write(codigo)
   '             RESPONSE.Write("<BR>")
                RS.MOVEFIRST

                TPDA = right(RS("TIPOPRENDA"),2)
                CAD =   " INSERT INTO dbprod..COMSTYOP(ST_CCODIGO,ST_CCODART,ST_CPRENDA,ST_CTEJIDO,ST_CCODEMP,ST_CEMPRESA,ST_CCODCLI,ST_CTIPO,ST_CTIEMPO) " & _
                        " VALUES ('"&ESTCLI&"','"&CODIGO&"','"&TPDA&"','','0001','EL MODELADOR S.A.','"&POS&"','P','')   "
                CNN.EXECUTE (CAD)
            END IF
            ' ACTUALIZA ARTICULO EN ESTILOS-MODELADOR
                CAD = "UPDATE estilos SET CODARTICULO = '"&CODIGO&"' where cliente = '"&pos&"' and codest = '"&est&"'  "
                CNN.EXECUTE (CAD)
        end if
    end if
    RS.CLOSE
   ' RESPONSE.END
end if

' necesito saber si LA PAGINA fue llamado desde el PROTO y devolver los resultados a LA 
' FICHA-PROTO O ES PARA EDITAR EL ESTILO
' EN CUYO CASO NO EXISTE EL PARAMETRO...
HLP = Request.QueryString("HLP")
if len(trim(HLP)) = 0 then HLP = 0
ESTCLI = REQUEST.QueryString("ESTCLI")
codmod = trim(REQUEST.QueryString("codmod"))
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  top 15               			" & _
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
elseIF LEN(TRIM(codmod)) > 0 THEN  
    CAD = CAD +   " and right(ltrim(rtrim(CODARTICULO)),5) >= '"&codmod&"' order by right(ltrim(rtrim(CODARTICULO)),5) " 
else   
 CAD = CAD +   " and codest >= '"&est&"'   order by codest  " 
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

<form name="thisForm" method="post" action="DETAESTILO.asp">
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
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST
cont= 1 %>
    <%DO WHILE NOT RS.EOF %>
	    <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')">
	        <%FOR i=0 TO columnas-3%>
		        <td class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></td>
	        <%NEXT%>
	        <td align="center" style="display:none"><%=RS.FIELDS(i).NAME%></td>
            <td><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=POS%>" HEIGHT="40" /></td> 
        </tr>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
    <%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera()" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras()" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina()" style="cursor:pointer" /></td>

		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima()" style="cursor:pointer;" /></td>
        
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Est_Cli:</b></font></td>
		<td><input id="kod" name="kod" value="" /> </td>    
	  </tr>
	   <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Cod_Mod:</b></font></td>
		<td><input id="Des" name="Des" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer;" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer;" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>


<%end if%>


<%IF cint(HLP) <> 1   THEN %>

        <table border="0" align="center"  cellspacing="3">
            <tr>
                <td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:hand;" /></td>
                <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:hand;" /></td>		
            </tr>
        </table>
    <%END IF%>

<%rs.close%>

<script>

    if (marca == 0 || HLP == 1)
        dd('1');		
			
function NUEVO() {
    OBS = ''
    cad = 'fichaest.asp?cod=AUTO&cli=' + '<%=pos%>'
    //alert(cad)
    window.open(cad)
  return true;
}
function LLENA(ff) {

return true; }


function elimina()
{	var t = document.all.TABLA;
    var pos = parseInt(oldrow,10)
    var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	COD = ltrim(t.rows(pos).cells(0).innerText);
	CAD = 'COMUN/DELEEST.ASP?CLI=' + '<%=trim(request.QueryString("pos"))%>'
	CAD += '&COD=' + COD
	window.location.replace(CAD); 
	return true;
}
function BUSCA(url, alias) {
    if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.Des.value)=='') {
        alert("Debe informar el Código de Estilo o Codigo Modelador");
        window.thisForm.kod.focus();
    }

    cad = 'detaestilo.asp?pos=' + '<%=trim(request.QueryString("pos"))%>' + '&estCLI=' + trim(window.thisForm.kod.value) + '&hlp=' + '<%=hlp%>' + '&codmod=' + trim(window.thisForm.Des.value) 
    window.location.replace(cad);
    return true;
}
</script>
<%SET RS  = NOTHING 
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
