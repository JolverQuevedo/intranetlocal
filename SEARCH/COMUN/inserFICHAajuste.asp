<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script language="jscript" type="text/jscript">


</script>
</head>
<% fec =  "{ fn NOW() }"
AJU = REQUEST.FORM("AJU")
VER = REQUEST.FORM("VER")
CLI = REQUEST.FORM("CLI")
EST = REQUEST.FORM("EST")
DES = ucase(REQUEST.FORM("DESE"))
TEL = REQUEST.FORM("TELA")
TEM = REQUEST.FORM("TEM") 
MOT = ucase(REQUEST.FORM("MOT"))
obs = ucase(REQUEST.FORM("OBSERVA"))
obse = ucase(REQUEST.FORM("OBSE"))
DESE = UCASE(REQUEST.FORM("DESE"))
ADIC = REQUEST.FORM("DESADI")
MINCOR = REQUEST.FORM("MINCOR")
MINCOS = REQUEST.FORM("MINCOS")
MINACA = REQUEST.FORM("MINACA")
MINADI = REQUEST.FORM("MINADI")
EFICOR = REQUEST.FORM("EFICOR")
EFICOS = REQUEST.FORM("EFICOS")
EFIACA = REQUEST.FORM("EFIACA")
EFIADI = REQUEST.FORM("EFIADI")
' ****************************************
' DATOS DE CABECERA DEL ajuste
' ****************************************
CAD= "SELECT * FROM AJUSTES WHERE AJUSTE='"&AJU&"' AND VERSION = '"&VER&"'; "

RS.OPEN CAD,CNN, 2,2
rec = RS.RECORDCOUNT 
' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE(CAD)
'RESPONSE.END

RS.CLOSE
Cnn.BeginTrans	
CAD = ""
'***************************************
' POR UPDATE O INSERT, SE HACE LO MISMO
' PRIMERO SE ELIMINAN LOS REGISTROS Y
' LUEGO SE VUELVEN A CREAR...
'***************************************





tallas()
TELAS()
AVIOS()


sub AVIOS()
CAD = CAD + "delete [AJUSTE-DETALLES] where AJUSTE='"&AJU&"' AND VERSION = '"&VER&"' AND TIPODETALLE= 'AV' ; "
    FOR I = request.querystring("telm")-1 TO request.querystring("AVIM")
        IF TRIM(Request.Form("AVI"&I)) <> "" THEN
            CODI    = TRIM(Request.Form("AVI"&I))
            ADIC    = ucase(TRIM(Request.Form("OBS"&I)))
            CONS    = TRIM(Request.Form("CON"&I))
            MERM    = TRIM(Request.Form("MRR"&I))
            PESO    = TRIM(Request.Form("CON"&I))
            TIPO    = TRIM(Request.Form("EXX"&I))
            TOTA    = TRIM(Request.Form("TTO"&I))
            csto    = TRIM(Request.Form("costo"&I))
            UNID    = TRIM(Request.Form("UNI"&I))
            CAD = CAD +  " INSERT INTO [AJUSTE-detalles] (AJUSTE, [VERSION], TIPODETALLE, ID, CODIGO,         " & _
                         " ADICIONAL, CONSUMO, MERMA, PESO, FACTOR,CANPZA, TIPO, TOTAL, UNIDAD,             " & _
                         " USUARIO, FECHA, ESTADO, COSTO )  VALUES ( '"&AJU&"', '"&VER&"', 'AV', '"&I&"',   " & _
                         " '"&codi&"', '"&ADIC&"', '"&CONS&"', '"&MERM&"', "&PESO&", 1,1,'"&TIPO&"',        " & _
                         " "&tota&" , '"&UNID&"', '"&USUARIO&"', GETDATE(), 'A' , '"&csto&"') ;             "
        END IF    
    NEXT
end sub

sub TELAS()
CAD = CAD + "delete [AJUSTE-DETALLES] where AJUSTE='"&AJU&"' AND VERSION = '"&VER&"' AND TIPODETALLE= 'TE' ;"
    FOR I = 0 TO request.querystring("telm")
        IF TRIM(Request.Form("TEL"&I)) <> "" THEN
            CODI    = TRIM(Request.Form("TEL"&I))
            ADIC    = ucase(TRIM(Request.Form("COM"&I)))
            CONS    = TRIM(Request.Form("LAR"&I))
            MERM    = TRIM(Request.Form("MER"&I))
            PESO    = TRIM(Request.Form("CUN"&I))
            ANCH    = TRIM(Request.Form("ANC"&I))
            TOTA    = TRIM(Request.Form("TOT"&I))
            UNID    = TRIM(Request.Form("UNI"&I))
            PZAS    = TRIM(Request.Form("PZA"&I))
            FACT    = TRIM(Request.Form("FAC"&I))
            RUTA    = RIGHT("000" & TRIM(Request.Form("RUT"&I)),3)
           CAD = CAD +  " INSERT INTO [AJUSTE-detalles] (AJUSTE, [VERSION], TIPODETALLE, ID, CODIGO,    " & _
                         " ADICIONAL, CONSUMO, MERMA, PESO, FACTOR,CANPZA, ANCHO, TOTAL, UNIDAD,        " & _
                         " USUARIO,FECHA, ESTADO, RUTA)  VALUES ('"&AJU&"','"&VER&"','TE','"&I&"',      " & _
                         " '"&codi&"', '"&ADIC&"', '"&CONS&"', '"&MERM&"', "&PESO&", '"&FACT&"',        " & _
                         " '"&PZAS&"','"&ANCH&"', "&tota&" , 'KGR', '"&USUARIO&"', GETDATE(), 'A',      " & _
                         " '"&RUTA&"') ;                                                                "    
        END IF    
    NEXT

end sub

sub tallas()
    CAD = CAD +  "delete [AJUSTE-tallas] where AJUSTE='"&AJU&"' AND VERSION = '"&VER&"' ; "
    FOR I = 0 TO 14    
        IF TRIM(Request.Form("T"&I)) <> "" THEN
            TALL= TRIM(Request.Form("T"&I))
            IF TRIM(Request.Form("R"&I))="" THEN PROP  = 1 ELSE PROP  = TRIM(Request.Form("R"&I))
            CAD = CAD +     " INSERT INTO [AJUSTE-TALLAS] (AJUSTE, [VERSION], ORDEN, TALLA, " & _
                            " PROP, USUARIO, FECHA, ESTADO) VALUES ('"&AJU&"','"&VER&"'," & _
                            " '"&I&"', '"&TALL&"', '"&PROP&"', '"&USUARIO&"',           " & _
                            " GETDATE(), 'A'  )  ;                                      "
        ELSE
            EXIT FOR
        END IF    
    NEXT
end sub

RESPONSE.WRITE(CAD)
'RESPONSE.End
Cnn.EXECUTE CAD
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
    MMM = '../detaAJUSTE.asp?pos=' + '<%=cli%>' +'&aju=' + '<%=aju%>' + "&ver=" + '<%=ver%>'
   // alert(MMM)

    window.location.replace("../fichaAJUSTE.asp?aju=" + '<%=aju%>' + "&ver=" + '<%=ver%>') 
  //  window.opener.window.location.replace(MMM)
</script>

<body>

</body>
</html>
