<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%Session.LCid=2057%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<LINK REL="stylesheet" TYPE="text/css" HREF="estilos1.CSS">
<!--#include file="comun/funcionescomunes.asp"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<!--#include file="includes/cnn.inc"-->
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=15"%>
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
<script language="jscript" type="text/jscript">

addCalendar("Calendar1", "Elija una fecha", "final", "thisForm")

function MUESTRA(op) {

    datos = trim(thisForm.CLI.value)+ trim(thisForm.EST.value) + trim(thisForm.PO.value) + trim(thisForm.TEM.value) + trim(thisForm.OFI.value) + trim(thisForm.PRO.value)

    if (trim(datos) == '') {
        alert("Seleccione algun criterio por favor")
        return false;
    } 
    dato = ''
    if (trim(thisForm.OFI.value) != '') {
       
        det = trim(thisForm.OFI.value)
        while (det.indexOf(',') > 0) {
            n = det.indexOf(',')
            dato += "'" + strzero(Left(det, n), 8) + "',";
            det = det.slice((n + 1), det.length)
           // alert(det)
        }
        dato += "'" + strzero(Left(det, n), 8) + "'";
        //dato = Left(trim(dato),dato.length-1)
       // alert(dato)
    }

  cad  = 'TNTdeta.asp?cli=' +trim(thisForm.CLI.value)
  cad += '&GTE=' + trim(thisForm.gtex.value)
  cad += '&est=' + trim(thisForm.EST.value)
  cad += '&poo=' + trim(thisForm.PO.value)
  cad += '&tem=' + trim(thisForm.TEM.value)
  cad += '&ofi=' + dato
  cad += '&pro=' + trim(thisForm.PRO.value) 
  cad += '&excel=' + op
	//alert(cad)
	parent.window.frames[1].window.location.replace(cad)
}
function divis() {

    //thisForm.COL.value = '';
    cad = 'bake/baketemporadas.asp?pos=' + trim(thisForm.CLI.value) + '&sele=' + document.all.TEM
      // document.all.body0.style.display = 'block'
    // alert(cad)
    document.all.body0.src = cad
}

function calcHeight(marco) {  //find the height of the internal page
    var the_height =
    document.getElementById(marco).contentWindow.
      document.body.scrollHeight + 50;
    //change the height of the iframe
    document.getElementById(marco).height =
      the_height;
}
</script>

<body>
<form id ="thisForm" name= "thisForm" >
<table id="Table1" align="center"  bordercolor="#FFFFFF"  bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="1"  border="0">
    <tr valign="middle" >
    <td align="left" rowspan="4" width="10%"><img src="imagenes/ATRAS.gif" 
			style="cursor:pointer;" alt=""
			onclick="javascript: top.window.location.replace('<%=submenu%>');" /></td>
      <% CAD =   " SELECT CODIGO,  NOMBRE FROM CLIENTE WHERE ESTADO ='A' order by NOMBRE "
                  '  response.write(cad)
                  '  response.write("<br>")
            RS.OPEN CAD,CNN
            IF rs.recordcount > 0 THEN rs.movefirst%>
       	        <td class="AMERICAN22" valign="middle" align="right" width="10%">Cliente:&nbsp;</td> 
                <td  class="Estilo12" align="left" width="20%" colspan="2">
                    <select  name="CLI" id="CLI"  onChange="divis()" style="width:100%">
                        <option value = "" selected ></option>
                        <%do while not rs.eof %>
                            <option value="<%=TRIM(RS("CODIGO"))%>"><%=TRIM(RS("NOMBRE")) %></option>
                            <%rs.movenext %>
                        <%loop %>
                    </select>
                </td>  
        <%RS.CLOSE %>
       	 <td class="AMERICAN22" align ="right" valign="middle" width="10%">Estilo: </td>       
         <td width="20%"><input id="EST" name="EST"  value ="" style="width:100%" class="DATOSkhaki"></td>	
       
		
        <td align ="center" valign="middle"><input type="button" value="Pantalla"  onclick="MUESTRA('0')" style="cursor:pointer"/></td> 
     </tr>
     <tr>
        <td class="AMERICAN22" valign="middle" align="right" >Temporada:&nbsp;</td> 
        <td  class="Estilo12" align="left"  width="15%" colspan="2">
            <select  name="TEM" id="TEM" class="Estilo12" style="width:100%">
                <option value = "" selected></option>                     
            </select>
        </td>
        <td class="AMERICAN22" align ="right" valign="middle">PO: </td>       
        <td><input id="PO" name="PO"  value =""  style="width:100%" class="DATOSkhaki"></td>
        <td></td>
    </tr>
   <tr>    	
      
        <td class="AMERICAN22" align ="right" valign="middle">Grupo de Tela: </td>       
        <td colspan="2"><input id="gtex" name="gtex"  value ="" class="DATOSkhaki" style="width:100%" ></td>       
       <td colspan="2"></td>
     </tr>

      <tr>
        <td class="AMERICAN22" valign="middle" align="right" >OFI:&nbsp;</td> 
        <td  class="Estilo12" align="left"  width="15%" colspan="2">
            <input name="OFI" id="OFI" class="DATOSkhaki" style="width:100%" />
        </td>
        <td class="AMERICAN22" align ="right" valign="middle">Ajuste: </td>       
        <td><input id="PRO" name="PRO"  value =""  style="width:100%" class="DATOSkhaki"></td>
        <td align ="center" valign="middle"><input type="button" value="EXCEL"  onclick="MUESTRA('1')" style="cursor:pointer"/></td> 
    </tr>


</table>
<iframe  width="100%" onload="calcHeight('body0');" style="display:none; width:100%;" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="200" align="middle"></iframe>
</form>
</body>

</html>
