<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNQRY.ASP"-->
<script type="text/jscript" language="jscript">
    var aCod = Array()
    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('deta').contentWindow.
      document.body.scrollHeight +250;
        //change the height of the iframe
        document.getElementById('deta').height =
      the_height;
    }

    var oldrow = 1
</script>
<%alm = Request.QueryString("alm")
num = Request.QueryString("num")  
TIP = Request.QueryString("TIP")  
%>
<body style="margin-top:0; onload="document.getElementById('OC').focus();">

<form id="thisForm" method="post" name="thisForm" action="">


    <table width="100%" cellpadding="4" cellspacing="1" border="0" id="TABLA" >
        <tr class="DESCRIPTORnegro" >
            <td  align="center">ALM</td>
            <td  align="center">TD</td>
            <td  align="center">NUM DOC</td>
            <td  align="center" colspan="2">MOV</td>
            <td  align="center">FECHA</td>
            <td  align="center"  colspan="2">PROVEEDOR/CLIENTE</td>
            <td  align="center" colspan = "2">DOC REF</td>
            <td  align="center">O/C</td>
            <td  align="center">GLOSA</td>          
        </tr>
        <tr><td colspan="12"><hr /></td></tr>
        <%
        CAD =   " select A1_CDESCRI AS DESALM,TM_CDESCRI AS DESMOV, *        " & _
                " From RSFACCAR..AL0001MOVC                                 " & _
                " inner join RSFACCAR..AL0001ALMA on A1_CALMA = c5_calma    " & _
                " inner join RSFACCAR..AL0001TABM on TM_CTIPMOV=c5_ctipmov  " & _
                " AND TM_CCODMOV=c5_ccodmov                                 " & _
                " Where C5_CALMA='"&alm&"' AND C5_CTD='"&tip&"'             "
               if len(trim(num)) > 0 then cad = cad + " AND C5_CNUMDOC='"&NUM&"'; "

              '   response.write(cad)

        RS.OPEN CAD, CNN
        IF RS.RECORDCOUNT >0 THEN RS.MOVEFIRST
        CONT = 1%>
        <%do while not rs.eof %>
            <tr  valign="middle" ondblclick="EDITA('<%=cont%>')" align="center"  onclick="dd('<%=(cont)%>')"  class="cambio"
            <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			 id="fila<%=Trim(Cstr(cont))%>" >
                <td align="left"><%=RS("C5_calma") %></td>        
	            <td align="left"><%=RS("C5_CTD") %></td>
                <td align="left"><%=UCASE(trim(RS("C5_CNUMDOC")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CCODMOV")))%></td>
                <td align="left"><%=UCASE(trim(RS("DESMOV")))%></td>
                <td align="left"><%=FORMATdatetime(RS("C5_DFECdoc"),2)%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CCODPRO")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CNOMPRO")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CRFTDOC")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CRFNDOC")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_Cnumord")))%></td>
                <td align="left"><%=UCASE(trim(RS("C5_CGLOSA1")))%></td>
            </tr>
               <%CONT = CONT + 1 %>
               <%RS.MOVENEXT%>
               <%IF RS.EOF THEN EXIT DO %>
            <%loop%>
    </table>
</form>  
<script language="jscript" type="text/jscript">
if (parseInt('<%=rs.recordcount%>',10) > 0)
    dd('1')

function EDITA(ff) {
// el +1 es por la puta RAYAA  que me consume un digito del contador!
    var pos = parseInt(ff, 10)+1
    var t = document.all.TABLA;
    //alert(ltrim(t.rows(pos).cells(1).innerText))
    alm = ltrim(t.rows(pos).cells(0).innerText );
    tip = ltrim(t.rows(pos).cells(1).innerText );
    num = ltrim(t.rows(pos).cells(2).innerText );
    cad = 'reportes/prnpe.asp?alm='  + alm
    cad += '&tip=' + tip
    cad += '&num=' + num
    window.open (cad)
        return true
  
}

</script>
</body>
</html>
