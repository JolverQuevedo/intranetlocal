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
function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff) ;

	
	top.window.thisForm.CODEST.value = trim(t.rows(pos).cells(0).innerText);
    top.window.thisForm.ESTCLI.value = trim(t.rows(pos).cells(1).innerText);
    top.window.thisForm.DESEST.value = ltrim(t.rows(pos).cells(2).innerText);
    top.window.thisForm.CGEN.value = trim(t.rows(pos).cells(3).innerText);
    top.window.thisForm.DGEN.value = ltrim(t.rows(pos).cells(4).innerText);

    top.window.thisForm.TPRE.value = trim(t.rows(pos).cells(5).innerText);
    top.window.thisForm.DPRE.value = ltrim(t.rows(pos).cells(6).innerText);
    cad = '../BAKE/recuperaFOTOESTILO.asp?ID=' + trim(t.rows(pos).cells(7).innerText) + '&CLI=' + '<%=trim(Request.QueryString("CLI"))%>'
    top.window.thisForm.FOT.src = cad
                  
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CLI = Request.QueryString("CLI")
esti = Request.QueryString("pos")
CAD =	"select  v.ESTCLI, v.ESTILO AS DES_ESTILO, v.GENERO AS CGEN,    " & _
        " DGEN, v.TIPO AS TIP, v.DTIP, V.DESCLI,                        " & _
        " v.CODEST, cast(v.FOTO as image) AS FOTO, v.CONTENIDO          " & _
        " from (select ee.ESTCLI , EE.DESCRIPCION as ESTILO, EE.GENERO, " & _
        " GG.DESCRIPCION as dgen, TP.TIPO, TP.DESCRIPCION as dtip ,     " & _
        " EE.CODEST, EE.CONTENIDO,  cast(EE.FOTO as varbinary) AS foto, " & _
        " cl.nombre as DESCLI                                           " & _
        " from POS PP                                                   " & _
        " inner join cliente cl on cl.codigo = pp.cliente               " & _
        " INNER JOIN estilos	EE ON PP.CLIENTE = EE.CLIENTE           " & _
		"	         AND ee.CODEST = PP.CODEST                          " & _
        " INNER JOIN TIPPRENDA TP ON EE.TIPOPRENDA = TP.TIPO            " & _
        " INNER JOIN GENEROS GG ON GG.genero = ee.genero                " & _
        " where PP.cliente = '"&cli&"' and pp.estado ='a' and           " & _
        " pp.OFI is null and not pp.cotizacion is null                  " & _
        " and  ee.estcli = '"&esti&"'                                   " & _
        " group by   ee.ESTCLI, EE.DESCRIPCION, EE.GENERO ,             " & _
        " GG.DESCRIPCION, TP.TIPO, TP.DESCRIPCION , CL.NOMBRE,          " & _
        " EE.CODEST, EE.CONTENIDO,  cast(EE.FOTO as varbinary) ) v      " 

		'Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
	CONT = 1%>
	
<form name="thisForm" METHOD="post"><HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">
<%IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST%>
		<%columnas = rs.Fields.Count%>
	<%ELSE%>
		<center>
		<font color = red size=4 face =arial>
		Lo siento... No tenemos registrados estilos con PO para este cliente
		<%Response.End%>		
<%	END IF %>

<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor=#006699  class="AMERICANwhite10" align="center">
	<td colspan="3">ESTILO</td>
    <td colspan="2">GENERO</td>
    <td colspan="2">TIPO PRENDA</td>
    <td colspan="1">FOTO</td>
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
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>


<%end if%>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
	
</form>
<script>
    REDIR('1')
</script>

</BODY>
</HTML>
