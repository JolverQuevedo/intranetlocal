<%@ Language=VBScript %>
<%  Response.Buffer = True
    txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
    <%Session.LCID = 2057%>
<!--#include file="../includes/cnn.inc"-->
<html>
<head>
  <title></title>
</head>
<body>
 <table  border="1" align="center">
  
  <%DOC = request.QueryString("DOC")
    COD = request.QueryString("COD")
    LIN = request.QueryString("LIN")
    CAM = request.QueryString("CAM")
    PRE = request.QueryString("PRE")
    ALM = request.QueryString("ALM")

' actualiza la cabecera de la Orden de compra y la pone ANULADA
cad  =  " update  RSFACCAR..al0001movd set                                              " & _
        " C6_NPREUNI = "&PRE&", C6_NPREUN1 = "&PRE&", C6_NMNPRUN = "&PRE&" * "&CAM&",   " & _
        " C6_NUSPRUN = "&PRE&", C6_NVALTOT = c6_ncantid  * "&PRE&",                     " & _
        " C6_NUSIMPO= c6_ncantid * "&PRE&", c6_NMNIMPO = c6_ncantid * "&PRE&"* "&CAM&"  " & _
	    " from RSFACCAR..al0001movd                                                     " & _
	    " WHERE c6_cnumdoc = '"&DOC&"' AND c6_ccodigo = '"&COD&"'                       " & _
        " AND c6_citem = '"&LIN&"'  AND C6_CTD= 'PE'                                    " & _
        " AND C6_CALMA = '"&ALM&"'                                                      "

' Inicia transacción , para que los datos no queden a medias
response.write(cad)
'response.end
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
'Response.Write(CAD)
'Response.END


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	




%>
<script language="jscript" type="text/jscript">
    parent.window.parent.window.location.reload()
</script>

  
  
  
  
  
  

</body>
</html>
