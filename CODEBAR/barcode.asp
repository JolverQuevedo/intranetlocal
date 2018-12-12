<html>
<body>

123
<%'response.end%>
<%codigo = 12234%>

<% cad = "https://www.barcodesinc.com/generator/image.php?code=" & codigo & "&style=197&type=C128B&width=200&height=120&xres=1&font=3" %>

<img src='<%=cad%>'   />
</body>

</html>