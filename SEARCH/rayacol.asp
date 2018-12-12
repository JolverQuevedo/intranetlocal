<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<style type="text/css" media="all">
#graba { background:url('imagenes/done.jpg') no-repeat; border:3; width:25px; height:25px; }
</style>	
<%	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    POS = Request.QueryString("pos")
    com = Request.QueryString("com")
    DES = Request.QueryString("DCOM") 
    rs.open "select descripcion,cliente from colores where codigo = '"&pos&"'" 
    rs.movefirst
    dd =  rs("descripcion")   
    cc = rs("cliente")
    rs.close
	CAD =	" SELECT COLOR, LETRA, CODCOL, C1.DESCRIPCION   " & _ 
	        " FROM RAYACOLOR AS R1 full outer JOIN COLORES  " & _
	        " AS C1 ON r1.codcol = CODIGO  WHERE            " & _
	        " COMBIN = '"&COM&"' AND COLOR = '"&POS&"'      " & _
	        " AND R1.ESTADO = 'A'  ORDER BY 2               " 
	'response.Write(cAD)
	rs.open cad , cnn
	%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<script language="jscript" type="text/jscript">
var aCol =  Array()
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="">

<iframe  width="100%" style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<table width="100%" border="1" bordercolordark="<%=application("resalte")%>" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle" align="center">
		<td bgcolor="<%=application("resalte") %>" class="AMERICANwhite">COLORES &nbsp;<%=POS%>-<%=com %> :&nbsp;&nbsp; <%=trim(dd)%>&nbsp;&nbsp;&nbsp; <%=DES%></td>	
	</tr>
</table>


<table border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" width="100%">
<%if rs.recordcount>0 then 
    rs.movefirst 
  else 
    response.end
end if  %>
<tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
	    <td width="10%" class="DESCRIPTORnavyBOLD">LETRA</td>
        <td width="90%" class="DESCRIPTORnavyBOLD" colspan="2">COLOR</td>
	</tr>
<%cn=0
pp = 0 %>	
<%do while not rs.eof %>
  <tr valign="middle" bgcolor="<%if cn mod 2 = 0 then response.write(Application("color1")) else response.write(Application("color2")) %>" align="center">
	    <td class="DESCRIPTORnavyBOLD" ><%=rs("letra") %></td>
	    <td class="DESCRIPTORnavyBOLD" width="20%"><input id="COL<%=cn%>" name="COL<%=cn%>" value="<%=rs("codcol")%>" class="datoskhaki" ondblclick="help('<%=cn%>')" /></td>
	    <td class="DESCRIPTORnavyBOLD" width="70%"><input id="DES<%=cn%>" name="DES<%=cn%>" value="<%=rs("DESCRIPCION")%>" class="barra2" readonly /></td>
	</tr>
	<%if len(trim(rs("codcol"))) > 0 then pp = pp+1%>
    <script language="jscript" type="text/jscript">
        cn = parseInt('<%=pp%>',10)
        aCol[cn] = trim('<%=rs("codcol")%>')
    </script>
    <%cn = cn+1 %>
    <%rs.movenext %>
<%loop%>   
<tr>
<td colspan="3" bgcolor="<%=application("color2") %>" align="center"><input type="button" id="graba" style="display:none; cursor:pointer" onclick="veri()" />  </td></tr>    
 </table>
 <script type="text/jscript" language="jscript">
var opc = "height=480,width=300,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,scrollbars=1,status=1,toolbar=0"
var cliente = '<%=cc%>'

 function help(op)
 {  cad="help/HLPcolcli.asp?cli="+trim(cliente)+ "&raya="+trim('<%=pos%>')+ "&acol="+aCol+ "&ubi="+parseInt(op,10)
   window.open(cad,"",opc)
 }
 function veri()
 {  aColo = Array()
    tope = parseInt('<%=cn%>',10)
    for (v=0; v<tope; v++)
    {   QQ = eval("window.document.all.COL"+v+".value")
        if(trim(QQ)== '')
        {   alert("Para grabar debe llenar todos los colores")
            eval("window.document.all.COL"+v+".focus()")
            return false;
        }
        else
        {   aColo[v]= QQ
        }
    }
CAD = 'COMUN/INSERRAYAS4.ASP?pos='+trim('<%=pos%>')
CAD += '&com='+ trim('<%=com%>') + '&colo='+ aColo
document.all.body0.style.display='block';
document.all.body0.src=CAD
    
 }
 function rayas(op,des)
 {  cad = "bottomFrame"
    eval("top.window.frames.item('"+cad+"').window.document.all.COL"+op+".value=des")
 
 }
 
 	cor = 'rayaSEC2.asp?pos='+'<%=trim(pos)%>'+'&com='+ '<%=TRIM(COM)%>'
	top.window.frames.item("bottomFrame").window.location.replace(cor)
 
 
 
 </script>
  <%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("document.all.graba.style.display='block'"); 
	</script>
<%END IF %> 
	<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>