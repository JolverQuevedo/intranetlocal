<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
    CAD =	" SELECT top 1 PRO, VER		" & _
		    " from VIEW_PROTOS      	" & _
	        " where cli = '"&dato&"'    " & _
            " order by pro+ver desc		"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN %>
    
    <script language="javascript" type="text/jscript">
        cad = '../detaproto.asp?pos=' + '<%=dato %>'
       //alert(cad)
        window.parent.location.replace(cad)
	</script>
    <%else 
        pro = rs.fields.item(0)	
	    ver = rs.fields.item(1)	
%>
	<script language="javascript" type="text/jscript">
			cad =  '../detaproto.asp?pos='  + '<%=dato%>'
			cad += '&pro=' + '<%=pro%>'
            cad += '&ver=' + '<%=ver%>'
			//alert(cad)
			window.parent.location.replace(cad)
	</script>
<%end if %>
</body>
</html>
