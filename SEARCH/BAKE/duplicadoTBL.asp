<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

<%

response.Write("cad")


'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
DES = ucase(TRIM(Request.QueryString("dato")))
TBL = TRIM(Request.QueryString("TBL"))
DS  = TRIM(Request.QueryString("DeS"))


CAD = "SELECT * FROM "&tbl&" WHERE "&ds&"='"&DES&"'"




rs.open cad, cnn
IF rs.recordcount > 0 THEN
%><script language="jscript" type="text/jscript">
      alert("Ya existe un registro con este numero...")

       var si
        { si = confirm("¿ Confirma que desea sobreescribir esta PO ? "); }
        if (si == false)
        { top.window.nograba() }
        else { top.window.graba()}


   //  top.window.document.valida.value = false
</script>	
<%else%>
<script language="javascript" type="text/jscript">
    top.window.graba()


</script>

<%	POS = RS.FIELDS(0)

END IF	%>
	
<%Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
    //  top.window.document.all.DUPLI.value= "1"


</script>
</BODY>
</HTML>
