<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>PE SERVICIOS</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<%submenu = "SUBMENU.ASP?TIPO=13"
CIA = "0001"
%>
<script type="text/jscript" language="jscript">
    var aCod = Array()
    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('deta').contentWindow.
      document.body.scrollHeight +250;
        //change the height of the iframe
        document.getElementById('deta').height =
      the_height;
    }
</script>

<body style="margin-top:0; onload="document.getElementById('OC').focus();">

<form id="thisForm" method="post" name="thisForm" action="">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="10%" align="center"><img src="imagenes/atras.gif" style="cursor:pointer;" onclick="javascript: window.location.replace('<%=submenu%>');" /></td>	
    
          <td align="center" class="TALASBLUE" width="80%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td class="talasblue" align="center">Reimprimir Documentos</td></tr></table></td>
    <td width="10%" align="center"><img src="imagenes/logo.gif" /> </td>	
    </tr>
</table>    

<iframe id="head" name="head"  style="display:none" src=""  width="100%" scrolling="no" frameborder="1" height="100"></iframe>

<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left;padding-left:20px;">Criterios - Filtro </td></tr>
</table> 

<table  border="0" cellspacing="2" cellpadding="2" align="center" width="100%" style="background-color:#DDEBC6" >
    <tr valign="top">
        <td align="right" class="TEXTO7" width="10%" > Almacen :&nbsp;</td> 
        <td width="20%"><select id="ALM" name="ALM" class="DESCRIPTORnavy">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001ALMA Order by A1_CALMA" 
            RS.OPEN CAD, CNN
            IF RS.RECORDCOUNT >0 THEN     RS.MOVEFIRST
            DO WHILE NOT RS.EOF%>
            <option value ='<%=RS("A1_CALMA")%>'><%=RS("A1_CALMA")%>&nbsp;&nbsp;<%=RS("A1_CDESCRI")%></option>
                <%RS.MOVENEXT
            LOOP
            RS.CLOSE%>
        </select>
      </td>
      <td align="right" class="TEXTO7" width="10%" > Tipo-Nro. Doc :&nbsp;</td> 
        <td width="5%">
             <select  class="DESCRIPTORnavy" id="DOC" name="DOC"  value="" style="text-align:center;width:100%">
                            <option value=""></option>
                            <option value="PE">PE</option>
                            <option value="PS">PS</option>
                            <option value="GS">GS</option>
                           
                        </select> 
                <option value=""></option>
            </select> 
        </td>
        <td width="15%"><input type="text" class="DESCRIPTORnavy" id="NUM" name="NUM" style="text-align:center; width:100%"  value=""/></td>
        
         <td style="padding-left:20px"><img src="imagenes/done.jpg" style="cursor:pointer;" onclick="graba()" id="SAVE" name="SAVE" alt="Guardar Cambios"/></td>
</tr>
    
</table>

<iframe src="BLANCO.HTM" frameborder="0" name="deta" id="deta" width="100%" scrolling="yes" onload="calcHeight()"></iframe>

</form>  
<script language="jscript" type="text/jscript">   
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";



function graba() {
    if (trim(document.all.ALM.value) == '') {
        alert("Favor escojer Almacen")
        return false;
    }
    
    if (trim(document.all.DOC.value) == '') {
        alert("Favor seleccionar un tipo de Documento")
        return false;
    }
   
     
   

    
//    alert(kaa)

    if (trim(document.all.NUM.value) != '') {
        cad = 'reportes/prnpe.asp?alm=' + trim(document.all.ALM.value)
        cad += '&tip=' + trim(document.all.DOC.value)
        cad += '&num=' + trim(document.all.NUM.value)
        window.open(cad)
    }
    else {
        kaa = 'detaDOC.asp?TIP=' + trim(document.all.DOC.value) + '&num=' + trim(document.all.NUM.value)
        kaa += '&alm=' + trim(document.all.ALM.value)
        document.all.deta.src = kaa
    }
}


</script>
</body>
</html>
