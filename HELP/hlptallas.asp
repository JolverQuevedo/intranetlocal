<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") 
%>

<script language="jscript" type="text/jscript">
var ubi = 0

function REDIR(ff)
{	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad =  trim(t.rows(pos).cells(0).innerText);
	eval("window.opener.window.document.all.T"+ubi+".value=cad");
	eval("window.opener.window.document.all.T"+ubi+".style.display='block'");
	eval("window.opener.window.document.all.R" + ubi + ".style.display='block'");
    if (ubi < 9 )
        ubi++
    else
    alert("Solo se trabaja con size breakdown de 10 tallas")
	
//	window.close();
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;	
	dd(ff);
}

function achica()
{	window.resizeTo(300,400)
	}
</script>
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cli = Request.QueryString("POS")
maxi = Request.QueryString("maxi")

CAD =	" SELECT TALLA, ORDEN, NOMBRE   " & _ 
		" from CLIENTE_TALLA as cc      " & _
		" inner join cliente as c1 on   " & _
		" cc.codcliente =c1.codigo      " & _
		" where  cc.ESTADO='A' AND  	" & _ 
		"  CODcliente ='"&cli&"'     	" & _
		" ORDER BY 2                    " 
'		response.Write(CAD)
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF rs.recordcount > 0 THEN
	RS.MOVEFIRST
    else
        response.write("No tenemos tallas asignadas a este Cliente")
        RESPONSE.END
END IF %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" onload="achica()" >
<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" onClick="javascript: window.close();">
		</td>
		<td align="center"><font face="arial" size="2" color="DarkBlue"><b>TALLAS DE : <%IF RS.RECORDCOUNT>0 THEN RESPONSE.Write(rs("NOMBRE")) END IF%></b></font></td>
        </tr>
	</tr>
	<tr><td colspan="3"><HR></td></tr>
</table>
<table id="TABLA" align="center"  bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%for I=0 to 1 %>
	<td align="center" >
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
	<%for i=0 to 1%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=trim(RS.FIELDS.ITEM(I))%></b>&nbsp;
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
<script>
dd2('1');
 mm = parseInt('<%=trim(maxi)%>',10)
	// blanquea todas las tallas....
	for (j=0; j<=mm; j++)
	{	eval("window.opener.window.document.all.T"+j+".value=''");
		eval("window.opener.window.document.all.R"+j+".value=''");
		eval("window.opener.window.document.all.T"+j+".style.display='none'");
		eval("window.opener.window.document.all.R"+j+".style.display='none'");
	}

</script>    
</form>
</BODY>
</HTML>
