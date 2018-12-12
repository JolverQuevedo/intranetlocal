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
alm = TRIM(Request.QueryString("alm"))
ctd = TRIM(Request.QueryString("ctd"))
NUM = TRIM(Request.QueryString("NUM"))
lin = TRIM(Request.QueryString("lin"))
Can = TRIM(Request.QueryString("can"))

'	busca si encuentra un código duplicado
	CAD =   " SELECT * FROM RSFACCAR_2009..AL0002MOVD           " & _
            " Where C6_CALMA='"&alm&"' AND C6_CTD='"&ctd&"'     " & _
            " AND C6_CITEM='"&lin&"' and C6_CNUMDOC='"&num&"';"
	
	RS.Open CAD, CNN
    RESPONSE.Write(CAD)
IF RS.RecordCount > 0 THEN	
	RS.Close
	CAD =	" update RSFACCAR_2009..AL0002MOVD                  " & _
            " set c6_ncantid = "&can&"                          " & _
            " Where C6_CALMA='"&alm&"' AND C6_CTD='"&ctd&"'     " & _
            " and C6_CNUMDOC='"&num&"' AND C6_CITEM='"&lin&"';"       
	
else	%>
    <script language="jscript" type="text/jscript">
        alert("Registro No encontrado")
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
    window.location.replace("../arregladeta.asp")
</script>
</BODY>
</HTML>
