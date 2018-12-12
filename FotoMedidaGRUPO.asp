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
<%estilo  = request.querystring("est")%>
<head>
	<title>FICHA ESTILO</title>
</head>
<body>
<table WIDTH="100%" cellpadding="2" cellspacing="1" border="1" bordecolorlight="<%=application("color2")%>" bordercolordark="<%=application("color2")%>"
bgcolor="<%=application("color2")%>" bordercolor="<%=application("color2")%>">
<tr>
	<td align= left WIDTH=10% ><img src="imagenes/cerrar.gif" style="cursor:hand;" onClick="window.close();" alt=""/></td>
	<td align= CENTER valign="middle"  bgcolor="#ffcc66" bordercolordark="<%=application("borde")%>" bordercolorlight="<%=application("borde")%>" >
          <%cad = "select nombre from cliente where codigo= '"&cliente&"'"
          rs.open  cad, cnn 
          '  response.write(cad)
          clien = trim(rs("nombre"))
          rs.close
          rs.open "select estcli FROM ESTILOS WHERE CLIENTE = '"&CLIENTE&"' AND CODEST = '"&ESTILO&"' ", CNN
          ESTCLI = UCASE(TRIM(RS("ESTCLI")))
          rs.close
          codgru = request.querystring("gru")
          rs.open "select descripcion from grupomedida WHERE CODIGO = '"&CODGRU&"'", CNN
          DESGRU = UCASE(TRIM(RS("DESCRIPCION")))

          %>
          <span style="font-family:Trebuchet MS; font-size:small; color:Navy; font-weight:bold">
          CLIENTE : <%=clien%> <br /><font color="red" > Estilo: <%=estCLI%></font>
          <br /><font color="green" >Grupo : <%=desgru%></font>
          
          </span>
        <%rs.close %>
	</td>
	<TD ALIGN=right WIDTH=10% ><img src="imagenes/logo.GIF"></TD>
</TR>    
</table>
<form method="POST" enctype="multipart/form-data" action="" id="formato">
	<input id="gru" name="gru" value='<%=request.querystring("gru")%>'          style="display:none" />
    <input id="ord" name="ord" value='<%=request.querystring("ord")%>'          style="display:none" />
    <input id="cli" name="cli" value='<%=request.querystring("cli")%>'          style="display:none" />
    <input id="tem" name="tem" value='<%=request.querystring("tem")%>'          style="display:none" />
    <input id="med" name="med" value='<%=request.querystring("med")%>'          style="display:none" />
    <input id="est" name="est" value='<%=request.querystring("est")%>'          style="display:none" />
    <input id="spe" name="spe" value='<%=left(request.querystring("spe"),10)%>' style="display:none" />
    <input id="ver" name="ver" value='<%=right(request.querystring("spe"),3)%>' style="display:none" />
	<input id="cad" name="cad" value=''                                         style="display:none" />
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
	        <img src="bake/RECUPERAFOTOspec.ASP?spe=<%=left(request.querystring("spe"),10)%>&ver=<%=right(request.querystring("spe"),3)%>&ord=<%=request.querystring("ord")%>&gru=<%=request.querystring("gru")%>"
             width="200" /></td>	    
        </tr>
    </table>	
</form>
<script type="text/jscript" language="jscript">

function VERI() {

if (trim(document.getElementById('file').value) != '') 
{ 
    AlertFilesize() 
   
    document.all.formato.action = 'comun/InserfotoMedidaGRUPO.asp'
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
