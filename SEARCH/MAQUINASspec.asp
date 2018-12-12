<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID = 2057 %>
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
<%	sp  = request.Cookies("spe")
    vr  = right(request.Cookies("ver"),3)
    cli = request.Cookies("cli")
    tem = request.Cookies("tem")
    med = request.Cookies("med")
    mmd = request.Cookies("mmd")
    est = request.Cookies("est")

	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="formato" method="post" action="">
<center>
<font face="arial" size="3" style="color:'red'"><strong>Maquinas de Costura Spec : N&deg; <%=sp%>-<%=vr%> </strong></font><br /><br />
</center>

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table  border="1" bordercolordark="navy" cellpadding="10" cellspacing="0" bordercolorlight="<%=application("color2")%>" align="center">   
	<tr valign="middle">
		<td>
            <%aLET = ARRAY("0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0")%>
            <%u=1%>
            <table  border="0" cellspacing="1" cellpadding="1" align="center" style="background-color:white">
                <tr style="background-color:'<%=application("barra")%>';"  >
                    <td  class="texto">N&deg;&nbsp;&nbsp;&nbsp;</td>
                    <td  class="texto">MAQUINA</td>
                    <td style="text-align:center" class="texto">Ptda x 1"</td>
                    <td class="texto" align="center">Medida</td>
                    <td class="texto" align="center">Hilos</td>
                </tr>   
            <%cad = "select * from view_spec_maquinas  where spec= '"&sp&"' and ver = '"&vr&"' ORDER BY LIN "
            rs.open cad,cnn
            DO WHILE NOT RS.EOF %>   
              <tr  id="LIN<%=U%>" name="LIN<%=U%>"  style="display:block;" >
                <td class="AMERICANNAVY" id="IT<%=u%>" name="IT<%=u%>"><%=u%></td>
                <td  onfocus="lineas('<%=u%>');">
                     <%cad = "select * from maquinas where estado = 'a' order by descripcion "
                rs2.open cad, cnn %>
                 <select id="MAQ<%=U%>" name="MAQ<%=U%>" class="DATOS"  onfocus="lineas('<%=U%>');" style="width:100px;">
                    <%IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST %>
                    <option value=""></option>
                    <%DO WHILE NOT RS2.EOF%>
                        <option value='<%=RS2("codigo")%>'><%=RS2("DESCRIPCION")%></option>  
                        <%rs2.movenext %>
                    <%loop%>
                 </select> 
                <%=rs2.close %>
                    <script>
                        pp = parseInt('<%=u%>',10)
                        var subcadena = '<%=RS("maq")%>';
                        var elemento = eval("document.all.MAQ"+pp);
                        elemento.selectedIndex = seleindice(subcadena, elemento);
                       
                    </script>
                </td>
                <td ><input id="PTO<%=u%>" name="PTO<%=u%>" value="<%=trim(RS("PUNTOS"))%>" class="DATOS" style="text-align:center;width:100px;" maxlength="12" onfocus="lineas('<%=U%>');seleccionar(this)" /></td>   
                <td ><input id="MED<%=u%>" name="MED<%=u%>" value="<%=trim(RS("MEDIDA"))%>" class="DATOS" style="width:100px;text-align:center;" maxlength="8"  onfocus="lineas('<%=U%>');seleccionar(this)" /></td>
                <td ><input id="HIL<%=U%>" name="HIL<%=u%>" value="<%=trim(RS("HILOS"))%>" class="DATOS" style="width:60px;text-align:center;"  maxlength="4"  onfocus="lineas('<%=U%>');seleccionar(this)" /></td>
              </tr>
            <%U = U + 1 %>
            <%RS.MOVENEXT%>
            <%LOOP%>
            <%' solo tengo 26 letras del alfabetooo
            if 36 > u+35 then maximus = u+35 else maximus = 36%>
            <%for k=u to maximus %>
            <tr id="LIN<%=k%>" name="LIN<%=K%>" style="display:none" >
                <td class="AMERICANNAVY" id="IT<%=k%>" name="IT<%=k%>"><%=k%></td>
                <td style="width:39%">
                <%cad = "select * from maquinas where estado = 'a' order by descripcion "
                rs2.open cad, cnn %>
                 <select id="MAQ<%=k%>" name="MAQ<%=k%>" class="DATOS"  onfocus="lineas('<%=k%>');" style="width:100px;">
                    <%IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST %>
                    <option value=""></option>
                    <%DO WHILE NOT RS2.EOF%>
                        <option value='<%=RS2("codigo")%>'><%=RS2("DESCRIPCION")%></option>  
                        <%rs2.movenext %>
                    <%loop%>
                 </select> 
                <%=rs2.close %>

                <td ><input id="PTO<%=K%>" name="PTO<%=K%>" value="" class="DATOS" style="text-align:center;width:100px;"  maxlength="12" onfocus="lineas('<%=k%>');seleccionar(this)" /></td>   
                <td ><input id="MED<%=K%>" name="MED<%=K%>" value="" class="DATOS" style="width:100px;text-align:center;"  maxlength="8"  onfocus="lineas('<%=k%>');seleccionar(this)" /></td>
                <td ><input id="HIL<%=K%>" name="HIL<%=K%>" value="" class="DATOS" style="width:60px;text-align:center;"   maxlength="4"  onfocus="lineas('<%=k%>');seleccionar(this)" /></td>
              </tr>
            <%next %>
               <tr valign="middle"><td colspan="5" align="center">
               <iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none"></iframe>
               </td></tr>
               <tr>
                    <td colspan="5" align="center"><br /><input type="button" value= "" onclick="graba()" style="display:block; background-image:url(imagenes/disk.gif);width:26px;height:26px;cursor:pointer;" /><br /></td>
               </tr>
            </table>
</td>	
	</tr>
</table>
<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">
    
var TOPE= parseInt('<%=k%>',10)

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;


tto = parseInt('<%=u%>',10)
tto = tto
var lets ="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
lineas('<%=u-1%>')



function valida(){

    ninguno = 0
    for (d = 1; d < TOPE - 1; d++) 
    {   // revisa si todas las lineas con color tienen cantidad
        if (eval("document.all.LIN"+d+".style.display")== 'block') 
        {    if (trim(eval("document.all.MAQ"+d+".value"))!= '')
                ninguno++;
             
            if (trim(eval("document.all.PTO"+d+".value"))!= '')
                eval("document.all.PTO"+d+".value = toChar(document.all.PTO"+d+".value)")

            if (trim(eval("document.all.MED"+d+".value"))!= '')
                eval("document.all.MED"+d+".value = toMED(document.all.MED"+d+".value)")

            if (trim(eval("document.all.HIL"+d+".value"))!= '')
                eval("document.all.HIL"+d+".value= toChar(document.all.HIL"+d+".value)") 
        }      
    }
    if (ninguno == 0) {
        alert("Esta Prenda no utiliza máquinas?")
        document.all.MAQ1.focus();
        return false;
    }

return true;
}


function graba()
{    
    if (valida() == true) 
    {   document.all.formato.action ="comun/insermaquinaSPEC.asp?tope=" + TOPE
        document.all.formato.submit()
    } 
    return true;
}

function lineas(op)
{   op = parseInt(op,10)

if (op < TOPE-1)
{   op++
    eval("document.all.LIN"+op+".style.display='block'")
    }
}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>