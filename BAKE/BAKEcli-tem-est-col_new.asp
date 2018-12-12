<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<script language="jscript" type="text/jscript">
    var oldrow = 1
    var oldpos = 1
</script>
</head>
<body style="margin-top:0px; margin:0px; margin-right:0px">
<%cli	= Request.QueryString("cli")
  tem	= Request.QueryString("tem")
  est	= Request.QueryString("est")
  cad   = " EXEC SP_COMBOS_PARTIDA '"&cli&"', '"&est&"', '"&tem&"'     "
         RS.OPEN CAD, CNN
 '  RESPONSE.Write(cad)
	 '	RESPONSE.Write("<br>")
	 '	RESPONSE.Write(RS.RECORDCOUNT)
  	 '  response.end
		if RS.RECORDCOUNT > 0 then
			rs.movefirst
        end if
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1         
        
        
        
        %>

<form id="thisForm" method="post" action=''>

<%cont = 1 %>

<table id="TABLA" width ="100%" align="left" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
    <tr bgcolor="<%=APPLICATION("TITULO")%>" >        
        <td align="center" class="AMERICANwhite10" width="1%"><input type="checkbox" id="cheka"  onclick="chea()"/></td>
	    <td align="center" class="AMERICANwhite10" width="15%">COLOR-PO <input id="maxi" value =''  /></td>
    </tr>
    <%DO WHILE NOT RS.EOF %>    
        <% com = rs("combo")
        mas =  "EXEC SP_DESPACHO_PARTIDAS_COMBO '"&cli&"', '"&est&"', '"&tem&"' , '"&com&"' "
        rs2.open mas, cnn
        if rs2.recordcount > 0 then%>

        <tr id="fila<%=Trim(Cstr(cont))%>" <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>  onclick="dd('<%=(cont)%>')">         
               <td class="texto po" align="center"><input class="chk" type="checkbox" id="chk<%=cont%>" onclick="check('<%=cont%>')" /></td>
            <td class="AMERICANnavy33" align="left"  id="ub<%=cont%>"><%=trim(RS("combo"))%></td>
            </tr>           
        <%cont=cont+1%>
        <%end if
          rs2.close%>
        <%RS.MOVENEXT%>
    <%LOOP%>
    <tr  bgcolor="red">    
        <td colspan="2" align="center" class="AMERICANwhite10">Solo se muestran los Colores de las Po que tienen Explosión de Tela y Partida Asignada</td>
    </tr>
</table>

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

</form>

<script language="jscript" type="text/jscript">
mm = parseInt('<%=cont-1%>',10)

document.getElementById("maxi").value = parseInt(mm,10)
if (mm >0)
    dd('1')
function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
   	oldrow=pos
	return true;
}
function check(ff) 
{   var pos = parseInt(ff, 10)
    var t = document.all.TABLA;
    chk = "chk" + pos.toString()
    if (document.getElementById(chk).checked == true) 
    {   cad = 'BAKE/DESPACHO_PARTIDAS_COMBO.asp?cli=' + '<%=cli %>'
        cad += '&tem=' + '<%=tem%>'
        cad += '&est=' + '<%=est%>'
        cad += '&com=' +  ltrim(t.rows(pos).cells(1).innerText) ;
    }
    else 
    {   cad = 'blanco.htm' ;
       // cad = 'blanco.htm'
        eval("parent.document.all.DETACOL"+pos+".style.display = 'none'")
        //alert(parent.document.getElementById("DETACOL"+pos).style.display)
    }
    
    eval("parent.document.all.DETACOL"+pos+".src = cad")
    eval("parent.document.all.DETACOL"+pos+".style.display = 'block'")
    return true;
}


function chea()
{   maxim = parseInt(document.all.maxi.value,10)
    for (y= 1; y<=maxim; y++)
        {   if (document.all.cheka.checked == true)
                eval("document.all.chk" + y.toString()+".checked='true'")
            else    
            {  chec = "chk" + y.toString() 
               document.getElementById(chec).click();
             
            }
            check(y)
        }
}

</script>

		
</body>

</html>