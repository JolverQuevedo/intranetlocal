<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Option Explicit %>
<!--#include file="code/ingreso.code.asp"-->
<% Response.Buffer = true %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::::::: INTRANET - MODELADOR :::::::</title>
<style type="text/css">
BODY{overflow:auto}
</style>
</head>
<body  bgcolor="#b7cad2"   >
<br>
<br>
<form action="ingreso.asp" method="post" id="frmIngreso" onSubmit="return Ingresar()">
 <table  align="center" width="471" border="1" cellspacing = "4" cellpadding=4 >
    <tr>
	<td background="imagenes/home-INTRANET.jpg"  style="cursor:hand" height="160" valign="top" align="right" colSpan="2" onClick="window.location.replace('../index.html')">
	<font face="Arial" size="5"><b>EL MODELADOR &nbsp;</b></font>
	</td>
	</tr>
	<tr>
	<td bgcolor=#009942><table width="100%"  border="0"       
      align="center" cellpadding="0" cellspacing="0">
      <tr >
        <td  colspan="2">&nbsp;</td>
      </tr>
      <tr >
        <td width="50%" align="right" ><strong> <font face="Arial" size="2" color="#ffffff"> Usuario :</font></strong> </td>
        <td width="50%" ><input name="txtUsr" size="30" id="txtUsr" onBlur="this.value=this.value.toUpperCase()">
        </td>
      </tr>
      <tr  >
        <td >&nbsp;</td>
        <td >&nbsp;</td>
      </tr>
      <tr  >
        <td align="right"><strong> <font size="2" face="Arial"   color="#ffffff"> Password : </font></strong> </td>
        <td ><input name="txtPwd" id="txtPwd" type="password" size="30" 
           >
        </td>
      </tr>
      <tr >
        <td  colspan="2">&nbsp;</td>
      </tr>
      <tr >
        <td valign="center" height="51" >&nbsp;</td>
        <td align= "middle" height="51" valign="center"><input id="button1" name="button1" type="submit" value="Ingresar" >
        </td>
      </tr>
    </table></td>
	</tr>
</table>
</form>
<script language="javascript" src="INCLUDES/rutinas.js"></script>
<script language="javascript">
//Poner foco al elemnto inicial
document.getElementById("txtUsr").focus()

function Ingresar(){

	var btn= document.getElementById("button1")
	var _user=document.getElementById("txtUsr")
	var _pwd=document.getElementById("txtPwd")
	btn.disabled=true
	Formatotxt(_user,false,1)

	if(_user.value==''){
		MensajeForm("Debe ingresar su Usuario",_user)
		btn.disabled=false
		return false
	}
	else if(_pwd.value==''){
		MensajeForm("Debe ingresar su Password",_pwd)
		btn.disabled=false
		return false
	}
	else
		return true
}
</script>
</body>
</html>