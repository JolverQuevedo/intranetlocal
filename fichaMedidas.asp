<%@ Language=VBScript %>
<%  Response.Buffer = false %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	TITULO = "DETALLE DE MEDIDAS DEL GRUPO: "
%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<script ID=clientEventHandlersJS LANGUAGE=javascript>


</script>
<%sp =  left(request.QueryString("spe"),10)
  vr = right(request.QueryString("spe"),3)
CLI = REQUEST.QUERYSTRING("CLI")
TEM = REQUEST.QUERYSTRING("Tmp")
EST = REQUEST.QUERYSTRING("EST")


CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")
CAD = "SELECT * FROM CLIENTE_TEMP_EST_TALLA WHERE CLI= '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"' "
'response.write(cad)
'response.write("<BR>")
RS.OPEN CAD,CNN
%>
<form id="thisForm" method="post" action="">
<table  cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center"> 
    <td><img src="imagenes/disk.gif" style="cursor:hand;" onclick='GRABA()'>
   &nbsp;<img src="imagenes/version.jpg" style="cursor:hand;" onclick='GRABA()'></td>
		<td align="center" width="80%"><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>Ficha Medidas Spec N&ordm; &nbsp;&nbsp;&nbsp; <%=sp%>-<%=vr%>
        <input type="text" value="<%=cli%>" id="cli" style="display:none" />
        <input type="text" value="<%=est%>" id="est" style="display:none" />
        <input type="text" value="<%=tem%>" id="tmp" style="display:none" />
	</td>
     <td><img src="imagenes/print.gif" style="cursor:hand;" onclick='printea()'></td>
     <td><img src="imagenes/reload.jpg" style="cursor:hand;" onclick='location.reload()'></td>
    </tr>
	<tr>
    	<td style="background-color:Red; height:1px; font-size:xx-small" colspan="5"></td>
	</tr>
</table>	

<TABLE width="100%" border="0" id="SERV" name="SERV">
<%cont = 0%>
<%IF RS.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY tallas REGISTRADAS para su seleccion.... 

</center>
<br />
<%else%>
<%rs.movefirst%>
	<tr bgcolor='<%=application("barra")%>'>
        <td width="4%" class="titulito" align="center" colspan="3">Medida</td>	
        <td width="1%" class="titulito" align="center" colspan="1">TOL +/-</td>	
        
        	
		<%for i = 0 to 29 %>
        <%if len(trim(rs.fields.item(i+3)))> 0 then %>
            <td class="TITULITO" align="center"><%=rs.fields.item(i+3)%></td>
        <%else%>
            <% maxi= i
            exit for%>
        <%end if%>
		<%next%>
	</tr>		
    <% cad = "select * from view_spec_medidas where spec= '"&sp&"' and ver = '"&vr&"' order by orden, lin "
      '  response.Write(cad)
        rs.close
        rs.open cad, cnn
        if rs.recordcount > 0 then rs.movefirst
    %>
    <%do while not rs.eof %>
        <%GRUPO = RS("GRUPO") %>
        <tr>
            <td colspan='<%=i+3%>' class="TEXTOred"><%=trim(rs("desgru"))%></td> 
        </tr>
        <%DO WHILE NOT RS.EOF AND RS("GRUPO") = GRUPO %>
            <tr>
               <td><input id="gru<%=cont%>" name="gru<%=cont%>" value='<%=trim(rs("grupo"))%>'  type="hidden" class="TEXTONAVYREADONLY">
                   <input id="med<%=cont%>" name="med<%=cont%>" value='<%=trim(rs("medida"))%>'  type="hidden" class="TEXTONAVYREADONLY">
                   <input id="ord<%=cont%>" name="ord<%=cont%>" value='<%=trim(rs("orden"))%>'  type="hidden" class="TEXTONAVYREADONLY">
                   <input id="lin<%=cont%>" name="lin<%=cont%>" value='<%=trim(rs("LIN"))%>'  type="hidden" class="TEXTONAVYREADONLY">
               </td> 

               <td><span  class="TEXTONAVYREADONLY"><%=trim(rs("grupo"))%>-<%=trim(rs("medida"))%></span></td> 
               <td><span  class="TEXTONAVYREADONLY"><%=trim(rs("desmed"))%></span></td> 
               <td><input id="tol<%=cont%>" name="tol<%=cont%>" value='<%=trim(rs("tolera"))%>' type="text" maxlength="2" class="TEXTOminibbDER" onfocus="seleccionar(this)"></td> 

		        <%for j=0 to i-1%>
                    <td width="2%" align="center">
                       <input type="text"  id="m<%=j%>c<%=cont%>" name="m<%=j%>c<%=cont%>" maxlength="8" class="TEXTOminibbDER" 
                       value="<%=rs.fields.item(j+9)%>" onfocus="seleccionar(this)" onchange="this.value =toMED(this.value) "> 
                    </td>
                <%next %>
	        </tr>
            <%cont = cont + 1%>
            <%rs.movenext%>
             <%IF RS.EOF THEN EXIT DO %>
        <%LOOP%>
        <%IF RS.EOF THEN EXIT DO %>
    <%loop%>
</table>	
<%end if%>
<input id="cnt" name="cnt" value="<%=cont-1%>" type="hidden"/>
<input id="tal" name="tal" value="<%=i-1%>" type="hidden"/>
<%
set rs= nothing
set cnn=nothing
%>
</form>
<script>
    tope = parseInt('<%=i%>', 10)
    lin = parseInt('<%=cont%>', 10)
    //alert(lin)
 
    function GRABA() {	//alert(thisForm.CONTADOR.value = pos)
 /*   aGru = new Array()
    aMed = new Array()
    aVal = new Array()
    aTol = new Array()
    aOrd = new Array()
    aLin = new Array()
    z = 0
    for (a = 0; a < lin; a++) {
        aGru[z] = eval("document.all.gru" + a + ".value")
        aMed[z] = eval("document.all.med" + a + ".value")
        aTol[z] = eval("document.all.tol" + a + ".value")
        aOrd[z] = eval("document.all.ord" + a + ".value")
        aLin[z] = eval("document.all.lin" + a + ".value")
        for (b = 0; b < tope; b++) {
            aVal[z++] = eval("document.all.m" + b + "c"+ a + ".value")
            aGru[z] = ''
            aMed[z] = ''
            aTol[z] = ''
            aOrd[z] = ''
            aLin[z] = ''
        }
    }
    cad = "comun/insermedida_spec.ASP?sp=" + '<%=sp%>' + '&vr=' + '<%=vr%>' + '&gru=' + aGru
    cad += '&med=' + aMed + '&tol=' + aTol + '&val=' + aVal
    cad += '&lin=' + aLin + '&ord=' + aOrd + '&col=' + tope
    cad += '&cli=' + '<%=cli%>'
    cad += '&tmp=' + '<%=tem%>'
    cad += '&est=' + '<%=est%>'
   */ 
   // window.location.replace (cad)
    thisForm.action = "comun/insermedida_spec.ASP"
    thisForm.submit()
    }

    function printea() {
        cad = 'reportes/prn_spec.aSP'

        window.open(cad, '')
        kad = 'reportes/prn_grupoSPEC.asp'
     // window.open()
    return true
    }
</script>
</BODY>
</HTML>
