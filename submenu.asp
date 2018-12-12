<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Response.Buffer = true %>
<%txtUsuario = Request.Cookies("Usuario")("USUARIO")
  txtPerfil = Request.Cookies("Usuario")("Perfil")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::::::: INTRANET - PPFS :::::::</title>
<style type="text/css">
<!--
body {
	background-image: url(imagenes/fondo.jpg);
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.Estilo6 {
	font-family: Tahoma;
	font-size: 10px;
	color: #FFFFFF;
}
.Estilo6 {
	font-family: Tahoma;
	font-size: 14px;
	color: #FFFFFF;
}
.Estilo16 {
	font-family: Tahoma;
	font-weight:900;
	font-size: 14px;
	color: #66B727;
}
.Estilo8 {font-family: Tahoma; font-size: 10px; color: #1A528D; }
A
{TEXT-DECORATION: none;
color:white }

A:hover
{	COLOR: #66B727;}
td.special { 
background-image: url('imagenes/boton2.JPG');
background-repeat: no-repeat;
background-position: center;
}
td.special2 { 
background-image: url('imagenes/boton1.JPG');
background-repeat:no-repeat;
background-position: center;
}
--></style>
</style>
</head>
<body>
<!--#include file="includes/Cnn.inc"-->
  <%	  ' Open Database Connection
	TIPO = Request.QueryString("TIPO")
	DIM OWNER
	owner = Application("owner")
		cad = "select * from "&OWNER&".MENU AS MENU where MENU.MENU = '"&tipo&"'"
        RS.OPEN CAD, cNN
        'Response.Write(CAD)
        'Response.END
        IF NOT RS.EOF OR NOT RS.BOF THEN
			RS.MoveFirst
		ELSE %>
  <SCRIPT>window.location.replace('menu.asp')	</SCRIPT>
  <%end if%>
<table width="1024" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="144" rowspan="3" valign=top align="right"><IMG src="imagenes/logo.jpg" 
        name="IMG1" width=143 height=121 id=IMG1 ></td>
        <td width="50%" height="56" valign="top" background="imagenes/fondito2.jpg"><div align="left"><IMG 
        height=59 src="imagenes/titulo.jpg" width=307 ></div></td>
        <td width="50%" valign="bottom" background="imagenes/fondito2.jpg" align=right>
        <span class="Estilo16">
       Sub-menú : <%=rs("desmenu")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
      </tr>
      <tr>
        <td colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="42" background="imagenes/fondito.jpg"><table width="150" border="0" 
            align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="119" valign="center"><table width="150" border="0" cellspacing="1" cellpadding="1">
                  <tr>
                    <td><div align="right"><span class="Estilo6">Usuario : <%=UCase(txtusuario)%></span></div></td>
                  </tr>
                </table></td>
                <td width="31" valign="top"><IMG height=25 src="imagenes/usuario.jpg" width=31 ></td>
              </tr>
              <tr>
                <td height="13" colspan="2" valign="bottom"><div align="right"><span class="Estilo8"><%=now()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="19" colspan="2" valign="top">&nbsp;</td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="234">
          

 <%'*********************************%>
  <%'RECORDSET PARA LLENAR EL SUB MENU%>
  <%'*********************************%>
  <%MENU = Request.QueryString("TIPO")%>
  <%
  owner = Application("owner")
  cad =	" SELECT SUBMENU.SUBMENU, SUBMENU.DESCRIPCION,  " & _
			" SUBMENU.PROGRAMA, [USR-OPC].PERFIL, " & _
			" SUBMENU.PARAMETROS " & _
			" FROM "&OWNER&".[USR-OPC] AS [USR-OPC] INNER JOIN " & _
			" "&OWNER&".SUBMENU AS SUBMENU ON [USR-OPC].MENU = SUBMENU.MENU AND  " & _
			" [USR-OPC].SUBMENU = SUBMENU.SUBMENU " & _
			" WHERE ([USR-OPC].USUARIO = '"&txtusuario&"') AND  " & _
			" (SUBMENU.ESTADO = 'A') " & _
			" and SUBMENU.MENU = '"&menu&"'" & _
			" GROUP BY SUBMENU.SUBMENU, SUBMENU.DESCRIPCION,  " & _
			" SUBMENU.PROGRAMA, [USR-OPC].PERFIL, SUBMENU.PARAMETROS " & _
			" ORDER BY SUBMENU.DESCRIPCION " 
  rs.close
	'Response.write(cad)
	RS.OPEN CAD
IF NOT RS.EOF OR NOT RS.BOF THEN
	RS.MoveFirst
ELSE
	response.write("<P ALIGN=CENTER>")
	response.write("<BR>")
	response.write("<FONT SIZE = 3 COLOR = RED FACE = ARIAL>")
	response.write("<BR>")
	response.write("Usted no tiene opciones disponibles para este Módulo")
	response.end %>
	<SCRIPT>//window.location.replace('menu.asp')	</SCRIPT>
<%end if%>

<form name="ItemUno">
	<input type="hidden" name="txtprg" value="<%=rs("Programa")%>">
	<input type="hidden" name="txtopc" value="<%=rs("subMENU")%>">
	<input type="hidden" name="txtdsc" value="<%=Trim(rs("Descripcion"))%>">
</form>	
<table border="0" cellspacing="4" cellpadding="4" 
width=80% title="Opciones del usuario" align="CENTER">
<%	do  %>
  <tr> 

<%CONT = 0%>
	<%for i=0 to 2 %>
		<%if not rs.eof then%>
			<% IF NOT ISNULL(RS("PROGRAMA")) THEN 
					prg= trim(RS("PROGRAMA"))+"?PERFIL="+TRIM(rs("perfil"))+TRIM(RS("PARAMETROS"))	%>
			<%RESPONSE.COOKIES("usuario")("Perfil") = TRIM(rs("perfil"))%>
			  <td width="30%" class=special2 onMouseOver="this.className='special'" 
				onmouseout="this.className='special2'" align = center style="cursor:hand"
				onclick= "window.location.replace('<%=RS("PROGRAMA")%>?PERFIL=<%=TRIM(rs("perfil"))%><%=TRIM(RS("PARAMETROS"))%>')">
				<font face="ARIAL" size="2"  color=white>
		      <strong><%=rs("descripcion")%>
		<%ELSE%>
				<%NO = 1%>
				<font face="ARIAL" size="2"  color=ivory>
				<b><%=rs("descripcion")%></b>
		<%END IF %>    
	<%else%>
	<%exit do%>
</td>
<%end if%>
		<%RS.MOVENEXT%>
     <%next%> 
</tr>     
<%  Loop until rs.EOF
	RS.Close 
	Cnn.Close
	set Cnn = Nothing
	set RS = Nothing
%>
</table>
<CENTER> <A HREF="MENU.ASP" class=estilo16>ATRAS</A>

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          <%'=menu%></td>
        </tr>
      </table></td>
  </tr>
</table>

</body>
</html>