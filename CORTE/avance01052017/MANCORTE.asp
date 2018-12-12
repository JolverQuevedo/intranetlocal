<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")
  txtPerfil = Request.Cookies("Usuario")("Perfil")
  Session("ManCorte") = null
  Session("ManCorteDet") = null
 %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Mantenimiento de Corte</title>
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
  <table WIDTH="100%">
    <tr>
      <td align= "left" WIDTH="35%"><img src="../imagenes/ATRAS.gif"  alt="" style="cursor:hand;"
			onclick="javascript: window.location.replace('../SUBMENU.ASP?TIPO=16');"></td>
      <td align= CENTER><table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" 
		width="100%" bordercolorlight="#f7d975">
        <tr>
          <td>MANTENIMIENTO DE CORTE</td>
        </tr>
      </table></td>
      <TD ALIGN=right WIDTH=35%><img src="../imagenes/logo.GIF"  ></TD>
    </TR>
  </tr>
  
  <TR>
    <td COLSPAN=3><HR></td>
  </TR>
  </table>
  <div style="text-align:center;">
			<table width="50%" border="1" style="margin:0 auto;border: 1px solid #000;">
			  <tbody>
				<tr>
				  <td width="27%" class="fondocelda" style="text-align:left;border:hidden;">#Corte</td>
				  <td width="73%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtnroCORTE" id="txtnroCORTE" class="ctrlenable" maxlength="5" ></td>
				</tr>
				<tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">#OFI</td>
				  <td width="25%" style="border:hidden;" id="celOFI" class="ctrlNormal"></td>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Prenda</td>
				  <td width="25%" style="border:hidden;" id="celPrenda"  class="ctrlNormal"></td>
				</tr>
				 <tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Color</td>
				  <td width="25%" style="border:hidden;" id="celColor"  class="ctrlNormal"></td>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Tejido</td>
				  <td width="25%" style="border:hidden;" id="celTejido"  class="ctrlNormal"></td>
				</tr>
				<tr>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Estilo</td>
				  <td width="25%" style="border:hidden;" id="celEstilo"  class="ctrlNormal"></td>
				  <td width="25%" class="fondocelda" style="border:hidden;text-align:left;">Articulo</td>
				  <td width="25%" style="border:hidden;" id="celArticulo"  class="ctrlNormal"></td>
				</tr>
			</tbody>
			</table></br>
			<table width="50%" border="1" style="margin:0 auto;border: 1px solid #000;">
				<tr>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Fecha</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtFecha" id="txtFecha" class="clsFecha" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Peso Paño</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtPesoPano" id="txtPesoPano" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Tapeta</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtTapeta" id="txtTapeta" class="ctrlenable" ></td>
				</tr>
				<tr>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Cons Estimado</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtConsEstimado" id="txtConsEstimado" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Pza x Paño</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtPzaPano" id="txtPzaPano" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Retazos</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtRetazos" id="txtRetazos" class="ctrlenable" ></td>
				</tr>
				<tr>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Cons Real</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtConsReal" id="txtConsReal" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Paños</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtPanos" id="txtPanos" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Puntas</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtPuntas" id="txtPuntas" class="ctrlenable" ></td>
				</tr>
				<tr>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Ancho</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtAncho" id="txtAncho" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Kg.</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtKg" id="txtKg" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Fallados</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtFallados" id="txtFallados" class="ctrlenable" ></td>
				</tr>
				<tr>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Larg. Tend</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtLargo" id="txtLargo" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Sobrantes</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtSobrantes" id="txtSobrantes" class="ctrlenable" ></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Partida</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtPartida" id="txtPartida" class="ctrlenable" ></td>
				</tr>
				<tr>
				  <td width="16%" style="text-align:left;border:hidden;"></td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"></td>
				  <td width="16%" style="text-align:left;border:hidden;"></td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"></td>
				  <td width="16%" class="fondocelda" style="text-align:left;border:hidden;">Metros</td>
				  <td width="16%" colspan="3" style="text-align:left;border:hidden;"><input type="text" name="txtMetros" id="txtMetros" class="ctrlenable" ></td>
				</tr>
				<tr>
					<td style="text-align:left;border:hidden;" class="fondocelda" colspan="4">
					Local<input name="RadioGroup1" value="1" id="L1" class="opt1" checked="checked" type="radio"> Servicio<input name="RadioGroup1" value="2" id="S1" class="opt1" type="radio">
					</td>
					<td colspan="4" id="celRadio" name="celRadio">
					<select id="cboModulo" name="cboModulo"><option>--Seleccionar--</option></select>
					</td>
					<td class="fondocelda" style="text-align:left;border:hidden;">Paquete de</td>
					<td colspan="3" style="text-align:left;border:hidden;">
					<input type="text" name="txtPqte" id="txtPqte" class="ctrlenable" size="5" >&nbsp; <span class="ctrlNormal">Pzas</span></td>
					
				</tr>
				
			</table>
			</br>
			<table width="50%" border="0" style="margin:0 auto;border: 1px solid #000;" name="tbTallas" id="tbTallas">
				<tr>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">#</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Articulo</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Talla</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Original</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Edicion</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Grupos</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Desde</td>
				  <td width="12%" class="fondocelda" style="text-align:left;border:hidden;">Hasta</td>
				</tr>
				<tr>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				</tr>
				<tr>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;" class="ctrldisable"><input type="text" value="0.00" name="txtTotEdicion" id="txtTotEdicion" /></td>
				  <td width="12%" style="text-align:left;border:hidden;" class="ctrldisable"><input type="text" value="0.00" name="txtTotGrupos" id="txtTotGrupos" /></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				  <td width="12%" style="text-align:left;border:hidden;"></td>
				</tr>
			</table>
			<table style="margin:0 auto;border: 0px solid #000;">
			<tr>
				<td><input type="button" id="bntGrabar" value="::Grabar Corte::" class="btn"/></td>
				<td><input type="button" id="bntImprimir" value="::Imprimir Corte::" class="btn"/></td>
			</tr>
			</table>
  </div>
</form>
</body>
</html>

