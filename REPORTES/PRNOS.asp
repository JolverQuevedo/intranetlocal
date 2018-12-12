<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/Cnn.inc"-->
<!--include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--<script type="text/jscript" language="jscript">
var aCod = Array() 
function calcHeight(obj)
{
  //find the height of the internal page
  var the_height=
    document.getElementById(obj).contentWindow.
      document.body.scrollHeight+5;
  //change the height of the iframe
  document.getElementById(obj).height=
      the_height;
}
</script>-->
<%	OS = Request.QueryString("OS")
    if trim(OS)= "" then os = "AUTO"

    

	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    rs2.open "select nombres from modelador..usuarios where usuario = '"&txtUsuario&"'", cnn
    rs2.movefirst
    desUsuario = rs2("nombres")
    rs2. close
    cad = "exec SP_SERVI_HEAD '"&oS&"' "  
	   'response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
        gg = "select codest, temporada, destem, estcli from view_pos where po = (select top 1 po from servidet where numord= '"&os&"')"
        rs2.open gg, cnn
       ' response.Write(gg)
        if rs2.recordcount > 0 then
            tempo = rs2("temporada")
            deste = rs2("destem")
            codes = rs2("codest")
            deses = rs2("estcli")
        else
            tempo = ""
            deste = ""
            codes = ""   
            deses = ""     
        end if
        rs2.close
      '  response.write(tempo) 

         COP = "select * FROM MULTI..VIEW_DETA_PO where po = (select top 1 po from servidet where numord= '"&os&"') AND UBI =(select top 1 UBI from servidet where numord= '"&os&"') "
        ' RESPONSE.WRITE(COP)
         RS2.OPEN COP,CNN
         IF RS2.RECORDCOUNT > 0 THEN
             COLO = RS2("COLOR")
             UBIC = RS2("UBI")
         ELSE
            COLO = ""
            UBIC = ""
         END IF
         RS2.CLOSE
    ELSE
        response.write("algo salio mal con el SP")
        RESPONSE.END
	END IF
    MON = RS("CODMON")
    FPA = RS("FPAG")
    TOC = RS("TIPSER")
    KLI = RS("CLIENTE")

    Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.CursorLocation   = 3
	RS3.CursorType       = 3    
	RS3.LockType         = 1 
    kkk = "select * from tipserv where codigo='"&toc&"'"
    rs3.open kkk, cnn
    rs3.movefirst
    DETALLESERVICIO = RS3("DETALLE")

%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA SERVICIO TALLERES</title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<script
  src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/selectivizr/1.0.2/selectivizr-min.js"></script>
  <style>
      *{color:#000 !important ;font-family: sans-serif;font-size:9px}
      .br{
        border-right: 1px inset #000
      }
      .bt{
        border-top: 1px inset #000
      }
      .bb{
        border-bottom: 1px inset #000
      }
      .bl{
        border-left: 1px inset #000
      }
      body{
          width: 680px;
      }
  </style>
</head>
<body >

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle"> 
		  
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table >
		        <tr>
                    <td align="center" class="talasblue">ORDEN DE SERVICIO  <%=rs("numord")%>
                    
                    </td>
                </tr>
		    </table> 
         </td>
         
	     </td>
         
    </tr>
</table>  
<table width="100%">   
	<tr valign="middle">
		<td  style="height:1px;"></td>	
	</tr>
</table>


<table class="br bb bl" cellpadding="2" width="100%" cellspacing="0" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
       <tr>
            <td class="br  bt" style="width: 70px;"   colspan="2">DATOS DEL PROVEEDOR : </td>
            <td style="width:30%"  colspan="4" >&nbsp;</td>
            <td class="br  bl bt"  colspan="1">Fec. Aprob.</td>
            <td class="br  bt"  colspan="1" style="width: 100px">&nbsp;</td>
            <td class="br  bt"  colspan="1">Fec. Impresión</td>
            <td class=" bt"  colspan="1"><%=formatdatetime(rs("FECDOC"),2  )%></td>
        </tr>
  <tr>
    <td class="br bt bb" style="width: 70px"   colspan="1"><p>&nbsp;</p></td>
    
    <td class="br bb bt" colspan="7"><b><%=UCASE(TRIM(rs("PROVEEDOR")))%></b></td>
    <td class="br bb bt" colspan="1"  >R.U.C.</td>
    <td class=" bb bt"  colspan="1"><%=rs("RUC")%></td>
  </tr>
  <tr>
    <td class="br bb" style="width: 70px" colspan="1">Att. :</td>
    <td class=" bb br" colspan="4" style="width:175px"><%=UCASE(TRIM(rs("ATT")))%></td>
    <td class=" bb" colspan="2">DIREC</td>
    <td class="bl bb"colspan="3" ><%=trim(ucase(rs("DIREC")))%></td>
  </tr>
  <tr>
    <td class="br" style="width: 70px"   colspan="1"class="TITULITO">Teléfono</td>
    <td class="br" colspan="1" style="min-width: 70px"><%=UCASE(TRIM(rs("AC_CTELEF1")))%>&nbsp;</td>
    <td class="br" colspan="1">Nextel</td>
    <td class="br" colspan="2" style="min-width: 70px">&nbsp;</td>
    <td class="" colspan="2"  class="TITULITO" >Formulado por  </td>
    <td class="bl" colspan="3" style="font-size:11px"> <%=trim(ucase(txtUsuario))%> - <%=trim(RS("USUARIO"))%></td>
  </tr>
 </table>
 




 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table  class="br bl bt" style="width:160px" >
    <tr><td align="left">DATOS GENERALES: </td></tr>
</table> 
<table   style="border: 1px solid #000;" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
        bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr>
        <td class=" bb"  style="width:175px" colspan="1">Fecha Entrega</td>
       
        <td class="br bb" style="width:175px"  colspan="1"><%=FORMATDATETIME(RS("FECENT"),2) %></td>
        <td class="br bb"  colspan="1">Case de Ord Compra </td>
        <!--SI LA CLASE ES 1 => FABRICA, Y SI ES 2 => SERVICIOS EXTERNOS-->
        <td class=" bb" colspan="4">
            <%
                IF RS("CLASE") = "1" THEN
            %>
                Fabrica
            <%  
                ELSE
            %>
            Servicios Externos
            
            <%
                END IF
            %>
        </td>
    </tr>
    <tr>
        <td colspan="1" class=" bb">Condicion de Pago</td>
        <td colspan="1" class="br bb">

                <%CAD = "Select TG_CODIGO, left(TG_DESCRI,34) as TG_DESCRI From RSCONCAR..CP0001TAGE Where TG_INDICE='51' AND TG_CODIGO= '"&FPA&"' " 
                'response.write(cad)
                RS2.OPEN CAD, CNN
                IF RS2.RECORDCOUNT >0 THEN  
                    RS2.MOVEFIRST %>
                    <%=RS2("TG_DESCRI")%>
                <%ELSE
                    RESPONSE.WRITE("")
                END IF%>
                <%RS2.CLOSE%>

        </td>
        <td colspan="1" class="br bb">Lugar Entrega</td>
        <td colspan="4" class=" bb"><%=UCASE(rs("ENTREGA"))%></td>
    </tr>
    <tr>
            <td class="br" colspan="1" >Proceso  </td>
            <td class="br" colspan="1">
                    <%CAD = "Select CODIGO, DESCRIPCION From MODELADOR..TIPSERV WHERE ESTADO ='A'AND CODIGO = '"&TOC&"' " 
                    RS2.OPEN CAD, CNN
                    IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST%>
                   <%=RS2("DESCRIPCION")%>
                  <%RS2.CLOSE%>
            </td>
            <td class="br" colspan="1">Cliente  </td>
        <td class="" colspan="1"> <%=RS("nombre")%></td>
    </tr>
  
    
 </table>
    <!--*********************************************************-->
    <!--DETALLE-->
    <!--*********************************************************-->
    <%
    

    cad =  " SELECT destem,estcli,color,sum(CANT) as cant " & _                
            " from View_Cliente_Temporada_Estilo_PO_color as dd  " & _  
            " inner  join servidet as ss on ss.po = dd.po        " & _
            " and ss.UBI = dd.ubi                                " & _
            " WHERE CLIENTE = '"&Kli&"'                          " & _
            " and numord = '"&OS&"'                              " & _
            " group by destem,estcli,color                                       " 
        'RESPONSE.WRITE(CAD)
        rs2.open cad, cnn
        rs2.movefirst
    

    %>
    <table class="bt bb bl br" cellpadding="2" cellspacing="0" style="width:100%;margin-top:10px;margin-bottom:10px;">
        <tr style="background:#ddd">
            <td class="br bb">Cantidad</td>
            <td class="br bb">UM</td>
            <td class="br bb">Item</td>
            <td class=" bb" style="text-align:center">Descripcion</td>
            <td class="br bb" style="text-align:right">Cantidad Req.</td>
            <td class="br bb">P.Unit</td>
            <td class="br bb">Dscto.</td>
            <td class="bb">Total</td>
        </tr>
        <tr>
            <td><%=cdbl(rs2("cant"))%></td>
            <td>UND</td>
            <td>1</td>
            <td>
                <b><%=rs("destip")%></b>
                <br/><%=DETALLESERVICIO%>
                <table style="width:100%;text-align:center">
                    <tr>
                        <td style="text-align:left">
                            Estilo
                        </td>
                        <td>
                            Temporada
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:left"><%=rs2("estcli")%></td>
                        <td><%=rs2("destem")%></td>
                    </tr>
                    <tr>
                        <td style="text-align:left">
                            Colores
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="text-align:left"><%=rs2("color")%></td>
                        <td></td>
                    </tr>
                </table>
                
            </td>
            <td style="text-align:right"><%=cdbl(rs2("cant"))%></td>
            <td style="text-align:right"><%=rs("codmon")%>&nbsp;<%=cdbl(rs("preuni"))%></td>
            <td style="text-align:right">
                <!--AGREGAR DESCUENTO SI UBIERA-->
                0.00
            </td>
            <td  style="text-align:right"><%=cdbl(rs2("cant"))*cdbl(rs("preuni"))%></td>
        </tr>
    </table>
    


<br/>
 <div class="bt bb" style="margin-top:10px;margin-bottom:10px;">Observaciones:
    <br>
    <%=rs("glosa")%>
 </div>
<br />
<div style="font-size:10px;font-family:sans-serif;">
    <div style="border:1px inset #333; width: 100%;">
        VoBo GERENCIA OPERACIONES
        <div style="float:right;margin-right: 120px">PCP</div>
    </div>
    <div style="padding:5px 10px">
        <b>COMPROMISOS CON LA EMPRESA, DE LOS PROVEEDORES DE SERVICIO</b>
        El Proveedor al aceptar la carga de trtabajo se compromete a cumplir con lo siguientes:
        <br>
        <ul style="list-style: none">
            <li>- Es de total responsabilidad del proveedor, velar por la mercadería asignada como carga de trabajo ante cualquier escenario adverso y/o siniestro inesperado que sea perjuicio directo para El Modelador S.A.C.</li>
            <li>- Por ningún motivo el proveedor subcontratara el servicio pactado en el presente documento de forma parcial o total, excepto cuando se comunique al Coordinador de Servicios externos, por razones evidentes que compliquen el cumplimiento de lo pactado.</li>
            <li>- Verificar y validar(piezas, prendas, avios, otros) la calidad y peso que les enviamos , según cantidad física vs Guía; en caso de no conformidad deberán presentar su informe vía memorándum y/o Correo de cual indique PO, Estilo, Color, Cantidad, Talla y N° de corte. Los plazos para reclamos de pzas faltantes son 48 horas y para faltarte de avios con 24 horas.</li>
            <li>- El Proveedor del Servicio antes de dar el ingreso de la carga de trabajo esta obligado a presentar su contramuestra y/o 1ra pda a la Jefa de Aseguramiento de la calidad a través de la Auditoría de proceso para su aprobación y o comentarios correspondientes.</li>
            <li>- Elaborar Kardex de Ingresos y salidas de cual indique  "Fecha, N°, Guía, Cliente, Orden de Pedido, Estilo, Color, Talla".</li>
            <li>- El Proveedor del Servicio, tiene conocimiento que la carga de trabajo, se somete a un control de calidad en proceso y auditoría final, por lo tanto esta prohibido entregar mercadería sin los rótulos(po, estilo, cantidad, talla y observaciones) correspondientes, sin los sellos de aprobación de la auditoría. Se entenderáque la mercadería no ha sido auditada, por lo consiguiente no se recogerá la mercadería.</li>
            <li>- No hacer devoluciones y facturaciones de prendas completas e incompletas, una vez pasada las 48 horas de producida la ultima entrega, estos serán facturadas, salvo autorización del coordinador de servicios externos.</li>
            <li>- El proveedor del servicio, al culminar la producción deberá hacer entrega de los prototipos y avios sobrantes, caso contrario serán descontados en su factura.</li>
        </ul>
        <b>GUÍAS</b>
        <ul style="list-style: none">
            <li>- La guía deberá especificar la descripción de la mercadería Y el tipo de servicio realizado.</li>
            <li>- La guía deberá tener la fecha en la que fue entregada la mercadría.</li>
            <li>- La guía debe especificar el color, cantidad, peso.</li>
            <li>- La guía debe especificar la PO, el estilo y la orden de compra.</li>
            <li>- Toda guía deberá estar sellada y firmada en donde se debe indicar el nombre de la persona que la recepciona.</li>
        </ul>
        <b>FACTURAS</b>
        <ul style="list-style: none">
            <li>- Para el pago de sus facturas, deberá adjuntar en ellas copia de la orden de servicio firmada previo a su producción, por ambas empresas.</li>
            <li>- Los pagos de sus facturas son a los 7 días de haberlo presentado.</li>
            <li>- Para el pago especifico de acabado, se considerará en base a lo que se exporta.</li>
        </ul>
    </div>
</div>

<script language="javascript" type="text/javascript">
 

function cierra()
{   window.opener.location.reload();
    window.close()
} 


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>

</body>
</html>

