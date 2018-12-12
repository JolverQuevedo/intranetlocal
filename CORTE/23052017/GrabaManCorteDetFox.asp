<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="JSON/QueryToJSON.asp"-->
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
CD_ROPA			= trim(Request.QueryString("ropa"))
CD_NROPQT		= trim(Request.QueryString("paqt"))

Dim transaccion
Dim Conn 


Set transaccion = jsObject()

Set Conn = CreateObject("ADODB.Connection")
Conn.Open "Provider=VFPOLEDB.1;Data Source=E:\UnidadH\ACOSTO;Collating Sequence=MACHINE"


queryFoxDet1 = " update pla_paqt00 set  artic_dsc='',  can_pqte = "& CD_NCANT &", num_ini = "& CD_NINI &", num_fin = "& CD_NFIN &"  " &_
				" where nro_pqte = '" & CD_CNROOFI &"' and talla = '"& CD_CTALLA  &"' and articulo = '"& CD_CARTICULO &"' "

'response.write(queryFoxDet1)


						
queryFoxDet2 = " update LinOrden00 set  cantidad = " & CD_NCANT & ",  nro_paqts = " & CD_NROPQT & ", desde = " & CD_NINI & ",hasta = " & CD_NFIN & "  " &_
	  " where nro_orden = '" & CD_CNROCORTE & "' and articulo='" & CD_CARTICULO & "' and talla = '" & CD_CTALLA   & "'  "

'response.write(queryFoxDet2)
	   
Conn.begintrans
Conn.Execute(queryFoxDet1)
Conn.Execute(queryFoxDet2)
if Conn.Errors.Count>0 then 
	Conn.RollbackTrans
	Conn.close
	Set Conn=nothing
	transaccion("status") = "0"		
else
	Conn.CommitTrans
	transaccion("status") = "1"
end if

transaccion("tabs")   = CD_TABS
transaccion("item")   = CD_ITEM	
set Conn = nothing
Response.Write toJSON(transaccion)	
%>