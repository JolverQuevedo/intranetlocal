<%@ Language=VBScript%>
<%Session.LCID=2057%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	
pos = Request.QueryString("pos")
srv = Request.QueryString("srv")
ITM = Request.QueryString("ITM")
alm = Request.QueryString("alm")
pe2 = Request.QueryString("pe2")
ctd = Request.QueryString("ctd")
%>
    <script language="jscript" type="text/jscript">
        window.parent.document.all.chks.value = '1'
     //   alert()
    </script>
<%
' HAY QUE JALAR DE LA TABLA DE PARAMETROS EL PORCENTAJE DE TOLERANCIA PARA LA ATENCION DE LAS COMPRAS
RS.OPEN "Select TG_CDESCRI From RSFACCAR..AL0001TABL WHERE TG_CCOD='93' And TG_CCLAVE='EXCECOM' ",CNN

IF RS.RECORDCOUNT > 0 THEN TOLERANCIA=1+(CDBL(RS("TG_CDESCRI"))/100) ELSE TOLERANCIA = 1
RS.CLOSE

CAD =   " Select OC_CITEM, OC_CCODIGO, OC_CCODREF, OC_CDESREF, OC_CUNIDAD, CONVERT(NUMERIC(13,3),OC_NCANORD) AS OC_NCANORD,OC_NPREUN2,  " & _
        " CONVERT(NUMERIC(13,3), (OC_NCANORD*"&TOLERANCIA&")-ISNULL((select sum(c6_ncantid) from RSFACCAR..al0001movc AS A inner join   " & _
        " RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&pos&"'   " & _
        " AND C6_CITEM ='"&itm&"' AND C6_CCODIGO='"&ref&"' and left(c6_ccodigo,1) <> 'S'),0)) AS PORATENDER, CONVERT(NUMERIC(13,3), ((OC_NCANORD*"&tolerancia&")-" & _
        " OC_NCANTEN)) AS OC_NCANTEN, OC_NCANSAL, OC_NANCHO, OC_NCORTE, OC_CESTADO, OC_NPREUN2, OC_CNUMORD, OC_NIGVPOR,                 " & _
        " (select isnull(sum(c6_ncantid),0) from RSFACCAR..al0001movc AS A inner join                                                             " & _
        " RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&pos&"'   " & _
        " AND C6_CITEM ='"&itm&"' and left(c6_ccodigo,1) <> 'S') AS RECIBIDO From RSFACCAR..CO0001MOVD                                  " & _
        " Where OC_CNUMORD= '"&pos&"' AND OC_CITEM = '"&ITM&"'                                                                          "
RESPONSE.WRITE(CAD)
 RESPONSE.WRITE("<BR>")
 RS.OPEN CAD, CNN

	if RS.RECORDCOUNT > 0 then
        
        ref = rs("OC_CCODIGO")
    %>
		<script type="text/jscript" language="jscript">
		    cod = '<%=rs("OC_CCODIGO")%>'
		    ds1 = '<%=rs("OC_CDESREF")%>'
		    kod = '<%=rs("OC_CCODIGO")%>'
		    ate = '<%=rs("PORATENDER")%>'
		    unm = '<%=rs("OC_CUNIDAD")%>'
		    RECIBIDO = '<%=formatnumber(RS("RECIBIDO"),3,,,true)%>'
		    ord = FormatNumber(parseFloat('<%=rs("OC_NCANORD")%>'), 3, true, true, true,true)
		    pun = FormatNumber(parseFloat('<%=rs("OC_NPREUN2")%>'), 6, true, true, true,true)
		    ate = parseFloat('<%=rs("PORATENDER")%>')
		    rec = FormatNumber(parseFloat('<%=rs("OC_NCANTEN")%>'), 3, true, true, true,true)
		    //  ate = FormatNumber(parseFloat('<%=rs("OC_NCANSAL")%>'), 3, true, true, true, true)
            tol = parseFloat(ate)* parseFloat('<%=tolerancia%>')
		    if (Left(trim(kod), 1) == '9') {
		        window.parent.document.all.tallas.style.display = 'block'
		        window.parent.document.all.tallasR.style.display = 'block'
		    }
		    else {
		        window.parent.document.all.tallas.style.display = 'none'
		        window.parent.document.all.tallasR.style.display = 'none'
		    }
			window.parent.document.all.codi.value = cod
			window.parent.document.all.dscr.value = ds1
			window.parent.document.all.orde.value = ord
			window.parent.document.all.unid.value = unm
			window.parent.document.all.puni.value = pun
			//alert(ord - ate + tol)
			window.parent.document.all.pund.value = pun
			window.parent.document.all.xrec.value = Math.ceil(ord - ate + tol)
			window.parent.document.all.reci.value = RECIBIDO
			window.parent.document.all.rea.value = '<%=rea %>'
			window.parent.document.all.tipc.value = top.window.document.all.CAM.value
			//eval("window.parent.document.all.aten.value=ate")
           // alert(pun)
			
        </script>
<%end if%>

<%' DETALLE DE DECRIPCION, UNIDADES, PRECIOS, ETC.
CAD =   "Select AR_CFSERIE, AR_CUNIDAD,  AR_CFSERIE, AR_CFLOTE,AR_NPRECI2 , AR_NPRECI1  AR_CMONVTA,                                                                              " & _
        " (Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='05' And TG_CCLAVE=(Select AR_CUNIDAD From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&ref&"')) AS TG_CDESCRI, " & _ 
        " (Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='03' And TG_CCLAVE=(Select OC_CCODMON From RSFACCAR..CO0001MOVC FF Where OC_CNUMORD='"&pos&"')) AS COD_MON, " & _
        " (Select TG_CCLAVE From RSFACCAR..AL0001TABL Where TG_CCOD='03' And TG_CCLAVE=(Select OC_CCODMON From RSFACCAR..CO0001MOVC FF Where OC_CNUMORD='"&pos&"')) AS DES_MON   " & _
        " From RSFACCAR..AL0001ARTI  Where AR_CCODIGO='"&ref&"'                                                                                                                  "    

        RS.CLOSE
        RESPONSE.WRITE(CAD)
		RS.OPEN CAD, CNN

		if RS.RECORDCOUNT > 0 then%>
			<script type="text/jscript" language="jscript">
			    mon = '<%=rs("cod_MON")%>'
			    ds1 = '<%=rs("TG_CDESCRI")%>'
			    dun = '<%=rs("TG_CDESCRI")%>'
			    ttt = parseFloat(ord) * parseFloat(pun)
			    tot = FormatNumber(parseFloat(ttt), 2, true, true, true, true)
			    window.parent.document.all.dmon.value = mon
			    window.parent.document.all.mone.value = mon
			   // window.parent.document.all.dsar.value = ds1
			    window.parent.document.all.dsun.value = dun
			    window.parent.document.all.tota.value = tot
			    window.parent.document.all.aten.style.textAlign = 'right'
            </script>
		 <% if left(trim(ref),1) = "9" then
              

                rs.close
                cad = " select aa.*, " & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='0' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R0," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='1' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R1," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='2' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R2," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='3' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R3," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='4' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R4," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='5' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R5," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='6' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R6," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='7' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R7," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='8' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R8," & _
                " isnull((select sum(cantidad) from multi..RS_ALMOVD_TALLA0001 as tt inner join multi..rs_almovd0001 as dd on tt.calma collate Modern_Spanish_CI_AS = dd.calma and dd.citem = '"&itm&"' and tt.CNUMDOC collate Modern_Spanish_CI_AS = dd.CNUMDOC where cnumord = '"&pos&"' and left(CCODIGO,1) <> 'S'and orden='9' and tt.citem collate Modern_Spanish_CI_AS= dd.citem and dd.ccodigo = '"&ref&"'),0) as R9 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 0),0) as c0 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 1),0) as c1 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 2),0) as c2 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 3),0) as c3 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 4),0) as c4 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 5),0) as c5 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 6),0) as c6 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 7),0) as c7 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 8),0) as c8 " & _
                " , isnull((select cantidad from multi..RS_ALMOVD_TALLA0001 where calma = '"&alm&"' and ctd = 'PE' and cnumdoc = '"&pe2&"' and citem = '"&itm&"' and orden = 9),0) as c9 " & _
                "  from modelador..octalla as aa where numord = '"&pos&"'  and item='"&itm&" ' "

                response.write(cad)
                rs.open cad, cnn
                if rs.recordcount > 0 then%>
                    <script type="text/jscript" language="jscript">
                        window.parent.document.getElementById("aten").disabled = true;
                        // por lo menos tiene una talla si es rectilineo
                        window.parent.document.all.t0.innerText = '<%=rs("t0")%>'
                        window.parent.document.all.t1.innerText = '<%=rs("t1")%>'
                        window.parent.document.all.t2.innerText = '<%=rs("t2")%>'
                        window.parent.document.all.t3.innerText = '<%=rs("t3")%>'
                        window.parent.document.all.t4.innerText = '<%=rs("t4")%>'
                        window.parent.document.all.t5.innerText = '<%=rs("t5")%>'
                        window.parent.document.all.t6.innerText = '<%=rs("t6")%>'
                        window.parent.document.all.t7.innerText = '<%=rs("t7")%>'
                        window.parent.document.all.t8.innerText = '<%=rs("t8")%>'
                        window.parent.document.all.t9.innerText = '<%=rs("t9")%>'
                        window.parent.document.all.tt0.innerText = '<%=rs("t0")%>'
                        window.parent.document.all.tt1.innerText = '<%=rs("t1")%>'
                        window.parent.document.all.tt2.innerText = '<%=rs("t2")%>'
                        window.parent.document.all.tt3.innerText = '<%=rs("t3")%>'
                        window.parent.document.all.tt4.innerText = '<%=rs("t4")%>'
                        window.parent.document.all.tt5.innerText = '<%=rs("t5")%>'
                        window.parent.document.all.tt6.innerText = '<%=rs("t6")%>'
                        window.parent.document.all.tt7.innerText = '<%=rs("t7")%>'
                        window.parent.document.all.tt8.innerText = '<%=rs("t8")%>'
                        window.parent.document.all.tt9.innerText = '<%=rs("t9")%>'

                        window.parent.document.all.qq0.value = '<%=rs("q0")%>'
                        window.parent.document.all.qq1.value = '<%=rs("q1")%>'
                        window.parent.document.all.qq2.value = '<%=rs("q2")%>'
                        window.parent.document.all.qq3.value = '<%=rs("q3")%>'
                        window.parent.document.all.qq4.value = '<%=rs("q4")%>'
                        window.parent.document.all.qq5.value = '<%=rs("q5")%>'
                        window.parent.document.all.qq6.value = '<%=rs("q6")%>'
                        window.parent.document.all.qq7.value = '<%=rs("q7")%>'
                        window.parent.document.all.qq8.value = '<%=rs("q8")%>'
                        window.parent.document.all.qq9.value = '<%=rs("q9")%>'

                        window.parent.document.all.rr0.value = '<%=rs("r0")%>'
                        window.parent.document.all.rr1.value = '<%=rs("r1")%>'
                        window.parent.document.all.rr2.value = '<%=rs("r2")%>'
                        window.parent.document.all.rr3.value = '<%=rs("r3")%>'
                        window.parent.document.all.rr4.value = '<%=rs("r4")%>'
                        window.parent.document.all.rr5.value = '<%=rs("r5")%>'
                        window.parent.document.all.rr6.value = '<%=rs("r6")%>'
                        window.parent.document.all.rr7.value = '<%=rs("r7")%>'
                        window.parent.document.all.rr8.value = '<%=rs("r8")%>'
                        window.parent.document.all.rr9.value = '<%=rs("r9")%>'

                        window.parent.document.all.q0.value = '<%=rs("c0")%>'
                        window.parent.document.all.q1.value = '<%=rs("c1")%>'
                        window.parent.document.all.q2.value = '<%=rs("c2")%>'
                        window.parent.document.all.q3.value = '<%=rs("c3")%>'
                        window.parent.document.all.q4.value = '<%=rs("c4")%>'
                        window.parent.document.all.q5.value = '<%=rs("c5")%>'
                        window.parent.document.all.q6.value = '<%=rs("c6")%>'
                        window.parent.document.all.q7.value = '<%=rs("c7")%>'
                        window.parent.document.all.q8.value = '<%=rs("c8")%>'
                        window.parent.document.all.q9.value = '<%=rs("c9")%>'

                        window.parent.document.all.QTOC.value = '<%=rs("q0")+rs("q1")+rs("q2")+rs("q3")+rs("q4")+rs("q5")+rs("q6")+rs("q7")+rs("q8")+rs("q9")%>'
                        window.parent.document.all.QTPE.value = '<%=rs("r0")+rs("r1")+rs("r2")+rs("r3")+rs("r4")+rs("r5")+rs("r6")+rs("r7")+rs("r8")+rs("r9")%>'
                        window.parent.document.all.aten.value = '<%=rs("c0")+rs("c1")+rs("c2")+rs("c3")+rs("c4")+rs("c5")+rs("c6")+rs("c7")+rs("c8")+rs("c9")%>'


                        window.parent.document.all.reci.value = window.parent.document.all.QTPE.value
                        window.parent.document.all.xrec.value = Math.ceil(ord-ate+tol)
                        //window.parent.document.all.QTOC.value - window.parent.document.all.reci.value

                        if (trim('<%=rs("t1")%>') == '') {
                            window.parent.document.all.q1.style.display = 'none'
                            window.parent.document.all.qq1.style.display = 'none'
                            window.parent.document.all.rr1.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q1.style.display = 'block'
                            window.parent.document.all.qq1.style.display = 'block'
                            window.parent.document.all.rr1.style.display = 'block'
                        }
                        if (trim('<%=rs("t2")%>') == '') {
                            window.parent.document.all.q2.style.display = 'none'
                            window.parent.document.all.qq2.style.display = 'none'
                            window.parent.document.all.rr2.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q2.style.display = 'block'
                            window.parent.document.all.qq2.style.display = 'block'
                            window.parent.document.all.rr2.style.display = 'block'
                        }
                        if (trim('<%=rs("t3")%>') == '') {
                            window.parent.document.all.q3.style.display = 'none'
                            window.parent.document.all.qq3.style.display = 'none'
                            window.parent.document.all.rr3.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q3.style.display = 'block'
                            window.parent.document.all.qq3.style.display = 'block'
                            window.parent.document.all.rr3.style.display = 'block'
                        }
                        if (trim('<%=rs("t4")%>') == '') {
                            window.parent.document.all.q4.style.display = 'none'
                            window.parent.document.all.qq4.style.display = 'none'
                            window.parent.document.all.rr4.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q4.style.display = 'block'
                            window.parent.document.all.qq4.style.display = 'block'
                            window.parent.document.all.rr4.style.display = 'block'
                        }
                        if (trim('<%=rs("t5")%>') == '') {
                            window.parent.document.all.q5.style.display = 'none'
                            window.parent.document.all.qq5.style.display = 'none'
                            window.parent.document.all.rr5.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q5.style.display = 'block'
                            window.parent.document.all.qq5.style.display = 'block'
                            window.parent.document.all.rr5.style.display = 'block'
                        }
                        if (trim('<%=rs("t6")%>') == '') {
                            window.parent.document.all.q6.style.display = 'none'
                            window.parent.document.all.qq6.style.display = 'none'
                            window.parent.document.all.rr6.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q6.style.display = 'block'
                            window.parent.document.all.qq6.style.display = 'block'
                            window.parent.document.all.rr6.style.display = 'block'
                        }
                        if (trim('<%=rs("t7")%>') == '') {
                            window.parent.document.all.q7.style.display = 'none'
                            window.parent.document.all.qq7.style.display = 'none'
                            window.parent.document.all.rr7.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q7.style.display = 'block'
                            window.parent.document.all.qq7.style.display = 'block'
                            window.parent.document.all.rr7.style.display = 'block'
                        }
                        if (trim('<%=rs("t8")%>') == '') {
                            window.parent.document.all.q8.style.display = 'none'
                            window.parent.document.all.qq8.style.display = 'none'
                            window.parent.document.all.rr8.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q8.style.display = 'block'
                            window.parent.document.all.qq8.style.display = 'block'
                            window.parent.document.all.rr8.style.display = 'block'
                        }
                        if (trim('<%=rs("t9")%>') == '') {
                            window.parent.document.all.q9.style.display = 'none'
                            window.parent.document.all.qq9.style.display = 'none'
                            window.parent.document.all.rr9.style.display = 'none'
                        }
                        else {
                            window.parent.document.all.q9.style.display = 'block'
                            window.parent.document.all.qq9.style.display = 'block'
                            window.parent.document.all.rr9.style.display = 'block'
                        }
                        window.parent.document.all.aten.style.readOnly = true;
                        window.parent.document.getElementById("aten").disabled = true;
                        window.parent.document.all.aten.style.textAlign = 'right'                    
                    </script>
                <%end if%>
            <%else %>
            <script language="javascript" type="text/jscript">
                window.parent.document.all.aten.style.readOnly = false;
                window.parent.document.getElementById("aten").disabled = false;
                // window.parent.document.all.aten.value = RECIBIDO
                //   window.parent.document.all.reci.value = RECIBIDO
                //      window.parent.document.all.xrec.value = ATE
            
            </script>
             <%end if%>
        <%end if%>
         <script language="javascript" type="text/jscript">
             window.parent.document.all.PWD.value = '';

             // window.parent.document.all.aten.value = RECIBIDO
             //   window.parent.document.all.reci.value = RECIBIDO
             //      window.parent.document.all.xrec.value = ATE
            
            </script>
</BODY>
</HTML>
