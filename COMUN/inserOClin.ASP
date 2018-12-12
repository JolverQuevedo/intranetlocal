<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE 
  Session.LCID=2057%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

OC =    TRIM(REQUEST.QUERYSTRING("OC"))
rs.open ("select oc_Ccodpro,OC_CTIPORD, OC_DFECDOC, oc_ntipcam, oc_ccodmon from RSFACCAR..CO0001MOVC  where oc_cnumord = '"&OC&"'"),cnn
pro  = rs("oc_ccodpro")
TIP = RS("OC_CTIPORD")
FECD = RS("OC_DFECDOC")
cam= rs("oc_ntipcam")
mon = rs("oc_ccodmon")

rs.close
' capturo el codigo de proveedor de la cabecera
cod  =   UCASE(TRIM(REQUEST.QUERYSTRING("cod")))
lin  =   UCASE(TRIM(REQUEST.QUERYSTRING("lin")))
uni  =   UCASE(TRIM(REQUEST.QUERYSTRING("uni")))
des  =   UCASE(TRIM(REQUEST.QUERYSTRING("des")))
come  =   left(UCASE(TRIM(REQUEST.QUERYSTRING("kom"))),800)
fin  =   UCASE(TRIM(REQUEST.QUERYSTRING("fin")))
cto  =   UCASE(TRIM(REQUEST.QUERYSTRING("cto")))
soli =  UCASE(TRIM(REQUEST.QUERYSTRING("sol")))
ent  =   UCASE(TRIM(REQUEST.QUERYSTRING("ent")))
ref  =   UCASE(TRIM(REQUEST.QUERYSTRING("ref")))
USR  =   UCASE(LEFT(USUARIO,5))
HOR  =   LEFT(TIME(),5)
KAN  =   UCASE(TRIM(REQUEST.QUERYSTRING("aCan")))
ofi  =   UCASE(TRIM(REQUEST.QUERYSTRING("aOfi")))
qty  =   UCASE(TRIM(REQUEST.QUERYSTRING("aqty")))
tal  =   UCASE(TRIM(REQUEST.QUERYSTRING("atal")))
kgs  =   UCASE(TRIM(REQUEST.QUERYSTRING("kgs")))
aCan =  split(kan,",")
aOfi =  split(ofi,",")
for i=0 to ubound(aofi)
    aofi(i) = right(aofi(i),8)
next
aqty =  split(qty,",")
atal =  split(tal,",")
 response.write(tal)
response.Write("<br>")
'response.write(OFI)
'response.Write("<br>")

' cantidad total pedida del item
ped =   TRIM(REQUEST.QUERYSTRING("ped"))
'**************************************************
    pre =   TRIM(REQUEST.QUERYSTRING("pre"))
'**************************************************
' % dcto item incluido
ch1 =   TRIM(REQUEST.QUERYSTRING("ch1")) 
dct =   TRIM(REQUEST.QUERYSTRING("dct"))
if dct = "" then ddct = 100 else ddct = dct
if ch1 = "1" then  dite = pre -(pre * (ddct/100)) else dite = 0
' % dcto adicional incluido
ch2 =   TRIM(REQUEST.QUERYSTRING("ch2")) 
adi =   TRIM(REQUEST.QUERYSTRING("adi"))
if adi = "" then aadi = 100 else aadi = adi
if ch2 = "1" then  dadi = pre -(pre * (aadi/100)) else dadi = 0
' % igv incluido
ch3 =   TRIM(REQUEST.QUERYSTRING("ch3")) 
igv =   TRIM(REQUEST.QUERYSTRING("igv"))
if igv = "" then iigv = 100 else iigv = igv
' % isc incluido
ch4 =   TRIM(REQUEST.QUERYSTRING("ch4")) 
isc =   TRIM(REQUEST.QUERYSTRING("isc"))
if isc = "" then iisc = 100 else iisc = isc
pre = cdbl(pre)



pre2= cdbl(pre2)
cam = cdbl(cam)
ped = cdbl(ped)
'************************************************
'  --- casos del precio unitario informado ---
'************************************************
' preuni ==> tiene el igv incluido
if ch3 = "1" then 
    preuni = pre 
    pre2   = pre - (pre * (iigv/100)) 
else    
    preuni = preuni + (pre * (iigv/100))
    pre2 = pre
end if


pigv = pre * (iigv/100) 
'* ped
  
'--------------------------------
'   igv e isc son excluyentes
'--------------------------------
' preuni == tiene el isc incluido
' if ch4 = "1" then 
'     preuni = pre 
'     pre2   = pre - (pre * (iisc/100)) 
' else    
'     preuni = preuni + (pre * (iisc/100))
'     pre2 = pre
' end if
' pisc = pre2 * (iisc/100)
' 
' if mon = "MN" then 
'     usd = ((pre) / cam) * ped  +pigv
'     sol = usd * cam
' else 
'     usd = (CDBL(PRE) * CDBL(ped)) + PIGV
'     sol = usd * cam
'   
'   
' end if

' incluir el igv...
' preuni = pre 
' asi esta en el MULTI-......
if ch4 = "1" then 
    preuni = pre 
    pre2   = pre - (pre * (iisc/100)) 
else    
    preuni = preuni + (pre * (iisc/100))
    pre2 = pre
end if
pisc = pre2 * (iisc/100)

if mon = "MN" then 
    usd = ((pre+pigv) / cam) * ped 
    sol = (pre+pigv) * ped
else 
    usd = (pre+pigv) * ped
    sol = ((pre+pigv) * cam) * ped
end if
response.write(pre)
response.write("<br>")
response.write(pre+pigv)
response.write("<br>")
response.write((pre+pigv) / cam)
response.write("<br>")
response.write(((pre+pigv) / cam) * ped )
response.Write("<br>")
response.write(PIGV)
response.Write("<br>")
response.write(CAM)
response.Write("<br>")
response.write(PED)
response.Write("<br>")
' incluir el igv...
preuni = pre 
pigv = pre * (iigv/100) * ped
'-------------------------------------------------------------------
' PRIMERO SE BORRA LA LINEA DE DETALLE DEL REAL Y DEL MODELADOR
' ESTO LO HACE COMO RUTINA REAL PARA "EVITAR" HORRORES DE UPDATE???
'-------------------------------------------------------------------


CAD = " DELETE ORDENCOMPRA WHERE NUMORD = '"&OC&"' AND ITEM = '"&LIN&"' ; "
CAD = CAD + " Delete From RSFACCAR..CO0001MOVD Where OC_CNUMORD='"&OC&"' AND OC_CITEM='"&LIN&"' ; "
CAD = CAD + " DELETE MODELADOR..OCTALLA Where NUMORD='"&OC&"' AND ITEM='"&LIN&"' ; "
' INSERT
response.write(come)
response.write("<br>")
response.write("kkkkkkkkkkkkkkkkkk")
response.write(iigv)
    ' INSERTA LA CABECERA DE LA O/C  
  cad = cad +   " Insert RSFACCAR..CO0001MOVD (                                                         " & _
                " OC_CTIPORD, OC_CNUMORD, OC_DFECDOC, OC_CCODPRO, OC_CESTADO, OC_CITEM,   OC_CCODIGO,   " & _         
                " OC_CCODREF, OC_CDESREF, OC_CUNIDAD, OC_NCANORD, OC_NPREUN2, OC_NDESCAD, OC_NDSCPAD,   " & _
                " OC_NIGV,    OC_NIGVPOR, OC_NISC,    OC_NISCPOR, OC_NCANSAL, OC_NTOTUS,  OC_NTOTMN,    " & _
                " OC_NTOTMO,  OC_NPREUNI, OC_COMENTA, OC_NDSCPFI, OC_NDESCFI, OC_NDSCPIT, OC_NDESCIT,   " & _
                " OC_NDSCPOR, OC_NDESCTO, OC_CCENCOS, OC_CSOLICI, OC_CNUMREQ, OC_DFECENT, OC_CITMPOR,   " & _
                " OC_CDSCPOR, OC_CIGVPOR, OC_CISCPOR, OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM,   " & _
                " OC_NCANREF, OC_CSERIE,  OC_NANCHO,  OC_NCORTE,  OC_CITEREQ, OC_CREFCOD, OC_CPEDINT,   " & _
                "  OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values  (                          " & _ 
                " '"&TIP&"', '"&OC&"',   Convert(datetime,'"&FECD&"',103),'"&PRO&" ', '1', '"&lin&"',   " & _
                " '"&cod&"', '"&ref&"','"&des&"', '"&uni&"', "&ped&", "&pre2&", "&dct&", "&Dite&", "&pigv&",   " & _
                " "&iigv&", "&pisc&", "&iisc&", '"&ped&"', "&usd&", "&sol&", 0, "&preuni&",     " & _
                " '"&come&"', '"&fin&"', 0, '"&adi&"', "&dadi&", 0, 0, '"&cto&"', '"&soli&"', '',        " & _
                " Convert(datetime,'"&ent&"',103), 'N', 'N', 'N', 'N' , '', '', 0,'', 0, '', 0, 0,'',   " & _
                " '', '', '', '',  '', 0) ;                                                             " & _
                " Insert RSFACCAR..AL0001APRO (PM_CCODMAT, PM_CCODPRO, PM_DFECDOC, PM_CTIPMON,          " & _
                " PM_NVALOR, PM_CCOTIZA, PM_CORDCOM,  PM_DFECCRE, PM_CHORA, PM_CUSER) Values (          " & _
                " '"&cod&"', '"&pro&"', Convert(datetime,'"&FECD&"',103), '"&mon&"',                    " & _
                " "&pre2&", '', '"&oc&"', Convert(datetime,'"&FECD&"',103), '"&hor&"', '"&USR&"')     ; "


' INCLUIR LOS INSERTS DE LAS OFIS.....

for i= 0 to ubound(aofi)
    SIT = RIGHT("00"+ CSTR(I),2)
    CAN = AcAN(I)
    OFI = AOFI(I)
    cad = cad + " INSERT ORDENCOMPRA (NUMORD, ITEM, SUB_IT, OFI, CODIGO, CANTIDAD, USUARIO,FECHA, ESTADO,   " & _
                " coddes, almdes) VALUES ('"&OC&"', '"&LIN&"', '"&SIT&"', '"&OFI&"', '"&COD&"', '"&CAN&"',  " & _
                " '"&USUARIO&"', GETDATE(), 'A', '"&ref&"', (select OC_CALMDES from rsfaccar..CO0001MOVc WHERE OC_CNUMORD = '"&oc&"'));"
NEXT

CAD = CAD + " INSERT MODELADOR..OCTALLA (NUMORD, ITEM, T0, Q0, T1, Q1, T2, Q2, T3, Q3, T4, Q4, T5, Q5,      " & _
            " T6, Q6, T7, Q7, T8, Q8, T9,Q9	, KGUNI, usuario,fecha,estado) values (  '"&OC&"', '"&lin&"',   " & _
            " '"&aTal(0)&"', "&aQty(0)&", '"&aTal(1)&"', "&aQty(1)&", '"&aTal(2)&"', "&aQty(2)&", '"&aTal(3)&"', "&aQty(3)&", '"&aTal(4)&"', "&aQty(4)&",     " & _     
            " '"&aTal(5)&"', "&aQty(5)&", '"&aTal(6)&"', "&aQty(6)&", '"&aTal(7)&"', "&aQty(7)&", '"&aTal(8)&"', "&aQty(8)&", '"&aTal(9)&"', "&aQty(9)&",     " & _
            " "&kgs&",'"&USR&"', Convert(datetime,'"&FECD&"',103),'A')"

response.write(cad)
'
' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)

Cnn.BeginTrans	
Cnn.Execute(CAD)
'response.end

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
    parent.top.window.opener.window.location.replace('../FICHAOCdeta.ASP?OC=' + '<%=OC%>')
//window.opener.top.window.location.replace('../FICHAOCdeta.ASP?OC=' + '<%=OC%>')

  parent.top.window.close()
//    parent.window.opener.window.top.parent.frames['mainFrame'].window.location.replace('../detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>');
</script>
</BODY>
</HTML>
