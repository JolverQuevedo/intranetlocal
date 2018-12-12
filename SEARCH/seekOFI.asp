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

<%	cot 	= Request.QueryString("cot")
	CLI		= Request.QueryString("cli")
    pro 	= Request.QueryString("pro")
    est 	= Request.QueryString("est")
if len(ltrim(rtrim(cot))) > 0 then
    cot = right("0000000000" + ltrim(rtrim(cot)),10)
    CAD =	" SELECT pro                " & _
		    " from VIEW_cotizacion	    " & _
		    " where CLI = '"&CLI&"'     " & _
            " AND cotizacion = '"&cot&"'" & _
		    " order by  pro+ver DESC    "
elseif len(ltrim(rtrim(pro))) > 0 then
    pro = right("0000000000" + ltrim(rtrim(pro)),10)
    CAD =	" SELECT pro                " & _
		    " from VIEW_cotizacion	    " & _
		    " where CLI = '"&CLI&"'     " & _
            " AND pro = '"&pro&"'       " & _
		    " order by  pro+ver DESC    "
elseif len(ltrim(rtrim(est))) > 0 then
   
    CAD =	" SELECT pro                " & _
		    " from VIEW_cotizacion	    " & _
		    " where CLI = '"&CLI&"'     " & _
            " AND ecli = '"&est&"'      " & _
		    " order by  pro+ver DESC    "
end if
RS.Open  CAD
IF rs.recordcount > 0 THEN 
	RS.movefirst
	ss= rs.fields.item(0)	
else
    ss = ""
END IF    
response.Write(cad)	
%>
<script>
	cad = '../DETAcoti.ASP?POS=' + '<%=CLI%>' + '&cot=' + '<%=ss%>'
	//alert(cad)
	window.parent.location.replace(cad)
</script>
</BODY>
</HTML>
