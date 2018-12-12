<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
    cia = "0001"
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="FUNCIONESCOMUNES.ASP"-->
<html>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

<%
alm = ucase(TRIM(Request.QueryString("alm")))
tip = ucase(TRIM(Request.QueryString("CTD")))
doc = ucase(TRIM(Request.QueryString("Doc")))
ITM = ucase(TRIM(Request.QueryString("ITM")))
UNI = ucase(TRIM(Request.QueryString("UNI")))
COL = ucase(TRIM(Request.QueryString("COL")))
LOT = ucase(TRIM(Request.QueryString("LOT")))
BUL = replace(ucase(TRIM(Request.QueryString("BUL"))),",","")
CON = replace(ucase(TRIM(Request.QueryString("CON"))),",","")
KGN = replace(ucase(TRIM(Request.QueryString("KGN"))),",","")
KGB = replace(ucase(TRIM(Request.QueryString("KGB"))),",","")
CNP = replace(ucase(TRIM(Request.QueryString("CNP"))),",","")
CNR = replace(ucase(TRIM(Request.QueryString("CNR"))),",","")
KNP = replace(ucase(TRIM(Request.QueryString("KNP"))),",","")
KBP = replace(ucase(TRIM(Request.QueryString("KBP"))),",","")
SER = ucase(TRIM(Request.QueryString("SER")))
UBI = ucase(TRIM(Request.QueryString("UBI")))
OBS = ucase(TRIM(Request.QueryString("OBS")))
TAL = ucase(TRIM(Request.QueryString("TAL")))
VBC = ucase(TRIM(Request.QueryString("VBC")))
OC  = ucase(TRIM(Request.QueryString("OC")))
ata  = ucase(TRIM(Request.QueryString("ata")))
aca  = ucase(TRIM(Request.QueryString("aca")))
glos = Request.QueryString("glos")
REF = Request.QueryString("REF")
pe1 = Request.QueryString("pe1")
pe2 = Request.QueryString("pe2")
ps1 = Request.QueryString("ps1")
aTal = Split(ata, ",") 
aCan = Split(aca, ",")
TBL1 = "multi..RS_ALMOVD" + cia
TBL2 = "multi..RS_ALMOVD_TALLA" + cia
TBL3 = "RSFACCAR..AL"+CIA+"MOVD"


if len(trim(cnr)) = 0 then cnr=0
if len(trim(ncp)) = 0 then ncp=0

' ACTUALIZA LA LINEA DE DETALLE DE MOVIMIENTO
CAD =  " UPDATE "&TBL1&" SET CRFNDOC='"&REF&"',CNUMORD='"&OC&"',UNIMED='"&UNI&"',COLOR='"&COL&"', LOTE='"&LOT&"',  " & _
       " BULTOS= '"&BUL&"', CONOS='"&CON&"',	KGBRUTO='"&KGB&"', 	KGNETO='"&KGN&"', NCANTIDPROV='"&CNP&"',       " & _
       " KGBRUTOPROV='"&KBP&"', KGNETOPROV='"&KNP&"', CODTIPOMOV='"&SER&"', CUBICACION='"&UBI&"', OBSERV='"&OBS&"'," & _
	   " DETALLADO='"&TAL&"', 	VBCC='"&VBC&"' 	WHERE CALMA='"&ALM&"' AND CTD='"&tip&"' AND CNUMDOC='"&DOC&"' AND  " & _
       " CITEM='"&ITM&"' ;                                                                                         "

' ACTUALIZA REAL POR TEMAS DE PRECIOS!!!!
CAD = CAD + " UPDATE "&TBL3&" SET  C6_NCANTID = "&cnp&", C6_NVALTOT = "&cdbl(cnr)&" * c6_npreun1,         " & _
            " C6_NUSIMPO="&cdbl(cnr)&"* c6_npreun1, C6_NMNIMPO="&cdbl(cnr)&"* c6_npreun1 * c6_ntipcam   " & _
            " where C6_CNUMDOC ='"&DOC&"' AND c6_CALMA='"&ALM&"' AND c6_CTD='"&tip&"' AND c6_CITEM='"&ITM&"' "

' SE CHIFA LAS CANTIDADES POR TALLA
CAD = CAD + " DELETE "&TBL2&" WHERE CALMA='"&ALM&"' AND CTD='"&tip&"' AND CNUMDOC='"&DOC&"' AND CITEM='"&ITM&"' ;  "
' VOLVER A CREAR LAS CANTIDADES POR Talla EN CASO HAYA MODIFICADO
if (ubound(atal) >=0 ) then
    FOR I= lbound(atal) TO ubound(aTal)
        ttt = aTal(i)
        ccc = aCan(i)
        cad = cad + "Insert into "&tbl2&" (CALMA,CTD,CNUMDOC,CITEM,TALLA,CANTIDAD,ORDEN) VALUES(    " & _
                    " '"&alm&"', '"&tip&"', '"&doc&"', '"&itm&"', '"&ttt&"', "&ccc&", '"&i&"' ) ;   "
    Next
end if
'response.write(cad)
'RESPONSE.END
  Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
   // alert(window.parent.window.opener.document.all.compra.value)
    //alert(top.window.window.opener.document.all.compra.value)
/*
    kag = 'frames/partes_deta_oc_contra.asp?doc=' + trim(window.parent.window.opener.document.all.compra.value)
    */
    //alert(window.opener.window.parent.document.all.ruc.value)

    kaa = '../detaAtencion.asp?co='+strzero(trim('<%=oc%>'),10)+'&nume=' + trim('<%=doc%>')
    kaa += '&REF=' + '<%=REF%>'
	kaa += '&pe1=' + '<%=pe1%>'
	kaa += '&pe2=' + '<%=pe2%>'
	kaa += '&ps1=' + '<%=ps1%>'
	kaa += '&glos=' + '<%=glos%>'
	kaa += '&alm=' + trim('<%=alm %>')
   // alert(top.window.opener.window.name)
	//alert(window.opener.window.name)
    window.opener.window.location.replace = kaa

   window.close()
</script>
    
</body>
</html>
