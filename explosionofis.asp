<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2058%>
<% tienda = Request.Cookies("tienda")("pos") %>

<!--#include file="./includes/cnn.inc"-->

<!--#include file="./includes/funcionesVBscript.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=11" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<LINK REL="stylesheet" TYPE="text/css" HREF="./estilos1.CSS">
<title>Untitled Document</title>
<script src="./COMUN/jquery.js"></script>
<SCRIPT language="javascript" src="./includes/cal.js"></SCRIPT>
<!--#include file="./comun/funcionescomunes.asp"-->
</head>
<body>
    <form id ="thisForm" name= "thisForm" >
    <table id="Table1" align="center"  bordercolor="#FFFFFF"  bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="1"  border="0">
        <tr valign="middle" >
        <td align="left" rowspan="4" width="10%"><img src="./imagenes/ATRAS.gif" 
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
             <td width="20%"><input id="EST" name="EST"  value =""  style="width:100%" class="DATOSkhaki"></td>	  
         <!--<td class="AMERICAN22" align ="right" valign="middle" width="10%">Tela: </td>       
             <td width="20%"><input id="TEL" name="TEL"  value =""  style="width:100px" class="DATOSkhaki"></td>	-->
         </tr>
         <tr>
            <td class="AMERICAN22" valign="middle" align="right" >Temporada:&nbsp;</td> 
            <td  class="Estilo12" align="left"  width="15%" colspan="2">
                <select  name="TEM" id="TEM" class="Estilo12" style="width:100%">
                    <option value = "" selected></option>                     
                </select>
            </td>
            <!--<td class="AMERICAN22" align ="right" valign="middle">PO: </td>       
            <td><input id="PO" name="PO"  value =""  style="width:100%" class="DATOSkhaki"></td>-->
            <td colspan=2"></td>
            <td align="center" colspan="2"><input type="button" value="Pantalla"  onclick="MUESTRA('0')" style="cursor:pointer"/></td>
        </tr>
        <tr>    	
            <!--<td class="AMERICAN22" align ="right" valign="middle" >Fec Llegada PO: </td> 
            
            <td><input id="final" name="final"  readonly value ="" tabindex="-1" width=70></td>	
            <td class="Estilo11" align ="left" valign="middle"><A href="javascript:showCal('Calendar1')"><img height=16 src="./imagenes/cal.gif" width=16 border=0></A></td> 
            <td class="AMERICAN22" align ="right" valign="middle">Grupo de Tela: </td>       
            <td><input id="gtex" name="gtex"  value =""   style="width:100%" class="DATOSkhaki"></td>       -->
            <td class="AMERICAN22" valign="middle" align="right" >OFI:&nbsp;</td> 
            <td  class="Estilo12" align="left"  width="15%" colspan="2">
                <input name="OFI" id="OFI" class="DATOSkhaki" style="width:100%" />
            </td>
            <td class="AMERICAN22" align ="right" valign="middle">PROTO: </td>       
            <td><input id="PRO" name="PRO"  value =""  style="width:100%" class="DATOSkhaki"></td>
            
            <td align ="center" valign="middle" colspan="2"><input  style="display:none" type="button" value="EXCEL"  onclick="MUESTRA('1')" style="cursor:pointer"/></td> 
         </tr>
    
        
        
    </table>
    </form>
    <iframe id="body0" name="body0" style="display:none"></iframe>
    <iframe id="body1" name="body1" style="width:100%" frameBorder="0"></iframe>
    <script>

        var CLI=$("#CLI");
        var EST=$("#EST");
        var TEM=$("#TEM");
        var PRO=$("#PRO");
        var OFI=$("#OFI");

        $(document).ready(function () {
          addCalendar("Calendar1", "Elija una fecha", "final", "thisForm")
          calcHeight("#body1");
        });

        

        function MUESTRA(op) {

          datos = trim(CLI.val()) + trim(EST.val()) + trim(TEM.val()) + trim(OFI.val()) + trim(PRO.val())
          
          if (trim(datos) == '') {
            alert("Seleccione algun criterio por favor")
            return false;
          }

          //  alert(off)
          cad = 'explosionofisdeta.asp?pos=' + trim(CLI.val())
          cad += '&est=' + trim(EST.val())
          cad += '&tem=' + trim(TEM.val())
          cad += '&ofi=' + Right(strzero(trim(OFI.val()),8),8)
          cad += '&pro=' + trim(PRO.val())
          cad += '&excel=' + op
          //alert(cad)
          //alert(cad)
          $("#body1").removeAttr("src");
          $("#body1").attr("src",cad)
        }

        function divis() {

          //thisForm.COL.value = '';
          cad = './bake/baketemporadas.asp?pos=' + trim(thisForm.CLI.value) + '&sele=' + document.all.TEM
          // document.all.body0.style.display = 'block'
          // alert(cad)
          document.all.body0.src = cad
        }

        function calcHeight(marco) { 
          $("#body1").height($(document).height()-$("#body1").offset().top-20)
        }
    </script>
</body>
</html>
