<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%session.LCID = 2057 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%USER = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<% fec =  "{ fn NOW() }"
op = request.QueryString("op")
COT = REQUEST.QueryString("COT")
PRO = REQUEST.QueryString("PRO")
VER = REQUEST.QueryString("VER")
p1 = request.form("pack")
p2 = request.form("boxpack")
IF  LEN(TRIM(REQUEST.FORM("COBE"))) > 0 THEN cobe = REQUEST.FORM("COBE") ELSE COBE= 0
IF  LEN(TRIM(REQUEST.FORM("ADUTOT"))) > 0 THEN ADUA = REQUEST.FORM("ADUTOT") ELSE ADUA= 0
ADUA = REPLACE(ADUA, ",", "")
CANT = REQUEST.FORM("CAN")
CANT = REPLACE(CANT, ",", "")
IF  LEN(TRIM(REQUEST.FORM("EFICI"))) > 0 THEN EFICI = REQUEST.FORM("EFICI") ELSE EFICI= 0
IF  LEN(TRIM(REQUEST.FORM("PORFIN"))) > 0 THEN PORFIN = REQUEST.FORM("PORFIN") ELSE PORFIN= 0
IF  LEN(TRIM(REQUEST.FORM("FAC1"))) > 0 THEN FAC1 = REQUEST.FORM("FAC1") ELSE FAC1= 0
IF  LEN(TRIM(REQUEST.FORM("FAC2"))) > 0 THEN FAC2 = REQUEST.FORM("FAC2") ELSE FAC2= 0
IF  LEN(TRIM(REQUEST.FORM("CERCOM"))) > 0 THEN CERCOM = REQUEST.FORM("CERCOM") ELSE CERCOM= 0
IF  LEN(TRIM(REQUEST.FORM("OTRTOT"))) > 0 THEN OTR = REQUEST.FORM("OTRTOT") ELSE OTR= 0
OTR = REPLACE(OTR, ",","")
IF  LEN(TRIM(REQUEST.FORM("FOBUNI"))) > 0 THEN FOB = REQUEST.FORM("FOBUNI") ELSE FOB= 0
IF  LEN(TRIM(REQUEST.FORM("DRAW"))) > 0 THEN DRAW = REQUEST.FORM("DRAW") ELSE DRAW= 0
IF  LEN(TRIM(REQUEST.FORM("RENTA"))) > 0 THEN RENTA = REQUEST.FORM("RENTA") ELSE RENTA= 0
VMIN = REQUEST.FORM("VALMIN")
IF  LEN(TRIM(REQUEST.FORM("COMI"))) > 0 THEN COMI = REQUEST.FORM("COMI") ELSE COMI= 0
IF  LEN(TRIM(REQUEST.FORM("RGSTOT"))) > 0 THEN RGS = REQUEST.FORM("RGSTOT") ELSE RGS= 0
RGS = REPLACE(RGS,",","")
IF  LEN(TRIM(REQUEST.FORM("TIPEMB"))) > 0 THEN TEMB = REQUEST.FORM("TIPEMB") ELSE TEMB= ""
ANCHOT = REQUEST.FORM("ANCHOT")
LARGOT = REQUEST.FORM("LARGOT")

CONSU = REQUEST.FORM("CONKI")
RENDI = REQUEST.FORM("RENDM")
TCAM = REQUEST.FORM("TCAM")
IF  LEN(TRIM(REQUEST.FORM("OBSERVA"))) > 0 THEN OBS = REQUEST.FORM("OBSERVA") ELSE OBS= ""
   
FCOT = date()

CLI = REQUEST.QueryString("CLI")
EST = REQUEST.QueryString("EST")
TEL = REQUEST.QueryString("TEL")
TEM = REQUEST.QueryString("TEM")
IF  LEN(TRIM(REQUEST.FORM("MINCOR"))) > 0 THEN M1 = REQUEST.FORM("MINCOR") ELSE M1= 0
IF  LEN(TRIM(REQUEST.FORM("MINCOS"))) > 0 THEN M2 = REQUEST.FORM("MINCOS") ELSE M2= 0
IF  LEN(TRIM(REQUEST.FORM("MINACA"))) > 0 THEN M3 = REQUEST.FORM("MINACA") ELSE M3= 0
IF  LEN(TRIM(REQUEST.FORM("MINADI"))) > 0 THEN M4 = REQUEST.FORM("MINADI") ELSE M4= 0
IF  LEN(TRIM(REQUEST.FORM("EFICOR"))) > 0 THEN F1 = REQUEST.FORM("EFICOR") ELSE F1= 0
IF  LEN(TRIM(REQUEST.FORM("EFICOS"))) > 0 THEN F2 = REQUEST.FORM("EFICOS") ELSE F2= 0
IF  LEN(TRIM(REQUEST.FORM("EFIACA"))) > 0 THEN F3 = REQUEST.FORM("EFIACA") ELSE F3= 0
IF  LEN(TRIM(REQUEST.FORM("EFIADI"))) > 0 THEN F4 = REQUEST.FORM("EFIADI") ELSE F4= 0
IF  LEN(TRIM(REQUEST.FORM("DESADI"))) > 0 THEN ADI = REQUEST.FORM("DESADI") ELSE ADI= ""

'telas maximo número' 
TELM = REQUEST.QueryString("TELM")
' Avios ultimo número de linea
avim = REQUEST.QueryString("avim")
rutas= ucase(TRIM(Request.QueryString("rutas")))
mate= ucase(TRIM(Request.QueryString("mate")))
FECHA ="{ fn NOW() }"


' ****************************************
' DATOS DE CABECERA DE LA COGTIZACION
' ****************************************
IF TRIM(COT) = "AUTO" or trim(cot) = ""  THEN
    CAD = "SELECT TOP 1 COTIZACION FROM COTIZACION ORDER BY 1 DESC"
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT>0 THEN
        COT = RIGHT("0000000000"+TRIM(CSTR(RS("COTIZACION")+1)),10)
    ELSE
        COT = "0000000001"
    END IF    
    RS.CLOSE
    NUEVO = 1
ELSE
    NUEVO = 0
END IF
  aRut = split(rutas,",")
  aMat = split(mate, ",")
CAD = " set dateformat dmy; "
IF NUEVO = 1 THEN  
'*******************************
' Insert CABECERA COTIZACION
'*******************************
CAD = CAD + " INSERT INTO COTIZACION (COTIZACION, PROTO, [VERSION], PACK, PACKCAJA,   " & _
            " COBERTURA, ADUANAS, CANTIDAD, EFI_TIZADO, FINANCIA, CERTINTEX, OTROS, " & _
            " FOB, DRAWBACK, RENTA, VALORMINUTO, COMISION, CAMBIO, USUARIO, FECHA,  " & _
            " ESTADO, OBS, RGS, TIPEMB, FACTOR1, FACTOR2, ANCHOT, LARGOT,           " & _
            " RENDIMIENTO, CONSUMO )                                                " & _
            " VALUES('"&COT&"', '"&PRO&"', '"&VER&"', '"&p1&"','"&p2&"','"&COBE&"', " & _
            " '"&adua&"', "&CANT&", "&EFICI&",  "&PORFIN&", "&CERCOM&", "&OTR&",    " & _
            " "&FOB&", "&DRAW&", "&RENTA&", "&VMIN&", "&COMI&", "&TCAM&",'"&USER&"'," & _
            " "&FCOT&", 'A', '"&OBS&"', "&RGS&", '"&TEMB&"', "&FAC1&", "&FAC2&",   " & _
            " "&ANCHOT&", "&LARGOT&", "&RENDI&", "&CONSU&" ) ;                      "
'**********************************************************************
' Insert COTIZACION - RUTA (POR LOS PRECIOS DE LOS SERVICIOS ..........
'********************************************************************** 

  ord = 1  
  ' I es por el número de telas
   FOR I = 0 TO cint(telm)-1
        TELA =  TRIM(Request.Form("TEL1"&I+1)) 
        ID =  TRIM(Request.Form("ID1"&I+1)) 
        MIR =  TRIM(Request.Form("MERI"&I+1)) 
  
       ' K es por el numero de servicios de la ruta  
       
        IF I+1 <= CINT(TELM )  THEN 
        if ubound(arut) > 0 then TOPE = aRut(I+1)+I else tope =0
       ELSE 
           TOPE=0
       end if



       FOR k = (i+1) TO TOPE  
            ser =  TRIM(Request.Form("ser"&ord)) 
            mer =  TRIM(Request.Form("M"&ord)) 
            CTO =  TRIM(Request.Form("CTO"&ord)) 
            UNI =  TRIM(Request.Form("UNT"&ord)) 
            cad = cad + " INSERT INTO COTIRUTA (        " & _
                        " COTIZACION, TELA, ID, ORDEN,  " & _
                        " SERVICIO, MERMA, COSTO,       " & _
                        " UNIDAD, USUARIO, FECHA,       " & _
                        " ESTADO ) VALUES ( '"&COT&"' , " & _
                        " '"&tela&"', '"&ID&"', "&ord&"," & _
                        " '"&ser&"', "&MER&", "&CTO&",  " & _
                        " '"&UNI&"', '"&USER&"',        " & _
                        " getdate(), 'A') ;             "
            ord = ord + 1
       next
       
       cad = cad + " UPDATE [PROTO-DETALLES] SET " & _
                   " MERMA = "&MIR&"             " & _
                   " WHERE PROTO = '"&PRO&"' AND " & _
                   " VERSION = '"&VER&"' AND     " & _
                   " ID = '"&ID&"';              "
        
        
   next 

  telas()
   AVIOS()
   MINUTOS()
   tallas()  



else
'*********************
' UPDATE COTIZACION 
'*********************

    CAD = CAD + " UPDATE COTIZACION SET         " & _
                " PACK          = "&P1&",       " & _
                " PACKCAJA      = "&P2&",       " & _
                " COBERTURA     = "&COBE&",     " & _
                " ADUANAS       = "&ADUA&",     " & _
                " CANTIDAD      = "&CANT&",     " & _
                " EFI_TIZADO    = "&EFICI&",    " & _
                " FINANCIA      = "&PORFIN&",   " & _
                " CERTINTEX     = "&CERCOM&",   " & _
                " OTROS         = "&OTR&",      " & _
                " FOB           = "&FOB&",      " & _
                " DRAWBACK      = "&DRAW&",     " & _
                " RENTA         = "&RENTA&",    " & _
                " VALORMINUTO   = "&VMIN&",     " & _
                " COMISION      = "&COMI&",     " & _
                " CAMBIO        = "&TCAM&",     " & _
                " USUARIO       = '"&USER&"',   " & _
                " FECHA         = '"&FCOT&"',   " & _
                " ESTADO        = 'A',          " & _
                " OBS           = '"&OBS&"',    " & _
                " RGS           = "&RGS&",      " & _
                " TIPEMB        = '"&TEMB&"',   " & _
                " FACTOR1       = "&FAC1&",     " & _
                " FACTOR2       = "&FAC2&",     " & _
                " ANCHOT        = "&ANCHOT&",   " & _
                " LARGOT        = "&LARGOT&",   " & _
                " RENDIMIENTO   = "&RENDI&",    " & _
                " CONSUMO       = "&CONSU&"     " & _
                " WHERE COTIZACION = '"&COT&"'; "

'*********************************************************************
' UPDATE COTIZACION - RUTA (POR LOS PRECIOS DE LOS SERVICIOS ..........
'********************************************************************** 
  aRut = split(rutas,",")
  aMat = split(mate, ",")

  ord = 1  
  ' I es por el número de telas
   FOR It = 0 TO cint(telm)-1
        TELA =  TRIM(Request.Form("TEL1"&It+1)) 
        ID =  TRIM(Request.Form("ID1"&It+1)) 
        MIR =  TRIM(Request.Form("MERI"&It+1)) 

       ' K es por el numero de servicios de la ruta  
       
       IF It+1  <= CINT(TELM )  THEN 
        if ubound(arut) > 0 then TOPE = aRut(It+1)+It else tope =0
       ELSE 
           TOPE=0
       end if
       FOR kt = (it+1) TO TOPE  
            ser =  TRIM(Request.Form("ser"&ord)) 
            mer =  TRIM(Request.Form("M"&ord)) 
            CTO =  TRIM(Request.Form("CTO"&ord)) 
            UNI =  TRIM(Request.Form("UNT"&ord)) 
            cad = cad + " UPDATE COTIRUTA SET           " & _
                        " MERMA     =  '"&MER&"',       " & _ 
                        " COSTO     =  "&CTO&",         " & _
                        " USUARIO   = '"&USER&"' ,      " & _
                        " FECHA     = getdate(),        " & _
                        " ESTADO    = 'A'               " & _
                        " WHERE COTIZACION='"&COT&"'    " & _
                        " AND TELA      = '"&tela&"'    " & _
                        " AND  ID       = '"&ID&"'      " & _
                        " AND ORDEN     =  '"&ord&"'    " & _
                        " AND SERVICIO  = '"&ser&"';    "  
            ord = ord + 1
           
       next
       cad = cad + " UPDATE [PROTO-DETALLES] SET " & _
                   " MERMA = "&MIR&"            " & _
                   " WHERE PROTO = '"&PRO&"' AND " & _
                   " VERSION = '"&VER&"' AND     " & _
                   " ID = '"&ID&"';              "
   next 
 

    telas()
    AVIOS()
    MINUTOS()
    tallas()
END IF

sub telas()
'**********************************************************************
' Insert COTIZACION - hilos por tela (POR LOS PRECIOS DEL hilado .....
'********************************************************************** 
   CAD =  CAD + " DELETE COTIHILADO WHERE       " & _
                " COTIZACION    = '"&COT&"'  ;  "
  ord = 1
  ' I es por el número de telas
  orden = 1
  FOR I = 0 TO cint(telm)-1
       TELA =  TRIM(Request.Form("TEL1"&I+1)) 
       ID   =  TRIM(Request.Form("ID1"&I+1)) 
  
       
      Ctope = "select LEN(hil1+hil2+hil3+HIL4+HIL5+HIL6)/12 AS NUMHIL from telas where tela = '"&TELA&"'"
      RS.OPEN CTOPE, CNN
      IF RS.RECORDCOUNT > 0 THEN TOPE = CINT(RS("NUMHIL")) ELSE TOPE = 0
      RS.CLOSE
     
       RESPONSE.WRITE(TOPE)
       RESPONSE.Write("<BR>")
       FOR k = 1 TO TOPE 
            CTO =  TRIM(Request.Form("CH"&ord)) 
            cad = cad + " INSERT INTO COTIHILADO (          " & _
                        " COTIZACION, TELA, ID, ORDEN,      " & _
                        " COSTO,  USUARIO, FECHA,           " & _
                        " ESTADO ) VALUES ( '"&COT&"' ,     " & _
                        " '"&tela&"', '"&ID&"', "&orden&",  " & _
                        " "&CTO&",  '"&USER&"',             " & _
                        " getdate(), 'A') ;                 "
            ord = ord + 1
            orden = orden + 1
        next

        costo = TRIM(Request.Form("USD"&I+1))
         
        IF CDBL(COSTO) > 0 THEN
            cad = cad + " UPDATE [PROTO-DETALLES] SET   " & _
                " costo = "&costo&"                     " & _
                " WHERE PROTO = '"&PRO&"' AND           " & _
                " VERSION = '"&VER&"' AND               " & _
                " ID = '"&ID&"';                        "
        ELSE
            cad = cad + " UPDATE [PROTO-DETALLES] SET   " & _
                " costo = null                          " & _
                " WHERE PROTO = '"&PRO&"' AND           " & _
                " VERSION = '"&VER&"' AND               " & _
                " ID = '"&ID&"';                        "
        END IF
  next 
end sub
sub AVIOS()
'*********************************
' UPDATE COTIZACION - AVIOS
'*********************************
   ' A es por el número de AVIOS
   FOR A = 0 TO cint(AVIM)  
       CCTO =  TRIM(Request.Form("ACTO"&A)) 
       amer =  TRIM(Request.Form("MRR"&A)) 
       IDO = Request.Form("AID"&A)
       CAD = CAD +  " UPDATE [PROTO-DETALLES] SET   " & _
                    " COSTO = "&CCTO&",             " & _
                    " MERMA = "&AMER&"              " & _
                    " WHERE PROTO = '"&PRO&"' AND   " & _
                    " VERSION = '"&VER&"' AND       " & _
                    " ID = '"&IDO&"';               "
   NEXT
end sub
 
sub MINUTOS()
CAD = CAD + " UPDATE [protos] SET           " & _
            " MINCOR = "&M1&",              " & _
            " MINCOS = "&M2&",              " & _
            " MINACA = "&M3&",              " & _
            " MINADI = "&M4&",              " & _
            " EFICOR = "&F1&",              " & _
            " EFICOS = "&F2&",              " & _
            " EFIACA = "&F3&",              " & _
            " EFIADI = "&F4&",              " & _
            " ADICIONAL = '"&ADI&"' ,       " & _
            " cotizacion = '"&cot&"'        " & _
            " WHERE PROTO = '"&PRO&"' AND   " & _
            " VERSION = '"&VER&"' ;         "
end sub

sub tallas()

dd = CINT(Request.form("NUMTALLAS")) 
response.write ("<br>")
response.write ("-------------------------------")
response.write ((Request.form("NUMTALLAS")) )
response.write ("-------------------------------")
response.write ("<br>")
  FOR I = 0 TO   dd 
    QTY = TRIM(Request.Form("T"&I))
    QTY = REPLACE(QTY,",","")
    IF len(trim(qty)) > 0  THEN
        CAD = CAD + " UPDATE [PROTO-TALLAS] SET " & _
                    " CANT = '"&QTY&"',         " & _
                    " USUARIO = '"&USER&"',     " & _
                    " FECHA   = getdate(),      " & _
                    " estado  = 'A'             " & _
                    " WHERE  PROTO = '"&PRO&"'  " & _
                    " AND VERSION = '"&VER&"'   " & _
                    " AND ORDEN = '"&I&"' ;     "
        totalprendas = totalprendas + cdbl(qty)
        END IF    

    NEXT
     CAD = CAD + " UPDATE COTIZACION SET            " & _
                " CANTIDAD      = "&totalprendas&"  " & _
                " WHERE COTIZACION = '"&COT&"';     "    
end sub

response.write (cad)
'RESPONSE.End
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
    cnn.execute (cad)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
Cnn.Close	
%>
<script language="jscript" type="text/jscript">

    window.opener.window.location.replace('../detacoti.asp?pos='+'<%=cli%>')
    window.location.replace("../fichacotizacion.asp?pro="+'<%=pro%>'+"&ver="+'<%=ver%>' +"&COT="+'<%=COT %>' )
    
</script>


<body>

</body>
</html>
