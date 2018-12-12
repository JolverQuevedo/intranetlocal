<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<%cliente = request.QueryString("cli")%>
<%estilo  = request.querystring("cod")%>
<head>
	<title>FICHA ESTILO</title>
</head>
<body style="margin-top:0" onafterprint="return window_onafterprint()" onbeforeprint="return window_onbeforeprint()">
<table cellpadding="2" cellspacing="1" border="1" bordecolorlight="<%=application("color2")%>" bordercolordark="<%=application("color2")%>"
bgcolor="<%=application("color2")%>" bordercolor="<%=application("color2")%>" align="center">
<tr>
	
	<td align= CENTER valign="middle" class="TALASBLUE" bgcolor="orange" bordercolordark="<%=application("borde")%>" bordercolorlight="<%=application("borde")%>" >
          <%cad = "select nombre from cliente where codigo= '"&cliente&"'"
          rs.open  cad, cnn 
          '  response.write(cad)
          %>
          CLIENTE : <%=trim(rs("nombre"))%> --> Estilo: <%=estilo %>
        <%rs.close %>
	</td>
	
</TR>    

</table>

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
         
		    <input name="ART" type="TEXT" class="DATOSGRANDE" id ="ART" maxlength="20" width="100" value="<%=request.querystring("art")%>" /></td>
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
    	<td colspan="6"><textarea name="OBS" cols="1000" rows="2" class="DATOSgrande" id="OBS" ></textarea> </td>
    </tr>
    
	<tr>
	    <td colspan ="7" align="center" width="100%">
	    <img src="../bake/RECUPERAFOTOESTILO.ASP?CLI=<%=CLIENTE%>&ID=<%=REQUEST.QUERYSTRING("cod")%>" width="500" /></td>	    
    </tr>
  </table>	
<center>
<br />
<img src="../imagenes/print.gif" style="cursor:pointer" onClick="window.print();" id="ppp" name="ppp"/>

</center>
<script type="text/jscript" language="jscript">
//document.all.OBS.value=window.opener.OBS
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

function window_onafterprint() {
    ppp.style.display = 'block'
}
function window_onbeforeprint() {
    ppp.style.display = 'none'
}
</script>
</body>
</html>
