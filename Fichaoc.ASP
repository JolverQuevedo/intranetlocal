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
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%	oc = Request.QueryString("Oc")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   
    cad = "exec FICHAOC_HEAD '"&oc&"' "  
	  ' response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
    ELSE
        RESPONSE.Write("ERROR AL GRABAR LA CABECERA")
        RESPONSE.Write("<BR>")
        RESPONSE.Write("<BR>")
        RESPONSE.Write("<CENTER>")
        RESPONSE.Write("<A HREF=javascript:window.history.back(0)>REGRESAR</A>")

        RESPONSE.END
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="window.close()" /></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue">FICHA O/C</td></tr>
		    </table> 
         </td>
         <td id="grab" align="center" width="10%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="imagenes/disk.gif" />
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
    <tr><td align="left" class="AMERICANnavy">DATOS GENERALES : </td></tr>
</table> 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Orden de Compra</td>
        <td width="10%"><input type="text" id="OC" name="OC" value="<%=rs("oc_cnumord")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
        <td colspan="2">&nbsp;</td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Fecha</td>
        <td width="10%"><input type="text" id="FEC" name="FEC" value="<%=left(rs("oc_dfecdoc"),10   )%>" class="DESCRIPTORES" readonly tabindex="-1" style="text-align:center"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%"><p>Proveedor</p></td>
    <td width="12%"><input type="text" id="PRO" name="PRO" value="<%=rs("oc_cCODPRO")%>" class="DATOSKHAKI" onchange="BAKEPRO()" ondblclick="helpPRO()" /></td>
    <td colspan="2">&nbsp;</td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">R.U.C.</td>
    <td width="23%"><input type="text" id="RUC" name="RUC" value="<%=rs("AC_CRUC")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Razon Social</td>
    <td colspan="3"><input type="text" id="NOM" name="NOM" value="<%=UCASE(TRIM(rs("OC_CRAZSOC")))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">Fax</td>
    <td width="23%"><input type="text" id="FAX" name="FAX" value="<%=rs("AC_CFAXACR")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Direccion Prov.</td>
    <td colspan="3"><input type="text" id="DPRO" name="DPRO" value="<%=UCASE(TRIM(rs("AC_CDIRECC")))%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">T.Despacho</td>
    <td width="23%"><select id="DESP" name="DESP" class="DESCRIPTORES">
    <option value =""></option>
    <option value ="XSO">XSO Reposicion Stock</option>
    <option value ="XMD">XMD Machine down</option>
    </select></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Doc. Referencia</td>
    <td colspan="2">
        <select id="DOCR" name="DOCR" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select TG_CCLAVE, TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='04' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE") %>'><%=RS2("TG_CCLAVE") %> &nbsp;&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
    </td>
    <td><input type="text" id="DOC1" name="DOC1" value="<%=RS("oc_CCOTIZA")%>" class="BARRA333"  style="width:100%; text-align:left" /></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">Doc. Ref. 2</td>
    <td width="23%"><input type="text" id="DOC2" name="DOC2" value="<%=RS("OC_CNUMREF")%>" class="BARRA333"  style="width:100%; text-align:left;"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Moneda</td>
    <td colspan="2">
    <select id="MON" name="MON" class="DESCRIPTORES">
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
    
    </td> <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="23%">&nbsp; </td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >Tipo O/C</td>
    <td width="11%"> <select id="TOC" name="TOC" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select TG_CCLAVE, TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='63' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE") %>'><%=RS2("TG_CCLAVE") %> &nbsp;&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select></td>
   
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Forma de pago</td>
    <td colspan="3"> <select id="FPAG" name="FPAG" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select TG_CODIGO, left(TG_DESCRI,34) as TG_DESCRI From RSCONCAR..CP0001TAGE Where TG_INDICE='51' Order By TG_DESCRI" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_DESCRI") %>'><%=RS2("TG_DESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">T. Cambio</td>
    <td width="23%"><input type="text" id="TCAM" name="TCAM" value="<%=formatnumber(RS("OC_NTIPCAM"),3,,true)%>" class="DESCRIPTORES" style="text-align:center;" readonly tabindex="-1"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="10%">Fecha de Entrega</td>
    <td width="12%"><input type="text" id="ENT" name="ENT" value="<%=LEFT(RS("oc_dfecent"),10)%>" class="BARRA333" style="width:100%"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >% Dcto Financiero</td>
    <td><input type="text" id="FIN" name="FIN" value="" class="BARRA333" style="width:100%"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="11%">Pais:</td>
    <td width="23%"><select id="PAI" name="PAI" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select RTrim(Left(TG_CDESCRI, 40)) as Cad,* From RSFACCAR..AL0001TABL Where TG_CCOD='27' Order by RTrim(Left(TG_CDESCRI, 40))" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE") %>'><%=RS2("TG_CCLAVE") %> &nbsp;&nbsp;&nbsp;<%=RS2("CAD")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select></td>
  </tr> 
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Solicitante</td>
        <td  colspan="1"><input type="text" id="CSOL" name="CSOL" value="<%=rs("OC_CCODSOL")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="50"/></td>
         <td  colspan="1"><input type="text" id="SOLI" name="SOLI" value="<%=rs("oc_cSOLICT")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="50"/></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  >
        <input id="CHK" name="CKH" type="checkbox" value="<%=rs("OC_CUNIORD")%>" />&nbsp;
        Bloquear para Ingreso</td>

  </tr>
  <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Centro de Costo</td>
        <td colspan="3"><select id="CCTO" name="CCTO" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Tipo de Envio</td>
    <td colspan="3"><input type="text" id="TENV" name="TENV" value="<%=rs("oc_cTIPENV")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Almac&eacute;n de Entrega</td>
    <td colspan="3"><select id="ALM" name="ALM" class="DESCRIPTORES">
        <option value =""></option>
        <%CAD = "Select * From RSFACCAR..AL0001ALMA Order by A1_CALMA" 
        RS2.OPEN CAD, CNN
        IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
        DO WHILE NOT RS2.EOF%>
        <option value ='<%=RS2("A1_CALMA")%>'><%=RS2("A1_CALMA")%>&nbsp;&nbsp;<%=RS2("A1_CDESCRI")%></option>
            <%RS2.MOVENEXT
        LOOP
        RS2.CLOSE%>
    </select></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Lugar de Entrega</td>
    <td colspan="3"><input type="text" id="LENT" name="LENT" value="<%=rs("OC_CLUGENT")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Distrito</td>
    <td ><input type="text" id="DIS" name="DIS" value="<%=rs("OC_CDISTOC")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" style="text-align:right;">Provincia &nbsp; &nbsp;</td>
    <td ><input type="text" id="PRV" name="PRV" value="<%=rs("OC_CPROVOC")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Lugar de Factura</td>
    <td colspan="3"><input type="text" id="LFAC" name="LFAC" value="<%=rs("OC_CLUGFAC")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Observaciones</td>
    <td colspan="3" ><input type="text" id="OBS" name="OBS" value="<%=rs("OC_CDETENT")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%" >Remitente</td>
    <td ><input type="text" id="TEMI" name="REMI" value="<%=rs("OC_CREMITE")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%" style="text-align:right;">Persona de Atenci&oacute;n&nbsp; &nbsp;</td>
    <td ><input type="text" id="ATEN" name="ATEN" value="<%=rs("OC_CPERATE")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
     <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Contactos</td>
     <td width="30%"><input type="text" id="CON1" name="CON1" value="<%=rs("OC_CCONTA1")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="25"/></td>
     <td width="30%"><input type="text" id="CON2" name="CON2" value="<%=rs("OC_CCONTA2")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="25"/></td>
     <td width="30%"><input type="text" id="CON3" name="CON3" value="<%=rs("OC_CCONTA3")%>" class="BARRA333" style="width:100%; text-align:left" maxlength="25"/></td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">Responsables (Personas/Cargos)</td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">

<tr valign="top">
     <td width="33%"><select id="PE1" name="PE1" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='80' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="34%"><select id="PE2" name="PE2" class="DESCRIPTORES">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select>
     </td>
     <td width="33%"><select id="PE3" name="PE3" class="DESCRIPTORES">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            rs2.close%>
        </select>
     </td>
</tr>
<tr valign="top">     
     <td width="33%"><select id="RE1" name="RE1" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='A6' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="34%"><select id="RE2" name="RE2" class="DESCRIPTORES">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="33%"><select id="RE3" name="RE3" class="DESCRIPTORES">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">Orden de Giro de Anticipo </td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">

<tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="25%">Fecha Limite Pago</td>
    <td width="25%"><input type="text" id="ttx" name="ttx" value="  /  /    " class="BARRA333" style="width:100%; text-align:left" /></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="25%">Estado</td>
    <td width="25%"><input type="text" id="ppp" name="ppp" value="P PENDIENTE" class="BARRA333" style="width:100%; text-align:left;" disabled /></td>
</tr>
<tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="25%">Importe</td>
    <td width="25%"><input type="text" id="Text1" name="ttx" value="  " class="BARRA333" style="width:100%; text-align:left" /></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="25%">Glosa</td>
    <td width="25%"><input type="text" id="Text2" name="ppp" value="" class="BARRA333" style="width:100%; text-align:left;" disabled /></td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">Resumen</td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Total Soles :</td>
        <td width="10%"><input id="soles" name="soles" value="<%=formatnumber(rs("oc_nimpmn"),3,,true)%>" style="text-align:right; padding-right:5px;" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO"  width="10%">Total US $ :</td>
        <td width="10%"><input id="dolares" name="dolares" value="<%=formatnumber(rs("oc_nimpus"),3,,true)%>" style="text-align:right; padding-right:5px;" class="DESCRIPTORES" readonly tabindex="-1"/></td>
    </tr>
</table>
<!-------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------!-->
<script type="text/jscript" language="jscript">
//**********************************************************************************************
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";


var subcadena ='<%=RS("OC_CTIPDSP")%>' ;
var elemento = document.all.DESP ;
document.all.DESP.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("OC_CTIPDOC")%>' ;
var elemento = document.all.DOCR ;
document.all.DOCR.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("OC_CCODMON")%>' ;
var elemento = document.all.MON ;
document.all.MON.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("OC_CTIPORD")%>' ;
var elemento = document.all.TOC ;
document.all.TOC.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=TRIM(RS("OC_CFORPA1"))%>' ;
var elemento = document.all.FPAG ;
document.all.FPAG.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("OC_CCOPAIS")%>' ;
var elemento = document.all.PAI ;
document.all.PAI.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("OC_CCOSTOC")%>' ;
var elemento = document.all.CCTO ;
document.all.CCTO.selectedIndex = seleindice(subcadena,elemento);

var subcadena ='<%=RS("OC_CALMDES")%>' ;
var elemento = document.all.ALM ;
document.all.ALM.selectedIndex = seleindice(subcadena,elemento);

var subcadena = '<%=RS("OC_CRESPER1")%>';
var elemento = document.all.PE1;
document.all.PE1.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("OC_CRESPER2")%>';
var elemento = document.all.PE2;
document.all.PE2.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("OC_CRESPER3")%>';
var elemento = document.all.PE3;
document.all.PE3.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("OC_CRESCARG1")%>';
var elemento = document.all.RE1;
document.all.RE1.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("OC_CRESCARG2")%>';
var elemento = document.all.RE2;
document.all.RE2.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("OC_CRESCARG3")%>';
var elemento = document.all.RE3;
document.all.RE3.selectedIndex = seleindice(subcadena, elemento);

CkK = '<%=rs("OC_CUNIORD")%>'
if (trim(CkK) == '1') 
{    document.all.CHK.checked = true
     document.all.CHK.value = '1'
 }
 

function BAKEPRO() {
    cad = 'bake/bakeREALpro.asp?pos=' + trim(thisForm.PRO.value)
/*  
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
  */ 
document.all.body10.src = cad
}

function helpPRO() {   
cad = 'help/HLPprovREAL.asp?hlp=1'
window.open(cad,'',opc)
}

function graba() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
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
        alert("Favor ingresar el tipo de Orden de compra")
        document.all.TOC.focus();
        return true;
    }
    if (document.all.ALM.value == '') {
        alert("Favor ingresar el ALMACEN de entrega")
        document.all.ALM.focus();
        return true;
    }
    if (fecha(document.all.FEC.value) == false) 
    {   alert("Formato de Fecha incorrecto")
        return true;
    }




    kad  = 'comun/insercaboc.asp?OC=' + trim(document.all.OC.value)
    kad += '&sit=1' 
    kad += '&pro=' + trim(document.all.PRO.value)
    kad += '&raz=' + ltrim(document.all.NOM.value)
    kad += '&dir=' + toAlpha(document.all.DPRO.value)
    kad += '&COT=' + ltrim(document.all.DOC1.value)
    kad += '&FEDO=' + ltrim(document.all.FEC.value)
    kad += '&FPAG=' + ltrim(document.all.FPAG.value)
    kad += '&MON=' + ltrim(document.all.MON.value)
    kad += '&CAM=' + ltrim(document.all.TCAM.value)
    kad += '&ENT=' + ltrim(document.all.ENT.value)
    kad += '&KOS=' + ltrim(document.all.CSOL.value)
    kad += '&SOL=' + ltrim(document.all.SOLI.value)
    kad += '&LUG=' + ltrim(document.all.LENT.value)
    kad += '&LFA=' + ltrim(document.all.LFAC.value)
    kad += '&OBS=' + ltrim(document.all.OBS.value)
    kad += '&TIP=' + ltrim(document.all.TENV.value)
    kad += '&USR=' + '<%=txtUsuario%>'
    kad += '&TOC=' + ltrim(document.all.TOC.value)
    // FECHA ACTUALIZA
    // HORA ACTUALIZA
    kad += '&mus=' + trim(toInt(document.all.dolares.value))  // IMPORTE US
    kad += '&mmn=' + trim(toInt(document.all.soles.value))    //IMPORTE SOLES 
    kad += '&PE1=' + ltrim(document.all.PE1.value)
    kad += '&PE2=' + ltrim(document.all.PE2.value)
    kad += '&PE3=' + ltrim(document.all.PE3.value)
    kad += '&RE1=' + ltrim(document.all.RE1.value)
    kad += '&RE2=' + ltrim(document.all.RE2.value)
    kad += '&RE3=' + ltrim(document.all.RE3.value)
    kad += '&PAI=' + ltrim(document.all.PAI.value)
    kad += '&REMI=' + ltrim(document.all.REMI.value)
    kad += '&ATE=' + ltrim(document.all.ATEN.value)
    kad += '&CN1=' + ltrim(document.all.CON1.value)
    kad += '&CN2=' + ltrim(document.all.CON2.value)
    kad += '&CN3=' + ltrim(document.all.CON3.value)
    kad += '&CHK=' + ltrim(document.all.CHK.value)
    kad += '&DOCR=' + ltrim(document.all.DOCR.value)
    kad += '&DESP=' + ltrim(document.all.DESP.value)
    kad += '&DOC2=' + ltrim(document.all.DOC2.value)
    kad += '&ALM=' + ltrim(document.all.ALM.value)
    kad += '&DIS=' + ltrim(document.all.DIS.value)
    kad += '&PRV=' + ltrim(document.all.PRV.value)
    kad += '&CCTO=' + ltrim(document.all.CCTO.value)
    // NO HAY DOCPAG
    // NO HAY FECPAG -- NULL
    // NO HAY FECVEN -- NULL
    // NO HAY ESTPAG
    // NO HAY MONPAG
    // NO HAY IMPPAG --0
    // NO HAY GLOPAG

     
    /*document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = kad

    //alert(kad)
    cad = 'FICHAOCdeta.asp?OC=' + trim(thisForm.OC.value)
window.open(cad,'Deta_OC', opc)
    
}
window.onbeforeunload = confirmExit;

function confirmExit() {

    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    kad = 'comun/recalculaoc.asp?OC=' + trim(document.all.OC.value)
    document.all.body10.src = kad
  // hay que hacer reload al grid que la abrio
    //   parent.top.window.opener.window.location.replace('../FICHAOCdeta.ASP?OC=' + '<%=OC%>')



}
window.onunload = refreshParent;
function refreshParent() {
    window.opener.window.location.reload();
}


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>