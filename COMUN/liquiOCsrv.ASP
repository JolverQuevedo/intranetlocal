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
<body style="background-color:#FFf; margin-top:0; margin-left:0; margin-right:0; margin-bottom:10;">

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
' YA SABEMOS QUE ES un SERVICIO

tip =    "S"
OC  =    TRIM(REQUEST.QUERYSTRING("OC"))
pe  =    TRIM(REQUEST.QUERYSTRING("pe"))
ln  =    TRIM(REQUEST.QUERYSTRING("lin"))
fc  =    TRIM(REQUEST.QUERYSTRING("fec"))
cd  =    TRIM(REQUEST.QUERYSTRING("cod"))
qt  =    TRIM(REQUEST.QUERYSTRING("qty"))
mn  =    TRIM(REQUEST.QUERYSTRING("mon"))
' por las OC antiguas y los mamarrachos de RHIN, PRIMERO
' hay que buscar si el codigo de la linea de la OC esta definido en la matriz
mm= "select oc_ccodigo from RSFACCAR..co0001movd where  oc_cnumord = '"&oc&"' and oc_citem = '"&ln&"' "
'response.Write(mn)
rs.open mm,cnn
rs.movefirst
srv = rs("oc_ccodigo")
rs.close


lad = "select  OLDALM, ALMORI, ALMDES, CODSER, LET1,LET2,ENTREGA, RECIBE, CODSER from MATRIZ_COMPRA_TELA where codser = '"&srv&"' "
rs.open lad, cnn
if rs.recordcount <=0 then
    ' No es un servicio que se pueda valorizar 
%>
<script language="jscript" type="text/jscript">
    eval("parent.window.document.all.ame" + parseInt('<%=request.querystring("pos")%>',10) + ".style.display='none'")
    alert("Este SERVICIO ha sido ingresado manualmente (JF - RHIN)")
    // oculto el frame que haya estado abierto
    
    //eval("parent.window.document.all.ame" + oldframe + ".style.display='none'")

</script>
<%    response.end
end if

'response.write(lad)
RS.MOVEFIRST
MANDA = UCASE(TRIM(RS("ENTREGA")))
LLEGA = UCASE(TRIM(RS("RECIBE")))
OLD = RS("OLDALM")
ORI = RS("ALMORI")
DES = RS("ALMDES")
LET1 = RS("LET1")
LET2 = RS("LET2")

rs.close
ahil = array(null, "","","","","","")
apor = array(null, 0, 0, 0, 0, 0, 0)
aPre = array(null, 0, 0, 0, 0, 0, 0)
aDol = array(null, 0, 0, 0, 0, 0, 0)
aAlm = array(null, "","","","","","")
aDoc = array(null, "","","","","","")
pesouni=0
' TENEMOS el valor facturado, el valor segun PE Y EL FACTOR POR EL QUE MULTIPLICAR EL PRECIO UNITARIO DE LOS PE
' PRECIO UNITARIO DEL PE = FACTOR * PU anterior.... y recalculamos el resto del ingreso
' busca TODOS los PE de los servicios
    

    CAD =   " SELECT C6_CCODIGO, ltrim(rtrim(OC_CCODIGO)) as OC_CCODIGO, C6_NCANTID, C6_NPREUNI, C6_NPREUN1, C6_NMNPRUN, " & _
            " C6_NUSPRUN, C6_NTIPCAM, C6_NVALTOT, C6_NMNIMPO, C6_NUSIMPO, C5_CCODMON,   " & _
            " OC_CITEM, C6_CNUMDOC ,C6_CDESCRI , OC_CUNIDAD ,OC_NCANORD , OC_NPREUN2 ,  " & _
            "  CONVERT(VARCHAR, C5_DFECDOC, 103) AS FECHA, C5_CCODMOV ,oc_ntipcam,      " & _
            " (OC_NCANORD*OC_NPREUN2) as totoc                                          " & _
            " From RSFACCAR..CO0001MOVD AS CC                                           " & _    
            " inner join RSFACCAR..al0001movc AS A on cc.OC_CNUMORD = c5_cnumord        " & _
            " inner join RSFACCAR..co0001movc AS d on d.OC_CNUMORD = c5_cnumord         " & _  
            " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc           " & _
            " and c5_ctd = c6_ctd and c5_calma = c6_calma and OC_CITEM = C6_CITEMOC     " & _
            " Where cc.OC_CNUMORD='"&OC&"' AND OC_NCANORD > 0 and oc_ccodref = '"&cd&"' " & _
            " and OC_CITEM = '"&ln&"' and left(c6_ccodigo,1) <> 'S'                     " & _
            " and c6_cnumdoc = '"&pe&"'                                                 " & _
            " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                          " 
           
          '  response.write(cad)
            rs.open cad,cnn
    KAD = ""
    if rs.recordcount > 0 then rs.movefirst
     SRV = RS("OC_ccodigo") 
     art = rs("C6_CCODIGO")
     ate = cdbl(rs("C6_NCANTID"))
     cam = cdbl(rs("oc_ntipcam"))
     ser = cdbl(rs("OC_NPREUN2"))
     fec = rs("fecha")
     unitarioUS = cdbl(rs("C6_Nusprun"))
    ' response.write(ate)
%>

<%
alm= ""
doc = ""
bol = ""
IF UCASE(LET2) = "H" THEN  
    response.write(SRV)
    response.write("<br>")
    ' ESTO ES HILO CRUDO A HILO COLOR --> MISMO CODIGO DE ORIGEN
    ' CAPTURA EL PRECIO UNITARRIO DEL ULTIMO INGRESO POR COMPRA
    ' como iniciamos a la prepo... tengo que buscar en el almacen antiguo y en el almacen nuevo para ver si tienen precio unitario!
    MMB =   " SELECT TOP 1 C6_NUSPRUN, c6_calma, c6_cnumdoc From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
            " (C6_CALMA =  '"&ORI&"' or C6_CALMA =  '"&OLD&"') AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&ART&"'   " & _
            " ORDER BY C6_NUSPRUN desc, C6_DFECDOC DESC ;                                                         "    
    ' response.write(mmb)
    ' response.write("<br>")
    if rs.state <> 0 then rs.close
    RS.OPEN, MMB, CNN
    IF RS.RECORDCOUNT <= 0 THEN  ' -- IF ORI (1)%>
            <script language="javascript" type="text/jscript">
                alert("No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. ANTIGUO")
            </script>
            <%response.end
    ELSE
        PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
        PRETOTus = PRECIOus * ATE
        PRECIOmn = PRECIOus * CDBL(CAM)
        PRETOTmn = PRECIOmn * ATE
        aAlm(1) = rs("c6_calma")
        aDoc(1) = rs("c6_cnumdoc")
        aPre(1) = CDBL(RS("C6_NUSPRUN")) 
        aHil(1) = art
        aPor(1) = 1
        bol = CDBL(RS("C6_NUSPRUN")) 
    end if  ' -- END ORI (1)
    RS.CLOSE
'-----------------------------------------------------------------------------------------------------------------
' ST006 : es el unico que tiene de H --> C  
'-----------------------------------------------------------------------------------------------------------------
ELSEIF  UCASE(LET2) = "C"  THEN ' ES TELA CRUDA --> SE ENTREGA HILADO
    ' primero hay que buscar la composicion de la tela y despues buscamos los costos por fibra
    'response.write("ST006")
    'response.write("<br>") 
    TEL = LEFT(ART,6)
    mm = "Select HIL1, HIL2, HIL3, HIL4, HIL5, HIL6, POR1, POR2, POR3, POR4, POR5, POR6 From MODELADOR..TELAS WHERE TELA = '"&TEL&"' ; "
    ' response.write("CRUODOOOO")
    ' response.write("<br>")
    if rs.state <> 0 then rs.close
    RS.OPEN MM,CNN
    IF RS.RECORDCOUNT <= 0 THEN  'INICIO IF LET2 = C  (AAA) %>
        <script language="javascript" type="text/jscript">
            alert("No EXISTE la tela en el maestro")
        </script>
        <%response.end
    else ' ENCONTRO LA TELA Y TENGO LA MATERIA PRIMA DE LET2 = C  (AAA)
        H1 = rs("hil1")
        H2 = rs("hil2")
        H3 = rs("hil3")
        H4 = rs("hil4")
        H5 = rs("hil5")
        H6 = rs("hil6")
        P1 = CDBL(rs("POR1")) / 100
        P2 = CDBL(rs("POR2")) / 100
        P3 = CDBL(rs("POR3")) / 100
        P4 = CDBL(rs("POR4")) / 100
        P5 = CDBL(rs("POR5")) / 100
        P6 = CDBL(rs("POR6")) / 100
        
        aSol =  Array(null, 0, 0, 0, 0, 0, 0)
        aDol =  Array(null, 0, 0, 0, 0, 0, 0)
        aSoT =  Array(null, 0, 0, 0, 0, 0, 0)
        aDoT =  Array(null, 0, 0, 0, 0, 0, 0)
        aHil =  Array(null, H1, H2, H3, H4, H5, H6)
        aPor =  Array(null, P1, P2, P3, P4, P5, P6)
        PRECIOus = 0
        PRETOTus = 0
        PRECIOmn = 0
        PRETOTmn = 0
        FOR I = 1 TO 6
            IF CDBL(aPor(i)) > 0 THEN ' INICIO IF aPor
                RS.CLOSE
                hil= aHil(i)
                miko =  " SELECT TOP 1 C6_NUSPRUN, c6_calma, c6_cnumdoc  From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                        " (C6_CALMA =  '"&ORI&"' or  C6_CALMA =  '"&OLD&"')  AND C6_CCODIGO = '"&hil&"'       " & _
                        " ORDER BY C6_NUSPRUN desc, C6_DFECDOC DESC  ;                                                  "
                        'AND C6_CCODMOV = 'CO'
                if rs.state <> 0 then rs.close
                RS.OPEN MIKO, CNN
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (3) 
                    %><script language="javascript" type="text/jscript">
                          alert("No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. ANTIGUO --> " + '<%=hil%>')
                    </script>
                    <%response.end               
                end if '-- END Ori (3)
                aDol(i) = CDBL(RS("C6_NUSPRUN")) * aPor(i) 
                aAlm(i) = rs("c6_calma") 
                aDoc(i) = rs("c6_cnumdoc")
                aPre(i) =   cstr(aDol(i))
                bol = bol + cstr(aDol(i)) + " - "
            END IF ' FIN if aPor22
           ' estos son parciales con porcentajes
            aDoT(i) = aDol(i) * ATE              
            aSol(i) = aDol(i) * CDBL(CAM)
            aSoT(i) = aSol(i) * ATE 
            PRECIOus = PRECIOus + aDol(i) 
            PRETOTus = PRETOTus + aDoT(i)
            PRECIOmn = PRECIOmn + aSol(i)
            PRETOTmn = PRETOTmn + aSoT(i)
        NEXT
        '       HAY QUE SUMARLE EL COSTO UNITARIO DEL SERVICIO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        rs.close
        
        PRECIOus = PRECIOus  + cdbl(dol)
        PRETOTus = cdbl(PRECIOus) * cdbl(ate)
        PRECIOmn = PRECIOmn 
        PRETOTmn = PRECIOmn * cdbl(ate)

        'response.write(PRECIOus)
        'response.write("<br>")
        ' ya tengo los precios
    end if ' FIN DE LET2 = C  (AAA)
   
   
'--------------------------------------------------------------------------------------------------
' ST101  H --> T  (PARA RAYADOS, ENTREGO HILO COLOR Y REGRESA TELA COLOR " CRUDA" - SIN ACABAR)
'--------------------------------------------------------------------------------------------------
'                 00HT, 00HD  --> 00M7 
'--------------------------------------------------------------------------------------------------
ELSEIF UCASE(LET1) = "H" AND UCASE(LET2) = "T" AND UCASE(des) = "00M7"  then
    response.write("no esta en la matriz")
        response.write("<br>")
%>
    <script language="javascript" type="text/jscript">
        alert("MOVIMEITNO NO CONSIDERADO, la tela rayada se manda fabricar como \n  PRODUCTO TERMINADO")
    </script>
    <%RESPONSE.END

ELSEIF UCASE(LET1) = "H"  AND (UCASE(des) = "00MD" or UCASE(des) = "00M0")   then
   ' response.write("S 200")
   ' response.write("<br>")
' HE QUITADO AND UCASE(LET2) = "T"
'--------------------------------------------------------------------------------------------------
' ST200  H --> T                                00h0,  00HD  --> 00MD  (tela acabada) 
' SR200  H --> R                                00h0,  00HD  --> 00MD  (RECTILINEO acabada) 
' este DEBE ser el que MAS se use!!!!!!!!!!!!!!!!!!!!  
'--------------------------------------------------------------------------------------------------
 TEL = LEFT(ART,6)
' response.write(art)
 mm = "Select HIL1, HIL2, HIL3, HIL4, HIL5, HIL6, POR1, POR2, POR3, POR4, POR5, POR6, pesouni From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
 '   response.write(mm)
   ' response.write("<br>")
    if rs.state <> 0 then rs.close
    RS.OPEN MM,CNN
    IF RS.RECORDCOUNT <= 0 THEN  'INICIO IF LET2 = T  (SSS) %>
        <script language="javascript" type="text/jscript">
            alert("No EXISTE la tela en el maestro")
        </script>
        <%response.end
    else ' ENCONTRO LA TELA Y TENGO LA MATERIA PRIMA DE LET2 = T  (SSS)
        H1 = rs("hil1")
        H2 = rs("hil2")
        H3 = rs("hil3")
        H4 = rs("hil4")
        H5 = rs("hil5")
        H6 = rs("hil6")
        P1 = CDBL(rs("POR1")) / 100
        P2 = CDBL(rs("POR2")) / 100
        P3 = CDBL(rs("POR3")) / 100
        P4 = CDBL(rs("POR4")) / 100
        P5 = CDBL(rs("POR5")) / 100
        P6 = CDBL(rs("POR6")) / 100
        pesouni = cdbl(rs("pesouni"))
        aSol = array(null, 0,0,0,0,0,0)
        aDol = array(null, 0,0,0,0,0,0)
        aSoT = array(null, 0,0,0,0,0,0)
        aDoT = array(null, 0,0,0,0,0,0)
        aHil =  Array(null, H1, H2, H3, H4, H5, H6)
        aPor =  Array(null, P1, P2, P3, P4, P5, P6)
        PRECIOus = 0
        PRETOTus = 0
        PRECIOmn = 0
        PRETOTmn = 0
        FOR I = 1 TO 6
           ' RESPONSE.WRITE(cam&"-..-")
            IF CDBL(aPor(i)) > 0 THEN ' INICIO IF aPor22
                RS.CLOSE
                hil= aHil(i)
                miko =  " SELECT TOP 1 C6_NUSPRUN,c6_calma,c6_cnumdoc From RSFACCAR..AL0001MOVD Where C6_CTD = 'PE' AND   " & _
                        " (C6_CALMA =  '"&ORI&"' OR C6_CALMA =  '"&OLD&"') AND C6_CCODIGO = '"&hil&"'       " & _
                        " ORDER BY C6_NUSPRUN desc, C6_DFECDOC DESC  ;                                                  "
                        ' AND C6_CCODMOV = 'CO'
                if rs.state <> 0 then rs.close
                RS.OPEN MIKO, CNN
                'response.write(miko)
                'response.write("<br>")
                rs.movefirst
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (33) 
                        %><script language="javascript" type="text/jscript">
                              cad = "No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. --> " 
                              cad+= '<%=ori%>' + '-' + '<%=old%>' + '<%=hil%>'
                              alert(cad)
                        </script>
                        <%response.end
                else
                   
                    IF CDBL(RS("C6_NUSPRUN")) <= 0 THEN %>
                        <script language="javascript" type="text/jscript">
                            alert("No TENGO INGRESOS VALORIZADOS DE .... " + '<%=hil%>')
                        </script>
                        <%response.end
                   else
                     aPre(i) =  CDBL(RS("C6_NUSPRUN"))
                     aDol(i) = CDBL(RS("C6_NUSPRUN")) * aPor(i)     
                     aAlm(i) = rs("c6_calma") 
                     aDoc(i) = rs("c6_cnumdoc")

                     bol = bol + cstr(aDol(i)) + " - "
                '   RESPONSE.WRITE(aDol(i) )   
                '   RESPONSE.WRITE("<br>")
                    END IF             
                end if '-- END Ori (33)
            END IF ' FIN if aPor22
            
          '   RESPONSE.WRITE("<br>")
          '  response.write(pesouni)
          '   RESPONSE.WRITE("<br>")

            aDoT(i) = aDol(i) * ATE 
            if  UCASE(LET2) = "R" then aDol(i) =  aDol(i) *  pesouni                    
            aSol(i) = aDol(i) * CDBL(CAM)
            aSoT(i) = aSol(i) * ATE 
            PRECIOus = PRECIOus + aDol(i)
            PRETOTus = PRETOTus + aDoT(i)
            PRECIOmn = PRECIOmn + aSol(i)
            PRETOTmn = PRETOTmn + aSoT(i)
         '   RESPONSE.WRITE("<br>")
         '   RESPONSE.WRITE(precious)
         '   RESPONSE.WRITE("<br>")
          '  RESPONSE.WRITE("<br>")
        NEXT
        ' hay que sumar el costo del servicio para acumular
        rs.close
            PRECIOus = PRECIOus  + cdbl(dol)
            PRETOTus = cdbl(PRECIOus) * cdbl(ate)
            PRECIOmn = PRECIOmn 
            PRETOTmn = PRECIOmn * ate
        ' ya tengo los precios
        

    end if ' FIN DE LET2 = t  (sss)

ELSEIF (UCASE(LET1) = "C" AND UCASE(LET2) = "T") OR (UCASE(LET1) = "R" AND UCASE(LET2) = "R")   then ' TEÑIDO DE TELA ST015 / SR015 PARA RECTILINEOS....
     TEL = LEFT(ART,6)
     mm = "Select * From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
    'response.write(mm)
    ' response.write("<br>")
     if rs.state <> 0 then rs.close
    RS.OPEN MM,CNN
    IF RS.RECORDCOUNT <= 0 THEN  'INICIO IF LET2 = T  (333..SSS) %>
        <script language="javascript" type="text/jscript">
            alert("No EXISTE la tela en el maestro")
        </script>
        <%response.end
    else ' ENCONTRO LA TELA CRUDA EN EL MAESTRO  (333..SSS)
        TELA = TEL + "0000000000"
        pesouni = cdbl(rs("pesouni"))
        RS.CLOSE    
        miko =  " SELECT TOP 1 C6_NUSPRUN, c6_calma, c6_cnumdoc From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                " (c6_CALMA =  '"&ORI&"' or C6_CALMA =  '"&OLD&"' ) AND C6_CCODIGO = '"&TELA&"'      " & _
                " AND c6_dfecdoc < '"&fec&"'    " & _
                " ORDER BY C6_NUSPRUN desc,C6_DFECDOC DESC  ;                                                  "
                ' AND C6_CCODMOV = 'CO'
      '  response.write(miko)
       '  RESPONSE.WRITE("<br>")
       '   RESPONSE.WRITE("<br>")
        if rs.state <> 0 then rs.close
        RS.OPEN MIKO, CNN
        IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (RR)       %>
            <script language="javascript" type="text/jscript">
                alert("No se puede valorizar un servicio que no tiene ingreso \n de Tela Cruda ALM. --> " + '<%=tela%>')
            </script>
            <%'response.write(miko)
            response.end                    
        else
            aAlm(1) = rs("c6_calma")  
            aDoc(1) = rs("c6_cnumdoc") 
            aPre(1) = cstr(RS("C6_NUSPRUN"))
            aHil(1) = tela
            aPor(1) = 1
            aDol(1) = CDBL(RS("C6_NUSPRUN"))
            bol = bol + cstr(RS("C6_NUSPRUN"))
            PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
            PRETOTus = PRECIOus * ATE
            PRECIOmn = PRECIOus * CDBL(CAM)
            PRETOTmn = PRECIOmn * ATE
        end if '-- END Ori (RR)

         'RESPONSE.WRITE("<br>"+"dolores--")
         'response.write(precioUS)
         ' RESPONSE.WRITE("<br>")
    END IF ' FIN (333..SSS)
    

ELSEIF ((UCASE(LET1) = "T" AND UCASE(LET2) = "T") OR ( UCASE(LET1) = "R" AND UCASE(LET2) = "R" )) and (ucase(codmov) =  "SN" ) then 
    ' LOS DEMAS CASOS EN LOS QUE SALE TELA/RECTILINEO crudo Y REGRESA TELA/RECTILINEO ACABADOA
    ' LO UNICO QUE DIFERENCIA LOS SERVICIOS ES EL ALMACEN DE ORIGEN Y EL DE DESTINO
    response.write("ffffffffffffffffffffffff")
    TEL = LEFT(ART,6)
    mm = "Select * From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
  '  response.write(mm)
    ' response.write("<br>")
    if rs.state <> 0 then rs.close
    RS.OPEN MM,CNN
    IF RS.RECORDCOUNT <= 0 THEN  'INICIO IF LET2 = T  (333..SSS) %>
        <script language="javascript" type="text/jscript">
            alert("No EXISTE la tela en el maestro")
        </script>
        <%response.end
    else ' ENCONTRO LA TELA CRUDA EN EL MAESTRO  (333..SSS)
        TELA = tel + "0000000000"
        pesouni = cdbl(rs("pesouni"))
        RS.CLOSE    
        miko =  " SELECT TOP 1 C6_NUSPRUN, c6_calma, c6_cnumdoc From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                " (C6_CALMA =  '"&ORI&"' or C6_CALMA =  '"&OLD&"') AND C6_CCODIGO = '"&TELA&"'      " & _
                " ORDER BY C6_DFECDOC DESC  ;                                                  "
                ' AND C6_CCODMOV = 'CO' 
                if rs.state <> 0 then rs.close
                RS.OPEN MIKO, CNN
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (RR)                    
                    %><script language="javascript" type="text/jscript">
                          alert("No se puede valorizar un servicio que no tiene ingreso \n de Tela COLOR ALM.  --> " + '<%=ori%>' + '-' + '<%=old%>' + ' ' + '<%=tela%>')
                    </script>
                    <%'response.write(miko)
                      response.end                                    
                end if '-- END Ori (RR)
    END IF ' FIN (333..SSS)
    aAlm(1) = rs("c6_calma") 
    aDoc(1) = rs("c6_cnumdoc")
    aHil(1) = tela 
    aPor(1) = 1
    aPre(1) = CDBL(RS("C6_NUSPRUN"))
    aDol(1) = CDBL(RS("C6_NUSPRUN"))
    bol = CDBL(RS("C6_NUSPRUN"))
    PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
    PRETOTus = PRECIOus * ATE
    PRECIOmn = PRECIOus * CDBL(CAM)
    PRETOTmn = PRECIOmn * ATE


ELSEIF (UCASE(LET1) = "T" AND UCASE(LET2) = "T") OR ( UCASE(LET1) = "R" AND UCASE(LET2) = "R" )   then 
    ' LOS DEMAS CASOS EN LOS QUE SALE TELA/RECTILINEO COLOR Y REGRESA TELA/RECTILINEO ACABADOA
    ' LO UNICO QUE DIFERENCIA LOS SERVICIOS ES EL ALMACEN DE ORIGEN Y EL DE DESTINO
   ' response.write("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
    art = TRIM(REQUEST.QUERYSTRING("ART"))
    TEL = LEFT(ART,6)
    mm = "Select * From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
    response.write(mm)
     response.write("<br>")
     if rs.state <> 0 then rs.close
    RS.OPEN MM,CNN
    IF RS.RECORDCOUNT <= 0 THEN  'INICIO IF LET2 = T  (333..SSS) %>
        <script language="javascript" type="text/jscript">
            alert("No EXISTE la tela en el maestro")
        </script>
        <%response.end
    else ' ENCONTRO LA TELA CRUDA EN EL MAESTRO  (333..SSS)
        TELA = ART
        pesouni = cdbl(rs("pesouni"))
        RS.CLOSE    
        miko =  " SELECT TOP 1 C6_NUSPRUN, c6_calma, c6_cnumdoc From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                " (C6_CALMA =  '"&ORI&"' or C6_CALMA =  '"&OLD&"')  AND C6_CCODIGO = '"&TELA&"'      " & _
                " ORDER BY C6_DFECDOC DESC  ;                                                  "
                'AND C6_CCODMOV = 'CO'
                if rs.state <> 0 then rs.close
                RS.OPEN MIKO, CNN
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (RR)                    
                    %><script language="javascript" type="text/jscript">
                          alert("No se puede valorizar un servicio que no tiene ingreso \n de Tela COLOR ALM.  --> " + '<%=ori%>' + '-' + '<%=old%>' + ' ' + '<%=tela%>')
                    </script>
                    <%'response.write(miko)
                      response.end                                    
                end if '-- END Ori (RR)
    END IF ' FIN (333..SSS)
    aAlm(1) = rs("c6_calma")
    aDoc(1) = rs("c6_cnumdoc")
    aPre(1) =  CDBL(RS("C6_NUSPRUN"))
    aHil(1) = tela
    aPor(1) = 1
    aDol(1) = CDBL(RS("C6_NUSPRUN"))
    PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
    PRETOTus = PRECIOus * ATE
    PRECIOmn = PRECIOus * CDBL(CAM)
    PRETOTmn = PRECIOmn * ATE    
END IF ' FIN DE LOS IF ELSEIF DE LET1 - LET2 
'RESPONSE.WRITE( rs.state )
'response.write("<br>")




if cdbl(precioUS) <> cdbl(UNITARIOus) then revalorizado = cdbl(ser)+cdbl(precious)

%>
<!--
MANDA = <%=MANDA %>&nbsp; Precio Uni MAT. PRI US$: &nbsp; <%=precious%> &nbsp; Alm = &nbsp; <%=alm%> &nbsp; Doc = &nbsp;<%'=doc%> &nbsp; Pre = <%=bol%><br />
Valor Sericio = <%=CDBL(ser)%>  <br />
RECIBE = <%=llega%>&nbsp; Materia Prima + Valor Servicio UNITARIO = <%=revalorizado%> <br />


Poner Boton para actualizarla linea con el nuevo precio?
-->
<table  border="0" cellspacing="2" cellpadding="2" style="background-color:#FFC9AE"  align="center" width="100%" >
    <tr valign="middle">
        <td align="left" class="tituloGRANDEorange" width="100%" colspan="7" style="text-align:left; height:30px;"> CALCULO DEL VALOR FINAL....&nbsp;</td>
        <td class="tituloGRANDEorange" align="right"><img src="../imagenes/avios.jpg" style="cursor:pointer" onclick="graba()"/></td>
    </tr>
    <tr valign="middle" style="background-color:#ffffff">
        <td align="right" class="descriptornegro" width="10%"> Envia&nbsp;</td>
        <td align="left" class="descriptornegro" width="10%" colspan="7"><%=manda%></td>    
    </tr>
        <tr  style="background-color:#f0f0f0">
            <td align="center" class="descriptornegro" width="10%" > Alm&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" > Doc&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" > Materia Prima&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" >%&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" > Uni/Kg.&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" > Uni/%&nbsp;</td>
            <%if trim(ucase(let1))= "H" then tit = "Kgs/Pza" else tit = "" %>
            <td align="center" class="descriptornegro" width="10%" > <%=tit%>&nbsp;</td>
            <td align="center" class="descriptornegro" width="10%" > Uni/Pza&nbsp;</td>
        </tr>
        <%if left(art,1) = "9" then pesouni = formatnumber(pesouni,4,,,true) else pesouni= ""%>
        <%for i=1 to 6%> 
            <%if trim(aHil(i)) <> "" then %>
            <tr>
                <td align="center" class="descriptornegro" width="10%" style="background-color:#fff"><%=aAlm(i)%></td>
                <td align="center" class="descriptornegro" width="10%" style="background-color:#fff"><%=aDoc(i)%></td>
                <td align="center"class="descriptornegro" width="10%" style="background-color:#fff"><%=aHil(i)%> &nbsp;</td>
                <td align="center" class="descriptornegro" width="10%" style="background-color:#fff"><%=aPor(i)*100%></td>
                <td align="right" class="descriptornegro" width="10%" style="background-color:#fff"><%=formatnumber(aPre(i),4,,,true)%></td>
                <td align="right" class="descriptornegro" width="10%" style="background-color:#fff"><%=formatnumber(aPre(i)*aPor(i),4,,,true)%></td>
                  <%if trim(ucase(let1))= "H" then tit = pesouni else tit = "" %>
                <td align="right" class="descriptornegro" width="10%" style="background-color:#f0f0f0"><%=tit%></td>
                <td align="right" class="descriptornegro" width="10%" style="background-color:#fff"><%=formatnumber(aDol(i),4,,,true)%></td>            
            </tr>
            <%END IF%>
       <%next%>
       <tr>
           <td  align="right" class="descriptornegro" width="10%" style="background-color:#f0f0f0" colspan="7"><b>Total MP</b></td>
           <td align="right" class="descriptornegro" width="10%" style="background-color:#fff"><%=formatnumber(precious,4,,,true)%></td>
       </tr>
   
   <tr>
        <td  align="right" class="descriptornegro" width="10%" style="background-color:#f0f0f0" colspan="7"><b>Valor Servicio</b></td>
        <td align="right" class="descriptornegro" width="10%" style="background-color:#fff"><%=formatnumber(cdbl(ser),4,,,true)%></td>
   </tr>

   <tr class="descriptornegro" style="background-color:#ffffff">
      <td align="right"  > Recibe&nbsp;</td>
      <td align="left"     colspan="3"><%=llega %></td>
      <td align="right"  > Peso Kg&nbsp;</td>
      <td align="left"   ><%=pesouni %></td>
      <td  align="right" style="background-color:#f0f0f0"><b>Revalorizado</b></td>
      <td align="right"  style="background-color:#fff"><%=formatnumber(cdbl(revalorizado),4,,,true)%></td>
   </tr>
</table>
 <iframe id="kuku" style="width:100%;border:none;display:none;" ></iframe>

<%



Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>

<script language="jscript" type="text/jscript">
function graba() {
    document.all.kuku.style.display='block'
    cad  = 'REVALpeLIN.ASP?doc=' + trim('<%=pe%>')
    cad += '&cod=' + trim('<%=cd%>')
    cad += '&lin=' + trim('<%=ln%>')
    cad += '&cam=' + parseFloat('<%=cam%>')
    cad += '&pre=' + parseFloat('<%=revalorizado%>')
    cad += '&alm=' + trim('<%=des%>')
  //  alert(cad)
    document.all.kuku.src = cad
}
</script>

</body>
</HTML>

