<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID= 2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") 
	pos = Request.QueryString("cod")
    alm = Request.QueryString("alm")
    %>
	

<script language="jscript" type="text/jscript">
var pos = '<%=cod%>';

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	/*var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;	
    */
	dd('1');
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top 10 CALMA, CTD, CNUMDOC as N_DOC, CRFTDOC AS REF,       " & _
        " CRFNDOC AS N_REF, CCODMOV AS MOV, CCODIGO AS CODIGO, CDESCRI AS   " & _
        " DESCRI,UNIMED AS UNI, NCANTID AS CANT, CCODPROV AS RUC,           " & _
        " CNOMPROV AS PROVEEDOR, CNUMORD AS OC, COLOR,LOTE,BULTOS,CONOS,    " & _
        " KGNETO AS NETO , KGBRUTO AS BRUTO, KGNETOPROV,                    " & _
        " CUBICACION AS UBI, OBSERV, DFECDOC, citem as ITEM, ctipmov as TP, " & _
        " codtipomov as CD                                                  " & _
        " FROM            MULTI.dbo.RS_ALMOVD0001                           " & _
        " WHERE        (ESTADO = 'V' or estado is null) AND (CTD = 'PE')    " & _
        " AND CCODIGO = '"&pos&"' AND CTIPMOV = 'E'  and calma= '"&alm&"'   " & _
        " order by DFECDOC desc                                             "
		'Response.Write(CAD)
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>
		

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count -1%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" >
<HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" onclick="javascript: window.close();">
		</td>
		<td align="center"><font face="arial" size="2" color="DarkBlue"><b>10 ULTIMOS INGRESOS <br /><font color="red">
        doble click para ver detalle..</b></font></td>
        </tr>
	</tr>
	<tr><td colspan="3"><HR></td></tr>
</table>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%for I=0 to columnas%>
	<td align="center" >
		<font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(I).NAME%></b></font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>

<%DO WHILE NOT RS.EOF%>

    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" ondblclick="show('<%=cont%>')" >       
	<%for i=0 to columnas%>
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


</form>
<script language="jscript" type="text/jscript">
rec = parseInt('<%=rs.recordcount %>',10)
if (rec > 0)
    dd2('0')
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=500,width=900";
function show(op) { 
   pos = parseInt(op,10)
    var t = document.all.TABLA;
    cod = trim(t.rows(oldrow).cells(6).innerText);

   alm = trim(t.rows(oldrow).cells(0).innerText);
   ctd = trim(t.rows(oldrow).cells(1).innerText);
   des = ltrim(t.rows(oldrow).cells(7).innerText);
   itm = trim(t.rows(oldrow).cells(23).innerText);
   tip = trim(t.rows(oldrow).cells(24).innerText);
   col = trim(t.rows(oldrow).cells(13).innerText);
   doc = trim(t.rows(oldrow).cells(2).innerText);
   occ = trim(t.rows(oldrow).cells(12).innerText);
   uni = trim(t.rows(oldrow).cells(8).innerText);
   lot = trim(t.rows(oldrow).cells(14).innerText);
   bul = trim(t.rows(oldrow).cells(15).innerText);
   con = trim(t.rows(oldrow).cells(16).innerText);
   ser = trim(t.rows(oldrow).cells(25).innerText);
   cad  = 'show_tallas.asp?alm=' + alm + '&ctd=' + ctd + '&doc=' + doc
   cad += '&tip=' + tip + '&art=' + cod + '&des=' + des + '&col=' + col
   cad +=  '&oc=' + occ + '&itm=' + itm + '&UNI=' + uni + '&bul=' + bul
   cad += '&lot=' + lot + '&cnr=' + con + '&ser=' + ser
  // alert(cad)
   window.open(cad,'Detalle',opc)



}


</script>
</BODY>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
  

</HTML>
