<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CAM =   trim(REQUEST.QUERYSTRING("CAM"))
response.write(CAM)
response.Write("<br>")
response.write("cam")
response.Write("<br>")
OC =    TRIM(REQUEST.QUERYSTRING("OC"))
SIT =   LEFT(TRIM(REQUEST.QUERYSTRING("sit")),1)
PRO =   TRIM(REQUEST.QUERYSTRING("pro"))
RAZ =   LEFT(TRIM(REQUEST.QUERYSTRING("raz")),80)
DIR =   LEFT(TRIM(REQUEST.QUERYSTRING("dir")),80)
COT =   LEFT(TRIM(REQUEST.QUERYSTRING("COT")),30)
FDO =   TRIM(REQUEST.QUERYSTRING("FEDO"))
FPAG =  LEFT(TRIM(REQUEST.QUERYSTRING("FPAG")),30)
MON =   LEFT(TRIM(REQUEST.QUERYSTRING("MON")),2)

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
CHK =   LEFT(TRIM(REQUEST.QUERYSTRING("CHK")),1)
DOCR =  LEFT(TRIM(REQUEST.QUERYSTRING("DOCR")),2)
DESP =  LEFT(TRIM(REQUEST.QUERYSTRING("DESP")),3)
DOC2 =  LEFT(TRIM(REQUEST.QUERYSTRING("DOC2")),20)
ALM =   LEFT(TRIM(REQUEST.QUERYSTRING("ALM")),4)
DIS =   LEFT(TRIM(REQUEST.QUERYSTRING("DIS")),15)
PRV =   LEFT(TRIM(REQUEST.QUERYSTRING("PRV")),40)
CCTO =  LEFT(TRIM(REQUEST.QUERYSTRING("CCTO")),6)
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
        CAD = CAD + " Insert RSFACCAR..CO0001MOVC (OC_CNUMORD, OC_CSITORD, OC_CCODPRO, OC_CRAZSOC, OC_CDIRPRO,      " & _
                    " OC_CCOTIZA, OC_DFECDOC, OC_CFORPA1, OC_CCODMON, OC_NTIPCAM, OC_DFECENT, OC_CCODSOL,           " & _
                    " OC_CSOLICT, OC_CLUGENT, OC_CLUGFAC,OC_CDETENT, OC_CTIPENV, OC_CUSUARI, OC_CTIPORD,            " & _
                    " OC_DFECACT, OC_CHORA, OC_NIMPUS, OC_NIMPMN, OC_CRESPER1, OC_CRESPER2, OC_CRESPER3,            " & _       
                    " OC_CRESCARG1, OC_CRESCARG2, OC_CRESCARG3, OC_CCOPAIS, OC_CREMITE, OC_CPERATE,                 " & _
                    " OC_CCONTA1, OC_CCONTA2, OC_CCONTA3, OC_CUNIORD, OC_CTIPDOC, OC_CTIPDSP, OC_CNUMREF,           " & _
                    " OC_CALMDES, OC_CDISTOC, OC_CPROVOC, OC_CCOSTOC, OC_CDOCPAG, OC_DFECPAG, OC_DFECVEN,           " & _
                    " OC_CESTPAG, OC_CMONPAG, OC_NIMPPAG, OC_CGLOPAG )  Values( '"&OC&"', '"&SIT&"',                " & _
                    " '"&PRO&"', '"&RAZ&"', '"&DIR&"', '"&COT&"', GETDATE(), '"&FPAG&"', '"&MON&"', '"&CAM&"',      " & _
                    " Convert(datetime,'"&ENT&"',103), '"&KOS&"', '"&SOL&"', '"&LUG&"', '"&LFA&"', '"&OBS&"', '"&TIP&"' , '"&USR&"',      " & _
                    " '"&TOC&"', GETDATE(), '"&HOR&"', 0, 0,'"&PE1&"', '"&PE2&"', '"&PE3&"', '"&RE1&"', '"&RE2&"',  " & _
                    " '"&RE3&"', '"&PAI&"', '"&REMI&"', '"&ATE&"', '"&CN1&"', '"&CN2&"', '"&CN3&"', '"&CHK&"',      " & _
                    " '"&DOCR&"', '"&DESP&"', '"&DOC2&"', '"&ALM&"', '"&DIS&"', '"&PRV&"', '"&CCTO&"', '', NULL,    " & _
                    " NULL, '', '', 0, '') ;                                                                "
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
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
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
    parent.window.location.replace('../FICHAOC.ASP?OC=' + '<%=OC%>')




    //  window.open('../FICHAOC.ASP?OC=' + '<%=OC%>')
    //parent.window.opener.window.top.parent.frames['mainFrame'].window.location.replace('../detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>');
</script>
</BODY>
</HTML>
