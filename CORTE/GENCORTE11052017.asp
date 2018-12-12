<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")
  txtPerfil = Request.Cookies("Usuario")("Perfil")
  Session("Corte") = null
  Session("CorteDet") = null
 %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Generación de Corte</title>
<link rel="stylesheet" type="text/css" href="../INCLUDES/superEstilos.css" media="screen" />
<script src="../INCLUDES/jquery/jquery-3.1.1.min.js"></script>
<script src="jsGenCorte/GENCORTE.js"></script>
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
          <td>GENERACION DE CORTES</td>
        </tr>
      </table></td>
      <TD ALIGN=right WIDTH=35%><img src="../imagenes/logo.GIF"  ></TD>
    </TR>
  </tr>
  
  <TR>
    <td COLSPAN=3><HR></td>
  </TR>
  </table>
  <table width="101%" border="0">
    <tbody>
      <tr>
        <td width="50%" ><table width="89%" border="0">
          <tbody>
            <tr>
              <td width="27%" class="fondocelda">Ingrese Nro de OFI</td>
              <td width="73%"><input type="text" name="txtnroOFI" id="txtnroOFI" class="ctrlenable" onKeyup="//siNumber(this.value);" >
                <img src="../imagenes/DELETE.gif" alt="ELIMIAR REGISTRO"
			id="btnlimpiar" name="btnlimpiar" style="cursor:hand;" />&nbsp;&nbsp;<label id="lblCodCli" class="lbl"></label></td>
            </tr>
             <tr>
              <td class="fondocelda">Tipo Prenda</td>
              <td><select name="cboTipPrenda"  id="cboTipPrenda" class="combo1">
             		<option value="S">--Seleccionar--</option>
              		<option value="0">Polo</option>
              		<option value="1">Lenceria</option>
              </select></td>
            </tr>
            <tr>
              <td class="fondocelda">Cliente</td>
              <td><input type="text" name="txtCliente" id="txtCliente" class="ctrldisable" size="30"></td>
            </tr>
            <tr>
              <td class="fondocelda">Estilo</td>
              <td><input type="text" name="txtEstilo" id="txtEstilo" class="ctrldisable" size="30"></td>
            </tr>
            <tr>
              <td class="fondocelda">Nro Estilo</td>
              <td><input type="text" name="txtNroEstilo" id="txtNroEstilo" class="ctrldisable" size="30"></td>
            </tr>
            <tr>
              <td class="fondocelda">Descripción</td>
              <td><input type="text" name="txtDescripcion" id="txtDescripcion" class="ctrldisable" size="40"></td>
            </tr>
            <tr>
              <td class="fondocelda">Prenda</td>
              <td><input type="text" name="txtPrenda" id="txtPrenda" class="ctrldisable" size="30"></td>
            </tr>
            <tr>
              <td class="fondocelda">Tela</td>
              <td><input type="text" name="txtTela" id="txtTela" class="ctrldisable" size="40"></td>
            </tr>
            <tr>
              <td class="fondocelda">Código Tela</td>
              <td><input type="text" name="txtCodTela" id="txtCodTela" class="ctrlenable" size="40"></td>
            </tr>
            <tr>
              <td class="fondocelda">Tallas</td>
              <td><input type="text" name="txtTallas" id="txtTallas" class="ctrldisable" size="40"></td>
            </tr>
            <tr>
              <td class="fondocelda">Tiempo Corte</td>
              <td><input type="text" name="txtTiempo" id="txtTiempo" class="ctrlenable" size="30"></td>
            </tr>
            <tr>
              <td colspan="2"><table width="100%" border="0">
                <tbody>
                  <tr>
                    <td class="fondocelda">Articulo [ Taller ]</td>
                  </tr>
                  <tr>
                    <td>
                    	<select name="cboArticulo" id="cboArticulo" class="combo1" >
                    	</select>
                    </td>
                  </tr>
                  <tr>
                    <td class="fondocelda">Ordenes de Producción Relacionadas</td>
                  </tr>
                  <tr>
                    <td><table width="100%" border="0" id="tbPo" name="tbPo">
                      <tbody>
                        <tr>
                          <td class="fondosubcelda">P.O</td>
                          <td class="fondosubcelda">Destino</td>
                        </tr>
                      </tbody>
                    </table></td>
                  </tr>
                  <tr>
                    <td class="fondocelda">Lista de Colores</td>
                  </tr>
                  <tr>
                    <td><table width="100%" border="0" id="tbColores">
                      <tbody>
                        <tr>
                          <td class="fondosubcelda">&nbsp;</td>
                          <td class="fondosubcelda">Colores</td>
                        </tr>
                      </tbody>
                    </table></td>
                  </tr>
                </tbody>
              </table>
              <input type="button" id="b1" value="::Aperturar::" class="btn"/>
              <input type="button" id="bntGrabar" value="::Grabar Corte::" class="btn"/>
              
              </td>
              </tr>
          </tbody>
        </table></td>
        <td width="50%" >
        <!--<input type="button" name="bb1" id="bb1" value="tallas" />-->
		 <div id="tabs" style="display: dnone;" >
			<ul id="ulTabs">
			</ul>
		</div>
        </td>
      </tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
    </tbody>
  </table>
</form>
</body>
</html>
