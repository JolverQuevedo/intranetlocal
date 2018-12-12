<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%Session.LCID=2057%>
<%	usr = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
oc  = Request.QueryString("oc")
pe  = right("00000000000"+trim(Request.QueryString("pe")),11)
alm = Request.QueryString("alm")
itm = Request.QueryString("itm")
qty = Request.QueryString("qty")
fec =  "{ fn NOW() }"
CAD =	" Select *                  " & _
        " From modelador..clavepe   " & _
        " Where numord='"&oc&"'     " & _
        " And alm='"&alm&"'         " & _
        " and pe = '"&pe&"'         " & _
        " and item = '"&itm&"'      " 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then
            rs.close
            mad = "exec modelador..sp_crea_pwd '30' "
            rs.open mad,cnn
            pwd = trim(rs.fields.item(0))
            ' se hace el insert en la tabla de Excesos.....
            Kad = " insert into clavePE select '"&oc&"', '"&alm&"', " & _
                  " '"&pe&"','"&itm&"',"&qty&", '"&pwd&"', '"&usr&"'," & _
                  " "&fec&", 'A' "

            response.write(cad)
            response.write("<br>")
            response.write(mad)
            response.write("<br>")
            response.write(kad)
            cnn.execute kad
            lap = "SEND_MAIL_PE '"&oc&"', '"&alm&"', '"&pe&"', '"&itm&"', "&qty&", '"&pwd&"' , '"&usr&"' "
            response.write(lap)
            cnn.execute lap


        %>
			<script type="text/jscript" language="jscript">
			    parent.window.document.all.PWD.value = '<%=pwd%>'
            //    parent.window.document.all.PWD.style.display='none'
               // alert("Clave Generada " + '<%=pwd%>')  
            </script>
		<%else%>
		<% Kad = " UPDATE clavePE SET QTY = "&qty&" " & _
                 " WHERE NUMORD =  '"&oc&"' AND ALM = '"&alm&"'  " & _
                 " AND PE=  '"&pe&"'AND ITEM ='"&itm&"' "
            CNN.EXECUTE(kad)
        %>
            <script type="text/jscript" language="jscript">
                alert("Clave previamente generada")

			</script>	
        <%end if%>
		
</BODY>
</HTML>
