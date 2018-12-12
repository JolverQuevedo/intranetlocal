<html>
<body>
<p>This web page uses ASP code to create a barcode.</p>
<% @ LANGUAGE = VBScript %>
<% BarcodeData = "123456789012" %>
<p><img src="<%="https://www.bcgen.com/aspscripts/idautomation-code128.asp?D=" & BarcodeData %>"
</p>
</body>
</html>