<%
    cod = request.querystring("cod")
    cli = request.querystring("cli")
    cad= "update  modelador.dbo.colores set estado ='e' where codigo = '"&cod&"' and cliente ='"&cli&"'"
    response.write(cad)
%>
<script>
    alert("Actualizado");
</script>