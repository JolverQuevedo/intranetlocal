<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
CT_CNROCORTE	= trim(Request.QueryString("numCorte"))
CT_DFECHA		= trim(Request.QueryString("fecha"))
CT_CPO			= trim(Request.QueryString("CPO"))
CT_NCONEST		= trim(Request.QueryString("costoEst"))
CT_NCONREA		= trim(Request.QueryString("costoReal"))
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
CT_NPQTE		= trim(Request.QueryString("nropaquete"))
CT_NCODSER		= trim(Request.QueryString("codservicio"))
CT_CDESSER		= trim(Request.QueryString("servicio"))

Dim Corte
Dim x,y
x = 0
y = 0
Corte = Array (0)
DatosCorte = Array (0)

if isnull(SESSION("ManCorte")) then
	Corte (0) = CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER
else
	Corte = SESSION("ManCorte")
	y = ubound(corte,1)+1
	
	Redim preserve Corte (y)
	aValor = CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER
	existe = false
	for i=0 to ubound(Corte)
		if Corte(i)=aValor then
			existe = true
		End	if	
	next
	if existe = false then
		Corte (y) = CT_CNROCORTE+"|"+CT_DFECHA+"|"+CT_CPO+"|"+CT_NCONEST+"|"+CT_NCONREA+"|"+CT_NKILOS+"|"+CT_NSOBRA+"|"+CT_NTAPETA+"|"+CT_NANCHO+"|"+CT_NLARGO+"|"+CT_NMETROS+"|"+CT_NPUNTA+"|"+CT_NRETAZOS+"|"+CT_NFALLAS+"|"+CT_NPEPAN+"|"+CT_NPZPAN+"|"+CT_NNRPAN+"|"+CT_CPARTIDA+"|"+CT_CCODTEL+"|"+CT_NPQTE+"|"+CT_NCODSER+"|"+CT_CDESSER
	End if		
end if

SESSION ("ManCorte") = Corte

'response.write( "Totla" + cstr(ubound(SESSION ("Corte"))))
'response.write(DatosCorte(1))
'DatosCorte = SESSION ("ManCorte")
'for i=0 to ubound(DatosCorte)
'	Response.write(Cstr(i)+":-"+DatosCorte(i))
'next
Dim transaccion
Set transaccion = jsObject()

if ubound(SESSION ("ManCorte"))>=0 then
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