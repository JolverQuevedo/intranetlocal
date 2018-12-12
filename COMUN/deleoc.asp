
<%@ Language=VBScript %>
<%  Response.Buffer = True
    txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="../includes/cnn.inc"-->
<html>
<head>
  <title></title>
</head>
<body>
 <table  border="1" align="center">
  
  <% oc= request.QueryString("oc")
  fecha= request.QueryString("fecha")
' actualiza la cabecera de la Orden de compra y la pone ANULADA
cad  = " Update RSFACCAR..CO0001MOVC Set OC_CSITORD='7' Where OC_CNUMORD='"&oc&"' ; "

cad = cad + "Delete From RSFACCAR..CO0001MOVD Where OC_CNUMORD='"&oc&"' ; "

' busca si tiene requerimiento
rs.open "SELECT * FROM RSFACCAR..AL0001REQF WHERE RF_CNUMORD='"&oc&"' ORDER BY RF_CNUMREQ,RF_CITEREQ ", cnn
if rs.recordcount > 0 then
'    -- actualiza el estado del requerimiento a anulado
    cad = cad + "UPDATE RSFACCAR..AL0001REQF SET RF_CESTADO='A'  WHERE RF_CNUMORD='"&oc&"' ; "
'   -- busca el numero de orden en la tabla de cabecera de requerimiento
    RS.CLOSE
    RS.OPEN "Select RC_CNROREQ From RSFACCAR..AL0001REQC Where RC_CNUMORD='"&OC&"' "
    IF RS.RECORDCOUNT > 0 THEN
    '   -- pone en blanco la oc de compra de referencia igual al # de req de la tabla anterior
        REQ = RS("RC_CNROREQ")
        CAD = CAD + " UPDATE RSFACCAR..AL0001REQC  SET RC_CNUMORD='' WHERE RC_CNROREQ='"&REQ&"' "
    END IF
END IF

' Inicia transacción , para que los datos no queden a medias
'response.write(cad)
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
    cad = '../detaoc.asp?fecha=' + '<%=right(fecha,7)%>'
    window.location.replace(cad)
</script>

  
  
  
  
  
  

</body>
</html>
