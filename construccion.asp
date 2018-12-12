<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<%cliente = request.QueryString("cli")%>
<%estilo  = request.querystring("est")
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp  = REQUEST.cookies("spe")
vr  = right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")



%>
<head>
	<title>FICHA ESTILO</title>
</head>
<body>
<form method="POST" enctype="multipart/form-data" action="" id="formato">
	<input id="gru" name="gru" value='<%=request.querystring("gru")%>'          style="display:none" />
    <input id="ord" name="ord" value='<%=request.querystring("ord")%>'          style="display:none" />
    <input id="cli" name="cli" value='<%=cli%>'          style="display:none" />
    <input id="tem" name="tem" value='<%=tem%>'          style="display:none" />
    <input id="med" name="med" value='<%=med%>'          style="display:none" />
    <input id="est" name="est" value='<%=est%>'          style="display:none" />
    <input id="spe" name="spe" value='<%=sp%>' style="display:none" />
    <input id="ver" name="ver" value='<%=vr%>' style="display:none" />
	<input id="cad" name="cad" value=''                                         style="display:none" />
	
    <table  cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center"> 
		<td align="center"><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><%=TITULO%> SPEC : <%=trim(SP)%>-<%=vr%>&nbsp;Medido en <%=med %>   
		<input type="hidden" id="Hidden1" name="GRU" value="<%=POS%>">
	</td>
    	<td align="center" height="19px"><img src="imagenes/reload.jpg" border="0" style="cursor:pointer; display:none" onclick="location.reload()" />
        </td>
    </tr>
	<tr>
    	<td colspan="3" style="background-color:Red; height:1px; font-size:xx-small"></td>
	</tr>
</table>	
    
    
    <table align="center" width="100%" border="1" cellpadding="1" cellspacing="1"  >
        <tr>    
            <td class="DESCRIPTORnavyBOLD" bgcolor='<%=(Application("barra"))%>' width="100%">FOTO</td> 
        </tr>
        <tr>       
            <td><input type="file" class="default" id="file" name="file" accept="image/gif, image/jpeg, image/png" value="" style="width:100%" /></td>
        </tr>
            <td colspan ="7" align="center"> <input type="submit" id="manda" onclick="VERI()" value="GRABAR" /></td>
	    </tr>
	    <tr>
	        <td colspan ="7" align="center" width="100%">
	        <img src="bake/RECUPERAFOTO.ASP?spe="
             width="200" /></td>	    
        </tr>
    </table>	
</form>
<script type="text/jscript" language="jscript">

function VERI() {

if (trim(document.getElementById('file').value) != '') 
{ 
    AlertFilesize() 
   
    document.all.formato.action = 'comun/Inserconstruccion.asp'
 //    alert( document.all.formato.action)
 
     document.all.formato.submit()
 } 
 }

 function AlertFilesize() {
     var fileUpload = document.getElementById("file");

     if (typeof (fileUpload.files) != "undefined") {

         var size = parseFloat(fileUpload.files[0].size / 1024).toFixed(2);

         alert(size + " KB.");

     } 
 }


</script>
</body>
</html>
