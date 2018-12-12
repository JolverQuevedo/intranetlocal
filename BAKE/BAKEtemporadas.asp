<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">


</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
PROCESANDO...
<script type="text/jscript" language="jscript">
var aData = new Array()
var aVal = new Array()
xx=0

// se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....
var select = parent.window.thisForm.TEM
// borra los elementos PRE - existentes
select.options.length = 0;
// ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
select.options[0] = new Option('','');
// POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
// Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%	sele	= Request.QueryString("sele")
    cli     = Request.QueryString("pos")
    CAD =   " select t1.codigo, t1.descripcion FROM temporadas AS t1              " & _
            " INNER JOIN cliente AS C2 ON  t1.cliente = C2.COdigo          " & _
            " WHERE t1.cliente = '"&cli&"'  and t1.estado = 'A'  ORDER BY 2  " 
        
		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
		'RESPONSE.Write("<br>")
		'RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <script type="text/jscript" language="jscript">
					aData[xx]     = '<%=trim(rs("codigo"))%>';
					aVal[xx++] = '<%=trim(rs("descripcion"))%>';
                </script>
				<%=RS("codigo")%>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
				 for(i=1; i <= xx; i++) 
				  	select.options[i] = new Option( aVal[i-1], aData[i-1]); 				  
             </script>	
		<%end if%>


	FIN
</body>
</html>