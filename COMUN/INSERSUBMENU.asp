<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
OPC = CINT(Request.QueryString("opc"))
Response.Write(Request.QueryString)
if OPC = 1 then
	pro = Request.QueryString("pro")
	des = (Request.QueryString("des"))
	edo = (Request.QueryString("edo"))
	MEN = Request.QueryString("MENU")

	cad =	" select top 1 SUBMENU				" & _
			" from SUBMENU						" & _
			" WHERE MENU = '"&MEN&"'			" & _
			" order by CONVERT(INT,SUBMENU) desc"
	rs.open cad,cnn
	if rs.recordcount > 0 then cod = cint(rs("SUBMENU")) + 1 ELSE COD = "1"

	CAD = cad +	" insert into SUBMENU  " & _
				" (MENU, SUBMENU, DESCRIPCION, PROGRAMA, ESTADO) " & _
				" values('"&MEN&"','"&COD&"', '" & DES & "', '" & PRO & "', '"&EDO&"')  " 
else
	MENU = Request.QueryString("MENU")
	SUBM = (Request.QueryString("submenu"))
	COLU = (Request.QueryString("COLUMNA"))
	DATO = (Request.QueryString("DATO"))
	FECHA ="{ fn NOW() }"
	'	busca si encuentra un código duplicado
			CAD =	" UPDATE  SUBMENU			" & _
					" set "&COLU&" = '"&DATO&"'	" & _
					" WHERE MENU = '"&MENU&"'	" & _
					" AND SUBMENU= '"&SUBM&"';	"
end if
Response.Write (CAD)
'Response.end'
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
%>
<script>
pos = '<%=Request.QueryString("MENU")%>'
top.window.frames(0).location.href='../submenudeta.asp?pos='+pos
</script>
</BODY>
</HTML>
