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


fin =   trim(request.querystring("fin"))
srv =   TRIM(REQUEST.QUERYSTRING("srv"))
DET =   left(TRIM(REQUEST.QUERYSTRING("DET")),50)
RS.OPEN "select * from MODELADOR..MATRIZ_COMPRA_TELA WHERE CODSER = '"&SRV&"'", CNN
'RESPONSE.WRITE(RS.RECORDCOUNT)

IF RS.RECORDCOUNT <= 0 THEN %>
    <script language="jscript" type="text/jscript">
        alert("No está DEFINIDO este servicio en la matriz\n Avisar a Sistemas..")
    </script>
<%RESPONSE.End
END IF
RS.MOVEFIRST
ORI = RS("ALMORI")
DES = RS("ALMDES")
old = RS("OLDALM")
LET1 = RS("LET1")
LET2 = RS("LET2")


RS.CLOSE
OC =    TRIM(REQUEST.QUERYSTRING("OC"))
' Bloqueo la OC para que otro no meta la manotas
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='1' Where OC_CNUMORD='"&OC&"' ; "

lin =    right("0000" +TRIM(REQUEST.QUERYSTRING("lin")),4)
ate =    TRIM(REQUEST.QUERYSTRING("CAN"))
nro =    TRIM(REQUEST.QUERYSTRING("nro"))
glo =    TRIM(REQUEST.QUERYSTRING("glo"))
ref =    LEFT(GLO,2)
pe1 =    right("00000000000" + TRIM(REQUEST.QUERYSTRING("pe1")),11)
pe2 =    right("00000000000" + TRIM(REQUEST.QUERYSTRING("pe2")),11)
ps1 =    right("00000000000" + TRIM(REQUEST.QUERYSTRING("ps1")),11)
dol =    TRIM(REQUEST.QUERYSTRING("pu2"))
cam =    TRIM(REQUEST.QUERYSTRING("cam"))
ART =    TRIM(REQUEST.QUERYSTRING("ART"))
rea =    TRIM(REQUEST.QUERYSTRING("rea"))
sol = cdbl(dol) * cdbl(cam)
doltot = cdbl(ate) * cdbl(dol)
soltot = cdbl(ate) * cdbl(sol)
Dim aPor
dim aHil
dim aSOL
precious=0
pretotus=0
preciomn =0
pretotmn=0
ata  = ucase(TRIM(Request.QueryString("ata")))
aca  = ucase(TRIM(Request.QueryString("aca")))
aTal = Split(ata, ",") 
aCan = Split(aca, ",")
'response.write(ata)
'response.write("<br>")
'response.write(aca)
'response.write("<br>")

pesouni = 0
'---------------------------------------------------------------------------------------------
' VERIFICAMOS LOS CONTADORES PARA LOS PARTES QUE SE VAN A GENERAR
'---------------------------------------------------------------------------------------------

rs.open "select A1_NNUMENT, A1_NNUMsal from RSFACCAR..AL0001ALMA  Where A1_CALMA='"&DES&"' "
IF RS.RECORDCOUNT <= 0 THEN %>
    <script language="jscript" type="text/jscript">
        alert("No hay DEFINIDOS contadores para almacen : \n"+ '<%=ucase(des)%>'+ '\nAvisar a Sistemas')
    </script>
<%RESPONSE.End
END IF
rs.close

'-----------------------------------------------------------------------------------------------------------------
'actualizamos la linea de detalle de la OC 
' en el item que estamos trabajando con la cantidad que estamos ingresando
'' primero sumamos las atenciones PARCIALES del item para poder calcular el saldo POR ATENDER!

MUD = "select isnull(OC_NCANTEN,0)+"&ate&" as aten from RSFACCAR..CO0001MOVD Where OC_CNUMORD='"&oc&"' AND OC_CITEM='"&lin&"'"
rs.open MUD, cnn

' response.write("<br>")
' RESPONSE.WRITE(MUD)
' response.write("<br>")
if rs.recordcount > 0 then atendido = cdbl(rs("aten")) else atendido = ate
rs.close
cad = "Update RSFACCAR..CO0001MOVD Set OC_NCANTEN="&ateNDIDO&", OC_CESTADO='4', OC_NCANSAL =  OC_NCANORD-"&atendido&" Where OC_CNUMORD='"&oc&"' AND OC_CITEM='"&lin&"'"
' response.write("<br>")
' RESPONSE.WRITE(CAD)
' RESPONSE.END
'-----------------------------------------------------------------------------------------------------------------
' VEMOS SI EXISTE EN ALMACEN EL PARTE DE ENTRADA 
'-----------------------------------------------------------------------------------------------------------------
rs.open "select * from RSFACCAR..AL0001MOVC where C5_CALMA = '"&des&"' and C5_CTD = 'PE' AND C5_CNUMDOC = '"&PE1&"' ", CNN

IF RS.RECORDCOUNT <= 0 THEN
' NO EXISTE, SE HACE EL INSERT
' primero jalamos datos de la OC
    rs.close
    lad = "Select * From RSFACCAR..CO0001MOVC Where OC_CNUMORD= '"&oc&"'; "
    'response.write("<br>")
  '  response.write(request.QueryString)
    'response.write("<br>")
    rs.open lad, cnn
    rs.movefirst
    ruc = rs("oc_ccodpro")
    pro = rs("oc_crazsoc")
    mon = rs("OC_CCODMON")
    kam = rs("oc_ntipcam")
    
    '--------------------------
    '       CABECERAS
    '--------------------------
    ' parte de entrada por el servicio
    cad = cad + " Insert Into RSFACCAR..AL0001MOVC(C5_CALMA, C5_CTD, C5_CNUMDOC, C5_DFECDOC, C5_CTIPMOV, C5_CCODMOV, C5_CRFTDOC,    " & _
                " C5_CRFNDOC, C5_CGLOSA1, C5_DFECCRE, C5_CUSUCRE, C5_CNUMORD, C5_CNUMLIQ, C5_CCODPRO, C5_CNOMPRO, C5_CCODMON,       " & _
                " C5_CTIPO, C5_NTIPCAM, C5_CSITUA, C5_CLOCALI) Values ('"&des&"','PE','"&pe1&"', getdate(),'E','CO','"&ref&"',      " & _
                " '"&nro&"','"&glo&"',GETDATE(),'"&USUARIO&"','"&oc&"','','"&RUC&"','"&pro&"','"&mon&"','V',"&kam&",'V','0001');    "
    ' parte de salida por el servicio
    cad = cad + " Insert Into RSFACCAR..AL0001MOVC(C5_CALMA, C5_CTD, C5_CNUMDOC, C5_DFECDOC, C5_CTIPMOV, C5_CCODMOV, C5_CRFTDOC,    " & _
                " C5_CRFNDOC, C5_CGLOSA1, C5_DFECCRE, C5_CUSUCRE, C5_CNUMORD, C5_CNUMLIQ, C5_CCODPRO, C5_CNOMPRO, C5_CCODMON,       " & _
                " C5_CTIPO, C5_NTIPCAM, C5_CSITUA, C5_CLOCALI) Values ('"&des&"','PS','"&ps1&"', getdate(),'S','CO','"&ref&"',      " & _
                " '"&nro&"','"&glo&"',GETDATE(),'"&USUARIO&"','"&oc&"','','"&RUC&"','"&pro&"','"&mon&"','V',"&kam&",'V','0001') ;   "
    ' PARTE DE ENTRADA POR EL PRODUCTO TERMINADO
    cad = cad + " Insert Into RSFACCAR..AL0001MOVC(C5_CALMA, C5_CTD, C5_CNUMDOC, C5_DFECDOC, C5_CTIPMOV, C5_CCODMOV, C5_CRFTDOC,    " & _
                " C5_CRFNDOC, C5_CGLOSA1, C5_DFECCRE, C5_CUSUCRE, C5_CNUMORD, C5_CNUMLIQ, C5_CCODPRO, C5_CNOMPRO, C5_CCODMON,       " & _
                " C5_CTIPO, C5_NTIPCAM, C5_CSITUA, C5_CLOCALI) Values ('"&des&"','PE','"&pE2&"', getdate(),'E','"&rea&"','"&ref&"',      " & _
                " '"&nro&"','"&glo&"',GETDATE(),'"&USUARIO&"','"&oc&"','','"&RUC&"','"&pro&"','"&mon&"','V',"&kam&",'V','0001') ;   "
END IF
rs.close
    lad = "Select * From RSFACCAR..CO0001MOVd Where OC_CNUMORD= '"&oc&"' and OC_CITEM='"&lin&"'; "
    'response.write("<br>")
    'response.write(lad)
    'response.write("<br>")
    rs.open lad, cnn
    rs.movefirst
    sal = cdbl(rs("OC_NCANSAL"))
RS.CLOSE
'-----------------------------------------------------------------------------------------------------------------
' ELIMINAMOS LAS LINEAS DE DETALLE Y LAS VOLVEMOS A CREAR (POR SI HAN EDITADO ANTES DE FINALIZAR)
'-----------------------------------------------------------------------------------------------------------------
' elimino por el número de linea de la OC que tengo en el grid de la atención, 
' porque tengo que generar un nuevo correlativo en el detalle del parte
 cad = cad +    " delete RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and C6_CNUMDOC = '"&pe1&"' and C6_CITEMOC = '"&lin&"' ; "
 cad = cad +    " delete RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PS' and C6_CNUMDOC = '"&pS1&"' and C6_CITEMOC = '"&lin&"' ; "
 cad = cad +    " delete RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and C6_CNUMDOC = '"&pe2&"' and C6_CITEMOC = '"&lin&"' ; "
 ' parte de entrada por compra del servicio
 cad = cad +    " Insert Into RSFACCAR..AL0001MOVD(C6_CALMA,C6_CLOCALI,C6_CTD,C6_CNUMDOC,C6_CITEM,C6_CCODIGO,C6_CDESCRI, " & _
                " C6_CITEMOC,C6_NCANTID,C6_NVALTOT,C6_NUSIMPO,C6_NUSPRUN,C6_NMNIMPO,C6_NMNPRUN,C6_NPREUN1,C6_NPREUNI,    " & _
                " C6_DFECDOC,C6_CCODMOV,C6_CESTADO,C6_CCODMON,C6_CTIPO,C6_NTIPCAM,C6_NPORDE1,C6_NIMPO1,C6_NPORDE2,       " & _
                " C6_NIMPO2,C6_NPORDE4,C6_NIMPO4, C6_NPORDES,C6_NDESCTO) Values('"&des&"','0001','PE','"&pe1&"',         " & _
                " '"&lin&"', '"&SRV&"', '"&DET&"','"&lin&"',"&ate&","&doltot&","&doltot&","&dol&","&soltot&","&sol&",    " & _
                " "&dol&","&dol&", getdate(),'CO','V','US','V',"&cam&",0,0,0,0,0,0,0,0) ;                                " 
' parte de salida por compra del servicio --> solo para que paguen la factura
 cad = cad +    " Insert Into RSFACCAR..AL0001MOVD(C6_CALMA,C6_CLOCALI,C6_CTD,C6_CNUMDOC,C6_CITEM,C6_CCODIGO,C6_CDESCRI, " & _
                " C6_CITEMOC,C6_NCANTID,C6_NVALTOT,C6_NUSIMPO,C6_NUSPRUN,C6_NMNIMPO,C6_NMNPRUN,C6_NPREUN1,C6_NPREUNI,    " & _
                " C6_DFECDOC,C6_CCODMOV,C6_CESTADO,C6_CCODMON,C6_CTIPO,C6_NTIPCAM,C6_NPORDE1,C6_NIMPO1,C6_NPORDE2,       " & _
                " C6_NIMPO2,C6_NPORDE4,C6_NIMPO4, C6_NPORDES,C6_NDESCTO) Values('"&des&"','0001','PS','"&ps1&"',         " & _
                " '"&lin&"', '"&SRV&"', '"&DET&"','"&lin&"',"&ate&","&doltot&","&doltot&","&dol&","&soltot&","&sol&",    " & _
                " "&dol&","&dol&", getdate(),'CO','V','US','V',"&cam&",0,0,0,0,0,0,0,0) ;                                " 

'-----------------------------------------------------------------------------------------------------------------
' para el parte de entrada del Producto "terminado", hay que acumular el precio del servicio + el costo de la 
' ultima entrada de materia prima .... del almacén de origen!
'-----------------------------------------------------------------------------------------------------------------
' ST006 -> es el unico que tiene H --> H
'-----------------------------------------------------------------------------------------------------------------

IF UCASE(LET2) = "H" THEN  
'ST015
    ' ESTO ES HILO CRUDO A HILO COLOR --> MISMO CODIGO DE ORIGEN
    ' CAPTURA EL PRECIO UNITARRIO DEL ULTIMO INGRESO POR COMPRA
    MMB =   " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
            " C6_CALMA =  '"&ORI&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&ART&"'        " & _
            " ORDER BY C6_DFECDOC DESC ;                                                    "    
    ' response.write(mmb)
    ' response.write("<br>")
    RS.OPEN, MMB, CNN
    IF RS.RECORDCOUNT <= 0 THEN  ' -- IF ORI (1)
            ' como iniciamos a la prepo... tengo que buscar en el almacen antiguo y en el almacen nuevo para ver si tienen precio unitario!
            MMB =   " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
                    " C6_CALMA =  '"&OLD&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&ART&"'        " & _
                    " ORDER BY C6_DFECDOC DESC ;                                                    "
        rs.close
        RS.OPEN, MMB, CNN
        IF RS.RECORDCOUNT <= 0 THEN   ' -- IF OLD  (2) %>
            <script language="javascript" type="text/jscript">
                alert("No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. ANTIGUO")
            </script>
            <%response.end
        else
            PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
            PRETOTus = PRECIO * ATE
            PRECIOmn = PRECIOus * CDBL(CAM)
            PRETOTmn = PRECIOmn * ATE
        end if '-- END OLD (2)
    ELSE
        PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
        PRETOTus = PRECIO * ATE
        PRECIOmn = PRECIOus * CDBL(CAM)
        PRETOTmn = PRECIOmn * ATE
    end if  ' -- END ORI (2)
    RS.CLOSE
'-----------------------------------------------------------------------------------------------------------------
' ST006 : es el unico que tiene de H --> C  
'-----------------------------------------------------------------------------------------------------------------
ELSEIF  UCASE(LET2) = "C"  THEN ' ES TELA CRUDA --> SE ENTREGA HILADO
    ' primero hay que buscar la composicion de la tela y despues buscamos los costos por fibra
    TEL = LEFT(ART,6)
    mm = "Select HIL1, HIL2, HIL3, HIL4, HIL5, HIL6, POR1, POR2, POR3, POR4, POR5, POR6 From MODELADOR..TELAS WHERE TELA = '"&TEL&"' ; "
     response.write("CRUODOOOO")
     response.write("<br>")
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
           ' RESPONSE.WRITE(cam&"-..-")
            IF CDBL(aPor(i)) > 0 THEN ' INICIO IF aPor
                RS.CLOSE
                hil= aHil(i)
                miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                        " C6_CALMA =  '"&ORI&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&hil&"'       " & _
                        " ORDER BY C6_DFECDOC DESC  ;                                                  "
                RS.OPEN MIKO, CNN
              
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (3) 

                
                    rs.close
                    miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
                            " C6_CALMA =  '"&OLD&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&hil&"'        " & _
                            " ORDER BY C6_DFECDOC DESC ;                                                    "
                            RS.OPEN MIKO, CNN
                    IF RS.RECORDCOUNT <= 0 THEN  ' inicio  If old (4)
                    %><script language="javascript" type="text/jscript">
                        alert("No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. ANTIGUO --> " + '<%=hil%>')
                    </script>
                    <%response.end
                    end if  ' fin (4)                                    
                end if '-- END Ori (3)
                aDol(i) = CDBL(RS("C6_NUSPRUN")) * aPor(i) 
            END IF ' FIN if aPor22
           ' estos son parciales con porcentajes
            aDoT(i) = aDol(i) * ATE * aPor(i)                      
            aSol(i) = aDol(i) * CDBL(CAM)
            aSoT(i) = aSol(i) * ATE * Apor(i)
            PRECIOus = PRECIOus + aDol(i) 
            PRETOTus = PRETOTus + aDoT(i)
            PRECIOmn = PRECIOmn + aSol(i)
            PRETOTmn = PRETOTmn + aSoT(i)
        NEXT
        '       HAY QUE SUMARLE EL COSTO UNITARIO DEL SERVICIO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        
        PRECIOus = PRECIOus + CDBL(DOL)
        PRETOTus = PRECIOus * ATE
        PRETOTmn = PRETOTus * CDBL(CAM)
        PRECIOmn = PRECIOus * CDBL(CAM)

        response.write(PRECIOus)
        response.write("<br>")
        ' ya tengo los precios
    end if ' FIN DE LET2 = C  (AAA)
   
   
'--------------------------------------------------------------------------------------------------
' ST101  H --> T  (PARA RAYADOS, ENTREGO HILO COLOR Y REGRESA TELA COLOR " CRUDA" - SIN ACABAR)
'--------------------------------------------------------------------------------------------------
'                 00HT, 00HD  --> 00M7 
'--------------------------------------------------------------------------------------------------
ELSEIF UCASE(LET1) = "H" AND UCASE(LET2) = "T" AND UCASE(des) = "00M7"  then%>
    <script language="javascript" type="text/jscript">
        alert("MOVIMEITNO NO CONSIDERADO, la tela rayada se manda fabricar como \n  PRODUCTO TERMINADO")
    </script>

    <%RESPONSE.END

ELSEIF UCASE(LET1) = "H"  AND UCASE(des) = "00MD"   then
' HE QUITADO AND UCASE(LET2) = "T"
'--------------------------------------------------------------------------------------------------
' ST200  H --> T                                00h0,  00HD  --> 00MD  (tela acabada) 
' SR200  H --> R                                00h0,  00HD  --> 00MD  (RECTILINEO acabada) 
' este DEBE ser el que MAS se use!!!!!!!!!!!!!!!!!!!!  
'--------------------------------------------------------------------------------------------------
 TEL = LEFT(ART,6)
 mm = "Select HIL1, HIL2, HIL3, HIL4, HIL5, HIL6, POR1, POR2, POR3, POR4, POR5, POR6, pesouni From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
    response.write(mm)
    response.write("<br>")
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
                miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                        " (C6_CALMA =  '"&ORI&"' OR C6_CALMA =  '"&OLD&"') AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&hil&"'       " & _
                        " ORDER BY C6_NUSPRUN, C6_DFECDOC DESC  ;                                                  "
                RS.OPEN MIKO, CNN
                response.write(miko)
                response.write("<br>")
                rs.movefirst
                RESPONSE.WRITE(cdbl(RS("C6_NUSPRUN")) )   
               ' RESPONSE.WRITE("ooooooooooooooooooooooooooooooooooo")
                RESPONSE.WRITE("<br>")
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (33) 
                        %><script language="javascript" type="text/jscript">
                              alert("No se puede valorizar un servicio que no tiene ingreso \n de Materia Prima ALM. ANTIGUO --> " + '<%=hil%>')
                        </script>
                        <%response.end
                else
                   
                    IF CDBL(RS("C6_NUSPRUN")) <= 0 THEN %>
                        <script language="javascript" type="text/jscript">
                            alert("No TENGO INGRESOS VALORIZADOS DE .... " + '<%=hil%>')
                        </script>
                        <%response.end
                   else
                     aDol(i) = CDBL(RS("C6_NUSPRUN")) * aPor(i)     
                   '  RESPONSE.WRITE("<br>")
                   '  RESPONSE.WRITE(CDBL(RS("C6_NUSPRUN")) )   
                   '  RESPONSE.WRITE("<br>")
                   '  RESPONSE.WRITE(aPor(i) ) 
                    END IF             
                end if '-- END Ori (33)
            END IF ' FIN if aPor22
            ' RESPONSE.WRITE("<br>")
            ' RESPONSE.WRITE(CDBL(RS("C6_NUSPRUN")) )
            ' estos son parciales con porcentajes
            aDoT(i) = aDol(i) * ATE                     
            aSol(i) = aDol(i) * CDBL(CAM)
            aSoT(i) = aSol(i) * ATE * Apor(i)
            PRECIOus = PRECIOus + (aDol(i) * aPor(i))
            PRETOTus = PRETOTus + aDoT(i)
            PRECIOmn = PRECIOmn + aSol(i)
            PRETOTmn = PRETOTmn + aSoT(i)
            ' RESPONSE.WRITE("<br>")
            ' RESPONSE.WRITE(precious)
            ' RESPONSE.WRITE("<br>")
            
             RESPONSE.WRITE("<br>")
        NEXT
        ' hay que sumar el costo del servicio para acumular
        
            PRECIOus = PRECIOus  + cdbl(dol)
            PRETOTus = PRETOTus * ate
            PRECIOmn = PRECIOmn 
            PRETOTmn = PRETOTmn 
          
          
        ' ya tengo los precios
    end if ' FIN DE LET2 = t  (sss)

ELSEIF (UCASE(LET1) = "C" AND UCASE(LET2) = "T") OR (UCASE(LET1) = "R" AND UCASE(LET2) = "R")   then ' TEÑIDO DE TELA ST015 / SR015 PARA RECTILINEOS....
 TEL = LEFT(ART,6)
 mm = "Select * From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
  '   response.write(mm)
  '   response.write("<br>")
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
        miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                " C6_CALMA =  '"&ORI&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&TELA&"'      " & _
                " ORDER BY C6_DFECDOC DESC  ;                                                  "
                RS.OPEN MIKO, CNN
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (RR) 
                    rs.close
                    miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
                            " C6_CALMA =  '"&OLD&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&TELA&"'       " & _
                            " ORDER BY C6_DFECDOC DESC ;                                                    "
                            RS.OPEN MIKO, CNN
                    IF RS.RECORDCOUNT <= 0 THEN  ' inicio  If old (UU,,44)
                    %><script language="javascript" type="text/jscript">
                          alert("No se puede valorizar un servicio que no tiene ingreso \n de Tela Cruda ALM. ANTIGUO --> " + '<%=tela%>')
                    </script>
                    <%'response.write(miko)
                    'response.end                    
                    end if  ' fin (44)       
                end if '-- END Ori (RR)

    END IF ' FIN (333..SSS)
    PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
    PRETOTus = PRECIO * ATE
    PRECIOmn = PRECIOus * CDBL(CAM)
    PRETOTmn = PRECIOmn * ATE

ELSEIF (UCASE(LET1) = "T" AND UCASE(LET2) = "T") OR ( UCASE(LET1) = "R" AND UCASE(LET2) = "R" )   then ' LOS DEMAS CASOS EN LOS QUE SALE TELA/RECTILINEO COLOR Y REGRESA TELA/RECTILINEO ACABADOA
    ' LO UNICO QUE DIFERENCIA LOS SERVICIOS ES EL ALMACEN DE ORIGEN Y EL DE DESTINO

    TEL = LEFT(ART,6)
 mm = "Select * From MODELADOR..TELAS WHERE TELA = '"&tel&"' ; "
    ' response.write(mm)
    ' response.write("<br>")
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
        miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND   " & _
                " C6_CALMA =  '"&ORI&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&TELA&"'      " & _
                " ORDER BY C6_DFECDOC DESC  ;                                                  "
                RS.OPEN MIKO, CNN
                IF RS.RECORDCOUNT <= 0 THEN   ' -- IF ori  (RR) 
                    rs.close
                    miko =  " SELECT TOP 1 C6_NUSPRUN From RSFACCAR..AL0001MOVD Where  C6_CTD = 'PE' AND    " & _
                            " C6_CALMA =  '"&OLD&"' AND C6_CCODMOV = 'CO' AND C6_CCODIGO = '"&TELA&"'       " & _
                            " ORDER BY C6_DFECDOC DESC ;                                                    "
                            RS.OPEN MIKO, CNN
                    IF RS.RECORDCOUNT <= 0 THEN  ' inicio  If old (UU,,44)
                    %><script language="javascript" type="text/jscript">
                          alert("No se puede valorizar un servicio que no tiene ingreso \n de Tela COLOR ALM. ANTIGUO --> " + '<%=tela%>')
                    </script>
                    <%'response.write(miko)
                      'response.end                    
                    end if  ' fin (44)       
                end if '-- END Ori (RR)

    END IF ' FIN (333..SSS)
    PRECIOus = CDBL(RS("C6_NUSPRUN")) + CDBL(DOL)
    PRETOTus = PRECIO * ATE
    PRECIOmn = PRECIOus * CDBL(CAM)
    PRETOTmn = PRECIOmn * ATE
    
END IF ' FIN DE LOS IF ELSEIF DE LET1 - LET2 
'RESPONSE.WRITE(MIKO)
'response.write("<br>")
rs.close

' *******************************************************************
' Graba el registro de detalle como producto terminado revalorizado
' *******************************************************************
cad = cad +    " Insert Into RSFACCAR..AL0001MOVD(C6_CALMA,C6_CLOCALI,C6_CTD,C6_CNUMDOC,C6_CITEM,C6_CCODIGO,C6_CDESCRI,  " & _
                " C6_CITEMOC,C6_NCANTID,C6_NVALTOT,C6_NUSIMPO,C6_NUSPRUN,C6_NMNIMPO,C6_NMNPRUN,C6_NPREUN1,C6_NPREUNI,    " & _
                " C6_DFECDOC,C6_CCODMOV,C6_CESTADO,C6_CCODMON,C6_CTIPO,C6_NTIPCAM,C6_NPORDE1,C6_NIMPO1,C6_NPORDE2,       " & _
                " C6_NIMPO2,C6_NPORDE4,C6_NIMPO4, C6_NPORDES,C6_NDESCTO) Values('"&des&"','0001','PE','"&pe2&"',         " & _
                " '"&lin&"', '"&ART&"', '"&DET&"','"&lin&"',"&ate&","&PRETOTus&","&PRETOTus&","&PRECIOUS&","&PRETOTmn&", " & _
                " "&PRECIOmn&", "&PRECIOus&","&PRECIOus&", getdate(),'"&REA&"','V','US','V',"&cam&",0,0,0,0,0,0,0,0) ;        " 


' el nuevo correlativo lo genero AL FINALIZAR la atención renumerando todas las lineas del parte, de monento se genera la linea del parte = a la linea de la OC
' despues de finalizar la atención, ya NO SE PUEDE EDITAR, por eso la renumero en ese momento nada más

' tambien tengo que actualizar el cansal de la ORDEN DE COMPRAAAAAAAAAAAAAAAAAAAAAAAAAAA
 '     RESPONSE.WRITE("<BR>")   
 '   RESPONSE.WRITE("<BR>")
 '   response.write(fin)
 '    RESPONSE.WRITE("<BR>")    
 '   RESPONSE.WRITE("<BR>")   
    
' HAY QUE GRABAR LAS CANTIDADES POR TALLA DEL PE EN EL MULTI
mas = "select * from MULTI..RS_ALMOVC0001 WHERE C5_CALMA = '"&DES&"' AND C5_CTD = 'PE' AND C5_CNUMDOC = '"&PE2&"' "
RS.OPEN MAS,CNN
' EXISTE EN EL MULTI
deta = ""

IF RS.RECORDCOUNT > 0 THEN
    cad = cad + " delete  MULTI..rs_almovd_TALLA0001  WHERE CALMA = '"&DES&"' AND CTD = 'PE' " & _
                " AND CNUMDOC = '"&PE2&"' and citem = '"&lin&"'"

    cad = cad + "delete  MULTI..rs_almovd0001  WHERE CALMA = '"&DES&"' AND CTD = 'PE' " & _
                " AND CNUMDOC = '"&PE2&"' and citem = '"&lin&"'" 
end if



CAD = CAD + " INSERT INTO MULTI..RS_ALMOVC0001 SELECT '"&DES&"', 'PE', '"&PE2&"', '"&ref&"', '"&nro&"' , getdate(), null, " & _
            " '"&usuario&"', null "
'***************************************************************
' rectilineos SON 10 TALLAS Y CANTIDADES....
'***************************************************************
IF LEFT(ART,1) = "9" THEN 
    deta = "S"
    
    FOR I = 0 TO 9
        if len(trim(aTal(i))) > 0 then 
            talla = aTal(i)
            if len(trim(aCan(i))) = 0 then canti = 0 else canti = cint(aCan(i))
            CAD = CAD + " INSERT INTO Multi..rs_almovd_TALLA0001 SELECT  '"&des&"', 'PE', '"&PE2&"', " & _
                        " '"&LIN&"', '"&talla&"', "&canti&", "&i&" "
            recto = recto + canti
        end if
    NEXT
    pesouni = recto * pesouni
else
    deta = "N"
END IF
RS.CLOSE
' deta es s --> Si tiene tallas / n --> to tiene tallas
cad = cad + " insert into multi..rs_almovd0001 SELECT '"&des&"', 'PE', '"&PE2&"', '"&LIN&"', GETDATE(),'"&ref&"', " & _
            "'"&nro&"' , 'E',  '"&REA&"', '"&ART&"', '"&DET&"', "&ate&", "&ate&", '"&RUC&"', '"&PRO&"', NULL,     " & _
            " '"&OC&"', NULL, NULL, NULL, NULL, "&pesouni&", "&pesouni&", "&pesouni&", "&pesouni&", NULL, NULL,   " & _
            " NULL, '"&deta&"', NULL, 'V', NULL, NULL, NULL "

' RESPONSE.WRITE("<BR>")   
'    RESPONSE.WRITE("<BR>")
'    response.write(cAD)
'     RESPONSE.WRITE("<BR>")    
'    RESPONSE.WRITE("<BR>")   
'
if CINT(fin) = 1 then  
    sas = " select  * from  RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and C6_CNUMDOC = '"&pe1&"', " & _ 
          " '"&REF&"', '"&NUME&"', GETDATE(), GETDATE(),  " & _
          " order by c6_citem ;"
    rs.open sas, cnn
    if rs.recordcount <= 0 then %>
        <script language="javascript" type="text/jscript">
            alert("No hay detalle que FINALIZAR")
        </script>
        <%response.end
    else
        pot = 1
        do while not rs.eof
            ITM = RIGHT("0000" + CSTR(POT), 4)
            LINE = RS("C6_CITEMOC")
            ' ACTUALIZA EL NUMERADOR DE LOS PARTES
            cad = cad + " update RSFACCAR..AL0001MOVD  set c6_citem = '"&ITM&"' " & _
                        " where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and      " & _
                        " C6_CNUMDOC = '"&pE1&"' and C6_CITEMOC = '"&line&"' ;  "                                        
            ' actualiza las cantidades atendidas en la OC          
            atend = cdbl(rs("C6_NCANTID"))        
            ' la OC se actualiza solo una vezzzzzzz
            cad = cad + " Update RSFACCAR..CO0001MOVD Set OC_NCANSAL=OC_NCANSAL-"&atend&", OC_CESTADO='4' Where OC_CNUMORD='"&oc&"' AND OC_CITEM='"&line&"' ; "
            POT = POT +1
            RS.MOVENEXT
        LOOP
    end if
    rs.close
    sas = " select  * from  RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PS' and C6_CNUMDOC = '"&pS1&"' " & _
          " order by c6_citem ;"
    rs.open sas, cnn
    if rs.recordcount <= 0 then %>
        <script language="javascript" type="text/jscript">
            alert("No hay detalle que FINALIZAR")
        </script>
        <%response.end
    else
        pot = 1
        do while not rs.eof
            ITM = RIGHT("0000" + CSTR(POT), 4)
            LINE = RS("C6_CITEMOC")
            ' ACTUALIZA EL NUMERADOR DE LOS PARTES
            cad = cad + " update RSFACCAR..AL0001MOVD  set c6_citem = '"&ITM&"' " & _
                        " where C6_CALMA = '"&DES&"' and C6_CTD = 'PS' and      " & _
                        " C6_CNUMDOC = '"&pS1&"' and C6_CITEMOC = '"&line&"' ;  "                                        
            ' actualiza las cantidades atendidas en la OC          
            atend = cdbl(rs("C6_NCANTID"))        
           
            POT = POT +1
            RS.MOVENEXT
        LOOP
    end if
    rs.close
    sas = " select  * from  RSFACCAR..AL0001MOVD where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and C6_CNUMDOC = '"&pe2&"' " & _
          " order by c6_citem ;"
    rs.open sas, cnn
    if rs.recordcount <= 0 then %>
        <script language="javascript" type="text/jscript">
            alert("No hay detalle que FINALIZAR")
       </script>
        <%response.end
     else
         pot = 1
         do while not rs.eof
             ITM = RIGHT("0000" + CSTR(POT), 4)
             LINE = RS("C6_CITEMOC")
             ' ACTUALIZA EL NUMERADOR DE LOS PARTES
             cad = cad + " update RSFACCAR..AL0001MOVD  set c6_citem = '"&ITM&"' " & _
                         " where C6_CALMA = '"&DES&"' and C6_CTD = 'PE' and      " & _
                         " C6_CNUMDOC = '"&pE2&"' and C6_CITEMOC = '"&line&"' ;  "                                        
             ' actualiza las cantidades atendidas en la OC          
             atend = cdbl(rs("C6_NCANTID"))        
             POT = POT +1
             RS.MOVENEXT
         LOOP
     end if
    rs.close
ELSE
    RESPONSE.WRITE("<BR>")   
    RESPONSE.WRITE("<BR>")   
    RESPONSE.WRITE("<BR>")   
    RESPONSE.WRITE("<BR>")   
    RESPONSE.WRITE("ELSE porque fin = 0")   
end if



RESPONSE.WRITE("<br>")

response.write(cad)
'
' Inicia transacción , para que los datos no queden a medias


'response.end
Cnn.BeginTrans	
Cnn.Execute(CAD)


if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

' DESBLOQUEO LA oc
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='' Where OC_CNUMORD='"&OC&"'; "

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
//top.window.graba()
//top.window.location.replace('../ATENCION.ASP')

    kaa = '../detaAtencion.asp?co=' + strzero(trim('<%=oc%>'), 10) + '&nume=' + trim('<%=doc%>')
    kaa += '&REF=' + '<%=REF%>'
    kaa += '&pe1=' + '<%=pe1%>'
    kaa += '&pe2=' + '<%=pe2%>'
    kaa += '&ps1=' + '<%=ps1%>'
    kaa += '&glos=' + '<%=glos%>'
    kaa += '&alm=' + trim('<%=alm %>')
    // alert(top.window.opener.window.name)
    //alert(window.opener.window.name)
 //   parent.window.location.replace = kaa

//    parent.window.opener.window.top.parent.frames['mainFrame'].window.location.replace('../detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>');
</script>
</BODY>
</HTML>

