<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../includes/rutinas.asp"-->
<%'***************************************************
'PROCESO        : INSERCION DE NUEVOS CLIENTE
'CREACION       : MABEL MOLINA
'FECHA CREACION : 
'FECHA MODIFIC  : 13/09/2007
'OBS: SE MODIFICO POR ERROR AL MOMENTO DE GRABAR.
'***************************************************%>
<%Response.Buffer = TRUE %>
<%
FAD = ""
CHK = prepara_str_sql(Request.querystring("chk"))
COD = prepara_str_sql(Request.querystring("pos"))
NOM = prepara_str_sql(Request.querystring("des"))
CLI = prepara_str_sql(Request.querystring("CLI"))
tip = prepara_str_sql(Request.querystring("TIP"))
ZON = prepara_str_sql(Request.querystring("ZON"))
PAI = prepara_str_sql(Request.querystring("PAI"))
RUC = prepara_str_sql(Request.querystring("RUC"))
CIU = prepara_str_sql(Request.querystring("CIU"))
TEL = prepara_str_sql(Request.querystring("TEL"))
FAX = prepara_str_sql(Request.querystring("FAX"))
DIR = prepara_str_sql(Request.querystring("DIR"))
url = prepara_str_sql(Request.querystring("url"))
if trim(ruc)="" then ruc="00000000000" 
IF LEN(CLI) < 12 THEN
	CLI = ""
END IF 
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT CLIENTE FROM EMPRESAS  " & _
			" WHERE  CLIENTE = '"&COD&"'    " & _
			" ORDER BY CLIENTE DESC         "
			response.Write(cad)
	RS.Open CAD, CNN
IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "0" then
		CAD =	" UPDATE  EMPRESAS set      " & _
				" NOMBRE = '"&NOM&"',       " & _ 
				" DIRECCION = '"&DIR&"',    " & _
				" CIUDAD = '"&CIU&"' ,      " & _
				" PAIS = '"&PAI&"' ,        " & _
				" ruc = '"&ruc&"' ,         " & _
				" TIPO = '"&TIP&"' ,        " & _
				" FAX = '"&FAX&"' ,         " & _
				" TELEFONO = '"&TEL&"' ,    " & _
				" ESTADO = 'A',             " & _
				" USUARIO = '"&USUARIO&"',  " & _
				" FECHA = "&FECHA&" ,       " & _
				" ZONA= '"&ZON&"'           " & _ 
				" WHERE CLIENTE = '"&COD&"';"
	else
		CAD =	" UPDATE EMPRESAS               " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE CLIENTE = '"&COD&"' ;   "	
	end if		
else	
	RS.CLOSE
	CAD =   " SELECT TOP 1 CLIENTE FROM EMPRESAS                " & _
			" where TIPO = '"&TIP&"'  AND CLIENTE <= '999999'   "  & _
			" ORDER BY CLIENTE DESC                             "
	RS.Open CAD, CNN
	IF RS.RecordCount > 0  THEN	
		RS.MOVEFIRST
		COD = CDBL(RS("CLIENTE")) + 1
		IF TIP = "E" THEN
			COD = RIGHT("000000" + LTRIM(RTRIM(COD)),6)
		END IF 
	ELSE 
		if tip = "E" then	
			cod = "000000"	
		ELSEIF TIP = "L" THEN	
			COD = "100000"
		ELSE
			COD = "900000"	
		END IF 
	end if 	
	CAD =	" insert into EMPRESAS  " & _
			" (CLIENTE, NOMBRE, DIRECCION, CIUDAD, RUC, " & _
			" ZONA, PAIS, TIPO,  FAX, TELEFONO, " & _
			" ESTADO, usuario, fecha)" & _
			" values('"&COD&"', '" & NOM & "', " & _
			" '" & DIR & "', '" & CIU & "', '"&ruc&"', " & _
			" '" & ZON & "', '" & PAI & "', " & _
			" '" & TIP & "', '" & FAX & "', " & _
			" '" & TEL & "',  " & _
			" 'A', '"&USUARIO&"', "&fecha&")  " 

End if
cnn.BeginTrans
Response.Write(cad)
'Response.end
	cnn.Execute(CAD)
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
	Else
		cnn.RollbackTrans
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) 
	End if
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing
'regresa a la página de donde fué llamado, para que vea que agregó el registro
cod = cstr(cod)
eee= "../clientes.asp?POS="+COD+ "&PERFIL=1"  %>
<script>
top.window.location.replace('<%=trim(eee)%>')
</script>