<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
	
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CLI = Request.QueryString("CLI")
tem = Request.QueryString("tem")
est = Request.QueryString("est")
oss = Request.QueryString("oss")
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
CAD =	" select * from View_Cliente_Temporada_Estilo_PO    " & _
        " WHERE CLIENTE = '"&cli&"'                         " & _
        " and codtem = '"&tem&"' and estilo = '"&est&"'     " & _
        " ORDER BY PO                                       "

		Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
	IF  RS.RECORDCOUNT = 0 THEN  response.end 
    rs.movefirst
%>	
<form name="thisForm" METHOD="post"><HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin=0 leftmargin=20 rightmargin=20 border=0 text="#000000">

<%ln= 1%>	
<%do while not rs.eof%>
<%
'===========================================================
'  FALTA RELLENAR LAS CELDAS CUANDO ES UNA EDICION
'===========================================================
po = rs("po")
mass = "select * from servidet"
rs2.open mass,cnn
rs2.close
%>
<script>
    PO = '<%=rs("po") %>'
    ln = parseInt('<%=ln%>', 10)
    eval("parent.window.document.all.lin" + ln + ".style.display='block'")
    eval("parent.window.document.all.lin" + ln + ".innerText=PO")
    eval("parent.window.document.all.ccc" + ln + ".style.display='block'")
    eval("parent.window.document.all.chk" + ln + ".checked=false")
 //   alert("jolver")
 //   eval("parent.window.document.all.co" + ln + ".style.display='block'")
</script>
<%ln = ln + 1 %>
<%rs.movenext %>
<%loop%>
</BODY>
<SCRIPT language="jscript" type="text/jscript">

    CAD = '../comun/deelOS.asp?OS=' + '<%=TRIM(oss)%>'
    // alert(CAD)
    window.location.replace(CAD)

</SCRIPT>
</HTML>
