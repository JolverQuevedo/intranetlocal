<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************

PRO = LEFT(Request.QueryString("PRO"),10)
vvv = RIGHT(Request.QueryString("PRO"),3)
cli = Request.QueryString("cli")

if len(trim(pro)) = 0 then response.end
'RESPONSE.Write(VVV)
CAD =	" SELECT distinct  PP.PROTO, PP.VERSION AS VER,	        		    " & _
	    " EM.NOMBRE AS CLIENTE,	PP.ESTILO, PP.COTIZACION,			        " & _ 
	    " CC.TIPEMB, EE.ESTCLI, EE.DESCRIPCION, EE.GENERO,                  " & _
        " GG.DESCRIPCION AS DGEN ,ee.codest, cc.FOB                         " & _
		" FROM PROTOS PP											        " & _
        " INNER JOIN ESTILOS AS EE ON PP.ESTILO = EE.CODEST AND PP.CLIENTE  " & _
        " = EE.CLIENTE                                                      " & _
		" INNER JOIN CLIENTE EM ON PP.CLIENTE = EM.CODIGO			        " & _
        " INNER JOIN COTIZACION AS CC ON CC.COTIZACION = PP.COTIZACION      " & _
        " INNER JOIN GENEROS AS GG ON GG.GENERO = EE.GENERO                 " & _
		" WHERE (PP.ESTADO = 'A') AND (PP.proto = '"&pro&"')		        " & _
        " and (PP.[VERSION] = '"&VVV&"')  and pp.cliente = '"&cli&"'        " & _
		" ORDER BY PP.PROTO , PP.VERSION                                    " 

		'Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
    if rs.recordcount > 0 then
        rs.movefirst
	%>
<Script type="text/jscript" language="jscript">
        top.window.thisForm.PRO.value = '<%=RS("PROTO")%>'+'-'+'<%=RS("VER") %>'
       top.window.thisForm.COTI.value = '<%=RS("COTIZACION") %>'
       top.window.thisForm.FOB.value = '<%=formatnumber(RS("FOB"),2,,true) %>'
        var subcadena = '<%=RS("TIPEMB") %>'
        var elemento =top.window.thisForm.TIP;
       top.window.thisForm.TIP.selectedIndex = seleindice(subcadena, elemento);
       top.window.document.all.IT1.innerHTML=1
       top.window.thisForm.CGEN.value = '<%=RS("GENERO")%>'
       top.window.thisForm.DGEN.value = '<%=rs("dgen") %>'
       tope = parseInt(top.window.thisForm.veri.value,10)
       for (u = 1; u < tope; u++ )
        eval("top.window.thisForm.FOB"+u+".value = '<%=formatnumber(rs("FOB"),2,,true) %>'")
       top.window.thisForm.CODEST.value = '<%=rs("codest") %>'
       top.window.thisForm.ESTCLI.value = '<%=rs("estcli") %>'
       top.window.thisForm.DESEST.value = '<%=rs("descripcion") %>'
        FOTON = '<%=RS("CODEST")%>'
        cad = '../BAKE/recuperaFOTOESTILO.asp?ID=' +FOTON + '&CLI=' + '<%=trim(Request.QueryString("CLI"))%>'

       top.window.thisForm.FOT.src = cad
       // alert(cad)
       
</Script>	
<%rs.close
cad = "SELECT TALLA, orden FROM [PROTO-TALLAS] WHERE PROTO = '"&PRO&"' AND VERSION = '"&vvv&"' ORDER BY ORDEN"
rs.open cad,cnn
rs.movefirst
t=0
do while not rs.eof%>
    <Script type="text/jscript" language="jscript">
        t = parseInt('<%=t%>',10)
        talla = '<%=rs("talla")%>'
        eval("top.window.thisForm.x"+t+".value=talla")
    </script>
    <% rs.movenext
        t= t + 1
    loop
else%>
<Script type="text/jscript" language="jscript">
    alert("Proto - Version - Cliente no Encontrado")
   top.window.thisForm.PRO.value = ''
   top.window.thisForm.PRO.focus();
</script>
<%end if%>
<HTML>
<HEAD>
<TITLE>help PROTOS</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

</BODY>
</HTML>
