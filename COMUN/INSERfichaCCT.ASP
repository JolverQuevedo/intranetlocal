<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%Response.Write("<center>")
Response.Write("<font color=red 5 face=arial>")
Response.Write("<br><br>")
Response.Write("<br><br>")
Response.Write("<br><b>")
Response.Write("GRABANDO Y VERIFICANDO DATOS")
'*********************** OJO **********************

FECHA ="{ fn NOW() }"
cct=request.querystring("CCT")
par=request.querystring("PAR")
tel=request.querystring("TEL")
COL=request.querystring("COL")
COM=request.querystring("COM")
CLI=request.querystring("CLI")
FIN=fecha
OFI=request.querystring("OFI")
KGS=replace(request.querystring("KGS"),",",".")
RLL=replace(request.querystring("RLL")  , ",", ".")
RL2=replace(request.querystring("RL2")  , ",", ".")
OC=replace(request.querystring("OC")    , ",", ".")
RUC=replace(request.querystring("RUC")  , ",", ".")
TIP=replace(request.querystring("TIP")  , ",", ".")
POR=replace(request.querystring("por")  , ",", ".")
VLA=replace(request.querystring("VLA")  , ",", ".")
VAA=replace(request.querystring("VAA")  , ",", ".")
VLD=replace(request.querystring("VLD")  , ",", ".")
VAD=replace(request.querystring("VAD")  , ",", ".")
LFA=replace(request.querystring("LFA")  , ",", ".")
LFD=replace(request.querystring("LFD")  , ",", ".")
LRA=replace(request.querystring("LRA")  , ",", ".")
LRD=replace(request.querystring("LRD")  , ",", ".")
VLL=replace(request.querystring("VLL")  , ",", ".")
VAL=replace(request.querystring("VAL")  , ",", ".")
LFL=replace(request.querystring("LFL")  , ",", ".")
LRL=replace(request.querystring("LRL")  , ",", ".")
TON=replace(request.querystring("TON")  , ",", ".")
DEG=replace(request.querystring("DEG")  , ",", ".")
TAC=replace(request.querystring("TAC")  , ",", ".")
REP=replace(request.querystring("REP")  , ",", ".")
AO=replace(request.querystring("AO")    , ",", ".")
AV=replace(request.querystring("AV")    , ",", ".")
lPv=replace(request.querystring("lPv")  , ",", ".")
lPl=replace(request.querystring("lPl")  , ",", ".")
DMIN=replace(request.querystring("DMIN"), ",", ".")
DMAX=replace(request.querystring("DMAX"), ",", ".")
MAC=replace(request.querystring("MAC")  , ",", ".")
CAL=replace(request.querystring("CAL")  , ",", ".")
CON=replace(request.querystring("CON")  , ",", ".")
OBS=request.querystring("OBS") 
aOB=request.querystring("aobs")
arl=request.querystring("arll") 
ANU=request.querystring("aNUM")
can=request.querystring("acan") 
def=request.querystring("adef")
aObs = split(aob,",")
aRll = split(arl,",")
aNum = split(anu, ",")
aCan = split(can, ",")
aDef = split(def, ",")
cad = ""

if trim(av)   = "" then AV = 0
IF TRIM (AO)  = "" THEN AO = 0
IF TRIM(DMIN) = "" THEN DMIN =0
IF TRIM(DMAX) = "" THEN DMAX = 0
for i=0 to ubound(aCan)
    IF TRIM(ACAN(I)) = "" THEN ACAN(I) = 0 
next
' AGREGUE UNA COLUMNA SALDO
' PARA PODER LLEVAR CONTROL 
' DE LOS KILOS ASIGNADOS A OFI's
if trim(cct) = "AUTO" then
    rs.open "select count(*) as cc from CCTELA"  , cnn
    if rs.recordcount <=0 then
        cct= "0000000001"
    else    
        rs.movefirst    
        cct= right("0000000000"+ cstr(cdbl(rs("cc"))+1),10)
    end if
    rs.close
    ' inserta una NUEVA ficha de CCT
    cad = cad + " INSERT INTO CCTELA (CCT, TELA, PARTIDA, COLOR, COMBI,     " & _
                " CLIENTE, FECINI, PEDIDO, PESOTOTAL, TOTALROLLOS, OC,      " & _
                " PROVEEDOR, TIPOCCT, PORCENTAJE, VAPLARA, VAPANCA, VAPLARD," & _
                " VAPANCD, LAVFALA, LAVFALD, LAVREVA, LAVREVD, VAPLARL,     " & _
                " VAPANCL, LAVFaLL, LAVREVL,TONO, MATCHING, DEGRADE, TACTO, " & _
                " REPROCESO, CALIDAD, CONDICION, ANCHOOBTENIDO, ANCHOVAP,   " & _
                " DENMIN, DENMAX, RLLINS, USUARIO, FECHA, ESTADO, LAVporv,  " & _
                " LAVporL,SALDO) VALUES (                                   " & _
                " '"&CCT&"', '"&TEL&"', '"&PAR&"', '"&COL&"', '"&COM&"',    " & _
                " '"&CLI&"', "&Fin&", '"&OFI&"', "&KGS&", "&RLL&", '"&OC&"'," & _
                " '"&RUC&"', '"&TIP&"', "&POR&", "&VLA&", "&VAA&", "&VLD&", " & _
                " "&VAD&", "&LFA&", "&LFD&", "&LRA&", "&LRD&", "&VLL&",     " & _
                " "&VAL&", "&LFL&", "&LRL&", '"&TON&"', '"&MAC&"','"&DEG&"'," & _
                " '"&TAC&"', '"&REP&"', '"&CAL&"', '"&CON&"', "&AO&","&AV&"," & _ 
                " "&DMIN&", "&DMAX&", "&RL2&",'"&USUARIO&"',"&FECHA&",'A',  " & _
                " "&LPV&", "&LPL&", "&KGS&");                               "
    CAD = CAD + " INSERT INTO CCTOBSERVACIONES (CCT, OBSERVACIONES, USUARIO," & _
                " FECHA, ESTADO) VALUES ('"&CCT&"', '"&OBS&"','"&USUARIO&"'," & _
                " "&FECHA&", 'A');                        "
else
    ' update a la cabecera de CCT
    CAD = CAD + " UPDATE CCTELA SET         " & _
                " PARTIDA   =   '"&PAR&"',  " & _ 
                " COLOR     =   '"&col&"',  " & _
                " COMBI     =   '"&com&"',  " & _
                " CLIENTE   =   '"&cli&"',  " & _
                " FECINI    =   "&fin&",    " & _
                " PEDIDO    =   '"&ofi&"',  " & _
                " PESOTOTAL =   "&kgs&",    " & _
                " TOTALROLLOS=  "&rll&",    " & _
                " OC        =   '"&oc&"',   " & _
                " TELA      =   '"&TEL&"',  " & _
                " PROVEEDOR =   '"&ruc&"',  " & _
                " TIPOCCT   =   '"&tip&"',  " & _
                " PORCENTAJE=   "&por&",    " & _
                " VAPLARA   =   "&vla&",    " & _
                " VAPANCA   =   "&vaa&",    " & _
                " VAPLARD   =   "&VLD&",    " & _
                " VAPANCD   =   "&VAD&",    " & _
                " LAVFALA   =   "&LFA&",    " & _
                " LAVFALD   =   "&LFD&",    " & _
                " LAVREVA   =   "&LRA&",    " & _
                " LAVREVD   =   "&LRD&",    " & _
                " LAVporv   =   "&LPV&",    " & _
                " LAVporl   =   "&LPl&",    " & _
                " VAPLARL   =   "&VLL&",    " & _
                " VAPANCL   =   "&VAL&",    " & _
                " LAVFaLL   =   "&LFL&",    " & _
                " LAVREVL   =   "&LRL&",    " & _
                " TONO      =   '"&TON&"',  " & _
                " MATCHING  =   '"&MAC&"',  " & _
                " DEGRADE   =   '"&DEG&"',  " & _
                " TACTO     =   '"&TAC&"',  " & _
                " REPROCESO =   '"&REP&"',  " & _
                " CALIDAD   =   '"&cal&"',  " & _
                " CONDICION =   '"&CON&"',  " & _
                " ANCHOOBTENIDO = "&AO&",   " & _
                " ANCHOVAP  =   "&AV&",     " & _
                " DENMIN    =   "&DMIN&",   " & _
                " DENMAX    =   "&DMAX&",   " & _
                " RLLINS    =   "&RL2&",    " & _
                " USUARIO   = '"&USUARIO&"'," & _
                " FECHA     =   "&FECHA&",  " & _
                " SALDO     =  "&KGS&",     " & _
                " ESTADO    = 'A'           " & _
                " where cct = '"&cct&"';    "

    cad = cad + " UPDATE CCTOBSERVACIONES   " & _
                " SET OBSERVACIONES =       " & _
                " '"&OBS&"' ,               " & _
                " USUARIO  = '"&USUARIO&"', " & _
                " FECHA     =   "&FECHA&",  " & _
                " ESTADO    = 'A'           " & _
                " where cct= '"&cct&"';     "
end if



'borra TODOS los registros de cctdefectos y de cctrollos
cad = cad + "delete cctdefectos where cct= '"&cct&"'; "
cad = cad + "delete cctrollos   where cct= '"&cct&"'; "
'****************************************************************************
' el INSERT de defectos y rollos es el MISMO cuando es update o INSERT
'****************************************************************************
CN = 0
response.Write(lbound(aCan))

'response.end
FOR I = 1 TO RL2 'NÚMERO DE ROLLOS INSPECCIONADOS.....
    CAD = CAD + " INSERT INTO CCTROLLOS (CCT, ROLLO, ANCHO, OBS, NUMDEF," & _
                " usuario,fecha, estado) VALUES ('"&CCT&"', "&I&",      " & _ 
                " "&ARll(I)&", '"&AOBS(I)&"', "&ANUM(I)&",              " & _
                " '"&USUARIO&"',"&FECHA&", 'A' );                       "
    '*****************************************************
    ' HAY QUE HACER EL INSERT DE DFEFECTOS POR CADA ROLLO
    '*****************************************************
    FOR J=0 TO ubound(aDEF)
        CAD = CAD + " INSERT INTO CCTDEFECTOS (CCT, ROLLO, DEFECTO,CANT, " & _
                    " USUARIO, fecha, ESTADO ) VALUES ('"&CCT&"', "&I&", " & _
                    " '"&aDef(J)&"',  "&aCan(CN)&" ,'"&USUARIO&"',       " & _
                    " "&FECHA&", 'A' );                                  "    
        cn = cn + 1
        ' el Acan trae TODAS las cantidades en una tripa, sin distinguir 
        ' a que rollo pertencen, por eso se trabaja con otro contador
    NEXT
NEXT


Response.Write(CAD)
'Response.END



CNN.BEGINTRANS
CNN.EXECUTE (CAD)

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
'Response.Write(bAD)
'Response.END		
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
%>
<script>
cct ='<%=trim(cct)%>'
top.window.location.replace('../fichaCCT.asp?POS='+cct)
</script>
</BODY>
</HTML>
