<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
%>

<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />

<script>
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
	window.opener.window.thisForm.CODEST.value = ltrim(t.rows(pos).cells(0).innerText);
	window.opener.window.thisForm.DESEST.value = ltrim(t.rows(pos).cells(1).innerText)
	window.opener.window.thisForm.TIPPRE.value = ltrim(t.rows(pos).cells(2).innerText);
	window.opener.window.thisForm.DESTPREN.value = ltrim(t.rows(pos).cells(3).innerText);
	window.opener.window.thisForm.GEN.value = ltrim(t.rows(pos).cells(4).innerText);
	window.opener.window.thisForm.DESGEN.value = ltrim(t.rows(pos).cells(5).innerText)
	window.close();
}
function MARCA() {
    //alert(rec)
    if (document.all.chk.checked == true) {
        for (i = 0; i < rec; i++)
            eval("document.all.chk" + i + ".checked=true")
    }
    else
        for (i = 0; i < rec; i++)
            eval("document.all.chk" + i + ".checked=false")
}
function graba() {
si = 0
xx = 0
var aPo = new Array()
for (i = 0; i < rec; i++) {
    if (eval("document.all.chk" + i + ".checked")) {
        si = 1
        aPo[xx++] = eval("document.all.po" + i + ".value")
    }
}

if (si == 0) {
    alert("Necesitamos asignar por lo menos una PO a este spec para impresión ")
    return true;
}
cad = "../comun/inserpoSPEC.asp?pos=" + aPo 
//alert(cad)
document.all.head.src= cad 

}


</script>
<%

sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)
cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")


if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" select distinct VC.PO , SP.PO AS POS, SPEC, VER,  " & _
        " ESTILO, ESTCLI                                    " & _
        " from View_Cliente_Temporada_Estilo_PO AS VC       " & _
        " FULL OUTER JOIN SPEC_POS AS SP ON SP.PO = VC.PO   " & _
        " where cliente = '"&cli&"' and codtem='"&tem&"'    " & _
        " and estilo = '"&est&"' AND (SP.PO  IS NULL        " & _
        " OR (SPEC= '"&sp&"' AND VER= '"&vr&"' ))           " & _
		" ORDER BY VC.po                                    " 
		 'Response.Write(cad)
		'Response.end
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 0%>
<form name="thisForm" METHOD="post" ><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

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
<TABLE ID="TABLA" ALIGN="CENTER" cellpadding="1"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr>
<td colspan="2" class="DATOSgrande">Seleccionamos las Po's de este SPEC?</td>
</tr>
<TR style="background-color:Navy">
    <TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>CHK</B></FONT><input id="chk" name="chk" type="checkbox" onclick="MARCA()" /></TD>
	<TD align="center"><FONT face=arial COLOR=IVORY SIZE=1><B>PO</B></FONT></TD>

</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor=#F8FEFB 
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
				<!-- ondblclick="//REDIR('<%=(cont)%>')">-->
		<% else %>
			<tr bgcolor=#C5D6D9
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>"  >
				<!-- ondblclick="REDIR('<%=(cont)%>')"> -->
	<%end IF%>
        <%if isnull(rs("pos"))  then xx = 0 else xx = 1 %>
	    <td align="center"><input id="chk<%=cont%>" name="chk<%=cont%>" type="checkbox" <%if xx = 1 then %>checked <%end if %> > </td> 
		<TD align= "left" style="padding-left:10px"><input id="po<%=cont%>" name="po<%=cont%>" type="text" value="<%=trim(rs("po"))%>" class="AMERICANnavy" ></TD>
	
	</TR>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<center>
<br />
<img src="../imagenes/DISK.gif" style="cursor:pointer" onclick="graba()" />
</center>
<iframe id="head" name="head" src="" HEIGHT="300" width="100%" scrolling="no" frameborder="0" style="display:block"></iframe>

<%end if%>
<script language="jscript" type="text/jscript">
    dd2('1');
 var   rec = '<%=rs.recordcount%>'
</script>    


<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

	
</form>
</BODY>
</HTML>
