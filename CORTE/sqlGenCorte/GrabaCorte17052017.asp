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
Dim transaccion
Set transaccion = jsObject()
	

	queryCab ="sp_Graba_Corte_Cab '" & CT_CNROOFI & "', '" & CT_CCODSTY & "', '" & CT_CPRENDA & "', '" & CT_CARTICULO & "', " & CT_NTIEMPO & ", '" & CT_CNROCORTE & "', '" & CT_DFECHA & "', '" & CT_CCLIENTE & "', '" & CT_CPO & "', " & CT_NCONEST & ", " & CT_NCONREA & ",'" & CT_CCODCOL & "', '" & CT_CDESCOL & "', " & CT_NKILOS & ", " & CT_NSOBRA & ", " & CT_NTAPETA & ", " & CT_NANCHO & ", " & CT_NLARGO & ", " & CT_NMETROS & ", " & CT_NPUNTA & ", " & CT_NRETAZOS & ", " & CT_NFALLAS & ", " & CT_NPEPAN & ", " & CT_NPZPAN & ", " & CT_NNRPAN & ", '" & CT_CPARTIDA & "', '" & CT_CCODTEL & "'  , '" & CT_CDESTEL & "', " & CT_NPQTE & ", " & CT_NCODSER & ", '" & CT_CDESSER & "', " & CT_TIPOPREN & " "

'response.write(queryCab)
Cnn.begintrans
Cnn.execute(queryCab)
if Cnn.Errors.Count>0 then 
		Cnn.RollbackTrans
		Cnn.close
		Set Cnn=nothing
		transaccion("status") = "0"		
	else
		Cnn.CommitTrans
		transaccion("status") = "1"
	end if

transaccion("tabs")   = CT_TABS
transaccion("nrocorte") = CT_CNROCORTE
Response.Write toJSON(transaccion)	
%>