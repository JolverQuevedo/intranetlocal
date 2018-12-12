<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

 
 <form name="thisForm" METHOD="post"  >
<table WIDTH=100%>
<tr>
	<td align= left WIDTH=35% ROWSPAN=2>
		<img src="../imagenes/ATRAS.gif" 
		style="cursor:hand;"
		onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=14');">
	</td>
	<td align= CENTER colspan="4">
		<font face=arial size= 3 color=DarkBlue><B>DESCONTABILIZA TIENDAS
		</b></font>
	</td>
	<TD ALIGN=right WIDTH=35% ROWSPAN=2><img src="../imagenes/logo.GIF"></TD>
</TR>    
<%MesES="ENERO,FEBRERO,MARZO,ABRIL,MAYO,JUNIO,JULIO,AGOSTO,SETIEMBRE,OCTUBRE,NOVIEMBRE,DICIEMBRE"  
aMes= split(meses,",")%>
<TR><td>Mes</td>
	<TD ALIGN=CENTER>	
		<SELECT ID="mes" NAME="mes" CLASS=DATOSGRANDE>
			<option value=''></option>
		<%FOR I =0 TO 11%>
			<option value='<%=I+1%>'><%=AmES(I)%></OPTION>

		<%NEXT%>
		</SELECT>
	</TD><td>Año</td>
    <td><SELECT ID="ano" NAME="ano" CLASS=DATOSGRANDE >
			<option value=''></option>
		<%FOR I =2013 TO year(date())%>
			<option value='<%=I%>'><%=I%></OPTION>

		<%NEXT%>
		</SELECT>
    </td>
    <td></td>
</TR>
<TR><td COLSPAN="6"><HR></td></TR>
<tr><td colspan="6" align="center"><input type="button" value="ELIMINAR" onclick="MANDA()"/></td></tr>
</table>
</form>
<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="dele" name="dele"  scrolling="yes" frameborder="1" height="250" align="middle" ></iframe>


<script type="text/jscript" language="jscript">

var aMes = new Array("ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO", "JUNIO", "JULIO", "AGOSTO", "SETIEMBRE", "OCTUBRE", "NOVIEMBRE", "DICIEMBRE")

function MANDA() {
    if (trim(thisForm.mes.value) == '' || trim(thisForm.ano.value) == '') {
        alert("Datos incompetos, Revise")
    return false}
        cad = '../comun/del_conta.asp?mes=' + trim(thisForm.mes.value)
        cad += '&ano=' + trim(thisForm.ano.value)
        //alert(cad)
        document.all.dele.src=cad
    }



 </script>


</BODY>
</HTML>
