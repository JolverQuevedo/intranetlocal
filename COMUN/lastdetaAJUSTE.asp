<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
    CAD =	" SELECT top 1 AJU, VER		" & _
		    " from VIEW_AJUSTES      	" & _
	        " where cli = '"&dato&"'    " & _
            " order by AJU+ver desc		"
		Response.Write(cad)
		RS.Open  CAD, CNN
	IF rs.recordcount <= 0 THEN %>
    
    <script language="javascript" type="text/jscript">
        cad = '../detaAJUSTE.asp?pos=' + '<%=dato %>'
        cad += '&AJU=0000000001' 
        cad += '&ver=001' 
       //alert(cad)
        window.parent.location.replace(cad)
	</script>
    <%else 
        AJU = rs.fields.item(0)	
	    ver = rs.fields.item(1)	
%>
	<script language="javascript" type="text/jscript">
			cad =  '../detaAJUSTE.asp?pos='  + '<%=dato%>'
			cad += '&AJU=' + '<%=AJU%>'
            cad += '&ver=' + '<%=ver%>'
		//	alert(cad)
			window.parent.location.replace(cad)
	</script>
<%end if %>
</body>
</html>
