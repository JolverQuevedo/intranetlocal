<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>

<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<%
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
ofi = request.QUERYSTRING("ofi")

  ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAOFI '"&ofi&"' , ''  "     
	KAD =  " exec FICHAOFI_ADIC '"&ofi&"' , ''  " 
    ' response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO ="OFI # : " + COD  +" -> " + ucase(trim(DESCLI))
        RS2.OPEN KAD, CNN
	END IF

%>
<body >
<form id="thisForm" method="post" name="thisForm" action="">

<table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
	<tr><td align="center" class="talasblue">EXPLOSION DE TELAS OFI --> <%=OFI%></td></tr>
</table> 
     

<hr />


<table width="100%" cellspacing="0" border="0" cellpadding="1">

        <tr valign="top">
            <td width="10%" class="TITULITO">Estilo Cliente:</td>
            <td class="TEXTOBLUE" width="20%"><%=TRIM(rs("ESTCLI")) %> </td>
            <td class="TITULITO">Estilo:</td>
            <td class="TEXTOBLUE" colspan="2" width="60%"><%=TRIM(rs("CODEST"))%> - <%=TRIM(rs("DESEST")) %></td>
        </td>
        </tr>

        <tr class="TITULITO" >
            <td class="titulito">Temporada:</td>
            <td class="TEXTOBLUE"><%=TRIM(rs2("codtem"))%> - <%=TRIM(rs2("destem"))%></td>
            <td class="TITULITO">Genero:</td>
            <td class="TEXTOBLUE" ><%=TRIM(rs("CGEN"))%> - <%=TRIM(rs("DGEN"))%></td>
        </tr>
        <%rs2.close%>
    <tr class="TITULITO" >
            <td class="TITULITO"  >Cantidad:</td>
            <td class="TEXTOBLUE" ><%=formatnumber(rs("CANT"),0,,,true)%></td>  
            <td class="titulito">Tipo Prenda:</td>
            <td class="TEXTOBLUE"><%=TRIM(rs("TPRE"))%> - <%=TRIM(rs("DPRE"))%></td>             
        </tr>
    </table>   
<hr />


<%cad = "exec  SP_PRE_explosion_telas '"&ofi&"' " 
'response.write(cad)
RS.CLOSE
rs.open cad, cnn
IF RS.RECORDCOUNT > 0 THEN 
    RS.MOVEFIRST 
else  %>  

<span class="talasrojo">OFI --> <%=OFI%> sin Hoja de combinaciones</span>
<%
response.end    
end if    %>
<%u=1%>
<%etc = rs("codetc") %>
<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%" id="TABLA" name="TABLA">
<tr class="TEXTOBLUE">
    <td WIDTH="5%" >PO</td>  
    <td WIDTH="10%" >COMBO</td>
    <td WIDTH="5%" >CRUDO</td>
    <td WIDTH="10%" >TIPTELA</td>
    <td WIDTH="20%" >OBS</td>
    <td WIDTH="5%" >QTY</td>
    <td WIDTH="5%" >KGS</td>
    <td WIDTH="10%" >COLOR PZA</td>
    <td WIDTH="1%" style="display:block">UBI</td>
    <td WIDTH="1%" style="display:block">ID</td>
   
    <td WIDTH="1%" style="display:none">H1</td> 
    <td WIDTH="1%" style="display:none">P1</td> 
    <td WIDTH="1%" style="display:none">K1</td> 
    <td WIDTH="1%" style="display:none">H2</td> 
    <td WIDTH="1%" style="display:none">P2</td> 
    <td WIDTH="1%" style="display:none">K2</td> 
    <td WIDTH="1%" style="display:none">H3</td> 
    <td WIDTH="1%" style="display:none">P3</td> 
    <td WIDTH="1%" style="display:none">K3</td> 
    <td WIDTH="1%" style="display:none">H4</td> 
    <td WIDTH="1%" style="display:none">P4</td> 
    <td WIDTH="1%" style="display:none">K4</td> 
    <td WIDTH="1%" style="display:none">H5</td> 
    <td WIDTH="1%" style="display:none">P5</td> 
    <td WIDTH="1%" style="display:none">K5</td> 
    <td WIDTH="1%" style="display:none">H6</td> 
    <td WIDTH="1%" style="display:none">P6</td> 
    <td WIDTH="1%" style="display:none">K6</td> 
     <td WIDTH="30%" >ARTICULO REAL</td>
</tr>
   
<%DO WHILE NOT RS.EOF %>   
  <tr  id="LIN<%=U%>" name="LIN<%=U%>" class="TEXTO4" style="text-align:left">
      <%ubi = trim(rs("ubi")) %>      
      <%id= trim(rs("id")) %>
      <td><input readonly tabindex="-1" class="texto4" id="po<%=u%>"   name="po<%=u%>"   value="<%=TRIM(RS("PO"))%>"     </td>  
      <td><input readonly tabindex="-1" class="texto4" id="comb<%=u%>" name="comb<%=u%>" value="<%=TRIM(RS("COMBO"))%>"  </td>    
      <td><input readonly tabindex="-1" class="texto4" id="tel<%=u%>"  name="tel<%=u%>"  value="<%=TRIM(RS("TELA"))%>"   </td>    
      <td><input readonly tabindex="-1" class="texto4" id="fam<%=u%>"  name="fam<%=u%>"  value="<%=TRIM(RS("FAMTEL"))%>" </td>    
      <td><textarea readonly tabindex="-1"  class="texto4" id="obs<%=u%>" name="obs<%=u%>" style="overflow:hidden"><%=TRIM(RS("OBS"))%></textarea>    </td>    
      <td><input readonly tabindex="-1" class="texto4" id="qty<%=u%>" name="qty<%=u%>"  style="text-align:right" value="<%=FORMATNUMBER(CDBL(RS("QTY")),0,,,TRUE)%>" /></td>    
      <td><input readonly tabindex="-1" class="texto4" id="kgs<%=u%>" name="kgs<%=u%>"  style="text-align:right" value="<%=FORMATNUMBER(CDBL(RS("KILOS")),3,,,TRUE)%>" /></td>    
      <td><input readonly tabindex="-1" class="texto4" id="col<%=u%>" name="col<%=u%>" value="<%=TRIM(RS("COLOR"))%>" /></td> 
      <td><input readonly tabindex="-1" class="texto4" id="ubi<%=u%>" name="ubi<%=u%>" value="<%=TRIM(RS("ubi"))%>" /></td> 
      <td><input readonly tabindex="-1" class="texto4" id="idd<%=u%>" name="idd<%=u%>" value="<%=TRIM(RS("id"))%>" /></td>  
      <td style="display:none"><input id="h1<%=u%>" name="h1<%=u%>" value="<%=TRIM(RS("h1"))%>" /></td>  
      <td style="display:none"><input id="p1<%=u%>" name="p1<%=u%>" value="<%=TRIM(RS("p1"))%>" /></td>  
      <td style="display:none"><input id="k1<%=u%>" name="k1<%=u%>" value="<%=TRIM(RS("k1"))%>" /></td>  
      <td style="display:none"><input id="h2<%=u%>" name="h2<%=u%>" value="<%=TRIM(RS("h2"))%>" /></td>  
      <td style="display:none"><input id="p2<%=u%>" name="p2<%=u%>" value="<%=TRIM(RS("p2"))%>" /></td>  
      <td style="display:none"><input id="k2<%=u%>" name="k2<%=u%>" value="<%=TRIM(RS("k2"))%>" /></td>  
      <td style="display:none"><input id="h3<%=u%>" name="h3<%=u%>" value="<%=TRIM(RS("h3"))%>" /></td>  
      <td style="display:none"><input id="p3<%=u%>" name="p3<%=u%>" value="<%=TRIM(RS("p3"))%>" /></td>  
      <td style="display:none"><input id="k3<%=u%>" name="k3<%=u%>" value="<%=TRIM(RS("k3"))%>" /></td>  
      <td style="display:none"><input id="h4<%=u%>" name="h4<%=u%>" value="<%=TRIM(RS("h4"))%>" /></td>   
      <td style="display:none"><input id="p4<%=u%>" name="p4<%=u%>" value="<%=TRIM(RS("p4"))%>" /></td>  
      <td style="display:none"><input id="k4<%=u%>" name="k4<%=u%>" value="<%=TRIM(RS("k4"))%>" /></td>  
      <td style="display:none"><input id="h5<%=u%>" name="h5<%=u%>" value="<%=TRIM(RS("h5"))%>" /></td>  
      <td style="display:none"><input id="p5<%=u%>" name="p5<%=u%>" value="<%=TRIM(RS("p5"))%>" /></td>  
      <td style="display:none"><input id="k5<%=u%>" name="k5<%=u%>" value="<%=TRIM(RS("k5"))%>" /></td>  
      <td style="display:none"><input id="h6<%=u%>" name="h6<%=u%>" value="<%=TRIM(RS("h6"))%>" /></td>  
      <td style="display:none"><input id="p6<%=u%>" name="p6<%=u%>" value="<%=TRIM(RS("p6"))%>" /></td>  
      <td style="display:none"><input id="k6<%=u%>" name="k6<%=u%>" value="<%=TRIM(RS("k6"))%>" /></td>  
      <td>
        <select id="art<%=u%>" name= "art<%=u%>" class="TEXTO5" onchange="this.className='TEXTO5'">   
            <%OPC=0 %>   
            <%DO WHILE NOT RS.EOF AND TRIM(RS("UBI"))= TRIM (UBI) AND TRIM(RS("ID"))= TRIM(ID) %>
                <option value ='<%=TRIM(RS("AR_CCODIGO"))%>'><%=TRIM(RS("AR_CDESCRI"))%></option> 
                <%OPC=  OPC + 1 %>
                <%RS.MOVENEXT%>
                <%IF RS.EOF THEN EXIT DO %>   
            <%LOOP %>
        </select>
        <script language="jscript" type="text/jscript">
            op = parseInt('<%=opc%>', 10)
            u = '<%=u%>'
            if (op > 1) {   document.getElementById("art" + u ).selectedIndex  = -1     }
        </script>
      </td>  
       
  </tr>
    <%U = U + 1 %>
    <%IF RS.EOF THEN EXIT DO %>     
    <%'IF NOT RS.EOF AND TRIM(RS("UBI"))<> TRIM (UBI) AND TRIM(RS("ID"))<> TRIM(ID) THEN RS.MOVENEXT%>
    
<%LOOP%>
<tr>
    <td colspan="16" align="right"><input type="button" value= "  " onclick="ENVIO()" class="botonok2">&nbsp;&nbsp;&nbsp;</td>
   <!-- <td colspan="8" align="left">&nbsp;&nbsp;<input type="button" value= "  " onclick="prn()"   class="botonok3"></td> -->
</tr> 
</table>
</form>  
<iframe id="head" name="head" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
<iframe id="cuerpo" name="cuerpo" src="" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>
</body>
<script language="jscript" type="text/jscript">

var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
function ENVIO() {
    TOPE = parseInt('<%=u%>',10)-1
    
    // revisa si todas las lineas tienen TELA-COLOR
    for (d = 1; d < TOPE ; d++) 
    {   if (document.getElementById("art" + d ).selectedIndex  == -1  ) {
        alert("Falta Asignar Tela-Color")
        document.getElementById("art" + d).className= 'datosrojo'
                seleccionar(document.getElementById("art" + d ))
                return false;    
        } 
    }

    thisForm.action = 'comun/inserEXPLOtela.asp?ofi='+ '<%=ofi%>' + '&maxi='+ TOPE + '&etc=' + '<%=etc%>'
    //alert()
    thisForm.submit()

return true
}


</script>

</html>
