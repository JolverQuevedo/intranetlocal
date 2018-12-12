<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
CT_CNROOFI		= trim(Request.QueryString("nroOFI"))
CT_CCODSTY		= trim(Request.QueryString("estilo"))
CT_CPRENDA		= trim(Request.QueryString("prenda"))
CT_CARTICULO	= trim(Request.QueryString("articulo"))	
CT_NTIEMPO		= trim(Request.QueryString("Tiempo"))
CT_CNROCORTE	= trim(Request.QueryString("numCorte"))
CT_DFECHA		= trim(Request.QueryString("fecha"))
CT_CCLIENTE		= trim(Request.QueryString("cliente"))
CT_CPO			= trim(Request.QueryString("CPO"))
CT_NCONEST		= trim(Request.QueryString("costoEst"))
CT_NCONREA		= trim(Request.QueryString("costoReal"))
CT_CCODCOL		= trim(Request.QueryString("codColor"))
CT_CDESCOL		= trim(Request.QueryString("desColor"))
CT_NKILOS		= trim(Request.QueryString("kilos"))
CT_NSOBRA		= trim(Request.QueryString("sobra"))
CT_NTAPETA		= trim(Request.QueryString("tapeta"))
CT_NANCHO		= trim(Request.QueryString("ancho"))
CT_NLARGO		= trim(Request.QueryString("largo"))
CT_NMETROS		= trim(Request.QueryString("metro"))
CT_NPUNTA		= trim(Request.QueryString("punta"))
CT_NRETAZOS		= trim(Request.QueryString("retazo"))
CT_NFALLAS		= trim(Request.QueryString("falla"))
CT_NPEPAN		= trim(Request.QueryString("pepan"))
CT_NPZPAN		= trim(Request.QueryString("pazpano"))
CT_NNRPAN		= trim(Request.QueryString("nropano"))
CT_CPARTIDA		= trim(Request.QueryString("partida"))	
CT_CCODTEL		= trim(Request.QueryString("codTela"))
CT_CDESTEL		= trim(Request.QueryString("tela"))
CT_NPQTE		= trim(Request.QueryString("nropaquete"))
CT_NCODSER		= trim(Request.QueryString("codservicio"))
CT_CDESSER		= trim(Request.QueryString("servicio"))
CT_TABS			= trim(Request.QueryString("tabs"))
CT_TIPOPREN		= trim(Request.QueryString("tpoPrenda"))
CT_ARTI1        = trim(Request.QueryString("arti1"))
CT_ORPRO   		= trim(Request.QueryString("orpro"))

Dim Corte
Dim x,y
x = 0
y = 0
Corte = Array (0)
DatosCorte = Array (0)

if isnull(SESSION("Corte")) then
	'response.write("es nulo")
	'Redim preserve Corte (x)
	Corte (0) = CT_CNROOFI+"|"+CT_CCODSTY+"|"+CT_CPRENDA+"|"+CT_CARTICULO+"|"+CT_NTIEMPO+"|"+CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CCLIENTE+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_CCODCOL+"|"+CT_CDESCOL+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_CDESTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER+"|"+CT_TIPOPREN+"|"+CT_ARTI1+"|"+CT_ORPRO
	
else
	'response.write("no es nulo")
	Corte = SESSION("Corte")
	y = ubound(corte,1)+1
	
	Redim preserve Corte (y)
	aValor = CT_CNROOFI+"|"+CT_CCODSTY+"|"+CT_CPRENDA+"|"+CT_CARTICULO+"|"+CT_NTIEMPO+"|"+CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CCLIENTE+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_CCODCOL+"|"+CT_CDESCOL+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_CDESTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER+"|"+CT_TIPOPREN+"|"+CT_ARTI1+"|"+CT_ORPRO
	existe = false
	for i=0 to ubound(Corte)
		if Corte(i)=aValor then
			existe = true
		End	if	
	next
	if existe = false then
		Corte (y) = CT_CNROOFI+"|"+CT_CCODSTY+"|"+CT_CPRENDA+"|"+CT_CARTICULO+"|"+CT_NTIEMPO+"|"+CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CCLIENTE+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_CCODCOL+"|"+CT_CDESCOL+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_CDESTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER+"|"+CT_TIPOPREN+"|"+CT_ARTI1+"|"+CT_ORPRO
	End if		
end if

SESSION ("Corte") = Corte



'response.write( "Totla" + cstr(ubound(SESSION ("Corte"))))
'response.write(DatosCorte(1))
'DatosCorte = SESSION ("Corte")
'for i=0 to ubound(DatosCorte)
'	Response.write(Cstr(i)+":-"+DatosCorte(i))
'next
Dim transaccion
Set transaccion = jsObject()

if ubound(SESSION ("Corte"))>=0 then
	transaccion("number") = "1"
	transaccion("status") = "1"
else
	transaccion("number") = "0"
	transaccion("status") = "0"
End if
transaccion("tabs")   = CT_TABS
transaccion("nrocorte") = CT_CNROCORTE
Response.Write toJSON(transaccion)	
%>