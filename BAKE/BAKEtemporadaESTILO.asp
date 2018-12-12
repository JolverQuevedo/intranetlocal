<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title></title>
</head>
<body>

<script type="text/jscript" language="jscript">
var aData = new Array()
var aVal = new Array()
xx=0
//alert(top.window.thisForm.COL.options.length)
// se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....

if (parent.window.thisForm.EST) {
    var select = parent.window.thisForm.EST
} else {
    var select = window.parent.document.all.EST
}

// borra los elementos PRE - existentes
select.options.length = 0;
// ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
select.options[0] = new Option('','');
// POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
// Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%
cli	    = Request.QueryString("cli")
tem	    = Request.QueryString("tem")

     CAD =	" select distinct pp.estilo,    " & _
            " EE.CODEST, ESTCLI             " & _
            " from protos pp                " & _
            " inner join ESTILOS EE  on     " & _
            " pp.cliente =EE.cliente        " & _
            " AND EE.CODEST = PP.ESTILO     " & _
            " where temporada = '"&tem&"'   " & _
            " and PP.cliente = '"&cli&"'    " 

		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
	'	RESPONSE.Write("<br>")
	'	RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <%if len(trim(rs("estcli"))) > 0 then %>
                    <script type="text/jscript" language="jscript">
                        aData[xx]   = '<%=trim(rs("codest"))%>';
					    aVal[xx++]  = '<%=trim(rs("estcli"))%>';
                    </script>
				<%end if %>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
				 for(i=1; i <= xx; i++) 
				  	select.options[i] = new Option( aVal[i-1], aData[i-1]); 				  
             </script>	
		<%end if%>


</body>

<script>
op = trim('<%=request.querystring("opc") %>')
if (op == "1") {

    CAD = '../comun/deelOS.asp?OS=' + trim(window.parent.document.all.OS.value)
   // alert(CAD)
    window.location.replace(CAD)


}
</script>
</html>