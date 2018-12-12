<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%'=request.QueryString()%>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CAM =   trim(REQUEST.QUERYSTRING("CAM"))
'response.write(CAM)
'response.Write("<br>")
'response.write("cam")
'response.Write("<br>")
OC =    TRIM(REQUEST.QUERYSTRING("OC"))
SIT =   LEFT(TRIM(REQUEST.QUERYSTRING("sit")),1)
PRO =   TRIM(REQUEST.QUERYSTRING("pro"))
RAZ =   LEFT(TRIM(REQUEST.QUERYSTRING("raz")),80)
DIR =   LEFT(TRIM(REQUEST.QUERYSTRING("dir")),80)
COT =   LEFT(TRIM(REQUEST.QUERYSTRING("COT")),30)
FDO =   TRIM(REQUEST.QUERYSTRING("FEDO"))
FPAG =  LEFT(TRIM(REQUEST.QUERYSTRING("FPAG")),30)
MON =   LEFT(TRIM(REQUEST.QUERYSTRING("MON")),2)
AL2 =   LEFT(TRIM(REQUEST.QUERYSTRING("AL2")),4)
ENT =   TRIM(REQUEST.QUERYSTRING("ENT"))
KOS =   LEFT(TRIM(REQUEST.QUERYSTRING("KOS")),12)
SOLi =   LEFT(TRIM(REQUEST.QUERYSTRING("SOL")),50)
LUG =   LEFT(TRIM(REQUEST.QUERYSTRING("LUG")),80)
LFA =   LEFT(TRIM(REQUEST.QUERYSTRING("LFA")),80)
OBS =   LEFT(TRIM(REQUEST.QUERYSTRING("OBS")),80)
TIP =   LEFT(TRIM(REQUEST.QUERYSTRING("TIP")),80)
USR =   LEFT(TRIM(REQUEST.QUERYSTRING("USR")),5)
TOC =   LEFT(TRIM(REQUEST.QUERYSTRING("TOC")),1)
FAC =   DATE()
HOR =   LEFT(TIME(),8)
DOL =   TRIM(REQUEST.QUERYSTRING("mus")   )
SOL =   TRIM(REQUEST.QUERYSTRING("mmn")   )
PE1 =   TRIM(REQUEST.QUERYSTRING("PE1")   )
PE2 =   LEFT(TRIM(REQUEST.QUERYSTRING("PE2")),30)
PE3 =   LEFT(TRIM(REQUEST.QUERYSTRING("PE3")),30)
RE1 =   LEFT(TRIM(REQUEST.QUERYSTRING("RE1")),30)
RE2 =   LEFT(TRIM(REQUEST.QUERYSTRING("RE2")),30)
RE3 =   LEFT(TRIM(REQUEST.QUERYSTRING("RE3")),30)
PAI =   LEFT(TRIM(REQUEST.QUERYSTRING("PAI")),4)
REMI =  LEFT(TRIM(REQUEST.QUERYSTRING("REMI")),40)
ATE =   LEFT(TRIM(REQUEST.QUERYSTRING("ATE")),40)
CN1 =   LEFT(TRIM(REQUEST.QUERYSTRING("CN1")),25)
CN2 =   LEFT(TRIM(REQUEST.QUERYSTRING("CN2")),25)
CN3 =   LEFT(TRIM(REQUEST.QUERYSTRING("CN3")),25)
chk  =  ""
DOCR =  LEFT(TRIM(REQUEST.QUERYSTRING("DOCR")),2)
DESP =  LEFT(TRIM(REQUEST.QUERYSTRING("DESP")),3)
DOC2 =  LEFT(TRIM(REQUEST.QUERYSTRING("DOC2")),20)
ALM =   LEFT(TRIM(REQUEST.QUERYSTRING("ALM")),4)
DIS =   LEFT(TRIM(REQUEST.QUERYSTRING("DIS")),15)
PRV =   LEFT(TRIM(REQUEST.QUERYSTRING("PRV")),40)
CCTO =  LEFT(TRIM(REQUEST.QUERYSTRING("CCTO")),6)
CLA =   TRIM(REQUEST.QUERYSTRING("CLA"))
DPG =   "" '// NO HAY DOCPAG
    '// NO HAY FECPAG -- NULL
    '// NO HAY FECVEN -- NULL
EDO = ""    '// NO HAY ESTPAG
MPG = ""    '// NO HAY MONPAG
PAG = 0   '// NO HAY IMPPAG --0
GPG = ""    '// NO HAY GLOPAG

CAD = ""

' INSERT
IF TRIM(OC) = "AUTO" THEN
    '-- aca jala el ultimo numero correlativo para la OC EMITIDOOO
        RS.OPEN "Select tn_nNUMERO From RSFACCAR..FT0001NUME Where TN_CCODIGO='OC' And TN_CNUMSER='000' ", CNN
        RS.MOVEFIRST
        OC = RIGHT("0000000000" + CSTR(CDBL(RS("TN_NNUMERO")) + 1),10)
    ' ACTUALIZA EL CORRELATIVO    
        NUME = CDBL(RS("TN_NNUMERO")) + 1
        CAD = CAD + " Update RSFACCAR..FT0001NUME Set TN_NNUMERO="&NUME&" Where TN_CCODIGO='OC' And TN_CNUMSER='000'; "
    ' INSERTA LA CABECERA DE LA O/C  
        CAD = CAD + " Insert RSFACCAR..CO0001MOVC (OC_CNUMORD, OC_CSITORD, OC_CCODPRO, OC_CRAZSOC, OC_CDIRPRO,                       " & _
                    " OC_CCOTIZA, OC_DFECDOC, OC_CFORPA1, OC_CCODMON, OC_NTIPCAM, OC_DFECENT, OC_CCODSOL,                            " & _
                    " OC_CSOLICT, OC_CLUGENT, OC_CLUGFAC,OC_CDETENT, OC_CTIPENV, OC_CUSUARI, OC_CTIPORD,                             " & _
                    " OC_DFECACT, OC_CHORA, OC_NIMPUS, OC_NIMPMN, OC_CRESPER1, OC_CRESPER2, OC_CRESPER3,                             " & _       
                    " OC_CRESCARG1, OC_CRESCARG2, OC_CRESCARG3, OC_CCOPAIS, OC_CREMITE, OC_CPERATE,                                  " & _
                    " OC_CCONTA1, OC_CCONTA2, OC_CCONTA3, OC_CUNIORD, OC_CTIPDOC, OC_CTIPDSP, OC_CNUMREF,                            " & _
                    " OC_CALMDES, OC_CDISTOC, OC_CPROVOC, OC_CCOSTOC, OC_CDOCPAG, OC_DFECPAG, OC_DFECVEN,                            " & _
                    " OC_CESTPAG, OC_CMONPAG, OC_NIMPPAG, OC_CGLOPAG )  Values( '"&OC&"', '"&SIT&"',                                 " & _
                    " '"&PRO&"', '"&RAZ&"', '"&DIR&"', '"&COT&"', GETDATE(), '"&FPAG&"', '"&MON&"', '"&CAM&"',                       " & _
                    " Convert(datetime,'"&ENT&"',103), '"&KOS&"', '"&SOL&"', '"&LUG&"', '"&LFA&"', '"&OBS&"', '"&TIP&"' , '"&USR&"', " & _
                    " '"&TOC&"', GETDATE(), '"&HOR&"', 0, 0,'"&PE1&"', '"&PE2&"', '"&PE3&"', '"&RE1&"', '"&RE2&"',                   " & _
                    " '"&RE3&"', '"&PAI&"', '"&REMI&"', '"&ATE&"', '"&CN1&"', '"&CN2&"', '"&CN3&"', '"&CHK&"',                       " & _
                    " '"&DOCR&"', '"&DESP&"', '"&DOC2&"', '"&ALM&"', '"&DIS&"', '"&PRV&"', '"&CCTO&"', '', NULL,                     " & _
                    " NULL, '', '', 0, '') ;                                                                                         "
ELSE
    CAD = CAD + " Update RSFACCAR..CO0001MOVC Set OC_CCODPRO='"&PRO&"',             " & _
                " OC_CRAZSOC='"&RAZ&"',     OC_CDIRPRO='"&DIR&"',                   " & _
                " OC_CTIPDSP='"&DESP&"', OC_CNUMREF='"&DOC2&"',                     " & _
                " OC_CTIPDOC='"&DOCR&"', OC_CCOTIZA='"&COT&"',                      " & _
                " OC_DFECDOC=Convert(datetime,'"&FDO&"',103), OC_CFORPA1='"&FPAG&"'," & _
                " OC_CCODMON='"&MON&"', OC_NTIPCAM="&CAM&",                         " & _
                " OC_DFECENT=Convert(datetime,'"&ENT&"',103), OC_CCODSOL='"&KOS&"', " & _
                " OC_CSOLICT='"&SOLi&"', OC_CLUGENT='"&LUG&"',                      " & _
                " OC_CLUGFAC='"&LFA&"', OC_CDETENT='"&OBS&"',                       " & _
                " OC_CTIPENV='"&TIP&"', OC_CUSUARI='"&USR&"',                       " & _
                " OC_CTIPORD='"&TOC&"', OC_DFECACT=GETDATE(),                       " & _                          
                " OC_CHORA='"&HOR&"', OC_CRESPER1='"&PE1&"',                        " & _
                " OC_CRESPER2='"&PE2&"', OC_CRESPER3='"&PE3&"',                     " & _
                " OC_CRESCARG1='"&RE1&"', OC_CRESCARG2='"&RE2&"',                   " & _
                " OC_CRESCARG3='"&RE3&"', OC_CCOPAIS='"&PAI&"',                     " & _
                " OC_CREMITE = '"&REMI&"', OC_CPERATE='"&ATE&"',                    " & _
                " OC_CCONTA1='"&CN1&"', OC_CCONTA2='"&CN2&"',                       " & _
                " OC_CCONTA3='"&CN3&"', OC_CUNIORD='"&CHK&"',                       " & _
                " OC_NIMPUS="&dol&", OC_NIMPMN="&SOL&",                             " & _
                " OC_CALMDES='"&ALM&"', OC_CDISTOC='"&DIS&"',                       " & _
                " OC_CPROVOC='"&PRV&"', OC_CCOSTOC='"&CCTO&"',                      " & _
                " OC_CDOCPAG='"&DPG&"', OC_DFECPAG=Null,                            " & _
                " OC_DFECVEN=Null, OC_CESTPAG='',                                   " & _
                " OC_CMONPAG='', OC_NIMPPAG=0,                                      " & _
                " OC_CGLOPAG=''                                                     " & _
                " Where OC_CNUMORD='"&OC&"' ;                                       "
    cad = cad + " update RSFACCAR..CO0001MOVd Set OC_CCODPRO='"&PRO&"'              " & _
                " Where OC_CNUMORD='"&OC&"' ;                                       "
END IF

' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE("<br>")
'RESPONSE.WRITE(CAD)
'RESPONSE.END
Cnn.BeginTrans	
Cnn.Execute(CAD)
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
    ALM = '<%=request.QueryString("al2")%>'
    COD = '<%=request.QueryString("cod")%>'
    CAN = '<%=request.QueryString("CAN")%>'
    OFI = '<%=request.QueryString("OFI")%>'
    LT2 = '<%=request.QueryString("LT2")%>'
    LT1 = '<%=request.QueryString("LT1")%>'
    CLA = '<%=request.QueryString("CLA")%>'
    SER = '<%=request.QueryString("ser")%>'
    hi1 = '<%=request.QueryString("hi1")%>'
    hi2 = '<%=request.QueryString("hi2")%>'
    hi3 = '<%=request.QueryString("hi3")%>'
    hi4 = '<%=request.QueryString("hi4")%>'
    hi5 = '<%=request.QueryString("hi5")%>'
    hi6 = '<%=request.QueryString("hi6")%>'
    ki1 = '<%=request.QueryString("ki1")%>'
    ki2 = '<%=request.QueryString("ki2")%>'
    ki3 = '<%=request.QueryString("ki3")%>'
    ki4 = '<%=request.QueryString("ki4")%>'
    ki5 = '<%=request.QueryString("ki5")%>'
    ki6 = '<%=request.QueryString("ki6")%>'

    cad = '../FICHAocNEW.ASP?OC=' + '<%=OC%>'
    cad += '&des=' + ALM
    cad += '&cod=' + COD
    cad += '&CAN=' + CAN
    cad += '&ofi=' + OFI
    
    cad += '&al2=' + ALM
    cad += '&CLA=' + CLA
    cad += '&SER=' + SER
    cad += '&ki1=' + ki1
    cad += '&ki2=' + ki2
    cad += '&ki3=' + ki3
    cad += '&ki4=' + ki4
    cad += '&ki5=' + ki5
    cad += '&ki6=' + ki6
    cad += '&hi1=' + hi1
    cad += '&hi2=' + hi2
    cad += '&hi3=' + hi3
    cad += '&hi4=' + hi4
    cad += '&hi5=' + hi5
    cad += '&hi6=' + hi6
    cad += '&lt2=' + LT2
    cad += '&lt1=' + LT1
  //  document.write(cad)
   // alert(cad)
   parent.window.location.replace(cad)





    //  window.open('../FICHAOC.ASP?OC=' + '<%=OC%>')
    //parent.window.opener.window.top.parent.frames['mainFrame'].window.location.replace('../detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>');
</script>
</BODY>
</HTML>
