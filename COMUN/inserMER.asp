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
CHK			= TrIM(Request.QueryString("chk"))
SER			= TRIM(Request.QueryString("SER"))
TEL			= TRIM(Request.QueryString("TEL"))
AVI			= TRIM(Request.QueryString("AVI"))
HIL			= TRIM(Request.QueryString("HIL"))
TEN			= TRIM(Request.QueryString("TEN"))
TEJ			= TRIM(Request.QueryString("TEJ"))
COR			= TRIM(Request.QueryString("COR"))
COT			= TRIM(Request.QueryString("COS"))
ACA			= TRIM(Request.QueryString("ACA"))
EMB			= TRIM(Request.QueryString("EMB"))
Sss			= TRIM(Request.QueryString("SIN"))

FECHA		= "{ fn NOW() }"
		CAD =	" UPDATE  "&OWNER&".MERMAS set " & _
				" SERVICIOS	= '"&SER&"',  " & _
				" TELAS		= '"&TEL&"',  " & _  
				" AVIOS		= '"&AVI&"',  " & _  
				" HILO		= '"&HIL&"',  " & _  
				" TEJIDO	= '"&TEJ&"',  " & _  
				" TENIDO	= '"&TEN&"',  " & _ 
				" CORTE		= '"&COR&"',  " & _  	
				" COSTURA	= '"&COT&"',  " & _  	
				" ACABADO	= '"&ACA&"',  " & _  	
				" EMBALAJE	= '"&EMB&"',  " & _  	
				" ENCONADO  = '"&Sss&"',  " & _  	
				" ESTADO	= 'A',  " & _
				" USUARIO	= '"&USUARIO&"', " & _
				" FECHA		= "&fecha&"  "
				
'RESPONsE.WRITE(CAD)
'RESPONSE.END
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

<SCRIPT>
window.location.replace('../mermas.asp');
</SCRIPT>
</BODY>
</HTML>
