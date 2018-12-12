<%@ Language=VBScript%>
<%Session.LCID=2057%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEd>
</heD>

<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<body style="margin-top:0; background-color:#edf6f9">
<html>
<%	
ori = Request.QueryString("ori")
po  = Request.QueryString("po")
ofi = Request.QueryString("ofi")
lin = Request.QueryString("lin")
lt1 = Request.QueryString("lt1")
ser = Request.QueryString("ser")
hil = Request.QueryString("ahil")
kil = Request.QueryString("acan")
des = Request.QueryString("des")
kod = Request.QueryString("kod")
'response.write(kil)
aHil = split(hil,",")
aKil = split(kil, ",")%>
<iframe id="head" name="head" src=""  width="100%" scrolling="no" frameborder="1" height="100" style="display:none"></iframe>	
<table align="center" cellspacing="4" border="0" cellpadding="4" id="RESE" name="RESE" style="display:block">
  <tr class="tituloGRANDEgris3">
    <td style="text-align:center">OFI</td> 
    <td style="text-align:center">CODIGO</td>    
    <td>REQUERIDO</td>
    <td>ALM</td> 
    <td>STK DISP</td> 
    <td>RSV</td> 
    <td>FECHA RSV</td> 
  </tr>

    <%for i = 0 to ubound(aHil)
        CAD =   " SELECT DISTINCT SK_CCODIGO,SK_NSKDIS= ISNULL((select SK_NSKDIS-(select CAN = CASE   " & _
                " WHEN SUM(QTY)>0 THEN SUM(QTY) WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END            " & _
                " from rsv_tela  where CODIGO = '"&ahil(i)&"') from rsfaccar..AL0001STOC              " & _
                " where sk_calma = ('"&ori&"')  and sk_ccodigo= '"&ahil(i)&"'),0), UPPER(sk_calma) AS " & _                                                
                " SK_CALMA,   RSV = (SELECT ISNULL(sum(CASE WHEN QTY=0 THEN KGS ELSE QTY END),0)      " & _
                " FROM RSV_TELA WHERE CODIGO='"&ahil(i)&"' AND ALM='"&ori&"'  and ofi ='"&ofi&"'      " & _
                " and replace(PO,' ','') = '"&po&"' and almdes = '"&des&"' and coddes = '"&kod&"'),   " & _   
                " FEC = (SELECT FECHA FROM RSV_TELA WHERE CODIGO='"&ahil(i)&"' AND ALM='"&ori&"'      " & _
                " and ofi ='"&ofi&"'     and replace(PO,' ','') = '"&po&"' and almdes = '"&des&"'     " & _
                " and coddes = '"&kod&"')                                                             " & _
                " FROM RSFACCAR..AL0001STOC WHERE SK_CALMA = '"&ori&"' AND SK_CCODIGO = '"&ahil(i)&"' " 
            'RESPONSE.WRITE(CAD)
		    RS.OPEN CAD, CNN%>           
		        <%if RS.RECORDCOUNT > 0 then%>
                    <tr class="textogris4">
			            <td><%=OFI%></td> 
                        <td><%=rs("SK_CCODIGO")%></td>
                        <td  style="color:navy;text-align:right"><%=formatnumber(akil(i),3,,,true)%></td>
                        <td><%=rs("sk_calma")%></td>
                        <%  rsv = FORMATNUMBER(rs("RSV"),3,,,TRUE)
                            if  cdbl(rs("SK_NSKDIS")) < 0 then 
                                stk = 0
                           else
                                stk = FORMATNUMBER(rs("SK_NSKDIS"),3,,,TRUE)
                           end if 
                        'response.end%>
                        <td style="text-align:right"><%=stk%></td>
                        <td style="text-align:right"><%=rsv%></td>
                        <td><%=rs("FEC")%></td>
                    </tr>
		        <%else%>
                    <tr  class="textogris4">
			            <td><%=OFI%></td> 
                        <td><%=aHil(i)%></td>
                        <td  style="color:navy; text-align:right"><%=formatnumber(akil(i),3,,,true)%></td>
                        <td><%=ori%></td>
                        <td style="text-align:right">0.000</td>
                        <td style="text-align:right">0.000</td>
                        <td>&nbsp;</td>
                    </tr>
                <%end if%>           
            <%rs.close%>
    <%NEXT%>	
   <!-- 
   <tr>
        <td colspan="3" align="right"><input type="button" class="botonok6" onclick="valida(1)" /></td>
        <td colspan="3" align="left" ><input type="button" class="botonok7" onclick="valida(2)" /></td>
   </tr> 
    -->
</table>

<script language="jscript" type="text/jscript">

function valida(op) {
    LIN = '<%=lin%>'
    maxi = '<%=i%>'
    var t = document.all.RESE;
    ofi = '<%=ofi%>'
    pos = '<%=po%>'
    ori = '<%=ori%>'
    lt1 = '<%=lt1%>'
    ser = '<%=ser%>'
    dd = 'OC' + LIN
    cad=''
    ell = parent.document.getElementById(dd);
     if (parseInt(op,10) == 1) {
     for (o = 1; o <= maxi; o++) {   
    
        str = trim(t.rows(o).cells(2).innerHTML)
        kil = str.replace(/,/g, "");
        str = trim(t.rows(o).cells(4).innerHTML)
        stk = str.replace(/,/g, "");
        cod = trim(t.rows(o).cells(1).innerHTML)
        str = trim(t.rows(o).cells(5).innerHTML)
        RSV = str.replace(/,/g, "");
       // alert(parseFloat(kil) - parseFloat(stk))    
        // SOLO VALIDA STOCK CUANDO ES UNA RESERVA
        if ((parseFloat(kil)+ parseFloat(RSV)) - (parseFloat(stk)) > 0) {
            alert("No tenemos suficiente stock de " + cod + " para mandar a Servicio")
            parent.document.getElementById(dd).style.display = 'none'
            return true;
        }       
    }  // del for
} // if del OP
 
        cad = '../comun/inserRSVhilo.asp?dele=' + parseInt(op, 10)
        cad += '&ahil=' + '<%=hil%>' + '&akil=' + '<%=kil%>'
        cad += '&ori=' + ori + '&ofi=' + ofi + '&pos=' + pos
        cad += '&lt1=' + lt1 + '&ser=' + ser + '&KOD=' + '<%=kod%>'
        cad += '&des=' + '<%=des%>'
 
 
    document.getElementById('head').src = cad   
}
//alert("reservhilo")




</script>
</body>
</html>
