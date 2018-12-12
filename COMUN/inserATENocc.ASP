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
DET =   left(TRIM(REQUEST.QUERYSTRING("bET")),50)
OC =    TRIM(REQUEST.QUERYSTRING("OC"))

' Bloqueo la OC para que otro no meta la manotas
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='1' Where OC_CNUMORD='"&OC&"' ; "


lin =    right("0000" +TRIM(REQUEST.QUERYSTRING("lin")),4)
ate =    TRIM(REQUEST.QUERYSTRING("CAN"))
nro =    TRIM(REQUEST.QUERYSTRING("nro"))
glo =    left(TRIM(REQUEST.QUERYSTRING("glo")),30)
ref =    LEFT(GLO,2)
pe1 =    right("00000000000" + TRIM(REQUEST.QUERYSTRING("pe1")),11)
dol =    TRIM(REQUEST.QUERYSTRING("pu2"))
cam =    TRIM(REQUEST.QUERYSTRING("cam"))
ART =    TRIM(REQUEST.QUERYSTRING("ART"))
rea =    TRIM(REQUEST.QUERYSTRING("rea"))
des =    TRIM(REQUEST.QUERYSTRING("des")) 
fec =  request.QueryString("fec")


response.write("<br>")
response.write(dol)
response.write("<br>")

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
response.write(srv)
' como es una compra el articulo es el servicio y no hay 2 codigos
ART = SRV

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
        alert("No hay DEFINIDOS contadores para almacen : \n" + '<%=ucase(des)%>' + '\nAvisar a Sistemas')
    </script>
<%RESPONSE.End
END IF
rs.close

'---------------------------------------------------------------------------
' miro si hay registro en la tabla de stocks para crearlo con 0 disponilbe
'---------------------------------------------------------------------------

vad = "select * from RSFACCAR..AL0001STOC  WHERE SK_CALMA = '"&DES&"' AND SK_CCODIGO='"&ART&"'  "
rs.open vad, cnn

if rs.recordcount <=0 then
    ' creamos un nuevo registro de stock
    vad = "insert into RSFACCAR..AL0001STOC (sk_calma, sk_ccodigo, sk_nskdis, sk_dfecmov) values ('"&des&"', '"&art&"', 0, getdate())"
    cnn.execute vad
end if
rs.close
response.write(vad)
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


' sumo los parciales acumulados de las atenciones para tener el atendido VERDADERO
dedo =  " select isnull(sum(c6_ncantid),0) as xxx from RSFACCAR..al0001movc AS A inner join          " & _
        " RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&oc&"'   " & _
        " AND C6_CITEM ='"&lin&"' "
rs.open dedo, cnn
if rs.recordcount > 0 then atendido = cdbl(rs("xxx")) else atendido = 0
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
    rucp = ruc
    '--------------------------
    '       CABECERAS
    '--------------------------
    ' parte de entrada por el producto terminado
    cad = cad + " Insert Into RSFACCAR..AL0001MOVC(C5_CALMA, C5_CTD, C5_CNUMDOC, C5_DFECDOC, C5_CTIPMOV, C5_CCODMOV, C5_CRFTDOC,    " & _
                " C5_CRFNDOC, C5_CGLOSA1, C5_DFECCRE, C5_CUSUCRE, C5_CNUMORD, C5_CNUMLIQ, C5_CCODPRO, C5_CNOMPRO, C5_CCODMON,       " & _
                " C5_CTIPO, C5_NTIPCAM, C5_CSITUA, C5_CLOCALI) Values ('"&des&"','PE','"&pe1&"', Convert(datetime,'"&fec&"',103),'E','CO','"&ref&"',      " & _
                " '"&nro&"','"&glo&"',GETDATE(),'"&USUARIO&"','"&oc&"','','"&RUC&"','"&pro&"','"&mon&"','V',"&kam&",'V','0001');    "
else
    nro = rs("c5_crfndoc")
    rs.close
    lad = "Select * From RSFACCAR..CO0001MOVC Where OC_CNUMORD= '"&oc&"'; "
    'response.write("<br>")
  '  response.write(request.QueryString)
    'response.write("<br>")
    rs.open lad, cnn
    rs.movefirst
    ruc = rs("oc_ccodpro")
    rucp= ruc
    pro = rs("oc_crazsoc")
    mon = rs("OC_CCODMON")
    kam = rs("oc_ntipcam")
    
    response.write(rucp)
    response.write("<br>")
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
 ' parte de entrada por compra del producto
 cad = cad +    " Insert Into RSFACCAR..AL0001MOVD(C6_CALMA,C6_CLOCALI,C6_CTD,C6_CNUMDOC,C6_CITEM,C6_CCODIGO,C6_CDESCRI, " & _
                " C6_CITEMOC,C6_NCANTID,C6_NVALTOT,C6_NUSIMPO,C6_NUSPRUN,C6_NMNIMPO,C6_NMNPRUN,C6_NPREUN1,C6_NPREUNi,    " & _
                " C6_DFECDOC,C6_CCODMOV,C6_CESTADO,C6_CCODMON,C6_CTIPO,C6_NTIPCAM,C6_NPORDE1,C6_NIMPO1,C6_NPORDE2,       " & _
                " C6_NIMPO2,C6_NPORDE4,C6_NIMPO4, C6_NPORDES,C6_NDESCTO) Values('"&des&"','0001','PE','"&pe1&"',         " & _
                " '"&lin&"', '"&SRV&"', '"&DET&"','"&lin&"',"&ate&","&doltot&","&doltot&","&dol&","&soltot&","&sol&",    " & _
                " "&dol&","&dol&",  Convert(datetime,'"&fec&"',103),'CO','V','US','V',"&cam&",0,0,0,0,0,0,0,0) ;                                " 

response.write(srv)
codpro = srv

' HAY QUE GRABAR LAS CANTIDADES POR TALLA DEL PE EN EL MULTI
mas = "select * from MULTI..RS_ALMOVC0001 WHERE C5_CALMA = '"&DES&"' AND C5_CTD = 'PE' AND C5_CNUMDOC = '"&PE1&"' "
RS.OPEN MAS,CNN
' EXISTE EN EL MULTI
deta = ""

IF RS.RECORDCOUNT > 0 THEN
    cad = cad + " delete  MULTI..rs_almovd_TALLA0001  WHERE CALMA = '"&DES&"' AND CTD = 'PE' " & _
                " AND CNUMDOC = '"&PE1&"' and citem = '"&lin&"'"

    cad = cad + "delete  MULTI..rs_almovd0001  WHERE CALMA = '"&DES&"' AND CTD = 'PE' " & _
                " AND CNUMDOC = '"&PE1&"' and citem = '"&lin&"'" 

     cad = cad + "delete  MULTI..RS_ALMOVC0001  WHERE c5_CALMA = '"&DES&"' AND c5_CTD = 'PE' " & _
                " AND c5_CNUMDOC = '"&PE1&"' "
end if



CAD = CAD + " INSERT INTO MULTI..RS_ALMOVC0001 SELECT '"&DES&"', 'PE', '"&PE1&"', '"&ref&"', '"&nro&"' ,  Convert(datetime,'"&fec&"',103), null, " & _
            " '"&usuario&"', null "
'***************************************************************
' rectilineos SON 10 TALLAS Y CANTIDADES....
'***************************************************************

response.Write("<br>")
        response.Write("left...")
        response.Write("<br>")
        response.Write("<br>")
        response.Write(srv)
        response.Write("<br>")
IF LEFT(ART,1) = "9"  THEN 
    deta = "S"
    response.Write("<br>")
    response.Write("rectilineo")
    response.Write("<br>")

    FOR I = 0 TO 9
        response.Write("<br>")
        response.Write("for...")
        response.Write("<br>")
        if len(trim(aTal(i))) > 0 then 
            talla = aTal(i)
            if len(trim(aCan(i))) = 0 then canti = 0 else canti = cint(aCan(i))
            CAD = CAD + " INSERT INTO Multi..rs_almovd_TALLA0001 SELECT  '"&des&"', 'PE', '"&PE1&"', " & _
                        " '"&LIN&"', '"&talla&"', "&canti&", "&i&" "
            recto = recto + canti
        end if
    NEXT
    pesouni = recto * pesouni
else
    deta = "N"
END IF
RS.CLOSE
' deta es s --> Si tiene tallas / n --> no tiene tallas
cad = cad + " insert into multi..rs_almovd0001 SELECT '"&des&"', 'PE', '"&PE1&"', '"&LIN&"', Convert(datetime,'"&fec&"',103),'"&ref&"'," & _
            "'"&nro&"' , 'E',  '"&REA&"', '"&codpro&"', '"&DET&"', "&ate&", "&ate&", '"&RUCp&"', '"&PRO&"', NULL,     " & _
            " '"&OC&"', NULL, NULL, NULL, NULL, "&pesouni&", "&pesouni&", "&pesouni&", "&pesouni&", NULL, NULL,   " & _
            " NULL, '"&deta&"', NULL, 'V', NULL, NULL, NULL "

 RESPONSE.WRITE("<BR>")   
    RESPONSE.WRITE("<BR>")
'    response.write(cAD)
     RESPONSE.WRITE("<BR>")    
    RESPONSE.WRITE("<BR>")   

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
                         " C6_CNUMDOC = '"&pE1&"' and C6_CITEMOC = '"&line&"' ;  "                                        
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
response.write("<br>")
response.write(ATE)
response.write("<br>")


' actualiza el strock

CAD = CAD + " UPDATE RSFACCAR..AL0001STOC  SET SK_NSKDIS = SK_NSKDIS + "&ATE&" WHERE SK_CALMA = '"&DES&"' AND SK_CCODIGO='"&ART&"' "

RESPONSE.WRITE("<br>")

'response.write(cad)
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
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='', oc_csitord='4' Where OC_CNUMORD='"&OC&"'; "

    ' RE RE RE sumo los parciales acumulados de las atenciones para tener el atendido VERDADERO
dedo =  " select isnull(sum(c6_ncantid),0) as xxx from RSFACCAR..al0001movc AS A inner join          " & _
        " RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma where C5_CNUMord='"&oc&"'   " & _
        " AND C6_CITEM ='"&lin&"'"
rs.open dedo, cnn
if rs.recordcount > 0 then atendido = cdbl(rs("xxx")) else atendido = 0
rs.close
cnn.execute "Update RSFACCAR..CO0001MOVD Set OC_NCANTEN="&ateNDIDO&", OC_CESTADO='4', OC_NCANSAL =  OC_NCANORD-"&atendido&" Where OC_CNUMORD='"&oc&"' AND OC_CITEM='"&lin&"'"
 response.write("<br>")
 RESPONSE.WRITE(CAD)
' RESPONSE.END

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
    //top.window.graba()
    //top.window.location.replace('../ATENCION.ASP')

    kaa = '../detaAtencionocc.asp?co=' + strzero(trim('<%=oc%>'), 10) + '&nume=' + trim('<%=doc%>')
    kaa += '&REF=' + '<%=REF%>'
    kaa += '&pe1=' + '<%=pe1%>'
    kaa += '&glos=' + ltrim(top.window.document.all.GLO.value)
    kaa += '&alm=' + trim(top.window.document.all.COD.value)
  
    
 parent.window.location.replace = kaa
</script>
</BODY>
</HTML>

