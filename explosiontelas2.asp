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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
    <script type="text/javascript" src="./COMUN/jquery.js"></script>
</head>
 <% IF  request.QueryString("EXCEL") = "1" THEN
  archivo = "c:\temp\TNTexcel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
  END IF

 %>
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
' revisa si tiene explosion para crear o para mostrary lo redirecciona
rs.open "select ofi from explosion_tela where ofi = '"&ofi&"'" , cnn
if rs.recordcount <= 0 then response.redirect("explosiontelasNEW.asp?ofi="+ OFi)
rs.close


  ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAOFI '"&ofi&"' , ''  "     
	KAD =  " exec FICHAOFI_ADIC '"&ofi&"' , ''  " 
    ' response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
        esttt = rs("codest")
        cli = rs("cli")
		TITULO ="OFI # : " + COD  +" -> " + ucase(trim(DESCLI))
        RS2.OPEN KAD, CNN
	END IF

%>
<body >
<form id="thisForm" method="post" name="thisForm" action="">

<table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
	<tr>
        <td align="center" class="talasblue" width="90%">EXPLOSION DE TELAS OFI --> <%=OFI%></td>
        <td align="right"><input type="button" class="botonok3" onclick="EXCEL()"/></td>
    </tr>
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
        <%temp=TRIM(rs2("codtem"))%>
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
<table width="100%" cellspacing="0" border="1" cellpadding="0">
   <tr>
    <td colspan="2" class="tituloGRANDEgris3">Resumen para Planeamiento</td>
   </tr>
 <!--   Hay QUE ver en la tabla de ofis si tiene marca de EXP_TEL para calcular las mermas de hilo y tejido
        sinó todo queda tal cual -->    


    <tr valign="top">
        <td >
                <%cad = "EXEC SP_RESUMEN_HILADO_OFI '"&ofi&"' " 
                'response.write(cad)
                RS.CLOSE
                rs.open cad, cnn
                IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
                <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" >
                  <tr><td height="40px;" colspan="5" class="tituloMODELADOR">Resumen de Materia Prima&nbsp;</td></tr>
                    <tr class="tituloGRANDEVERDE">
                        <td>PO</td>  
                        <td>HILADO</td>
                        <td>DESCRIPCION</td>
                        <td>&nbsp;</td>
                        <td>KGS</td>
                    </tr>
                    <%tot1=0 
                    tot2 = 0 %>
                    <%DO WHILE NOT RS.EOF %>
                        <tr class="TEXTO4" >
                            <td><%=TRIM(RS("PO"))%></td>
                            <td><%=TRIM(RS("H1"))%></td>
                            <td><%=TRIM(RS("DESCRIPCION"))%></td>
                            <td style="text-align:right">&nbsp;</td>
                            <td style="text-align:right"><%=FORMATNUMBER(CDBL(RS("K1")),3,,,TRUE)%></td>
                            <%tot2= tot2+CDBL(RS("K1")) %>
                        </tr>
                        <%rs.movenext %>
                    <%LOOP %>
                    <tr class="TEXTO4" style="background-color:gainsboro">    
                    <td colspan="4" align="right"><strong>Total: </strong></td>
                    <td style="text-align:right"><%=FORMATNUMBER(TOT2,3,,,TRUE)%></td>
                    </tr>
                    <tr>
                <td height="40px;" colspan="5"  class="tituloMODELADOR">Resumen de Tejido&nbsp;</td>
                </tr>
              </table>
            <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" >
            
            <%cad = "EXEC SP_RESUMEN_CRUDO_OFI '"&ofi&"' " 
            'response.write(cad)
            RS.CLOSE
            rs.open cad, cnn
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
                <tr class="tituloGRANDEVERDE">
                    <td>PO</td>  
                    <td>CRUDO</td>
                    <td>DESCRIPCION</td>
                    <td>UNIDADES</td>
                    <td>KGS</td>
                </tr>
                
                  <%tot1=0 
                    tot2 = 0 %>
                <%DO WHILE NOT RS.EOF %>
                    <tr  class="TEXTO4" >
                        <td><%=TRIM(RS("PO"))%></td>
                        <td><%=TRIM(RS("CRUDO"))%></td>
                        <td><%=TRIM(RS("DESCRIPCION"))%></td>
                         <td style="text-align:right"><%IF CDBL(RS("unid")) > 0 THEN %>          
                                    <%=FORMATNUMBER(CDBL(RS("unid")),0,,,TRUE)%>
                                    <%tot1= tot1+CDBL(RS("unid")) %>
                             <%ELSE%>   &nbsp;
                             <%END IF %>       </td>
                        <td style="text-align:right"><%=FORMATNUMBER(CDBL(RS("KILOS")),3,,,TRUE)%></td>
                          <%tot2= tot2+CDBL(RS("Kilos")) %>

                    </tr>
                    <%rs.movenext %>
                <%LOOP %>
                <tr class="TEXTO4" style="background-color:gainsboro">    
                    <td colspan="3" align="right"><strong>Total: </strong></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT1,0,,,TRUE)%></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT2,3,,,TRUE)%></td>
                </tr>
    </table>
    


    <table  border="0" cellspacing="1" cellpadding="1" align="center" width="100%" >
            <!-- RECTILINEOS -->
              <tr>
                <td height="40px;" colspan="5"  class="tituloMODELADOR">Resumen de Rectilineos Acabado&nbsp;</td>
                </tr>

             <%CAD = "SELECT top 1 T0,T1,T2,T3,T4,T5,T6,T7,T8,T9 FROM [PO-DETA] PD INNER JOIN POS PP ON PP.PO = PD.PO where ofi = '"&OFI&"'"
            'response.write(cad)
            RS.CLOSE
            rs.open cad, cnn
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
                <tr class="tituloGRANDEROJO">
                    <td>PO</td>  
                   
                    <td>CODIGO</td>
                    <td>DESCRIPCION</td>
                     <td>COMBO</td>
                   
                    <%FOR I=0 TO 9 %>
                        
                        <td><%=(TRIM(RS.FIELDS.ITEM(I)))%></td>
                        
                    <%NEXT%>
                     <td>TOT</td>
                     <td>KGS</td>
                </tr>
                <%cad =    " SELECT * FROM VIEW_RECTILINEOS_OFI    " & _
                        " WHERE OFI =  '"&ofi&"' ORDER BY UBI, TELA" 
            'response.write(cad)
            RS.CLOSE
            rs.open cad, cnn
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
                  <%tot1=0 
                    tot2 = 0 %>
                <%DO WHILE NOT RS.EOF %>
                    <tr  class="TEXTO4" >
                        <td><%=TRIM(RS("PO"))%></td>
                        <td><%=TRIM(RS("TELA"))%></td>
                        <td><%=TRIM(RS("DESCRIPCION"))%></td>
                        <td><%=TRIM(RS("COLPZA"))%></td>
                       
                        <%FOR I=5 TO 14 %>
                        <td style="text-align:right"><%IF CDBL(RS.FIELDS.ITEM(I)) > 0 THEN %>          
                                    <%=FORMATNUMBER(CDBL(RS.FIELDS.ITEM(I)),0,,,TRUE)%>
                                    <%tot1= tot1+CDBL(RS.FIELDS.ITEM(I)) %>
                             <%ELSE%>   &nbsp;
                             <%END IF %>  </td>
                        <%NEXT%>
                        <td style="text-align:right"><%=FORMATNUMBER(CDBL(rs("tot_pza")),0,,,TRUE)%></td>
                           <%tot2= tot2+CDBL(RS("Kilos")) %>
                        <td style="text-align:right"><%=FORMATNUMBER(CDBL(RS("KILOS")),3,,,TRUE)%></td>
                    </tr>
                    <%rs.movenext %>
                <%LOOP %>
                <tr class="TEXTO4" style="background-color:gainsboro">    
                    <td colspan="14" align="right"><strong>Total: </strong></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT1,0,,,TRUE)%></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT2,3,,,TRUE)%></td>
                </tr>



            </table>
           
        </td>
        <td >  
            <%cad = "EXEC SP_RESUMEN_tela_color_OFI '"&ofi&"' " 
            'response.write(cad)
            RS.CLOSE
            rs.open cad, cnn
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
            <span>
            <table  border="0" cellspacing="1" cellpadding="1" align="center" >
              <tr><td height="40px;" colspan="5" class="tituloMODELADOR">Resumen de Tela Acabada&nbsp;</td></tr>
                <tr class="tituloGRANDEVERDE">
                    <td>PO</td>  
                    <td>TELA-COLOR</td>
                    <td>DESCRIPCION</td>
                    <td>UNIDADES</td>
                    <td>KGS</td>
                </tr>
                 <%tot1=0 
                    tot2 = 0 
                    po = ""
                    
                 %>
                <%DO WHILE NOT RS.EOF %>
                    <%
                        if po <> TRIM(RS("PO")) then
                            po = po + TRIM(RS("PO"))
                        end if
                        
                     %>
                    <tr  class="TEXTO4" >
                        <td><%=TRIM(RS("PO"))%></td>
                        <td><%=TRIM(RS("TELA"))%></td>
                        <td><%=TRIM(RS("DESCRIPCION"))%></td>
                        <td style="text-align:right"><%IF CDBL(RS("unid")) > 0 THEN %>          
                                    <%=FORMATNUMBER(CDBL(RS("unid")),0,,,TRUE)%>
                                    <%tot1= tot1+CDBL(RS("unid")) %>
                             <%ELSE%>   &nbsp;
                             <%END IF %>       </td>
                        <td style="text-align:right"><%=FORMATNUMBER(CDBL(RS("KILOS")),3,,,TRUE)%></td>
                         <%tot2= tot2+CDBL(RS("Kilos")) %>
                    </tr>
                    <%rs.movenext %>
                <%LOOP %>
                <tr class="TEXTO4" style="background-color:gainsboro">    
                    <td colspan="3" align="right"><strong>Total: </strong></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT1,0,,,TRUE)%></td>
                     <td style="text-align:right"><%=FORMATNUMBER(TOT2,3,,,TRUE)%></td>
               </tr>
            </table>
            </span>
        </td>
    </tr>
    <tr valign="top">
        <td colspan="3">
        </td>
    </tr>
</table>

        <%cad = "EXEC SP_OFI_TELA_EXPLOTADA '"&ofi&"' " 
        'response.write(cad)
        RS.CLOSE
        rs.open cad, cnn
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
        <%u=1%>
        <%etc = rs("etc") %>
        <table  border="1" cellspacing="0" cellpadding="0" align="left" width="100%" id="TABLA" name="TABLA">
         <tr>
    <td colspan="12" class="tituloGRANDEgris3">Detalle de Explosion</td>
   </tr>
        <tr class="">
            <td><div id="contenido">
            Recolectando Informacion, espere...
            </div></td>
        </tr>
        
  </table>
      <%
        COMBOOOSCAD = "SELECT distinct colpza FROM VIEW_RECTILINEOS_OFI  WHERE OFI =  '"&OFI&"'"
        'response.write(comboooscad)
        rs.close 
        rs.open COMBOOOSCAD,cnn
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST
        combos = ""
        do until rs.EOF
        for each x in rs.Fields
             combos = combos & (x.value)&" , "
        next
        rs.MoveNext
  loop
     %>
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

function EXCEL() { 
window.location.replace('explosiontelas.asp?ofi='+'<%=ofi%>'+'&excel=1')

}
$(document).ready(function () {
    
    var combos = "<%=combos %>";
    var po = "<%=po %>";
    var c = "";

    for (var i = 0; i < combos.split(',').length; i++) {
        var ex = combos.split(',')[i];
        //alert(ex)
        if (ex != "") {
            var url = "http://localhost/modelador/BAKE/DESPACHO_PARTIDAS_COMBO_tnt.asp?cli=<%=cli%>&tem=<%=temp %>&est=<%=esttt %>&com=" + ex
            $.ajax({
                async: false,
                type: "get",
                url: url,
                success: function (res) {
                    console.log(url)
                    c = c + res;

                }
            });
        }
    }
    console.log("xd" + c);
    $("#contenido").html(c)
    alert("listo")

});

</script>

</html>
