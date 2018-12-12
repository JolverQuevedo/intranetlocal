<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"

CD_CNROOFI 		= trim(Request.QueryString("CD_CNROOFI"))
CD_CNROCORTE 	= trim(Request.QueryString("CD_CNROCORTE"))
CD_CSECUEN 		= trim(Request.QueryString("CD_CSECUEN"))
CD_CARTICULO    = trim(Request.QueryString("CD_CARTICULO"))
CD_CTALLA 		= trim(Request.QueryString("CD_CTALLA"))
CD_CCODCOL 		= trim(Request.QueryString("CD_CCODCOL"))
CD_CCOLOR 		= trim(Request.QueryString("CD_CCOLOR"))
CD_NCANT		= trim(Request.QueryString("CD_NCANT"))
CD_NINI			= trim(Request.QueryString("CD_NINI"))
CD_NFIN			= trim(Request.QueryString("CD_NFIN"))
CD_NORDEN		= trim(Request.QueryString("CD_NORDEN"))
CD_TABS			= trim(Request.QueryString("tabs"))
CD_ITEM			= trim(Request.QueryString("item"))

Dim Corte
Dim x,y
x = 0
y = 0
Corte = Array (0)
DatosCorte = Array (0)

if isnull(SESSION("CorteDet")) then
	''Redim preserve Corte (x)
	Corte (0) = CT_CNROOFI+"|"+CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_CCODCOL+"|"+CD_CCOLOR+"|"+CD_NCANT+"|"+CD_NINI+"|"+CD_NFIN+"|"+CD_NORDEN
	
else
	Corte = SESSION("CorteDet")
	y = ubound(corte,1)+1
	
	Redim preserve Corte (y)
	aValor = CT_CNROOFI+"|"+CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_CCODCOL+"|"+CD_CCOLOR+"|"+CD_NCANT+"|"+CD_NINI+"|"+CD_NFIN+"|"+CD_NORDEN
	existe = false
	for i=0 to ubound(Corte)
		if Corte(i)=aValor then
			existe = true
		End	if	
	next
	
	if existe = false then
		Corte (y) = CT_CNROOFI+"|"+CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_CCODCOL+"|"+CD_CCOLOR+"|"+CD_NCANT+"|"+CD_NINI+"|"+CD_NFIN+"|"+CD_NORDEN
	End if
	
end if

SESSION ("CorteDet") = Corte
Dim transaccion
Set transaccion = jsObject()
'DatosCorte = SESSION ("CorteDet")
'response.write("Total ")
'response.write(ubound(DatosCorte))
'for i=0 to ubound(DatosCorte)
'	Response.write(Cstr(i)+":-"+DatosCorte(i))
'next
if ubound(SESSION ("Corte"))>=0 then
	transaccion("number") = "1"
	transaccion("status") = "1"
else
	transaccion("number") = "0"
	transaccion("status") = "0"
End if
'transaccion("number") = "0"
'transaccion("status") = "0"
transaccion("tabs")   = CD_TABS
transaccion("item")   = CD_ITEM
Response.Write toJSON(transaccion)	
%>