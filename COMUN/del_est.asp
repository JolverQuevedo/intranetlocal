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
est = TRIM(Request.QueryString("est"))

'	busca si encuentra un código duplicado
	CAD =   " select *  FROM dbprod..COMSTYOP WHERE ST_CCODIGO ='"&est&"' "

	RS.Open CAD, CNN
    RESPONSE.Write(CAD)
IF RS.RecordCount > 0 THEN	
	RS.Close
		CAD =   " DELETE FROM dbprod..COMSTYOP WHERE ST_CCODIGO ='"&est&"' "
	
else	%>
    <script language="jscript" type="text/jscript">
        alert("Estilo No encontrado")
    </script>
<%
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

%>
<script language="jscript" type="text/jscript">
    window.location.replace("../borraESTILO.asp")
</script>
</BODY>
</HTML>
