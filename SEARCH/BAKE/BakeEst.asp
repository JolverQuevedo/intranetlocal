<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<% Session.LCID = 2058 'Mexico (comas y punto) %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%
fecha = "{ fn NOW() }"

est = trim(request.QueryString("est"))
cli = trim(request.QueryString("cli"))
Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = Cnn

	strSql = " select * from estilos where estilo = '" & est & " ' "
	rs.Open strSql,cnn,3,1
	if rs.recordcount > 0 then
		rs.Close
		cad = " select ss.estilo, ee.nombre	" & _
			  " from estilos ss				" & _
			  " left outer join empresas ee " & _
			  " on ee.cliente = ss.cliente	" & _
			  " where   estilo ='"&est&"'		"
			  'Response.WRITE(CAD)
			  RS.Open CAD,CNN
		if rs.RecordCount > 0 then%>
			<SCRIPT>
				alert("Código de Estilo ya existe para cliente\n"+'<%=trim(rs("nombre"))%>')
				top.window.frames(1).window.thisForm.COD.value=''
				top.window.frames(1).window.thisForm.COD.focus()
			</SCRIPT>
		<%end if	
	else	
		response.end()		
	end if 
	rs.Close	
	
%>
