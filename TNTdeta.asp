<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.Buffer = true %>
<%Session.LCID=2057%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="comun/funcionescomunes.asp"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<!--#include file="includes/cnn.inc"-->
<% 
IF  request.QueryString("EXCEL") = "1" THEN
  archivo = "c:\temp\TNT.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
END IF

cli = trim(request.QueryString("cli") )    

if len(trim(cli)) = 0 then
    response.write("Le agradecemos que informe el Cliente para poder proceder")
    response.end
end if
est = trim(request.QueryString("est") )
poo = trim(request.QueryString("poo") )
tem = trim(request.QueryString("tem") )
PRO = replace(trim(request.QueryString("PRO") ),"-","")
OFI = trim(request.QueryString("OFI") )
GTE = REPLACE(trim(request.QueryString("GTE") ) ," ", "")

cad =   " SELECT * FROM VIEW_TNT_TELA WHERE ESTADO ='A' "
    IF LEN(TRIM(CLI)) > 0 THEN CAD = CAD + " AND CODCLI= '"&CLI&"'   "
    IF LEN(TRIM(POO)) > 0 THEN CAD = CAD + " AND  PO LIKE '%"&POO&"%' "
    IF LEN(TRIM(TEM)) > 0 THEN CAD = CAD + " AND CODTEM =  '"&TEM&"'" 
    IF LEN(TRIM(OFI)) > 0 THEN CAD = CAD + " AND OFI in ("&OFI&") "
    IF LEN(TRIM(PRO)) > 0 THEN CAD = CAD + " AND rtrim(ltrim(AJU))+ver LIKE '%"&PRO&"'"
    IF LEN(TRIM(EST)) > 0 THEN CAD = CAD + " AND  ESTCLI = '"&EST&"' " 
    IF LEN(TRIM(GTE)) > 0 THEN CAD = CAD + " AND  REPLACE(GRUPO_TEX,' ' ,'') LIKE '%"&GTE&"%' "


'RESPONSE.WRITE (CAD)
response.Cookies("csql") = cad
'RESPONSE.END
rs.open cad,cnn
if rs.recordcount <=0 then 
    'RESPONSE.WRITE (CAD)
    RESPONSE.WRITE("NO HAY DATOS QUE CUMPLAN LOS CRITERIOS DE SU FILTRO")
    RESPONSE.End
END IF
%>

<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<body >
<center>
<!--<input type="button" class="botonok3" onclick="EXCEL()"/> -->
<!--<table id="TABLA" align="CENTER" width="100%" 	 cellpadding="1" cellspacing="1" style="background-color:#c4c4c4;display:none">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<tr class="BARRA333" valign="top" align="center"  style="background-color:#FFF;">
    <td align="center" class="tituloGRANDEgris" >OFI</td>
    <td class="tituloGRANDEgris">PO</td>   
    <td class="tituloGRANDEgris">UBI</td>   
    <td class="tituloGRANDEgris">ID</td>   
    <td align="center" class="tituloGRANDEgris" >ESTILO</td>   
    <td align="center" class="tituloGRANDEgris" >AJUSTE</td>
    <td align="center" class="tituloGRANDEgris" >VER</td>
    <td align="center" class="tituloGRANDEgris" >COD</td>
    <td align="center" class="tituloGRANDEgris" >COLOR</td>    
    <td align="center" class="tituloGRANDEgris" >TELA ACABADA</td>
    <td align="center" class="tituloGRANDEgris" >QTY</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >CRUDO</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 1</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 2</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 3</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 4</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 5</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
    <td align="center" class="tituloGRANDEgris" >HILADO 6</td>
    <td align="center" class="tituloGRANDEgris" >KGS</td>
                                                  
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN RS.MOVEFIRST%>
<%OFI = rs("ofi") 
cad = " delete tempo; insert into tempo SELECT '"&ofi&"';"
'response.write (cad)
cnn.execute cad

cadOfi = "'" + trim(rs("ofi"))+ "'," %>
<%cont = 0%>
<%DO WHILE NOT RS.EOF %>
	<tr valign="top"   style="background-color:#FFF;">
	    <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="pof<%=cont%>" ><%=trim(RS("OFI"))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="ppo<%=cont%>" ><%=trim(RS("PO"))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="pub<%=cont%>" ><%=trim(cstr(RS("ubi")))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="pid<%=cont%>" ><%=trim(cstr(RS("id")))%></td>
	    <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center"><%=ucase(rs("ESTCLI"))%></td>
        
        <%if trim(ofi) <> trim(rs("ofi")) then 
            cadOfi = cadOfi + "'" + trim(rs("ofi"))+ "'," 
            ofi =  trim(rs("ofi"))
            cad = "insert into tempo select '"&ofi&"'   "
            cnn.execute cad
        end if%>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center"><%=RS("AJU")%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center"><%=RS("VER")%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center">&nbsp;<%=SoloNumeros(rs("COMBO"))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="left"  ><%=Sololetras(RS("COMBO"))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="pac<%=cont%>">&nbsp;<%=RS("TELA")%></td>
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="pqt<%=cont%>"><%IF LEFT(RS("TELA"),1)= "9" THEN RESPONSE.WRITE(formatnumber(RS("QTY"),0,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="pka<%=cont%>"><%IF CDBL(RS("KGS")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("KGS"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="pcr<%=cont%>"><%=RS("CRUDO")%></td>
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="pkc<%=cont%>"><%IF CDBL(RS("KGSTEJE")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("KGSTEJE"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p1h<%=cont%>"><%=RS("H1")%></td>
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p1k<%=cont%>"><%IF CDBL(RS("K1")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K1"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p2h<%=cont%>"><%=RS("H2")%></td>                                                
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p2k<%=cont%>"><%IF CDBL(RS("K2")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K2"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p3h<%=cont%>"><%=RS("H3")%></td>                                                
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p3k<%=cont%>"><%IF CDBL(RS("K3")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K3"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p4h<%=cont%>"><%=RS("H4")%></td>                                                
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p4k<%=cont%>"><%IF CDBL(RS("K4")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K4"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p5h<%=cont%>"><%=RS("H5")%></td>                                                
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p5k<%=cont%>"><%IF CDBL(RS("K5")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K5"),3,,,true))%></td>
        <td class="DATOSnormal" style="background-color:#fff;    font-size:smallest; font-weight:300" align="center" id="p6h<%=cont%>"><%=RS("H6")%></td>                                                
        <td class="DATOSnormal" style="background-color:#CAFFFF; font-size:smallest; font-weight:300" align="right"  id="p6k<%=cont%>"><%IF CDBL(RS("K6")) > 0 THEN RESPONSE.WRITE(formatnumber(RS("K6"),3,,,true))%></td>
    </tr>                                                                                                                                                                              

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
-->
<p class="tituloRESUMEN">
Resumen para Emitir Ordenes de Compra

<%CadOfi = "(" + left(cadOfi, len(cadOfi)-1)+")"
  '  RESPONSE.WRITE(CADOFI)
    rs.close

cad = " SELECT TELA, ar_cdescri as DESCRI, QTY = CASE WHEN LEFT(TELA,1) = '9' THEN  SUM(QTY) ELSE 0 END,    " & _ 
      " SUM(KGS) AS KGS                                                                                     " & _
      " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA                                      " & _
      " on TELA collate Modern_Spanish_CI_AS = AR_CCODIGO                                                   " & _
      " WHERE ESTADO ='A' AND OFI IN  "&CADOFI&"                                                            " & _ 
      " GROUP BY  TELA, AR_CDESCRI                                                                          " & _ 
      " ORDER BY 1                                                                                          "    
'response.write(cad)

rs.open  cad, cnn

if rs.recordcount > 0 then rs.movefirst%>
</p>

<table id="Table1" align="CENTER" width="100%"	 cellpadding="1" cellspacing="1" style="background-color:#c4c4c4">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
    <tr  valign="top" align="center"  style="background-color:#FFF;">
        <td class="tituloGRANDEgris" colspan="2">Tela Acabada</td>   
        <td class="tituloGRANDEgris" align="center">Qty</td>
        <td class="tituloGRANDEgris" align="center">Kgs</td>
    </tr>
    <%t = 0 %>
<%do while not rs.eof %>
    <tr>
        <td class="DATOSnormal" id="tc<%=t%>" name="tc<%=t%>" style="background-color:#FFF;font-size:smallest; font-weight:300" align="left" >&nbsp;<%=trim(rs("TELA"))%></td>
        <td class="DATOSnormal" id="td<%=t%>" name="td<%=t%>" style="background-color:#FFF;font-size:smallest; font-weight:300" align="left" ><%=trim(rs("descri"))%></td>
        <td class="DATOSnormal" id="tq<%=t%>" name="tq<%=t%>" style="background-color:#FFF;font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("qty"),0,,,true)%></td>
        <td class="DATOSnormal" id="tk<%=t%>" name="tk<%=t%>" style="background-color:#FFF;font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("kgs"),3,,,true)%></td>
    </tr>
    <%t = t + 1%>
    <%rs.movenext %>
    <%loop%>
    <tr valign="top" align="center"  style="background-color:#FFF;">
        <td class="tituloGRANDEgris" colspan="2">Tela Cruda</td>   
        <td class="tituloGRANDEgris" align="center">Qty</td>
        <td class="tituloGRANDEgris" align="center">Kgs</td>
    </tr>
    <%
    rs.close

cad = " SELECT CRUDO, ar_cdescri as DESCRI, QTY = CASE WHEN LEFT(CRUDO,1) = '9' THEN  SUM(QTY) ELSE 0 END,  " & _
      " SUM(KGSTEJE) AS KGS                                                                                 " & _
      " FROM VIEW_TNT_TELA AS VT  LEFT OUTER JOIN RSFACCAR..AL0001ARTI AS AA                                " & _
      " on ltrim(rtrim(CRUDO))+ '0000000000' collate Modern_Spanish_CI_AS = AR_CCODIGO                      " & _
      " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                             " & _
      " GROUP BY  CRUDO, AR_CDESCRI                                                                         "
'response.write(cad)
rs.open  cad, cnn

if rs.recordcount > 0 then rs.movefirst%>
<%c=0%>
<%do while not rs.eof %>
    <tr>
        <td class="DATOSnormal" id="cc<%=c%>" name="cc<%=c%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="left" ><%=trim(rs("crudo"))%></td>
        <td class="DATOSnormal" id="cd<%=c%>" name="cd<%=c%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="left" ><%=trim(rs("descri"))%></td>
        <td class="DATOSnormal" id="cq<%=c%>" name="cq<%=c%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("qty"),0,,,true)%></td>
        <td class="DATOSnormal" id="ck<%=c%>" name="ck<%=c%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("kgs"),3,,,true)%></td>
    </tr>
    <%c= c +1%>
    <%rs.movenext %>
    <%loop%>
    <%RS.CLOSE
    cad = " SELECT '3' AS TIP, H1, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K1) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H1 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H1, AR_CDESCRI                                                                                            " & _
          " UNION                                                                                                               " & _
          " SELECT '3' AS TIP, H2, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K2) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H2 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H2, AR_CDESCRI                                                                                            " & _
          " UNION                                                                                                               " & _
          " SELECT '3' AS TIP, H3, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K3) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H3 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H3, AR_CDESCRI                                                                                            " & _
          " UNION                                                                                                               " & _
          " SELECT '3' AS TIP, H4, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K4) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H4 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H4, AR_CDESCRI                                                                                            " & _
          " UNION                                                                                                               " & _
          " SELECT '3' AS TIP, H5, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K5) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H5 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H5, AR_CDESCRI                                                                                            " & _
          " UNION                                                                                                               " & _
          " SELECT '3' AS TIP, H6, AR_CDESCRI as DESCRI, QTY = 0 ,SUM(K6) AS KGS                                                " & _
          " FROM VIEW_TNT_TELA as vt INNER JOIN RSFACCAR..AL0001ARTI AS AA on H6 collate Modern_Spanish_CI_AS = AR_CCODIGO      " & _
          " WHERE ESTADO ='A' AND OFI IN "&CADOFI&"                                                                             " & _
          " GROUP BY  H6, AR_CDESCRI                                                                                            " & _
          " ORDER BY 1,2                                                                                                        " 
   rs.open  cad, cnn

if rs.recordcount > 0 then rs.movefirst%>
<tr class="BARRA333" valign="top" align="center"  style="background-color:#FFF;">
        <td class="tituloGRANDEgris" colspan="2">Hilado</td>   
        <td class="tituloGRANDEgris" align="center">Qty</td>
        <td class="tituloGRANDEgris" align="center">Kgs</td>
    </tr>
<%h = 0%>
<%do while not rs.eof %>
    <%if len(trim(rs("h1"))) > 0 then%>
    <tr>
        <td class="DATOSnormal" id="hc<%=h%>" name="hc<%=h%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="left" ><%=trim(rs("h1"))%></td>
        <td class="DATOSnormal" id="hd<%=h%>" name="hd<%=h%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="left" ><%=trim(rs("descri"))%></td>
        <td class="DATOSnormal" id="hq<%=h%>" name="hq<%=h%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("qty"),0,,,true)%></td>
        <td class="DATOSnormal" id="hk<%=h%>" name="hk<%=h%>" style="background-color:#fff; font-size:smallest; font-weight:300" align="right"><%=formatnumber(rs("kgs"),3,,,true)%></td>
    </tr>
    <%h = h + 1 %>
    <%end if %>
    <%rs.movenext %>
    <%loop%>
</table>
<p></p>
<%atot= array() %>
 <%CAD = " exec SP_TNT_RECTILINEOS '"&cli&"' "
            'response.write(cad)
            RS.CLOSE
            rs.open cad, cnn
            IF RS.RECORDCOUNT > 0 THEN 
            RS.MOVEFIRST%>
 <table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" >
            <!-- RECTILINEOS -->

              <tr>
                <td height="40px;" colspan="20"  class="tituloMODELADOR">Resumen de Rectilineos Acabados&nbsp;</td>
                </tr>
            
                <tr class="tituloGRANDEROJO">
                    <td>RECTILINEO</td>
                    <td>DESCRIPCION COLOR</td>
                   <%MAXI= RS.FIELDS.COUNT-4 %>
                   
                    <%FOR I=3 TO MAXI%>                        
                        <td><%=(TRIM(RS.FIELDS(I).NAME))%></td>       
                        <%ReDim Preserve atot(UBound(atot) + 1)
                        atot(i-3) = 0%>
                    <%NEXT%>   
                </tr>      
                <%DO WHILE NOT RS.EOF %>
                    <tr  class="TEXTO4" >                      
                        <td>&nbsp;<%=TRIM(RS("TELA"))%></td>
                        <td style="text-align:left"><%=TRIM(RS("DESCRI"))%></td>                     
                        <%FOR I=3 TO MAXI%>
                        <td style="text-align:right">
                            <%IF CDBL(RS.FIELDS.ITEM(I)) > 0 THEN %>          
                                <%=FORMATNUMBER(CDBL(RS.FIELDS.ITEM(I)),0,,,TRUE)%>
                                <%atot(i-3)= atot(i-3) + CDBL(RS.FIELDS.ITEM(I)) %>
                            <%ELSE%>&nbsp;
                            <%END IF %>  </td>
                        <%NEXT%>
                    </tr>
                    <%rs.movenext %>
                <%LOOP %>               
              <tr>
                <td colspan="2" class="tituloGRANDEgris">Total por Talla</td>
                <%FOR I=3 TO MAXI%>
                    <td style="text-align:right"  class="tituloGRANDEgris">          
                        <%if atot(i-3) > 0 then %>
                        <%=FORMATNUMBER(atot(i-3),0,,,TRUE)%>
                        <%else %>
                            &nbsp;
                        <%end if %>
                    </td>
                <%NEXT%>
                </tr>
                
         </table>
<%END IF %> <!-- DE LOS RECTILINEOS-->

<input id="t" name="t" value='<%=t-1%>' style="display:none" />
<input id="c" name="c" value='<%=c-1%>'  style="display:none"/>
<input id="h" name="h" value='<%=h-1%>' style="display:none" />
<input id="CNT" name="CNT" value='<%=CONT-1%>' style="display:none" />

<iframe id="oc" name="oc" src="OPCoc.asp?t=<%=t%>&c=<%=c%>&h=<%=h%>&tip=" onload="autofitIframe(this);" width="100%" scrolling="no" frameborder="0"></iframe>

<script language="jscript" type="text/jscript">
function EXCEL() {
    window.location.replace('tntdeta.asp?ofi=' + '<%=ofi%>' + '&excel=1'+ '&cli='+'<%=cli %>'+'&est='+'<%=est %>'+'&poo='+'<%=poo%>'+'&tem='+'<%=tem%>'+'&pro='+'<%=pro %>')
}

</script>


<%  
Public Function SoloNumeros(cadena)
     Solo= ""
For i = 1 To Len(cadena) 
    letra   = Mid(cadena, i, 1) 
    If IsNumeric(letra) Then Solo = Solo + Mid(cadena, i, 1) 
Next 
SoloNumeros = Solo
end function

Public Function Sololetras(cadena)
     Solo= ""
For i = 1 To Len(cadena) 
    letra   = Mid(cadena, i, 1) 
    If IsNumeric(letra) = false Then Solo = Solo + Mid(cadena, i, 1) 
Next 
Sololetras = Solo
end function

%>
</center>
</body>
</html>
