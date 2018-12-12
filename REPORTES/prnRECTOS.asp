<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<%
POS	=	Request.QueryString("COD") 
 
CAD =	" SELECT RECTILINEO,DESCRI, CODCLI, DESCLI, pa, " & _
        " TEL, DES, FACT, UNID, TALLA, AGUJAS, unid,    " & _
        " CABOS, PASADAS, ANCHO AS LaRGO, ALTO, LM1     " & _
        " FROM VIEW_RECTILINEOS_HEAD AS H1              " & _
        " INNER JOIN RECTIL_CLI_TALLA AS C1             " & _
        " ON H1.RECTILINEO = C1.CODIGO                  " & _
        " WHERE C1.CODIGO = '"&POS&"'                   " & _
        " ORDER BY ORDEN                                " 
		RS.OPEN CAD ,Cnn
		'response.write(cad)
If rs.eof or rs.bof then
	Response.Write("Tabla  Vacía")		
	Response.End
end if	
	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
rs.movefirst
%>
<script type="text/jscript" language="jscript">

    function PLGaMT(plg) {
        blanco = 0
        plg= ltrim(plg)
        blanco = plg.indexOf(' ')
        dato = 0
        bit=''
        if (plg.indexOf(' ') > 0) {
            dit = Right(plg, plg.length - blanco)
            if (trim(dit) != '')
                bit = eval(dit)
            dato = parseInt(Left(plg, blanco), 10) + bit
        }
        else {
            dato = parseInt(plg, 10)
            
        }
        devu = toDeci((parseFloat(dato) * 0.0254),4)
        return devu
    }
    function peso(lar, alt, uni,pa,fac) {
        if (trim(uni) == "PUL") {
            lar = PLGaMT(lar)
            alt = PLGaMT(alt)
        }
        area = toDeci(lar * alt, 5)
        gramos = (parseFloat(area) * parseFloat(pa)) / 1000
        gramos = gramos * parseInt(fac,10)
    return toDeci(gramos,5)+' Kgs.'
}

function show(pos) {
   op = document.all.ruta.value
    document.all.muestra.src='../help/hlpdetarutatela.asp?pos='+pos+'&rut='+op
}
function calcHeight() {
    //find the height of the internal page
    var the_height =
    document.getElementById('muestra').contentWindow.
    document.body.scrollHeight + 25;

    //change the height of the iframe
    document.getElementById('muestra').height =
      the_height;
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../estilos1.CSS" />

</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0">


<table width="100%" align="center" border="0" cellpadding="0" cellspacing="3" bgcolor="<%=application("color2")%>" >
<tr >
	<td width="3%" align="right"  rowspan="3" valign="top" height="180"><img src="../imagenes/modelador-head2.jpg"></td>
    <td  width="20%"  rowspan="3" class="american22" align="right"><font size="1" color="gray"><%=DATE() %></font><br /><br />EL MODELADOR S.A.<br /><br /><br />
    <span class="TEXTOminibb">Calle Capitan Salvador Carmona 280
    <br />Lot. Ind. S.R. La Molina - Ate <br />
          e-Mail: sales@elmodelador.com.pe<br />
          Phone: (511)348-8180/348-6936<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;348-9467/348-1380<br />
          Fax: (511)348-6182</span></td>	 
	<td width="80%" align="center"  class="TALASBLUE" valign="bottom">FICHA TECNICA DE RECTILINEO : 
		<%=POS%></td>		
	<td width="5%" rowspan="3"><img id="ppp" style="cursor:hand;" onClick="this.style.display='none';window.print();" src="../imagenes/PRINT.gif" alt="" /></td>
</tr>
<tr><td class="TITULITOcentergreen" valign="bottom"><font color="#626262">Cliente: <%=TRIM(UCASE(RS("DESCLI")))%> --> Artículo: <%=rs("tel") %> </font><br /></td>
</tr>
<tr><td class="TITULITOcentergreen" valign="top"><font color="#626262"> <%=trim(ucase(rs("des"))) %></font></td>
</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="1" bordercolor="<%=application("color2")%>" bordercolorlight="<%=application("borde")%>">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<tr bgcolor="<%=application("titulo") %>">
	
		<td class="AMERICANwhite" align="center">CODIGO</td>
        <td class="AMERICANwhite" align="center">DESCRIPCION</td>
        <td class="AMERICANwhite" align="center">TALLA</td>
        <td class="AMERICANwhite" align="center"># AGUJAS</td>
        <td class="AMERICANwhite" align="center"># CABOS</td>
        <td class="AMERICANwhite" align="center">#PASADAS</td>
        <td class="AMERICANwhite" align="center">L.M.</td>
        <td class="AMERICANwhite" align="center">LARGO</td>
        <td class="AMERICANwhite" align="center">ALTO</td>
         <td class="AMERICANwhite" align="center">FACT.</td>
		<td class="AMERICANwhite" align="center">PESO</td>
</tr>
<%tel = rs("tel") %>
<tr>
	<td rowspan="<%=rs.recordcount%>" class="DATOSnormal" align="center" ><%=rs("rectilineo") %></td>
    <td rowspan="<%=rs.recordcount%>" class="DATOSnormal" align="center" ><%=rs("descri") %></td>
    <%c=0 %>
    <%do while not rs.eof%>
         <td align="center" class="DATOSnormal"><%=trim(RS("talla"))%></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("agujas"))%></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("cabos"))%></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("pasadas"))%></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("lm1"))%></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("largo"))%><%if rs("unid")="PUL" then%>"<%else%> cms <%end if %></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("alto"))%><%if rs("unid")="PUL" then%>"<%else%> cms <%end if %></td>
         <td align="center" class="DATOSnormal"><%=trim(RS("fact"))%></td>
         <td align="center" class="DATOSnormal"><input id="pp<%=c%>"  class="DESCRIPTORnegro" readonly tabindex="-1"/> </td>
         <script type="text/jscript" language="jscript">
           eval("document.all.pp"+parseInt('<%=c%>',10)+".value = peso('<%=RS("largo")%>', '<%=RS("alto")%>', '<%=rs("unid")%>','<%=rs("pa")%>','<%=rs("fact")%>')")
        </script>
    </tr>
    <tr>
    <%c=c+1 %>
    <%RS.MOVENEXT%>
<%loop%>
</tr>
</table>
<%cad = "select codmaq, desmaq,desmar, gg, observacion, comentario, pa  " & _
        " from view_telas as v1 inner join [tela-obs] as t1             " & _
        " on t1.tela = v1.tela where v1.tela = '"&tel&"'                "      
        rs.close
        rs.open cad,cnn
        if rs.recordcount <=0 then response.End
        rs.movefirst
%>


<table width="100%"  cellspacing="0" border="1">
<tr class="TEXTO">
    <td width="20%">GG <%=trim(rs("gg")) %></td>
    <td rowspan="4" width="40%">
        <table border="0" width="100%" ><tr><td><textarea  class="estilotextarea3"><%=TRIM(UCASE(RS("OBSERVACION"))) %></textarea></td></tr></table>
    </td>
    <td rowspan="4" width="40%" valign="top">
        <table border="0" width="100%" ><tr><td><textarea  class="estilotextarea3"><%=TRIM(UCASE(RS("comentario"))) %></textarea></td></tr></table>
    </td>
</tr>
<tr class="TEXTO">
    <td> Maq. <%=trim(ucase(rs("desmaq"))) %></td>
</tr>
<tr class="TEXTO">
    <td>Dens. Acabado : <%=trim(rs("pa")) %> gr/mt2 </td>
</tr>
</table>
<%rs.close
cad= " SELECT  VERSION,	 DESCRIPTOR     " & _
		" FROM     TELARUTAHEAD			" & _
		" WHERE ESTADO = 'A' and		" & _
		" TELA = '"&TEL&"'				" & _
        " ORDER BY VERSION  		    "  
        
rs.open cad,cnn
if rs.recordcount <= 0 then        %>
  No hay rutas definidas para esta tela
  <%Response.End
end if %>

<span class="barras">RUTA: 
<select class="DATOSnormal" id="ruta" onclick="show('<%=tel%>')" >
<option></option>
<%rs.movefirst
do while not rs.eof %>
<option value="<%=rs("version")%>"><%=rs("DESCRIPTOR") %></option>
<%rs.movenext %>
<%loop %>
</select>
 </span>

<iframe frameborder="1" width="100%" id="muestra" onload="calcHeight()"></iframe> 

<%rs.close
set rs = nothing
set cmd = nothing %>
</body>
</html>
