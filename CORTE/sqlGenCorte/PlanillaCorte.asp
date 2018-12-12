<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<%Usuario = Request.Cookies("Usuario")("USUARIO")
  txtPerfil = Request.Cookies("Usuario")("Perfil")
 Dim rs
 Dim ofi, corte
 
 ofi = trim(Request.QueryString("ofi"))
 corte = trim(Request.QueryString("corte"))
 
 set rs = CreateObject("ADODB.RecordSet")
 rs.open "sp_Genera_Planilla_Corte '"&ofi&"', '"&corte&"' ", Cnn,3,1  
 
  %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Planilla de Corte</title>
<link rel="stylesheet" type="text/css" href="../INCLUDES/superEstilos.css" media="screen" />
<script src="../INCLUDES/jquery/jquery-3.1.1.min.js"></script>
<script src="jsGenCorte/MANCORTE.js"></script>
<link rel="stylesheet" href="../INCLUDES/jquery/jquery-ui.css">
<script src="../INCLUDES/jquery/jquery-1.12.4.js"></script>
<script src="../INCLUDES/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="../INCLUDES/jquery/jquery.numeric.js"></script>
<script type="text/javascript" src="../INCLUDES/jquery/jquery.numeric.min.js"></script>
<script type="text/javascript" src="../INCLUDES/jquery/jquery.mask.js"></script>
<script type="text/javascript" src="../INCLUDES/jquery/comunes.js"></script>
</head>
<body>
<form>

  <div>
			<table width="50%" border="0" >
			  <tbody>
				<tr>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">Orden de Corte</td>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">Style</td>
				</tr> 
				<tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Orden de Produccion</td>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">Cantidad Habilitado</td>
				</tr> 
				
				<tr> 
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Cliente</td>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">Color</td>
				</tr> 
				<tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Fecha</td>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">Partida</td>
				</tr> 
				<tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Tela</td>
				</tr> 
				<tr>
				  <td width="25%" style="border:hidden;" id="celTejido"  class="ctrlNormal"></td>
				</tr> 
				<tr>
				</tr>
			</tbody>
			</table></br>
			<table border="1" style=" border-collapse: collapse;solid #000;" width="50%">
				<tr>
					<td>PQTE</td>
					<td>TALLA</td>						
					<td>PZAS</td>	
					<td>NUMERACION</td>	
					<td>FECHA</td>			
				</tr>
			</table></br>
			<table width="50%" border="1" style="border-collapse: collapse;solid #000;">
				<%
				Listado = true
				DO WHILE Listado%>
				<tr>
					<td><%=rs("NPQTE")%></td>
					<td><%=rs("CD_CTALLA")%></td>						
					<td><%=rs("CD_NCANT")%></td>	
					<td><%=CSTR(rs("DESDE"))+" - "+cstr(rs("HASTA")) %></td>
					<td><%=rs("CT_FECHA")%></td> 
				</tr>
				<%
				rs.moveNext
				if rs.EOF then
					Listado = false
				End if
				LOOP%>
			</table>
			</br>
			
			<table style="margin:0 auto;border: 0px solid #000;">
			<tr>
				<td><input type="button" id="bntImprimir" value="::Imprimir Corte::" class="btn"/></td>
			</tr>
			</table>
  </div>
</form>
</body>
</html>

