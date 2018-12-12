<%@ Language=VBScript%>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
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

<%'=request.QueryString()%>

<%	oc = Request.QueryString("Oc")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
SER = request.QueryString("ser")  
ALM = request.QueryString("des")  
AL2 = request.QueryString("al2")  
cod = request.QueryString("cod")
can = request.QueryString("can")
OFI = request.QueryString("OFI")
LT2 = request.QueryString("LT2")
LT1 = request.QueryString("LT1")
CLA = request.QueryString("CLA")
cia = "0001"
if ucase(ltrim(rtrim(oc))) = "AUTO" then 
    
    cad = 	" SELECT	'AUTO' AS OC_CNUMORD, '' AS OC_CCODPRO, '' AS OC_CRAZSOC,                   " & _	
			" 'TNT_PCP' AS OC_CCOTIZA, 'US' AS OC_CCODMON, '' AS OC_CFORPA1,'' AS OC_CFORPA2,       " & _
			" '' AS OC_CFORPA3, replace((Select top 1 XMEIMP2 From                                  " & _
			" RSCONCAR..CTCAMB Where XCODMON='US' order by xdate desc),',','.')                     " & _
            " AS OC_NTIPCAM, getdate() AS OC_DFECENT, 0 AS OC_NPORDES,  '' AS AC_CUSER,             " & _
            " '' AS OC_CDIRPRO, '' AS OC_CCARDES, 0 AS OC_NIMPUS,  0 AS OC_NIMPMN,	                " & _
            " 'AUTOMATICO PCP' AS OC_CSOLICT, '' AS OC_CTIPENV, '' AS OC_CLUGENT, '' AS OC_CLUGFAC,	" & _
            " '' AS OC_CDETENT, '1' AS OC_CSITORD, getdate() AS OC_DFECACT, '' AS OC_CHORA,         " & _
            " '' AS OC_CUSUARI, getdate() AS OC_DFECDOC, '' AS OC_CTIPORD, '' AS OC_CREMITE,        " & _
            " '' AS OC_CRESPER1,'' AS OC_CRESPER2,  getdate() AS OC_DFECR03, '' AS AC_CCTAUS,       " & _
			" '' AS OC_CRESPER3,'' AS OC_CRESCARG1,'' AS OC_CRESCARG2,'' AS OC_CRESCARG3,           " & _
			" '' AS OC_CCOPAIS, '' AS OC_CUSEA01, '' AS OC_CUSEA02, '' AS OC_CUSEA03,               " & _
			" getdate() AS OC_DFECR01, getdate() AS OC_DFECR02, '' AS OC_CDIAENT,                   " & _
			" '' AS OC_CPERATE, '' AS OC_CCONTA1, '' AS OC_CCONTA2, '' AS OC_CCONTA3,               " & _
			" '' AS OC_CNUMFAC, getdate() AS OC_DFECEMB, '1' AS OC_CUNIORD,'' AS OC_CCONVTA,        " & _
			" '' AS OC_CCONEMB, '' AS OC_CCONDIC, '' AS OC_CTIPENT, '' AS OC_CMONPAG,               " & _
			" 0 AS OC_NFLEINT, 0 AS OC_NDOCCHA, 0 AS OC_NFLETE, 0 AS OC_NSEGURO,                    " & _
			" 0 AS OC_NIMPFAC, 0 AS OC_NIMPFOB, 0 AS OC_NIMPCF, 0 AS OC_NIMPCIF,                    " & _
			" '' AS OC_CNUMREF, '' AS OC_CTIPDSP, 'OP' AS OC_CTIPDOC,	'"&ALM&"' AS OC_CALMDES,    " & _
			" '' AS OC_CDISTOC, '' AS OC_CPROVOC, '' AS OC_CCOSTOC,	'' AS OC_CDOCPAG,               " & _
			" getdate() AS OC_DFECPAG, getdate() AS OC_DFECVEN, '' AS OC_CESTPAG,	                " & _
			" 0 AS OC_NIMPPAG, '' AS OC_CGLOPAG, 'PCP_TNT' AS OC_CCODSOL, '' AS AC_CMAXPAG,         " & _
			" '' AS AC_CVANEXO, '' AS AC_CCODIGO, '' AS AC_CNOMBRE, '' AS AC_CDIRECC,               " & _
			" '' AS AC_CLOCALI, '' AS AC_CPAISAC, '' AS AC_CTELEF1, '' AS AC_CTELEF2,               " & _
			" '' AS AC_CTELEF3, '' AS AC_CFAXACR, '' AS AC_CTIPOAC, '' AS AC_CGIROAC,               " & _
			" '' AS AC_CREPRES, '' AS AC_CCARREP, '' AS AC_CTELREP,                                 " & _
			" getdate() AS AC_DFECMOD, '' AS AC_CESTADO,	'' AS AC_CABREVI,                       " & _
			" '' AS AC_CRUC,    '' AS AC_CTIPPAG, '' AS AC_CCTAMN,'' AS AC_CCTAMNC,	                " & _
			" '' AS AC_CCODPOS, '' AS AC_CFORPAG, '' AS AC_CCODSUP,'' AS AC_CCTAUS7,	            " & _
			" '' AS AC_CCTAUSC, '' AS AC_CTIPCTA, '' AS AC_CSUCURS,'' AS AC_CTIPPRO,	            " & _
			" '' AS AC_CTASDET, '' AS AC_CTASPER, '' AS AC_CEMAIL, getdate() AS AC_DFECCRE, 	    " & _ 
			" '' AS AC_CCTAMN7, '' AS AC_CTIPDOI, '' AS AC_CNUMDOI,	                                " & _
			" '' AS AC_CCTAUST, '' AS AC_CCTAMNT, '' AS AV_CPATER,	'' AS AV_CMATERN,               " & _
			" '' AS AV_CNOMBRE, '' AS AV_CFORMSU, '' AS AV_CTIPTRA,	'' AS AC_CCTAMNB,               " & _
			" '' AS AC_CCTAUSB, 0 AS AC_NMESNOR, 0 AS AC_NMESURG,	0 AS AC_NDIANOR,                " & _
			" 0 AS AC_NDIAURG, '' AS AV_CTIPRO2, '' AS AV_CDOCIDE,	'' AS AV_CNUMIDE,               " & _
			" '' AS AC_CFORPA1, '' AS AC_CCTAMNK, '' AS AC_CCTAUSK,	'' AS AC_CTIPPRK,               " & _
			" '' AS AC_CTIPABK, '' AS AC_CCODOFK, '' AS AC_CTIPPA2,	'' AS AC_CNUMTRA,               " & _
			" '' AS AC_CCODBC2, '' AS AC_CNUMCT2, '' AS AC_CNUMUS2,	'' AS AC_CTIPCT2,               " & _
			" '' AS AC_DFNACI,  '' AS AC_CSEXO,   '' AS AC_CNACIO,	'' AS AC_CESSAL,                " & _
			" '' AS AC_CDOMIC,  '' AS AC_CTIPVIA, '' AS AC_CNVVIA,	'' AS AC_CNUMER,                " & _
			" '' AS AC_CINTER,  '' AS AC_CTZONA,  '' AS AC_CNZONA,	'' AS AC_CREFER,                " & _
			" '' AS AC_CUBIGU,  '' AS AC_CSITUA,  '' AS AC_CRETE,		0 AS AC_NPORRE,             " & _
			" '' AS AC_CCOPAIS, '' AS AC_CTICONV, '' AS AC_CCTADET,	'' AS AC_CFLUPRO,               " & _
			" '' AS AC_CVALRUT, '' AS AC_COBSERV, '' AS AC_CFORPG7,	'' AS AC_CTIPCT7,               " & _
			" '' AS AC_CCODCI7, '' AS AC_CCTAITB, '' AS AC_CTIPOPG,	'' AS AC_CGRUACR,               " & _
			" '' AS AC_CSISTEL, '' AS AC_CCTAITI                                                    " 
ELSE
    tbl1 = "RSFACCAR..CO"+ cia +"MOVC"
    tbl2 = "RSCONCAR..CP"+ cia +"MAES"
    cad =   " Select * From "&tbl1&" LEFT OUTER JOIN "&tbl2&" on AC_CVANEXO='P' " & _
            " AND AC_CCODIGO=OC_CCODPRO Where OC_CNUMORD='"&oc&"' ;             "
end if

	'   response.Write(cAD)
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>O/C Automatica</title>

</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center" >          
         <td class="tituloMODELADOR" width="60%">ORDEN DE COMPRA</td>
         <td id="grab" align="center" width="1%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="imagenes/rsv.png" /></td>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" style="background-color:#dbe3cd">   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">DATOS GENERALES : </td></tr>
</table> 
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="2" width="100%" cellspacing="2"  >
    <tr valign="top">
        <td  class="TEXTO6"  width="10%">O/C #</td>
        <td width="10%"><input type="text" id="OC" name="OC" value="<%=rs("oc_cnumord")%>" class="DATOS" readonly tabindex="-1"/></td>
       <td  class="TEXTO6" width="11%">T. Cambio</td>
    <td width="23%"><input type="text" id="TCAM" name="TCAM" value="<%=formatnumber(RS("OC_NTIPCAM"),3,,true)%>" class="textonavyreadonly" style="text-align:center;" readonly tabindex="-1"/></td>
        <td class="TEXTO6"  width="10%">Fecha</td>
        <td width="10%"><input type="text" id="FEC" name="FEC" value="<%=left(rs("oc_dfecdoc"),10   )%>" class="TEXTO" readonly tabindex="-1" style="text-align:center"/></td>
  </tr>
  <tr>
    <td  class="TEXTO6" width="10%"><p>Proveedor</p></td>
    <td width="12%"><input type="text" id="PRO" name="PRO" value="<%=rs("oc_cCODPRO")%>" class="DATOSkhaki" onChange="BAKEPRO()" onDblClick="helpPRO()" /></td>
    <td  class="TEXTO6" width="11%">R.U.C.</td>
    <td width="23%"><input type="text" id="RUC" name="RUC" value="<%=rs("AC_CRUC")%>" class="TEXTONAVYREADONLY" readonly tabindex="-1"/></td>
    <td colspan="1" CLASS="TEXTO6">Fax</td>
    <td colspan="1"> <input type="text" id="FAX" name="FAX" value="<%=rs("AC_CFAXACR")%>" class="TEXTONAVYREADONLY" style="display:block"/></td>
    
  </tr>
  <tr>
    <td  class="TEXTO6" width="10%">Empresa</td>
    <td colspan="3"><input type="text" id="NOM" name="NOM" value="<%=UCASE(TRIM(rs("OC_CRAZSOC")))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1"/></td>
   <td  class="TEXTO6"  width="10%">Alm_Entrega</td>
    <td colspan="1"><select id="ALM" name="ALM" class="DATOS">
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
  <tr>
    <td  class="TEXTO6" width="10%">Direccion</td>
    <td colspan="3"><input type="text" id="DPRO" name="DPRO" value="<%=UCASE(TRIM(rs("AC_CDIRECC")))%>" class="TEXTONAVYREADONLY" readonly tabindex="-1"/></td>
    <td  class="TEXTO6" width="11%">T.Despacho</td>
    <td width="23%"><select id="DESP" name="DESP" class="DATOS">
    <option value =""></option>
    <option value ="XSO">XSO Reposicion Stock</option>
    <option value ="XMD">XMD Machine down</option>
    </select></td>
  </tr>
  <tr>
    <td  class="TEXTO6" width="10%">Doc. Ref.</td>
    <td colspan="2" WIDTH="20%">
        <select id="DOCR" name="DOCR" class="DATOS">
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
    <td><input type="text" id="DOC1" name="DOC1" value="<%=RS("oc_CCOTIZA")%>" class="textonavyreadonly"  style="width:100%; text-align:left" /></td>
    <td  class="TEXTO6" width="11%">Doc. Ref. 2</td>
    <td width="23%"><input type="text" id="DOC2" name="DOC2" value="<%=RS("OC_CNUMREF")%>" class="DATOS"  style="width:100%; text-align:left;"/></td>
  </tr>
  <tr>
    <td  class="TEXTO6" width="10%">Moneda</td>
    <td colspan="1">
    <select id="MON" name="MON" class="DATOS">
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
   <td  class="TEXTO6" width="10%">Tipo pago</td>
    <td colspan="1"> <select id="FPAG" name="FPAG" class="DATOS">
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
    <td  class="TEXTO6" >Tipo O/C</td>
    <td width="11%"> <select id="TOC" name="TOC" class="DATOS">
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
  </tr>
  <tr>
    <td  class="TEXTO6" width="10%">Fecha_Entrega</td>
    <td width="12%"><input type="text" id="ENT" name="ENT" value="<%=LEFT(RS("oc_dfecent"),10)%>" class="datos" style="width:100%"/></td>
    <td  class="TEXTO6" >% Dcto Financiero</td>
    <td><input type="text" id="FIN" name="FIN" value="" class="datos" style="width:100%"/></td>
     <td  class="TEXTO6"  width="10%">Cen_Cto</td>
        <td><select id="CCTO" name="CCTO" class="DATOS">
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
    <select id="PAI" name="PAI" class="datos" style="display:none">
            <option value =""></option>
            <%CAD = "Select RTrim(Left(TG_CDESCRI, 40)) as Cad,* From RSFACCAR..AL0001TABL Where TG_CCOD='27' Order by RTrim(Left(TG_CDESCRI, 40))" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE") %>'><%=RS2("TG_CCLAVE") %> &nbsp;&nbsp;&nbsp;<%=RS2("CAD")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
  </tr> 
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>

<table border="1" cellpadding="2" width="100%" cellspacing="1" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("color2"))%>" 
bordercolorlight="<%=(Application("COLOR2"))%>" style="display:none" >
    <tr valign="top">
        <td  class="TEXTO6"  width="10%">Solicitante</td>
        <td  colspan="1"><input type="text" id="CSOL" name="CSOL" value="<%=rs("OC_CCODSOL")%>" class="textonavyreadonly" style="width:100%; text-align:left" maxlength="50"/></td>
        <td  colspan="1"><input type="text" id="SOLI" name="SOLI" value="<%=rs("oc_cSOLICT")%>" class="TEXTONAVYREADONLY" style="width:100%; text-align:left" maxlength="50"/></td>
        <td  class="TEXTO6"><input id="CHK" name="CKH" type="checkbox" value="<%=rs("OC_CUNIORD")%>"  disabled/>&nbsp;Bloquear para Ingreso</td>
  </tr>
  <tr valign="top">
       

    <td  class="TEXTO6"  width="10%" align="right">Tipo de Envio</td>
    <td ><input type="text" id="TENV" name="TENV" value="<%=rs("oc_cTIPENV")%>" class="INPUTS" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    
    <td CLASS="texto6" colspan="2"></td>
</tr>
<tr valign="top">
    <td  class="TEXTO6"  width="10%">Lugar_Entrega</td>
    <td colspan="3"><input type="text" id="LENT" name="LENT" value="<%=rs("OC_CLUGENT")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td  class="TEXTO6"  width="10%">Distrito</td>
    <td ><input type="text" id="DIS" name="DIS" value="<%=rs("OC_CDISTOC")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
    <td  class="TEXTO6" style="text-align:right;">Provincia &nbsp; &nbsp;</td>
    <td ><input type="text" id="PRV" name="PRV" value="<%=rs("OC_CPROVOC")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td  class="TEXTO6"  width="10%">Lugar_Factura</td>
    <td colspan="3"><input type="text" id="LFAC" name="LFAC" value="<%=rs("OC_CLUGFAC")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td  class="TEXTO6"  width="10%">Observaciones</td>
    <td colspan="3" ><input type="text" id="OBS" name="OBS" value="<%=rs("OC_CDETENT")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
    <td  class="TEXTO6"  width="10%" >Remitente</td>
    <td ><input type="text" id="TEMI" name="REMI" value="<%=rs("OC_CREMITE")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
    <td  class="TEXTO6"  width="10%" style="text-align:right;">Persona de Atenci&oacute;n&nbsp; &nbsp;</td>
    <td ><input type="text" id="ATEN" name="ATEN" value="<%=rs("OC_CPERATE")%>" class="inputs" style="width:100%; text-align:left" maxlength="80"/></td>
</tr>
<tr valign="top">
     <td  class="TEXTO6"  width="10%">Contactos</td>
     <td width="30%"><input type="text" id="CON1" name="CON1" value="<%=rs("OC_CCONTA1")%>" class="inputs" /></td>
     <td width="30%"><input type="text" id="CON2" name="CON2" value="<%=rs("OC_CCONTA2")%>" class="inputs" /></td>
     <td width="30%"><input type="text" id="CON3" name="CON3" value="<%=rs("OC_CCONTA3")%>" class="inputs" /></td>
</tr>
</table>
<table cellpadding="5" cellspacing="0" border="1" style="display:none" align="center" width="100%">
    <tr><td align="left" class="estilo4">RESPONSABLES (Personas/Cargos)</td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="0" style="display:none">

<tr valign="top">
     <td width="33%"><select id="PE1" name="PE1" class="data2">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='80' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="34%"><select id="PE2" name="PE2" class="data2">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select>
     </td>
     <td width="33%"><select id="PE3" name="PE3" class="data2">
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
     <td width="33%"><select id="RE1" name="RE1" class="data2">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='A6' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="34%"><select id="RE2" name="RE2" class="data2">
            <option value =""></option>
            <%IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP%>
        </select></td>
     <td width="33%"><select id="RE3" name="RE3" class="data2">
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
<table cellpadding="5" cellspacing="0" border="1" width="100%" align="center"  style="display:none">
    <tr><td align="left" class="ESTILO4">Orden de Giro de Anticipo </td></tr>
</table> 
<table border="0" cellpadding="2" width="100%" cellspacing="2" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>" style="display:none">

<tr>
    <td  class="TEXTO6"  width="25%">Fecha Limite Pago</td>
    <td width="25%"><input type="text" id="ttx" name="ttx" value="  /  /    " class="inputs" style="width:100%; text-align:left" /></td>
    <td  class="TEXTO6"  width="25%">Estado</td>
    <td width="25%"><input type="text" id="ppp" name="ppp" value="<%=rs("oc_csitord") %>" class="inputs" maxlength="1" style="width:100%; text-align:left;" style="display:none" /></td>
</tr>
<tr>
    <td  class="TEXTO6"  width="25%">Importe</td>
    <td width="25%"><input type="text" id="ttx" name="ttx" value="  " class="inputs" style="width:100%; text-align:left" /></td>
    <td  class="TEXTO6"  width="25%">Glosa</td>
    <td width="25%"><input type="text" id="Text2" name="Text2" value="" class="inputs" style="width:100%; text-align:left;" disabled /></td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table cellpadding="5" cellspacing="0" border="1"  style="display:none" width="100%" align="center" >
    <tr><td align="left" class="ESTILO4">Resumen</td></tr>
</table> 
<table border="1" cellpadding="2" width="100%" cellspacing="2" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("COLOR2"))%>" bordercolorlight="<%=(Application("COLOR2"))%>" style="display:none">
    <tr valign="top">
        <td  class="TEXTO6"  width="10%">Total Soles :</td>
        <td width="10%"><input id="soles" name="soles" class ="data2" value="<%=formatnumber(rs("oc_nimpmn"),3,,true)%>" style="text-align:right; padding-right:5px;" class="data2" readonly tabindex="-1"/></td>
                <td  class="TEXTO6"  width="10%">Total US $ :</td>
        <td width="10%"><input id="dolares" name="dolares" class="data2" value="<%=formatnumber(rs("oc_nimpus"),3,,true)%>" style="text-align:right; padding-right:5px;" class="data2" readonly tabindex="-1"/></td>
    </tr>
</table>
<!-------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------!-->
<script type="text/jscript" language="jscript">
//**********************************************************************************************
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=800,width=1200";
user = '<%=trim(ucase(usr))%>'
if (user == 'MHD')
    document.all.ppp.style.display='block'
//alert(user)
var subcadena ='<%=RS("OC_CTIPDSP")%>' ;
var elemento = document.all.DESP ;
document.all.DESP.selectedIndex = seleindice(subcadena,elemento);
document.all.DESP.disabled = true;
var subcadena ='<%=RS("OC_CTIPDOC")%>' ;
var elemento = document.all.DOCR ;
document.all.DOCR.selectedIndex = seleindice(subcadena,elemento);
document.all.DOCR.disabled = true;
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
document.all.ALM.disabled = true;

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
    opc += "menubar=yes,resizable=yes,left=0,top=0,height=600,width=1200";

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

    if (fecha(document.all.FEC.value) == false) {
        document.all.FEC.value = '<%=DATE()%>'
    }
    if (trim(document.all.CCTO.value) == '') {
        alert("Favor informar el Centro de Costo")
        document.all.CCTO.focus()
        return true;
    }

    kad = 'comun/insercabocNEW.asp?OC=' + trim(document.all.OC.value)

    kad += '&MON=' + ltrim(document.all.MON.value)
    kad += '&TOC=' + ltrim(document.all.TOC.value)
    kad += '&sit=' + trim(document.all.ppp.value)
    kad += '&pro=' + trim(document.all.PRO.value)
    kad += '&raz=' + ltrim(document.all.NOM.value)  
    kad += '&COT=' + ltrim(document.all.DOC1.value)   
    kad += '&SOLi=' + ltrim(document.all.SOLI.value)  
    kad += '&CAM=' + ltrim(document.all.TCAM.value)
    kad += '&ENT=' + ltrim(document.all.ENT.value)
    kad += '&KOS=' + ltrim(document.all.CSOL.value)
    kad += '&LUG=' + ltrim(document.all.LENT.value)
    kad += '&LFA=' + ltrim(document.all.LFAC.value)
    kad += '&OBS=' + ltrim(document.all.OBS.value)
    kad += '&TIP=' + ltrim(document.all.TENV.value)
    kad += '&USR=' + '<%=txtUsuario%>' 
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
    kad += '&CHK=' 
    kad += '&DOCR=' + ltrim(document.all.DOCR.value)
    kad += '&DESP=' + ltrim(document.all.DESP.value)
    kad += '&DOC2=' + ltrim(document.all.DOC2.value)
    kad += '&ALM=' + ltrim(document.all.ALM.value)
    kad += '&DIS=' + ltrim(document.all.DIS.value)
    kad += '&PRV=' + ltrim(document.all.PRV.value)
    kad += '&CCTO=' + ltrim(document.all.CCTO.value)
    kad += '&FEDO=' + ltrim(document.all.FEC.value)
    kad += '&FPAG=' + ltrim(document.all.FPAG.value)
    kad += '&dir=' + ltrim(document.all.DPRO.value)
    kad += '&al2=' + '<%=al2%>'
    kad += '&cod=' + '<%=cod%>'
    kad += '&can=' + '<%=can%>'
    kad += '&ofi=' + '<%=ofi%>'
    kad += '&lt2=' + '<%=lt2%>'
    kad += '&lt1=' + '<%=lt1%>'
    kad += '&cla=' + '<%=cla%>'
    kad += '&SER=' + '<%=SER%>'
    kad += "&ki1=" + '<%=request.QueryString("ki1")%>'
    kad += "&ki2=" + '<%=request.QueryString("ki2")%>'
    kad += "&ki3=" + '<%=request.QueryString("ki3")%>'
    kad += "&ki4=" + '<%=request.QueryString("ki4")%>'
    kad += "&ki5=" + '<%=request.QueryString("ki5")%>'
    kad += "&ki6=" + '<%=request.QueryString("ki6")%>'
    kad += "&hi1=" + '<%=request.QueryString("hi1")%>'
    kad += "&hi2=" + '<%=request.QueryString("hi2")%>'
    kad += "&hi3=" + '<%=request.QueryString("hi3")%>'
    kad += "&hi4=" + '<%=request.QueryString("hi4")%>'
    kad += "&hi5=" + '<%=request.QueryString("hi5")%>'
    kad += "&hi6=" + '<%=request.QueryString("hi6")%>'

   document.all.body10.style.display = 'block'
     document.all.body10.height = "350"
     document.all.body10.width = "100%"
 
   alert(kad)
   document.all.body10.src = kad
}


if (trim(thisForm.OC.value) != 'AUTO') {
    cad = 'MAINarticuloOCnew.asp?OC=' + trim(thisForm.OC.value)
    cad += '&alm=' + '<%=alm%>'
    cad += '&cod=' + '<%=cod%>'
    cad += '&can=' + '<%=can%>'
    cad += '&ofi=' + '<%=ofi%>'
    cad += '&lt2=' + '<%=lt2%>'
    cad += '&lt1=' + '<%=lt1%>'
    cad += '&al2=' + '<%=al2%>'
    cad += '&CLA=' + '<%=CLA%>'
    cad += '&SER=' + '<%=SER%>'
    cad += "&ki1=" + '<%=request.QueryString("ki1")%>'
    cad += "&ki2=" + '<%=request.QueryString("ki2")%>'
    cad += "&ki3=" + '<%=request.QueryString("ki3")%>'
    cad += "&ki4=" + '<%=request.QueryString("ki4")%>'
    cad += "&ki5=" + '<%=request.QueryString("ki5")%>'
    cad += "&ki6=" + '<%=request.QueryString("ki6")%>'
    cad += "&hi1=" + '<%=request.QueryString("hi1")%>'
    cad += "&hi2=" + '<%=request.QueryString("hi2")%>'
    cad += "&hi3=" + '<%=request.QueryString("hi3")%>'
    cad += "&hi4=" + '<%=request.QueryString("hi4")%>'
    cad += "&hi5=" + '<%=request.QueryString("hi5")%>'
    cad += "&hi6=" + '<%=request.QueryString("hi6")%>'

   //alert(cad)
    window.open(cad, 'Deta_OC', opc)
}


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>