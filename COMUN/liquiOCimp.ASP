<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<%Response.Buffer = TRUE %>
<%Session.LCID = 2057%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>

<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<BODY>

<%MSS = "select realsoft from usuarios where usuario = '"&usuario&"'"
RS.OPEN MSS, CNN
'RESPONSE.WRITE(MSS)
USUARIO = TRIM(RS("REALSOFT"))
RS.CLOSE
IF TRIM(USUARIO) = "" THEN%>
<script language="jscript" type="text/jscript">
    parent.window.alert("Usuario no registrado para GRABAR en el Real")
</script>
<%RESPONSE.End
END IF
' YA SABEMOS QUE ES UNA IMPORTACIÓN
OC  =    TRIM(REQUEST.QUERYSTRING("OC"))
tip =    TRIM(REQUEST.QUERYSTRING("tip"))
CIF =    TRIM(REQUEST.QUERYSTRING("CIF"))
FOB =    TRIM(REQUEST.QUERYSTRING("FOB"))
FAC =    TRIM(REQUEST.QUERYSTRING("FAC"))


' Bloqueo la OC para que otro no meta la manotas


' CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='1' Where OC_CNUMORD='"&OC&"' ; "




' TENEMOS EL FOB, CIF Y EL FACTOR POR EL QUE MULTIPLICAR EL PRECIO UNITARIO DE LOS PE
' PRECIO UNITARIO DEL PE = FACTOR * PU anterior.... y recalculamos el resto del ingreso
' busca TODOS los PE de los servicios
    

    CAD =   " SELECT C6_CCODIGO, C6_NCANTID, C6_NPREUNI, C6_NPREUN1, C6_NMNPRUN,        " & _
            " C6_NUSPRUN, C6_NTIPCAM, C6_NVALTOT, C6_NMNIMPO, C6_NUSIMPO, C5_CCODMON,   " & _
            " OC_CITEM, C6_CNUMDOC ,C6_CDESCRI  From RSFACCAR..CO0001MOVD AS CC         " & _    
            " inner join RSFACCAR..al0001movc AS A on OC_CNUMORD = c5_cnumord           " & _
            " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc           " & _
            " and c5_ctd = c6_ctd and c5_calma = c6_calma and OC_CITEM = C6_CITEMOC     " & _
            " Where OC_CNUMORD='"&OC&"' AND OC_NCANORD > 0                              " & _
            " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                          " 
           
         '   response.write(cad)
            rs.open cad,cnn
    KAD = ""
    if rs.recordcount > 0 then rs.movefirst
        do while not rs.eof
            ' si los precios estan en DOLARES..
            if rs("c5_ccodmon") = "US" then
            
                PUN = CDBL(RS("C6_NPREUNI")) * CDBL(FAC)
                CAM = CDBL(RS("C6_NTIPCAM"))
                PU2 = PUN * CAM
                TT1 = PUN * CDBL(RS("C6_NCANTID"))
                TT2 = PU2 * CDBL(RS("C6_NCANTID")) 
                ITM = RS("OC_CITEM")
                DOC = RS("C6_CNUMDOC")
               
            else
                ' si los precios estan en MONEDA NACIONAL
                CDBL(RS("C6_NPREUNI")) * CDBL(FAC)
                CAM = CDBL(RS("C6_NTIPCAM"))
                PU2 = PUN / CAM
                TT1 = PUN / CDBL(RS("C6_NCANTID"))
                TT2 = PU2 / CDBL(RS("C6_NCANTID")) 
                ITM = RS("OC_CITEM")
                DOC = RS("C6_CNUMDOC")
            end if
            KAD = KAD + " UPDATE RSFACCAR..AL0001MOVD SET   " & _
                        " C6_NPREUNI = "&PUN&",             " & _
                        " C6_NPREUN1 = "&PUN&",             " & _
                        " C6_NMNPRUN = "&PU2&",             " & _
                        " C6_NUSPRUN = "&PUN&",             " & _
                        " C6_NVALTOT = "&tt1&",             " & _
                        " C6_NMNIMPO = "&TT2&",             " & _
                        " C6_NUSIMPO = "&TT1&"              " & _
                        " WHERE C6_CITEM  = '"&ITM&"' AND   " & _
                        " C6_CNUMDOC = '"&DOC&"'            " 
            rs.movenext
        loop




CNN.EXECUTE KAD


'RESPONSE.END
' actuaiza el flag de la OC a LIQUIDADO
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CSITORD='6' Where OC_CNUMORD='"&OC&"' ; "
cnn.execute "Update RSFACCAR..CO0001MOVD Set OC_CESTADO='6' Where OC_CNUMORD='"&oc&"' "

' DESBloqueo la OC 
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='' Where OC_CNUMORD='"&OC&"' ; " %>

<table cellpadding="5" cellspacing="0" border="1" style="width:100%" align="center" >
    <tr><td class="TITULITOWHITE" style="text-align:left; background-color:navy">REVALORIZACION de Documentos de Almacen : </td></tr>
</table> 
<p></p>
<%   CAD =      " Select a.c5_calma as alm, OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDEN,                    " & _
                " OC_NPREUN2 AS UNI_OC, (OC_NCANORD*OC_NPREUN2) AS TOT_OC,  C5_CCODMOV,                                                         " & _
                " CANTI = case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END,                                      " & _
                " ltrim(rtrim(c6_ctd)) + ' - '+ ltrim(rtrim(c6_cnumdoc)) as DOC, (C6_NPREUNi) AS UNI_PE,                                        " & _
                " (C6_NPREUNi) * case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END AS TOT_PE,                     " & _
                " CONVERT(VARCHAR, C5_DFECDOC, 103) AS FECHA, a.C5_CCODMON,                                                                     " & _
                " (OC_NCANORD*OC_NPREUN2)-(C6_NPREUNI* case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID*-1 END) AS SALDO " & _
                " From RSFACCAR..CO0001MOVD AS CC                                                                                               " & _
                "  inner join  RSFACCAR..al0001movc AS A  on OC_CNUMORD = c5_cnumord                                                            " & _
                " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                   " & _
                " and OC_CITEM = C6_CITEMOC                                                                                                     " & _
                " Where OC_CNUMORD='"&OC&"' AND OC_NCANORD > 0                                                                                  " & _
                " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                                                                              " 
                rs.close
             '   response.write(cad)
                rs.open cad,cnn
 %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
        <tr class="DESCRIPTORnegro" >
           
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
        </tr>
        <tr><td colspan="14"><hr /></td></tr>
        <% IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST%>
        <%cnt = 0 %>
        <%tot1=0 %>
        <%mone= rs("c5_ccodmon") %>
        <%do while not rs.eof%>
         <tr  class="DESCRIPTORnegro" id="Tr1" valign="top"  <% IF cnt mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>>
          
            <td align="center"><%=RS("COD") %></td>
            <td align="left"><%=UCASE(RS("DESCRI"))%></td>
            <td align="center"><%=UCASE(RS("UNI"))%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("ORDEN")),4,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_oc")),2,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_oc")),2,,,TRUE)%></td>
             <td align="center"><%=UCASE(RS("C5_CCODMOV"))%></td>
             <td align="center"><%=UCASE(RS("doc"))%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("canti")),4,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("uni_pe")),2,,,TRUE)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("tot_pe")),2,,,TRUE)%></td>
            <%tot1 = tot1 + CDBL(RS("tot_pe") )%>
            <td align="right" style="padding-right:10px;"><%=FORMATdatetime((RS("fecha")),2)%></td>
            <td align="right" style="padding-right:10px;"><%=FORMATNUMBER(CDBL(RS("saldo")),2,,,TRUE)%></td>
            </tr>
            <%rs.movenext%>
            <%cnt = cnt + 1%>
        <%loop %>
        <tr  class="DESCRIPTORnegro"  valign="top" bgcolor='<%=(Application("barra"))%>' style="padding-right:10px;">
            <td colspan ="10"  align="right" style="padding-right:10px;">Total segun documentos</td><td align="right" style="padding-right:10px;"><b><%=FORMATNUMBER(tot1,2,,,TRUE)%></b></td><td colspan="2">&nbsp;</td>
        </tr>
        </table>


<% RS.CLOSE
rs.open cAD, CNN
RS.MOVEFIRST
  do while not rs.eof          %>


    
    <%RS.MOVENEXT%>
<%LOOP%>




<%Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>






<script language="javascript" type="text/jscript">
   alert("OC liquidada")
   cad= '../liquidadas.asp?tip='+ '<%=tip%>'
   //alert(cad)
parent.window.document.all.OK.style.display='none'
/*
   top.window.opener.window.location.replace(cad)
   top.window.close()
*/

</script>
</BODY>
</HTML>

