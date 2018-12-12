<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body topmargin="0">
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="BODY" name="BODY"></iframe >
<form name="thisForm" id="thisForm" method="post" action="tipmaq.asp">
<%
tel = Request.QueryString("tel")
ver = Request.QueryString("ver")
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<table	align="center" border="0" id="DATAENTRY" width="100%">
<tr bgcolor="<%=application("contraste") %>">
    <td class="AMERICANwhite" colspan="4" width="50%">ORIGEN</td>
    <td class="AMERICANwhite" colspan="4" width="50%">DESTINO</td>
</tr>
   <tr>
        <td width="10%" bgcolor="<%=(Application("barra"))%>" align= "right">
            <font face="arial" size="1" color="MidnightBlue"><b> 
            TELA 1:</b></font>
            </td>
        <td bgcolor="WHITE" width="10%" valign="middle"> 
            <input type="text" id="TEL1" name="TEL1"  class="BARRAS" value="<%=TEL%>" tabindex="-1" readonly="readonly" />
        </td>
        <td width="10%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b> 
            RUTA :</b></font> </td>
        <td bgcolor="WHITE" width="10%" valign="middle"> 
            <input type="text" id="RUT1" name="RUT1"  class="BARRAS" value="<%=VER%>" tabindex="-1" readonly="readonly" />
        </td>
        <td width="10%" bgcolor="<%=(Application("barra"))%>" align= "right">
            <font face="arial" size="1" color="MidnightBlue"><b> 
            TELA 2:</b></font>
            </td>
        <td bgcolor="WHITE" width="10%" valign="middle" > 
            <input type="text" id="TEL2" name="TEL2"  class="DATOS" onblur="VERI()"  />
        </td>
        <td width="10%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b> 
            RUTA 2:</b></font> </td>
        <td bgcolor="WHITE" width="10%" valign="middle"> 
            <input type="text" id="RUT2" name="RUT2"  class="BARRAS" tabindex="-1" readonly="readonly" />
        </td>
    </tr>
    <tr>
        <td colspan="8" align="center">		
            <img src="imagenes/DONE.JPG" alt="GRABAR" onclick="GRABA()" style="cursor:pointer;" id="gg" />	
        </td>		
  </tr>
</table>

</form>
</body>

<script language="jscript" type="text/jscript">
    function GRABA() {
      /*  document.all.BODY.style.visibility = 'visible'
        document.all.BODY.height = "150"
        document.all.BODY.width = "100%"
       */
        tel1 = document.all.TEL1.value
        tel2 = document.all.TEL2.value
        rut2 = document.all.RUT2.value
        rut1 = document.all.RUT1.value
        if (trim(rut2)!= '')
            document.all.BODY.src = 'comun/duplicaruta.asp?tel2=' + tel2 + '&ver2=' + rut2 + '&ver1='+rut1+ '&tel1='+ tel1
        else {
            alert("No hay nada que grabar")
            return false;
        }
    }

    function VERI() {
        tel2 = document.all.TEL2.value
       /* document.all.BODY.style.visibility = 'visible'
        document.all.BODY.height = "150"
        document.all.BODY.width = "100%"
       */
        document.all.BODY.src = 'bake/baketelaruta.asp?tel=' + tel2

    }
</script>
</html>
