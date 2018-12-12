<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<%Response.Buffer = TRUE %>
<%Session.LCID = 2057%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%MSS = "select realsoft from usuarios where usuario = '"&usuario&"'"
RS.OPEN MSS, CNN
'RESPONSE.WRITE(MSS)
USUARIO = TRIM(RS("REALSOFT"))
RS.CLOSE
IF TRIM(USUARIO) = "" THEN%>
<script language="jscript" type="text/jscript">
    parent.window.alert("Usuario no registrado para GRABAR en el Real")
</script>

<%RESPONSE.End
END IF

OC =    TRIM(REQUEST.QUERYSTRING("OC"))
' Bloqueo la OC para que otro no meta la manotas
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CSITORD='5' Where OC_CNUMORD='"&OC&"' ; "
cnn.execute "Update RSFACCAR..CO0001MOVD Set OC_CESTADO='5' Where OC_CNUMORD='"&oc&"' "
' response.write("<br>")
' RESPONSE.WRITE(CAD)
' RESPONSE.END

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
   

    kaa = '../detaAtencion.asp'
    //  alert(kaa)
    top.window.location.href = top.window.location.href;
</script>
</BODY>
</HTML>

