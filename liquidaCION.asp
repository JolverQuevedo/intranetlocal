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
<!--#include file="COMUN/COMUNliq.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title><%=titulo%></title>

</head>

<body>
<form name="thisForm" id="thisForm" method="post" action="">

<%submenu = "SUBMENU.ASP?TIPO=13"
CIA = "0001"
%><table width="100%" border="0">
<tr class="titulito">
	<td align="left" rowspan="2" style="width:5%">
		<img src="imagenes/ATRAS.gif" style="cursor:pointer;" 	onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=13');"> 	</td>
	<td align="center" colspan="5">
		<font face=arial size= 3 color=DarkBlue><B>OC FINALIZADAS
		</b></font>
	</td>
	<td align="right" width="5%" rowspan="2"><img src="imagenes/logo.GIF"></TD>
</tr>
<tr class="titulito">
<td width="3%">Proveedor</td>
<td width="10%"><input type="text" name="PRO" id="PRO" value="" class="DATOSkhaki" onchange="BAKE(this.value)" ondblclick="help()"/></td>
<td width="25%"><input type="text" name="DPRO" id="DPRO" value="" class="TEXTOAZULPOS" readonly tabindex="-1" style="width:100%"/></td>
<td width="1%">Tipo</td>
<%' recibe tabla, primary key, y descripcion 

cad =	"Select TG_CCLAVE, TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='63' Order by TG_CCLAVE"

rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
	<td align="center" width="15%">	
		<select id="TIP" name="TIP" onchange="tipos()" class="DATOSGRANDE">    
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("tg_cclave"))%>'><%=trim(rs("tg_cdescri"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</td>
<td style="width:5%;" ><input type="button" id="ENVI" name="ENVI" value="FILTRAR" class="boton" onclick="filtra()"/></td>
</tr>
<tr><td colspan="12" ><hr></td></tr>
</table>
<%tip = Request.QueryString("tip")
if tip = "" or isnull(tip)  or tip = " " then
	tip = ""
end if
pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SET DATEFORMAT DMY;                                                               " & _
        " SELECT *  FROM VIEW_LIQUIDA                                                       " 
        if len(trim(pro)) > 0 then cad = cad +  " where RUC = '"&pro&"'                     "
        if len(trim(tip)) > 0 then cad = cad +  " where tip = '"&tip&"'                     "
        if len(trim(edo)) > 0 then cad = cad +  " where OC_CSITORD = '"&edo&"'              "
        if len(trim(pro))+len(trim(tip))+len(trim(edo)) = 0 then cad = cad +  " where 2=1   "
        cad = cad +  " ORDER BY 1 ;                                                     "
	'	response.Write(Cad)
    RS.CLOSE
	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
        RESPONSE.WRITE("<CENTER>")
		RESPONSE.Write("SELECCIONE UN CRITERIO")	
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
	            end IF%>" onkeyup="baja()" ondblclick="ANALI()"
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
<iframe frameborder="1" style="display:none" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>
 
<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
    dd2('1');

ruc = '<%=pro%>'
if (ruc.length > 0) {
    document.all.DPRO.value = '<%=trim(request.queryString("des"))%>'
    document.all.PRO.value = ruc
}
tti = '<%=trim(request.queryString("tip"))%>'
if (tti.length > 0) {

    var subcadena = tti;
    var elemento = document.all.TIP;
    document.all.TIP.selectedIndex = seleindice(subcadena, elemento);	

}

function tipos() {
    cad = 'liquidacion.asp?tip=' + trim(document.all.TIP.value)
    window.location.replace(cad)


}
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


    oc = trim(t.rows(pos).cells(0).innerText)
    TIPO = trim(t.rows(pos).cells(4).innerText)
    SIT = trim(t.rows(pos).cells(7).innerText)
    cad = 'Fichaliqui.asp?oc=' + oc + '&tip=' + TIPO + '&sit=' + SIT + '&opc=1'
  //  cad = 'fichaliqui.asp?oc=' + trim(t.rows(pos).cells(0).innerText);
    window.open(cad)
}


function help() {
    cad = 'help/HLPprovREAL.asp'
    window.open(cad, "PROVEEDORES", opc)
}

function BAKE(ruc) {
    cad = 'BAKE/PROVEEDOR_REAL_liq.asp?pos=' + trim(ruc) + '&URL=' + '../liquidacion.asp?pro='
    /*alert(cad)
    window.document.all.ACTIV.style.display='block'
    */
    window.document.all.ACTIV.src = cad
   
}				  
</script>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
