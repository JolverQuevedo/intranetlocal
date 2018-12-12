<%@ Language=VBScript%>
<%Session.LCID=2057%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	
pos = Request.QueryString("pos")
cod = Request.QueryString("cod")
ofi = Request.QueryString("ofi")
alm = Request.QueryString("alm")

UFO = "('" + replace(ofi,",", "','")+ "')"
'response.write(ufo)
CAD =	" Select * From ORDENCOMPRA WHERE OFI IN "&ufo&" AND CODDES = '"&COD&"' " & _
        " AND ALMDES ='"&ALM&"' "
        RESPONSE.WRITE(CAD)
		RS.OPEN CAD, CNN

		if RS.RECORDCOUNT > 0 then%>
			<script type="text/jscript" language="jscript">
			    obj = '<%=pos%>'
			    eval("window.parent.document.all.co" + obj + ".style.backgroundColor = 'red'")
			    eval("window.parent.document.all.co" + obj + ".style.display = 'none'")
			    vari = 'co' + obj.toString()
               // alert(vari)
                window.parent.document.getElementById(vari).checked = 'false'
                //alert(window.parent.document.getElementById(vari).checked)

			    
              // alert('<%=cad %>')
            </script>
		<%else%>
            <script type="text/jscript" language="jscript">
                obj = '<%=pos%>'
               eval("window.parent.document.all.co"+obj+".style.backgroundColor = 'green'")
               //alert('<%=cad%>')
			</script>	
        <%end if%>
		
</BODY>
</HTML>
