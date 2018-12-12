<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Response.Buffer = true %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")
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
.Estilo8 {font-family: Tahoma; font-size: 10px; color: #1A528D; }
A
{TEXT-DECORATION: none;
color:white }

A:hover
{	COLOR: white;}

td.special { 
background-image: url('imagenes/boton2.JPG');
background-repeat: repeat-x;
background-position: center;
}
td.special2 { 
background-image: url('imagenes/boton1.JPG');
background-repeat: repeat-x;
background-position: center;
}
--></STYLE>

</head>
<body>
<table width="1024" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="144" rowspan="3" valign=top align="right"><IMG src="imagenes/logo.jpg" name="IMG1" width=143 height=121 id=IMG1 ></td>
        <td width="100%" height="56" valign="top" background="imagenes/fondito2.jpg"><div align="left"><IMG height=59 src="imagenes/titulo.jpg" width=307 ></div></td>
      </tr>
      <tr>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="42" background="imagenes/fondito.jpg"><table width="150" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="119" valign="center"><table width="150" border="0" cellspacing="1" cellpadding="1">
                  <tr>
                    <td><div align="right"><span class="Estilo6"><%=UCase(usuario)%></span></div></td>
                  </tr>
                </table></td>
                <td width="31" valign="top"><IMG height=25 src="imagenes/usuario.jpg" width=31 ></td>
              </tr>
              <tr>
                <td height="13" colspan="2" valign="bottom">
                <div align="right"><span class="Estilo8"><%=now()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="19" valign="top">&nbsp;</td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="234">
          
<!--#include file="includes/Cnn.inc"-->
<%DIM OWNER
owner = Application("owner")
cSQL	=	" SELECT MENU.MENU,MENU.DESMENU AS DESMENU, MENU.PROGRAMA,   " & _ 
			" MENU.FOTO	FROM "&OWNER&".[USR-OPC] AS [USR-OPC] LEFT OUTER " & _
			" JOIN "&OWNER&".MENU AS MENU ON [USR-OPC].MENU = MENU.MENU  " & _
			" WHERE USUARIO = '"&USUARIO&"' and MENU.ESTADO='A'          " & _
            " and menu.desmenu <> 'EXTRANET'                             " & _
			" GROUP BY MENU.DESMENU, MENU.PROGRAMA, MENU.FOTO, MENU.MENU " & _
			" ORDER BY MENU.DESMENU                                      "
			'Response.Write(CsQL)
			RS.Open cSQL, Cnn
			
If rs.EOF then
	RS.Close 
	Cnn.Close
	set Cnn = Nothing
	set RS = Nothing
 %>
	<FONT FACE=ARIAL color=red ><B>
	<p align="center">Usted no tiene opciones disponibles.</p></b></FONT>
<%
Else %>

<form name="ItemUno">
	<input type="hidden" name="txtprg" value="<%=rs("Programa")%>">
	<input type="hidden" name="txtopc" value="<%=rs("MENU")%>">
	<input type="hidden" name="txtdsc" value="<%=Trim(rs("DesMENU"))%>">
</form>	
<table border="0" cellspacing="4" cellpadding="4" 
width=80% title="Opciones del usuario" align="CENTER">
<%	do  %>
<%CONT = 0%>
	<tr>
		<td width="30%" class=special2 onMouseOver="this.className='special'" 
		onmouseout="this.className='special2'" align = center style="cursor:hand"
		onclick= "window.location.replace('<%=rs("programa")%>')">
			<font face="ARIAL" size="2"  color=white>
		      <strong><%=RS("DESMENU")%></strong>
		    </font>
		  </td>
		<%rs.movenext%> 
		<%if rs.EOF then exit do%> 
		  <td width="30%"class=special2 onMouseOver="this.className='special'" 
		  onmouseout="this.className='special2'" align=center	style="cursor:hand"
		onclick= "window.location.replace('<%=rs("programa")%>')">
			<font face="ARIAL" size="2"  color=white>
		      <strong><%=RS("DESMENU")%></strong>
		    </font>
		  </td>
		
	<%rs.movenext%>
	<%if rs.EOF then exit do%> 
		  <td width="30%" class=special2 onMouseOver="this.className='special'" 
		  onmouseout="this.className='special2'" align=center	style="cursor:hand"
		onclick= "window.location.replace('<%=rs("programa")%>')">
			<font face="ARIAL" size="2"  color=white>
		      <strong><%=RS("DESMENU")%></strong>
		    </font>
		</tr>
	<%rs.movenext%>
<%  Loop until rs.EOF
	RS.Close 
	Cnn.Close
	set Cnn = Nothing
	set RS = Nothing
%>
</table>

<%	End If%>
</td>
        </tr>
      </table></td>
  </tr>
</table>
<script>
function cambia(obj)
{	obj.style.backgroundImage='imagenes/boton3.jpg'
alert()
}
</script>
</body>
</html>