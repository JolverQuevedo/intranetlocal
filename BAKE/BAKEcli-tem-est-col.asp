<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
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
    xx = 0
    //alert(top.window.thisForm.COL.options.length)
    // se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....


    if (parent.window.thisForm.COL) {
        var select = parent.window.thisForm.COL
    } else {
        var select = window.parent.document.all.COL
    }


    // borra los elementos PRE - existentes
    select.options.length = 0;
    // ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
    select.options[0] = new Option('', '');
    // POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
    // Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%cli	= Request.QueryString("cli")
  tem	= Request.QueryString("tem")
  est	= Request.QueryString("est")
     CAD =	" SELECT COLOR                                                               " & _
            " FROM View_Cliente_Temporada_Estilo_PO_color                                " & _
            " WHERE CLIENTE = '"&cli&"'    AND codtem = '"&tem&"' AND estilo = '"&est&"' " & _
            " GROUP BY color                                                             " & _
            " ORDER BY color;                                                            "
		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
		RESPONSE.Write("<br>")
		RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <%if len(trim(rs("COLOR"))) > 0 then %>
                    <script type="text/jscript" language="jscript">
                        aData[xx]  = '<%=trim(rs("COLOR"))%>';
                        aVal[xx++] = '<%=trim(rs("COLOR"))%>';
                    </script>
				<%end if %>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
                for (i = 1; i <= xx; i++) {
                    select.options[i] = new Option(aVal[i - 1], aData[i - 1]);
                }
             </script>	
		<%end if%>    
</body>

</html>