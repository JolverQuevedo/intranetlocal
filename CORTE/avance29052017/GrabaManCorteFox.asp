<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"


numCorte = Request.QueryString("numCorte")
fecha	 = Request.QueryString("fecha")
CPO		 = Request.QueryString("CPO")
costoEst = Request.QueryString("costoEst")
costoReal= Request.QueryString("costoReal")
kilos	 = Request.QueryString("kilos")
sobra	 = Request.QueryString("sobra")
tapeta	 = Request.QueryString("tapeta")
ancho	 = Request.QueryString("ancho")
largo	 = Request.QueryString("largo")
metro	 = Request.QueryString("metro")
punta	 = Request.QueryString("punta")
retazo	 = Request.QueryString("retazo")
falla	 = Request.QueryString("falla")
pepan	 = Request.QueryString("pepan")
pazpano  = Request.QueryString("pazpano")
nropano  = Request.QueryString("nropano")
partida  = Request.QueryString("partida")
codTela  = Request.QueryString("codTela")
nropaquete = Request.QueryString("nropaquete")
codservicio= Request.QueryString("codservicio")
servicio   = Request.QueryString("servicio")

Dim transaccion
Dim Conn 

Set transaccion = jsObject()

Set Conn = CreateObject("ADODB.Connection")
Conn.Open "Provider=VFPOLEDB.1;Data Source=E:\UnidadH\ACOSTO;Collating Sequence=MACHINE"

queryFox =  " update caborden  set fch_orden = ctod('" & fecha & "'), ancho = " & ancho & ", metros = " & metro & ",kilos = " & kilos & ", " &_
" panio = " & pepan & ", tendi = " & largo & ", " &_
" n_sobra = " & sobra & ",n_tapet = " & tapeta & ", n_punta = " & punta & ",n_retaz = " & retazo &",n_falla = " & falla &", " &_
" n_pepan = " & pazpano & ",n_parti = " & partida &", codser = " & codservicio &",coprend =" & costoEst & " ,conreal = " & costoReal & ", part_tinto = '" & nropaquete & "' " &_
" where nro_orden = '" & numCorte & "'" 

'response.write(queryFox)

Conn.begintrans
Conn.Execute(queryFox)
if Conn.Errors.Count>0 then 
		Conn.RollbackTrans
		Conn.close
		Set Conn =nothing
		transaccion("status") = "0"		
	else
		Conn.CommitTrans
		transaccion("status") = "1"
	end if
transaccion("tabs")   = 1
transaccion("nrocorte") = numCorte
set Conn = nothing
Response.Write toJSON(transaccion)
%>