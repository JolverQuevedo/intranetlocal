<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="estilos1.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>

<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<body>
<form name="thisForm" METHOD="post"  >
<p class="tituloGRANDEVERDE">&nbsp;Opciones para emitir Orden de Compra</p>

             <table	align="center" width="100%" cellpadding="1" cellspacing="0"  bgcolor="WHITE" border="1" >
              <tr valign="middle"> 
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>Tipo OC </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>Transaccion </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>CODIGO </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>TIPO OC </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>MOVIMIENTO</b></font> </td> 
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>ALM ORIGEN</b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>ALM DESTINO</b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>ALM ANTERIOR</b></font> </td> 
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>COD. SERVICIO</b></font> </td> 
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>ENTREGA</b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>RECIBE </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>L1 </b></font> </td>
              <td bgcolor="<%=(Application("barra"))%>" align="center"> <font face="arial" size="1" color="#000066"><b>L2</b></font> </td>
              <td rowspan="2" align="center" ><input id="OK" name="OK" class="tituloGRANDEVERDE" type="button" value="OK" onclick="oc()"></td>
            </tr>
            <tr>
                <td width="10%"><select id="TIPOC" name="TIPOC" class="DATOS" onchange="cambia()">
                    <option value=''></option>
                    <option value="C">Producto Final</option>
                    <option value="S">Servicio de Transformaci&oacute;n</option>
                </select>
                </td>
                <td width="10%" id="Td1" >
                <%TIP = REQUEST.QueryString("TIP")
                'response.write(tip)
                if len(trim(ucase(tip))) = 0 then Tip = "C"
                CAD = "SELECT * FROM MATRIZ_COMPRA_TELA WHERE TIPO = '"&tip&"'" 
               'response.write(cad)
                 rs.open cad, cnn 
                 if rs.recordcount > 0 then rs.movefirst
                %>
                    <select id="FINAL" name="FINAL" class="DATOS"  style="display:block" onchange="rellena()">
                        <option value=""></option>
                        <%do while not rs.eof %>
                            <option value="<%=rs("codigo")%>"><%=trim(rs("movim"))%></option>
                            <%rs.movenext%> 
                        <%LOOP%>
                    </select>
                </td>
               <td><input type="text" style="text-align:center" id="COD" name="COD" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="TIP" name="TIP" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="MOV" name="MOV" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="ORI" name="ORI" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="DES" name="DES" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="OLD" name="OLD" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="SER" name="SER" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="ENT" name="ENT" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="REC" name="REC" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="LT1" name="LT1" class="DATOS" readonly tabindex="-1" /></td>
               <td><input type="text" style="text-align:center" id="LT2" name="LT2" class="DATOS" readonly tabindex="-1" /></td>
           </tr>
          </table>
   


<iframe id="AXN" name="AXN" src="blanco.htm" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0" style="display:none"></iframe>
<iframe id="Iframe1" name="Iframe1" src="" width="100%" scrolling="no" height="2900" frameborder="0" ></iframe>
<script language="jscript" type="text/jscript">
//    alert()
    CN = parseInt(parent.window.document.all.CNT.value, 10)    // contador de lineas de detalle
    t  = parseInt(parent.window.document.all.t.value,10)    // contador de tela acabada
    c  = parseInt(parent.window.document.all.c.value,10)    // contador de tela cruda
    h  = parseInt(parent.window.document.all.h.value,10)    // contador de hilado
 
    tip = trim('<%=request.querystring("tip")%>')
  //alert(tip)
    if (tip.length > 0) {
        if (trim(tip) == 'C') {
            document.all.TIPOC.value = 'C'
            document.all.TIPOC.selectedIndex = 1
        }
        else {
            document.all.TIPOC.value = 'S'
            document.all.TIPOC.selectedIndex = 2
        }
    }

function cambia() {
  cad =  'opcOC.ASP?TIP=' + trim(document.all.TIPOC.value)
  //  alert(cad)
window.location.replace =cad
return true
}

function rellena() {
    //alert()
    document.all.AXN.src = 'bake/bakemovOC.asp?pos=' + trim(document.all.FINAL.value)
    
    return true
}

function oc() {
    if (trim(document.all.MOV.value) == '') {
        alert("favor seleccionar algun movimiento")
        return false;
        }

    aCo1 = new Array()
    aQt1 = new Array()
    aKg1 = new Array()
    aDs1 = new Array()
    aCo2 = new Array()
    aQt2 = new Array()
    aKg2 = new Array()
    aDs2 = new Array()
    
        switch (thisForm.LT2.value) {
            case 'h':
                cod2 = "hc";
                can2 = "hq";
                kil2 = "hk";
                max2 = h;
                des2 = "hd";
                break;
            case 'c':
                cod2 = "cc";
                can2 = "cq";
                kil2 = "ck";
                max2 = c;
                des2 = "cd";
                break;
            case 't':
                cod2 = "tc";
                can2 = "tq";
                kil2 = "tk";
                max2 = t;
                des2 = "td";
                break;
        }
        for (W = 0; W <= max2; W++) 
        {   aCo2[W] = trim(window.parent.document.getElementById(cod2 + W).innerText)
            aQt2[W] = removecommas(window.parent.document.getElementById(can2 + W).innerText)
            aKg2[W] = removecommas(window.parent.document.getElementById(kil2 + W).innerText)
            aDs2[W] = removecommas(window.parent.document.getElementById(des2 + W).innerText)
            //alert(aCo2[W])
        }


        if (document.all.TIPOC.value == 'S') {
        // servicio tiene origen ademas de destino
        // lo que tomo es el codigo de la explosion 
       
        switch (thisForm.LT1.value) {
            case 'h':
                cod1 = "hc";
                can1 = "hq";
                kil1 = "hk";
                max1 = h;
                des1 = "hd"
                break;
            case 'c':
                cod1 = "cc";
                can1 = "cq";
                kil1 = "ck";
                max1 = c;
                des1 = "cd";
                break;
            case 't':
                cod1 = "tc";
                can1 = "tq";
                kil1 = "tk";
                max1 = t;
                des1 = "td";
                break;
        }
        for (i = 0; i <= max1; i++) {
            aCo1[i] = trim(window.parent.document.getElementById(cod1 + i).innerText)
            aQt1[i] = removecommas(window.parent.document.getElementById(can1 + i).innerText)
            aKg1[i] = removecommas(window.parent.document.getElementById(kil1 + i).innerText)
            aDs1[i] = removecommas(window.parent.document.getElementById(des1 + i).innerText)
        }

    }
cad = 'showdata.asp'
cad += '?COD=' + ltrim(thisForm.COD.value);
cad += '&TIP=' + ltrim(thisForm.TIP.value);
cad += '&MOV=' + ltrim(thisForm.MOV.value);
cad += '&ORI=' + ltrim(thisForm.ORI.value);
cad += '&DES=' + ltrim(thisForm.DES.value);
cad += '&OLD=' + ltrim(thisForm.OLD.value);
cad += '&SER=' + ltrim(thisForm.SER.value);
cad += '&ENT=' + ltrim(thisForm.ENT.value);
cad += '&REC=' + ltrim(thisForm.REC.value);
cad += '&LT1=' + ltrim(thisForm.LT1.value);
cad += '&LT2=' + ltrim(thisForm.LT2.value);
cad += '&aC1=' + aCo1
cad += '&aQ1=' + aQt1
cad += '&aK1=' + aKg1
cad += '&aD1=' + aDs1
cad += '&aC2=' + aCo2
cad += '&aQ2=' + aQt2
cad += '&aK2=' + aKg2
cad += '&aD2=' + aDs2
cad += '&cnt=' + parseInt(CN ,10)

document.all.Iframe1.style.display = 'block'

//alert(cad)
document.all.Iframe1.src = cad
//autofitIframe(document.all.Iframe1)

}
</script>
</body>
</HTML>
