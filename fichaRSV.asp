<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<!--#include file="includes/Cnn.inc"-->
<%	
COD			= Request.QueryString("cod")
TIP			= Request.QueryString("TIP")
alm			= Request.QueryString("alm")
OFI			= Request.QueryString("OFI")
POS			= Request.QueryString("POS")
CLI			= Request.QueryString("CLI")

CAD =   " select RR.*, MM.AR_CDESCRI AS DESCRI from rsv_tela RR             " & _ 
        " INNER JOIN RSFACCAR..AL0001ARTI MM ON MM.AR_CCODIGO collate       " & _
        " SQL_Latin1_General_CP1_CI_AI = rr.CODIGO                          " & _
        " where CODIGO = '"&COD&"' AND TIPO ='"&TIP&"' AND ALM='"&ALM&"'    " & _
        " AND OFI = '"&OFI&"'                                               "
'response.write(cad)
RS.OPEN CAD, CNN
IF RS.RECORDCOUNT > 0 THEN 
    RS.MOVEFIRST
ELSE
    RESPONSE.WRITE("SIN DATOS")
    response.end
END IF
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
%>
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<title>RESERVAS FICHA</title>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="ESTILOS1.CSS" >
<script language="javascript">



</script>
</HEAD>
<body topmargin="0" leftmargin="10" rightmargin="10" text="#000000">
<form name="thisForm" METHOD="post" >
<table WIDTH=100%>
	<tr>
		<td align= left WIDTH=15%>
			<img src="imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: window.close();">
		</td>
		<td align= "center">
			<font face="arial" size="3" color=DarkBlue><B>
			Reservas: <font size="1" color="darkgreen"> 
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
        <td align="center" class="AMERICANwhite" >OFI</td>
        <td align="center" class="AMERICANwhite" >PO</td>
        <td align="center" class="AMERICANwhite" colspan="10" >TALLAS/KGS.</td>
    </tr>
    <tr valign="top">     

		<td class="texto" align="center" valign="top"><%=RS("ALM")%>&nbsp;</td>
	    <td class="texto" align="center" valign="top"><%=RS("CODIGO")%>&nbsp;</td>
        <td class="texto" align="left"   valign="top"><%=RS("DESCRI")%>&nbsp;</td>
        <td class="texto" align="left"   valign="top"><%=RS("OFI")%>&nbsp;</td>
        <td class="texto" align="left"   valign="top"><%=RS("PO")%>&nbsp;</td>
        <td class="texto" align="right"  valign="top">
               
               <% if left(Cod,1) = "9" then %>
                    <%IF LCASE(TIP) = "c" THEN
                        CAD = " exec SP_TNT_RECTILINEOS_OFI_CRUDO '"&cli&"', '"&Cod&"', '"&ofi&"' "
                    ELSE    
                        CAD = " exec SP_TNT_RECTILINEOS_OFI '"&cli&"', '"&Cod&"', '"&ofi&"' "
                    END IF
                   ' response.write(cad)
                    aTal = Array("","","","","","","","","","")
                    aqty = Array(0,0,0,0,0,0,0,0,0,0)
                    RS2.OPEN CAD,CNN
                    IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF%>
                       
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
                    <td class="texto" align="right" valign="top"><font color="red">REQ</font></td>
                    <%' cuando es crudo
                    if ucase(tip) = "C" then
                            cad =   " select kilos=sum(kgsteje) from EXPLOSION_TELA         " & _
                                    " where left('"&cod&"',6)=crudo AND OFI = '"&ofi&"'  "
                    elseIF         ucase(tip) = "T" then
                        cad =   " select kilos=sum(kgs) from EXPLOSION_TELA     " & _
                                " where '"&cod&"'  = tela AND OFI = '"&ofi&"'"
                    ELSE

                        CAD = " select kilos = case when h1='"&COD&"' then sum(k1) when h2='"&COD&"' then sum(k2)  " & _
                              " when h3='"&COD&"' then sum(k3) when h4='"&COD&"' then sum(k4)                      " & _
                              " when h5='"&COD&"' then sum(k4) when h5='"&COD&"' then sum(k5)                      " & _
                              " when h6='"&COD&"' then sum(k6)  end from EXPLOSION_TELA where '"&COD&"'            " & _
                              " in (h1, h2,h3,h4,h5,h6) AND OFI = '"&OFI&"'                                        " & _
                              " group by h1,h2,h3,h4,h5,h6                                                         " 
                     END IF%>           
                     <%   'RESPONSE.WRITE(CAD)
                        rs2.open cad, cnn
                        if rs2.recordcount > 0 then 
                            rs2.movefirSt
                            kilos = CDBL(rs2("kilos"))
                        else
                            kilos = 0 
                        end if%>

                        <%RS2.CLOSE %>
                   
                        <%kilos = formatnumber((kilos),3,,,true) %>
                    <td class="texto" align="right" valign="top" colspan="3"><%=formatnumber(kilos,3,,,true)%></td>
                <%end if%>
                </tr>
                <tr>
                    <td colspan="6">&nbsp;</td>
                    <td class="texto" align="right" valign="top"><font color="green">RSV</font></td>
                    <% if left(Cod,1) = "9" then %>
                        <%aRec ="" 
                        aTll = ""  %>
                        <%FOR M = 0 TO 9%>
                            <td class="TEXTO" style="text-align:right"><font color="green">
                                <%CAD = " select qty from rsv_talla where   " & _
                                        " CODIGO = '"&COD&"' AND talla ='"&aTal(m)&"' AND ALM='"&ALM&"'    " & _
                                        " AND OFI = '"&OFI&"' " 
                                        ' response.write(cad)
                                        'response.end
                                    RS2.OPEN CAD,CNN%>
                                   <%if rs2.recordcount>0 then%>
                                   <%=rs2("QTY") %>
                                   <%else%>
                                    &nbsp;
                                   <%end if %>
                                <%RS2.CLOSE%>
                                                 
                            </td>
                        <%NEXT%>             
                    <%else%>
                        <td class="texto" align="right" colspan="3" style="color:Green">
                            <%= formatnumber(CDBL(RS("KGS")),3,,,true)%>
                        </td>
                    <%end if%>
                </tr>
           
         <%rs.close%>
  
</table>


<script language="javascript" type="text/jscript">
window.opener.location.reload();
</script>    

</form>
</body>
</HTML>