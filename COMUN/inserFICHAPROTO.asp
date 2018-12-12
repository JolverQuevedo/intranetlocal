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
op = request.QueryString("op")
PRO = REQUEST.FORM("PRO")
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
' DATOS DE CABECERA DEL PROTO
' ****************************************
IF TRIM(PRO) = "AUTO" THEN
    CAD = "SELECT TOP 1 PROTO FROM PROTOS ORDER BY 1 DESC"
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT>0 THEN
        PRO = RIGHT("0000000000"+TRIM(CSTR(RS("proto")+1)),10)
    ELSE
        PRO = "0000000001"
    END IF    
    RS.CLOSE
END IF
'response.Write(ver)
'   response.write("<Br>")
IF TRIM(VER) = "AUTO" THEN
    CAD = "SELECT TOP 1 VERSION FROM PROTOS WHERE PROTO = '"&PRO&"' ORDER BY 1 DESC"
    RS.OPEN CAD,CNN
    IF RS.RECORDCOUNT>0 THEN
        VER = RIGHT("000"+TRIM(CSTR(RS("VERSION")+1)),3)
    ELSE
        VER = "001"
    END IF    
    RS.CLOSE
END IF

'response.write(cad)
'response.write("<Br>")

CAD= "SELECT * FROM PROTOS WHERE PROTO='"&PRO&"' AND VERSION = '"&VER&"'"

RS.OPEN CAD,CNN, 2,2
rec = RS.RECORDCOUNT 
' Inicia transacción , para que los datos no queden a medias

RS.CLOSE
Cnn.BeginTrans	
CAD = ""
IF rec <= 0 THEN  
   '********************
   ' Insert
   '********************

   CAD = CAD +  " INSERT INTO PROTOS (PROTO, VERSION, CLIENTE, ESTILO, DESCRIPCION, TELA, TEMPORADA,    " & _
                " MOTIVO, ADICIONAL, MINCOR, MINCOS, MINACA, MINADI, EFICOR, EFICOS, EFIACA, EFIADI,    " & _
                "  USUARIO, FECHA, ESTADO,obs ) VALUES ( '"&pro&"', '"&VER &"', '"&CLI&"', '"&EST&"',       " & _
                " '"&DESE&"','"&TEL&"','"&TEM&"','"&MOT&"','"&ADIC&"', "

        IF len(TRIM(MINCOR)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINCOR&", " 
        IF len(TRIM(MINCOS)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINCOS&", " 
        IF len(TRIM(MINACA)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINACA&", " 
        IF len(TRIM(MINADI)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINADI&", " 

        IF len(TRIM(EFICOR)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFICOR&", " 
        IF len(TRIM(EFICOS)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFICOS&", " 
        IF len(TRIM(EFIACA)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFIACA&", " 
        IF len(TRIM(EFIADI)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFIADI&", " 
        CAD = CAD +           " '"&USUARIO&"', GETDATE(), 'A', '"&obse&"') ; "
    '********************
    ' observaciones
    '********************
CAD = CAD + " INSERT INTO [proto-obs] (PROTO, VERSION, SOLICITA, USUARIO,FECHA, ESTADO) VALUES  " & _
            " ('"&PRO&"', '"&VER&"', '"&OBS&"', '"&USUARIO&"', GETDATE(), 'A' ) ;          "
     
else
    CAD = CAD + "UPDATE PROTOS SET MINCOR = "
        IF len(TRIM(MINCOR)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINCOR&", " 
    CAD = CAD + " MINCOS = "
        IF len(TRIM(MINCOS)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINCOS&", " 
    CAD = CAD + " MINACA = "
        IF len(TRIM(MINACA)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINACA&", " 
    CAD = CAD + " MINADI = "
        IF len(TRIM(MINADI)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&MINADI&", " 
    CAD = CAD + " EFICOR = "
        IF len(TRIM(EFICOR)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFICOR&", " 
    CAD = CAD + " EFICOS = "
        IF len(TRIM(EFICOS)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFICOS&", " 
    CAD = CAD + " EFIACA = "
        IF len(TRIM(EFIACA)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFIACA&", " 
    CAD = CAD + " EFIADI = "
        IF len(TRIM(EFIADI)) = 0 THEN CAD = CAD + "NULL," ELSE CAD = CAD +     " "&EFIADI&", " 
    CAD = CAD + " USUARIO = '"&USUARIO&"', FECHA = GETDATE(), ESTADO = 'A',             " & _   
                " ESTILO =   '"&EST&"', DESCRIPCION = '"&DESE&"', TELA = '"&TEL&"',     " & _
                " TEMPORADA = '"&TEM&"', MOTIVO = '"&MOT&"', ADICIONAL = '"&ADIC&"' ,   " & _
                " obs = '"&obse&"'                                                      " & _
                " WHERE PROTO = '"&PRO&"' AND VERSION ='"&VER&"'    "    
    '********************
    ' observaciones
    '********************
    CAD = CAD +  "UPDATE  [PROTO-OBS] SET SOLICITA = '"&OBS&"' WHERE PROTO='"&PRO&"' AND VERSION = '"&VER&"' ;"
END IF    
'***************************************
' POR UPDATE O INSERT, SE HACE LO MISMO
' PRIMERO SE ELIMINAN LOS REGISTROS Y
' LUEGO SE VUELVEN A CREAR...
'***************************************
tallas()
TELAS()
AVIOS()


sub AVIOS()
CAD = CAD + "delete [proto-DETALLES] where PROTO='"&PRO&"' AND VERSION = '"&VER&"' AND TIPODETALLE= 'AV' ; "
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
            CAD = CAD +  " INSERT INTO [proto-detalles] (PROTO, [VERSION], TIPODETALLE, ID, CODIGO,         " & _
                         " ADICIONAL, CONSUMO, MERMA, PESO, FACTOR,CANPZA, TIPO, TOTAL, UNIDAD,             " & _
                         " USUARIO, FECHA, ESTADO, COSTO )  VALUES ( '"&PRO&"', '"&VER&"', 'AV', '"&I&"',   " & _
                         " '"&codi&"', '"&ADIC&"', '"&CONS&"', '"&MERM&"', "&PESO&", 1,1,'"&TIPO&"',        " & _
                         " "&tota&" , '"&UNID&"', '"&USUARIO&"', GETDATE(), 'A' , '"&csto&"') ;             "
        END IF    
    NEXT
end sub

sub TELAS()
CAD = CAD + "delete [proto-DETALLES] where PROTO='"&PRO&"' AND VERSION = '"&VER&"' AND TIPODETALLE= 'TE' ;"
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
           CAD = CAD +  " INSERT INTO [proto-detalles] (PROTO, [VERSION], TIPODETALLE, ID, CODIGO,    " & _
                         " ADICIONAL, CONSUMO, MERMA, PESO, FACTOR,CANPZA, ANCHO, TOTAL, UNIDAD,    " & _
                         " USUARIO,FECHA, ESTADO, RUTA)  VALUES ('"&PRO&"','"&VER&"','TE','"&I&"',  " & _
                         " '"&codi&"', '"&ADIC&"', '"&CONS&"', '"&MERM&"', "&PESO&", '"&FACT&"',    " & _
                         " '"&PZAS&"','"&ANCH&"', "&tota&" , 'KGR', '"&USUARIO&"', GETDATE(), 'A',  " & _
                         " '"&RUTA&"') ;                                                            "    
        END IF    
    NEXT

end sub

sub tallas()
    CAD = CAD +  "delete [proto-tallas] where PROTO='"&PRO&"' AND VERSION = '"&VER&"' ; "
    FOR I = 0 TO 14    
        IF TRIM(Request.Form("T"&I)) <> "" THEN
            TALL= TRIM(Request.Form("T"&I))
            IF TRIM(Request.Form("R"&I))="" THEN PROP  = 1 ELSE PROP  = TRIM(Request.Form("R"&I))
            CAD = CAD +     " INSERT INTO [PROTO-TALLAS] (PROTO, [VERSION], ORDEN, TALLA, " & _
                            " PROP, USUARIO, FECHA, ESTADO) VALUES ('"&PRO&"','"&VER&"'," & _
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
    MMM = '../detaproto.asp?pos=' + '<%=cli%>' +'&PRO=' + '<%=pro%>' + "&ver=" + '<%=ver%>'
   // alert(MMM)
    window.opener.window.location.replace(MMM)

    window.location.replace("../fichaproto.asp?pro="+'<%=pro%>'+"&ver="+'<%=ver%>')
</script>

<body>

</body>
</html>
