<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"

CD_CNROCORTE 	= trim(Request.QueryString("CD_CNROCORTE"))
CD_CSECUEN 		= trim(Request.QueryString("CD_CSECUEN"))
CD_CARTICULO    = trim(Request.QueryString("CD_CARTICULO"))
CD_CTALLA 		= trim(Request.QueryString("CD_CTALLA"))
CD_ORIGEN		= trim(Request.QueryString("CD_ORIGEN"))
CD_NCANT		= trim(Request.QueryString("CD_NCANT"))
CD_GRUPO		= trim(Request.QueryString("CD_GRUPO"))
CD_NINI			= trim(Request.QueryString("CD_NINI"))
CD_NFIN			= trim(Request.QueryString("CD_NFIN"))
CD_ITEM			= trim(Request.QueryString("item"))
									
Dim Corte
Dim x,y
x = 0
y = 0
Corte = Array (0)
DatosCorte = Array (0)

if isnull(SESSION("ManCorteDet")) then
	Corte (0) = CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_ORIGEN+"|"+CD_NCANT+"|"+CD_GRUPO+"|"+CD_NINI+"|"+CD_NFIN
else
	Corte = SESSION("ManCorteDet")
	y = ubound(corte,1)+1

	Redim preserve Corte (y)
	aValor = CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_ORIGEN+"|"+CD_NCANT+"|"+CD_GRUPO+"|"+CD_NINI+"|"+CD_NFIN	
	existe = false
	for i=0 to ubound(Corte)
		if Corte(i)=aValor then
			existe = true
		End	if	
	next
	
	if existe = false then
		Corte (y) = CD_CNROCORTE+"|"+CD_CSECUEN+"|"+CD_CARTICULO+"|"+CD_CTALLA+"|"+CD_ORIGEN+"|"+CD_NCANT+"|"+CD_GRUPO+"|"+CD_NINI+"|"+CD_NFIN	
	End if
	
end if

SESSION ("ManCorteDet") = Corte
Dim transaccion
Set transaccion = jsObject()
'DatosCorte = SESSION ("ManCorteDet")
'for i=0 to ubound(DatosCorte)
'	Response.write(Cstr(i)+":-"+DatosCorte(i))
'next
if ubound(SESSION ("ManCorteDet"))>=0 then
	transaccion("number") = "1"
	transaccion("status") = "1"
else
	transaccion("number") = "0"
	transaccion("status") = "0"
End if
transaccion("item")   = CD_ITEM
Response.Write toJSON(transaccion)	
%>