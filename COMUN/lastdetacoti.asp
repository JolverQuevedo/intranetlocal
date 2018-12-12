<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
pag = request.QueryString("pag")
    CAD =	" SELECT top "&pag&" PRO, VER		" & _
		    " from VIEW_cotizacion     	" & _
	        " where cli = '"&dato&"'    " & _
            " order by  pro+ver desc		"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount <= 0 THEN %>
    <script language="javascript" type="text/jscript">
        cad = '../detacoti.asp?pos=' + '<%=dato %>'
       //alert(cad)
        window.parent.location.replace(cad)
	</script>
    <%else 
        rs.movelast
        cot = rs.fields.item(0)	
	    %>
	<script language="javascript" type="text/jscript">
			cad =  '../detacoti.asp?pos='  + '<%=dato%>'
			cad += '&cot=' + '<%=cot%>'

			//alert(cad)
			window.parent.location.replace(cad)
	</script>
<%end if %>
</body>
</html>
