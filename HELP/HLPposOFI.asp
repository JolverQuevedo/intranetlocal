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

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function redir(cont) {
    var pos = parseInt(cont, 10)
    t = document.all.TABLA
    O = 0
    var aPos = Array(10)
    for (k = 1; k < pos; k++) { 
        chk = eval("document.all.ch"+k+".checked")
        if (chk == true) {
            //alert(trim(t.rows(k).cells(1).innerText))
            aPos[O] = trim(t.rows(k).cells(1).innerText)
            O++
            if (O > 10) {
                alert("Solo se pueden adicionar POS maximo de 10 en 10")
                break ;
                }
        }
    }
    cad = "hlpdetaOFIpos.asp?pos=" + aPos + '&ofi=' + '<%=Request.QueryString("ofi")%>' + '&codest=' + '<%=Request.QueryString("est") %>' + '&cli=' + '<%=Request.QueryString("cli") %>'

   // alert(cad)
   
   document.all.tallitas.style.display='block'
   document.all.tallitas.style.height=200
  
   document.all.tallitas.src = cad
    
  //this.window.close();
              
}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
ofi = Request.QueryString("ofi")
CLI = Request.QueryString("CLI")
est = Request.QueryString("est")
esCLI = Request.QueryString("esCLI")

CAD =	" select PP.PO,  '"&ESCLI&"' AS EST_CLI, DD.NOMBRE AS DESTINO,  " & _
        " PP.CANTIDAD,  PP.DESTINO AS CODDEST   from pos PP             " & _
        " INNER JOIN DESTINOS DD ON PP.DESTINO = DD.CODIGO              " & _
        " where PP.cliente = '"&CLI&"' and PP.codest='"&EST&"'          " & _
        " and (PP.ofi is null or pp.ofi = '')                           " 

        apos = request.QueryString("apos")
        apos = replace(apos,",","','")
		'Response.Write(cad)
       '' Response.Write("<br>")
        'Response.Write(ofi)
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
		Lo siento... No tenemos registrados PO's con este Estilo para este cliente 
        <P><center>
        <img src="../imagenes/CERRAR.gif" 			style="cursor:pointer;"			onclick="javascript: window.close();">
        </center>
        </P>
		<%Response.End%>		
<%	END IF %>
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=15%>
			<img src="../imagenes/CERRAR.gif" 
			style="cursor:hand;"
			onclick="javascript: window.close();">
			
		</td>
		<td align= CENTER><font face=arial size= 3 color=DarkBlue><B>Po's DISPONIBLES</b></font></td>
		<TD ALIGN=right WIDTH=15%><img src="../imagenes/logo.GIF"  ></TD>
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
<tr bgcolor=#006699  class="AMERICANwhite10" align="center">
	<td>CHK</td>
	<td>PO</td>
    <td>ESTILO</td>
    <td>DESTINO</td>
    <td>CANTIDAD</td>
    <td  style="display:none">CODEST</td>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
	<% IF CONT mod 2  = 0 THEN %>
			<tr bgcolor='<%=application("color1")%>' class="DESCRIPTORnavy" valign="top"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
		<% else %>
			<tr bgcolor='<%=application("color2")%>' class="DESCRIPTORnavy" valign="top"
				onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">
	<%end IF%>
        <td align="center"><input type="checkbox" id="ch<%=cont%>" name="ch<%=cont%>" /></td>
        <td><%=RS("po")%></td>
        <td><%=RS("est_cli")%></td>
        <td><%=RS("destino")%></td>
        <td align="right"><%=formatnumber(RS("cantidad"),0,,,true)%>&nbsp;  </td>
        <td style="display:none"><%=RS("coddest")%></td>
        
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </td>
  </tr>
</table>
<center><p><img src="../imagenes/done.jpg" style="cursor:pointer" onclick="redir('<%=cont %>')"/></p> </center>
<iframe id="tallitas" name="tallitas" src="" width="100%" style="display:BLOCK"></iframe>



<%end if%>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
	
</form>
<script>
    dd2('1')

    maxim = parseInt('<%=cont %>', 10)
    // aca tengo los numeros de pos eliminados , separados por comas
    poss = trim('<%=apos%>')
    // ya viene con ',' en cada , para poder hacer un for y el redir de c/u po de la ofi
    // ahora hacer el for para simular el barrido de todas las pos disponibles

	var t = document.all.TABLA;

    for (y = 0; y < maxim; y++) { 

    xx =  ltrim(t.rows(y).cells(1).innerText) 
//    barrer poss y buscar si encuentra la pos del array
    //if ( )
    
    
    }




</script>

</BODY>
</HTML>
