<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script language="jscript" type="text/jscript">


</script>
</head>
<% fec =  "{ fn NOW() }"
ofi = REQUEST.querystring("ofi")
etc = REQUEST.querystring("etc")
KAD = "SELECT MERMAHILO, MERMACRUD FROM TB_CTRL"
RESPONSE.WRITE(KAD)
RESPONSE.WRITE("<BR>")

RS.OPEN KAD, CNN
RS.MOVEFIRST
MHILO= 1+ (RS("MERMAHILO")/100)
MCRUDO = 1+(RS("MERMACRUD")/100)
RS.CLOSE
Cnn.BeginTrans	
CAD = ""

RESPONSE.WRITE(MHILO)
RESPONSE.WRITE("<BR>")
RESPONSE.WRITE(MCRUDO)
RESPONSE.WRITE("<BR>")
'***************************************
' POR UPDATE O INSERT, SE HACE LO MISMO
' PRIMERO SE ELIMINAN LOS REGISTROS Y
' LUEGO SE VUELVEN A CREAR...
'***************************************
CAD = CAD + "delete [explosion_tela] where ofi= '"&ofi&"'; "
    FOR I = 1 TO request.querystring("maxi")
        po  = TRIM(Request.Form("po"&I))
        ubi = TRIM(Request.Form("ubi"&I))
        idd = TRIM(Request.Form("idd"&I))
        com = TRIM(Request.Form("comb"&I))
        cru = TRIM(Request.Form("tel"&I))
        qty = replace(TRIM(Request.Form("qty"&I)),",","")
        kgs = replace(TRIM(Request.Form("kgs"&I)),",","")
        col = TRIM(Request.Form("col"&I))
        tel = TRIM(Request.Form("art"&I))
        ah1  = TRIM(Request.Form("h1"&I))
        ap1  = TRIM(Request.Form("p1"&I))
        ak1  = replace(TRIM(Request.Form("k1"&I)), ",","")
        AK1  = AK1 * MCRUDO * MHILO
        ah2  = TRIM(Request.Form("h2"&I))
        ap2  = TRIM(Request.Form("p2"&I))
        ak2  = replace(TRIM(Request.Form("k2"&I)), ",","")
        AK2  = AK2 * MCRUDO * MHILO
        ah3  = TRIM(Request.Form("h3"&I))
        ap3  = TRIM(Request.Form("p3"&I))
        ak3  = replace(TRIM(Request.Form("k3"&I)), ",","")
        AK3  = AK3 * MCRUDO * MHILO
        ah4  = TRIM(Request.Form("h4"&I))
        ap4  = TRIM(Request.Form("p4"&I))
        ak4  = replace(TRIM(Request.Form("k4"&I)), ",","")
        AK4  = AK4 * MCRUDO * MHILO
        ah5  = TRIM(Request.Form("h5"&I))
        ap5  = TRIM(Request.Form("p5"&I))
        ak5  = replace(TRIM(Request.Form("k5"&I)), ",","")
        AK5  = AK5 * MCRUDO * MHILO
        ah6  = TRIM(Request.Form("h6"&I))
        ap6  = TRIM(Request.Form("p6"&I))
        ak6  = replace(TRIM(Request.Form("k6"&I)), ",","")
        AK6  = AK6 * MCRUDO * MHILO
        TEJ  = kgs* MCRUDO
        CAD = CAD +  " INSERT INTO [explosion_tela] (OFI, PO, UBI, ID, COMBO, ETC, CRUDO, QTY,              " & _		
                     " KGS, COLPZA, TELA, H1, P1, K1, H2, P2, K2, H3, P3, K3, H4, P4, K4, H5,               " & _
                     " P5, K5, H6, P6, K6, USUARIO, FECHA,  ESTADO, KGSTEJE) VALUES ('"&ofi&"', '"&po&"',   " & _
                     " '"&ubi&"', '"&idd&"', '"&com&"', '"&etc&"', '"&cru&"', "&qty&",                      " & _
                     " "&kgs&", '"&col&"', '"&tel&"', '"&ah1&"', "&ap1&", "&ak1&", '"&ah2&"',               " & _
                     " "&ap2&", "&ak2&", '"&ah3&"', "&ap3&", "&ak3&", '"&ah4&"', "&ap4&",                   " & _
                     " "&ak4&", '"&ah5&"', "&ap5&", "&ak5&", '"&ah6&"', "&ap6&", "&ak6&",                   " & _
                     " '"&txtUsuario&"', getdate(), 'A', "&TEJ&") ;                                         " 
        
     
    NEXT
    cad = cad + " update ofis set EXP_TEL = '*' WHERE CODIGO = '"&OFI&"' ; "
 ' RESPONSE.WRITE(CAD)
'RESPONSE.End
Cnn.EXECUTE CAD
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

' YA SE GRABARON LOS DATOS AL 100%
' REVISAMOS SI HAY ALGUNA TELA QUE NO TERMINE EN 00 (O SEA SE TEJE CON HILO COLOR)
' Y APLICAMOS LAS MERMAS

Cnn.Close	

%>
<script language="jscript" type="text/jscript">
    window.location.replace("../explosiontelas.asp?ofi=" + '<%=ofi%>')  
</script>

<body>

</body>
</html>
