<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% 'Option Explicit %>
<!--#include file="code/subefoto.code.asp"-->
<% Response.Buffer = true 
if len(request.QueryString("opp")) > 0 then
    response.Cookies("usuario")("tela")=  Request.QueryString("usr")+ Request.QueryString("opp")
end if    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::::::: INTRANET - EL MODELADOR SA :::::::</title>
<link rel="stylesheet" type="text/css" href="includes/estilo2.css"/>
<script type="text/javascript" language="javascript" src="includes/rutinas.js"></script>
</head>
<body scroll=no>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td width="10%">
		<img src="imagenes/cerrar.gif" style="cursor:pointer;" onclick="window.close()">
	</td>
	<td width="80%" align="left">
		<div align="center"><font face="arial" color="black"  size="2"><b>
		PUBLICAR IMAGEN</b></font>
		</div>
	</td>
	<td width="10%" align="left">&nbsp;</td>
	</tr>
</table>
<hr />
<br />
<form  name="form" id="form" action="subefoto.asp" method="post" enctype="multipart/form-data">
	<table width="100%" cellspacing="0" cellpadding="0" id="tabla">
  <tr>
    <th width="12%" scope="row">Foto:</th>
    <td width="88%"><input type="file" name="fichero" id="fichero"  >
	  </td>
  </tr>
</table>
  <div align="center" ><img src="imagenes/DONE.JPG" style="cursor:pointer;" onclick=" Graba()">
    </div>
</form>

<script type="text/javascript" language="javascript">
function Graba(){
	
	document.getElementById('form').submit()
}
</script>
</body>
</html>
