<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<script type="text/jscript" language="jscript"> 
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
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
	window.opener.window.thisForm.PRO.value	    =  trim(t.rows(pos).cells(0).innerText)+'-'+trim(t.rows(pos).cells(1).innerText);

	window.opener.window.thisForm.COTI.value = trim(t.rows(pos).cells(4).innerText);
	window.opener.window.thisForm.FOB.value = trim(t.rows(pos).cells(12).innerText);
	tope = window.opener.window.TOPE
	//  alert(k)
	for (k = 1; k <= tope; k++ )
	    eval("window.opener.window.thisForm.FOB" + k + ".value = trim(t.rows(pos).cells(12).innerText);")

	var subcadena = trim(t.rows(pos).cells(9).innerText);
	var elemento = window.opener.window.thisForm.TIP;
	window.opener.window.thisForm.TIP.selectedIndex = seleindice(subcadena, elemento);

	window.opener.window.thisForm.CGEN.value = trim(t.rows(pos).cells(10).innerText);
	window.opener.window.thisForm.DGEN.value = ltrim(t.rows(pos).cells(11).innerText);
	window.opener.window.thisForm.CODEST.value = trim(t.rows(pos).cells(5).innerText);
    window.opener.window.thisForm.ESTCLI.value = trim(t.rows(pos).cells(6).innerText);
    window.opener.window.thisForm.DESEST.value = ltrim(t.rows(pos).cells(7).innerText);
    window.opener.window.thisForm.GRUPO.value = trim(t.rows(pos).cells(8).innerText);
    cad = '../BAKE/recuperaFOTOESTILO.asp?ID=' + trim(t.rows(pos).cells(5).innerText) + '&CLI=' + '<%=trim(Request.QueryString("CLI"))%>'
    window.opener.window.thisForm.FOT.src = cad
    cad = "../bake/bkPROposTAL.asp?pro=" + trim(t.rows(pos).cells(0).innerText) + "-" + trim(t.rows(pos).cells(1).innerText) + "&fob=" + trim(t.rows(pos).cells(12).innerText); ;
   /* document.all.tallitas.style.display='block'
    */
    document.all.tallitas.src =cad
    //alert(cad)
	//window.close();
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CLI = Request.QueryString("CLI")
PRO = LEFT(Request.QueryString("PRO"),10)
VER = RIGHT(Request.QueryString("PRO"),3)
CAD =	" SELECT PP.PROTO, PP.VERSION AS VER, EM.NOMBRE AS CLIENTE, TT.DESCRIPCION AS TEMPORADA,   " & _
        " PP.COTIZACION, PP.ESTILO, EE.ESTCLI, EE.DESCRIPCION,  pp.motivo as GP_TELA ,             " & _
        " CC.TIPEMB, EE.GENERO, GG.DESCRIPCION AS DGEN, cc.FOB                                     " & _
        " FROM PROTOS PP                                                                           " & _
        " INNER JOIN ESTILOS AS EE ON PP.ESTILO = EE.CODEST AND PP.CLIENTE = EE.CLIENTE            " & _
        " INNER JOIN CLIENTE EM ON PP.CLIENTE = EM.CODIGO                                          " & _
        " INNER JOIN COTIZACION AS CC ON CC.COTIZACION = PP.COTIZACION                             " & _
        " INNER JOIN GENEROS AS GG ON GG.GENERO = EE.GENERO                                        " & _
        " inner join temporadas as tt on pp.cliente = tt.cliente and pp.temporada = tt.codigo      " & _
        " WHERE (PP.ESTADO = 'A') AND (PP.CLIENTE = '"&cli&"')                                     " 

if len(trim(pro)) > 0 then     cad = cad + " and pp.proto = '"&pro&"' "

CAD = CAD + " GROUP BY PP.PROTO, PP.[VERSION] , EM.NOMBRE , PP.ESTILO, PP.COTIZACION,              " & _
            " cc.FOB, EE.ESTCLI, EE.DESCRIPCION, pp.motivo , TT.DESCRIPCION,                       " & _
            " CC.TIPEMB, EE.GENERO, GG.DESCRIPCION                                                 " & _
            " ORDER BY PP.PROTO , PP.VERSION                                                       " 
 

		'Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
	CONT = 1%>
	
<form name="thisForm" METHOD="post" ><HTML>
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
		Lo siento... No tenemos registrados PROTOS COTIZADOS para este cliente
		<%Response.End%>		
<%	END IF %>
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=35%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
			
		</td>
		<td align= CENTER>
			<font face=arial size= 3 color=DarkBlue><B>
			Protos de <%=rs("cliente")%>
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
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cols=2 width=100%
	 cellpadding=2  cellspacing=1 bordercolor=White
	  bgcolor=NAVY border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%for I=0 to columnas-1 %>
	<TD align="center">
		<FONT face=arial COLOR=IVORY SIZE=1>
		<B><%=RS.FIELDS(I).NAME%></B>
		</FONT>
	</TD>
<%next%>	
</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB 
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
				ondblclick="REDIR('<%=(cont)%>')">
		<% else %>
			<tr bgcolor=#C5D6D9
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  
				ondblclick="REDIR('<%=(cont)%>')">
	<%end IF%>

	<%FOR i=0 TO columnas -2%>
		<TD valign=top>
		<FONT face=arial COLOR=MidnightBlue SIZE=1>
		<B><%=RS.FIELDS.ITEM(I)%></B>&nbsp;
		</FONT>
	</TD>
	<%NEXT%>
	<TD valign=top>
		<FONT face=arial COLOR=MidnightBlue SIZE=1>
		<B><%=formatnumber(cdbl(RS.FIELDS.ITEM(I)),2,,true)%></B>&nbsp;
		</FONT>
	</TD>
	</TR>
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
