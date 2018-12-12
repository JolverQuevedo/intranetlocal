<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
	
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->

<link rel="Stylesheet" type="text/css" href="../estilos1.css" />
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
function ACTUALIZA(cod,des)
{	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff) ;

	
	window.opener.window.thisForm.CODEST.value = trim(t.rows(pos).cells(0).innerText);
    window.opener.window.thisForm.ESTCLI.value = trim(t.rows(pos).cells(1).innerText);
    window.opener.window.thisForm.DESEST.value = ltrim(t.rows(pos).cells(2).innerText);
    window.opener.window.thisForm.CGEN.value = trim(t.rows(pos).cells(3).innerText);
    window.opener.window.thisForm.DGEN.value = ltrim(t.rows(pos).cells(4).innerText);

    window.opener.window.thisForm.TPRE.value = trim(t.rows(pos).cells(5).innerText);
    window.opener.window.thisForm.DPRE.value = ltrim(t.rows(pos).cells(6).innerText);
 
    window.opener.window.thisForm.CTEM.value = ltrim(t.rows(pos).cells(8).innerText);
    //alert() 
      window.opener.window.thisForm.DTEM.value = ltrim(t.rows(pos).cells(9).innerText);
    window.opener.window.thisForm.ART.value = ltrim(t.rows(pos).cells(10).innerText);
    window.opener.window.thisForm.TEJE.value = ltrim(t.rows(pos).cells(11).innerText);


    cad = '../BAKE/recuperaFOTOESTILO.asp?ID=' + trim(t.rows(pos).cells(7).innerText) + '&CLI=' + '<%=trim(Request.QueryString("CLI"))%>'
    window.opener.window.thisForm.FOT.src = cad
    this.window.close();
              
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CLI = Request.QueryString("CLI")

CAD =	" EXEC ESTILOS_CLIENTE '"&CLI&"'    " 

		'Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
	CONT = 1
    if rs.recordcount > 0 then descli = rs("descli") else descli = cli
    
    %>
	
<form name="thisForm" METHOD="post"><HTML>
<HEAD>
<TITLE>ESTILOS DE <%=DESCLI%></TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin="0" leftmargin="20" rightmargin="20" border="0" text="#000000">
<%IF rs.recordcount > 0 THEN
		RS.MOVEFIRST%>
		<%columnas = rs.Fields.Count%>
	<%ELSE%>
		<center>
		<font color="red" size="4" face="arial">
		Lo siento... No tenemos registrados estilos con PO para este cliente
        <center>
        <img src="../imagenes/CERRAR.gif" style="cursor:pointer;" onclick="javascript: window.close();">
        </center>
		<%Response.End%>		
<%	END IF %>
<table width="100%">
	<tr>
		<td align="left" width="15%">
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
			
		</td>
		<td align= "center"><font face="arial" size="3" color="DarkBlue"><B>Estilos de <%=rs("descli")%></b></font></td>
		<TD align="right" width="15%"><img src="../imagenes/logo.GIF"  ></TD>
        </TR>
	</tr>
	<TR>
	<td colspan="3">
			<HR>
		</td>
	</TR>
</table>
<%'*********************************************************************%>
<TABLE ID="TABLA" align="center" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="navy" border="1">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor=#006699  class="AMERICANwhite10" align="center">
	<td colspan="3">ESTILO</td>
    <td colspan="2">GENERO</td>
    <td colspan="2">TIPO PRENDA</td>
    <td colspan="1">FOTO</td>
    <td colspan="2">TEMPORADA</td>
    <td colspan="1">ARTICULO</td>
    <td colspan="1">TEJIDO</td>    
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB class="DESCRIPTORnavy" valign="top"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ondblclick="REDIR('<%=(cont)%>')">
		<% else %>
			<tr bgcolor=#C5D6D9 class="DESCRIPTORnavy" valign="top"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  
				ondblclick="REDIR('<%=(cont)%>')">
	<%end IF%>
        <td><%=RS("codest")%></td>
        <td><%=RS("estcli")%></td>
        <td><%=RS("DES_ESTILO")%></td>
        <td><%=RS("cgen")%></td>
        <td><%=RS("dgen")%></td>
        <td><%=RS("tip")%></td>
        <td><%=RS("dtip")%></td>
	<td align="center"><img src="../BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=CLI%>" width="30" /></td>
         <td><%=RS("TEMPORADA")%></td>
         <td><%=RS("DESTEM")%></td>
         <td><%=RS("CODARTICULO")%>&nbsp;</td>
         <td><%=RS("TEJIDO")%></td>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>

<iframe id="tallitas" name="tallitas" src="" width="100%" style="display:none"></iframe>



<%end if%>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
	
</form>
<script>
dd2('1')
</script>

</BODY>
</HTML>
