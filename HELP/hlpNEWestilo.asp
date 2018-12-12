<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
%>

<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************

function REDIR(ff)
{	var t = document.all.TABLA;
var pos = parseInt(ff);


	window.opener.window.document.all.ECL2.value = ltrim(t.rows(pos).cells(0).innerText);
	window.opener.window.document.all.EST2.value = ltrim(t.rows(pos).cells(1).innerText)
	window.opener.window.document.all.des2.value = ltrim(t.rows(pos).cells(3).innerText)
	window.opener.foton2()
	window.close();
}
</script>
<%

CLI = Request.QueryString("CLI")
est =Request.QueryString("est")

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" select                         " & _
        " CODEST, ESTCLI, foto,          " & _
        " DESCRIPCION, CODARTICULO       " & _
        " from estilos                   " & _
        " where cliente = '"&cli&"'  and " & _
        " estcli like '"&est&"%'         " & _ 
        " and estado ='a'                " & _
		" ORDER BY 1" 
		'Response.Write(cad)
		'Response.end
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%	RS.Open CAD, Cnn
	CONT = 1%>
<style type="text/css">
    .style3
    {
        border-style: none;
        border-color: inherit;
        border-width: medium;
        FONT-WEIGHT: 900;
        FONT-SIZE: 11px;
        WIDTH: 10%;
        COLOR: white;
        FONT-FAMILY: "Arial";
    }
    .style4
    {
        border-style: none;
        border-color: inherit;
        border-width: medium;
        FONT-SIZE: 10px;
        COLOR: navy;
        FONT-FAMILY: Arial;
        font-weight: 400;
        padding-right: 10px;
        width: 10%;
    }
</style>

<script language="jscript" type="text/jscript">


    var auto = 1;
    var url = '../estilos.asp?cli='
    var alias = 'estilos'
    var TBL = 'estilos'
    var PK = 'CODest'
    var DS = 'desCRIPCION'
    var largo = 3
    var largo2 = 200
    var oldrow = 1


    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);

        dd(ff);
    }


</script>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<table WIDTH="100%">
	<tr>
		<td align= left WIDTH=35%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			Estilos que empiezan con : <%=est%>
			</b></font>
		</td>
		<TD ALIGN=right WIDTH=35%> 
		  	<img src="../imagenes/logo.GIF"  >
		  </TD>
        </TR>
	</tr>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>
<%IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST%>
		<%columnas = rs.Fields.Count%>
	<%ELSE%>
		<center>
		<font color = red size=4 face =arial>
		Lo siento... No tenemos registrados estilos para este cliente
		<%Response.End%>		
<%	END IF %>
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR style="background-color:Navy">

	<TD align="center" class="style3">ESTCLI</TD>
    <TD align="center" class="style3">CODEST</TD>
    <TD align="center" class="style3">CODARTICULO</TD>
    <TD align="center" class="TITULITOWHITE">DESCRIPCION</TD>
    <TD align="center" class="TITULITOWHITE">FOTO</TD>

</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> 
    bgcolor='<%=(Application("color2"))%>' <%end IF%>
	onclick="dd('<%=(cont)%>')" id="fila<%=cont%>" valign="top" ondblclick="REDIR('<%=cont%>')">
	  
 


		<TD align= "left" class="style4"><%=trim(RS("estcli"))%></TD>
        <TD align= "left" class="style4"><%=trim(RS("CODEST"))%></TD>
        <TD align= "left" class="style4"><%=trim(RS("CODARTICULO"))%></TD>
        <TD align= "left" class="TEXTOblue100" width="70%"><%=trim(RS("DESCRIPCION"))%></TD>
        <td><img src="../BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=cli%>" width="30" /></td> 
	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
  </tr>
</table>
<%end if%>

<script language=jscript type="text/jscript">
    rec = parseInt('<%=rs.recordcount%>', 10)
    if (rec > 0)
        dd2('1');
</script>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

  
</form>
</BODY>
</HTML>
