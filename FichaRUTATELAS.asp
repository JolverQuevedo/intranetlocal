<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	tel = Request.QueryString("tel")
	rut = Request.QueryString("rut")
	des = Request.QueryString("des")
%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
var check = 1
var dele = 0
function window_onfocus() {
return true
}
function BORRA()
{	pos = dele
	for (i=0 ; i<pos; i++)	
	{	eval("thisForm.pos"+i+".value=''")
		eval("thisForm.chk"+i+".checked=false")
		check = 1
	}

return true
}
function NUMERA(op)
{	if (trim(eval("thisForm.desc"+op+".value")) == '')
	{	eval("thisForm.chk"+op+".checked=false")
		eval("thisForm.pos"+op+".value=''")
		return true;
	}
	if (eval("thisForm.chk"+op+".checked")==true)
	{eval("thisForm.pos"+op+".value=check++")}
	else
	{eval("thisForm.pos"+op+".value=''")}
	return true
}
//-->
</script>
<%CAD = "SELECT DESCRIPCION FROM TELAS WHERE TELA = '"&TEL&"'"
RS.OPEN CAD,CNN
'response.Write(tel)
DESTEL = RS("DESCRIPCION")
RS.CLOSE
rs.open "select descriptor from telarutahead where tela = '"&tel&"' and version ='"&rut&"'", cnn
des = rs("descriptor")
rs.close
%>
<form id="thisForm" method="post" action="comun/inserRUTA.asp">
<table border ="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center"> 
		<td><img src="imagenes/CERRAR.gif" style="cursor:hand;" onClick="javascript: window.close();" alt="" /></td>		
		<td align="center"><font face="arial" size="3" color='<%=(Application("titulo"))%>'><b>PROCESOS DE ACABADOS TELA: <%=trim(TEL)%>  <br />
        <font face="arial" size="1" color="<%=(Application("resalte"))%>" ><b><%=DEK%>
		<br /><%=DESTEL%></b></font><br />
        <font face="arial" size="1" color="<%=(Application("contraste"))%>" ><b>Ruta: <%=rut%> - <%=des%></b></font>
		 <input type="hidden" id="TELA" name="TELA" value="<%=TEL%>">
		<input type="hidden" id="RUT" name="RUT" value="<%=RUT%>">
	</td>
	<td align="right" width="1%"><img src="imagenes/logo.gif" alt="" /></td>
	<tr>
    	<td colspan="3"><hr size="1" color="RED"></td>
	</tr>
</table>	
<taBLE BORDER=0 align="center">
	<tr >
		<td align = right  
			><img src=imagenes/disk.gif
				style="cursor:hand;" 
				onclick="return GRABA();"
		></td>
		<td align = right  
			><img src=imagenes/print.gif
				style="cursor:hand;" 
				onclick="PRN()"
		></td>
	</tr>
</table>
<%CAD =	" SELECT tela, servicio AS codigo, opc, SS.DESCRIPCION,	" & _
		" TIPOSER.DESCRIPCION AS TIPO FROM TELARUTADETA 		" & _
		" INNER JOIN SERVICIOS SS ON SERVICIO = CODIGO 			" & _
		" iNNER JOIN TIPOSER ON SS.TIPO = TIPOSER.CODIGO 		" & _
		" WHERE TELA = '"&TEL&"' AND SS.ESTADO = 'A' and 		" & _
		" version = '"&RUT&"' AND TIPOSER.CODIGO='TEL'			" & _
		" UNION 												" & _
		" SELECT '' AS TELA, SS.codigo, ''AS opc, 				" & _
		" SS.DEScripcion, TIPOSER.DESCRIPCION AS TIPO 			" & _
		" FROM servicios SS 									" & _
		" INNER JOIN TIPOSER ON SS.TIPO = TIPOSER.CODIGO 		" & _
		" WHERE SS.codigo NOT IN (SELECT servicio 				" & _
		" FROM TELARUTADETA WHERE TELA = '"&TEL&"' 				" & _
		" and version = '"&RUT&"' ) AND SS.ESTADO = 'a' 		" & _
		" AND TIPOSER.CODIGO='TEL'								" & _
		" ORDER BY TELA DESC, opc, SS.DEScripcion, CODIGO 	 	"
		'Response.Write(cad)
		RS.OPEN CAD ,CNN
if rs.recordcount> 0 then	
	RS.MOVEFIRST
else
	Response.Write("<center>")
	Response.Write("<font face = arial size=3 color = red>")
	
	Response.Write("<B>")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("Este Artículo no tiene los datos completos")
	Response.Write("<br>")
	Response.Write("<br>")
	Response.Write("R E V I S A R... su Ficha Técnica")
	Response.end
end if 		
'RS.OPEN CAD, CNN%>
<TABLE width="100%" border="0" id="SERV" name="SERV">
<%cont = 0%>
<%IF RS.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY SERVICIOS REGISTRADOS.... <br />
		Avise a PLANEAMIENTO
</center>
<br />
<%else%>
<%rs.movefirst%>
	<tr bgcolor='<%=application("barra")%>'>
		<td width="5%" class="titulito">CODIGO</td>
		<td width=1% align="center" valign="middle"><img border="0" style="cursor:hand;" onClick="BORRA()"	alt="BORRAR SELECCION"	src="imagenes/eraser.jpg">
		</td>
		<td width="1%" class="titulito">#</td>
		<td width="50%" class="titulito">DESCRIPCION</td>
		<td width="10%" class="titulito">TIPO</td>
	</tr>		
	<%DO WHILE NOT RS.EOF%>
		<tr <%if CONT mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	>
			<td width=10% align="center" >
				<input id="cod<%=cont%>" name="cod<%=cont%>" readonly="readonly" value="<%=trim(RS("CODIGO"))%>"	class="DESCRIPTORCENTERnavy"></td>
			<td width="1%" align="center">
				<input type="checkbox" id="chk<%=cont%>" name="chk<%=cont%>" onClick="NUMERA('<%=cont%>')" 
				<%IF RS("TELA")<> "" THEN%>checked<%END IF%>> 
			</td>
			<td width="5%" align="center">
				<input type="text"  id="pos<%=cont%>" name="pos<%=cont%>" maxlength="3" class="DESCRIPTORCENTERnavy" readonly="readonly"	value=<%IF RS("TELA")<> "" THEN%>
					<%=trim(RS("OPC"))%>
				<%END IF%>> 
			</td>
			<td>
				<input id="desc<%=cont%>" name="desc<%=cont%>" class="descriptores" value='<%=trim(rs("descripcion"))%>' readonly="readonly">
			</td>
			<td>
				<input id="TIPO<%=cont%>" name="TIPO<%=cont%>" class="DESCRIPTORCENTERnavy" value="<%=trim(rs("TIPO"))%>" readonly="readonly"></td>
		</tr>
		<%RS.MOVENEXT%>
		<%cont = cont + 1%>
	<%LOOP%>
	<%I=cont%>
	
</table>	
<%end if%>

<table  border="0" cellpadding="0" align="center" cellspacing="1" width="100%" bgcolor="<%=application("color2")%>" bordercolor="SeaGreen" bordercolordark="DARKGREEN" bordercolorlight="LightSeaGreen">
	<tr>
		<td colspan="6">
		<hr size="1" color="RED">
		</td>
	</tr>
</table>
<table  border="0" cellpadding="0" align="center" cellspacing="8" >    
	<tr>	
		<td class="TEXTO2" >Fecha :</td>
		<td class="TEXTOazul2"  ><%=DATE()%></td>
		<td class="TEXTO2" >Usuario :</td>
		<td class="TEXTOAZUl2" ><%=TXTUSUARIO%></td>
		<td class="TEXTO2" >Estado :</td>
		<td class="TEXTOAZUL2" >A<input type="hidden" id="CONTADOR" name="CONTADOR">
		</td>
	</tr>
</table>	
<%
set rs= nothing
set cnn=nothing
%>
</form>
<script>
dele = '<%=cont%>'
pos = parseInt(dele,10)
thisForm.CONTADOR.value = pos
check = 0
for (i=0 ; i<pos; i++)	
{	if(eval("thisForm.pos"+i+".value")!='')
	{	eval("thisForm.chk"+i+".checked=true")
		check++
	}
}
function GRABA()
{	//alert(thisForm.CONTADOR.value = pos)
	i = 0;	
	var t = ''
	cont = 0
	for (ii=0; ii<dele; ii++)
	{	if (eval("thisForm.chk"+ii+".checked") == true )
		{	cont++; 	
		}	
	}
	if (cont == 0)
	{	alert("Debe seleccionar ALGUN PASO para la secuencia acabados de la tela")
		return true;
	}
	thisForm.action = "comun/inserRUTAdeta.ASP"
	thisForm.submit()
}
function PRN()
{	cad = 'reportes/prnRUTATELA.asp?tel='+'<%=TRIM(tel)%>'
	cad += '&rut=' + trim(thisForm.RUT.value)
	var opc = "directories=no,height=500," ;
		opc = opc + "hotkeys=no,location=no," ;
		opc = opc + "menubar=no,resizable=YES," ;
		opc = opc + "left=0,top=0,scrollbars=yes," ;
		opc = opc + "status=no,titlebar=no,toolbar=no," ;
		opc = opc + "width=700";
	window.open(cad,"RUTA_TINTORERIA",opc)
}

</script>
</BODY>
</HTML>
