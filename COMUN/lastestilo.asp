<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	pos	= Request.QueryString("pos")
    est = Request.QueryString("est")

    CAD =	" SELECT top 15 cliente, codest      " & _
		    " from estilos     	        " & _
	        " where cliente = '"&pos&"' " & _
            " order by codest 	desc	"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN %>
    
    <script language="javascript" type="text/jscript">
        cad = '../detaestilo.asp?pos=' + '<%=pos %>'+ '&est='+'<%=est%>'
       //alert(cad)
       window.parent.location.replace(cad)
	</script>
    <%else 
        rs.movefirst
        pos = rs.fields.item(0)	
	    est = rs.fields.item(1)	
%>
	<script language="javascript" type="text/jscript">
	    cad = '../detaestilo.asp?pos=' + '<%=pos %>' + '&est=' + '<%=est%>' + '&hlp=' + '<%=Request.QueryString("HLP") %>'
			//alert(cad)
			window.parent.location.replace(cad)
	</script>
<%end if %>
</body>
</html>
