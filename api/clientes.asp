<!--#include file="./includes/Cnn.inc"-->
<% session.LCID = 2057 %>
<% Response.CacheControl = "no-cache" %>
<%

cad = "select codigo,abreviatura,nombre,tipo,rsccliente,estado,feccrea,fecmod,usumod,usucrea,stat from modelador.dbo.cliente"



set rs = cnn.execute(cad)
Response.ContentType = "application/json"
Response.Write "{"&JSONData(rs, """data""")&"}"




%>