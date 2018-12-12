<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<%  pos = request.QueryString("pos")
    est = request.QueryString("est")
    hlp = Request.QueryString("HLP")
CAD =	" SELECT top 15 codest		    " & _
		" from estilos			        " & _
		" where cliente  = '"&pos&"'    " & _
        " and codest <= '"&est&"'       " & _
		" order by codest 	DESC        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN 
	    est = ""
	else 
	    RS.MOVELAST
	    est= rs.fields.item(0)	
	END IF    
	
%>
	<script>
	    cad = '../detaestilo.asp?pos=' + '<%=pos %>' + '&est=' + '<%=est%>' + '&hlp=' + '<%=Request.QueryString("HLP") %>'
	   // alert(cad)
	    window.parent.location.replace(cad)
	</script>
</BODY>
</HTML>
