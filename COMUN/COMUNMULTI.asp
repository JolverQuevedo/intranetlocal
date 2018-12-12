<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.QueryString("Perfil")
%>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	if (parseInt(ff) > 0 )
	{	var pos = parseInt(ff)
		var celpa = 'fila' + ff;
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
		//alert(eval("document.all."+celpa+".style.backgroundColor"))
		if (eval("document.all."+celpa+".style.backgroundColor")=='#99cc99')
			{if ((pos%2) ==0) 
				eval("document.all."+celpa+".style.backgroundColor='#F8FEFB'");
		 	else
		 		eval("document.all."+celpa+".style.backgroundColor='#C5D6D9'");
		 	}	
		 else				
			eval("document.all."+celpa+".style.backgroundColor='#99cc99'");
	}
}
</SCRIPT>