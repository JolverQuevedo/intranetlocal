<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="JSON/QueryToJSON.asp"-->
<%

Response.ContentType = "application/json; charset=utf-8"

CD_CNROOFI 		= trim(Request.QueryString("CD_CNROOFI"))
CD_CNROCORTE 	= trim(Request.QueryString("CD_CNROCORTE"))
CD_FECPQTE	= "  /  /    "
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
CD_ESTADO		= ""
CD_ROPA			= trim(Request.QueryString("ropa"))
CD_NROPQT		= trim(Request.QueryString("paqt"))

Dim transaccion
Dim Conn 


Set transaccion = jsObject()

Set Conn = CreateObject("ADODB.Connection")
Conn.Open "Provider=VFPOLEDB.1;Data Source=E:\UnidadH\ACOSTO;Collating Sequence=MACHINE"


queryFoxDet1 = " insert into pla_paqt00 (nro_pqte, fec_pqte, articulo, artic_dsc, talla, color, can_pqte, num_ini, num_fin,estado, ropa ) " &_ 
		          "values('"& CD_CNROOFI &"',ctod('" & CD_FECPQTE & "'),'"& CD_CARTICULO &"','AA','"& CD_CTALLA  &"','"& CD_CCOLOR &"',"& CD_NCANT &","& CD_NINI &","& CD_NFIN &",'" & CD_ESTADO & "'," & CD_ROPA & " )  "
'response.write(queryFoxDet1)


						
queryFoxDet2 = " insert into LinOrden00 (nro_orden, articulo, talla, tala1, color, cantidad, nro_arti, nro_paqts, desde,hasta, ropa) " &_
	  " values('" & CD_CNROCORTE & "','" & CD_CARTICULO & "','" & CD_CTALLA   & "','" & CD_CTALLA & "','" & CD_CCOLOR & "'," & CD_NCANT & ",0, " & CD_NROPQT & "," & CD_NINI & "," & CD_NFIN & "," & CD_ROPA & ") "

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