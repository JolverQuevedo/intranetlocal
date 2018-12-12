<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/comunqry.ASP"-->
<style type="text/css">
html, body{
  width:100%;
  height:100%;
  overflow:hidden;
  margin:0px;   
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    function autoResize(iframe) {
        $(iframe).height($(iframe).contents().find('html').height());
    }
</script>

<script type="text/jscript" language="jscript">
    var aCod = Array()
    function calcHeight(obj) {
        //find the height of the internal page
        var the_height =
    document.getElementById(obj).contentWindow.
      document.body.scrollHeight +5;
        //change the height of the iframe
        document.getElementById(obj).height = 0
        document.getElementById(obj).height =
      the_height;
    }
    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
oldrow = 1
oldframe= 1
</script>
<%oc = Request.QueryString("oc")
ruc = Request.QueryString("ruc")  %>
<body style="margin-top:0; onload="document.getElementById('OC').focus();">

<form id="thisForm" method="post" name="thisForm" action="">
<%
     CAD =      " Select a.c5_calma as alm, oc_ccodref AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDEN,                    " & _
                " OC_NPREUN2 AS UNI_OC, (OC_NCANORD*OC_NPREUN2) AS TOT_OC,  C5_CCODMOV,c5_ntipcam,                                              " & _
                " CANTI = case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END,                                      " & _
                " ltrim(rtrim(c6_ctd)) + ' - '+ ltrim(rtrim(c6_cnumdoc)) as DOC, (C6_NPREUNi) AS UNI_PE,                                        " & _
                " (C6_NPREUNi) * case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END AS TOT_PE,                     " & _
                " CONVERT(VARCHAR, C5_DFECDOC, 103) AS FECHA, a.C5_CCODMON,   C6_CITEMOC,                                                       " & _
                " (OC_NCANORD*OC_NPREUN2)-(C6_NPREUNI* case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID*-1 END) AS SALDO " & _
                " From RSFACCAR..CO0001MOVD AS CC                                                                                               " & _
                "  inner join  RSFACCAR..al0001movc AS A  on OC_CNUMORD = c5_cnumord                                                            " & _
                " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                   " & _
                " and OC_CITEM = C6_CITEMOC                                                                                                     " & _
                " Where OC_CNUMORD='"&OC&"' AND OC_CCODPRO='"&RUC&"' AND OC_NCANORD > 0 and c5_ccodmov <> 'CO'                           " & _
                " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                                                                              " 
              '  response.write(cad)
                rs.open cad,cnn
    
     %>
<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="tituloGRANDEorange" style="text-align:left">Documentos de Almacen : </td></tr>
</table> 
<table width="100%" cellpadding="1" cellspacing="1" border="0" id="TABLA" name="TABLA" style="background-color:#f0f0f0">
        <tr class="TEXTO7" bgcolor='<%=Application("color1")%>' >
            <td width="8%" align="center">ALM</td>
            <td width="8%" align="center">CODIGO</td>
            <td width="30%" align="left">DESCRIPCION</td>
            <td width="1%"  align="center">UNI</td>
            <td width="8%"  align="center">ORDENADO</td>

            <td width="8%"  align="center">UNIT OC</td>
            <td width="10%"  align="center">TOT OC</td>
            <td width="10%" align="right">MOV</td>
            <td width="10%" align="right">DOC</td>
            <td width="8%" align="right">CANT</td>
            <td width="8%" align="right">UNIT DOC</td>
            <td width="8%"  align="center">TOT DOC</td>
            <td width="8%" align="center">FECHA</td>
            <td width="8%"  align="center">SALDO</td>
            <td width="1%" align="center">ITM</td>
            <td style="display:none"></td>
        </tr>
        <tr  class="TEXTO7" ><td colspan="15"  bgcolor='<%=Application("color1")%>' ><hr /></td></tr>
        <% IF RS.RECORDCOUNT >0 THEN 
            RS.MOVEFIRST
            mone= rs("c5_ccodmon") 
        else
            mone = ""
            response.end
        end if%>
        <%cnt = 1%>
        <%tot1 = 0%>
        <%do while not rs.eof%>
         <tr  class="DESCRIPTORnegro"  style="cursor:pointer" id="fila<%=cnt%>" valign="top"  
         <% IF cnt mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
         ondblclick="liqui('<%=cnt%>')" onmouseover="dd('<%=(cnt)%>')" onmouseout="dd('<%=(cnt)%>')">
            <td id="a<%=cnt%>" align="center"><%=RS("alm") %></td>
            <td id="b<%=cnt%>" align="center"><%=RS("COD") %></td>
            <td id="c<%=cnt%>" align="left"><%=UCASE(RS("DESCRI"))%></td>
            <td id="d<%=cnt%>" align="center"><%=UCASE(RS("UNI"))%></td>
            <td id="e<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN")),4,,,TRUE)%></td>
            <td id="f<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_oc")),4,,,TRUE)%></td>
            <td id="g<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_oc")),4,,,TRUE)%></td>
            <td id="h<%=cnt%>" align="center"><%=UCASE(RS("C5_CCODMOV"))%></td>
            <td id="i<%=cnt%>" align="center"><%=UCASE(RS("doc"))%></td>
            <td id="j<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("canti")),4,,,TRUE)%></td>
            <td id="k<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_pe")),4,,,TRUE)%></td>
            <td id="l<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_pe")),4,,,TRUE)%></td>
            <td id="m<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATdatetime((RS("fecha")),2)%></td>
            <td id="n<%=cnt%>" align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("saldo")),2,,,TRUE)%></td>
            <td id="o<%=cnt%>" align="right" style="padding-right:10px;"><%=RS("c6_citemoc")%></td> 
            <td id="p<%=cnt%>" align="right" style="padding-right:10px;display:none"><%=RS("c5_ntipcam")%></td> 
            </tr>
            <tr>
                <td colspan="15">
                    <iframe id="ame<%=cnt%>" width="100%" height="0" marginheight="0" frameborder="0" border="0" scrolling="auto" style="overflow: hidden" onload="autoResize(this);" ></iframe>
                </td>
            </tr>



            <%tot1 = tot1 + CDBL(RS("tot_pe"))  %>
            <%rs.movenext%>
            <%cnt = cnt + 1%>
        <%loop %>
        <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("fondito"))%>' style="padding-right:10px;">
            <td colspan ="11"  align="right" style="padding-right:10px;">Total segun documentos</td><td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot1,2,,,TRUE)%></b></td><td colspan="3">&nbsp;</td>
        </tr>
        </table>
       

</form>  
<script language="jscript" type="text/jscript">
    dd2('1');
sit = trim(parent.window.document.all.sit.value)

function liqui(pos) {
// priemro oculto cualquier frame que haya estado abierto
    eval("document.all.ame" + oldframe + ".style.display='none'")
    
    pos = parseInt(pos,10)
    doc = eval("document.all.i" + pos + ".innerText")
    // no funciona porque el onmouseover tiene prioridad!!!! :(
    //eval("document.all.fila" + pos + ".style.backgroundColor='red'")
    //alert(doc)
    // capturo el numero de parte para poder buscar su detalle
    doc = Right(trim(doc),11)
    
    cad = 'comun/liquiOCSRV.asp?oc=' + '<%=oc%>' + '&pe=' + doc + '&pos=' + pos
    cad += '&lin=' + eval("document.all.o" + pos + ".innerText")
    cad += '&fec=' + eval("document.all.m" + pos + ".innerText")
    cad += '&cod=' + eval("document.all.b" + pos + ".innerText")
    cad += '&qty=' + eval("document.all.l" + pos + ".innerText")
    cad += '&mon=' + parent.document.all.MON.value
    eval("document.all.ame" + pos + ".style.display='block'")
    //alert(cad)

    eval("document.all.ame" + pos + ".src= cad")

    oldframe=pos
}
</script>
</body>
</html>
