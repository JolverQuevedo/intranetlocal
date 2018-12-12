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
Dim transaccion
Set transaccion = jsObject()

queryDet = "sp_Graba_Corte_Det '"& CT_CNROOFI &"', '"& CD_CNROCORTE &"', "& CD_CSECUEN &", '"& CD_CARTICULO &"','"& CD_CTALLA &"','"& CD_CCODCOL &"','"& CD_CCOLOR &"', "& CD_NCANT &", "& CD_NINI &", "& CD_NFIN &", "& CD_NORDEN &" " 
Cnn.begintrans
	Cnn.execute(queryDet)	
if Cnn.Errors.Count>0 then 
		Cnn.RollbackTrans
		Cnn.close
		Set Cnn=nothing
		transaccion("status") = "0"		
	else
		Cnn.CommitTrans
		transaccion("status") = "1"
	end if
	

transaccion("tabs")   = CD_TABS
transaccion("item")   = CD_ITEM
Response.Write toJSON(transaccion)	
%>