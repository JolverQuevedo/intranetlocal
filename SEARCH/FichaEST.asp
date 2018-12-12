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
<%estilo  = request.querystring("cod")%>
<head>
	<title>FICHA ESTILO</title>
</head>
<body>
<table WIDTH="100%" cellpadding="2" cellspacing="1" border="1" bordecolorlight="<%=application("color2")%>" bordercolordark="<%=application("color2")%>"
bgcolor="<%=application("color2")%>" bordercolor="<%=application("color2")%>">
<tr>
	<td align= left WIDTH=10% ><img src="imagenes/cerrar.gif" style="cursor:hand;" onClick="window.close();" alt=""/></td>
	<td align= CENTER valign="middle" class="TALASBLUE" bgcolor="orange" bordercolordark="<%=application("borde")%>" bordercolorlight="<%=application("borde")%>" >
          <%cad = "select nombre from cliente where codigo= '"&cliente&"'"
          rs.open  cad, cnn 
          '  response.write(cad)
          %>
          CLIENTE : <%=trim(rs("nombre"))%> --> Estilo: <%=estilo %>
        <%rs.close %>
	</td>
	<TD ALIGN=right WIDTH=10% ><img src="imagenes/logo.GIF"></TD>
</TR>    

</table>


	<form method="POST" enctype="multipart/form-data" action="" id="formato">
	<input id="USR" name="USR" value="<%=txtUsuario%>" style="display:none" />
	<input id="FEC" name="FEC" value="<%=date()%>" style="display:none" />
	<input id="CLI" name="CLI" value="<%=cliente%>" style="display:none" />
	<table align="center" width="100%" border="1" cellpadding="1" cellspacing="1"  >
 
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="10%"  class="DESCRIPTORnavyBOLD">CODIGO ESTILO</td>
	    <td width="5%"><input name="COD" type="TEXT" class="DATOSGRANDE" id ="COD" readonly="readonly" value="<%=request.querystring("cod")%>" /></td>
    	<td width="10%" bgcolor='<%=(Application("barra"))%>'  class="DESCRIPTORnavyBOLD">ESTILO CLIENTE</td>
        <td colspan="4"><input name="ECL"  type="text" class="DATOSGRANDE" id="ECL" maxlength="50" value="<%=request.querystring("ecl")%>" /></td>
    </tr>
    <tr>
        <td bgcolor='<%=(Application("barra"))%>' width="10%"  class="DESCRIPTORnavyBOLD">DESCRIPCION CLIENTE </td>
        <td colspan="6"><input id="DES" name="DES" type="TEXT"  class="DATOSGRANDE" maxlength="200" value="<%=request.querystring("des")%>" /></td>
    </tr>
    <tr> 
    	<td  bgcolor='<%=(Application("barra"))%>' width="10%"  class="DESCRIPTORnavyBOLD"> CODIGO MODELADOR</td>
		<td width="10%">
         
		    <input name="ART" type="TEXT" class="DATOSGRANDE" id ="ART" maxlength="20" width="100" value="<%=request.querystring("art")%>" <%if ucase(trim(txtusuario)) <> "MHINOJO" THEN %> READONLY <%END IF%>/></td>
		<td  bgcolor='<%=(Application("barra"))%>' width="10%" class="DESCRIPTORnavyBOLD">GENERO</td>
		<td width="10%"> 
		    <select id ="GEN" name="GEN" type="TEXT"  class="DATOSGRANDE" >
		    <option value=''></option>
		    <%  cad = "select * from generos order by GENERO" 
                rs.open cad,cnn
                if rs.recordcount > 0 then rs.movefirst
                do while not rs.eof%>
                    <option value='<%=rs("GENERO")%>'><%=trim(rs("DESCRIPCION")) %></option>
                    <%rs.movenext
			    loop%>
		    </select>		
		</td>

    	<td width="10%" bgcolor='<%=(Application("barra"))%>' class="DESCRIPTORnavyBOLD">TIPO PRENDA</td>
        <td colspan="2" width="10%" ><select id ="TIP" name="TIP" type="TEXT"  class="DATOSGRANDE" >
		    <option value=''></option>
		    <%  cad = "select * from TIPPRENDA  WHERE ESTADO ='A' order by DESCRIPCION" 
                rs.close
                rs.open cad,cnn
                if rs.recordcount > 0 then rs.movefirst
                do while not rs.eof%>
                    <option value='<%=rs("TIPO")%>'><%=trim(rs("DESCRIPCION")) %></option>
                    <%rs.movenext%>
                <%loop%>    
	  </select>		</td>
    
    </tr>
    <tr>
        <td bgcolor='<%=(Application("barra"))%>' width="10%"  class="DESCRIPTORnavyBOLD">DESCRIPCION MODELADOR </td>
        <td colspan="6"><input id="DMOD" name="DMOD" type="TEXT"  class="DATOSGRANDE" maxlength="200" value="<%=request.querystring("DMODELO")%>" /></td>
    </tr>
    
    <tr><td class="DESCRIPTORnavyBOLD" bgcolor='<%=(Application("barra"))%>'>OBSERVACIONES</td>
    	<td colspan="6"><textarea name="OBS" cols="1000" rows="4" class="DATOSgrande" id="OBS" ></textarea> </td>
    </tr>
    <tr>    
        <td class="DESCRIPTORnavyBOLD" bgcolor='<%=(Application("barra"))%>' width="4%">FOTO</td>    
        <td colspan="6" align ="center"><input type="file" name="file" class="DATOSgrande" ></td>
    </tr>
        <td colspan ="7" align="center"> <input type="submit" id="manda" onclick="VERI()" value="GRABAR" /></td>
	</tr>
	<%IF  REQUEST.QUERYSTRING("cod") <> "AUTO" THEN %>	
	<tr>
	    <td colspan ="7" align="center" width="100%">
	    <img src="bake/RECUPERAFOTOESTILO.ASP?CLI=<%=CLIENTE%>&ID=<%=REQUEST.QUERYSTRING("cod")%>" width="500" /></td>	    
    </tr>
    <%END IF %>
  </table>	
  </form>
<script type="text/jscript" language="jscript">
document.all.OBS.value=window.opener.OBS
tt = '<%=REQUEST.QUERYSTRING("tip")%>'
if (trim(tt)!= '')
{   var subcadena =  trim(tt)
    var elemento = document.all.TIP ;
    document.all.TIP.selectedIndex = seleindice(subcadena,elemento);
}    
gg = '<%=REQUEST.QUERYSTRING("gen")%>'
if (trim(gg)!= '')
{   var subcadena =  trim(gg)
    var elemento = document.all.GEN ;
    document.all.GEN.selectedIndex = seleindice(subcadena,elemento);
}

function VERI() {
    if (trim(document.all.TIP.value) == '') {
        alert("Ingrese el tipo de prenda por favor")
        return true;}
    if (trim(document.all.GEN.value) == '') {
        alert("Ingrese el genero del estilo por favor")
        return true;
    }


    document.all.formato.action = 'comun/InserfichaEST.asp'  
   // alert( document.all.formato.action)
     document.all.formato.submit()
}
</script>
</body>
</html>
