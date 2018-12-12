<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="JSON/QueryToJSON.asp"-->
<%

Response.ContentType = "application/json; charset=utf-8"
CT_CNROOFI		= trim(Request.QueryString("nroOFI"))
CT_CCODSTY		= trim(Request.QueryString("estilo"))
CT_CPRENDA		= trim(Request.QueryString("prenda"))
CT_CARTICULO		= trim(Request.QueryString("articulo"))	
CT_NTIEMPO		= trim(Request.QueryString("Tiempo"))
CT_CNROCORTE		= trim(Request.QueryString("numCorte"))
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
CT_ARTI1        	= trim(Request.QueryString("arti1"))
CT_ORPRO   		= trim(Request.QueryString("orpro"))

Dim transaccion
Dim Conn, Conn1 
Dim rs


Set transaccion = jsObject()

set rs   =  CreateObject("ADODB.Recordset")
Set Conn = CreateObject("ADODB.Connection")
set Conn1 = CreateObject("ADODB.Connection")
Conn.Open "Provider=VFPOLEDB.1;Data Source=E:\UnidadH\ACOSTO;Collating Sequence=MACHINE"
Conn1.Open "Provider=VFPOLEDB.1;Data Source=E:\UnidadH\dbmaster100;Collating Sequence=MACHINE"

CT_ARTI2 = ""
CT_ARTI3 = ""		
CT_ARTI4 = ""		
CT_ARTI5 = ""		
CT_ARTI6 = ""		
CT_ARTI7 = ""		
CT_ARTI8 = ""		
CT_ARTI9 = ""		
tota1 = 0
tota2 = 0
tota3 = 0
tota4 = 0
tota5 = 0
tota6 = 0
tota7 = 0
tota8 = 0
tota9 = 0
mca1 = 0
mca2 = 0
mca3 = 0
mca4 = 0
mca5 = 0
mca6 = 0
mca7 = 0
mca8 = 0
mca9 = 0
mpa1 = 0
mpa2 = 0
mpa3 = 0
mpa4 = 0
mpa5 = 0
mpa6 = 0
mpa7 = 0
mpa8 = 0
mpa9 = 0
cantela = 0
flg_imp_pq = ""
flg_gen_pq = ""
lugar	 = "0"
oper_log = ""
stat	= ""
cproceso = ""
fecha01	= " /  /    "	
fecha02	= " /  /    "		
fecha03	= " /  /    "		
cproveed = ""
cfecha01 = " /  /    "	
cfecha02 = " /  /    "		
ntizad	 = 0
n_panos	 = 0	
n_parti	 = 0	
linea	 = ""
ctrlflag1	= 0
ctrlflag2	= 0

'********************************************
stat	  = ""
obsv	  = ""
mat_gen	  = ""
con_pren  = 0
destino	  = ""
cscorte	  = 0
csconfe	  = 0
csacaba	  = 0
tscorte	  = 0
tsconfe	  = 0
tsacaba	  = 0
flag	  = ""

'strSelect = "Select * from tabpexpo where cpedexpo = '" & CT_ORPRO &"' "
strSelect = "Select * from TABPEXPO where cpedexpo = '" & CT_ORPRO &"' "
rs.open strSelect, Conn1,3,1,1 

if rs.recordCount>0 then
	srtsql1 =" insert into TABPEXPO (cpedexpo,dpedexpo,stat,cliente,obsv,fecha,mat_gen,style,con_pren,destino,cscorte,csconfe,csacaba,tscorte,tsconfe,tsacaba,flag) " & _
			" values('" & CT_ORPRO & "','" & CT_CPRENDA & "','" & stat & "','" & CT_CCLIENT & "','" & obsv & "',ctod('" & CT_DFECHA & "'),'" & mat_gen & "','" & CT_CCODSTY & "'," & con_pren & ", " &_ 
			" '" & destino & "'," & cscorte & "," & csconfe & "," & csacaba & "," & tscorte & "," & tsconfe & "," & tsacaba & ", '" & flag & "') "
	'response.write(srtsql1)
	'response.end
	Conn1.execute(srtsql1)
End if

'********************************************

'response.write(queryFox)
'   IF !SEEK(ALLTRIM(tmppos.do_cdescol1),"tabpexpo","cpedexpo")	&& FAC 20110414 Esto se creo para que exista ofi en dbfs, q fecha exacta no lo recuerdo
'    	SELECT tabpexpo
'       	APPEND BLANK
'       	REPLACE cpedexpo WITH ALLTRIM(tmppos.do_cdescol1)
'       	REPLACE dpedexpo WITH ALLTRIM(thisform.txtco_cprenda.value)
'       	REPLACE cliente WITH ALLTRIM(THISFORM.txtco_ccliente.VALUE)
'       	REPLACE fecha WITH (&obj.txtct_dfecha.VALUE)
'       	REPLACE style WITH ALLTRIM(thisform.txtco_ccodsty.value)
'       ENDIF

'REsponse.end
str = CT_DFECHA
strDate = cDate(str)
fecha = right("0" & month(strDate),2) & "/" & right("0" & day(strDate),2) & "/" & right("00" & year(strDate),4) 

queryFox =  " insert into caborden (nro_orden,fch_orden,cliente,tela,codtela,colora,[color],ancho,metros,kilos,orpro, " &_
" panio,tendi,arti1,arti2,arti3,arti4,arti5,arti6,arti7,arti8,arti9,tota1,tota2, " &_
" tota3,tota4,tota5,tota6,tota7,tota8,tota9,mca1,mca2,mca3,mca4,mca5,mca6,mca7,mca8," &_
" mca9,mpa1,mpa2,mpa3,mpa4,mpa5,mpa6,mpa7,mpa8,mpa9,cantela,flg_imp_pq,flg_gen_pq,ropa, " &_
" lugar,oper_log,part_tinto,[stat],cproceso,proveedor,fecha01,fecha02,fecha03, "  &_
" cproveed,cfecha01,cfecha02,n_sobra,n_tapet,n_tizad,n_punta,n_retaz,n_falla, " &_
" n_pepan,n_prpan,n_panos,n_parti,coprend,codser,conreal,linea,ctrlflag1,ctrlflag2) " &_
" values('" & CT_CNROCORTE & "',ctod('" & fecha & "'),'" &CT_CCLIENTE & "','" & left(CT_CDESTEL,40) & "','" & CT_CCODTEL & "','" & CT_CCODCOL & "','" & CT_CDESCOL & "'," & CT_NANCHO & "," & CT_NMETROS & ", " &_
" " & CT_NKILOS & ",'" & CT_ORPRO & "'," & CT_NPEPAN & "," & CT_NLARGO & ",'" & CT_ARTI1 & "','" & CT_ARTI2 & "','" & CT_ARTI3 & "','" & CT_ARTI4 & "','" & CT_ARTI5 & "','" & CT_ARTI6 & "','" & CT_ARTI7 & "','" & CT_ARTI8 & "','" & CT_ARTI9 & "', " &_
" " & tota1 & "," & tota2 & ", " & tota3 & ", " & tota4 & "," & tota5 & "," & tota6 & "," & tota7 & "," & tota8 & "," & tota9 & "," & mca1 & "," & mca2 & "," & mca3 & "," & mca4 & "," & mca5 & "," & mca6 & "," & mca7 & "," & mca8 & "," & mca9 & ", " &_
" " & mpa1 & "," & mpa2 & "," & mpa3 & "," & mpa4 & "," & mpa5 & "," & mpa6 & "," & mpa7 & "," & mpa8 & "," & mpa9 & "," & cantela & ",'" & flg_imp_pq	& "' , '" & flg_gen_pq & "'," & CT_TIPOPREN & ", " & lugar & ", '" & oper_log & "', " &_
" '" & CT_CPARTIDA & "','" & stat & "', '" & cproceso & "','" & CT_CDESSER & "',ctod('" & fecha01 & "'), ctod('" & fecha02 & "'),ctod('" & fecha03 & "'),'" & cproveed & "' " &_
" ,ctod('" & cfecha01 & "'), ctod('" & cfecha02 & "')," & CT_NSOBRA & "," & CT_NTAPETA & ", " & ntizad & "," & CT_NPUNTA & "," & CT_NRETAZOS & "," & CT_NFALLAS & "," & CT_NPZPAN & "," & CT_NNRPAN & "," & n_panos & ", " &_
" " & n_parti & "," & CT_NCONEST & "," & CT_NCODSER & "," & CT_NCONREA & ",'" & linea	& "'," & ctrlflag1 & "," & ctrlflag2 & ") " 

'response.write(queryFox)
'response.end

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
transaccion("tabs")   = CT_TABS
transaccion("nrocorte") = CT_CNROCORTE
set Conn  = nothing
set Conn1 = nothing
set rs    = nothing
Response.Write toJSON(transaccion)
%>