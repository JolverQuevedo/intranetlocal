<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<LINK REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%DIM OWNER 
owner = Application("owner")

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
POS = Request.QueryString("pos")
CAD =	" SELECT  MENU,				" & _
		" upper(DESMENU) AS DESMENU	" & _
		" FROM "&OWNER&".MENU  WHERE			" & _
		" ESTADO='A'				" & _
		" ORDER BY DESMENU			" 
'Response.Write (CAD)
	RS.Open CAD, Cnn
	CONT = 1
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ACTION=""><HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border="0" text="black">
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="center" cols=2 width="100%"
	 cellpadding=2  cellspacing=1 bordercolor=white
	  bgcolor=navy border=1 >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<TR bgcolor=#006699 >
<%	LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<TD align="middle">
		<FONT face=arial COLOR=ivory SIZE=1>
		<B><%=RS.FIELDS(I).NAME%></B>
		</FONT>
	</TD>
<%next%>	
</TR>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF RS.recordcount > 0 and trim(pos) <> ""  THEN RS.MOVEFIRST
IF RS.recordcount > 0 and trim(pos) = ""  THEN 
	rs.movelast
	rs.movenext
end if%>
<%DO WHILE NOT RS.EOF%>
	<tr <% IF CONT mod 2  = 0 THEN %> bgcolor=#f8fefb  <%ELSE%> bgcolor=#c5d6d9 <%end IF%> 	
		onclick="dd('<%=(cont)%>');FICHA('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
		<TD id='opc<%=cont%>'><FONT face=arial COLOR=midnightblue SIZE=1><B><%=RS.FIELDS.ITEM(0)%></TD>
		<TD id='des<%=cont%>'><FONT face=arial COLOR=midnightblue SIZE=1><B><%=RS.FIELDS.ITEM(1)%></TD>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </TD>
  </tr>
</TABLE>

<br>
<script>
oldrow=1
menu = ''
pos = '<%=trim(pos)%>'
if (pos != '') dd('1');
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#F8FEFB'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='#C5D6D9'");
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		eval("document.all.fila"+ff+".style.backgroundColor='#99CC99'");
		oldrow=pos
		menu = eval("document.all.opc" + oldrow + ".innerText")
		return true;
	}
}
function FICHA(opc)
{	usr = '<%=trim(pos)%>'
	cad = 'opcusr.asp?pos='+menu+'&usr='+usr
	//alert(cad)
	top.window.frames[3].location.replace(cad)
}

</script>    
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
	
	
	


</FORM>
</BODY>
</HTML>
