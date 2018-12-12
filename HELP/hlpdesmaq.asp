<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") %>
	<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />

<script language="jscript" type="text/jscript">
function ACTUALIZA(cod,cad)
{	
	return true
}
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad = trim(t.rows(pos).cells(0).innerText);
	window.parent.window.opener.document.all.CODMAQ.innerHTML = cad;
	window.parent.window.opener.thisForm.CMAQ.value = cad;
	cad = ltrim(t.rows(pos).cells(1).innerText);
    window.parent.window.opener.document.all.DESMAQ.innerHTML = cad;
    cad = trim(t.rows(pos).cells(9).innerText);
    window.parent.window.opener.document.all.CODTIP.innerHTML = cad;
    cad = ltrim(t.rows(pos).cells(10).innerText);
    window.parent.window.opener.document.all.DESTIP.innerHTML = cad;
    cad = trim(t.rows(pos).cells(11).innerText);
    window.parent.window.opener.document.all.CODMOD.innerHTML = cad;
    cad = ltrim(t.rows(pos).cells(12).innerText);
    window.parent.window.opener.document.all.DESMOD.innerHTML = cad;
    cad = trim(t.rows(pos).cells(7).innerText);
    window.parent.window.opener.document.all.CODMAR.innerHTML = cad;
    cad = ltrim(t.rows(pos).cells(8).innerText);
    window.parent.window.opener.document.all.DESMAR.innerHTML = cad;
    cad = trim(t.rows(pos).cells(4).innerText);
    window.parent.window.opener.document.all.DIAM.innerHTML = cad;
    cad = trim(t.rows(pos).cells(2).innerText);
    window.parent.window.opener.document.all.GG.innerHTML = cad;
	cad = trim(t.rows(pos).cells(3).innerText);
    window.parent.window.opener.document.all.AGU.innerHTML = cad;
    cad = trim(t.rows(pos).cells(6).innerText);
    window.parent.window.opener.document.all.ALIM.innerHTML = cad;
    cad = trim(t.rows(pos).cells(5).innerText);
    window.parent.window.opener.document.all.SIST.innerHTML = cad;
    window.parent.window.opener.llenado()
	window.parent.window.close();
	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;	
	dd(ff);
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
TIP = REQUEST.QueryString("TIP")
MODE = REQUEST.QueryString("MODe")
marc = request.QueryString("mar")
marc = replace(marc,",", "','") 
CAD =	" SELECT  CODIGO, DESTEJ,       " & _
        " GALGA AS GG, AGUJAS, DIAMETRO," & _
        " SISTEMAS, ALIMENTA, MARCA,    " & _
        " DESMAR, TIPO, DESTIP, MODELO, " & _
        " DESMOD, EDO                   " & _
		" from VIEW_TEJEDORAS  where    " & _
		" EDO = 'A'                     " & _ 
		" and tipo = '"&tip&"'          " & _
		" and modelo = '"&mode&"'       " & _
		" and marca in ('" &marc& "')   " 
cad = cad + " ORDER BY DESTIP, DESMAR,  " & _
            " DESMOD, DESTEJ            " 
		'Response.Write(CAD)
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	nohay =0
	IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MOVEFIRST
	else
	nohay=1
	response.write("<font color='red' size='4'><b><center>")
	response.write("No hay datos que concuerden con su selección")
	response.end
	END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="2" cellspacing="1" bordercolorlight="DarkOrange">   
	<tr valign="middle">
		<td bgcolor="#f7d975" class="TALASBLUE" width="40%"><%=rs("destip") %></td >     
        <td bgcolor="#f7d975" class="TALASBLUE" width="60%" ><%=rs("desmod") %></td >	
	</tr >
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%for I=0 to rs.Fields.Count-2 %>
	<td align="center" <%IF i > 8 THEN%> style="display:'none'" <%end if %>>
		<font face="arial" color="IVORY" size="1"><b><%=RS.FIELDS(I).NAME%></b></font>
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
	            onclick="dd2('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="REDIR('<%=(cont)%>')">       
	<%for i=0 to rs.Fields.Count-2%>
		<td <%IF i > 8 THEN%> style="display:'none'" <%end if %>>
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
<%end if%>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="jscript" type="text/jscript">
nop=parseInt('<%=nohay %>',10)
if (nop==0)
dd2('1');
</script>    
</form>
</BODY>
</HTML>
