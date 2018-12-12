<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Generación de Corte</title>
<link rel="stylesheet" type="text/css" href="../INCLUDES/superEstilos.css" media="screen" />
<script src="../INCLUDES/jquery/jquery-3.1.1.min.js"></script>
<script src="jsGenCorte/GENCORTE.js"></script>
<link rel="stylesheet" href="../INCLUDES/jquery/jquery-ui.css">
  <script src="../INCLUDES/jquery/jquery-1.12.4.js"></script>
  <script src="../INCLUDES/jquery/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#tabs" ).tabs();
  } );
  </script>
</head>
<body>
<form>
  <table WIDTH="100%">
    <tr>
      <td align= "left" WIDTH="35%"><img src="../imagenes/ATRAS.gif"  alt="" style="cursor:hand;"
			onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=3');"></td>
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
              <td width="73%"><input type="text" name="txtnroOFI" id="txtnroOFI" class="ctrlenable">
                <input type="button" name="btnBuscar" id="btnBuscar" value="Ver">&nbsp;&nbsp;<label id="lblCodCli" class="lbl"></label></td>
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
              </table></td>
              </tr>
          </tbody>
        </table></td>
        <td width="50%" >
 <div id="tabs" style="display: none;" >
  <ul>
	  <li><a href="#tabs-1"><span id="tab1">Nunc tincidunt</span></a></li>
  </ul>
  <div id="tabs-1">
    <table width="100%" border="0" id="tbCorte" name="tbCorte">
      <tbody>
        <tr>
          <td class="fondocelda">Corte N#</td>
          <td><input type="text" name="txtCorteN" id="txtCorteN" class="ctrlenable" size="10"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td class="fondocelda">Fecha</td>
          <td><input type="text" name="txtFecha" id="txtFecha" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Peso Paño</td>
          <td><input type="text" name="txtPano" id="txtPano" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Tapeta</td>
          <td><input type="text" name="txtTapeta" id="txtTapeta" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td class="fondocelda">Cons. Estimado</td>
          <td><input type="text" name="txtEstimado" id="txtEstimado" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Pzas x Paño</td>
          <td><input type="text" name="txtPzaPano" id="txtPzaPano" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Retazos</td>
          <td><input type="text" name="txtRetazos" id="txtRetazos" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td class="fondocelda">Cons Real</td>
          <td><input type="text" name="txtReal" id="txtReal" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Paños</td>
          <td><input type="text" name="txtPan" id="txtPan" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Puntas</td>
          <td><input type="text" name="txtPuntas" id="txtPuntas" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td class="fondocelda">Ancho</td>
          <td><input type="text" name="txtAncho" id="txtAncho" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Kg</td>
          <td><input type="text" name="txtKg" id="txtKg" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Fallados</td>
          <td><input type="text" name="txtFalla" id="txtFalla" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td class="fondocelda">Larg Tend</td>
          <td><input type="text" name="txtLarg" id="txtLarg" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Sobrantes</td>
          <td><input type="text" name="txtSobrantes" id="txtSobrantes" class="ctrlenable" size="10"></td>
          <td class="fondocelda">Partida</td>
          <td><input type="text" name="txtPartida" id="txtPartida" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td><p>&nbsp;</p></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td class="fondocelda">Metros</td>
          <td><input type="text" name="txtMetros" id="txtMetros" class="ctrlenable" size="10"></td>
        </tr>
        <tr>
          <td class="fondocelda">Local
            <input type="radio" name="RadioGroup1" value="opción" id="RadioGroup1_0"></td>
          <td class="fondocelda">Servicio
            <input type="radio" name="RadioGroup1" value="opción" id="RadioGroup1_1"></td>
          <td><select name="cboModulo" id="cboModulo" class="combo1" >
          </select></td>
          <td class="fondocelda">Paquete de <input type="text" name="txtPaquete" id="txtPaquete" size="10" class="ctrlenable">Piezas</td>
          <td></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="7"><table width="100%" border="0">
            <tbody>
              <tr>
                <td class="fondosubcelda">#</td>
                <td class="fondosubcelda">Articulo</td>
                <td class="fondosubcelda">Talla</td>
                <td class="fondosubcelda">Cantidad</td>
                <td class="fondosubcelda">Grupos</td>
                <td class="fondosubcelda">Desde</td>
                <td class="fondosubcelda">Hasta</td>
              </tr>
            </tbody>
          </table></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
        	
        </td>
      </tr>
		<tr>
			<td><table align="center" border="0" cellpadding="0" cellspacing="2">
			  <tr>
			    <td><img src="../imagenes/NEW.gif"  alt="REGISTRO EN BLANCO"
			onclick="NUEVO()" style="cursor:hand;" id="NUEVO REGISTRO"  name="NUEVO REGISTRO"/ oncellchange="return NUEVO REGISTRO_oncellchange()"></td>
			    <td><img src="../imagenes/DISK.gif" alt="GRABAR"
			onclick="GRABA()" style="cursor:hand;"/></td>
			    <td><img src="../imagenes/DELETE.gif" alt="ELIMIAR REGISTRO"
			onclick="DELE()" style="cursor:hand;" /></td>
			    <td><img src="../imagenes/SEARCH.gif" alt="BUSCAR" 
	        onclick="document.getElementById('busq').style.display='block';document.getElementById('txtcodcli').focus()" 
	        style="cursor:hand;" />
			      <div id="busq" style="position:absolute; width:230px; z-index:1;display:none;">
			        <table width="81%"  cellpadding="1" cellspacing="0" 
		     bgcolor="WHITE" border="1" bordercolorlight="GAINSBORO" bordercolordark="WHITE" >
			          <tr>
			            <td width="25%"bgcolor='<%=(Application("barra"))%>' ><font face="arial" size="1" color="MidnightBlue"> <b>COLOR: </b></font></td>
			            <td width="75%"  bgcolor="#FFFFFF"><input  name="txtcodcli" type="text" id="txtcodcli" 
	   		      size="15" maxlength="10" tabindex="1" /></td>
		              </tr>
			          <tr >
			            <td colspan="2" align="right" bgcolor="#FFFFFF"><input  type="button" name="btnB" id="btnB" value=" Ir " 
                onclick="javascript:fBuscar(document.getElementById('txtcodcli').value)" 
                title="Buscar" />
			              <a  onclick="javascript:document.getElementById('busq').style.display='none'" 
                style="cursor:pointer; font:Arial; font-size:11px; color:#FF0000"> <u>[X]Cerrar</u></a></td>
		              </tr>
		            </table>
		          </div></td>
		      </tr>
		    </table></td>
			<td>&nbsp;</td>
		</tr>
    </tbody>
  </table>
</form>
</body>
</html>
