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
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
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
</script>
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
	'   response.Write(cAD)
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
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA SERVICIO TALLERES</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body onload="document.all.PRO.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoS.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle"> 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onclick="cierra()" alt="SALIR"/></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr>
                    <td align="center" class="talasblue">SERVICIO TALLERES : <%=rs("numord")%>
                    <input type="text" id="OS" name="OS" value="<%=rs("numord")%>" style="display:block"/>
                    </td>
                </tr>
		    </table> 
         </td>
         <td id="grab" align="center" width="10%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba()" title="GUARDAR" src="imagenes/disk.gif" />
	     </td>
         <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  /></td>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>


<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">DATOS DEL PROVEEDOR : </td></tr>
</table> 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
       bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
   
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%"><p>Proveedor</p></td>
    <td width="10%"><input type="text" id="PRO" name="PRO" value="<%=rs("RUC")%>" class="DATOSKHAKI" onchange="BAKEPRO();CLIENTE()" ondblclick="helpPRO();CLIENTE()" /></td>
    <td colspan="2"><input type="text" id="NOM" name="NOM" value="<%=UCASE(TRIM(rs("PROVEEDOR")))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">R.U.C.</td>
    <td><input type="text" id="RUC" name="RUC" value="<%=rs("RUC")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Direccion</td>
    <td colspan="5"><input type="text" id="DPRO" name="DPRO" value="<%=UCASE(TRIM(rs("DIREC")))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Telf</td>
    <td ><input type="text" id="FAX" name="FAX" value="<%=UCASE(TRIM(rs("AC_CTELEF1")))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">Solicitante  </td>
    <td ><input type="text" id="USR" name="USR" value="<%=trim(ucase(txtUsuario))%> - <%=trim(desUsuario)%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Att. : </td>
    <td  width="25%"><input type="text" id="ATT" name="ATT" value="<%=trim(ucase(rs("ATT")))%>" class="BARRA333" style="width:100%; text-align:left" maxlength="100"/></td>
  </tr>
 </table>
 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">DATOS GENERALES: </td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">F. Ent.</td>
        <td width="1%" align="right" style="PADDING-RIGHT:10PX;"><A href="javascript:showCal('Calendar1')"><img height="16" src="imageNEs/cal.gif" width="16" border=0></A></td>
        <td width="15%"><input type="text" id="ENT" name="ENT"  class="DESCRIPTORES"  value="<%=FORMATDATETIME(RS("FECENT"),2) %>" /></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="15%">Clase </td>
        <td width="23%" colspan="3" class="descriptores">
            <label class="radio-inline">
              <input type="radio" name="cla" id="cla" checked value="2"/>Servicios Externos
            </label>
            <label class="radio-inline">
              <input type="radio" name="cla" id="cla"  value="1"/>Fabrica
            </label>
        </td>
    </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Moneda</td>
    <td colspan="2">
    <select id="MON" name="MON" class="DESCRIPTORES" onchange="CLIENTE();verevere()">
            <option value =""></option>
            <%CAD = "Select TG_CCLAVE, TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='03' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE") %>'><%=RS2("TG_CCLAVE") %> &nbsp;&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
    </td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="15%">T. Cambio</td>
    <td width="10%" ><input type="text" id="TCAM" name="TCAM" value="<%=formatnumber(RS("TIPCAM"),3,,true)%>" class="DESCRIPTORES" style="text-align:center;" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%" >F. Pago</td>
    <td colspan="3"  width="10%"> <select id="FPAG" name="FPAG" class="DESCRIPTORES"  width="10%">
            <option value =""></option>
            <%CAD = "Select TG_CODIGO, left(TG_DESCRI,34) as TG_DESCRI From RSCONCAR..CP0001TAGE Where TG_INDICE='51' Order By TG_DESCRI" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CODIGO") %>'><%=RS2("TG_DESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select></td>
     </tr>
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Entregar en</td>
        <td  colspan="6"><input type="text" id="DIR" name="DIR" value="<%=rs("ENTREGA")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="100"/></td>
    </tr>
    <tr>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >Proceso  </td>
        <td width="11%" colspan="4"> <select id="TOC" name="TOC" class="DESCRIPTORES" onchange="CLIENTE();NUME()">
                <option value =""></option>
                <%CAD = "Select CODIGO, DESCRIPCION From MODELADOR..TIPSERV WHERE ESTADO ='A' ORDER BY DESCRIPCION " 
                RS2.OPEN CAD, CNN
                IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
                DO WHILE NOT RS2.EOF%>
                <option value ='<%=RS2("CODIGO") %>'><%=RS2("CODIGO") %> &nbsp;&nbsp;&nbsp;<%=RS2("DESCRIPCION")%></option>
                    <%RS2.MOVENEXT
                LOOP
                RS2.CLOSE%>
            </select>
        </td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >Cliente  </td>
        <td width="11%" colspan="4"> <select id="CLI" name="CLI" class="DESCRIPTORES" onchange="SELE()" style="background-color:Red" >
                <option value =""></option>
                <%CAD = "Select CODIGO, nombre From MODELADOR..cliente WHERE ESTADO ='A' ORDER BY nombre " 
                RS2.OPEN CAD, CNN
                IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
                DO WHILE NOT RS2.EOF%>
                <option value ='<%=RS2("CODIGO") %>'><%=RS2("nombre")%></option>
                    <%RS2.MOVENEXT
                LOOP
                RS2.CLOSE%>
            </select>
        </td>
    </tr>
 </table>
 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">DETALLE: </td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Temporada</td>
        <td width="40%">
            <select id="TEM" name="TEM" class="DESCRIPTORES" onchange="esti()">
                <option value =""></option>
            </select>
        </td> 
               
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Estilo</td>
        <td  width="40%">
            <select id="EST" name="EST" class="DESCRIPTORES" onchange="pos();" >
                <option value =""></option>
            </select>
        </td>
  </tr>  
  <tr>
       <td align="left" bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >COLORES </td>
       <td width="40%" colspan="1"> <select id="COL" name="COL" class="DESCRIPTORES"  onchange="COLOR()"  >
           <option value =""></option>              
           </select>
        </td>
        <td align="left" bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >CANTIDAD</td>
        <td width="40%" colspan="2"> <input type="text" id="TOTCOL" class="AMERICANnavy1" style="width:100%; text-align:right; padding-right:5px" value='<%=rs("cant")%>' disabled="disabled"/>  
        </td>
   </tr>
   <tr>
     <td colspan="6">   
            <iframe  id="DETACOL"  onload="calcHeight(this.id)" style="display:block;width:100%;" src="" scrolling="no" frameborder="1"></iframe>
      </td>
   </tr>
  
    
</table>




<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">Resumen</td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Fecha Emisi&oacute;n</td>
        <td width="10%"><input type="text" id="FEC" name="FEC" value="<%=left(rs("FECDOC"),10   )%>" class="DESCRIPTORES" disabled="disabled" style="text-align:center"/></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">P:Unit :</td>
        <td width="10%"><input id="PUN" name="PUN" value="<%=formatnumber(rs("PREUNI"),3,,true)%>" onchange="precio()" onfocus="seleccionar(this)"
        style="text-align:right; padding-right:5px;width:100%" class="barra333"/></td>              
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Total Soles :</td>
        <td width="10%"><input id="soles" name="soles" value="<%=formatnumber(rs("impmn"),3,,true)%>" style="text-align:right; padding-right:5px;" class="DESCRIPTORES" disabled="disabled" /></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Total US $ :</td>
        <td width="10%"><input id="dolares" name="dolares" value="<%=formatnumber(rs("impus"),3,,true)%>" style="text-align:right; padding-right:5px;" class="DESCRIPTORES" disabled="disabled"/></td>
    </tr>
    <tr>
       <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Observaciones:</td>
        <td width="90%" colspan="9"><textarea id="GLO" name="GLO" class="estilotextarea4" maxlength="200" ><%=left(rs("glosa"),200)%></textarea></td> 
    
    </tr>
</table>

<script language="javascript" type="text/javascript" src="includes/cal.js"></script>

<script language="jscript" type="text/javascript">
    addCalendar("Calendar1", "Elija una fecha", "ENT", "thisForm")
   
   var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";

    // VEO SI HAY TIPO DE CAMBIO   
    if (trim(trim(document.all.TCAM.value) == '') || parseFloat(document.all.TCAM.value) == 0) {
        alert("Favor solicitar a Contabilidad \nque Ingrese el tipo de Cambio")
        this.window.close()
    }

    document.all.PRO.focus()
    seleccionar(document.all.PRO)

    var subcadena = '<%=RS("CODMON")%>';
    var elemento = document.all.MON;
    document.all.MON.selectedIndex = seleindice(subcadena, elemento);

    var subcadena = '<%=RS("TIPser")%>';
    var elemento = document.all.TOC;
    document.all.TOC.selectedIndex = seleindice(subcadena, elemento);

    var subcadena = '<%=RS("fpag")%>';
    var elemento = thisForm.FPAG;
    thisForm.FPAG.selectedIndex = seleindice(subcadena, elemento);

   
    var subcadena = '<%=RS("cliente")%>';
    var elemento = thisForm.CLI;
    thisForm.CLI.selectedIndex = seleindice(subcadena, elemento);

 // cliente es primero porque si es edicion el CLIENTE NO SE PUEDE CAMBIARRRR
    CLIENTE()


  function CLIENTE() {
        //return true
        if (trim(document.all.PRO.value) != '' && trim(document.all.MON.value) != '' && trim(document.all.TOC.value) != '') {
            document.all.CLI.disabled = false
            document.all.CLI.style.backgroundColor = '#fff'
            document.all.TEM.disabled = false
            document.all.EST.disabled = false
        }
        else {
            document.all.CLI.disabled = true
            document.all.TEM.disabled = true
            document.all.EST.disabled = true
        }
    }



/**********************************************************
 SI ES EDICION, HAY QUE MOSTRAR LOS VALORES GRABADOS
 hay que colocar la funcion del setTimeout porque AHORA
 ya no se ejecuta la pagina de arriba hacia abajo, 
 sino que va ejecutando asincronamente las funciones
 !!!!!!!!!!!!!!!!!!!!!!!! ajjj !!!!!!!!!!!!!!!!!!!!!
**********************************************************/
setTimeout(function(){
    if (trim(document.all.CLI.value) != '') {
        document.all.CLI.disabled = true;
        document.all.CLI.style.backgroundColor = '#fff'
        var select = document.all.TEM
        select.options[0] = new Option(('<%=deste%>'), ('<%=tempo%>'));
        thisForm.TEM.selectedIndex = 0
        document.all.TEM.disabled = true

        var select = document.all.EST
        select.options[0] = new Option(trim('<%=deses%>'), trim('<%=codes%>'));
        thisForm.EST.selectedIndex = 0
        //alert(('<%=deste%>'))
        document.all.EST.disabled = true

        var select = document.all.COL
        select.options[0] = new Option(trim('<%=COLO%>'), trim('<%=colo%>'));
        thisForm.COL.selectedIndex = 0
        document.all.COL.disabled = true;

        COLOR()
        cla = trim('<%=RS("CLASE")%>')

        if (cla == '1') {
            document.all.cla[0].checked = true
            document.all.cla[1].checked = false
        }
        else {
            document.all.cla[0].checked = false
            document.all.cla[1].checked = true
        }
        document.all.MON.disabled = true
    }
}, 50)
    /************************************************/
   

   
    function SELE() {
    /*    document.all.body10.style.display = 'block'
        document.all.body10.height = "350"
        document.all.body10.width = "100%"
        */
        var select = document.all.TEM
        // borra los elementos PRE - existentes
        select.options.length = 0;
        // ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
        select.options[0] = new Option('', '');
        select.selectedIndex = -1
        var select = document.all.EST
        // borra los elementos PRE - existentes
        select.options.length = 0;
        // ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
        select.options[0] = new Option('', '');
     //   limpia()
        cad = 'bake/baketemporadaCliente.asp?cli=' + trim($("#CLI").val())
        document.all.body10.src = cad
    }

    function limpia() {
        //return true
        for (u = 1; u <= 60; u++) {

            eval("$('#lin" + u + "').text('')")
            eval("$('#lin" + u + "').css('display','none')")
            eval("$('#chk" + u + "').val('')")
            eval("$('#ccc" + u + "').css('display','none')")

        }
    }

    function COLOR() {
        //return true

        cad = 'bake/BAKEcli-tem-est-pos-col.asp?cli=' + trim($("#CLI").val())
        cad += '&tem=' + trim($("#TEM").val())
        cad += '&est=' + trim($("#EST").val())
        cad += '&col=' + trim($("#COL").val())
        cad += '&oss=' + trim($("#OS").val())
        document.all.DETACOL.src = cad

    }
    
function precio() {

    if (document.all.MON.value == '') {
        alert("Favor ingresar moneda")
        document.all.MON.focus();
        return false;
    }

    // segundo veo si hay cantidad a procesar
    qty = parseFloat(document.getElementById("TOTCOL").value)
    if (qty == 0)
    {    alert("Favor ingresar cantidad ")
        document.all.TOTCOL.focus();
        return false;
    }

    // tercero valido que el precio sea numerico
    document.getElementById("PUN").value = toInt((document.getElementById("PUN").value))
    pun = document.getElementById("PUN").value

    // tipo de cambio --> siempre hay sinó no lo deja hacer nada
    cam = parseFloat(document.getElementById("TCAM").value)

    if (trim(document.all.MON.value) == 'US') {
        dol = parseFloat(pun) * parseFloat(qty)
        sol = (parseFloat(pun) * parseFloat(cam) )* parseFloat(qty)
    }
    else {
        sol = parseFloat(pun) * parseFloat(qty)
        dol = (parseFloat(pun) / parseFloat(cam)) * parseFloat(qty)
    }

   

  sol = Math.floor(parseFloat(sol) * 1000)
  sol = addCommasz(parseFloat(sol / 1000).toFixed(3))
   
  dol = Math.floor(parseFloat(dol) * 1000)
  dol = addCommasz(parseFloat(dol / 1000).toFixed(3))

    document.getElementById("soles").value   = sol
    document.getElementById("dolares").value = dol


    return true
}

function addCommasz(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}




function BAKEPRO() {
    cad = 'bake/bakeREALpro.asp?pos=' + trim(thisForm.PRO.value)
  
 /*   document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
  */
    document.all.body10.src = cad
}

function helpPRO() {
    cad = 'help/HLPprovREAL.asp?hlp=1'
    window.open(cad, '', opc)
}



function NUME() {// return true
    if (Right(trim(document.all.OS.value), 4) == 'AUTO') {
        oss = Right(trim(document.all.OS.value), 9)
        document.all.OS.value = document.all.TOC.value + '-' + oss
    }
    else
    { document.all.TOC.disabled = true }

}


 
function esti() {
    //return true
    cad = 'bake/baketemporadaestilo.asp?cli=' + trim($("#CLI").val())
    cad += '&tem=' + trim($("#TEM").val())
    cad += '&opc=1'

    document.all.body10.src = cad
    limpia()

}


function pos() {
    //----------------------------------------------------
    // muestra lasPO's de la Temporada, estilo- cliente
    //----------------------------------------------------
    //return true 
    cad = 'bake/BAKEcli-tem-est-col.asp?cli=' + trim($("#CLI").val())
    cad += '&tem=' + trim($("#TEM").val())
    cad += '&est=' + trim($("#EST").val())
    document.all.body10.src = cad
}




function acum(nro) {
// acumula las cantidades de las po's 

    cad = 'bake/BAKEcli-tem-est-pos-col.asp?cli=' + trim($("#CLI").val())
    cad += '&tem=' + trim($("#TEM").val())
    cad += '&est=' + trim($("#EST").val())
    cad += '&oss=' + trim($("#OS").val())
    document.all.DETACOL.src = cad

}


function cambia() {
    //return true
    ttt = 0
    cont = parseInt($("#maxi").val(), 10)
    for (i = 1; i <= cont; i++) {
        ttt += parseInt($("#qt" + i).val(), 10);
    }

    document.all.total.value = ttt
}


function verevere() {
    //return true
    if (parseFloat(document.getElementById("PUN").value) != 0)
        precio()
    return true;

}

function graba() {
 
    
    if (trim(document.all.PRO.value) == '') {
        alert("Antes de continuar, favor de informar el Proveedor");
        document.all.PRO.focus();
        return true;
    }
    if (document.all.MON.value == '') {
        alert("Favor ingresar codigo de moneda")
        document.all.MON.focus();
        return true;
    }
    if (document.all.TOC.value == '') {
        alert("Favor ingresar el tipo de Servicio")
        document.all.TOC.focus();
        return true;
    }  
    if (fecha(document.all.FEC.value) == false) 
    {   alert("Formato de Fecha incorrecto")
        return true;
    }
    if (document.all.PUN.value == '') {
        alert("Favor ingresar Precio")
        document.all.PUN.focus();
        return false;
    }
    if (parseInt(document.all.PUN.value, 10) == 0) {
        alert("Favor ingresar Precio")
        document.all.PUN.focus();
        return false;
    }


    // vemos si hay precio / cantidad
    if (precio() == false)
        return true
    
    // jalamos los valores del iframe

    // # po's del iframe
    maxim = window.frames["DETACOL"].document.getElementById("recs").value;
    aCan = new Array()
    aPos = new Array()
    aUbi = new Array()
    for (m = 0; m < maxim; m++) {
        // qty a procesar
        can = "qt" + m.toString()
        pos = "po" + m.toString()
        ubi = "ub" + m.toString()
        aCan[m] = window.frames["DETACOL"].document.getElementById(can).value;
        aPos[m] = window.frames["DETACOL"].document.getElementById(pos).innerText;
        aUbi[m] = window.frames["DETACOL"].document.getElementById(ubi).innerText;
    }
    kad  = 'comun/inseros.asp?Os=' + trim(document.all.OS.value)
    kad += '&sit=1' 
    kad += '&TOC='  + trim(document.all.TOC.value)
    kad += '&ruc='  + ltrim(document.all.PRO.value)
    kad += '&ATT='  + Left(toAlpha(document.all.ATT.value),100)
    kad += '&CLI=' + ltrim(document.all.CLI.value)
    kad += '&MON=' + ltrim(document.all.MON.value)
    for (g = 0; g < 2; g++) {
        if (document.all.cla[g].checked == true) 
        {            kad += '&cla=' + parseInt(g + 1, 10)        }
    }
    kad += '&CAM=' + ltrim(document.all.TCAM.value)
    kad += '&ubi=' + aUbi
    kad += '&pos=' + aPos
    kad += '&can=' + aCan
    kad += '&FEDO=' + ltrim(document.all.FEC.value) // fecha del documento
    kad += '&FENT=' + ltrim(document.all.ENT.value) // fecha de entrega
    kad += '&FPAG=' + ltrim(document.all.FPAG.value) // forma de pago
    kad += '&PUN=' + ltrim(document.all.PUN.value)
    kad += '&usr='  + '<%=txtUsuario%>'
    kad += '&glo='  + toAlpha(ltrim(document.all.GLO.value)) // glosa
    kad += '&dir=' + ltrim(document.all.DIR.value) // direccion de entrega

    kad += '&dol=' + removecommas(trim(toInt(document.all.dolares.value)))  // IMPORTE US
    kad += '&sol=' + removecommas(trim(toInt(document.all.soles.value)) )   //IMPORTE SOLES 

    document.all.body10.src = kad

   
    
}

function cierra()
{window.opener.location.reload();

window.close()
} 




NUME()
//alert("fin")
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
<script type="text/javascript">
   // cuando se hayan cargado los estilos, los scripts... ejecuta
    $(document).ready(function () {
        // Función a lanzar cada vez que se presiona una tecla en un textarea
        // en el que se encuentra el atributo maxlength
        $("textarea[maxlength]").keyup(function () {
            var limit = $(this).attr("maxlength"); // Límite del textarea
            var value = $(this).val();             // Valor actual del textarea
            var current = value.length;              // Número de caracteres actual
            if (limit < current) {                   // Más del límite de caracteres?
                // Establece el valor del textarea al límite
                $(this).val(value.substring(0, limit));
            }





        });
    });
 </script>
</form>
</body>
</html>