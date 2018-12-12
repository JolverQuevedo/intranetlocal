<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2057%>
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
var oldrow =1
var olddata =''
var chk = ''
</script>

<script type="text/jscript" language="jscript">
var funcionalidad = 'comun/INSERoc.asp?'	//  Indica el nombre de la página donde se realizan los cambios 
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
<!--#include file="COMUN/COMUNoc.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title><%=titulo%></title>

</head>

<body>
<form name="thisForm" id="thisForm" method="post" action="">

<%fecha = Request.QueryString("fecha")
fecha = Request.QueryString("fecha")
if fecha = "" or isnull(fecha)  or fecha = " " then
	fecha = ""
end if
if len(fecha) > 0 then

    if right(left(fecha,2),1) = "/" then mes =left(fecha,1) else mes = cint(left(fecha,2))
    anio =  cint(right(fecha,4))
end if

edo = Request.QueryString("edo")
if EDO = "" or isnull(EDO)  or EDO = " " then
	EDO = ""
end if
tip = Request.QueryString("tip")
if tip = "" or isnull(tip)  or tip = " " then
	tip = ""
end if
pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if
occ = Request.QueryString("occ")
if occ = "" or isnull(occ)  or occ = " " then
	occ = ""
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SET DATEFORMAT DMY;                                                       " & _
        " select oc_cnumord as NRO_DOC, Convert(VARCHAR,OC_DFECDOC,103) as FECHA,   " & _
        " oc_crazsoc as PROVEEDOR,oc_ccodmon as Mnd, IMPORTE = CASE WHEN            " & _
        " oc_ccodmon = 'MN' THEN oc_nimpMN ELSE oc_nimpus END, (Select TG_CDESCRI   " & _
        " From RSFACCAR..AL0001TABL Where TG_CCOD='31' AND OC_CSITORD = TG_CCLAVE)  " & _
        " AS ESTADO, OC_CTIPORD AS TIP, OC_CCOTIZA AS COTIZA,OC_CSITORD as SIT      " & _
        " from RSFACCAR..CO0001MOVC WHERE                                           " 
        if len(trim(occ)) > 0 then 
            cad = cad +  " oc_cnumord = '"&occ&"'        "
        else
            cad = cad + " Month(OC_DFECDOC)="&mes&" and year(OC_DFECDOC)="&anio&"  " 
            if len(trim(pro)) > 0 then cad = cad +  " and OC_CCODPRO = '"&pro&"'   "
            if len(trim(tip)) > 0 then cad = cad +  " and OC_CTIPORD = '"&tip&"'   "
            if len(trim(edo)) > 0 then cad = cad +  " and OC_CSITORD = '"&edo&"'   "
            cad = cad +  " ORDER BY 1 DESC ;                                       "
        end if
		'response.Write(Cad)

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
<table id="TABLA" align="center"  bordercolor="#FFFFFF"
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
	            end IF%>" onkeyup="baja()" ondblclick="edita()"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
	<%for i=0 to LIMITE%>
		<td <%IF RS.FIELDS(I).NAME = "IMPORTE" THEN %> class="TEXTO" style="text-align:right;" <%ELSE %>CLASS="TEXTO" <%END IF%>>
        <%IF RS.FIELDS(I).NAME = "IMPORTE" THEN RESPONSE.WRITE(FORMATNUMBER(RS.FIELDS.ITEM(I),2,,,TRUE)) ELSE RESPONSE.WRITE(RS.FIELDS.ITEM(I)) %>&nbsp;</td>
	  <%NEXT%>	

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>

<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
 
<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
    dd2('1');

function baja() {

    if (event.keyCode == 40)
    // flecha abajo
    alert("avanza")
        avanza()    
    if (event.keyCode == 38)
    // flecha arriba
        atrasa()
}

function atrasa() {
    var t = document.all.TABLA;
    var ff = 1;
    if (oldrow > 1)
        dd(oldrow - 1);

}
function avanza() {
    var t = document.all.TABLA;
    var ff = 1;

    var max
    ff = oldrow + 1
    max = t.rows.length - 1;
    
    if (ff <= max)
    { dd(ff); }
}

function ANALI() {
    var pos = parseInt(oldrow, 10)
    var t = document.all.TABLA;

    sit = parseInt(trim(t.rows(pos).cells(8).innerText), 10);
    if (sit == 7) {
        alert("Orden de Compra ANULADA")
        return true;
    }

    cad = 'reportes/analiticaOC.asp?oc=' + trim(t.rows(pos).cells(0).innerText);
    window.open(cad)
}
				  
</script>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
