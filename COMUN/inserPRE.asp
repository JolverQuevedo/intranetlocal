<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

CHK = Request.QueryString("chk")
COD = TRIM(Request.QueryString("pos"))
DES = ucase(TRIM(Request.QueryString("DES")))
UNI = TRIM(Request.QueryString("UNI"))
PRO = TRIM(Request.QueryString("PRO"))
VER = TRIM(Request.QueryString("VER"))
TIP = TRIM(Request.QueryString("TIP"))
GRU = TRIM(Request.QueryString("GRU"))
CLI = TRIM(Request.QueryString("CLI"))
TAL = TRIM(Request.QueryString("TAL"))
MON = TRIM(Request.QueryString("MON"))
MIN = TRIM(Request.QueryString("MIN"))
GEN = TRIM(Request.QueryString("GEN"))
CTO = TRIM(Request.QueryString("CTO"))
PK  = TRIM(Request.QueryString("PK"))
tbL	= trim(application("owner"))+".prendas"
FECHA ="{ fn NOW() }"
url = Request.QueryString("url")
tt = len(trim(application("owner")))
tt = tt+1
tabla = right(tbl,(len(tbl)- tt))

'	busca si encuentra un código duplicado
	CAD =   " SELECT "&PK&" FROM "&tbl&" " & _
			" WHERE  "&PK&" = '"&COD&"' "
	
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "0" then
		CAD =	" UPDATE  "&tbl&" set       " & _
				" DESCRIPCION = '"&DES&"',  " & _ 
				" CLIENTE = '"&CLI&"' ,     " & _
				" UNIDAD = '"&UNI&"',       " & _
				" MONEDA = '"&MON&"' ,      " & _
				" GENERO = '"&GEN&"' ,      " & _
				" TIPPRENDA = '"&TIP&"' ,   " & _
				" PROTO = '"&PRO&"' ,       " & _
				" VERSION = '"&VER&"' ,     " & _
				" MINUTAJE = '"&MIN&"' ,    " & _
				" TALLA = '"&TAL&"' ,       " & _
				" GRUPO = '"&GRU&"' ,       " & _
				" FOB = '"&CTO&"' ,         " & _
				" ESTADO = 'A',             " & _
				" USUARIO = '"&USUARIO&"',  " & _
				" FECHA = "&fecha&"         " & _
				" WHERE                     " & _
				" "&PK&" = '"&COD&"' ;      "
	else
		CAD =	" UPDATE "&tbl&"                " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE                         " & _
				" "&PK&" = '"&COD&"' ;            "	
	end if		
		
else	
ss=     " select top 1 right(ltrim(rtrim(codigo)),6)" & _
        " from "&tbl&" where                        " & _
        " left("&pk&",1) = ltrim(rtrim              " & _
        " ('"&cod&"')) order by "&pk&"   desc       "
rs.close
response.Write(ss)
rs.open ss,cnn
if rs.recordcount > 0 then
    xx = cdbl(rs.fields.item(0))+1
    xx = trim(cstr(xx))
else
    xx = "000000"
end if        
cod = trim(cod) + right("000000"+xx,6)

	CAD =	" insert into "&tbl&" (CODIGO, MINUTAJE," & _
				" DESCRIPCION, UNIDAD, MONEDA,      " & _
				" CLIENTE, TIPPRENDA, PROTO,        " & _
				" VERSION, GENERO, GRUPO, TALLA,    " & _
				" FOB, ESTADO, usuario, fecha )     " & _
				" values('"&COD&"', '" & min & "',  " & _
				" '" & des & "','" & uni & "',      " & _
				" '" & mon & "','" & cli & "',      " & _
				" '" & tip & "','" & pro & "',      " & _
				" '" & ver & "','" & gen & "',      " & _
				" '" & gru & "','" & tal & "',      " & _
				" '" & cto & "', 'A', '"&USUARIO&"'," & _
				" "&fecha&" )                       " 
End if
Response.Write (CAD)
'Response.end
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
'regresa a la página de donde fué llamado, para que vea que agregó el registro
cod = cstr(cod)

%>
<script language="javascript" type="text/jscript">

cad = ('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'+'&tbl='+'<%=trim(tabla)%>'
//alert(cad)
top.window.location.replace(cad)
</script>
</BODY>
</HTML>
