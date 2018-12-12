<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<%	
COD			= Request.QueryString("cod")
can			= Request.QueryString("can")
lt2			= Request.QueryString("lt2")
alm			= Request.QueryString("alm")
des			= Request.QueryString("des")
aCod = split(cod, ",")
aCan = split(can, ",")
aAlm = split(alm, ",")
aDes = split(des, ",")



cSql = request.cookies("cSql")
lt2 = trim(request.QueryString("lt2"))
cSql = right(cSql, len(csql)-10)
dato  = ""
grupo = ""
hilos = ""
if lcase(lt2) = "c" then ' compra de tela cruda 
    dato = "crudo " 
    grupo =  "sum(kgsteje) as KGS , case when left(crudo,1) ='9' then sum(qty) else 0 end as qty"
   

elseif lcase(lt2) = "t" then
    dato = "tela " 
    grupo = "sum(kgs) as kgs, case when left(tela,1) ='9' then sum(qty) else 0 end as qty"
else
    dato = "h1, h2, h3, h4, h5, h6 "
    grupo = "sum(k1) as k1, sum(k2) as k2, sum(k3) as k3, sum(k4) as k4, sum(k5) as k5, sum(k6) as k6, 0 as qty "
    hilos = "1"
end if

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
%>
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<title>RESERVAS</title>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="../ESTILOS1.CSS" >
<script language="javascript">



</script>
</HEAD>
<body topmargin="0" leftmargin="10" rightmargin="10" text="#000000">
<form name="thisForm" METHOD="post" >
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=15%>
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align= "center">
			<font face="arial" size="3" color=DarkBlue><B>
			Reservas: <font size="1" color="darkgreen"> Detalle por cantidad en VERDE
			</b></font>
		</td>
        </tr>
	</tr>
	<tr>
	<td colspan="3"><HR></td>
	</tr>
</table>

<iframe id="ggg" name="ggg" src=""  width="100%" scrolling="no" frameborder="1" height="100" style="display:none"></iframe>
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>"   bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="2" >
    <tr bgcolor="<%=APPLICATION("TITULO")%>" >
        <td align="center" class="AMERICANwhite" >ALM</td>
        <td align="center" class="AMERICANwhite" >Codigo</td>
        <td align="center" class="AMERICANwhite" >Descripcion</td>
        <td align="center" class="AMERICANwhite" >DISP</td>
        <td align="center" class="AMERICANwhite" >OFI</td>
        <td align="center" class="AMERICANwhite" >PO</td>
        <td align="center" class="AMERICANwhite" colspan="10" >TALLAS/KGS.</td>
    </tr>
    <!-- Grid en dos colores.... -->
    <%for i= 1 to ubound(aCod)+1%>
        <%  kad =       " select ofi, po, CODCLI, " + dato+ ", " + grupo + " " 
            kad = kad   + cSql + " and "
            if lcase(lt2) = "c" then 
                kad = kad  + dato + " =  case when right('"+aCod(i-1)+"',10) = '0000000000' then LEFT('" + aCod(i-1)+ "' ,6) end " 
            elseIF   lcase(lt2) = "h" then 
                kad = kad  + "'" + aCod(i-1) +"' IN (" + DATO + ")"
            ELSE
                kad = kad  + dato + " = '" + aCod(i-1) +"'"
            end if 
            kad = kad  + " group by  ofi, po, CODCLI," + dato + " ORDER BY " + dato
        '    response.write(kad)    
            RS.OPEN KAD, CNN
            ofi = ""
            if rs.recordcount > 0 then 
                rs.movefirst
                OFI = RS("OFI")
                Opp = RS("po")
                ofiold = ofi%>
            <%end if %>
        <%do while not rs.eof%>
            <tr id="fila<%=Trim(Cstr(i))%>" valign="top" bgcolor="<% if i mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>">     
                
	            <!-- es porque el oldrow del comun empieza en 1 y mi array empieza en 0 -->
		        <td class="texto" align="center" valign="top"><%if trim(rs("ofi"))= trim(ofiold) then response.write(aAlm(I-1))%>&nbsp;</td>
	            <td class="texto" align="center" valign="top"><%if trim(rs("ofi"))= trim(ofiold) then response.write(aCod(I-1))%>&nbsp;</td>
                <td class="texto" align="left"   valign="top"><%if trim(rs("ofi"))= trim(ofiold) then response.write(aDes(I-1))%>&nbsp;</td>
                <td class="texto" align="right"  valign="top">
                <%if trim(rs("ofi"))= trim(ofiold) then%>
                    <%IF LEFT(aCod(i-1),1) = "9" then %>
                        <%=formatnumber((aCan(I-1)),0,,,true)%>
                     <%else %>
                        <%=formatnumber((aCan(I-1)),3,,,true)%>
                     <%end if%>
                <%END IF%>
                &nbsp;</td>   
                <%CLI= RS("CODCLI") 
                if left(aCod(i-1),1) = "9" then %>
                    <%IF LCASE(LT2) = "c" THEN
                        CAD = " exec SP_TNT_RECTILINEOS_OFI_CRUDO '"&cli&"', '"&aCod(i-1)&"', '"&ofi&"' "
                    ELSE    
                        CAD = " exec SP_TNT_RECTILINEOS_OFI '"&cli&"', '"&aCod(i-1)&"', '"&ofi&"' "
                    END IF
                   ' response.write(cad)
                    aTal = Array("","","","","","","","","","")
                    aqty = Array(0,0,0,0,0,0,0,0,0,0)
                    RS2.OPEN CAD,CNN
                    IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF%>
                        <td class="texto" align="center"><%=OFI%></td>
                        <td class="texto" align="center"><%=opp%></td>
                        <td class="texto" align="center"><font color="red">REQ</font></td>
                        <%FOR J= 11 TO 20 %>
                            <td class="TEXTO" style="text-align:right"><font color="red">
                                <% ATAL(J-11) = TRIM(RS2.FIELDS.ITEM(J))
                                   AQTY(J-11) = TRIM(RS2.FIELDS.ITEM(J-10))%>
                               <%if TRIM(RS2.FIELDS.ITEM(J-10))  <> "0" then%>
                                    <%=TRIM(RS2.FIELDS.ITEM(J))%>
                                    <br /><font color= "navy">
                                    <%=TRIM(RS2.FIELDS.ITEM(J-10))%>
                                <%ELSE%>
                                    &nbsp;
                                <%END IF %>
                            </td>
                        <%NEXT %>
                        <%RS2.MOVENEXT%>
                        <%IF RS2.EOF THEN EXIT DO %>
                    <%LOOP %>
                    <%RS2.CLOSE%>    
                <%else %>
                    <td class="texto" align="center"><%=OFI%></td>
                    <td class="texto" align="center"><%=OPP%></td>
                    <td class="texto" align="center" valign="top"><font color="red">REQ</font></td>
                    <%IF   lcase(lt2) = "h" then %>
                        <% IF aCod(I-1) = rs("h1") then
                                kilos = CDBL(RS("k1"))
                           elseif    aCod(I-1) = rs("h2") then
                                  kilos = CDBL(RS("k2")) 
                            elseif    aCod(I-1) = rs("h3") then
                                kilos = CDBL(RS("k3"))
                            elseif    aCod(I-1) = rs("h4") then
                                kilos = CDBL(RS("k4"))
                            elseif    aCod(I-1) = rs("h5") then
                                kilos = CDBL(RS("k5"))
                            else
                                kilos = CDBL(RS("k6"))
                            end if %>
                    <%else%>
                        <%kilos = formatnumber(CDBL(RS("KGS")),3,,,true) %>
                    <%end if %>
                    <td class="texto" align="right" valign="top" colspan="3"><%=formatnumber(kilos,3,,,true)%></td>
                <%end if%>
                </tr>
                <tr bgcolor="<% if i mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>">
                    <td colspan="6">&nbsp;</td>
                    <td class="texto" align="center" valign="top"><font color="green">RSV</font></td>
                    <% if left(aCod(i-1),1) = "9" then %>
                        <%aRec ="" 
                        aTll = ""  %>
                        <%FOR M = 0 TO 9%>
                            <td class="TEXTO" style="text-align:right"><font color="green">
                            <%if aqty(m) > 0 and aCan(i-1)>0 then%> 
                                <%CAD = " select CAN =isnull(SUM(CASE WHEN BB.CTIPMOV='E'THEN CANTIDAD ELSE CANTIDAD*-1 END),0) " & _
                                        " from multi..RS_ALMOVD_TALLA0001 as aa                                                 " & _
                                        " inner join multi..RS_ALMOVD0001 as bb on                                              " & _
                                        " aa.calma COLLATE Modern_Spanish_CI_AS = bb.calma and aa.cnumdoc                       " & _
                                        " COLLATE Modern_Spanish_CI_AS = bb.CNUMDOC                                             " & _
                                        " AND BB.CITEM = AA.CITEM COLLATE Modern_Spanish_CI_AS                                  " & _
                                        " where AA.CALMA='"&aAlm(I-1)&"' AND CCODIGO='"&aCod(I-1)&"' AND                        " & _
                                        " ltrim(rtrim(TALLA))=ltrim(rtrim('"&ATAL(M)&"' ))   "
                                        ' response.write(cad)
                                        'response.end
                                    RS2.OPEN CAD,CNN
                                    if rs2.recordcount > 0 then 
                                        rs2.movefirst%> 
                                        <%atll= atll + cstr(aTal(m)) + ","%>
                                        <%IF cint(RS2("CAN")) >= cint(aqty(M)) THEN%>
                                            <%=FORMATNUMBER(aqty(M),0,,,TRUE)%>
                                            <%aCan(i-1) = cint(aCan(i-1)) -cint(AQTY(M))
                                             aRec = arec + cstr(aqty(M)) + ","%>
                                        <%else%>
                                            <%=rs2("can")%>
                                            <%aCan(i-1) = cint(aCan(i-1)) -rs2("can")
                                              aQty(m)= aCan(i-1)
                                              arec= arec + cstr(rs2("can")) + ","%>
                                        <%end if%>
                                    <%end if%>
                                <%RS2.CLOSE%>
                            <%else%>
                            &nbsp;
                            <%end if%>                           
                            </td>
                        <%NEXT%>             
                    <%else%>
                        <td class="texto" align="right" colspan="3" style="color:Green">
                        <%if cdbl(aCan(I-1))-CDBL(kilos) > 0 then %>
                            <%= formatnumber(CDBL(kilos),3,,,true)%>
                            <%aCan(i-1) = aCan(i-1)-CDBL(kilos)  
                            kilos = RS("KGS")%>
                        <%else%>
                            <%= formatnumber(aCan(i-1),3,,,true)%>
                            <%kilos = aCan(i-1)
                            aCan(i-1) = aCan(i-1)-aCan(i-1) %>
                        <%end if%>
                            </td>
                    <%end if%>
                </tr>
                 <% if left(aCod(i-1),1) = "9" then %>
                    <%if len(trim(arec))> 0 then %>
                     <script language="javascript" type="text/jscript">
                         //alert()
                            cad = '../comun/grabaRSV.asp?ofi=' + trim('<%=ofi%>')
                            cad += '&pos=' + trim('<%=opp%>')
                            cad += '&qty=' + '<%=left(arec,len(arec)-1)%>'
                            cad += '&tal=' + '<%=left(atll,len(atll)-1)%>'
                            cad += '&cod=' + '<%=acod(i-1)%>'
                            cad += '&alm=' + '<%=aAlm(i-1)%>'
                            cad += '&LT2=' + '<%=LT2%>'
                            cad += '&tip=R'
                           // alert(cad)
                            document.all.ggg.src = cad
                        </script>   
                    <%end if%>

                 <%else%>
                 <script language="javascript" type="text/jscript">
                            cad = '../comun/grabaRSV.asp?ofi=' + trim('<%=ofi%>') 
                            cad += '&pos='+trim('<%=opp%>')
                            cad += '&kgs=' + '<%=kilos%>' 
                            cad += '&cod=' + '<%=acod(i-1)%>'
                            cad += '&alm=' + '<%=aAlm(i-1)%>'
                            cad += '&LT2=' + '<%=LT2%>'
                            cad += '&tip=T'
                            document.all.ggg.src= cad
                        </script>     
                 <%end if%>
                <%rs.movenext %>
                <%IF RS.EOF THEN 
                    EXIT DO 
                 else 
                    OFI = RS("OFI")
                    OPP = RS("PO") 
                 END IF%>           
              
            <%loop%>  
           
         <%rs.close%>
      
        <%next%>
</table>


<script language="javascript" type="text/jscript">
window.opener.location.reload();
</script>    

</form>
</body>
</HTML>